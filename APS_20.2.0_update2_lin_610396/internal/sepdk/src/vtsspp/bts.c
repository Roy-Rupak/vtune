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
#include "bts.h"
#include "cpuevents.h"
#include "dsa.h"
#include "kpti.h"
#include "cpu.h"
#include "globals.h"
#include "record.h"

#define BTS_ENABLE_MASK_P6  0x03c0

static int vtss_bts_count = VTSS_BTS_MIN;

int vtss_bts_overflowed(int cpu)
{
    vtss_dsa_t *dsa = pcb(cpu).dsa_ptr;

    if (IS_DSA_64ON32) {
        return (dsa->v32.bts_index >= dsa->v32.bts_threshold);
    } else {
        return (dsa->v64.bts_index >= dsa->v64.bts_threshold);
    }
}

void vtss_bts_enable(void)
{
    unsigned long long msr_val;
    if (hardcfg.family == VTSS_FAM_P6) {
        rdmsrl(VTSS_IA32_DEBUGCTL, msr_val);
        msr_val |= BTS_ENABLE_MASK_P6;
        wrmsrl(VTSS_IA32_DEBUGCTL, msr_val);
    }
}

void vtss_bts_disable(void)
{
    unsigned long long msr_val;

    if (hardcfg.family == VTSS_FAM_P6) {
        rdmsrl(VTSS_IA32_DEBUGCTL, msr_val);
        msr_val &= ~BTS_ENABLE_MASK_P6;
        wrmsrl(VTSS_IA32_DEBUGCTL, msr_val);
    }
}

unsigned short vtss_bts_dump(unsigned char *bts_buff)
{
    unsigned char *dst;
    size_t offset, value;
    int i, j, sign, prefix, cpu;
    char *src, *src_end;
    vtss_dsa_t *dsa;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();
    dsa = pcb(cpu).dsa_ptr;

    src     = (char*)(IS_DSA_64ON32 ? dsa->v32.bts_base  : dsa->v64.bts_base);
    src_end = (char*)(IS_DSA_64ON32 ? dsa->v32.bts_index : dsa->v64.bts_index);
    for (dst = bts_buff, offset = 0; ((dst - bts_buff) < (VTSS_BTS_MAX*sizeof(vtss_bts_t) - sizeof(size_t))) && (src < src_end); src = (IS_DSA_64ON32) ? src + 6*sizeof(void*) : src + 3*sizeof(void*)) {
        for (i = 0; i < 2; i++) {
            /// BTS structures are always 64-bit on Merom
            if (IS_DSA_64ON32) {
                value  = ((size_t*)src)[i << 1];
                value -= offset;
                offset = ((size_t*)src)[i << 1];
                prefix = (int)((size_t)((vtss_bts_t*)src)->v32.prediction << 3);
            } else {
                value  = ((size_t*)src)[i];
                value -= offset;
                offset = ((size_t*)src)[i];
                prefix = (int)((size_t)((vtss_bts_t*)src)->v64.prediction << 3);
            }
            sign = (value & (((size_t)1) << ((sizeof(size_t) << 3) - 1))) ? 0xff : 0;
            for (j = sizeof(size_t) - 1; j >= 0; j--) {
                if (((value >> (j << 3)) & 0xff) != sign) {
                    break;
                }
            }
            prefix |= sign ? 0x40 : 0;
            prefix |= j + 1;
            *dst++ = (unsigned char)prefix;
            for (; j >= 0; j--) {
                *dst++ = (unsigned char)(value & 0xff);
                value >>= 8;
            }
        }
    }
    return (unsigned short)(size_t)(dst - bts_buff);
}

#ifdef VTSS_CONFIG_KPTI
#include <asm/cpu_entry_area.h>

#ifndef BTS_BUFFER_SIZE
#define BTS_BUFFER_SIZE (PAGE_SIZE << 4)
#endif

static int vtss_bts_alloc_buffer(int cpu)
{
    void *cea;
    void *buffer;

    pcb(cpu).bts_vaddr = NULL;
    pcb(cpu).bts_ptr = NULL;
    cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
    buffer = vtss_cea_alloc_pages(BTS_BUFFER_SIZE, GFP_KERNEL, cpu);
    if (unlikely(!buffer)) {
        ERROR("Cannot allocate BTS buffer on %d CPU", cpu);
        return VTSS_ERR_NOMEMORY;
    }
    pcb(cpu).bts_vaddr = buffer;
    vtss_cea_update(cea, buffer, BTS_BUFFER_SIZE, PAGE_KERNEL);
    pcb(cpu).bts_ptr = cea;
    TRACE("allocated buffer for %d cpu cea=%p, vaddr=%p", cpu, cea, buffer);
    return 0;
}

static void vtss_bts_release_buffer(int cpu)
{
    void *cea;
    void *buffer;

    buffer = pcb(cpu).bts_vaddr;
    cea = &get_cpu_entry_area(cpu)->cpu_debug_buffers.bts_buffer;
    vtss_cea_clear(cea, BTS_BUFFER_SIZE);
    vtss_cea_free_pages(buffer, BTS_BUFFER_SIZE);
    TRACE("released buffer for %d cpu cea=%p, vaddr=%p", cpu, cea, buffer);
}

#elif defined(VTSS_CONFIG_KAISER)

static int vtss_bts_alloc_buffer(int cpu)
{
    void *buffer;

    pcb(cpu).bts_ptr = NULL;
    buffer = vtss_kaiser_alloc_pages(vtss_bts_count*sizeof(vtss_bts_t), GFP_KERNEL, cpu);
    if (unlikely(!buffer)) {
        ERROR("Cannot allocate BTS buffer on %d CPU", cpu);
        return VTSS_ERR_NOMEMORY;
    }
    pcb(cpu).bts_ptr = buffer;
    TRACE("allocated buffer for %d cpu, buffer=%p", cpu, buffer);
    return 0;
}

static void vtss_bts_release_buffer(int cpu)
{
    void *buffer;

    buffer = pcb(cpu).bts_ptr;
    vtss_kaiser_free_pages(buffer, vtss_bts_count*sizeof(vtss_bts_t));
    TRACE("released buffer for %d cpu, buffer=%p", cpu, buffer);
}

#else

static int vtss_bts_alloc_buffer(int cpu)
{
    void *buffer;

    pcb(cpu).bts_ptr = NULL;
    buffer = kmalloc_node(vtss_bts_count*sizeof(vtss_bts_t), GFP_KERNEL | __GFP_ZERO, cpu_to_node(cpu));
    if (unlikely(!buffer)) {
        ERROR("Cannot allocate BTS buffer on %d CPU", cpu);
        return VTSS_ERR_NOMEMORY;
    }
    TRACE("allocated buffer for %d cpu, buffer=%p", cpu, buffer);
    pcb(cpu).bts_ptr = buffer;
    return 0;
}

static void vtss_bts_release_buffer(int cpu)
{
    if (pcb(cpu).bts_ptr != NULL)
        kfree(pcb(cpu).bts_ptr);
}
#endif

/* initialize BTS in DSA for the processor */
void vtss_bts_init_dsa(void)
{
    size_t recsize;
    void *threshold, *absmax;
    int cpu;
    vtss_dsa_t *dsa;
    vtss_bts_t *bts;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();
    dsa = pcb(cpu).dsa_ptr;
    bts = pcb(cpu).bts_ptr;

    /* BTS structures are always 64-bit on Merom */
    recsize   = IS_DSA_64ON32 ? sizeof(bts->v32) : sizeof(bts->v64);
    absmax    = (void*)((size_t)bts + (vtss_bts_count - 1) * recsize + 1);
    threshold = (void*)((size_t)bts + (vtss_bts_count / 4 * 3 * recsize));

    if (IS_DSA_64ON32) {
        dsa->v32.bts_base      = bts;
        dsa->v32.bts_pad0      = NULL;
        dsa->v32.bts_index     = bts;
        dsa->v32.bts_pad1      = NULL;
        dsa->v32.bts_absmax    = absmax;
        dsa->v32.bts_pad2      = NULL;
        dsa->v32.bts_threshold = threshold;
        dsa->v32.bts_pad3      = NULL;
    } else {
        dsa->v64.bts_base      = bts;
        dsa->v64.bts_index     = bts;
        dsa->v64.bts_absmax    = absmax;
        dsa->v64.bts_threshold = threshold;
    }
}

static void vtss_bts_on_each_cpu_func(void *ctx)
{
    vtss_bts_disable();
}

int vtss_bts_init(int brcount)
{
    int cpu;
    /* Fix count of branches */
    brcount = (brcount < VTSS_BTS_MIN) ? VTSS_BTS_MIN : brcount;
    brcount = (brcount > VTSS_BTS_MAX) ? VTSS_BTS_MAX : brcount;
#ifdef BTS_BUFFER_SIZE
    if (brcount > (BTS_BUFFER_SIZE/sizeof(vtss_bts_t)))
        brcount = BTS_BUFFER_SIZE/sizeof(vtss_bts_t);
#endif
    vtss_bts_count = brcount;
    for_each_possible_cpu(cpu) {
        if (vtss_bts_alloc_buffer(cpu)) goto fail;
    }
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_BRANCH)
        REPORT("BTS: count of branches: %d", vtss_bts_count);
    return 0;

fail:
    for_each_possible_cpu(cpu) {
        vtss_bts_release_buffer(cpu);
    }
    return VTSS_ERR_NOMEMORY;
}

void vtss_bts_fini(void)
{
    int cpu;

    on_each_cpu(vtss_bts_on_each_cpu_func, NULL, 1);
    for_each_possible_cpu(cpu) {
        vtss_bts_release_buffer(cpu);
    }
}
