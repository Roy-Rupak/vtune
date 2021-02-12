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
#ifndef _VTSS_PROCFS_H_
#define _VTSS_PROCFS_H_

#include "config.h"

#include <linux/proc_fs.h>

#ifdef VTSS_AUTOCONF_PROCFS_OPS
#define vtss_procfs_ops proc_ops
#define VTSS_PROCFS_DEFAULT_OPS
#define vtss_procfs_read proc_read
#define vtss_procfs_write proc_write
#define vtss_procfs_open proc_open
#define vtss_procfs_lseek proc_lseek
#define vtss_procfs_release proc_release
#define vtss_procfs_poll proc_poll
#else
#define vtss_procfs_ops file_operations
#define VTSS_PROCFS_DEFAULT_OPS .owner = THIS_MODULE,
#define vtss_procfs_read read
#define vtss_procfs_write write
#define vtss_procfs_open open
#define vtss_procfs_lseek llseek
#define vtss_procfs_release release
#define vtss_procfs_poll poll
#endif

#ifdef VTSS_AUTOCONF_PROCFS_PDE_DATA
#define VTSS_PDE_DATA(inode) (void *)PDE_DATA(inode)
#else
#define VTSS_PDE_DATA(inode) (void *)PDE(inode)->data
#endif

extern unsigned int vtss_client_major_ver;
extern unsigned int vtss_client_minor_ver;

void vtss_procfs_fini(void);
int vtss_procfs_init(void);
const char *vtss_procfs_path(void);
struct proc_dir_entry *vtss_procfs_get_root(void);
void vtss_procfs_set_user(struct proc_dir_entry *pde, int uid, int gid);
int vtss_procfs_ctrl_wake_up(void *msg, size_t size);
int vtss_procfs_ctrl_wake_up_all(void);
void vtss_procfs_ctrl_flush(void);
extern struct cpumask vtss_procfs_cpumask;
extern int vtss_procfs_defsav;

#endif
