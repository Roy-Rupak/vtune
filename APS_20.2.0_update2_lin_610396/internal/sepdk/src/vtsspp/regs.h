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
#ifndef _VTSS_REGS_H_
#define _VTSS_REGS_H_

#include "config.h"

#ifdef VTSS_AUTOCONF_USER_MODE_VM
#define vtss_user_mode(regs) user_mode_vm(regs)
#else
#define vtss_user_mode(regs) user_mode(regs)
#endif

#ifdef VTSS_AUTOCONF_X86_UNIREGS
#define REG(name, regs) ((regs)->name)
#else
#define REG(name, regs) ((regs)->r##name)
#endif

static inline unsigned long vtss_read_rbp(void)
{
    unsigned long val;
    asm volatile("movq %%rbp, %0" : "=r"(val));
    return val;
}

#include <asm/msr.h>

static inline long long vtss_read_msr(int idx)
{
    long long val;
    rdmsrl(idx, val);
    return val;
}

#ifndef X86_CR4_PCE
#define X86_CR4_PCE 0x100
#endif

static inline unsigned long vtss_read_cr4(void)
{
    unsigned long val;
    asm volatile("movq %%cr4, %0" : "=r" (val));
    return val;
}

static inline void vtss_write_cr4(unsigned long val)
{
    asm volatile("movq %0, %%cr4" :: "r" (val) : "memory");
}
#endif
