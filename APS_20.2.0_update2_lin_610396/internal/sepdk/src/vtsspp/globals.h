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
#ifndef _VTSS_GLOBALS_H_
#define _VTSS_GLOBALS_H_

#include "config.h"
#include "ipt.h"

#define VTSS_SCRATCH_SIZE 0x10000

#pragma pack(push, 1)

typedef struct
{
    int version;

    short type;
    short major;
    short minor;
    short extra;
    short spack;

    short len;
    union
    {
        char host_name[1];
        char brand_name[1];
        char sysid_string[1];
        char system_root_dir[1];
        char placeholder[VTSS_CFG_SPACE_SIZE];
    };
    int record_size;

} vtss_syscfg_t;

typedef struct
{
    int version;

    short int cpu_chain_len;
    cpuevent_cfg_v1_t cpu_chain[1];

    short int exectx_chain_len;
    exectx_cfg_t exectx_chain[1];

    short int chip_chain_len;
    chipevent_cfg_t chip_chain[1];

    short int os_chain_len;
    osevent_cfg_t os_chain[1];

} vtss_softcfg_t;

typedef struct
{
    int version;

    long long cpu_freq;                     /// Hz
    long long timer_freq;                   /// realtsc, Hz
    long long maxusr_address;
    unsigned char os_sp;
    unsigned char os_minor;
    unsigned char os_major;
    unsigned char os_type;

    unsigned char mode;                     /// 32- or 64-bit
    unsigned char family;
    unsigned char model;
    unsigned char stepping;

    int cpu_no;

    struct
    {
        unsigned char node;
        unsigned char pack;
        unsigned char core;
        unsigned char thread;

    } cpu_map[NR_CPUS];   /// stored truncated to cpu_no elements

} vtss_hardcfg_t;

typedef struct
{
    int version;

    unsigned int fratio;    /// MSR_PLATFORM_INFO[15:8]; max non-turbo ratio
    unsigned int ctcnom;    /// RATIO_P = CPUID[21].EBX / CPUID[21].EAX; ratio of ART/CTC to TSC
    unsigned int tscdenom;
    unsigned int mtcfreq;   /// IA32_RTIT_CTL.MTCFreq
} vtss_iptcfg_t;

/**
 * per-processor control structures and declarations
 */
typedef struct processor_control_block
{
    /// save area
    unsigned long saved_msr_ovf;    /// saved value of IA32_PERF_GLOBAL_OVF_CTRL
    unsigned long saved_msr_perf;   /// saved value of IA32_PERF_GLOBAL_CTRL
    unsigned long saved_msr_debug;  /// saved value of IA32_DEBUGCTL
    unsigned long saved_msr_dsa;    /// saved value of DS_AREA_MSR
    unsigned long saved_apic_lvtpc; /// saved value of APIC_LVTPC

    /// operating state
    void *dsa_ptr;                  /// Debug Store Area pointer
    void *bts_ptr;                  /// Branch Trace Store pointer
    void *bts_vaddr;                /// Branch Trace Store saved virtual address
    void *pebs_ptr;                 /// Precise Event-Based Sampling pointer
    void *pebs_vaddr;               /// Precise Event-Based Sampling saved virtual address
    void *scratch_ptr;              /// Scratch-pad memory pointer

    /// IPT memory
    void *topa_virt;                /// virtual address of IPT ToPA
    void *iptbuf_virt;              /// virtual address of IPT output buffer
    unsigned long long topa_phys;   /// physical address of IPT ToPA
    unsigned long long iptbuf_phys[IPT_BUF_NO]; /// physical address of IPT output buffer
    unsigned long pce_state; /// need to disable access to rdpmc on collection end
} vtss_pcb_t;
#pragma pack(pop)

DECLARE_PER_CPU_SHARED_ALIGNED(vtss_pcb_t, vtss_pcb);

#ifndef __get_cpu_var
#define __get_cpu_var(var) (*this_cpu_ptr(&(var)))
#endif
#define pcb(cpu) per_cpu(vtss_pcb, cpu)
#define pcb_cpu __get_cpu_var(vtss_pcb)

extern vtss_syscfg_t  syscfg;
extern vtss_hardcfg_t hardcfg;
extern vtss_iptcfg_t  iptcfg;
extern fmtcfg_t       fmtcfg[2];
extern process_cfg_t  reqcfg;

void vtss_globals_fini(void);
int vtss_globals_init(void);

void vtss_reqcfg_init(void);
int vtss_reqcfg_verify(void);

#endif
