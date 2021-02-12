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
#include "dsa.h"
#include "cpu.h"
#include "globals.h"
#include "kpti.h"

#ifdef VTSS_CONFIG_KPTI
#include <asm/cpu_entry_area.h>
#endif

#define DS_AREA_MSR 0x0600

void vtss_dsa_init_cpu(void)
{
    if (hardcfg.family == VTSS_FAM_P6) {

        vtss_dsa_t *dsa = pcb_cpu.dsa_ptr;

        if (IS_DSA_64ON32) {
            dsa->v32.reserved[0] = dsa->v32.reserved[1] = NULL;
            dsa->v32.reserved[2] = dsa->v32.reserved[3] = NULL;
        } else {
            dsa->v64.reserved[0] = dsa->v64.reserved[1] = NULL;
        }
        wrmsrl(DS_AREA_MSR, (size_t)dsa);
    }
}

#ifdef VTSS_CONFIG_KPTI

static int vtss_dsa_alloc_buffer(int cpu)
{
    pcb(cpu).dsa_ptr = &get_cpu_entry_area(cpu)->cpu_debug_store;
    return 0;
}

static void vtss_dsa_release_buffer(int cpu)
{
    pcb(cpu).dsa_ptr = NULL;
}

#elif defined(VTSS_CONFIG_KAISER)

static int vtss_dsa_alloc_buffer(int cpu)
{
    void *buffer;

    pcb(cpu).dsa_ptr = NULL;
    buffer = vtss_kaiser_alloc_pages(sizeof(vtss_dsa_t), GFP_KERNEL, cpu);
    if (unlikely(!buffer)) {
        ERROR("Cannot allocate DSA buffer on %d CPU", cpu);
        return VTSS_ERR_NOMEMORY;
    }
    pcb(cpu).dsa_ptr = buffer;
    TRACE("allocated buffer for %d cpu, buffer=%p", cpu, buffer);
    return 0;
}

static void vtss_dsa_release_buffer(int cpu)
{
    void *buffer;

    buffer = pcb(cpu).dsa_ptr;
    vtss_kaiser_free_pages(buffer, sizeof(vtss_dsa_t));
    TRACE("released buffer for %d cpu, buffer=%p", cpu, buffer);
}

#else

static int vtss_dsa_alloc_buffer(int cpu)
{
    void *buffer;

    pcb(cpu).dsa_ptr = NULL;
    buffer = kmalloc_node(sizeof(vtss_dsa_t), GFP_KERNEL | __GFP_ZERO, cpu_to_node(cpu));
    if (unlikely(!buffer)) {
        ERROR("Cannot allocate DSA buffer on %d CPU", cpu);
        return VTSS_ERR_NOMEMORY;
    }
    pcb(cpu).dsa_ptr = buffer;
    TRACE("allocated buffer for %d cpu, buffer=%p", cpu, buffer);
    return 0;
}

static void vtss_dsa_release_buffer(int cpu)
{
    if (pcb(cpu).dsa_ptr != NULL)
        kfree(pcb(cpu).dsa_ptr);
}

#endif

static void vtss_dsa_on_each_cpu_init(void *ctx)
{
    if (hardcfg.family == VTSS_FAM_P6) {
        rdmsrl(DS_AREA_MSR, pcb_cpu.saved_msr_dsa);
    }
}

static void vtss_dsa_on_each_cpu_fini(void *ctx)
{
    if (hardcfg.family == VTSS_FAM_P6) {
        wrmsrl(DS_AREA_MSR, pcb_cpu.saved_msr_dsa);
    }
}

int vtss_dsa_init(void)
{
    int cpu;

    on_each_cpu(vtss_dsa_on_each_cpu_init, NULL, 1);
    for_each_possible_cpu(cpu) {
        if (vtss_dsa_alloc_buffer(cpu)) goto fail;
    }
    return 0;
fail:
    for_each_possible_cpu(cpu) {
        vtss_dsa_release_buffer(cpu);
    }
    return VTSS_ERR_NOMEMORY;
}

void vtss_dsa_fini(void)
{
    int cpu;

    on_each_cpu(vtss_dsa_on_each_cpu_fini, NULL, 1);
    for_each_possible_cpu(cpu) {
        vtss_dsa_release_buffer(cpu);
    }
}

