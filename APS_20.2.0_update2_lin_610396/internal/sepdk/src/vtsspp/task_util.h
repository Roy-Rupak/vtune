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
#ifndef _VTSS_TASK_UTIL_H_
#define _VTSS_TASK_UTIL_H_

#include "config.h"

#define TASK_PID(task) (task->tgid)
#define TASK_TID(task) (task->pid)
#define TASK_PARENT(task) (task->real_parent)

/* Only live tasks with mm and state == TASK_RUNNING | TASK_INTERRUPTIBLE | TASK_UNINTERRUPTIBLE */
#define VTSS_IS_VALID_TASK(task) ((task->mm || (task->flags & PF_KTHREAD)) && (task)->state < 4 && (task)->exit_state == 0)

#include <linux/path.h>
#define VTSS_DPATH(vm_file, name, maxlen) d_path(&((vm_file)->f_path), (name), (maxlen))

#define vtss_get_task_struct(task) get_task_struct(task)
#define vtss_put_task_struct(task) put_task_struct(task)
#define vtss_get_task_comm(name, task) get_task_comm(name, task)

struct task_struct *vtss_find_task_by_tid(pid_t tid);

int vtss_get_task_basename(char *basename, char *filename, int user);

#include <linux/cred.h>
static inline void vtss_current_uid_gid(uid_t *uid, gid_t *gid)
{
#ifdef VTSS_AUTOCONF_CURRENT_KUID_KGID
     kuid_t kuid;
     kgid_t kgid;
     current_uid_gid(&kuid, &kgid);
     *uid = kuid.val;
     *gid = kgid.val;
#else
    current_uid_gid(uid, gid);
#endif
}

#endif
