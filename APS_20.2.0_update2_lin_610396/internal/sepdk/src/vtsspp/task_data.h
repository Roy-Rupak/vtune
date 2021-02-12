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
#ifndef _VTSS_TASK_DATA_H_
#define _VTSS_TASK_DATA_H_

#include "config.h"
#include "cpuevents.h"
#include "transport.h"
#include "unwind.h"
#include "bts.h"
#include "lbr.h"

#ifdef VTSS_USE_PREEMPT_NOTIFIERS
#include <linux/preempt.h>
#endif

#define VTSS_ST_NEWTASK    (1<<0)
#define VTSS_ST_SOFTCFG    (1<<1)
#define VTSS_ST_SWAPIN     (1<<2)
#define VTSS_ST_SWAPOUT    (1<<3)
#define VTSS_ST_SAMPLE     (1<<4)
#define VTSS_ST_STKDUMP    (1<<5)
#define VTSS_ST_STKSAVE    (1<<6)
#define VTSS_ST_PAUSE      (1<<7)
#define VTSS_ST_IN_CONTEXT (1<<8)
#define VTSS_ST_IN_SYSCALL (1<<9)
#define VTSS_ST_CPUEVT     (1<<10)
#define VTSS_ST_COMPLETE   (1<<11)
#define VTSS_ST_NOTIFIER   (1<<12)
#define VTSS_ST_PMU_SET    (1<<13)
#define VTSS_ST_MMAP_INIT  (1<<14)

#define VTSS_IN_CONTEXT(tskd)            ((tskd)->state & VTSS_ST_IN_CONTEXT)
#define VTSS_IN_SYSCALL(tskd)            ((tskd)->state & VTSS_ST_IN_SYSCALL)
#define VTSS_IN_NEWTASK(tskd)            (!((tskd)->state & (VTSS_ST_NEWTASK | VTSS_ST_SOFTCFG)))
#define VTSS_IS_CPUEVT(tskd)             ((tskd)->state & VTSS_ST_CPUEVT)
#define VTSS_IS_COMPLETE(tskd)           ((tskd)->state & VTSS_ST_COMPLETE)
#define VTSS_IS_NOTIFIER(tskd)           ((tskd)->state & VTSS_ST_NOTIFIER)
#define VTSS_IS_PMU_SET(tskd)            ((tskd)->state & VTSS_ST_PMU_SET)

#define VTSS_IS_MMAP_INIT(tskd)          ((tskd)->state & VTSS_ST_MMAP_INIT)
#define VTSS_SET_MMAP_INIT(tskd)         (tskd)->state |= VTSS_ST_MMAP_INIT
#define VTSS_CLEAR_MMAP_INIT(tskd)       (tskd)->state &= ~VTSS_ST_MMAP_INIT

#define VTSS_NEED_STORE_NEWTASK(tskd)    ((tskd)->state & VTSS_ST_NEWTASK)
#define VTSS_NEED_STORE_SOFTCFG(tskd)    (((tskd)->state & (VTSS_ST_NEWTASK | VTSS_ST_SOFTCFG)) == VTSS_ST_SOFTCFG)
#define VTSS_NEED_STORE_PAUSE(tskd)      ((((tskd)->state & (VTSS_ST_NEWTASK | VTSS_ST_SOFTCFG | VTSS_ST_PAUSE)) == VTSS_ST_PAUSE) && (atomic_read(&vtss_collector_state)== VTSS_COLLECTOR_PAUSED))
#define VTSS_NEED_STACK_SAVE(tskd)       (((tskd)->state & (VTSS_ST_STKDUMP | VTSS_ST_STKSAVE)) == VTSS_ST_STKSAVE)

#define VTSS_ERROR_STORE_SAMPLE(tskd)    ((tskd)->state & VTSS_ST_SAMPLE)
#define VTSS_ERROR_STORE_SWAPIN(tskd)    ((tskd)->state & VTSS_ST_SWAPIN)
#define VTSS_ERROR_STORE_SWAPOUT(tskd)   ((tskd)->state & VTSS_ST_SWAPOUT)
#define VTSS_ERROR_STACK_DUMP(tskd)      ((tskd)->state & VTSS_ST_STKDUMP)
#define VTSS_ERROR_STACK_SAVE(tskd)      ((tskd)->state & VTSS_ST_STKSAVE)

#define VTSS_TRND_REG(tskd) (VTSS_RB_MODE ? (tskd)->trnd_aux : (tskd)->trnd)
#define VTSS_TRND_CFG(tskd) (VTSS_RB_MODE ? (tskd)->trnd : (tskd)->trnd_aux)

#define VTSS_STORE_STATE(tskd, rc, st) ((tskd)->state = (rc) ? (tskd)->state | (st) : (tskd)->state & ~(st))

#define VTSS_STORE_NEWTASK(tskd)       VTSS_STORE_STATE((tskd), vtss_record_thread_create((tskd)->trnd, (tskd)->tid, (tskd)->pid, (tskd)->cpu), VTSS_ST_NEWTASK)
#define VTSS_STORE_SOFTCFG(tskd)       VTSS_STORE_STATE((tskd), vtss_record_softcfg((tskd)->trnd, (tskd)->tid), VTSS_ST_SOFTCFG)
#define VTSS_STORE_PAUSE(tskd, cpu, i) VTSS_STORE_STATE((tskd), vtss_record_probe((tskd)->trnd, (cpu), (i)), VTSS_ST_PAUSE)

#define VTSS_STORE_SAMPLE(tskd, cpu, ip) VTSS_STORE_STATE((tskd), vtss_record_sample(VTSS_TRND_REG(tskd), (tskd)->tid, (cpu), (tskd)->cpuevent_chain, (ip)), VTSS_ST_SAMPLE)
#define VTSS_STORE_SWAPIN(tskd, cpu, ip) VTSS_STORE_STATE((tskd), vtss_record_switch_to(VTSS_TRND_REG(tskd), (tskd)->tid, (cpu), (ip)), VTSS_ST_SWAPIN)
#define VTSS_STORE_SWAPOUT(tskd, p)      VTSS_STORE_STATE((tskd), vtss_record_switch_from(VTSS_TRND_REG(tskd), (tskd)->cpu, (p)), VTSS_ST_SWAPOUT)

#define VTSS_STACK_DUMP(tskd, t, r, bp) VTSS_STORE_STATE((tskd), vtss_stack_dump(VTSS_TRND_REG(tskd), (tskd)->stk, (t), (r), (bp)), VTSS_ST_STKDUMP)
#define VTSS_STACK_SAVE(tskd)           VTSS_STORE_STATE((tskd), vtss_stack_record(VTSS_TRND_REG(tskd), (tskd)->stk, (tskd)->tid, (tskd)->cpu), VTSS_ST_STKSAVE)

struct vtss_task_data
{
    stack_control_t *stk;
    lbr_control_t   *lbr;
    struct vtss_transport_data *trnd;
    struct vtss_transport_data *trnd_aux;
#ifdef VTSS_USE_PREEMPT_NOTIFIERS
    struct preempt_notifier preempt_notifier;
#endif
    unsigned int     state;
    int              m32;
    pid_t            tid;
    pid_t            pid;
    pid_t            ppid;
    unsigned int     cpu;
    void            *ip;
#ifndef VTSS_NO_BTS
    unsigned short   bts_size;
    unsigned char   *bts_buffer;
#endif
    int              is_ipt_trace_ovf;
    char             filename[VTSS_FILENAME_SIZE];
    char             taskname[VTSS_TASKNAME_SIZE];
    cpuevent_t      *cpuevent_chain;
    unsigned long    from_ip;
#ifdef VTSS_SYSCALL_TRACE
    void               *syscall_sp;
    unsigned long long  syscall_enter;
#endif
};

int vtss_task_data_init(struct vtss_task_data *tskd, pid_t tid, pid_t pid, pid_t ppid);
int vtss_task_data_alloc_buffers(struct vtss_task_data *tskd);
int vtss_task_data_free_buffers(struct vtss_task_data *tskd);

#endif
