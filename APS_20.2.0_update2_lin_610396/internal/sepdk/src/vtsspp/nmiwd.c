/*
  Copyright (C) 2010-2020 Intel Corporation.  All Rights Reserved.

  This file is part of SEP Development Kit

  SEP Development Kit is free software; you can redistribute it
  and/or modify it under the terms of the GNU General Public License
  version 2 as published by the Free Software Foundation.

  SEP Development Kit is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with SEP Development Kit; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

  As a special exception, you may use this file as part of a free software
  library without restriction.  Specifically, if other files instantiate
  templates or use macros or inline functions from this file, or you compile
  this file and link it with other files to produce an executable, this
  file does not by itself cause the resulting executable to be covered by
  the GNU General Public License.  This exception does not however
  invalidate any other reasons why the executable file might be covered by
*/
#include "config.h"
#include "debug.h"
#include "nmiwd.h"

#include <linux/cred.h>
#include <linux/watchdog.h>
#include <linux/file.h>
#include <linux/proc_fs.h>
#include <linux/kthread.h>
#include <linux/delay.h>

static int vtss_wd_state = 0; // disabled
atomic_t vtss_nmiwd_sync = ATOMIC_INIT(1);

static ssize_t vtss_kernel_write(struct file *file, void *buf, size_t count, loff_t pos)
{
#ifdef VTSS_AUTOCONF_KERNEL_READ_WRITE
    return kernel_write(file, buf, count, &pos);
#else
    unsigned long res;
    mm_segment_t old_fs = get_fs();
    set_fs(get_ds());
    res = vfs_write(file, (const char __user *)buf, count, &pos);
    set_fs(old_fs);
    return res;
#endif
}

static ssize_t vtss_kernel_read(struct file *file, void *buf, size_t count, loff_t pos)
{
#ifdef VTSS_AUTOCONF_KERNEL_READ_WRITE
    return kernel_read(file, buf, count, &pos);
#else
    unsigned long res;
    mm_segment_t old_fs = get_fs();
    set_fs(get_ds());
    res = vfs_read(file, (char __user *)buf, count, &pos);
    set_fs(old_fs);
    return res;
#endif
}

static struct file *vtss_open_nmi_wd(void)
{
    return filp_open("/proc/sys/kernel/nmi_watchdog", O_RDWR, 0);
}

static void vtss_close_nmi_wd(struct file *fd)
{
    filp_close(fd, 0);
}

int vtss_nmi_watchdog_disable_thread(void *data)
{
    char c = '0';
    struct file *fd = NULL;
    int ret_code = 1;
    struct cred *new;
    int *mode_ptr = NULL;

    if (!data) {
        ERROR("No WD data");
        return VTSS_ERR_INTERNAL;
    }
    mode_ptr = data;

    new = prepare_kernel_cred(NULL);
    if (new != NULL) {
        commit_creds(new);
    } else {
        ERROR("Cannot prepare kernel creds");
    }
    // The function vtss_open_nmi_wd cannot be called when irqs disabled.
    // Otherwise can lead deadlock in smp_call_function_single!
    fd = vtss_open_nmi_wd();
    if (IS_ERR(fd)) {
        TRACE("Watchdog device is not enabled");
        ret_code = 2;
        goto exit_mark_no_file;
    }
    while (!atomic_dec_and_test(&vtss_nmiwd_sync)) {
        atomic_inc(&vtss_nmiwd_sync);
    }
    vtss_wd_state = vtss_wd_state + 1;
    // check watchdog state
    vtss_kernel_read(fd, &c, 1, 0);

    if (c == '1' && vtss_wd_state != 1) {
        ERROR("wixing counter");
        vtss_wd_state = 1;
    }
    if (vtss_wd_state == 1) {
        if (c == '0') {
            TRACE("Watchdog device is not enabled");
            vtss_wd_state = vtss_wd_state - 1;
            ret_code = 2;
            goto unlock_exit_mark;
        }
        vtss_kernel_write(fd, "0", 1, 0);
        vtss_kernel_read(fd, &c, 1, 0);
        if (c != '0') {
            ERROR("Watchdog is not disabled yet! Add wait into the code");
        }
    } else {
        TRACE("Watchdog was disabled already");
    }
    if (*mode_ptr == 1) {
        vtss_wd_state = vtss_wd_state - 1;
        if (vtss_wd_state != 0) {
            TRACE("Watchdog state will not be changed as VTSS collection is running");
            ret_code = 2;
        }
    }
unlock_exit_mark:
    atomic_inc(&vtss_nmiwd_sync);
    vtss_close_nmi_wd(fd);
exit_mark_no_file:
    *mode_ptr = *mode_ptr + ret_code; // done!
    return ret_code;
}

int vtsspp_nmi_root_thread_create(int (*threadfn)(void *data), const char *name, int mode)
{
    int thread_ret = mode;
    int count = 10000;
    struct task_struct *task = NULL;

    task = kthread_run(threadfn, (void*)&thread_ret, "%s", name);

    TRACE("task tid=%d, task->state=%lx, task->exit_state=%lx", task->tgid, task->state, (unsigned long)task->exit_state);

    while (thread_ret == mode && count > 0) {
        msleep_interruptible(10);
        TRACE("in wait, task->state=%lx, task->exit_state=%lx", task->state, (unsigned long)task->exit_state);
        count--;
    }
    if (thread_ret == mode) {
        ERROR("Watchtdog operations are still in progress");
    }

    return thread_ret - mode - 1;
}

int vtss_nmi_watchdog_disable(int mode)
{
    return vtsspp_nmi_root_thread_create(&vtss_nmi_watchdog_disable_thread, "vtsspp_nmiwd_disable", mode);
}

int vtss_nmi_watchdog_enable_thread(void *data)
{
    struct file *fd = NULL;
    int ret_code = 1;
    struct cred *new;

    int *mode_ptr = NULL;
    if (!data) {
        ERROR("No WD data");
        return VTSS_ERR_INTERNAL;
    }
    mode_ptr = data;

    new = prepare_kernel_cred(NULL);

    if (new != NULL) {
        commit_creds(new);
    }
    fd = vtss_open_nmi_wd();
    if (IS_ERR(fd)) {
        TRACE("Watchdog device is not enabled at the end of collection");
        ret_code = 2;
        goto exit_mark_no_file;
    }
    while (!atomic_dec_and_test(&vtss_nmiwd_sync)) {
        atomic_inc(&vtss_nmiwd_sync);
    }
    if (vtss_wd_state == 0 && *mode_ptr == 0) {
        TRACE("Watchdog device was not enabled before collection");
        ret_code = 2;
        goto unlock_exit_mark;
    }
    if (*mode_ptr == 0) vtss_wd_state = vtss_wd_state - 1;
    if (vtss_wd_state == 0) {
        vtss_kernel_write(fd, "1", 1, 0);
    }
    else if (*mode_ptr == 1) {
        TRACE("NMI watchdog timer cannot be enabled as VTSS collection is not finshed yet");
        ret_code = 2;
    }
unlock_exit_mark:
    atomic_inc(&vtss_nmiwd_sync);
    vtss_close_nmi_wd(fd);
exit_mark_no_file:
    *mode_ptr = *mode_ptr + ret_code;
    return ret_code;
}

int vtss_nmi_watchdog_enable(int mode)
{
    return vtsspp_nmi_root_thread_create(&vtss_nmi_watchdog_enable_thread, "vtsspp_nmiwd_enable", mode);
}
