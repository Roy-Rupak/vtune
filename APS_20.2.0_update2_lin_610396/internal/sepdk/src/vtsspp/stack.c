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
#include "stack.h"
#include "globals.h"
#include "record.h"
#include "user_vm.h"
#include "lbr.h"
#include "ksyms.h"
#include "regs.h"
#include "time.h"

#include <linux/highmem.h>      /* for kmap()/kunmap() */
#include <linux/pagemap.h>      /* for page_cache_release() */
#include <asm/page.h>
#include <asm/processor.h>
#include <linux/nmi.h>
#include <linux/module.h>

static int vtss_stack_store_ip(unsigned long addr, unsigned long *prev_addr, char *callchain, int *callchain_pos, int callchain_size)
{
    unsigned long addr_diff;
    int sign;
    char prefix = 0;
    int j;

    addr_diff = addr - (*prev_addr);
    sign = (addr_diff & (((size_t)1) << ((sizeof(size_t) << 3) - 1))) ? 0xff : 0;
    for (j = sizeof(void*) - 1; j >= 0; j--)
    {
        if (((addr_diff >> (j << 3)) & 0xff) != sign)
        {
            break;
        }
    }
    prefix |= sign ? 0x40 : 0;
    prefix |= j + 1;

    if (callchain_size <= (*callchain_pos) + 1 + j + 1) {
        return -1;
    }

    callchain[*callchain_pos] = prefix;
    (*callchain_pos)++;

    *(unsigned long*)&(callchain[*callchain_pos]) = addr_diff;
    (*callchain_pos) += j + 1;
    *prev_addr = addr;
    return 0;
}

#ifdef VTSS_AUTOCONF_STACKTRACE_OPS

#include <asm/stacktrace.h>

#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_WARNING
static void vtss_warning(void *data, char *msg)
{
}

static void vtss_warning_symbol(void *data, char *msg, unsigned long symbol)
{
}
#endif

typedef struct kernel_stack_control_t
{
    unsigned long bp;
    unsigned char *kernel_callchain;
    int *kernel_callchain_size;
    int *kernel_callchain_pos;
    unsigned long prev_addr;
    int done;
} kernel_stack_control_t;

static int vtss_stack_stack(void *data, char *name)
{
    kernel_stack_control_t *stk = (kernel_stack_control_t*)data;
    if (!stk) return -1;
    if (stk->done) {
        ERROR("Error happens during stack processing");
        return -1;
    }
    return 0;
}

static void vtss_stack_address(void *data, unsigned long addr, int reliable)
{
    kernel_stack_control_t *stk = (kernel_stack_control_t*)data;
    TRACE("%s%pB %d", reliable ? "" : "? ", (void*)addr, *stk->kernel_callchain_pos);
    touch_nmi_watchdog();
    if (!reliable) {
        return;
    }
    if (!stk || !stk->kernel_callchain_size || !stk->kernel_callchain_pos) {
        return;
    }
    if ((*stk->kernel_callchain_size) <= (*stk->kernel_callchain_pos)) {
        return;
    }
#ifndef CONFIG_FRAME_POINTER
    if (addr < VTSS_KOFFSET) return;
#endif
    if (stk->done) return;

    if (vtss_stack_store_ip(addr, &stk->prev_addr, stk->kernel_callchain,
        stk->kernel_callchain_pos, *stk->kernel_callchain_size) == -1) {
        stk->done = 1;
    }
}

#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_ADDRESS_INT
static int vtss_stack_address_int(void *data, unsigned long addr, int reliable)
{
    vtss_stack_address(data, addr, reliable);
    return 0;
}
#endif

#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_WALK_STACK
static unsigned long vtss_stack_walk(
#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_WALK_STACK_TASK_ARG
    struct task_struct *t,
#else
    struct thread_info *t,
#endif
    unsigned long *stack,
    unsigned long bp,
    const struct stacktrace_ops *ops,
    void *data,
    unsigned long *end,
    int *graph)
{
    kernel_stack_control_t *stk = (kernel_stack_control_t*)data;
    if (!stk) {
        ERROR("No stack data");
        return bp;
    }
    if (!stack) {
        ERROR("Broken stack pointer");
        stk->done = 1;
        return bp;
    }
    if (stack <= (unsigned long*)VTSS_MAX_USER_SPACE) {
        TRACE("Stack pointer belongs user space. We will not process it, stack_ptr=%p", stack);
        if (stk->kernel_callchain_pos && *stk->kernel_callchain_pos == 0) {
            TRACE("Most probably stack pointer intitialization is wrong. No one stack address is resolved.");
        }
        stk->done = 1;
        return bp;
    }
    if (stk->bp == 0) {
        TRACE("bp=0x%p, stack=0x%p, end=0x%p", (void*)stk->bp, stack, end);
        stk->bp = bp;
    }
    if (stk->done) {
        return bp;
    }
    bp = print_context_stack(t, stack, stk->bp, ops, data, end, graph);
    if (stk != NULL && bp < VTSS_KSTART) {
        TRACE("user bp=0x%p", (void*)bp);
        stk->bp = bp;
    }
    return bp;
}
#endif

static const struct stacktrace_ops vtss_stack_ops = {
#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_WARNING
    .warning        = vtss_warning,
    .warning_symbol = vtss_warning_symbol,
#endif
    .stack          = vtss_stack_stack,
#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_ADDRESS_INT
    .address        = vtss_stack_address_int,
#else
    .address        = vtss_stack_address,
#endif
#ifdef VTSS_AUTOCONF_STACKTRACE_OPS_WALK_STACK
    .walk_stack     = vtss_stack_walk,
#endif
};

static unsigned long vtss_stack_unwind_kernel(struct vtss_transport_data *trnd, stack_control_t *stk, struct task_struct *task, struct pt_regs *regs_in, unsigned long reg_fp)
{
    kernel_stack_control_t k_stk;

    k_stk.bp = reg_fp;
    k_stk.kernel_callchain = stk->kernel_callchain;
    k_stk.prev_addr = 0;
    k_stk.kernel_callchain_size = &stk->kernel_callchain_size;
    k_stk.kernel_callchain_pos =  &stk->kernel_callchain_pos;
    *k_stk.kernel_callchain_pos = 0;
    k_stk.done = 0;
#ifdef VTSS_AUTOCONF_DUMP_TRACE_HAVE_BP
    dump_trace(task, regs_in, NULL, 0, &vtss_stack_ops, &k_stk);
#else
    dump_trace(task, regs_in, NULL, &vtss_stack_ops, &k_stk);
#endif
    if (k_stk.bp) reg_fp = k_stk.bp;
    return reg_fp;
}

#else /* VTSS_AUTOCONF_STACKTRACE_OPS */

#include <asm/unwind.h>

static unsigned long vtss_stack_unwind_kernel(struct vtss_transport_data *trnd, stack_control_t *stk, struct task_struct *task, struct pt_regs *regs_in, unsigned long reg_fp)
{
    struct unwind_state state;
    unsigned long addr, prev_addr = 0;

    stk->kernel_callchain_pos = 0;
    for (unwind_start(&state, task, regs_in, NULL); !unwind_done(&state); unwind_next_frame(&state)) {
        addr = unwind_get_return_address(&state);
        if (!addr) {
            break;
        }
        if (vtss_stack_store_ip(addr, &prev_addr, stk->kernel_callchain,
            &stk->kernel_callchain_pos, stk->kernel_callchain_size) == -1) {
            break;
        }
    }
    return reg_fp;
}
#endif

static int vtss_check_user_fp(struct task_struct *task, stack_control_t *stk, char *fp)
{
    struct vm_area_struct *vma;
    //allow fp from segments differ than stack
    //if (fp < stk->user_sp.chp) return -1;
    //if (fp > stk->bp.chp) return -1;
    if ((unsigned long)fp & (stk->wow64 ? 3 : sizeof(void*) - 1)) return -1;
    vma = find_vma(task->mm, (unsigned long)fp);
    if (vma == NULL) return -1;
    if ((unsigned long)fp < vma->vm_start) return -1;
    if ((unsigned long)fp > vma->vm_end) return -1;
    return 0;
}

static int vtss_check_user_ip(struct task_struct *task, stack_control_t *stk, char *ip)
{
    struct vm_area_struct *vma;
    vma = find_vma(task->mm, (unsigned long)ip);
    if (vma == NULL) return -1;
    if (!(vma->vm_flags & VM_EXEC) && !(vma->vm_flags & VM_MAYEXEC)) return -1;
    if ((unsigned long)ip < vma->vm_start) return -1;
    if ((unsigned long)ip > vma->vm_end) return -1;
    return 0;
}

static int vtss_read_user_frame(stack_control_t *stk, char *curr_sp, char **fp, char **ip)
{
    char vals[2*sizeof(void*)]; /* fp + ip */
    int stride = stk->wow64 ? 4 : sizeof(void*);

    if (vtss_user_vm_read(stk->acc, curr_sp, vals, 2*stride) != 2*stride) {
        return -1;
    }
    *fp = (char*)(size_t)(stk->wow64 ? *(u32*)(&vals[0]) : *(u64*)(&vals[0]));
    *ip = (char*)(size_t)(stk->wow64 ? *(u32*)(&vals[stride]) : *(u64*)(&vals[stride]));
    return 0;
}

static int vtss_stack_unwind_user(struct vtss_transport_data *trnd, stack_control_t *stk, struct task_struct *task)
{
    char *fp = stk->user_fp.chp;
    char *ip = stk->user_ip.chp;
    char *curr_fp = fp;
    char *prev_ip = 0;
    void **buffer;

    stk->user_callchain_pos = 0;
    if (stk->user_callchain == NULL) {
        return 0;
    }
    buffer = (void**)stk->user_callchain;

    TRACE("fp=%p, stack_base=%p, ip=%p", fp, stk->bp.chp, ip);

    if (vtss_check_user_fp(task, stk, fp) == -1) {
        return VTSS_ERR_NOTFOUND; // no frames
    }

    while (curr_fp) {

        if (vtss_read_user_frame(stk, curr_fp, &fp, &ip) == -1) {
            break;
        }
        if (vtss_check_user_fp(task, stk, fp) == -1) break;
        if (vtss_check_user_ip(task, stk, ip) == -1) break;

        curr_fp = fp;
        if (vtss_stack_store_ip((unsigned long)ip, (unsigned long*)&prev_ip,
            stk->user_callchain, &stk->user_callchain_pos, stk->user_callchain_size) == -1) {
            return 0;
        }
    }
    return 0;
}

#ifdef VTSS_USE_OLD_RSP
unsigned long vtss_syscall_rsp_ptr = 0;

static void vtss_lookup_old_rsp(void)
{
    vtss_syscall_rsp_ptr = vtss_kallsyms_lookup_name("old_rsp");
    if (!vtss_syscall_rsp_ptr) vtss_syscall_rsp_ptr = vtss_kallsyms_lookup_name("per_cpu__old_rsp");
    if (!vtss_syscall_rsp_ptr) vtss_syscall_rsp_ptr = vtss_kallsyms_lookup_name("rsp_scratch");
}

static int vtss_in_syscall(void)
{
    if (current->audit_context) {
        if (((int*)current->audit_context)[1]) { /* audit_context->in_syscall */
            return 1;
        }
    }
    return 0;
}

static unsigned long vtss_get_old_rsp(struct task_struct *task)
{
    if (vtss_in_syscall() && !test_tsk_thread_flag(task, TIF_IA32))
    {
        if (vtss_syscall_rsp_ptr)
        {
            /* inside syscall */
            unsigned long old_rsp = *this_cpu_ptr((unsigned long*)vtss_syscall_rsp_ptr);
            if (old_rsp) return old_rsp;
        }
#ifdef VTSS_AUTOCONF_THREAD_STRUCT_USERSP
        /* fast system call or could not get old_rsp */
        if (task->thread.usersp) return task->thread.usersp;
#endif
    }
    return 0;
}
#endif

#ifdef VTSS_USE_CEA_RSP
#include <asm/cpu_entry_area.h>
static unsigned long vtss_get_cea_rsp(void)
{
    int cpu;
    char *entry_stack;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();
    entry_stack = (char*)cpu_entry_stack(cpu);
    if (entry_stack) {
        return *(unsigned long*)(entry_stack + sizeof(struct entry_stack) - 8);
    }
    return 0;
}
#endif

static unsigned long vtss_get_user_sp(struct task_struct *task, struct pt_regs *regs)
{
#ifdef VTSS_USE_OLD_RSP
    unsigned long reg_sp = vtss_get_old_rsp(task);
    if (reg_sp) return reg_sp;
#endif
#ifdef VTSS_USE_CEA_RSP
    unsigned long reg_sp = vtss_get_cea_rsp();
    if (reg_sp) return reg_sp;
#endif
    return REG(sp, regs);
}

int vtss_stack_dump(struct vtss_transport_data *trnd, stack_control_t *stk, struct task_struct *task, struct pt_regs *regs_in, unsigned long reg_fp)
{
    int rc = 0;
    unsigned long stack_base = stk->bp.szt;
    unsigned long reg_ip, reg_sp;
    int kernel_stack = 0;
    struct pt_regs *regs = regs_in;
    int user_mode_regs = 0;

    if ((!regs && reg_fp > VTSS_MAX_USER_SPACE) || (regs && (!vtss_user_mode(regs)))) {
        kernel_stack = 1;
    }
#ifndef CONFIG_FRAME_POINTER
    if (!regs) {
        TRACE("Kernel stack unwinding is disabled");
        kernel_stack = 0;
    }
#endif
    if (regs && vtss_user_mode(regs)) {
        user_mode_regs = 1;
    }

    /* Unwind kernel stack */
    if (kernel_stack && stk->kernel_callchain) {
        if (reg_fp < PAGE_SIZE || reg_fp == -1) reg_fp = 0; /* error instead of bp */
        reg_fp = vtss_stack_unwind_kernel(trnd, stk, task, regs_in, reg_fp);
    } else {
        stk->kernel_callchain_pos = 0;
    }
    if (current != task) {
        /* we will get crash during user space access while unwiding */
        return rc;
    }
    if (regs == NULL || !vtss_user_mode(regs)) {
        /* kernel mode regs, so get a user mode regs */
#if !defined(CONFIG_HIGHMEM)
        if (current->mm) {
            regs = task_pt_regs(task); /* get user mode regs */
        }
        else {
            regs = NULL;
        }
        if (regs == NULL || !vtss_user_mode(regs))
#endif
        {
            /* we might be in kernel thread */
            TRACE("Cannot get user mode registers");
            return rc;
        }
    }

    /* Get IP and SP registers from user space */
    reg_ip = REG(ip, regs);
    reg_sp = user_mode_regs ? REG(sp, regs) : vtss_get_user_sp(task, regs);
    if (reg_fp > VTSS_MAX_USER_SPACE || reg_fp < PAGE_SIZE)
        reg_fp = REG(bp, regs);

    { /* Check for correct stack range in task->mm */
        struct vm_area_struct *vma;

#ifdef VTSS_CHECK_IP_IN_MAP
        /* Check IP in module map */
        vma = find_vma(task->mm, reg_ip);
        if (likely(vma != NULL)) {
            unsigned long vm_start = vma->vm_start;
            unsigned long vm_end   = vma->vm_end;

            if (reg_ip < vm_start ||
                (!((vma->vm_flags & (VM_EXEC | VM_WRITE)) == VM_EXEC &&
                vma->vm_file && vma->vm_file->f_path.dentry) &&
                !(vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso)))
            {
                VTSS_RECORD_DEBUG(trnd, "ip = 0x%lx not in valid VMA", reg_ip);
                return -EFAULT;
            }
        }
        else {
            VTSS_RECORD_DEBUG(trnd, "No VMA on ip = 0x%lx", reg_ip);
            return -EFAULT;
        }
#endif

        /* Check SP in module map */
        vma = find_vma(task->mm, reg_sp);
        if (likely(vma != NULL)) {
            unsigned long vm_start = vma->vm_start;
            unsigned long vm_end   = vma->vm_end;
            unsigned long stack_limit = reqcfg.stk_sz[vtss_stk_user];

            if (reg_sp < vm_start || (vma->vm_flags & (VM_READ | VM_WRITE)) != (VM_READ | VM_WRITE)) {
                VTSS_RECORD_DEBUG(trnd, "sp = 0x%lx not in valid VMA", reg_sp);
                return -EFAULT;
            }
            if (!(stack_base >= vm_start && stack_base <= vm_end) || (stack_base <= reg_sp)) {
                if (stack_base) TRACE("Fixup stack [0x%lx-0x%lx] -> [0x%lx-0x%lx]", reg_sp, stack_base, reg_sp, vm_end);
                stack_base = vm_end;
                vtss_clear_stack(stk);
            }
            if (stack_limit == 0) stack_limit = VTSS_STACK_LIMIT;
            if (stack_base - reg_sp > stack_limit) {
                unsigned long stack_base_limit = (reg_sp + stack_limit + (PAGE_SIZE-1)) & (~(PAGE_SIZE-1));
                TRACE("Limit stack [0x%lx-0x%lx] -> [0x%lx-0x%lx]", reg_sp, stack_base, reg_sp, stack_base_limit);
                stack_base = stack_base_limit;
            }
        } else {
            VTSS_RECORD_DEBUG(trnd, "No VMA on sp = 0x%lx", reg_sp);
            return -EFAULT;
        }
    }

    /* Try to lock vm accessor */
    if (unlikely((stk->acc == NULL) || vtss_user_vm_trylock(stk->acc, task))) {
        VTSS_RECORD_DEBUG(trnd, "Unable to lock VM accessor");
        return -EBUSY;
    }

    stk->user_ip.szt = reg_ip;
    stk->user_sp.szt = reg_sp;
    stk->bp.szt = stack_base;
    stk->user_fp.szt = reg_fp;

    /* Unwind using FP */
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_CLRSTK) {
        rc = vtss_stack_unwind_user(trnd, stk, task);
        if (stk->user_callchain_pos != 0) {
            vtss_user_vm_unlock(stk->acc);
            return rc;
        }
    }

    rc = vtss_unwind_stack_fwd(stk);
    if (unlikely(rc)) {
        VTSS_RECORD_DEBUG(trnd, "Unwind error: %d: cpuidx = 0x%08x, ip = 0x%lx, stack = [0x%lx, 0x%lx], fp = 0x%lx",
            rc, raw_smp_processor_id(), stk->user_ip.szt, stk->user_sp.szt, stk->bp.szt, stk->user_fp.szt);
        vtss_clear_stack(stk);
    }
    TRACE("Unwound %ld elements of %s stack", (stk->stkmap_end - stk->stkmap_start)/sizeof(stkmap_t),
        stk->stkmap_common == stk->stkmap_end ? "full" : "incremental");

    vtss_user_vm_unlock(stk->acc);
    return rc;
}

int vtss_stack_record_kernel(struct vtss_transport_data *trnd, stack_control_t *stk, pid_t tid, int cpu)
{
    int rc = -EFAULT;
    int stklen = stk->kernel_callchain_pos;
    stk_trace_kernel_record_t stkrec;

    if (stklen == 0)
    {
        // kernel is empty
        VTSS_RECORD_DEBUG(trnd, "Kernel stack is empty");
        return 0;
    }
    //implementation is done for UEC NOT USED
    /// save current alt. stack:
    /// [flagword - 4b][residx]
    /// ...[sampled address - 8b][systrace{sts}]
    ///                       [length - 2b][type - 2b]...
    stkrec.flagword = UEC_LEAF1 | UECL1_VRESIDX | UECL1_SYSTRACE;
    stkrec.residx   = tid;
    stkrec.size     = sizeof(stkrec.size) + sizeof(stkrec.type);
    stkrec.type     = (sizeof(void*) == 8) ? UECSYSTRACE_CLEAR_STACK64 : UECSYSTRACE_CLEAR_STACK32;
    stkrec.size += sizeof(unsigned int);
    stkrec.idx   = -1;
    /// correct the size of systrace
    stkrec.size += (unsigned short)stklen;
    if (vtss_transport_record_write(trnd, &stkrec, sizeof(stkrec), stk->kernel_callchain, stklen)) {
        TRACE("STACK_record_write() FAIL");
        rc = -EFAULT;
    }

    return rc;
}

int vtss_stack_record_user(struct vtss_transport_data *trnd, stack_control_t *stk, pid_t tid, int cpu)
{
    int rc = 0;
    int stklen = stk->user_callchain_pos;
    clrstk_trace_record_t stkrec;

    if (stklen == 0)
    {
        // user clean stack is empty
        return 0;
    }
    /// save current alt. stack in UEC: [flagword - 4b][residx][cpuidx - 4b][tsc - 8b]
    ///                                 ...[sampled address - 8b][systrace{sts}]
    ///                                                          [length - 2b][type - 2b]...
    stkrec.flagword = UEC_LEAF1 | UECL1_VRESIDX | UECL1_CPUIDX | UECL1_CPUTSC | UECL1_EXECADDR | UECL1_SYSTRACE;
    stkrec.residx = tid;
    stkrec.cpuidx = cpu;
    stkrec.cputsc = vtss_time_cpu();
    stkrec.execaddr = (unsigned long long)stk->user_ip.szt;

    stkrec.size = sizeof(stkrec.size) + sizeof(stkrec.type) + sizeof(stkrec.merge_node) + (unsigned short)stklen;
    stkrec.type = (sizeof(void*) == 8) ? UECSYSTRACE_CLEAR_STACK64 : UECSYSTRACE_CLEAR_STACK32;
    stkrec.merge_node = 0xffffffff;

    if (vtss_transport_record_write(trnd, &stkrec, sizeof(stkrec), stk->user_callchain, stklen))
    {
        TRACE("STACK_record_write() FAIL");
        rc = -EFAULT;
    }

    return rc;
}

int vtss_stack_record(struct vtss_transport_data *trnd, stack_control_t *stk, pid_t tid, int cpu)
{
    int rc = -EFAULT;
    unsigned short sample_type;
    int sktlen = 0;
    stk_trace_record_t stkrec;

    /// collect LBR call stacks if so requested
    if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_LBRCSTK)
    {
        return vtss_stack_record_lbr(trnd, stk, tid, cpu);
    }
    /// skip compress dirty stack if clean is present
    if (stk->user_callchain_pos == 0)
    {
        sktlen = vtss_compress_stack(stk);
    }

    if (stk->kernel_callchain_pos != 0)
    {
        rc = vtss_stack_record_kernel(trnd, stk, tid, cpu);
    }
    else
    {
        TRACE("kernel stack is empty");
    }
    /// record clean stack
    if (stk->user_callchain_pos != 0) {
        return vtss_stack_record_user(trnd, stk, tid, cpu);
    }

    if (unlikely(sktlen == 0)) {
        VTSS_RECORD_DEBUG(trnd, "User stack is empty: tid = 0x%08x, cpuidx = 0x%08x, ip = 0x%lx, stack = [0x%lx, 0x%lx], fp = 0x%lx",
            tid, raw_smp_processor_id(), stk->user_ip.szt, stk->user_sp.szt, stk->bp.szt, stk->user_fp.szt);
        return 0;
    }

    if (vtss_is_full_stack(stk)) { /* full stack */
        sample_type = (sizeof(void*) == 8 && !stk->wow64) ? UECSYSTRACE_STACK_CTX64_V0 : UECSYSTRACE_STACK_CTX32_V0;
    } else { /* incremental stack */
        sample_type = (sizeof(void*) == 8 && !stk->wow64) ? UECSYSTRACE_STACK_CTXINC64_V0 : UECSYSTRACE_STACK_CTXINC32_V0;
    }

    /// save current alt. stack:
    /// [flagword - 4b][residx][cpuidx - 4b][tsc - 8b]
    /// ...[sampled address - 8b][systrace{sts}]
    ///                       [length - 2b][type - 2b]...
    stkrec.flagword = UEC_LEAF1 | UECL1_VRESIDX | UECL1_CPUIDX | UECL1_CPUTSC | UECL1_EXECADDR | UECL1_SYSTRACE;
    stkrec.residx   = tid;
    stkrec.cpuidx   = cpu;
    stkrec.cputsc   = vtss_time_cpu();
    stkrec.execaddr = (unsigned long long)stk->user_ip.szt;
    stkrec.type     = sample_type;

    if (!stk->wow64) {
        stkrec.size = 4 + sizeof(void*) + sizeof(void*);
        stkrec.sp   = stk->user_sp.szt;
        stkrec.fp   = stk->user_fp.szt;
    } else { /// a 32-bit stack in a 32-bit process on a 64-bit system
        stkrec.size = 4 + sizeof(unsigned int) + sizeof(unsigned int);
        stkrec.sp32 = (unsigned int)stk->user_sp.szt;
        stkrec.fp32 = (unsigned int)stk->user_fp.szt;
    }
    rc = 0;
    if (sktlen > 0xfffb) {
        lstk_trace_record_t lstkrec;

        lstkrec.size = (unsigned int)(stkrec.size + sktlen + 2); /* 2 = sizeof(int) - sizeof(short) */
        lstkrec.flagword = UEC_LEAF1 | UECL1_VRESIDX | UECL1_CPUIDX | UECL1_CPUTSC | UECL1_EXECADDR | UECL1_LARGETRACE;
        lstkrec.residx   = stkrec.residx;
        lstkrec.cpuidx   = stkrec.cpuidx;
        lstkrec.cputsc   = stkrec.cputsc;
        lstkrec.execaddr = stkrec.execaddr;
        lstkrec.type     = stkrec.type;
        lstkrec.sp       = stkrec.sp;
        lstkrec.fp       = stkrec.fp;
        if (vtss_transport_record_write(trnd, &lstkrec, sizeof(lstkrec) - (stk->wow64*8), stk->compressed, sktlen)) {
            TRACE("STACK_record_write() FAIL");
            rc = -EFAULT;
        }
    } else {
        /// correct the size of systrace
        stkrec.size += (unsigned short)sktlen;
        if (vtss_transport_record_write(trnd, &stkrec, sizeof(stkrec) - (stk->wow64*8), stk->compressed, sktlen)) {
            TRACE("STACK_record_write() FAIL");
            rc = -EFAULT;
        }
    }
    return rc;
}

