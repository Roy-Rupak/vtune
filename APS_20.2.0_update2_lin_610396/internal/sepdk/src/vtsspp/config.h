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
#ifndef _VTSS_CONFIG_H_
#define _VTSS_CONFIG_H_

#include "autoconf.h"

#include <linux/kernel.h>
#include <linux/version.h>      /* for KERNEL_VERSION     */
#include <linux/compiler.h>     /* for inline             */
#include <linux/types.h>        /* for size_t, pid_t      */
#include <linux/stddef.h>       /* for NULL               */
#include <linux/smp.h>          /* for smp_processor_id   */
#include <linux/fs.h>           /* for struct file        */
#include <linux/mm.h>           /* for struct mm_struct   */
#include <linux/sched.h>        /* for struct task_struct */
#include <linux/seq_file.h>     /* for struct seq_file    */
#include <linux/slab.h>         /* for kmalloc, kfree     */
#include <linux/cpumask.h>      /* for cpumask_t          */
#include <linux/percpu.h>       /* for per_cpu            */
#if LINUX_VERSION_CODE >= KERNEL_VERSION(4, 11, 0)
#include <linux/sched/task.h>
#include <linux/sched/task_stack.h>
#include <linux/sched/mm.h>
#include <linux/sched/signal.h>
#endif
#include <linux/uaccess.h>      /* for copy_from_user     */
#include <asm/uaccess.h>        /* for copy_from_user     */
#include <asm/cpufeature.h>     /* for X86_FEATURE        */
#include <asm/ptrace.h>         /* for struct pt_regs     */

#include "vtsserr.h"
#include "vtsscfg.h"
#include "vtsstypes.h"
#include "vtsstrace.h"
#include "vtssevids.h"

#ifndef VTSS_VERSION_MAJOR
#define VTSS_VERSION_MAJOR    1
#endif
#ifndef VTSS_VERSION_MINOR
#define VTSS_VERSION_MINOR    8
#endif
#ifndef VTSS_VERSION_REVISION
#define VTSS_VERSION_REVISION 0
#endif
#ifndef VTSS_VERSION_STRING
#define VTSS_VERSION_STRING   "1.8.0-custom"
#endif

#ifndef __x86_64__
#error "Only x86_64 architecture is supported"
#endif

#ifndef CONFIG_MODULES
#error "The kernel should be compiled with CONFIG_MODULES=y"
#endif

#ifndef CONFIG_MODULE_UNLOAD
#error "The kernel should be compiled with CONFIG_MODULE_UNLOAD=y"
#endif

#ifndef CONFIG_SMP
#error "The kernel should be compiled with CONFIG_SMP=y"
#endif

#ifndef CONFIG_KPROBES
#error "The kernel should be compiled with CONFIG_KPROBES=y"
#endif

#ifndef VTSS_AUTOCONF_KERNEL_HEADERS
#warning "Kernel headers contain some warnings, try to update compiler and libc or kernel sources"
#endif

/* Kernel/User page tables isolation support */
#if defined(X86_FEATURE_KAISER) || defined(CONFIG_KAISER) || defined(VTSS_AUTOCONF_KAISER)
#define VTSS_CONFIG_KAISER 1
#elif defined(X86_FEATURE_PTI)
#define VTSS_CONFIG_KPTI 1
#endif

#if defined(VTSS_CONFIG_KAISER) || defined(VTSS_CONFIG_KPTI)
#ifndef CONFIG_KALLSYMS
#error "The kernel should be compiled with CONFIG_KALLSYMS=y"
#endif
#endif

/* Tracepoints support */
#ifdef CONFIG_TRACEPOINTS
#if defined(VTSS_AUTOCONF_TRACE_SCHED) || defined(VTSS_AUTOCONF_TRACE_SCHED_RQ) || defined(VTSS_AUTOCONF_TRACE_SCHED_PREEMPT)
#define VTSS_USE_TRACEPOINTS 1
#endif
#endif

/* Fallback to preempt notifiers */
#if defined(CONFIG_PREEMPT_NOTIFIERS) && !defined(VTSS_USE_TRACEPOINTS)
#define VTSS_USE_PREEMPT_NOTIFIERS 1
#endif

/* Prevent task struct early destruction */
#define VTSS_GET_TASK_STRUCT 1

/* Always store context switches for time calculation, even if we do not need them in result */
#define VTSS_ALWAYS_STORE_CTX 1

/* Realtime patch support */
#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_PREEMPT_RT_FULL)
#define VTSS_CONFIG_REALTIME 1
#define VTSS_CONFIG_INTERNAL_MEMORY_POOL 1
#endif

#define VTSS_FILENAME_SIZE 128
#define VTSS_TASKNAME_SIZE TASK_COMM_LEN
#define VTSS_RUNSS_NAME "amplxe-runss"

#ifdef VTSS_AUTOCONF_INLINE_COPY_FROM_USER
#define vtss_copy_from_user _copy_from_user
#else
#define vtss_copy_from_user copy_from_user
#endif

#ifndef preempt_enable_no_resched
#define preempt_enable_no_resched() preempt_enable()
#endif

#ifndef ____cacheline_aligned
#define ____cacheline_aligned __attribute__((__aligned__(64)))
#endif

#endif
