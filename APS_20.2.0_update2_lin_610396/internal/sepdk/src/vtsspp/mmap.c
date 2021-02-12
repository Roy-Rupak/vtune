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
#include "mmap.h"
#include "task_data.h"
#include "task_map.h"
#include "task_util.h"
#include "cmd.h"
#include "record.h"
#include "ksyms.h"
#include "time.h"
#include "user_vm.h"
#include "mpool.h"

#include <linux/module.h>
#include <asm/pgtable.h>
#include <asm/fixmap.h>         /* VSYSCALL_START */

#ifndef MODULES_VADDR
#define MODULES_VADDR VMALLOC_START
#endif

int vtss_kmap_all(struct vtss_task_data *tskd)
{
    struct module *mod;
    struct list_head *modules;
    long long cputsc, realtsc;
    unsigned long addr, size;
    int repeat = 0;

    if (VTSS_IS_MMAP_INIT(tskd)) {
        ERROR("Kernel map was not loaded because currently the map is in initialized state");
        return 1;
    }
#ifdef VTSS_AUTOCONF_MODULE_MUTEX
    mutex_lock(&module_mutex);
#endif
    VTSS_SET_MMAP_INIT(tskd);
    vtss_time_get_sync(&cputsc, &realtsc);
    vtss_get_kstart(&addr, &size);
    if (vtss_record_module(VTSS_TRND_CFG(tskd), 0, addr, size, "vmlinux", 0, cputsc, realtsc)) {
        WARNING("Failed to record module: vmlinux");
    }
    for (modules = THIS_MODULE->list.prev; (unsigned long)modules > MODULES_VADDR; modules = modules->prev);
    list_for_each_entry(mod, modules, list) {
        const char *name   = mod->name;
#ifdef VTSS_AUTOCONF_MODULE_CORE_LAYOUT
        unsigned long addr = (unsigned long)mod->core_layout.base;
        unsigned long size = mod->core_layout.size;
#else
        unsigned long addr = (unsigned long)mod->module_core;
        unsigned long size = mod->core_size;
#endif
        if (module_is_live(mod)) {
            DEBUG_MMAP("module: addr=0x%lx, size=%lu, name='%s'", addr, size, name);
            if (vtss_record_module(VTSS_TRND_CFG(tskd), 0, addr, size, name, 0, cputsc, realtsc)) {
                WARNING("Failed to record module: %s", name);
                repeat = 1;
            }
        }
    }
    VTSS_CLEAR_MMAP_INIT(tskd);
#ifdef VTSS_AUTOCONF_MODULE_MUTEX
    mutex_unlock(&module_mutex);
#endif
    return repeat;
}

void vtss_kmap(struct task_struct *task, const char *name, unsigned long addr, unsigned long pgoff, unsigned long size)
{
    vtss_task_map_item_t *item = NULL;

    if (!task) return;

    item = vtss_task_map_get_item(TASK_TID(task));
    atomic_inc(&vtss_transport_busy);
    if (VTSS_TRANSPORT_IS_READY) {
        if (item != NULL) {
            struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
            long long cputsc, realtsc;

            if (!VTSS_IS_MMAP_INIT(tskd)) {
                vtss_time_get_sync(&cputsc, &realtsc);
                DEBUG_MMAP("addr=0x%lx, size=%lu, name='%s', pgoff=%lu", addr, size, name, pgoff);
                if (vtss_record_module(VTSS_TRND_CFG(tskd), 0, addr, size, name, pgoff, cputsc, realtsc)) {
                    WARNING("Failed to record module: %s", name);
                }
            }
        }
    }
    atomic_dec(&vtss_transport_busy);
    if (item != NULL) vtss_task_map_put_item(item);
}

int vtss_mmap_all(struct vtss_task_data *tskd, struct task_struct *task)
{
    struct mm_struct *mm;
    char *pname, *tmp = vtss_kmalloc(PAGE_SIZE, GFP_KERNEL);
    int repeat = 0;

    if (!tmp) {
        ERROR("No memory for tmp buffer");
        return 1;
    }
    if (VTSS_IS_MMAP_INIT(tskd)) {
        ERROR("Module map was not loaded because currently the map is in initialized state");
        return 1;
    }
    if ((mm = get_task_mm(task)) != NULL) {
        int is_vdso_found = 0;
        struct vm_area_struct *vma;
        long long cputsc, realtsc;
        unsigned long addr, size;

        VTSS_SET_MMAP_INIT(tskd);
        vtss_time_get_sync(&cputsc, &realtsc);
        down_read(&mm->mmap_sem);

        addr = VTSS_EVENT_LOST_MODULE_ADDR;
        size = 1;
        if (vtss_record_module(VTSS_TRND_CFG(tskd), tskd->m32, addr, size, VTSS_EVENT_LOST_MODULE_NAME, 0, cputsc, realtsc)) {
            WARNING("Failed to record module: %s", VTSS_EVENT_LOST_MODULE_NAME);
        }
#ifdef VTSS_AUTOCONF_VSYSCALL_ADDR
        addr = (unsigned long)VSYSCALL_ADDR;
        size = (unsigned long)PAGE_SIZE;
#else
        addr = (unsigned long)VSYSCALL_START;
        size = (unsigned long)(VSYSCALL_MAPPED_PAGES * PAGE_SIZE);
#endif
        if (vtss_record_module(VTSS_TRND_CFG(tskd), 0, addr, size, "[vsyscall]", 0, cputsc, realtsc)) {
            WARNING("Failed to record module: [vsyscall]");
        }
        for (vma = mm->mmap; vma != NULL; vma = vma->vm_next) {
            DEBUG_MMAP("vma=[0x%lx - 0x%lx], flags=0x%lx", vma->vm_start, vma->vm_end, vma->vm_flags);
            if ((vma->vm_flags & (VM_EXEC | VM_MAYEXEC)) && !(vma->vm_flags & VM_WRITE) &&
                vma->vm_file && vma->vm_file->f_path.dentry)
            {
                pname = VTSS_DPATH(vma->vm_file, tmp, PAGE_SIZE);
                if (!IS_ERR(pname)) {
                    DEBUG_MMAP("addr=0x%lx, size=%lu, file='%s', pgoff=%lu", vma->vm_start, (vma->vm_end - vma->vm_start), pname, vma->vm_pgoff);
                    if (vtss_record_module(VTSS_TRND_CFG(tskd), tskd->m32, vma->vm_start, (vma->vm_end - vma->vm_start), pname, vma->vm_pgoff, cputsc, realtsc)) {
                        WARNING("Failed to record module: %s", pname);
                        repeat = 1;
                    }
                }
#ifdef VM_HUGEPAGE
            } else if ((vma->vm_flags & VM_HUGEPAGE) &&
                (vma->vm_flags & VM_EXEC) && !(vma->vm_flags & VM_WRITE) &&
                !vma->vm_file)
            {
                /**
                 * Try to recover the mappings of some hugepages
                 * by looking at segments immediately precede and
                 * succeed them
                 */
                struct vm_area_struct *vma_pred = find_vma(mm, vma->vm_start - 1);
                struct vm_area_struct *vma_succ = find_vma(mm, vma->vm_end);
                if (vma_pred && vma_succ) {
                    if ((vma_pred->vm_flags & VM_EXEC) && !(vma_pred->vm_flags & VM_WRITE) &&
                        vma_pred->vm_file && vma_pred->vm_file->f_path.dentry) {
                        char *pname_pred = VTSS_DPATH(vma_pred->vm_file, tmp, PAGE_SIZE);
                        if (!IS_ERR(pname_pred)) {
                            if (vma_succ->vm_file && vma_succ->vm_file->f_path.dentry) {
                                char *pname_succ = VTSS_DPATH(vma_succ->vm_file, tmp, PAGE_SIZE);
                                if (!IS_ERR(pname_succ)) {
                                    if (strcmp(pname_pred, pname_succ) == 0) {
                                        DEBUG_MMAP("recovered vma=[0x%lx - 0x%lx] flags=0x%lx, pgoff=0x%lx, file='%s'", vma->vm_start, vma->vm_end, vma->vm_flags, vma_pred->vm_pgoff + ((vma_pred->vm_end - vma_pred->vm_start) >> PAGE_SHIFT), pname_pred);
                                        if (vtss_record_module(VTSS_TRND_CFG(tskd), tskd->m32, vma->vm_start, (vma->vm_end - vma->vm_start), pname_pred, vma_pred->vm_pgoff + ((vma_pred->vm_end - vma_pred->vm_start) >> PAGE_SHIFT), cputsc, realtsc)) {
                                            WARNING("Failed to record module: %s", pname_pred);
                                            repeat = 1;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
#endif
            } else if (vma->vm_mm && vma->vm_start == (long)vma->vm_mm->context.vdso) {
                is_vdso_found = 1;
                DEBUG_MMAP("addr=0x%lx, size=%lu, name='%s', pgoff=%lu", vma->vm_start, (vma->vm_end - vma->vm_start), "[vdso]", 0UL);
                if (vtss_record_module(VTSS_TRND_CFG(tskd), tskd->m32, vma->vm_start, (vma->vm_end - vma->vm_start), "[vdso]", 0, cputsc, realtsc)) {
                    WARNING("Failed to record module: [vdso]");
                    repeat = 1;
                }
            }
        }
        if (!is_vdso_found && mm->context.vdso) {
            DEBUG_MMAP("addr=0x%p, size=%lu, name='%s', pgoff=%lu", mm->context.vdso, PAGE_SIZE, "[vdso]", 0UL);
            if (vtss_record_module(VTSS_TRND_CFG(tskd), tskd->m32, (unsigned long)((size_t)mm->context.vdso), PAGE_SIZE, "[vdso]", 0, cputsc, realtsc)) {
                WARNING("Failed to record module: [vdso]");
                repeat = 1;
            }
        }
        up_read(&mm->mmap_sem);
        VTSS_CLEAR_MMAP_INIT(tskd);
        mmput(mm);
    }
    if (tmp)
        vtss_kfree(tmp);
    return repeat;
}

void vtss_mmap(struct file *file, unsigned long addr, unsigned long pgoff, unsigned long size)
{
    vtss_task_map_item_t *item = NULL;

    if (!VTSS_COLLECTOR_IS_READY_OR_INITING) {
        return;
    }
    atomic_inc(&vtss_kernel_tasks_in_progress);
    if (VTSS_TRANSPORT_IS_READY && VTSS_COLLECTOR_IS_READY_OR_INITING) {
        item = vtss_task_map_get_item(TASK_TID(current));
        if (item != NULL) {
            struct vtss_task_data *tskd = (struct vtss_task_data*)&item->data;
#ifdef VTSS_VMA_SEARCH_BOOST
            atomic_inc(&vtss_mmap_reg_callcnt);
#endif
            if ((!VTSS_IS_COMPLETE(tskd)) && (!VTSS_IS_MMAP_INIT(tskd))) {
                char *tmp = vtss_kmalloc(PAGE_SIZE, GFP_ATOMIC);
                long long cputsc, realtsc;
                vtss_time_get_sync(&cputsc, &realtsc);

                if (tmp != NULL) {
                    char *pname = VTSS_DPATH(file, tmp, PAGE_SIZE);
                    if (!IS_ERR(pname)) {
                        DEBUG_MMAP("vma=[0x%lx - 0x%lx], file='%s', pgoff=%lu", addr, addr + size, pname, pgoff);
                        if (vtss_record_module(VTSS_TRND_CFG(tskd), tskd->m32, addr, size, pname, pgoff, cputsc, realtsc)) {
                            ERROR("Failed to record module: %s", pname);
                        }
                    }
                    vtss_kfree(tmp);
                }
                else {
                    ERROR("No memory for tmp buffer");
                }
            }
            vtss_task_map_put_item(item);
        }
    }
    atomic_dec(&vtss_kernel_tasks_in_progress);
}
