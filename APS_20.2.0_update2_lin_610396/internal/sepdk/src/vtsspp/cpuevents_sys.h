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
#ifndef _VTSS_CPUEVENTS_SYS_H_
#define _VTSS_CPUEVENTS_SYS_H_

/// SNB power MSRs
#define VTSS_MSR_PKG_ENERGY_STATUS  0x611
#define VTSS_MSR_PP0_ENERGY_STATUS  0x639
#define VTSS_MSR_PP1_ENERGY_STATUS  0x641
#define VTSS_MSR_DRAM_ENERGY_STATUS 0x619

sysevent_desc_t sysevent_desc[] = {
    {"Synchronization Context Switches", "Thread being swapped out due to contention on a synchronization object"},
    {"Preemption Context Switches", "Thread being preempted by the OS scheduler"},
    {"Wait Time", "Time while the thread is waiting on a synchronization object"},
    {"Inactive Time", "Time while the thread is preempted and resides in the ready queue"},
    {"Idle Time", "Time while no other thread was active before activating the current thread"},
    {"Idle Wakeup", "Thread waking up the system from idleness"},
    {"C3 Residency", "Time in low power sleep mode with all but the shared cache flushed"},
    {"C6 Residency", "Time in low power sleep mode with all caches flushed"},
    {"C7 Residency", "Time in low power sleep mode with all caches flushed and powered off"},
    {"Energy Core", "Energy (uJoules) consumed by the processor core"},
    {"Energy GFX", "Energy (uJoules) consumed by the uncore graphics"},
    {"Energy Pack", "Energy (uJoules) consumed by the processor package"},
    {"Energy DRAM", "Energy (uJoules) consumed by the memory"},
    {"Charge SoC", "Charge (Coulombs) consumed by the system"},
    {NULL, NULL}
};

/// system event control virtual functions
static void vf_sys_start(cpuevent_t *this)
{
}

static void vf_sys_stop(cpuevent_t *this)
{
}

static void vf_sys_read(cpuevent_t *this)
{
}

static void vf_sys_freeze(cpuevent_t *this)
{
}

static void vf_sys_restart(cpuevent_t *this)
{
    switch (this->interval) {
    case vtss_sysevent_sync_cs:
        break;
    case vtss_sysevent_preempt_cs:
        break;
    case vtss_sysevent_wait_time:
        break;
    case vtss_sysevent_inactive_time:
        break;

    case vtss_sysevent_energy_core:
        rdmsrl(VTSS_MSR_PP0_ENERGY_STATUS, this->frozen_count);
        this->frozen_count &= 0xffffffffLL;
        break;

    case vtss_sysevent_energy_gfx:
        rdmsrl(VTSS_MSR_PP1_ENERGY_STATUS, this->frozen_count);
        this->frozen_count &= 0xffffffffLL;
        break;

    case vtss_sysevent_energy_pack:
        rdmsrl(VTSS_MSR_PKG_ENERGY_STATUS, this->frozen_count);
        this->frozen_count &= 0xffffffffLL;
        break;

    case vtss_sysevent_energy_dram:
        rdmsrl(VTSS_MSR_DRAM_ENERGY_STATUS, this->frozen_count);
        this->frozen_count &= 0xffffffffLL;
        break;

    case vtss_sysevent_energy_soc:
        break;
    default:
        break;
    }
}

static void vf_sys_freeze_read(cpuevent_t *this)
{
    long long tmp;

    switch (this->interval) {
    case vtss_sysevent_sync_cs:
        break;
    case vtss_sysevent_preempt_cs:
        break;
    case vtss_sysevent_wait_time:
        break;
    case vtss_sysevent_inactive_time:
        break;

    case vtss_sysevent_energy_core:

        rdmsrl(VTSS_MSR_PP0_ENERGY_STATUS, tmp);
        tmp &= 0xffffffffLL;

        if (tmp < this->frozen_count) {
            tmp += 0x100000000LL;
        }
        this->count += (tmp - this->frozen_count) << 4;
        break;

    case vtss_sysevent_energy_gfx:

        rdmsrl(VTSS_MSR_PP1_ENERGY_STATUS, tmp);
        tmp &= 0xffffffffLL;

        if (tmp < this->frozen_count) {
            tmp += 0x100000000LL;
        }
        this->count += (tmp - this->frozen_count) << 4;
        break;

    case vtss_sysevent_energy_pack:

        rdmsrl(VTSS_MSR_PKG_ENERGY_STATUS, tmp);
        tmp &= 0xffffffffLL;

        if (tmp < this->frozen_count) {
            tmp += 0x100000000LL;
        }
        this->count += (tmp - this->frozen_count) << 4;
        break;

    case vtss_sysevent_energy_dram:

        rdmsrl(VTSS_MSR_DRAM_ENERGY_STATUS, tmp);
        tmp &= 0xffffffffLL;

        if (tmp < this->frozen_count) {
            tmp += 0x100000000LL;
        }
        this->count += (tmp - this->frozen_count) << 4;
        break;

    case vtss_sysevent_energy_soc:
        break;
    default:
        break;
    }
}

static int vf_sys_overflowed(cpuevent_t *this)
{
    return 0;
}

static long long vf_sys_convert(cpuevent_t *this)
{
    return 0;
}

static void vf_sys_overflow_update(cpuevent_t *this)
{
}

/* this->tmp: positive - update and restart, negative - just restart
 *  0 - reset counter,
 *  1 - switch_to,
 *  2 - preempt,
 *  3 - sync,
 * -1 - switch_to no update,
 * -2 - preempt no update,
 * -3 - sync no update
 */
static void vf_sys_update_restart(cpuevent_t *this)
{
    switch (this->interval) {
    case vtss_sysevent_sync_cs:

        if (this->tmp == 3) { /* sync */
            this->count++;
        }
        break;

    case vtss_sysevent_preempt_cs:

        if (this->tmp == 2) { /* preempt */
            this->count++;
        }
        break;

    case vtss_sysevent_wait_time:

        if (this->tmp == 1 && this->frozen_count) { /* switch_to */
            this->count += vtss_time_cpu() - this->frozen_count;
            this->frozen_count = 0;
        } else if (abs(this->tmp) == 3) { /* sync */
            this->frozen_count = vtss_time_cpu();
        } else {
            this->frozen_count = 0;
        }
        break;

    case vtss_sysevent_inactive_time:

        if (this->tmp == 1 && this->frozen_count) { /* switch_to */
            this->count += vtss_time_cpu() - this->frozen_count;
            this->frozen_count = 0;
        } else if (abs(this->tmp) == 2) { /* preempt */
            this->frozen_count = vtss_time_cpu();
        } else {
            this->frozen_count = 0;
        }
        break;

    case vtss_sysevent_idle_time:
        break;
    case vtss_sysevent_idle_wakeup:
        break;
    case vtss_sysevent_idle_c3:
        break;
    case vtss_sysevent_idle_c6:
        break;
    case vtss_sysevent_idle_c7:
        break;
    case vtss_sysevent_energy_core:
        break;
    case vtss_sysevent_energy_gfx:
        break;
    case vtss_sysevent_energy_pack:
        break;
    case vtss_sysevent_energy_dram:
        break;
    case vtss_sysevent_energy_soc:
        break;
    default:
        break;
    }
}

static int vf_sys_select_muxgroup(cpuevent_t *this)
{
    return -1;
}

/// system virtual function tables
static cpuevent_i vft_sys = {
    vf_sys_start,
    vf_sys_stop,
    vf_sys_read,
    vf_sys_freeze,
    vf_sys_restart,
    vf_sys_freeze_read,
    vf_sys_overflowed,
    vf_sys_convert,
    vf_sys_overflow_update,
    vf_sys_update_restart,
    vf_sys_select_muxgroup
};

sysevent_e sysevent_type[] = {
    vtss_sysevent_sync_cs,
    vtss_sysevent_preempt_cs,
    vtss_sysevent_wait_time,
    vtss_sysevent_inactive_time,
    vtss_sysevent_idle_time,
    vtss_sysevent_idle_wakeup,
    vtss_sysevent_idle_c3,
    vtss_sysevent_idle_c6,
    vtss_sysevent_idle_c7,
    vtss_sysevent_energy_core,
    vtss_sysevent_energy_gfx,
    vtss_sysevent_energy_pack,
    vtss_sysevent_energy_dram,
    vtss_sysevent_energy_soc,
    vtss_sysevent_end
};
#endif
