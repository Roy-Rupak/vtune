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
#include "cmd.h"
#include "cpuevents.h"
#include "task_data.h"
#include "task_util.h"
#include "task_map.h"
#include "mmap.h"
#include "stack.h"
#include "record.h"
#include "dsa.h"
#include "bts.h"
#include "ipt.h"
#include "lbr.h"
#include "pebs.h"
#include "regs.h"
#include "time.h"

#include <asm/apic.h>

atomic_t vtss_events_enabling = ATOMIC_INIT(0);

static inline int vtss_is_branch_overflow(struct vtss_task_data *tskd)
{
    int i;
    int f = 0;

    cpuevent_t *event;
    event = (cpuevent_t*)tskd->cpuevent_chain;
    if (!event) {
        return 0;
    }
    for (i = 0; i < VTSS_CFG_CHAIN_SIZE; i++)
    {
        if (!event[i].valid) {
            break;
        }
        if ((event[i].selmsk & 0xff) == 0xc4) {
            f = 1;
            if (event[i].vft->overflowed(&event[i]))
            {
                return 1;
            }
        }
    }
    if (f) {
        return 0;
    }
    return 1;
}

static inline int vtss_is_bts_enable(struct vtss_task_data *tskd)
{
    return ((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_BRANCH) && vtss_is_branch_overflow(tskd));
}

static inline int vtss_is_callcount_enable(struct vtss_task_data *tskd)
{
    return ((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) || vtss_is_bts_enable(tskd));
}

static void vtss_callcount_disable(void)
{
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) vtss_disable_ipt();
    else vtss_bts_disable();
}

static void vtss_callcount_enable(void)
{
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) vtss_enable_ipt(reqcfg.ipt_cfg.mode, 0);
    else vtss_bts_enable();
}

static int vtss_is_callcount_overflowed(void)
{
    int cpu;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) return vtss_has_ipt_overflowed();
    return vtss_bts_overflowed(cpu);
}

void vtss_profiling_pause(void)
{
    unsigned long flags;

    local_irq_save(flags);
    vtss_callcount_disable();
    vtss_pebs_disable();
    vtss_cpuevents_freeze();
    vtss_lbr_disable();
    local_irq_restore(flags);
}

void vtss_profiling_resume(vtss_task_map_item_t *item, int bts_resume)
{
    int trace_flags = reqcfg.trace_cfg.trace_flags;
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
    int cpu;

    cpu = raw_smp_processor_id();

    tskd->state &= ~VTSS_ST_PMU_SET;

    atomic_inc(&vtss_transport_busy);
    if (!VTSS_TRANSPORT_IS_READY) {
        vtss_profiling_pause();
        atomic_dec(&vtss_transport_busy);
        return;
    }

    if (unlikely(!vtss_cpu_active(cpu) || VTSS_IS_COMPLETE(tskd))) {
        vtss_profiling_pause();
        atomic_dec(&vtss_transport_busy);
        return;
    }
    atomic_inc(&vtss_events_enabling);

    if (atomic_read(&vtss_collector_state) != VTSS_COLLECTOR_RUNNING) {
        vtss_profiling_pause();
        atomic_dec(&vtss_events_enabling);
        atomic_dec(&vtss_transport_busy);
        return;
    }
    atomic_dec(&vtss_transport_busy);

    /* clear BTS/PEBS buffers */
    vtss_bts_init_dsa();
    vtss_pebs_init_dsa();
    vtss_dsa_init_cpu();
    /* always enable PEBS */
    vtss_pebs_enable();
    if (likely(VTSS_IS_CPUEVT(tskd))) {
        /* enable BTS (if requested) */
        if (vtss_is_callcount_enable(tskd) && (bts_resume  || (reqcfg.ipt_cfg.mode & vtss_iptmode_full)))
            vtss_callcount_enable();
        /* enable LBR (if requested) */
        if (trace_flags & VTSS_CFGTRACE_LASTBR)
            vtss_lbr_enable(tskd->lbr);
        /* restart PMU events */
        vtss_cpuevents_restart(tskd->cpuevent_chain, 0);
    } else {
        /* enable LBR (if requested) */
        if (trace_flags & VTSS_CFGTRACE_LASTBR)
            vtss_lbr_enable(tskd->lbr);
        /* This need for Woodcrest and Clovertown */
        vtss_cpuevents_enable();
    }
    atomic_dec(&vtss_events_enabling);
    tskd->state |= VTSS_ST_PMU_SET;
    tskd->state &= ~VTSS_ST_CPUEVT;
}

void vtss_dump_stack(struct vtss_task_data *tskd, struct task_struct *task, struct pt_regs *regs, unsigned long bp)
{
    if (task != current) {
        return;
    }
    if (likely(!VTSS_IS_COMPLETE(tskd) &&
        (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_STACKS) &&
        VTSS_IS_VALID_TASK(task) &&
        vtss_trylock_stack(tskd->stk)))
    {
        unsigned long reg_bp;
        reg_bp = regs ? REG(bp, regs) : bp;
        if (!reg_bp && task == current) {
            reg_bp = vtss_read_rbp();
        }
        /* clear stack history if stack was not stored in the trace */
        if (unlikely(VTSS_NEED_STACK_SAVE(tskd)))
            vtss_clear_stack(tskd->stk);
        VTSS_STACK_DUMP(tskd, task, regs, reg_bp);

        if (likely(!VTSS_ERROR_STACK_DUMP(tskd))) {
            tskd->state |= VTSS_ST_STKSAVE;
        } else {
            vtss_clear_stack(tskd->stk);
        }
        vtss_unlock_stack(tskd->stk);
    }
}

static void vtss_pmi_dump(struct pt_regs *regs, vtss_task_map_item_t *item, int is_bts_overflowed)
{
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
    int cpu;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    VTSS_STORE_STATE(tskd, !is_bts_overflowed, VTSS_ST_CPUEVT);
    if (likely(VTSS_IS_CPUEVT(tskd))) {
        /* fetch PEBS.IP, if available, or continue as usual */
        vtss_pebs_t *pebs = vtss_pebs_get(cpu);
        if (pebs != NULL) {
            if (vtss_pebs_version() == 3) {
                tskd->ip = (void*)((size_t)pebs->v3.eventing_ip);
            } else {
                tskd->ip = (void*)((size_t)pebs->v1.ip);
            }
        } else
            tskd->ip = (void*)instruction_pointer(regs);
        if (likely(VTSS_IS_PMU_SET(tskd))) {
            vtss_cpuevents_sample(tskd->cpuevent_chain);
            tskd->state &= ~VTSS_ST_PMU_SET;
        }
    }
#ifndef VTSS_NO_BTS
    /* dump trailing BTS buffers */
    if (unlikely(reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_BRANCH)) {
        tskd->bts_size = vtss_bts_dump(tskd->bts_buffer);
        vtss_bts_disable();
    }
    else if (unlikely(reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT)) {
        vtss_disable_ipt();
    }
#endif
}

static void vtss_pmi_record(struct pt_regs *regs, vtss_task_map_item_t *item, int is_bts_overflowed)
{
    int cpu;
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    if (unlikely(VTSS_NEED_STORE_NEWTASK(tskd)))
        VTSS_STORE_NEWTASK(tskd);
    if (unlikely(VTSS_NEED_STORE_SOFTCFG(tskd)))
        VTSS_STORE_SOFTCFG(tskd);
    if (unlikely(VTSS_NEED_STORE_PAUSE(tskd)))
        VTSS_STORE_PAUSE(tskd, tskd->cpu, 0x66 /* tpss_pi___itt_pause from TPSS ini-file */);

    if (likely(VTSS_IN_NEWTASK(tskd))) {
        /* enter in context for the task if error was */
        if (unlikely(!VTSS_IN_CONTEXT(tskd) &&
            VTSS_ERROR_STORE_SWAPIN(tskd) &&
            atomic_read(&vtss_collector_state) == VTSS_COLLECTOR_RUNNING))
        {
            if (VTSS_ALWAYS_STORE_CTX || (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX)) {
                VTSS_STORE_SWAPIN(tskd, cpu, (void*)instruction_pointer(regs));
            }
            else {
                tskd->state &= ~VTSS_ST_SWAPIN;
            }

            if (likely(!VTSS_ERROR_STORE_SWAPIN(tskd))) {
                tskd->state |= VTSS_ST_IN_CONTEXT;
                tskd->cpu = cpu;
                if (unlikely(VTSS_NEED_STACK_SAVE(tskd) &&
                    (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CTX) &&
                    (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_STACKS) &&
                    !vtss_transport_is_overflowing(tskd->trnd) &&
                    vtss_trylock_stack(tskd->stk)))
                {
                    VTSS_STACK_SAVE(tskd);
                    vtss_unlock_stack(tskd->stk);
                }
            }
        }
    }
    else {
        tskd->state |= VTSS_ST_SWAPIN;
    }
    if (likely(VTSS_IN_CONTEXT(tskd))) {
#ifndef VTSS_NO_BTS
        if (!is_bts_overflowed)
        {
            if (unlikely (tskd->bts_size)) {
                vtss_record_bts(tskd->trnd, tskd->tid, tskd->cpu, tskd->bts_buffer, tskd->bts_size);
                tskd->bts_size = 0;
            }
        }
#endif
        if (unlikely((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) &&
            !VTSS_ERROR_STORE_SAMPLE(tskd) &&
            !(VTSS_ERROR_STACK_DUMP(tskd) && (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_STACKS)) &&
            !VTSS_ERROR_STACK_SAVE(tskd)))
        {
            vtss_dump_ipt(VTSS_TRND_REG(tskd), tskd->tid, tskd->cpu, &tskd->is_ipt_trace_ovf);
        }

        /* store sample and its stack */
        if (likely(VTSS_IS_CPUEVT(tskd)))
        {
            void *ip = VTSS_ERROR_STORE_SAMPLE(tskd) ? (void*)VTSS_EVENT_LOST_MODULE_ADDR : tskd->ip;

            VTSS_STORE_SAMPLE(tskd, tskd->cpu, ip);

            if (likely(!VTSS_ERROR_STORE_SAMPLE(tskd)))
            {
                vtss_dump_stack(tskd, current, regs, 0);
                if (likely(VTSS_NEED_STACK_SAVE(tskd) &&
                    (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_STACKS) &&
                    !vtss_transport_is_overflowing(tskd->trnd) &&
                    vtss_trylock_stack(tskd->stk)))
                {
                    VTSS_STACK_SAVE(tskd);
                    vtss_unlock_stack(tskd->stk);
                }
            }
        }
#ifndef VTSS_NO_BTS
        if (unlikely(is_bts_overflowed && tskd->bts_size &&
            !(reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) &&
            (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_BRANCH) &&
            !VTSS_ERROR_STORE_SAMPLE(tskd) &&
            !(VTSS_ERROR_STACK_DUMP(tskd) && (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_STACKS)) &&
            !VTSS_ERROR_STACK_SAVE(tskd)))
        {
            vtss_record_bts(tskd->trnd, tskd->tid, tskd->cpu, tskd->bts_buffer, tskd->bts_size);
            tskd->bts_size = 0;
        }
#endif
    }
}

/* unmask PMI */
void vtss_pmi_enable(void)
{
    apic_write(APIC_LVTPC, APIC_DM_NMI);
}

/* mask PMI */
void vtss_pmi_disable(void)
{
}

/**
 * CPU event counter overflow handler and BTS/PEBS buffer overflow handler
 * sample counter values, form the trace record
 * select a new mux group (if applicable)
 * program event counters
 * NOTE: LBR/BTS/PEBS is already disabled in vtss_perfvec_handler()
 */
asmlinkage void vtss_pmi_handler(struct pt_regs *regs)
{
    unsigned long flags = 0;
    int is_bts_overflowed = 0;
    int bts_enable = 0;
    vtss_task_map_item_t *item = NULL;

    local_irq_save(flags);
    preempt_disable();
#ifndef VTSS_NO_BTS
    is_bts_overflowed = vtss_is_callcount_overflowed();
#endif
    if (likely(!is_bts_overflowed))
        vtss_cpuevents_freeze();
    if (likely(VTSS_IS_VALID_TASK(current)))
        item = vtss_task_map_get_item(TASK_TID(current));
    if (likely(item != NULL)) {
        struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
        bts_enable = vtss_is_callcount_enable(tskd);
        vtss_pmi_dump(regs, item, is_bts_overflowed);
    } else {
        vtss_profiling_pause();
    }
    vtss_pmi_enable();
    if (likely(item != NULL)) {
        vtss_pmi_record(regs, item, is_bts_overflowed);
        vtss_profiling_resume(item, bts_enable);
        vtss_task_map_put_item(item);
    }
    preempt_enable_no_resched();
    local_irq_restore(flags);
}
