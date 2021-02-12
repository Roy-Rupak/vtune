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
#include "sched.h"
#include "task_data.h"
#include "task_util.h"
#include "cmd.h"
#include "record.h"
#include "stack.h"
#include "pmi.h"
#include "ipt.h"
#include "regs.h"

#ifdef VTSS_USE_PREEMPT_NOTIFIERS
static void vtss_notifier_sched_in (struct preempt_notifier *notifier, int cpu);
static void vtss_notifier_sched_out(struct preempt_notifier *notifier, struct task_struct *next);

struct preempt_ops vtss_preempt_ops = {
    .sched_in  = vtss_notifier_sched_in,
    .sched_out = vtss_notifier_sched_out
};
#endif

void vtss_sched_switch_from(vtss_task_map_item_t *item, struct task_struct *task, unsigned long bp, unsigned long ip)
{
    unsigned long flags;
    int state = atomic_read(&vtss_collector_state);
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
    int is_preempt = (task->state == TASK_RUNNING) ? 1 : 0;
    int cpu;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    if (unlikely(!vtss_cpu_active(cpu) || VTSS_IS_COMPLETE(tskd))) {
        vtss_profiling_pause();
        tskd->state &= ~VTSS_ST_PMU_SET;
        return;
    }

    local_irq_save(flags);
    preempt_disable();
    vtss_lbr_disable_save(tskd->lbr);
    /* read and freeze cpu counters if ... */
    if (likely((state == VTSS_COLLECTOR_RUNNING || VTSS_IN_CONTEXT(tskd)) &&
        VTSS_IS_PMU_SET(tskd))) {
        vtss_cpuevents_sample(tskd->cpuevent_chain);
        if ((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) && (reqcfg.ipt_cfg.mode & vtss_iptmode_full)) {
            vtss_dump_ipt(VTSS_TRND_REG(tskd), tskd->tid, tskd->cpu, &tskd->is_ipt_trace_ovf);
        }
    }
    tskd->state &= ~VTSS_ST_PMU_SET;

    /* update and restart system counters */
    vtss_cpuevents_quantum_border(tskd->cpuevent_chain,
        (state == VTSS_COLLECTOR_RUNNING || VTSS_IN_CONTEXT(tskd)) ?
        (is_preempt ? 2 : 3) : (is_preempt ? -2 : -3));

    /* store swap-out record */
    if (ip) tskd->from_ip = ip;
    if (likely(VTSS_IN_CONTEXT(tskd))) {
        if (VTSS_ALWAYS_STORE_CTX || (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX)) {
            VTSS_STORE_SWAPOUT(tskd, is_preempt);
        }
        else {
            tskd->state &= ~VTSS_ST_SWAPOUT;
        }
        /* exit from context */
        tskd->state &= ~VTSS_ST_IN_CONTEXT;
    }
    /* collect stack */
    if (likely(reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX)) {
        vtss_dump_stack(tskd, task, NULL, bp);
    }
    preempt_enable_no_resched();
    local_irq_restore(flags);
}

void vtss_sched_switch_to(vtss_task_map_item_t *item, struct task_struct *task, unsigned long ip)
{
    int cpu;
    unsigned long flags;
    int state = atomic_read(&vtss_collector_state);
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    if (unlikely(!vtss_cpu_active(cpu) || VTSS_IS_COMPLETE(tskd))) {
        vtss_profiling_pause();
        tskd->state &= ~VTSS_ST_PMU_SET;
        return;
    }
    local_irq_save(flags);
    preempt_disable();

    /* update and restart system counters */
    vtss_cpuevents_quantum_border(tskd->cpuevent_chain,
        (state == VTSS_COLLECTOR_RUNNING) ? 1 : -1);

    if (unlikely(VTSS_NEED_STORE_NEWTASK(tskd)))
        VTSS_STORE_NEWTASK(tskd);
    if (unlikely(VTSS_NEED_STORE_SOFTCFG(tskd)))
        VTSS_STORE_SOFTCFG(tskd);
    if (unlikely(VTSS_NEED_STORE_PAUSE(tskd)))
        VTSS_STORE_PAUSE(tskd, tskd->cpu, 0x66 /* tpss_pi___itt_pause from TPSS ini-file */);

    if (likely(VTSS_IN_NEWTASK(tskd))) {
        /* enter in context for the task */
        if (likely(!VTSS_IN_CONTEXT(tskd) &&
            state == VTSS_COLLECTOR_RUNNING))
        {
            if (!ip)
                ip = tskd->from_ip;
            /* use user IP if no stacks on context switches */
            if (!ip || !(reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX))
                ip = KSTK_EIP(task);
            if (VTSS_ALWAYS_STORE_CTX || (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX)) {
                if (reqcfg.cpuevent_count_v1 != 0) VTSS_STORE_SAMPLE(tskd, tskd->cpu, NULL);
                VTSS_STORE_SWAPIN(tskd, cpu, (void*)ip);
            } else {
                if (reqcfg.cpuevent_count_v1 != 0) VTSS_STORE_SAMPLE(tskd, tskd->cpu, (void*)ip);
                tskd->state &= ~VTSS_ST_SWAPIN;
            }

            tskd->state |= VTSS_ST_IN_CONTEXT;
            tskd->cpu = cpu;

            if (unlikely(!VTSS_NEED_STACK_SAVE(tskd))) {
                if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX) {
                    vtss_dump_stack(tskd, task, NULL, 0);
                }
            }
            /* store previously collected stack */
            if (likely(VTSS_NEED_STACK_SAVE(tskd) &&
                (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_STACKS) &&
                !vtss_transport_is_overflowing(tskd->trnd) &&
                vtss_trylock_stack(tskd->stk)))
            {
                VTSS_STACK_SAVE(tskd);
                vtss_unlock_stack(tskd->stk);
            }
        }
    } else {
        tskd->state |= VTSS_ST_SWAPIN;
    }
    tskd->state |= VTSS_ST_CPUEVT;
    vtss_profiling_resume(item, 0);
    preempt_enable_no_resched();
    local_irq_restore(flags);
}

#ifdef VTSS_USE_PREEMPT_NOTIFIERS

static void vtss_notifier_sched_out(struct preempt_notifier *notifier, struct task_struct *next)
{
    vtss_task_map_item_t *item;

    vtss_profiling_pause();
    item = vtss_task_map_get_item(TASK_TID(current));
    if (item != NULL) {
        unsigned long bp = vtss_read_rbp();
        vtss_sched_switch_from(item, current, bp, 0);
        vtss_task_map_put_item(item);
    }
}

static void vtss_notifier_sched_in(struct preempt_notifier *notifier, int cpu)
{
    vtss_task_map_item_t *item = vtss_task_map_get_item(TASK_TID(current));

    if (item != NULL) {
        vtss_sched_switch_to(item, current, _THIS_IP_);
        vtss_task_map_put_item(item);
    } else {
        vtss_profiling_pause();
    }
}

#endif

void vtss_sched_switch(struct task_struct *prev, struct task_struct *next, unsigned long prev_bp, unsigned long prev_ip)
{
    vtss_task_map_item_t *item;

    vtss_profiling_pause();
    item = vtss_task_map_get_item(TASK_TID(prev));
    if (item != NULL) {
        vtss_sched_switch_from(item, prev, prev_bp, prev_ip);
        vtss_task_map_put_item(item);
    }
    item = vtss_task_map_get_item(TASK_TID(next));
    if (item != NULL) {
        vtss_sched_switch_to(item, next, 0);
        vtss_task_map_put_item(item);
    }
}
