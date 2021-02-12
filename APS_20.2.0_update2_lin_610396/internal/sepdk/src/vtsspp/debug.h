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
#ifndef _VTSS_DEBUG_H_
#define _VTSS_DEBUG_H_

#include <linux/kernel.h>

#ifdef VTSS_DEBUG_TRACE
extern int vtss_check_trace(const char *func_name, int *flag);
#define TRACE(FMT, ...) do {   \
    static int trace_flag = 0; \
    if (unlikely(!trace_flag))  trace_flag = vtss_check_trace(__FUNCTION__, &trace_flag); \
    if (unlikely(trace_flag>0)) printk(KERN_DEBUG "%s(%d): [cpu%d]: "FMT"\n", __FUNCTION__, __LINE__, raw_smp_processor_id(), ##__VA_ARGS__); \
  } while (0)
#else
#define TRACE(FMT, ...) /* empty */
#endif
#define ERROR(FMT, ...) do { printk(KERN_ERR "vtsspp: "FMT"\n", ##__VA_ARGS__); } while (0)
#define WARNING(FMT, ...) do { printk(KERN_WARNING "vtsspp: "FMT"\n", ##__VA_ARGS__); } while (0)
#define REPORT(FMT, ...)  do { printk(KERN_NOTICE "vtsspp: "FMT"\n", ##__VA_ARGS__); } while (0)
#define INFO(FMT, ...)  do { printk(KERN_INFO "%s(%d): [cpu%d]: "FMT"\n", __FUNCTION__, __LINE__, raw_smp_processor_id(), ##__VA_ARGS__); } while (0)

#define DEBUG_CMD TRACE
#define DEBUG_MMAP TRACE
#define DEBUG_TARGET TRACE
#define DEBUG_CPUEVT TRACE
#define DEBUG_PROCFS TRACE
#define DEBUG_TASKMAP TRACE
#define DEBUG_TR TRACE
#define DEBUG_MPOOL TRACE
#define DEBUG_PROBE TRACE

#define VTSS_RECORD_DEBUG(trnd, fmt, ...) do {\
    char buf[256];\
    int nb = snprintf(buf, sizeof(buf) - 1, fmt, ##__VA_ARGS__);\
    if (nb > 0 && nb < sizeof(buf) - 1) {\
        buf[nb] = '\0';\
        vtss_record_debug_info(trnd, buf);\
    }\
} while (0)

#ifdef VTSS_DEBUG_PROFILE
struct vtss_profile {
    unsigned long long count;
    unsigned long long duration;
};
#define VTSS_DEFINE_PROFILE_VAR(name)\
    struct vtss_profile vtss_profile_##name = {0, 0};
#define VTSS_PROFILE_BEGIN(name) do { \
    cycles_t start_time_##name = vtss_time_cpu()
#define VTSS_PROFILE_END(name) \
    vtss_profile_##name.count++; \
    vtss_profile_##name.duration += vtss_time_cpu() - start_time_##name; \
  } while (0)
#else
#define VTSS_DEFINE_PROFILE_VAR(name)
#define VTSS_PROFILE_BEGIN(name) do {
#define VTSS_PROFILE_END(name) } while (0)
#endif

int vtss_debug_info(struct seq_file *s);
int vtss_target_pids(struct seq_file *s);

#endif
