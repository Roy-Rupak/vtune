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
#include "ksyms.h"

#ifdef CONFIG_KALLSYMS
#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 7, 0)
extern char *sym_lookup_func_addr;
static unsigned long (*vtss_kallsyms_lookup_name_local)(const char *) = NULL;

unsigned long vtss_kallsyms_lookup_name(const char *name)
{
    unsigned long addr = 0;

    if (!vtss_kallsyms_lookup_name_local && sym_lookup_func_addr) {
        int rc = kstrtoul(sym_lookup_func_addr, 16, &addr);
        if (rc) ERROR("Invalid kallsyms_lookup_name function address");
        TRACE("kallsyms_lookup_name=0x%lx", addr);
        vtss_kallsyms_lookup_name_local = (void *)addr;
    }
    return vtss_kallsyms_lookup_name_local ? vtss_kallsyms_lookup_name_local(name) : 0;
}
#elif LINUX_VERSION_CODE > KERNEL_VERSION(2, 6, 32)
unsigned long vtss_kallsyms_lookup_name(const char *name)
{
    return kallsyms_lookup_name(name);
}
#else
struct vtss_kallsyms_data
{
    const char *name;
    unsigned long ptr;
};

int vtss_kallsyms_lookup_callback(void *data, const char *name, struct module *mod, unsigned long addr)
{
    struct vtss_kallsyms_data *kdata = data;

    if (name) {
        if (kdata) {
            if (!strcmp(name, kdata->name)) {
                kdata->ptr = addr;
                return 1;
            }
        }
    }
    return 0;
}

unsigned long vtss_kallsyms_lookup_name(const char *name)
{
    struct vtss_kallsyms_data kdata;

    kdata.name = name;
    kdata.ptr = 0;
    kallsyms_on_each_symbol(vtss_kallsyms_lookup_callback, (void*)&kdata);
    TRACE("found symbol: %s=0x%lx", name, kdata.ptr);
    return kdata.ptr;
}
#endif
#else
unsigned long vtss_kallsyms_lookup_name(const char *name)
{
    return NULL;
}
#endif

void vtss_get_kstart(unsigned long *addr, unsigned long *size)
{
#ifdef CONFIG_RANDOMIZE_BASE
    unsigned long dyn_addr;
#endif
    *addr = VTSS_KSTART;
    *size = VTSS_KSIZE;
#ifdef CONFIG_RANDOMIZE_BASE
    /* fixup kernel start address of KASLR kernels */
    dyn_addr = vtss_kallsyms_lookup_name("_text") & ~(PAGE_SIZE - 1);
    if (dyn_addr > *addr) {
        TRACE("vmlinux: addr=0x%lx, dyn_addr=0x%lx", *addr, dyn_addr);
        *size -= (dyn_addr - *addr);
        *addr = dyn_addr;
    }
    else if (!dyn_addr) {
        dyn_addr = vtss_kallsyms_lookup_name("_stext") & ~(PAGE_SIZE - 1);
        if (dyn_addr > *addr) {
            TRACE("vmlinux: addr=0x%lx, stext dyn_addr=0x%lx", *addr, dyn_addr);
            *size -= (dyn_addr - *addr);
            *addr = dyn_addr;
        }
    }
#endif
}
