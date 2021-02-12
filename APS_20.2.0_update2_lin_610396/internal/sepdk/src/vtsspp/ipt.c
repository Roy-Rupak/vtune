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
#include "ipt.h"
#include "cpuevents.h"
#include "globals.h"
#include "regs.h"
#include "time.h"

#include <asm/io.h>

/**
// Intel Processor Trace functionality
*/

int vtss_ipt_init(void)
{
    int i, j;
    int res = 0;
    /// for each CPU:
    ///   allocate ToPA page
    ///   allocate output buffer
    ///   free all buffers in case of error
    for (i = 0; i < hardcfg.cpu_no; i++)
    {
        if ((pcb(i).topa_virt = kmalloc((size_t)IPT_BUF_SIZE, GFP_KERNEL)))
        {
            pcb(i).topa_phys = (unsigned long long)virt_to_phys(pcb(i).topa_virt);
        }
        else
        {
            ERROR("Cannot allocate IPT ToPA buffer");
            res = VTSS_ERR_NOMEMORY;
        }
        if ((pcb(i).iptbuf_virt = kmalloc(IPT_BUF_SIZE*IPT_BUF_NO, GFP_KERNEL)))
        {
            for (j = 0; j < IPT_BUF_NO; j++)
            {
                pcb(i).iptbuf_phys[j] = (unsigned long long)virt_to_phys(pcb(i).iptbuf_virt+ j * IPT_BUF_SIZE);
            }
        }
        else
        {
            ERROR("Cannot allocate IPT output buffer");
            res = VTSS_ERR_NOMEMORY;
        }
    }
    if (res == 0) REPORT("IPT is enabled");
    /// check for errors and free all buffers if any
    return res;
}

static void vtss_init_ipt(void)
{
    long long tmp = vtss_read_msr(IPT_CONTROL_MSR);

    wrmsrl(IPT_CONTROL_MSR, tmp & ~1L);

    wrmsrl(IPT_CONTROL_MSR, 0);
    wrmsrl(IPT_STATUS_MSR, 0);
    wrmsrl(IPT_OUT_BASE_MSR, 0);
    wrmsrl(IPT_OUT_MASK_MSR, 0);
}

static void vtss_ipt_disable_on_each_cpu(void *ctx)
{
    vtss_disable_ipt();
}

void vtss_ipt_fini(void)
{
    int i;
    on_each_cpu(vtss_ipt_disable_on_each_cpu, NULL, 1);
    for (i = 0; i < hardcfg.cpu_no; i++)
    {
        if (pcb(i).topa_virt)
        {
            kfree(pcb(i).topa_virt);
            pcb(i).topa_virt = 0;
            pcb(i).topa_phys = 0;
        }
        if (pcb(i).iptbuf_virt)
        {
            kfree(pcb(i).iptbuf_virt);
            pcb(i).iptbuf_virt = 0;
            memset(pcb(i).iptbuf_phys, 0, sizeof(pcb(i).iptbuf_phys));
        }
    }
}

// return value:
// 0 - ipt is not supported
// 1 - base ipt support
// 2 - ipt supports multiple output entries, iptmode_time, etc
int vtss_ipt_support_level(void)
{
    if (hardcfg.family == VTSS_FAM_P6 && (
        hardcfg.model == VTSS_CPU_BDW   ||
        hardcfg.model == VTSS_CPU_BDW_G ||
        hardcfg.model == VTSS_CPU_BDW_X ||
        hardcfg.model == VTSS_CPU_BDW_XD))
        return 1;

    if (hardcfg.family == VTSS_FAM_P6 && (
        hardcfg.model == VTSS_CPU_SKL   ||
        hardcfg.model == VTSS_CPU_SKL_M ||
        hardcfg.model == VTSS_CPU_SKL_X ||
        hardcfg.model == VTSS_CPU_KBL   ||
        hardcfg.model == VTSS_CPU_KBL_M ||
        hardcfg.model == VTSS_CPU_CNL   ||
        hardcfg.model == VTSS_CPU_CNL_M ||
        hardcfg.model == VTSS_CPU_ICL   ||
        hardcfg.model == VTSS_CPU_ICL_M ||
        hardcfg.model == VTSS_CPU_ICL_X ||
        hardcfg.model == VTSS_CPU_ICL_XD))
        return 2;

    return 0;
}

int vtss_has_ipt_overflowed(void)
{
    return 0;
}

void vtss_enable_ipt(unsigned int mode, int is_kernel)
{
    int i;
    vtss_pcb_t *pcbp = &pcb_cpu;

    long long tmp = vtss_read_msr(IPT_CONTROL_MSR);
    long long msr_val = 0x2500;

    TRACE("enable IPT");
    wrmsrl(IPT_CONTROL_MSR, tmp & ~1L);

    /// disable LBRs and BTS
    wrmsrl(VTSS_IA32_DEBUGCTL, 0);

    if (vtss_ipt_support_level() > 1)
    {
        /// form ToPA, and initialize status, base and mask pointers and control MSR
        for (i = 0; i < IPT_BUF_NO; i++)
        {
            ((unsigned long long*)pcbp->topa_virt)[i] = pcbp->iptbuf_phys[i];
        }
        if (mode & vtss_iptmode_full)
        {
            ((unsigned long long*)pcbp->topa_virt)[IPT_BUF_NO / 4 * 3] |= 0x04;    /// INT
            ((unsigned long long*)pcbp->topa_virt)[IPT_BUF_NO - 1] |= 0x10;    /// STOP
        }
        else
        {
            ((unsigned long long*)pcbp->topa_virt)[0] |= 0x10;    /// STOP
        }

        ((unsigned long long*)pcbp->topa_virt)[i] = pcbp->topa_phys | 0x1;
        if ((mode & vtss_iptmode_time)) msr_val |= 0x2; //PSB+TSC+CYC
    }
    else
    {
        /// form ToPA, and initialize status, base and mask pointers and control MSR
        if (mode & vtss_iptmode_full)
        {
            ((unsigned long long*)pcbp->topa_virt)[0] = pcbp->iptbuf_phys[0] | 0x14;    /// STOP | INT ///Full-PT addition
        }
        else
        {
            ((unsigned long long*)pcbp->topa_virt)[0] = pcbp->iptbuf_phys[0] | 0x10;    /// STOP
        }

        ((unsigned long long*)pcbp->topa_virt)[1] = pcbp->topa_phys | 0x1;
    }

    wrmsrl(IPT_OUT_MASK_MSR, 0x7f);
    wrmsrl(IPT_OUT_BASE_MSR, pcbp->topa_phys);
    wrmsrl(IPT_STATUS_MSR, 0);

    msr_val |= (is_kernel) ? 0x4/*kernel mode*/ : 0x8/*user mode*/;
    if (mode & vtss_iptmode_ring0) msr_val |= 0x4; // + kernel-mode

    wrmsrl(IPT_CONTROL_MSR, msr_val);
    wrmsrl(IPT_CONTROL_MSR, msr_val+1);

}

void vtss_disable_ipt(void)
{
    long long tmp = vtss_read_msr(IPT_CONTROL_MSR);

    wrmsrl(IPT_CONTROL_MSR, tmp & ~1L);
    /// clear control MSR
    wrmsrl(IPT_CONTROL_MSR, 0);
}

int vtss_record_ipt_overflow(struct vtss_transport_data *trnd, int tidx, int cpu)
{
    int rc = -1;
    ipt_trace_record_t iptrec;
    iptrec.flagword = UEC_LEAF1 | UECL1_VRESIDX | UECL1_CPUIDX | UECL1_CPUTSC | UECL1_SYSTRACE;
    iptrec.residx = (unsigned int)tidx;
    preempt_disable();
    iptrec.cpuidx = (unsigned int)smp_processor_id();
    preempt_enable_no_resched();
    iptrec.cputsc = vtss_time_cpu();
    iptrec.type = UECSYSTRACE_IPTOVF;
    iptrec.size = (unsigned short)(sizeof(iptrec.size) + sizeof(iptrec.type));
    rc = vtss_transport_record_write(trnd, &iptrec, sizeof(iptrec), NULL, 0);
    return rc;
}

void vtss_dump_ipt(struct vtss_transport_data *trnd, int tidx, int cpu, int *is_ipt_trace_ovf)
{
    unsigned short size;

    /// form IPT record and save the contents of the output buffer (from base to current mask pointer)

    if ((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) && vtss_ipt_support_level())
    {
        ipt_trace_record_t iptrec;

        TRACE("IPT before reset: Control = %llX; Status = %llX; Base = %llX; Mask = %llX",
                vtss_read_msr(IPT_CONTROL_MSR), vtss_read_msr(IPT_STATUS_MSR), vtss_read_msr(IPT_OUT_BASE_MSR), vtss_read_msr(IPT_OUT_MASK_MSR));

        if (*is_ipt_trace_ovf)
        {
            if (vtss_record_ipt_overflow(trnd, tidx, cpu))
            {
                vtss_init_ipt();
                return;
            }
            else
            {
                *is_ipt_trace_ovf = 0;
            }
        }
        //vtss_disable_ipt();
        size = (unsigned short)(((unsigned long long)vtss_read_msr(IPT_OUT_MASK_MSR) >> 32) & 0xffff);
        size += (unsigned short)(((unsigned long long)vtss_read_msr(IPT_OUT_MASK_MSR) & 0xffffff80L) << 5);

        /// [flagword][residx][cpuidx][tsc][systrace(bts)]
        iptrec.flagword = UEC_LEAF1 | UECL1_VRESIDX | UECL1_CPUIDX | UECL1_CPUTSC | UECL1_SYSTRACE;
        iptrec.residx = (unsigned int)tidx;
        preempt_disable();
        iptrec.cpuidx = (unsigned int)smp_processor_id();
        preempt_enable_no_resched();
        iptrec.cputsc = vtss_time_cpu();
        iptrec.type = UECSYSTRACE_IPT;
        iptrec.size = (unsigned short)(size + sizeof(iptrec.size) + sizeof(iptrec.type));

        if (vtss_transport_record_write(trnd, &iptrec, sizeof(ipt_trace_record_t), pcb_cpu.iptbuf_virt, size)) {
            *is_ipt_trace_ovf = 1;
            vtss_init_ipt();
            return;
        }
        vtss_init_ipt();
        TRACE("IPT after reset: Control = %llX; Status = %llX; Base = %llX; Mask = %llX",
            vtss_read_msr(IPT_CONTROL_MSR), vtss_read_msr(IPT_STATUS_MSR), vtss_read_msr(IPT_OUT_BASE_MSR), vtss_read_msr(IPT_OUT_MASK_MSR));
    }
}
