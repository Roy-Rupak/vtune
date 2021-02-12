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
#include "cmd.h"
#include "globals.h"
#include "task_data.h"
#include "task_util.h"
#include "target.h"
#include "pmi.h"
#include "mmap.h"
#include "probe.h"
#include "transport.h"
#include "record.h"
#include "procfs.h"
#include "pebs.h"
#include "dsa.h"
#include "bts.h"
#include "kpti.h"
#include "ipt.h"
#include "lbr.h"
#include "user_vm.h"
#include "nmiwd.h"
#include "mpool.h"
#include "workqueue.h"
#include "time.h"

#include <linux/file.h>
#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 32)
#include <xen/xen.h>
#endif

uid_t vtss_session_uid = 0;
gid_t vtss_session_gid = 0;

atomic_t vtss_collector_state = ATOMIC_INIT(VTSS_COLLECTOR_STOPPED);
cpumask_t vtss_collector_cpumask = CPU_MASK_NONE;
atomic_t vtss_start_paused = ATOMIC_INIT(0);
atomic_t vtss_transport_state = ATOMIC_INIT(VTSS_TRANSPORT_STOPPED);
atomic_t vtss_transport_busy = ATOMIC_INIT(0);
atomic_t vtss_kernel_tasks_in_progress = ATOMIC_INIT(0);

int vtss_cmd_open(void)
{
    return 0;
}

int vtss_cmd_close(void)
{
    return 0;
}

static int vtss_cmd_set_target_task(struct task_struct *task)
{
    int rc = -EINVAL;
    int state = atomic_read(&vtss_collector_state);

    if (state == VTSS_COLLECTOR_RUNNING || state == VTSS_COLLECTOR_PAUSED) {
        struct task_struct *p;
        if (task != NULL) {
            char *tmp = NULL;
            char *pathname = NULL;
            struct mm_struct *mm;
            struct pid *pgrp;

            pgrp = get_pid(task_pid(task));
            if ((mm = get_task_mm(task)) != NULL) {
                struct file *exe_file = mm->exe_file;
                mmput(mm);
                if (exe_file) {
                    get_file(exe_file);
                    tmp = vtss_kmalloc(PAGE_SIZE, GFP_KERNEL);
                    if (tmp) {
                        pathname = VTSS_DPATH(exe_file, tmp, PAGE_SIZE);
                        if (!IS_ERR(pathname)) {
                            char *p = strrchr(pathname, '/');
                            pathname = p ? p+1 : pathname;
                        } else {
                            pathname = NULL;
                        }
                    }
                    fput(exe_file);
                }
            }
            rc = -ENOENT;
            do_each_pid_thread(pgrp, PIDTYPE_PID, p) {
                DEBUG_CMD("profile: tid=%d, pid=%d, ppid=%d, pathname='%s'", TASK_TID(task), TASK_PID(task), TASK_PID(TASK_PARENT(p)), pathname);
                if (!vtss_target_new(TASK_TID(p), TASK_PID(p), TASK_PID(TASK_PARENT(p)), pathname, -1, -1)) {
                    rc = 0;
                }
            } while_each_pid_thread(pgrp, /*PIDTYPE_MAX*/PIDTYPE_PID, p);

            if (rc != 0) {
                ERROR("(%d:%d): Cannot profile the process '%s'", TASK_PID(task), TASK_TID(task), pathname);
            }
            put_pid(pgrp);
            if (tmp)
                vtss_kfree(tmp);
        } else
            rc = -ENOENT;
    }
    return rc;
}

int vtss_cmd_set_target(pid_t pid)
{
    int rc = -EINVAL;
    struct task_struct *task = vtss_find_task_by_tid(pid);
    rc = vtss_cmd_set_target_task(task);
    return rc;
}

static void vtss_collector_pmi_disable_on_cpu(void *ctx)
{
    vtss_pmi_disable();
}

static void vtss_transport_fini_work(struct work_struct *work)
{
    vtss_transport_fini();
    atomic_set(&vtss_transport_state, VTSS_TRANSPORT_STOPPED);
    vtss_procfs_ctrl_wake_up(NULL, 0);
    if (work) vtss_kfree(work);
}

static void vtss_wait_transport_fini(void)
{
    while (atomic_read(&vtss_transport_state) != VTSS_TRANSPORT_STOPPED);
}

static int vtss_callcount_init(void)
{
    int rc = 0;
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) rc = vtss_ipt_init();
    else rc = vtss_bts_init(reqcfg.bts_cfg.brcount);
    return rc;
}

static void vtss_callcount_fini(void)
{
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) vtss_ipt_fini();
    else vtss_bts_fini();
}

static void vtss_target_complete_item(vtss_task_map_item_t *item, void *args)
{
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
    if (tskd) tskd->state |= VTSS_ST_COMPLETE;
}

static unsigned long long vtss_collection_start_time;

static int vtss_collection_fini(void)
{
    if (atomic_read(&vtss_kernel_tasks_in_progress))
        WARNING("%d collector tasks in progress", atomic_read(&vtss_kernel_tasks_in_progress));
    while (atomic_read(&vtss_kernel_tasks_in_progress) != 0);

    if (atomic_read(&vtss_target_count) != 0) {
        //detach case
        vtss_task_map_foreach(vtss_target_complete_item, NULL);
    }

    while (atomic_read(&vtss_events_enabling) != 0);

    vtss_probe_fini();
    vtss_cpuevents_fini_pmu();
    vtss_pebs_fini();
    vtss_callcount_fini();
    vtss_lbr_fini();
    vtss_dsa_fini();
    /* NOTE: !!! vtss_transport_fini() should be after vtss_task_map_fini() !!! */
    vtss_task_map_fini();

    atomic_set(&vtss_transport_state, VTSS_TRANSPORT_UNINITING);
    while (atomic_read(&vtss_transport_busy) != 0);

    if (vtss_queue_work(-1, vtss_transport_fini_work, NULL, 0)) {
        vtss_transport_fini();
        atomic_set(&vtss_transport_state, VTSS_TRANSPORT_STOPPED);
        vtss_procfs_ctrl_wake_up(NULL, 0);
    } else {
        set_tsk_need_resched(current);
    }
    vtss_session_uid = 0;
    vtss_session_gid = 0;
    vtss_time_limit  = 0ULL; /* set default value */

    vtss_nmi_watchdog_enable(0);
    atomic_set(&vtss_start_paused, 0);
    atomic_set(&vtss_collector_state, VTSS_COLLECTOR_STOPPED);
    vtss_target_clear_temp_list();
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
#ifdef VTSS_AUTOCONF_PREEMPT_NOTIFIER_CONTROL
    preempt_notifier_dec();
#endif
#endif
    REPORT("Collection stopped after %lld sec", vtss_time_get_msec_from(vtss_collection_start_time)/1000ULL);
    return 0;
}

int vtss_cmd_start(void)
{
    int rc = 0;
    int old_state = atomic_cmpxchg(&vtss_collector_state, VTSS_COLLECTOR_STOPPED, VTSS_COLLECTOR_INITING);

    if (old_state != VTSS_COLLECTOR_STOPPED) {
        ERROR("Already running");
        return VTSS_ERR_START_IN_RUN;
    }

    if (vtss_reqcfg_verify()) {
        ERROR("Incoming settings are incorrect");
        return VTSS_ERR_BADARG;
    }
    // workaround on the problem when pmi enabling
    // while the collection is stopping,
    // but some threads is still collecting data
    on_each_cpu(vtss_collector_pmi_disable_on_cpu, NULL, 1);
    vtss_nmi_watchdog_disable(0);
    vtss_wait_transport_fini();
#ifdef VTSS_CONFIG_INTERNAL_MEMORY_POOL
    vtss_memory_pool_clear();
#endif
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
#ifdef VTSS_AUTOCONF_PREEMPT_NOTIFIER_CONTROL
    preempt_notifier_inc();
#endif
#endif
    if (reqcfg.stk_sz[vtss_stk_user])
        WARNING("User stack limit: %ldKB", reqcfg.stk_sz[vtss_stk_user]/1024);
    REPORT("Collection started");
    vtss_collection_start_time = vtss_time_cpu();

    atomic_set(&vtss_target_count, 0);
#ifdef VTSS_VMA_SEARCH_BOOST
    atomic_set(&vtss_mmap_reg_callcnt, 1);
#endif
    cpumask_copy(&vtss_collector_cpumask, &vtss_procfs_cpumask);
    vtss_target_init_temp_list();

    vtss_current_uid_gid(&vtss_session_uid, &vtss_session_gid);
    vtss_procfs_ctrl_flush();
    rc |= vtss_transport_init(vtss_is_aux_transport_ring_buffer());
    atomic_set(&vtss_transport_state, VTSS_TRANSPORT_READY);
    rc |= vtss_task_map_init();
    rc |= vtss_dsa_init();
    rc |= vtss_lbr_init();
    rc |= vtss_callcount_init();
    rc |= vtss_pebs_init();
    rc |= vtss_cpuevents_init_pmu(vtss_procfs_defsav);
    rc |= vtss_probe_init();
    REPORT("Trace flags: 0x%x", reqcfg.trace_cfg.trace_flags);
    REPORT("Time source: %s", vtss_time_source ? "TSC" : "SYS");
    if (!rc) {
        atomic_set(&vtss_collector_state, VTSS_COLLECTOR_RUNNING);
        if (atomic_read(&vtss_start_paused)) {
            atomic_set(&vtss_start_paused, 0);
            vtss_cmd_pause();
        }
    } else {
        ERROR("Collection was not started because of initialization error");
        vtss_collection_fini();
    }
    return rc;
}

int vtss_cmd_stop(void)
{
    int old_state = atomic_cmpxchg(&vtss_collector_state, VTSS_COLLECTOR_RUNNING, VTSS_COLLECTOR_UNINITING);

    if (old_state == VTSS_COLLECTOR_STOPPED) {
        DEBUG_CMD("Already stopped");
        return 0;
    }
    if (old_state == VTSS_COLLECTOR_INITING) {
        DEBUG_CMD("Stop in initing state");
        return 0;
    }
    if (old_state == VTSS_COLLECTOR_UNINITING) {
        DEBUG_CMD("Stop in uniniting state");
        return 0;
    }
    if (old_state == VTSS_COLLECTOR_PAUSED) {
        old_state = atomic_cmpxchg(&vtss_collector_state, VTSS_COLLECTOR_PAUSED, VTSS_COLLECTOR_UNINITING);
    }
    return vtss_collection_fini();
}

static void vtss_cmd_stop_work(struct work_struct *work)
{
    vtss_cmd_stop();
    vtss_kfree(work);
}

int vtss_cmd_stop_async(void)
{
    int rc = 0;

    if (atomic_read(&vtss_collector_state) != VTSS_COLLECTOR_STOPPED) {
        rc = vtss_queue_work(-1, vtss_cmd_stop_work, NULL, 0);
        DEBUG_CMD("Async stop: %d", rc);
    }
    return rc;
}

int vtss_cmd_stop_ring_buffer(void)
{
    int rc = 0;

    vtss_transport_stop_ring_bufer();
    return rc;
}

int vtss_cmd_pause(void)
{
    int rc = -EINVAL;
    int cpu;
    int old_state = atomic_cmpxchg(&vtss_collector_state, VTSS_COLLECTOR_RUNNING, VTSS_COLLECTOR_PAUSED);

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    if (old_state == VTSS_COLLECTOR_RUNNING) {
        if (!vtss_record_probe_all(cpu, 0x66 /* tpss_pi___itt_pause from TPSS ini-file */)) {
            rc = 0;
        } else {
            WARNING("Failed to record probe all");
        }
    } else if (old_state == VTSS_COLLECTOR_PAUSED) {
        DEBUG_CMD("Already paused");
        rc = 0;
    } else if (old_state == VTSS_COLLECTOR_STOPPED) {
        atomic_inc(&vtss_start_paused);
        DEBUG_CMD("Collector is stopped. Start paused: %d", atomic_read(&vtss_start_paused));
        rc = 0;
    } else {
        /* Pause can be done in RUNNING state only */
        DEBUG_CMD("Pause in wrong state: %d", old_state);
    }
    REPORT("Collection paused");
    return rc;
}

int vtss_cmd_resume(void)
{
    int rc = -EINVAL;
    int cpu;
    int old_state = atomic_cmpxchg(&vtss_collector_state, VTSS_COLLECTOR_PAUSED, VTSS_COLLECTOR_RUNNING);

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    if (old_state == VTSS_COLLECTOR_PAUSED) {
        if (!vtss_record_probe_all(cpu, 0x67 /* tpss_pi___itt_resume from TPSS ini-file */)) {
            rc = 0;
        } else {
            WARNING("Failed to record probe all");
        }
    } else if (old_state == VTSS_COLLECTOR_RUNNING) {
        DEBUG_CMD("Already resumed");
        rc = 0;
    } else if (old_state == VTSS_COLLECTOR_STOPPED) {
        atomic_dec(&vtss_start_paused);
        DEBUG_CMD("Collector is stopped. Start paused: %d", atomic_read(&vtss_start_paused));
        rc = 0;
    } else {
        /* Resume can be done in PAUSED state only */
        DEBUG_CMD("Resume in wrong state: %d", old_state);
    }
    REPORT("Collection resumed");
    return rc;
}

void vtss_fini(void)
{
    vtss_cmd_stop();
    vtss_wait_transport_fini();
    vtss_procfs_fini();
    vtss_user_vm_fini();
    vtss_cpuevents_fini();
    vtss_globals_fini();
#ifdef VTSS_CONFIG_INTERNAL_MEMORY_POOL
    vtss_memory_pool_fini();
#endif
}

int vtss_init(void)
{
    int rc = 0;

#if LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 32)
    if (xen_initial_domain()) {
        ERROR("XEN initial domain (DOM0) is not supported");
        return -1;
    }
#endif

    cpumask_copy(&vtss_collector_cpumask, cpu_present_mask);

#ifdef VTSS_CONFIG_INTERNAL_MEMORY_POOL
    rc |= vtss_memory_pool_init();
#endif
    rc |= vtss_globals_init();
    rc |= vtss_cpuevents_init();
    rc |= vtss_user_vm_init();
    rc |= vtss_procfs_init();

#ifdef VTSS_CONFIG_KPTI
    rc |= vtss_cea_init();
#elif defined(VTSS_CONFIG_KAISER)
    rc |= vtss_kaiser_init();
#else
    REPORT("KPTI is not detected");
#endif
#ifdef CONFIG_RANDOMIZE_BASE
    REPORT("KASLR is detected");
#endif
#ifdef VTSS_CONFIG_REALTIME
    REPORT("RT patch is detected");
#endif
#ifndef VTSS_USE_TRACEPOINTS
    REPORT("Tracepoints are disabled");
#endif
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
    REPORT("Use preempt notifiers");
#endif
    return rc;
}
