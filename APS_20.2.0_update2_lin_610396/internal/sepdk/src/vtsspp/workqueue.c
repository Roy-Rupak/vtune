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
#include "workqueue.h"
#include "mpool.h"

int vtss_queue_work(int cpu, vtss_work_func_t *func, void *data, size_t size)
{
    struct vtss_work *my_work = 0;

    my_work = vtss_kmalloc(sizeof(struct vtss_work) + size, GFP_ATOMIC);

    if (my_work != NULL) {
        INIT_WORK((struct work_struct*)my_work, func);
        if (data != NULL && size > 0)
            memcpy(&my_work->data, data, size);

#ifdef VTSS_AUTOCONF_SYSTEM_UNBOUND_WQ
#ifdef VTSS_CONFIG_REALTIME
        queue_work(system_unbound_wq, (struct work_struct*)my_work);
#else
        if (cpu < 0) {
            queue_work(system_unbound_wq, (struct work_struct*)my_work);
        } else {
            queue_work_on(cpu, system_unbound_wq, (struct work_struct*)my_work);
        }
#endif
#else
        if (cpu < 0) {
            schedule_work((struct work_struct*)my_work);
        } else {
            schedule_work_on(cpu, (struct work_struct*)my_work);
        }
#endif
    } else {
        ERROR("No memory for work data");
        return -ENOMEM;
    }
    return 0;
}
