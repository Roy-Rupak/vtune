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
#include "task_util.h"
#include "ksyms.h"

struct task_struct *vtss_find_task_by_tid(pid_t tid)
{
    struct task_struct *task = NULL;
    struct pid *p_pid = NULL;

    p_pid = find_get_pid(tid);
    if (p_pid) {
        rcu_read_lock();
        task = pid_task(p_pid, PIDTYPE_PID);
        rcu_read_unlock();
        put_pid(p_pid);
    }
    return task;
}

int vtss_get_task_basename(char *basename, char *filename, int user)
{
    int i = 0;
    char *p = filename;
    size_t size = 0;

    if (basename == NULL) return -1;
    if (filename != NULL) {
        if (user) {
            while ((i < VTSS_FILENAME_SIZE - 1) && (vtss_copy_from_user(&basename[i], p, 1) == 0)) {
                if (basename[i] == '/') i = 0;
                else if (basename[i] == '\0') break;
                else i++;
                p++;
            }
            size = i;
        } else {
            p = strrchr(filename, '/');
            p = p ? p + 1 : filename;
            size = min((size_t)VTSS_FILENAME_SIZE-1, (size_t)strlen(p));
            memcpy(basename, p, size);
        }
    }
    basename[size] = '\0';

    return 0;
}
