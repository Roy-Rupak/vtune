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
#include "cmd.h"
#include "target.h"

#include <linux/file.h>

static const char *task_state_str[] = {
    "-NEWTASK-",
    "-SOFTCFG-",
    "-SWAPIN-",
    "-SWAPOUT-",
    "-SAMPLE-",
    "-STACK_DUMP-",
    "-STACK_SAVE-",
    "PAUSE",
    "RUNNING",
    "IN_SYSCALL",
    "CPUEVT",
    "(COMPLETE)",
    "(NOTIFIER)",
    "(PMU_SET)",
    "(MMAP_INIT)",
};

static void vtss_debug_info_target(vtss_task_map_item_t *item, void *args)
{
    int i;
    struct seq_file *s = (struct seq_file*)args;
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

    seq_printf(s, "\n[task %d:%d]\nname='%s'\nstate=0x%04x (",
        tskd->tid, tskd->pid, tskd->filename, tskd->state);
    for (i = 0; i < sizeof(task_state_str)/sizeof(char*); i++) {
        if (tskd->state & (1<<i))
            seq_printf(s, " %s", task_state_str[i]);
    }
    seq_printf(s, " )\n");
}

static const char *state_str[4] = { "STOPPED", "INITING", "RUNNING", "PAUSED" };

int vtss_debug_info(struct seq_file *s)
{
    int rc = 0;

    seq_printf(s, "[collector]\nstate=%s\ntargets=%d\n",
        state_str[atomic_read(&vtss_collector_state)],
        atomic_read(&vtss_target_count));

    rc |= vtss_transport_debug_info(s);
    rc |= vtss_task_map_foreach(vtss_debug_info_target, s);
    return rc;
}

static void vtss_target_pids_item(vtss_task_map_item_t *item, void *args)
{
    struct seq_file *s = (struct seq_file*)args;
    struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;

    if (tskd->tid == tskd->pid) /* Show only processes */
        seq_printf(s, "%d\n", tskd->pid);
}

int vtss_target_pids(struct seq_file *s)
{
    return vtss_task_map_foreach(vtss_target_pids_item, s);
}
