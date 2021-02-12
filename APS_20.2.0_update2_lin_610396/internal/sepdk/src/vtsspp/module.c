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
#include "module.h"
#include "task_data.h"
#include "target.h"
#include "mmap.h"
#include "sched.h"
#include "cmd.h"
#include "globals.h"

#include <linux/module.h>
#include <linux/moduleparam.h>

int uid = 0;
module_param(uid, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
MODULE_PARM_DESC(uid, "An user id for profiling");

int gid = 0;
module_param(gid, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
MODULE_PARM_DESC(gid, "A group id for profiling");

int mode = 0;
module_param(mode, int, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
MODULE_PARM_DESC(mode, "A mode for files in procfs");

#ifdef VTSS_DEBUG_TRACE
static char debug_trace_name[64] = "";
static int  debug_trace_size     = 0;
module_param_string(trace, debug_trace_name, sizeof(debug_trace_name), S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
MODULE_PARM_DESC(trace, "Turn on trace output from functions starting with this name");

int vtss_check_trace(const char *func_name, int *flag)
{
    return (debug_trace_size && !strncmp(func_name, debug_trace_name, debug_trace_size)) ? 1 : -1;
}
#endif

char *sym_lookup_func_addr = NULL;
module_param(sym_lookup_func_addr, charp, 0);
MODULE_PARM_DESC(sym_lookup_func_addr, "kallsyms_lookup_name function address in hex");

void cleanup_module(void)
{
    vtss_fini();
    REPORT("Driver has been unloaded");
}

int init_module(void)
{
    int rc = 0;

#ifdef VTSS_DEBUG_TRACE
    if (*debug_trace_name != '\0')
        debug_trace_size = strlen(debug_trace_name);
#endif

    REPORT("Driver version %s", VTSS_VERSION_STRING);

    rc = vtss_init();

    if (!rc) {
        REPORT("Driver has been loaded");
    } else {
        REPORT("Initialization failed");
        vtss_fini();
    }
    return rc;
}

MODULE_LICENSE("GPL");
MODULE_AUTHOR(VTSS_MODULE_AUTHOR);
MODULE_DESCRIPTION(VTSS_MODULE_NAME);
