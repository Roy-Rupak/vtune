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
#ifndef _VTSS_TRACEPOINT_H_
#define _VTSS_TRACEPOINT_H_

#include "config.h"
#include "debug.h"
#include "ksyms.h"

#ifdef VTSS_USE_TRACEPOINTS

#include <trace/events/sched.h>
#ifdef DECLARE_TRACE_NOARGS
#define VTSS_TP_DATA , NULL
#define VTSS_TP_PROTO void *cb_data __attribute__ ((unused)),
#else
#define VTSS_TP_DATA
#define VTSS_TP_PROTO
#endif

#if LINUX_VERSION_CODE >= KERNEL_VERSION(3, 15, 0)
#define VTSS_REGISTER_TRACEPOINT(name, rc)\
{\
    struct tracepoint *vtss_tracepoint_##name_ptr = (struct tracepoint*)vtss_kallsyms_lookup_name("__tracepoint_"#name);\
    rc = (vtss_tracepoint_##name_ptr) ? tracepoint_probe_register(vtss_tracepoint_##name_ptr, tp_##name VTSS_TP_DATA) : -1;\
    if (rc) WARNING("Unable to register '"#name"' tracepoint");\
    else DEBUG_PROBE("registered '"#name"' tracepoint");\
}
#define VTSS_UNREGISTER_TRACEPOINT(name)\
{\
    int rc;\
    struct tracepoint *vtss_tracepoint_##name_ptr = (struct tracepoint*)vtss_kallsyms_lookup_name("__tracepoint_"#name);\
    rc = (vtss_tracepoint_##name_ptr) ? tracepoint_probe_unregister(vtss_tracepoint_##name_ptr, tp_##name VTSS_TP_DATA) : -1;\
    if (rc) DEBUG_PROBE("unable to unregister '"#name"' tracepoint");\
    else DEBUG_PROBE("unregistered '"#name"' tracepoint");\
}
#else
#define VTSS_REGISTER_TRACEPOINT(name, rc)\
{\
    rc = register_trace_##name(tp_##name VTSS_TP_DATA);\
    if (rc) WARNING("Unable to register '"#name"' tracepoint");\
    else DEBUG_PROBE("registered '"#name"' tracepoint");\
}
#define VTSS_UNREGISTER_TRACEPOINT(name)\
{\
    unregister_trace_##name(tp_##name VTSS_TP_DATA);\
    DEBUG_PROBE("unregistered '"#name"' tracepoint");\
}
#endif

#else
#define VTSS_REGISTER_TRACEPOINT(name, rc) rc = -1
#define VTSS_UNREGISTER_TRACEPOINT(name)
#endif

#endif
