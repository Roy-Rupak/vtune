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
#include "task_data.h"
#include "task_util.h"
#include "task_map.h"
#include "pmi.h"
#include "sched.h"
#include "transport.h"
#include "procfs.h"
#include "record.h"
#include "mmap.h"
#include "nmiwd.h"
#include "ipt.h"
#include "regs.h"
#include "mpool.h"
#include "spinlock.h"
#include "workqueue.h"

#include <linux/delay.h>        /* for msleep_interruptible() */

atomic_t vtss_target_count = ATOMIC_INIT(0);

int vtss_is_aux_transport_allowed(void)
{
    return (vtss_client_major_ver > 1 || (vtss_client_major_ver == 1 && vtss_client_minor_ver >= 1));
}

int vtss_is_aux_transport_ring_buffer(void)
{
    return vtss_is_aux_transport_allowed() && VTSS_RB_MODE;
}

static void vtss_target_ctrl_wakeup(struct vtss_transport_data *trnd, struct vtss_transport_data *trnd_aux)
{
    if (trnd) {
        if (trnd_aux && trnd_aux != trnd) {
            char *transport_path_aux = vtss_transport_get_filename(trnd_aux);
            vtss_procfs_ctrl_wake_up(transport_path_aux, strlen(transport_path_aux) + 1);
        } else {
            char *transport_path = vtss_transport_get_filename(trnd);
            vtss_procfs_ctrl_wake_up(transport_path, strlen(transport_path) + 1);
        }
    }
}

static void vtss_target_transport_create(struct vtss_transport_data **trnd, struct vtss_transport_data **trnd_aux, pid_t ppid, pid_t pid, uid_t cuid, gid_t cgid)
{
    if (!trnd) return;
    *trnd = vtss_transport_create(ppid, pid, cuid, cgid);
    if (!(*trnd)) return;
    if (trnd_aux) {
        if (vtss_is_aux_transport_allowed()) {
            *trnd_aux = vtss_transport_create_aux(*trnd, cuid, cgid, vtss_is_aux_transport_ring_buffer());
        }
        else {
            *trnd_aux = NULL;
        }
    }
    vtss_target_ctrl_wakeup(*trnd, *trnd_aux);
}

void vtss_target_del_empty_transport(struct vtss_transport_data *trnd, struct vtss_transport_data *trnd_aux)
{
    if (!trnd && !trnd_aux) return;

    atomic_inc(&vtss_transport_busy);
    if (VTSS_TRANSPORT_IS_READY) {
        if (trnd != NULL) {
            if (trnd == trnd_aux) trnd_aux = NULL;
            if (trnd_aux && vtss_transport_delref(trnd_aux) == 0) {
                vtss_transport_complete(trnd_aux);
            }
            if (trnd && vtss_transport_delref(trnd) == 0) {
                vtss_transport_complete(trnd);
            }
            /* NOTE: tskd->trnd will be destroyed in vtss_transport_fini() */
        }
    }
    atomic_dec(&vtss_transport_busy);
}

struct vtss_target_list_item
{
    struct list_head list;
    int pid;
    int cnt;
    int cnt_done;
};

static VTSS_DEFINE_SPINLOCK(vtss_target_temp_list_lock);
static LIST_HEAD(vtss_target_temp_list);

void vtss_target_init_temp_list(void)
{
    unsigned long flags;

    vtss_spin_lock_irqsave(&vtss_target_temp_list_lock, flags);
    INIT_LIST_HEAD(&vtss_target_temp_list);
    vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
}

struct vtss_target_list_item *vtss_target_find_in_temp_list_not_save(int pid)
{
    struct vtss_target_list_item *it = NULL;
    struct vtss_target_list_item *ret = NULL;
    struct list_head *p = NULL;

    list_for_each(p, &vtss_target_temp_list) {
        it = list_entry(p, struct vtss_target_list_item, list);
        if (it->pid == pid) {
            ret = it;
            break;
        }
    }
    return ret;
}

void vtss_target_remove_from_temp_list(int pid, int failed)
{
    unsigned long flags;
    struct vtss_target_list_item *it = NULL;
    struct list_head *p = NULL;
    struct list_head *tmp = NULL;

    vtss_spin_lock_irqsave(&vtss_target_temp_list_lock, flags);
    list_for_each_safe(p, tmp, &vtss_target_temp_list) {
        it = list_entry(p, struct vtss_target_list_item, list);
        if (it->pid == pid) {
            if (it->cnt == it->cnt_done) {
                DEBUG_TARGET("deleted completely from list, pid=%d, cnt=%d", pid, it->cnt);
                list_del(p);
                vtss_kfree(it);
            } else if (it->cnt < it->cnt_done) {
                ERROR("Target temp list is corrupted");
            } else {
                if (failed) it->cnt--; // queue_work failed, do it as it was before.
                else it->cnt_done++;
                DEBUG_TARGET("deleted from list, pid=%d, cnt_done=%d, cnt=%d", pid, it->cnt_done, it->cnt);
            }
            break;
        }
    }
    vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
}

int vtss_target_add_to_temp_list(int pid)
{
    unsigned long flags;
    struct vtss_target_list_item *item = NULL;

    vtss_spin_lock_irqsave(&vtss_target_temp_list_lock, flags);
    item = vtss_target_find_in_temp_list_not_save(pid);
    if (item) {
        int cnt;
        item->cnt++;
        cnt = item->cnt;
        vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
        DEBUG_TARGET("added to list item pid=%d, cnt=%d", pid, cnt);
        return cnt;
    }
    item = vtss_kmalloc(sizeof(struct vtss_target_list_item), GFP_ATOMIC);
    if (!item) {
        vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
        ERROR("No memory for target temp item");
        return -1;
    }
    item->pid = pid;
    item->cnt = 0;
    item->cnt_done = 0;
    list_add_tail(&item->list, &vtss_target_temp_list);
    vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
    DEBUG_TARGET("added item pid=%d, first time", pid);
    return 0;
}

int vtss_target_find_in_temp_list(int pid)
{
    unsigned long flags;
    struct vtss_target_list_item *it;
    struct list_head *p;
    int ret = -1;

    vtss_spin_lock_irqsave(&vtss_target_temp_list_lock, flags);
    list_for_each(p, &vtss_target_temp_list) {
        it = list_entry(p, struct vtss_target_list_item, list);
        if (it->pid == pid) {
            ret = it->cnt_done;
            break;
        }
    }
    vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
    return ret;
}

void vtss_target_clear_temp_list(void)
{
    unsigned long flags;
    struct vtss_target_list_item *it;
    struct list_head *p, *tmp;

    vtss_spin_lock_irqsave(&vtss_target_temp_list_lock, flags);
    list_for_each_safe(p, tmp, &vtss_target_temp_list) {
        it = list_entry(p, struct vtss_target_list_item, list);
        DEBUG_TARGET("free item pid=%d", it->pid);
        list_del(p);
        vtss_kfree(it);
    }
    INIT_LIST_HEAD(&vtss_target_temp_list);
    vtss_spin_unlock_irqrestore(&vtss_target_temp_list_lock, flags);
}

int vtss_target_wait_work_time(int id, int order)
{
    int wait_count = 100000;
    int num = -1;

    if (order == -1) {
        return 1;
    }
    while (wait_count--) {
        num = vtss_target_find_in_temp_list(id);
        if (num == -1) {
            return 1;
        }
        if (num > order) {
            return 1;
        }
        if (!irqs_disabled())
        {
            msleep_interruptible(1);
        }
        else
        {
            touch_nmi_watchdog();
        }
    }
    if (wait_count <= 0) ERROR("Cannot wait work %d with order %d", id, order);
    return 0;
}

static void vtss_target_add_mmap_work(struct work_struct *work)
{
    // This function load module map in the case if smth was wrong during first time loading
    // This is workaround on the problem:
    // During attach the "transfer loop" is not activated till the collection started.
    // The ring buffer is overflow on module loading as nobody reads it and for huge module maps we have unknowns.
    // So, we have to schedule the new task and try again.
    struct vtss_work *my_work = (struct vtss_work*)work;
    vtss_task_map_item_t *item = NULL;
    struct vtss_task_data *tskd = NULL;
    struct task_struct *task = NULL;
    struct vtss_transport_data *trnd = NULL;

    if (my_work == NULL) {
        ERROR("No work data");
        atomic_dec(&vtss_kernel_tasks_in_progress);
        return;
    }
    item = *((vtss_task_map_item_t**)(&my_work->data));
    if (item == NULL) {
        ERROR("No item data");
        goto out1;
    }
    if (atomic_read(&vtss_collector_state) == VTSS_COLLECTOR_UNINITING) {
        // no needs to add module map
        goto out;
    }
    tskd = (struct vtss_task_data*)&item->data;
    if (tskd == NULL) {
        ERROR("No task data");
        goto out;
    }

    trnd = VTSS_TRND_CFG(tskd);
    if (trnd == NULL) {
        ERROR("No transport data");
        goto out;
    }
    if (VTSS_IS_COMPLETE(tskd)) {
        // no needs to add module map
        goto out;
    }
    task = vtss_find_task_by_tid(tskd->tid);
    if (task == NULL) {
        ERROR("Cannot find tid: %d", tskd->tid);
        goto out;
    }

    if (vtss_mmap_all(tskd, task)) {
        msleep_interruptible(10); // wait again
        ERROR("Module map was not loaded completely to the trace");
        goto out;
    }
    if (atomic_read(&vtss_collector_state) == VTSS_COLLECTOR_UNINITING || vtss_kmap_all(tskd)) {
        ERROR("Kernel map was not loaded completely to the trace");
    }
    DEBUG_TARGET("%d:%d: data=0x%p, u=%d, n=%d",
        tskd->tid, tskd->pid, tskd, atomic_read(&item->usage), atomic_read(&vtss_target_count));
out:
    /* release data */
    vtss_task_map_put_item(item);
out1:
    atomic_dec(&vtss_kernel_tasks_in_progress);
    vtss_kfree(work);
}

static void vtss_target_dtr(vtss_task_map_item_t *item, void *args)
{
    struct task_struct *task = NULL;
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

    /* Set thread name in case of detach (exit has not been called) */
    if (tskd->taskname[0] == '\0')  {
        task = vtss_find_task_by_tid(tskd->tid);
        if (task != NULL) { /* task exist */
            vtss_get_task_comm(tskd->taskname, task);
            tskd->taskname[VTSS_TASKNAME_SIZE-1] = '\0';
        } else {
            ERROR("%d:%d: Task does not exist", tskd->tid, tskd->pid);
        }
    } else {
        if (strcmp(tskd->taskname, VTSS_RUNSS_NAME) == 0) {
            tskd->taskname[0]='\0';
        }
    }
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
    if (VTSS_IS_NOTIFIER(tskd)) {
        /* If forceful destruction from vtss_task_map_fini() */
        if (vtss_find_task_by_tid(tskd->tid) != NULL) { /* task exist */
            preempt_notifier_unregister(&tskd->preempt_notifier);
            tskd->state &= ~VTSS_ST_NOTIFIER;
            DEBUG_TARGET("unregistered notifier for tid=%d", tskd->tid);
        } else {
            ERROR("%d:%d: Task does not exist", tskd->tid, tskd->pid);
        }
    }
#endif

    /* Finish trace transport */
    atomic_inc(&vtss_transport_busy);
    if (VTSS_TRANSPORT_IS_READY) {
        if (tskd->trnd != NULL) {
            if (tskd->trnd == tskd->trnd_aux)tskd->trnd_aux = NULL;
            if (vtss_record_thread_name(tskd->trnd, tskd->tid, (const char*)tskd->taskname)) {
                WARNING("Failed to record thread name");
            }
            if (vtss_record_thread_stop(tskd->trnd, tskd->tid, tskd->pid, tskd->cpu)) {
                WARNING("Failed to record thread stop");
            }
            if (tskd->trnd_aux && vtss_transport_delref(tskd->trnd_aux) == 0) {
                if (vtss_record_magic(tskd->trnd_aux)) {
                    WARNING("Failed to record magic");
                }
                vtss_transport_complete(tskd->trnd_aux);
            }
            if (vtss_transport_delref(tskd->trnd) == 0) {
                if (vtss_record_process_exit(tskd->trnd, tskd->tid, tskd->pid, tskd->cpu, (const char*)tskd->filename)) {
                    WARNING("Failed to record process exit");
                }
                if (vtss_record_magic(tskd->trnd)) {
                    WARNING("Failed to record magic");
                }
                vtss_transport_complete(tskd->trnd);
            }
            tskd->trnd = NULL;
            tskd->trnd_aux = NULL;
            /* NOTE: tskd->trnd will be destroyed in vtss_transport_fini() */
        }
    }
    atomic_dec(&vtss_transport_busy);

    if (tskd->stk->lost_samples)
        WARNING("%d:%d: Lost %d stack sample(s)", tskd->tid, tskd->pid, tskd->stk->lost_samples);
    if (tskd->stk->trunc_samples > 1)
        REPORT("%d:%d: At least %d stack samples may be truncated", tskd->tid, tskd->pid, tskd->stk->trunc_samples);
    vtss_destroy_stack(tskd->stk);
    vtss_task_data_free_buffers(tskd);
}

static int vtss_target_del(vtss_task_map_item_t *item)
{
    vtss_task_map_del_item(item);
    if (atomic_dec_and_test(&vtss_target_count)) {
        //This function should be called after transport deinitialization
        //vtss_procfs_ctrl_wake_up(NULL, 0);
    }
    return 0;
}

struct vtss_target_new_data
{
    pid_t tid;
    pid_t pid;
    pid_t ppid;

    int fired_tid;
    int fired_order;

    vtss_task_map_item_t *item;
};

int vtss_target_new_part1(pid_t tid, pid_t pid, pid_t ppid, vtss_task_map_item_t *item)
{
    struct task_struct *task;
    struct vtss_task_data *tskd;
    struct vtss_transport_data *trnd = NULL;
    struct vtss_transport_data *trnd_aux = NULL;

    if (!VTSS_COLLECTOR_IS_READY) { // if adding the task is not actual anymore
        return 0;
    }
    tskd = (struct vtss_task_data*)&item->data;
    trnd = tskd->trnd;
    trnd_aux = tskd->trnd_aux;

    if (vtss_task_data_alloc_buffers(tskd)) {
        ERROR("%d:%d: Unable to allocate task buffers", tid, pid);
        return -ENOMEM;
    }
    if (vtss_init_stack(tskd->stk)) {
        ERROR("%d:%d: Unable to initialize stack structure", tid, pid);
        return -1;
    }
    if (vtss_alloc_stack(tskd->stk)) {
        ERROR("%d:%d: Unable to allocate stack structures", tid, pid);
        return -ENOMEM;
    }

    /* Transport initialization */
    if (tskd->tid == tskd->pid) { /* New process */
        if (!trnd) {
            vtss_target_transport_create(&trnd, &trnd_aux, tskd->ppid, tskd->pid, vtss_session_uid, vtss_session_gid);
        }
        if (trnd == NULL) {
            ERROR("%d:%d: Unable to create transport", tid, pid);
            return -ENOMEM;
        }
        tskd->trnd = trnd;
        if (tskd->trnd != NULL) {
            /* if aux transport was not created early, then use the same transport as for samples */
            tskd->trnd_aux = trnd_aux ? trnd_aux : tskd->trnd;
        }
        if (tskd->trnd != NULL && tskd->trnd_aux != NULL) {
            if (vtss_record_configs(VTSS_TRND_CFG(tskd), tskd->m32)) {
                WARNING("Failed to record configs");
            }
            if (vtss_record_process_exec(tskd->trnd, tskd->tid, tskd->pid, tskd->cpu, (const char*)tskd->filename)) {
                WARNING("Failed to record process exec");
            }
        }
        if (strcmp(tskd->filename, VTSS_RUNSS_NAME) != 0) {
            REPORT("Attached to '%s' (pid: %d)", tskd->filename, tskd->pid);
        }
    } else { /* New thread */
        struct vtss_task_data *tskd_main;

        vtss_task_map_item_t *item_main = vtss_task_map_get_item(tskd->pid);
        if (item_main == NULL) {
            ERROR("%d:%d: Unable to find main thread", tskd->tid, tskd->pid);
            return -ENOENT;
        }
        tskd_main = (struct vtss_task_data*)&item_main->data;
        tskd->trnd = tskd_main->trnd;
        tskd->trnd_aux = tskd_main->trnd_aux;
        if (tskd->trnd != NULL) {
            vtss_transport_addref(tskd->trnd);
        }
        if (tskd->trnd != tskd->trnd_aux && tskd->trnd_aux != NULL) {
            vtss_transport_addref(tskd->trnd_aux);
        }
        vtss_task_map_put_item(item_main);
    }
    if (tskd->trnd == NULL) {
        ERROR("%d:%d: Unable to create transport", tskd->tid, tskd->pid);
        return -ENOMEM;
    }

    /* Create cpuevent chain */
    vtss_cpuevents_upload(tskd->cpuevent_chain, &reqcfg.cpuevent_cfg_v1[0], reqcfg.cpuevent_count_v1);

    /* Store first records */
    if (likely(VTSS_NEED_STORE_NEWTASK(tskd)))
        VTSS_STORE_NEWTASK(tskd);
    if (likely(VTSS_NEED_STORE_SOFTCFG(tskd)))
        VTSS_STORE_SOFTCFG(tskd);
    if (likely(VTSS_NEED_STORE_PAUSE(tskd)))
        VTSS_STORE_PAUSE(tskd, tskd->cpu, 0x66 /* tpss_pi___itt_pause from TPSS ini-file */);

    /* Add new item in task map. Tracing starts after this call. */
    if (!vtss_task_map_add_item(item))
        atomic_inc(&vtss_target_count);
    task = vtss_find_task_by_tid(tskd->tid);
    if (task != NULL && !(task->state & TASK_DEAD)) { /* task exist */
#ifdef VTSS_GET_TASK_STRUCT
        vtss_get_task_struct(task);
#endif
        /* Setting up correct arch (32-bit/64-bit) of user application */
        tskd->m32 = test_tsk_thread_flag(task, TIF_IA32) ? 1 : 0;
        vtss_lock_stack(tskd->stk);
        tskd->stk->wow64 = tskd->m32;
        vtss_clear_stack(tskd->stk);
        vtss_unlock_stack(tskd->stk);
#ifdef VTSS_SYSCALL_TRACE
        /* NOTE: Need this for BP save and FIXUP_TOP_OF_STACK into pt_regs
         * when is called from the SYSCALL. Actual only for 64-bit kernel! */
        set_tsk_thread_flag(task, TIF_SYSCALL_TRACE);
#endif
        if (tskd->tid == tskd->pid) { /* New process */
            if (irqs_disabled() || vtss_mmap_all(tskd, task) || vtss_kmap_all(tskd)) {
                /* we have to try load map again */
                vtss_task_map_item_t *item_temp = vtss_task_map_get_item(tskd->tid);
                if (item == item_temp) {
                    DEBUG_TARGET("Map file was not loaded completely. Arranged the task to finish this");
                    atomic_inc(&vtss_kernel_tasks_in_progress);
                    if (vtss_queue_work(-1, vtss_target_add_mmap_work, &item, sizeof(item))) {
                        ERROR("Add mmap work was not arranged");
                        atomic_dec(&vtss_kernel_tasks_in_progress);
                        vtss_task_map_put_item(item_temp);
                    } else {
                        set_tsk_need_resched(current);
                    }
                } else {
                    vtss_task_map_put_item(item_temp);
                    ERROR("Task map error");
                }
            }
        }
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
        /**
         * TODO: add to task, not to current !!!
         * This API will be added in future version of kernel:
         * preempt_notifier_register_task(&tskd->preempt_notifier, task);
         * So far I should use following:
         */
        hlist_add_head(&tskd->preempt_notifier.link, &task->preempt_notifiers);
        tskd->state |= VTSS_ST_NOTIFIER;
        DEBUG_TARGET("registered notifier for tid=%d", tskd->tid);
#endif
#ifdef VTSS_GET_TASK_STRUCT
        vtss_put_task_struct(task);
#endif
    } else {
        ERROR("%d:%d:%d: %s: Doesn't exist or not valid", tskd->tid, tskd->pid, tskd->ppid, tskd->filename);
        vtss_target_del(item);
        return 0;
    }

    return 0;
}

static void vtss_target_new_part2(struct work_struct *work)
{
    struct vtss_work *my_work = (struct vtss_work*)work;
    struct vtss_target_new_data *data = NULL;

    if (!my_work) {
        ERROR("No work data");
        atomic_dec(&vtss_kernel_tasks_in_progress);
        return;
    }

    if (VTSS_COLLECTOR_IS_READY) {
        data = (struct vtss_target_new_data*)(&my_work->data);
        if (!data) {
            ERROR("No data in work");
            goto out;
        }
        if (data->fired_tid != -1) {
            if (!vtss_target_wait_work_time(data->fired_tid, data->fired_order))
                WARNING("Waiting task %d with order %d failed", data->fired_tid, data->fired_order);
        }
        if (VTSS_COLLECTOR_IS_READY) // if adding the task still actual after wait
            vtss_target_new_part1(data->tid, data->pid, data->ppid, data->item);
    }
    vtss_target_remove_from_temp_list(data->tid, 0);

out:
    vtss_task_map_put_item(data->item);
    vtss_kfree(work);
    atomic_dec(&vtss_kernel_tasks_in_progress);
    return;
}

int vtss_target_new(pid_t tid, pid_t pid, pid_t ppid, const char *filename, int fired_tid, int fired_order)
{
    int rc = 0;
    size_t size = 0;
    vtss_task_map_item_t *item = NULL;
    struct vtss_task_data *tskd = NULL;
    struct task_struct *task = NULL;

    DEBUG_TARGET("attaching to %d:%d:%d: %s", tid, pid, ppid, filename);

    if (!VTSS_TRANSPORT_IS_READY) {
        ERROR("%d:%d: Transport not initialized", tid, pid);
        return VTSS_ERR_INTERNAL;
    }

    atomic_inc(&vtss_kernel_tasks_in_progress);

    if (!VTSS_COLLECTOR_IS_READY) { // if adding the task is not actual anymore
        atomic_dec(&vtss_kernel_tasks_in_progress);
        return 0;
    }

    item = vtss_task_map_alloc(tid, sizeof(struct vtss_task_data), vtss_target_dtr);

    if (item == NULL) {
        ERROR("%d:%d: Unable to allocate task data", tid, pid);
        atomic_dec(&vtss_kernel_tasks_in_progress);
        return -ENOMEM;
    }

    tskd = (struct vtss_task_data*)&item->data;
    if (vtss_task_data_init(tskd, tid, pid, ppid)) {
        ERROR("%d:%d: Unable to initialize task structure", tid, pid);
        return -ENOMEM;
    }
    tskd->state = (VTSS_ST_NEWTASK | VTSS_ST_SOFTCFG | VTSS_ST_STKDUMP);
    if (atomic_read(&vtss_collector_state) == VTSS_COLLECTOR_PAUSED)
        tskd->state |= VTSS_ST_PAUSE;
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
    preempt_notifier_init(&tskd->preempt_notifier, &vtss_preempt_ops);
#endif
    task = vtss_find_task_by_tid(tskd->tid);
    if (task != NULL && !(task->state & TASK_DEAD)&&task->comm != NULL) { /* task exist */
        size = min((size_t)VTSS_FILENAME_SIZE-1, (size_t)strnlen(task->comm, TASK_COMM_LEN));
        memcpy(tskd->filename, task->comm, size);
    } else if (filename != NULL) {
        size = min((size_t)VTSS_FILENAME_SIZE-1, (size_t)strlen(filename));
        memcpy(tskd->filename, filename, size);
    }
    tskd->filename[size] = '\0';
    tskd->taskname[0] = '\0';

    if (tid == pid) {
        vtss_target_transport_create(&tskd->trnd, &tskd->trnd_aux, ppid, pid, vtss_session_uid, vtss_session_gid);
    }
    if ((!irqs_disabled() || (tskd->trnd && tskd->trnd_aux))) {
        if (fired_tid != -1) {
            vtss_target_wait_work_time(fired_tid, fired_order);
        }

        rc = vtss_target_new_part1(tid, pid, ppid, item);

        if (task == current /*|| tskd->tid == TASK_TID(current)*/)
        {
            tskd->from_ip = _THIS_IP_;
            vtss_sched_switch_to(item, task, 0);
        }
        vtss_task_map_put_item(item);
        atomic_dec(&vtss_kernel_tasks_in_progress);

    } else {
        struct vtss_target_new_data data;

        data.tid = tid;
        data.pid = pid;
        data.ppid = ppid;

        data.fired_tid = fired_tid;
        data.fired_order = fired_order;
        data.item = item;

        vtss_target_add_to_temp_list(data.tid);

        if ((rc = vtss_queue_work(-1, vtss_target_new_part2, &data, sizeof(data)))) {
            vtss_task_map_put_item(item);
            atomic_dec(&vtss_kernel_tasks_in_progress);
            vtss_target_remove_from_temp_list(data.tid, 1);
        } else {
            set_tsk_need_resched(current);
        }
    }
    return rc;
}

void vtss_target_fork(struct task_struct *task, struct task_struct *child)
{
    if (!VTSS_COLLECTOR_IS_READY) {
        DEBUG_TARGET("Collector is not ready: state: %d, tid: %d", VTSS_COLLECTOR_STATE(), child ? TASK_TID(child) : -1);
        return;
    }
    if (task != NULL && child != NULL) {
        int fired_order = -1;
        vtss_task_map_item_t *item = NULL;

        fired_order = vtss_target_find_in_temp_list(TASK_TID(task));
        if (fired_order != -1) {
            vtss_target_new(TASK_TID(child), TASK_PID(child), TASK_TID(task), task->comm, TASK_TID(task), fired_order);
        } else {
            item = vtss_task_map_get_item(TASK_TID(task));
        }
        if (item) {
            struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

            preempt_disable();
            tskd->cpu = smp_processor_id();
            preempt_enable_no_resched();
            {
                int rc = 0;
                rc = vtss_target_new(TASK_TID(child), TASK_PID(child), TASK_PID(task), tskd->filename, -1, -1);
                if (unlikely(rc)) ERROR("%d:%d: Fork failed", TASK_TID(task), TASK_PID(task));
            }
            vtss_task_map_put_item(item);
        }
    }
}

void vtss_target_exec_enter(struct task_struct *task, const char *filename)
{
    vtss_task_map_item_t *item;
    int fired_order = -1;

    vtss_profiling_pause();
    if (!VTSS_COLLECTOR_IS_READY) {
        DEBUG_TARGET("Collector is not ready: state: %d, tid: %d", VTSS_COLLECTOR_STATE(), task ? TASK_TID(task) : -1);
        return;
    }
    if (!VTSS_TRANSPORT_IS_READY) {
        ERROR("Transport is not ready");
        return;
    }
    fired_order = vtss_target_find_in_temp_list(TASK_TID(task));
    if (fired_order != -1)
        vtss_target_wait_work_time(TASK_TID(task), fired_order);
    item = vtss_task_map_get_item(TASK_TID(task));
    if (item != NULL) {
        struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

#ifdef VTSS_USE_PREEMPT_NOTIFIERS
        if (VTSS_IS_NOTIFIER(tskd)) {
            preempt_notifier_unregister(&tskd->preempt_notifier);
            tskd->state &= ~VTSS_ST_NOTIFIER;
            DEBUG_TARGET("unregistered notifier for tid=%d", tskd->tid);
        }
#endif
        if (task != NULL) {
            // The lines below leads a bug when thread name is shown as amplxe-runss.
            // We need fix it in GUI part before.
            strncpy(tskd->taskname, task->comm, VTSS_TASKNAME_SIZE-1);
        }
        tskd->taskname[VTSS_TASKNAME_SIZE-1] = '\0';
        tskd->state |= VTSS_ST_COMPLETE;
        vtss_task_map_put_item(item);
    }
}

void vtss_target_exec_leave(struct task_struct *task, const char *filename, int rc, int fired_tid)
{
    vtss_task_map_item_t *item = NULL;
    int fired_order = -1;

    if (!VTSS_COLLECTOR_IS_READY) {
        DEBUG_TARGET("Collector is not ready: state: %d, tid: %d", VTSS_COLLECTOR_STATE(), task ? TASK_TID(task) : -1);
        return;
    }
    fired_order = vtss_target_find_in_temp_list(fired_tid);
    if (fired_order != -1) {
        if (rc == 0) vtss_target_new(TASK_TID(task), TASK_PID(task), TASK_PID(TASK_PARENT(task)), filename, fired_tid, fired_order);
    } else {
        item = vtss_task_map_get_item(fired_tid);
    }
    if (item) {
        struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

        if (rc == 0) { /* Execution success, so start tracing new process */

            preempt_disable();
            tskd->cpu = smp_processor_id();
            preempt_enable_no_resched();
            vtss_target_new(TASK_TID(task), TASK_PID(task), TASK_PID(TASK_PARENT(task)), filename, -1, -1);

        } else { /* Execution failed, so restore tracing current process */
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
            /**
             * TODO: add to task, not to current !!!
             * This API will be added in future version of kernel:
             * preempt_notifier_register_task(&tskd->preempt_notifier, task);
             * So far I should use following:
             */
            hlist_add_head(&tskd->preempt_notifier.link, &task->preempt_notifiers);
            tskd->state |= VTSS_ST_NOTIFIER;
            DEBUG_TARGET("registered notifier for tid=%d", tskd->tid);
#endif
            tskd->state &= ~VTSS_ST_COMPLETE;
            tskd->state |= VTSS_ST_PMU_SET;
        }
        vtss_task_map_put_item(item);
    }
}

static void vtss_target_dump_ipt(struct vtss_task_data *tskd)
{
    unsigned long flags;

    local_irq_save(flags);
    preempt_disable();
    if (VTSS_IN_CONTEXT(tskd)) {
        if (unlikely((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) && (reqcfg.ipt_cfg.mode & vtss_iptmode_full))) {
            vtss_dump_ipt(VTSS_TRND_REG(tskd), tskd->tid, tskd->cpu, &tskd->is_ipt_trace_ovf);
        }
    }
    preempt_enable_no_resched();
    local_irq_restore(flags);
}

void vtss_target_exit(struct task_struct *task)
{
    vtss_task_map_item_t *item = NULL;
    int fired_order = -1;

    vtss_profiling_pause();

    fired_order = vtss_target_find_in_temp_list(TASK_TID(task));
    if (fired_order != -1)
        vtss_target_wait_work_time(TASK_TID(task), fired_order);
    item = vtss_task_map_get_item(TASK_TID(task));

    if (item != NULL) {
        struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
        if (!tskd) {
            ERROR("No task data");
        }
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
        if (VTSS_IS_NOTIFIER(tskd)) {
            preempt_notifier_unregister(&tskd->preempt_notifier);
            tskd->state &= ~VTSS_ST_NOTIFIER;
        }
#endif
        vtss_target_dump_ipt(tskd);
        tskd->cpu = raw_smp_processor_id();
        tskd->state |= VTSS_ST_COMPLETE;
        vtss_target_dump_ipt(tskd);
        if (task != NULL) {
            strncpy(tskd->taskname, task->comm, VTSS_TASKNAME_SIZE-1);
        }
        tskd->taskname[VTSS_TASKNAME_SIZE-1] = '\0';
        vtss_target_del(item);
        vtss_task_map_put_item(item);
    }
}

#ifdef VTSS_SYSCALL_TRACE

static struct vtss_task_data *vtss_wait_for_completion(vtss_task_map_item_t **pitem)
{
    unsigned long i;
    struct vtss_task_data *tskd = (struct vtss_task_data*)&((*pitem)->data);

    /* It's task after exec(), so waiting for re-initialization */
    DEBUG_TARGET("Waiting task: 0x%p", current);
    for (i = 0; i < 1000000UL && *pitem != NULL && atomic_read(&vtss_collector_state) == VTSS_COLLECTOR_RUNNING; i++) {
        vtss_task_map_put_item(*pitem);
        *pitem = vtss_task_map_get_item(TASK_TID(current));
        if (*pitem != NULL) {
            tskd = (struct vtss_task_data*)&((*pitem)->data);
            if (!VTSS_IS_COMPLETE(tskd))
                break;
        }
    }
    DEBUG_TARGET("Waiting task: 0x%p: done(%lu)", current, i);
    if (*pitem == NULL) {
        ERROR("Tracing task 0x%p error", current);
        return NULL;
    } else if (VTSS_IS_COMPLETE(tskd)) {
        DEBUG_TARGET("Task 0x%p wait timeout", current);
        vtss_task_map_put_item(*pitem);
        return NULL;
    }
    return tskd;
}

void vtss_syscall_enter(struct pt_regs *regs)
{
    vtss_task_map_item_t *item = vtss_task_map_get_item(TASK_TID(current));

    if (item != NULL) {
        struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

        DEBUG_TARGET("task=0x%p, syscall=%.3ld, ip=0x%lx, sp=0x%lx, bp=0x%lx",
            current, REG(orig_ax, regs), REG(ip, regs), REG(sp, regs), REG(bp, regs));
        if (unlikely(VTSS_IS_COMPLETE(tskd)))
            tskd = vtss_wait_for_completion(&item);
        if (tskd != NULL) {
            /* Just store BP register for following unwinding */
            tskd->syscall_sp = (void*)REG(sp, regs);
            tskd->syscall_enter = (atomic_read(&vtss_collector_state) == VTSS_COLLECTOR_RUNNING) ? vtss_time_cpu() : 0ULL;
            tskd->state |= VTSS_ST_IN_SYSCALL;
            vtss_task_map_put_item(item);
        }
    }
}

void vtss_syscall_leave(struct pt_regs *regs)
{
    vtss_task_map_item_t *item = vtss_task_map_get_item(TASK_TID(current));

    if (item != NULL) {
        struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

        DEBUG_TARGET("task=0x%p, syscall=%.3ld, ip=0x%lx, sp=0x%lx, bp=0x%lx, ax=0x%lx",
            current, REG(orig_ax, regs), REG(ip, regs), REG(sp, regs), REG(bp, regs), REG(ax, regs));
        tskd->state &= ~VTSS_ST_IN_SYSCALL;
        tskd->syscall_sp = NULL;
        vtss_task_map_put_item(item);
    }
}

#endif

