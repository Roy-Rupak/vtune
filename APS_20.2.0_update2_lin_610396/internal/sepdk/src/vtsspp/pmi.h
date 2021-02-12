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
#include "task_data.h"
#include "task_map.h"

#ifndef _VTSS_PMI_H_
#define _VTSS_PMI_H_

extern atomic_t vtss_events_enabling;

void vtss_dump_stack(struct vtss_task_data *tskd, struct task_struct *task, struct pt_regs *regs, unsigned long bp);

void vtss_profiling_pause(void);
void vtss_profiling_resume(vtss_task_map_item_t *item, int bts_resume);

void vtss_pmi_enable(void);
void vtss_pmi_disable(void);

#endif