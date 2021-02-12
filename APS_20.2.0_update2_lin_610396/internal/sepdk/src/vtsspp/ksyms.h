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
#ifndef _VTSS_KSYMS_H_
#define _VTSS_KSYMS_H_

#include "config.h"

#include <linux/kallsyms.h>
unsigned long vtss_kallsyms_lookup_name(const char *name);

#define VTSS_KOFFSET ((unsigned long)__START_KERNEL_map)
#define VTSS_MAX_USER_SPACE 0x7fffffffffff

#ifndef KERNEL_IMAGE_SIZE
#define KERNEL_IMAGE_SIZE (512*1024*1024)
#endif

#define VTSS_KSTART (VTSS_KOFFSET + ((CONFIG_PHYSICAL_START + (CONFIG_PHYSICAL_ALIGN - 1)) & ~(CONFIG_PHYSICAL_ALIGN - 1)))
#define VTSS_KSIZE  ((unsigned long)KERNEL_IMAGE_SIZE - ((CONFIG_PHYSICAL_START + (CONFIG_PHYSICAL_ALIGN - 1)) & ~(CONFIG_PHYSICAL_ALIGN - 1)) - 1)

void vtss_get_kstart(unsigned long *addr, unsigned long *size);

#endif
