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
#ifndef _VTSS_CMD_H_
#define _VTSS_CMD_H_

#include "config.h"
#include "task_map.h"

extern uid_t vtss_session_uid;
extern gid_t vtss_session_gid;

#define VTSS_COLLECTOR_UNINITING -1
#define VTSS_COLLECTOR_STOPPED 0
#define VTSS_COLLECTOR_INITING 1
#define VTSS_COLLECTOR_RUNNING 2
#define VTSS_COLLECTOR_PAUSED  3
#define VTSS_COLLECTOR_IS_READY (atomic_read(&vtss_collector_state) >= VTSS_COLLECTOR_RUNNING)
#define VTSS_COLLECTOR_IS_READY_OR_INITING (atomic_read(&vtss_collector_state) >= VTSS_COLLECTOR_INITING)
#define VTSS_COLLECTOR_STATE() (atomic_read(&vtss_collector_state))
extern atomic_t vtss_collector_state;

#define vtss_cpu_active(cpu) cpumask_test_cpu((cpu), &vtss_collector_cpumask)
extern cpumask_t vtss_collector_cpumask;

#define VTSS_TRANSPORT_UNINITING -1
#define VTSS_TRANSPORT_STOPPED 0
#define VTSS_TRANSPORT_READY 1
#define VTSS_TRANSPORT_IS_READY (atomic_read(&vtss_transport_state) == VTSS_TRANSPORT_READY)
extern atomic_t vtss_transport_state;
extern atomic_t vtss_transport_busy; /* cannot be uninited while busy */
extern atomic_t vtss_kernel_tasks_in_progress;

int vtss_cmd_open(void);
int vtss_cmd_close(void);
int vtss_cmd_set_target(pid_t pid);
int vtss_cmd_start(void);
int vtss_cmd_stop(void);
int vtss_cmd_stop_async(void);
int vtss_cmd_stop_ring_buffer(void);
int vtss_cmd_pause(void);
int vtss_cmd_resume(void);

int vtss_init(void);
void vtss_fini(void);

#endif
