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
#include "kpti.h"
#include "ksyms.h"

#include <linux/gfp.h>

#ifdef VTSS_CONFIG_KPTI
#include <asm/io.h>
#include <asm/tlbflush.h>

static void (*vtss_cea_set_pte)(void *cea_vaddr, phys_addr_t pa, pgprot_t flags) = NULL;
static void (*vtss_do_kernel_range_flush)(void *info) = NULL;

int vtss_cea_init(void)
{
    if (vtss_cea_set_pte == NULL) {
        vtss_cea_set_pte = (void*)vtss_kallsyms_lookup_name("cea_set_pte");
        if (vtss_cea_set_pte == NULL) {
            ERROR("Cannot find 'cea_set_pte' symbol");
            return VTSS_ERR_INTERNAL;
        }
    }
    if (vtss_do_kernel_range_flush == NULL) {
        vtss_do_kernel_range_flush = (void*)vtss_kallsyms_lookup_name("do_kernel_range_flush");
        if (vtss_do_kernel_range_flush == NULL) {
            ERROR("Cannot find 'do_kernel_range_flush' symbol");
            return VTSS_ERR_INTERNAL;
        }
    }
    REPORT("KPTI is enabled");
    return 0;
}

void vtss_cea_update(void *cea, void *addr, size_t size, pgprot_t prot)
{
    unsigned long start = (unsigned long)cea;
    struct flush_tlb_info info;
    phys_addr_t pa;
    size_t msz = 0;

    pa = virt_to_phys(addr);

    preempt_disable();
    for (; msz < size; msz += PAGE_SIZE, pa += PAGE_SIZE, cea += PAGE_SIZE)
        vtss_cea_set_pte(cea, pa, prot);

    info.start = start;
    info.end = start + size;
    vtss_do_kernel_range_flush(&info);
    preempt_enable();
}

void vtss_cea_clear(void *cea, size_t size)
{
    unsigned long start = (unsigned long)cea;
    struct flush_tlb_info info;
    size_t msz = 0;

    preempt_disable();
    for (; msz < size; msz += PAGE_SIZE, cea += PAGE_SIZE)
        vtss_cea_set_pte(cea, 0, PAGE_NONE);

    info.start = start;
    info.end = start + size;
    vtss_do_kernel_range_flush(&info);
    preempt_enable();
}

void *vtss_cea_alloc_pages(size_t size, gfp_t flags, int cpu)
{
    unsigned int order = get_order(size);
    int node = cpu_to_node(cpu);
    struct page *page;

    page = alloc_pages_node(node, flags | __GFP_ZERO, order);
    return page ? page_address(page) : NULL;
}

void vtss_cea_free_pages(const void *buffer, size_t size)
{
    if (buffer)
        free_pages((unsigned long)buffer, get_order(size));
}
#endif

#ifdef VTSS_CONFIG_KAISER
#include <linux/kaiser.h>

static int (*vtss_kaiser_add_mapping)(unsigned long addr, unsigned long size, pteval_t flags) = NULL;
static void (*vtss_kaiser_remove_mapping)(unsigned long start, unsigned long size) = NULL;
static int vtss_kaiser_enabled = 0;

int vtss_kaiser_init(void)
{
    int *kaiser_enabled_ptr = (int*)vtss_kallsyms_lookup_name("kaiser_enabled");
    if (kaiser_enabled_ptr) {
        vtss_kaiser_enabled = *kaiser_enabled_ptr;
        REPORT("KAISER is %s", vtss_kaiser_enabled ? "enabled" : "disabled");
    }
    else {
        vtss_kaiser_enabled = 1;
        REPORT("KAISER is auto");
    }
    if (vtss_kaiser_enabled) {
        if (vtss_kaiser_add_mapping == NULL) {
            vtss_kaiser_add_mapping = (void*)vtss_kallsyms_lookup_name("kaiser_add_mapping");
            if (vtss_kaiser_add_mapping == NULL) {
                ERROR("Cannot find 'kaiser_add_mapping' symbol");
                return VTSS_ERR_INTERNAL;
            }
        }
        if (vtss_kaiser_remove_mapping == NULL) {
            vtss_kaiser_remove_mapping = (void*)vtss_kallsyms_lookup_name("kaiser_remove_mapping");
            if (vtss_kaiser_remove_mapping == NULL) {
                ERROR("Cannot find 'kaiser_remove_mapping' symbol");
                return VTSS_ERR_INTERNAL;
            }
        }
    }
    return 0;
}

void *vtss_kaiser_alloc_pages(size_t size, gfp_t flags, int cpu)
{
    unsigned int order = get_order(size);
    int node = cpu_to_node(cpu);
    struct page *page;
    unsigned long addr;

    page = alloc_pages_node(node, flags | __GFP_ZERO, order);
    if (!page)
        return NULL;
    addr = (unsigned long)page_address(page);
    if (vtss_kaiser_enabled) {
        if (vtss_kaiser_add_mapping(addr, size, __PAGE_KERNEL | _PAGE_GLOBAL) < 0) {
            __free_pages(page, order);
            addr = 0;
        }
    }
    return (void *)addr;
}

void vtss_kaiser_free_pages(const void *buffer, size_t size)
{
    if (!buffer)
        return;
    if (vtss_kaiser_enabled) {
        vtss_kaiser_remove_mapping((unsigned long)buffer, size);
    }
    free_pages((unsigned long)buffer, get_order(size));
}
#endif
