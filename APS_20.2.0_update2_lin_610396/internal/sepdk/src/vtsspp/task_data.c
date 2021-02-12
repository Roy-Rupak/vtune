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
#include "mpool.h"

int vtss_task_data_init(struct vtss_task_data *tskd, pid_t tid, pid_t pid, pid_t ppid)
{
    tskd->stk      = NULL;
    tskd->lbr      = NULL;
    tskd->trnd     = NULL;
    tskd->trnd_aux = NULL;
    tskd->state    = 0;
    tskd->m32      = 0; /* unknown so far, assume native */
    tskd->tid      = tid;
    tskd->pid      = pid;
    tskd->ppid     = ppid;
    tskd->cpu      = raw_smp_processor_id();
    tskd->ip       = NULL;
#ifdef VTSS_SYSCALL_TRACE
    tskd->syscall_sp    = NULL;
    tskd->syscall_enter = 0ULL;
#endif
#ifndef VTSS_NO_BTS
    tskd->bts_size   = 0;
    tskd->bts_buffer = NULL;
#endif
    tskd->is_ipt_trace_ovf = 0;
    tskd->cpuevent_chain   = 0;
    tskd->from_ip          = 0;

    if (sizeof(struct vtss_task_data) > PAGE_SIZE)
        WARNING("Task data requires too much memory, resulting in allocation errors");
    return 0;
}

int vtss_task_data_alloc_buffers(struct vtss_task_data *tskd)
{
    tskd->stk = vtss_kmalloc(sizeof(stack_control_t), GFP_KERNEL);
    if (!tskd->stk) {
        WARNING("Unable to allocate stack control structure");
        return -ENOMEM;
    }
    memset(tskd->stk, 0, sizeof(stack_control_t));

    tskd->lbr = vtss_kmalloc(sizeof(lbr_control_t), GFP_KERNEL);
    if (!tskd->lbr) {
        WARNING("Unable to allocate LBR control structure");
        return -ENOMEM;
    }
    memset(tskd->lbr, 0, sizeof(lbr_control_t));

#ifndef VTSS_NO_BTS
    tskd->bts_buffer = vtss_kmalloc(VTSS_BTS_MAX*sizeof(vtss_bts_t), GFP_KERNEL);
    if (!tskd->bts_buffer) {
        WARNING("Unable to allocate BTS buffer");
        return -ENOMEM;
    }
    memset(tskd->bts_buffer, 0, VTSS_BTS_MAX*sizeof(vtss_bts_t));
#endif

    tskd->cpuevent_chain = vtss_kmalloc(VTSS_CFG_CHAIN_SIZE*sizeof(cpuevent_t), GFP_KERNEL);
    if (!tskd->cpuevent_chain) {
        WARNING("Unable to allocate CPU events config buffer");
        return -ENOMEM;
    }
    memset(tskd->cpuevent_chain, 0, VTSS_CFG_CHAIN_SIZE*sizeof(cpuevent_t));

    return 0;
}

int vtss_task_data_free_buffers(struct vtss_task_data *tskd)
{
    vtss_kfree(tskd->cpuevent_chain);
    vtss_kfree(tskd->bts_buffer);
    vtss_kfree(tskd->lbr);
    vtss_kfree(tskd->stk);
    return 0;
}
