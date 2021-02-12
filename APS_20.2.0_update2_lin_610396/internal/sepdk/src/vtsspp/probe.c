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
  the GNU General Public License.
*/
#include "config.h"
#include "debug.h"
#include "task_data.h"
#include "task_util.h"
#include "target.h"
#include "mmap.h"
#include "sched.h"
#include "globals.h"
#include "kprobes.h"
#include "tracepoint.h"
#include "regs.h"

#ifndef VTSS_USE_PREEMPT_NOTIFIERS

#if defined(VTSS_AUTOCONF_TRACE_SCHED_RQ)
#define VTSS_SCHED_ARG struct rq *rq,
#elif defined(VTSS_AUTOCONF_TRACE_SCHED_PREEMPT)
#define VTSS_SCHED_ARG bool preempt,
#else
#define VTSS_SCHED_ARG
#endif

#ifdef VTSS_USE_TRACEPOINTS
static void tp_sched_switch(VTSS_TP_PROTO VTSS_SCHED_ARG struct task_struct *prev, struct task_struct *next)
{
    unsigned long prev_bp = 0;
    unsigned long prev_ip = 0;

    if (prev == current && current != 0)
    {
        prev_bp = vtss_read_rbp();
        prev_ip = _THIS_IP_;
    }
    vtss_sched_switch(prev, next, prev_bp, prev_ip);
}
#endif

#ifdef VTSS_AUTOCONF_JPROBE
static void jp_sched_switch(struct task_struct *prev, struct task_struct *next)
{
    unsigned long prev_bp = 0;
    unsigned long prev_ip = 0;

    if (prev == current && current != 0)
    {
        prev_bp = vtss_read_rbp();
        prev_ip = _THIS_IP_;
    }
    vtss_sched_switch(prev, next, prev_bp, prev_ip);
    jprobe_return();
}
#endif

#ifdef VTSS_AUTOCONF_JPROBE
static struct jprobe jprobe_sched_switch = {
    .entry = jp_sched_switch
};
#endif

static int probe_sched_switch(void)
{
    int rc;

    VTSS_REGISTER_TRACEPOINT(sched_switch, rc);
#ifdef VTSS_AUTOCONF_JPROBE
    if (rc) {
        rc = vtss_register_jprobe(&jprobe_sched_switch, "context_switch");
        if (rc) rc = vtss_register_jprobe(&jprobe_sched_switch, "__switch_to");
        if (rc) {
            ERROR("Unable to register 'context_switch' probe");
            return -1;
        }
    }
#endif
    return 0;
}

static int unprobe_sched_switch(void)
{
    VTSS_UNREGISTER_TRACEPOINT(sched_switch);
#ifdef VTSS_AUTOCONF_JPROBE
    vtss_unregister_jprobe(&jprobe_sched_switch);
#endif
    return 0;
}
#endif

#ifdef VTSS_USE_TRACEPOINTS
static void tp_sched_process_fork(VTSS_TP_PROTO struct task_struct *task, struct task_struct *child)
{
    vtss_target_fork(task, child);
}
#endif

static int rp_sched_process_fork_enter(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    /* Skip kernel threads or if no memory */
    return (current->mm == NULL) ? 1 : 0;
}

static int rp_sched_process_fork_leave(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    pid_t pid = (pid_t)regs_return_value(regs);

    if (pid) {
        struct task_struct *task = vtss_find_task_by_tid(pid);
        if (task) vtss_target_fork(current, task);
        else WARNING("Unable to find pid: %d", pid);
    }
    return 0;
}

static struct kretprobe kretprobe_fork = {
    .entry_handler = rp_sched_process_fork_enter,
    .handler       = rp_sched_process_fork_leave,
    .data_size     = 0
};

static int probe_sched_process_fork(void)
{
    int rc;

    VTSS_REGISTER_TRACEPOINT(sched_process_fork, rc);
    if (rc) {
        rc = vtss_register_kretprobe(&kretprobe_fork, "do_fork");
        if (rc) rc = vtss_register_kretprobe(&kretprobe_fork, "_do_fork");
        if (rc) {
            ERROR("Unable to register 'fork' probe");
            return -1;
        }
    }
    return 0;
}

static int unprobe_sched_process_fork(void)
{
    VTSS_UNREGISTER_TRACEPOINT(sched_process_fork);
    vtss_unregister_kretprobe(&kretprobe_fork);
    return 0;
}

/* per-instance private data */
struct rp_sched_process_exec_data
{
    int ppid;
    char filename[VTSS_FILENAME_SIZE];
};

// From 3.9 do_execve is inlined into sys_execve,
// and probe is broken because of this
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0)
static int exec_probe_user = 1;
#else
static int exec_probe_user = 0;
#endif

static int rp_sched_process_exec_enter(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    char *filename;
    struct rp_sched_process_exec_data *data = (struct rp_sched_process_exec_data*)ri->data;

    if (current->mm == NULL)
        return 1; /* Skip kernel threads or if no memory */
    if (!data) return 1;
    filename = (char*)REG(di, regs);
    vtss_get_task_basename(data->filename, filename, exec_probe_user);

    data->ppid = TASK_TID(ri->task);
    TRACE("ri=0x%p, data=0x%p, filename=%s", ri, data, data->filename);
    vtss_target_exec_enter(ri->task, data->filename);
    return 0;
}

static int rp_sched_process_exec_leave(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    struct rp_sched_process_exec_data *data = (struct rp_sched_process_exec_data*)ri->data;
    int rc = regs_return_value(regs);

    if (!data) return 0;
    TRACE("ri=0x%p, data=0x%p, filename=%s, rc=%d", ri, data, data->filename, rc);
    vtss_target_exec_leave(ri->task, data->filename, rc, data->ppid);
    return 0;
}

static struct kretprobe kretprobe_exec = {
    .entry_handler = rp_sched_process_exec_enter,
    .handler       = rp_sched_process_exec_leave,
    .data_size     = sizeof(struct rp_sched_process_exec_data)
};

static int probe_sched_process_exec(void)
{
    int rc = 0;

    if (exec_probe_user) {
        rc = vtss_register_kretprobe(&kretprobe_exec, "sys_execve");
        if (rc) rc = vtss_register_kretprobe(&kretprobe_exec, "__x64_sys_execve");
    } else {
        rc = vtss_register_kretprobe(&kretprobe_exec, "do_execve");
    }
    if (rc) ERROR("Unable to register 'exec' probe");

    return rc;
}

static int unprobe_sched_process_exec(void)
{
    vtss_unregister_kretprobe(&kretprobe_exec);
    return 0;
}

#ifdef CONFIG_COMPAT
static struct kretprobe kretprobe_exec_compat = {
    .entry_handler = rp_sched_process_exec_enter,
    .handler       = rp_sched_process_exec_leave,
    .data_size     = sizeof(struct rp_sched_process_exec_data)
};

static int probe_sched_process_exec_compat(void)
{
    int rc = 0;

    if (exec_probe_user) {
        rc = vtss_register_kretprobe(&kretprobe_exec_compat, "compat_sys_execve");
        if (rc) rc = vtss_register_kretprobe(&kretprobe_exec_compat, "__x32_compat_sys_execve");
    } else {
        rc = vtss_register_kretprobe(&kretprobe_exec_compat, "compat_do_execve");
    }
    if (rc) ERROR("Unable to register 'exec_compat' probe");

    return 0;
}

static int unprobe_sched_process_exec_compat(void)
{
    return vtss_unregister_kretprobe(&kretprobe_exec_compat);
}
#endif

#ifdef VTSS_USE_TRACEPOINTS
static void tp_sched_process_exit(VTSS_TP_PROTO struct task_struct *task)
{
    vtss_target_exit(task);
}
#endif

static int kp_sched_process_exit(struct kprobe *p, struct pt_regs *regs)
{
    vtss_target_exit(current);
    return 0;
}

static struct kprobe kprobe_exit = {
    .pre_handler = kp_sched_process_exit,
};

static int probe_sched_process_exit(void)
{
    int rc;

    VTSS_REGISTER_TRACEPOINT(sched_process_exit, rc);
    if (rc) {
        rc = vtss_register_kprobe(&kprobe_exit, "do_exit");
        if (rc) {
            ERROR("Unable to register 'exit' probe");
            return -1;
        }
    }
    return 0;
}

static int unprobe_sched_process_exit(void)
{
    VTSS_UNREGISTER_TRACEPOINT(sched_process_exit);
    vtss_unregister_kprobe(&kprobe_exit);
    return 0;
}

/* per-instance private data */
struct rp_mmap_region_data
{
    struct file *file;
    unsigned long addr;
    unsigned long size;
    unsigned long pgoff;
    unsigned int  flags;
};

static int rp_mmap_region_enter(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    struct rp_mmap_region_data *data = (struct rp_mmap_region_data*)ri->data;

    if (current->mm == NULL)
        return 1; /* Skip kernel threads or if no memory */
    data->file  = (struct file*)REG(di, regs);
    data->addr  = REG(si, regs);
    data->size  = REG(dx, regs);
#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 9, 0)
    data->flags = REG(cx, regs); /* vm_flags */
    data->pgoff = data->file ? REG(r8, regs) : 0;
#else
    data->flags = REG(r8, regs); /* vm_flags */
    data->pgoff = data->file ? REG(r9, regs) : 0;
#endif
    return 0;
}

static int rp_mmap_region_leave(struct kretprobe_instance *ri, struct pt_regs *regs)
{
    struct rp_mmap_region_data *data = (struct rp_mmap_region_data*)ri->data;
    unsigned long rc = regs_return_value(regs);

    if ((rc == data->addr) &&
        (data->flags & VM_EXEC) && !(data->flags & VM_WRITE) &&
        data->file && data->file->f_path.dentry)
    {
        TRACE("file=0x%p, addr=0x%lx, pgoff=%lu, size=%lu, flags=0x%x", data->file, data->addr, data->pgoff, data->size, data->flags);
        vtss_mmap(data->file, data->addr, data->pgoff, data->size);
    }
    return 0;
}

static struct kretprobe kretprobe_mmap_region = {
    .entry_handler = rp_mmap_region_enter,
    .handler       = rp_mmap_region_leave,
    .data_size     = sizeof(struct rp_mmap_region_data)
};

static int probe_mmap_region(void)
{
    if (vtss_register_kretprobe(&kretprobe_mmap_region, "mmap_region")) {
        ERROR("Unable to register 'mmap' probe");
        return -1;
    }
    return 0;
}

static int unprobe_mmap_region(void)
{
    vtss_unregister_kretprobe(&kretprobe_mmap_region);
    return 0;
}

#ifdef VTSS_SYSCALL_TRACE
static int kp_syscall_enter(struct kprobe *p, struct pt_regs *regs)
{
    struct pt_regs *sregs;

    if (current->mm == NULL)
        return 1; /* Skip kernel threads or if no memory */
    sregs = (struct pt_regs*)REG(di, regs);
    vtss_syscall_enter(sregs);
    return 0;
}

static int kp_syscall_leave(struct kprobe *p, struct pt_regs *regs)
{
    struct pt_regs *sregs;

    if (current->mm == NULL)
        return 1; /* Skip kernel threads or if no memory */
    sregs = (struct pt_regs*)REG(di, regs);
    vtss_syscall_leave(sregs);
    return 0;
}

static struct kprobe kprobe_syscall_enter = {
    .pre_handler = kp_syscall_enter,
};

static struct kprobe kprobe_syscall_leave = {
    .pre_handler = kp_syscall_leave,
};

static int probe_syscall_trace(void)
{
    if (vtss_register_kprobe(&kprobe_syscall_leave, "syscall_trace_leave") == 0) {
        if (vtss_register_kprobe(&kprobe_syscall_enter, "syscall_trace_enter")) {
            WARNING("System calls tracing is disabled");
        }
    }
    return 0;
}

static int unprobe_syscall_trace(void)
{
    vtss_unregister_kprobe(&kprobe_syscall_leave);
    vtss_unregister_kprobe(&kprobe_syscall_enter);
}
#endif

/* kernel module notifier */
#include <linux/module.h>
static int vtss_kmodule_notifier(struct notifier_block *block, unsigned long val, void *data)
{
    struct module *mod = (struct module*)data;
    const char *name = mod->name;
#ifdef VTSS_AUTOCONF_MODULE_CORE_LAYOUT
    unsigned long module_core = (unsigned long)mod->core_layout.base;
    unsigned long core_size = mod->core_layout.size;
#else
    unsigned long module_core = (unsigned long)mod->module_core;
    unsigned long core_size = mod->core_size;
#endif
    if (val == MODULE_STATE_COMING) {
        TRACE("MODULE_STATE_COMING: name='%s', module_core=0x%lx, core_size=%lu", name, module_core, core_size);
        vtss_kmap(current, name, module_core, 0, core_size);
    } else if (val == MODULE_STATE_GOING) {
        TRACE("MODULE_STATE_GOING: name='%s'", name);
    }
    return NOTIFY_DONE;
}

static struct notifier_block vtss_kmodules_nb = {
    .notifier_call = &vtss_kmodule_notifier
};

static int probe_kmodules(void)
{
    return register_module_notifier(&vtss_kmodules_nb);
}

static int unprobe_kmodules(void)
{
    return unregister_module_notifier(&vtss_kmodules_nb);
}

int vtss_probe_init(void)
{
    int rc = 0;
#ifdef VTSS_SYSCALL_TRACE
    rc |= probe_syscall_trace();
#endif
    rc |= probe_sched_process_exit();
    rc |= probe_sched_process_fork();
#ifdef CONFIG_COMPAT
    rc |= probe_sched_process_exec_compat();
#endif
    rc |= probe_sched_process_exec();
    rc |= probe_mmap_region();
    rc |= probe_kmodules();
#ifndef VTSS_USE_PREEMPT_NOTIFIERS
    rc |= probe_sched_switch();
#endif
    return rc;
}

void vtss_probe_fini(void)
{
#ifndef VTSS_USE_PREEMPT_NOTIFIERS
    unprobe_sched_switch();
#endif
    unprobe_kmodules();
    unprobe_mmap_region();
    unprobe_sched_process_exec();
#ifdef CONFIG_COMPAT
    unprobe_sched_process_exec_compat();
#endif
    unprobe_sched_process_fork();
    unprobe_sched_process_exit();
#ifdef VTSS_SYSCALL_TRACE
    unprobe_syscall_trace();
#endif
#ifdef VTSS_USE_TRACEPOINTS
    tracepoint_synchronize_unregister();
#endif
}
