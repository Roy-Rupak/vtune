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
#ifndef _VTSS_TRANSPORT_H_
#define _VTSS_TRANSPORT_H_

#include "config.h"

#define VTSS_RB_MSEC reqcfg.ipt_cfg.size
#define VTSS_RB_MODE (reqcfg.ipt_cfg.size > 0)

struct vtss_transport_data;

void vtss_transport_addref(struct vtss_transport_data *trnd);
int vtss_transport_delref(struct vtss_transport_data *trnd);

int vtss_transport_record_write(struct vtss_transport_data *trnd, void *part0, size_t size0, void *part1, size_t size1);
int vtss_transport_record_write_all(void *part0, size_t size0, void *part1, size_t size1);
int vtss_transport_complete(struct vtss_transport_data *trnd);
struct vtss_transport_data *vtss_transport_create(pid_t ppid, pid_t pid, uid_t cuid, gid_t cgid);
struct vtss_transport_data *vtss_transport_create_aux(struct vtss_transport_data *main_trnd, uid_t cuid, gid_t cgid, int rb);

char *vtss_transport_get_filename(struct vtss_transport_data *trnd);
int vtss_transport_is_overflowing(struct vtss_transport_data *trnd);
int vtss_transport_is_ready(struct vtss_transport_data *trnd);
int vtss_transport_debug_info(struct seq_file *s);
int vtss_transport_init(int rb);
void vtss_transport_fini(void);

void vtss_transport_start_ring_bufer(void);
void vtss_transport_stop_ring_bufer(void);

#endif
