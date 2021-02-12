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
#include "transport.h"
#include "procfs.h"
#include "globals.h"
#include "mpool.h"
#include "spinlock.h"
#include "workqueue.h"
#include "time.h"

#include <linux/module.h>
#include <linux/wait.h>
#include <linux/poll.h>
#include <linux/delay.h>        /* for msleep_interruptible() */
#include <linux/namei.h>        /* for struct nameidata       */
#include <linux/nmi.h>

/* Define this to wake up transport by timeout */
/* transprot timer interval in jiffies (default 10ms) */
#define VTSS_TR_TIMER_INTERVAL (10 * HZ / 1000)

#define VTSS_TR_READ_TIMEOUT 5 /* msec */
#define VTSS_TR_FINI_TIMEOUT 100000 /* 100sec */

#define VTSS_TR_PREALLOC_SIZE 2

#define VTSS_TR_REG_NR_PAGES 256
#define VTSS_TR_IPT_NR_PAGES 4096
#define VTSS_TR_REG_NR_PAGES_PER_MSEC 1
#define VTSS_TR_IPT_NR_PAGES_PER_MSEC 128

#if VTSS_TR_TIMER_INTERVAL
static struct timer_list vtss_transport_timer;
#endif
static VTSS_DEFINE_SPINLOCK(vtss_transport_list_lock);
static LIST_HEAD(vtss_transport_list);
static atomic_t vtss_transport_inited = ATOMIC_INIT(0);

struct vtss_ring_buffer
{
    int nr_pages;
    int overflowed;
    atomic_t busy;
    atomic64_t wr_count ____cacheline_aligned;
    atomic64_t rd_count ____cacheline_aligned;
    char *pages[0];
};

#define VTSS_TR_REG 0x1
#define VTSS_TR_CFG 0x2 /* aux */
#define VTSS_TR_RB  0x4 /* ring buffer */

struct vtss_transport_data
{
    struct list_head list;
    struct file *file;
    wait_queue_head_t waitq;
    char name[64];
    atomic_t refcount;
    atomic_t lost_records;
    atomic64_t lost_bytes;
    atomic_t attached; /* opened by user */
    atomic_t detached; /* closed by user */
    atomic_t completed; /* closed by collector */
    atomic_t wr_seqno ____cacheline_aligned;
    atomic_t rd_seqno ____cacheline_aligned;
    int magic;
    int type;
    struct vtss_ring_buffer **ring_buffers;
};

struct vtss_transport_header
{
    int seqno;
    int size;
};

#define VTSS_TR_NR_RECORDS(trnd) (1 + atomic_read(&trnd->wr_seqno) - atomic_read(&trnd->rd_seqno))
#define VTSS_TR_EMPTY(trnd) (VTSS_TR_NR_RECORDS(trnd) == 0)
#define VTSS_TR_DATA_READY(trnd) (VTSS_TR_NR_RECORDS(trnd) > 0)

void vtss_transport_addref(struct vtss_transport_data *trnd)
{
    atomic_inc(&trnd->refcount);
}

int vtss_transport_delref(struct vtss_transport_data *trnd)
{
    return atomic_dec_return(&trnd->refcount);
}

char *vtss_transport_get_filename(struct vtss_transport_data *trnd)
{
    return trnd->name;
}

int vtss_transport_is_overflowing(struct vtss_transport_data *trnd)
{
    int cpu;

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();

    return trnd->ring_buffers[cpu]->overflowed;
}

int vtss_transport_is_ready(struct vtss_transport_data *trnd)
{
    return atomic_read(&trnd->attached);
}

static atomic_t vtss_ring_buffer_stopped = ATOMIC_INIT(0);

void vtss_transport_start_ring_bufer(void)
{
    atomic_set(&vtss_ring_buffer_stopped, 0);
}

void vtss_transport_stop_ring_bufer(void)
{
    atomic_set(&vtss_ring_buffer_stopped, 1);
}

static atomic_t vtss_kernel_tasks_in_progress = ATOMIC_INIT(0);

static void vtss_transport_wait_kernel_tasks(void)
{
    if (atomic_read(&vtss_kernel_tasks_in_progress))
        WARNING("%d transport tasks in progress", atomic_read(&vtss_kernel_tasks_in_progress));
    while (atomic_read(&vtss_kernel_tasks_in_progress));
}

#define RB_PAGE_INDEX(count) (((count) >> PAGE_SHIFT) % (rb->nr_pages))
#define RB_PAGE_OFFSET(count) ((count) & (PAGE_SIZE-1))
#define RB_ALIGN(x) ALIGN(x, sizeof(void *))

static void vtss_ring_buffer_reset(struct vtss_ring_buffer *rb)
{
    if (rb == NULL) return;

    atomic64_set(&rb->rd_count, 0);
    atomic64_set(&rb->wr_count, 0);
    atomic_set(&rb->busy, 0);
    rb->overflowed = 0;
}

static struct vtss_ring_buffer *vtss_ring_buffer_alloc(int nr_pages)
{
    int index;
    struct vtss_ring_buffer *rb = vtss_kmalloc(sizeof(struct vtss_ring_buffer) + nr_pages*sizeof(void *), GFP_KERNEL);

    if (rb == NULL) return NULL;

    vtss_ring_buffer_reset(rb);
    rb->nr_pages = nr_pages;

    for (index = 0; index < rb->nr_pages; index++)
        rb->pages[index] = NULL;

    for (index = 0; index < rb->nr_pages; index++) {
        rb->pages[index] = (char *)__get_free_page(GFP_KERNEL | __GFP_NOWARN);
        if (rb->pages[index] == NULL) {
            ERROR("Cannot allocate %dth page for ring buffer", index);
            return NULL;
        }
    }
    return rb;
}

static int vtss_ring_buffer_free(struct vtss_ring_buffer *rb)
{
    int index;

    if (rb == NULL) return -1;

    for (index = 0; index < rb->nr_pages; index++) {
        if (rb->pages[index]) free_page((unsigned long)rb->pages[index]);
    }
    vtss_kfree(rb);
    return 0;
}

static inline ssize_t vtss_ring_buffer_filled_size(struct vtss_ring_buffer *rb)
{
    return (ssize_t)atomic64_read(&rb->wr_count) - (ssize_t)atomic64_read(&rb->rd_count);
}

static inline ssize_t vtss_ring_buffer_free_size(struct vtss_ring_buffer *rb)
{
    return rb->nr_pages*PAGE_SIZE - vtss_ring_buffer_filled_size(rb);
}

static int vtss_ring_buffer_write(struct vtss_ring_buffer *rb, ssize_t wr_count, char *buf, size_t size)
{
    /* assumes: size >= free_size */
    while (size) {
        char *page = rb->pages[RB_PAGE_INDEX(wr_count)];
        int offset = RB_PAGE_OFFSET(wr_count);
        size_t nb = min(size, PAGE_SIZE - offset);
        memcpy(page + offset, buf, nb);
        DEBUG_TR("  page=%ld, offset=%d, nb=%zu", RB_PAGE_INDEX(wr_count), offset, nb);
        size -= nb; buf += nb;
        wr_count += nb;
    }
    return 0;
}

static int vtss_ring_buffer_read(struct vtss_ring_buffer *rb, ssize_t rd_count, int user_mode, char *buf, size_t size)
{
    /* assumes: size >= filled_size */
    while (size) {
        char *page = rb->pages[RB_PAGE_INDEX(rd_count)];
        int offset = RB_PAGE_OFFSET(rd_count);
        size_t nb = min(size, PAGE_SIZE - offset);
        if (user_mode) {
            if (copy_to_user((char __user *)buf, page + offset, nb))
                return -1;
        }
        else {
            memcpy(buf, page + offset, nb);
        }
        DEBUG_TR("  page=%ld, offset=%d, nb=%zu", RB_PAGE_INDEX(rd_count), offset, nb);
        size -= nb; buf += nb;
        rd_count += nb;
    }
    return 0;
}

static int vtss_transport_check_consistency(struct vtss_transport_data *trnd, int verbose)
{
    int rc = 0;
    int cpu;

    if (VTSS_TR_NR_RECORDS(trnd) < 0) {
        ERROR("%s: Sequencing is broken", trnd->name);
        rc = -1;
    }
    if (verbose) {
        REPORT("%s: %d records: wr_seqno: %d, rd_seqno: %d", trnd->name,
            VTSS_TR_NR_RECORDS(trnd), atomic_read(&trnd->wr_seqno), atomic_read(&trnd->rd_seqno));
    }
    for (cpu = 0; cpu < hardcfg.cpu_no; cpu++) {

        struct vtss_ring_buffer *rb = trnd->ring_buffers[cpu];
        struct vtss_transport_header header;
        ssize_t filled_size = vtss_ring_buffer_filled_size(rb);
        ssize_t rd_count = atomic64_read(&rb->rd_count);

        if (verbose) {
            REPORT("%s: cpu%02d: %ld bytes: wr_count: %ld, rd_count: %ld", trnd->name, cpu,
                filled_size, (ssize_t)atomic64_read(&rb->wr_count), (ssize_t)atomic64_read(&rb->rd_count));
        }
        if (filled_size < 0) {
            ERROR("%s: Buffer [cpu%d] is broken", trnd->name, cpu);
            rc = -1;
        }
        while (filled_size >= sizeof(header)) {
            vtss_ring_buffer_read(rb, rd_count, 0, (char *)&header, sizeof(header));
            if (verbose) REPORT("%s: cpu%02d:    seqno: %d, size: %d", trnd->name, cpu, header.seqno, header.size);
            if (verbose < 2 || header.size <= 0 || header.size > 16*PAGE_SIZE) break;
            rd_count += RB_ALIGN(sizeof(header) + header.size);
            filled_size -= RB_ALIGN(sizeof(header) + header.size);
        }
    }
    return rc;
}

int vtss_transport_record_write(struct vtss_transport_data *trnd, void *part0, size_t size0, void *part1, size_t size1)
{
    int rc = 0;
    int cpu;
    struct vtss_ring_buffer *rb;
    size_t size = size0 + size1;
    struct vtss_transport_header header;

    if (trnd == NULL) {
        ERROR("No transport data");
        return -EINVAL;
    }

    if (atomic_read(&trnd->completed)) {
        ERROR("%s: Transport is completed", trnd->name);
        return -EINVAL;
    }

    if (atomic_read(&vtss_ring_buffer_stopped)) {
        /* collection was stopped */
        return -EBUSY;
    }

    preempt_disable();
    cpu = smp_processor_id();
    preempt_enable_no_resched();
    rb = trnd->ring_buffers[cpu];

    if (atomic_cmpxchg(&rb->busy, 0, 1)) {
        rb->overflowed = 1;
        atomic_inc(&trnd->lost_records);
        atomic64_add(size, &trnd->lost_bytes);
        ERROR("%s: Buffer [cpu%d] is busy", trnd->name, cpu);
        WARNING("%s: Cannot write %ld bytes, flagword: 0x%x", trnd->name, size, (part0 && size0) ? *(unsigned int *)part0 : 0);
        return -EBUSY;
    }

    /* flush ring-buffer */
    if (trnd->type == VTSS_TR_RB) {
        while (vtss_ring_buffer_free_size(rb) < RB_ALIGN(sizeof(header) + size)) {

            int rd_seqno;
            ssize_t rd_count = atomic64_read(&rb->rd_count);
            struct vtss_transport_header header;

            vtss_ring_buffer_read(rb, rd_count, 0, (char *)&header, sizeof(header));
            while ((rd_seqno = atomic_read(&trnd->rd_seqno)) <= header.seqno) {
                atomic_cmpxchg(&trnd->rd_seqno, rd_seqno, header.seqno + 1);
            }
            rd_count += RB_ALIGN(sizeof(header) + header.size);
            atomic64_set(&rb->rd_count, rd_count);
        }
    }

    if (vtss_ring_buffer_free_size(rb) >= RB_ALIGN(sizeof(header) + size)) {

        int wr_seqno = atomic_inc_return(&trnd->wr_seqno);
        ssize_t wr_count = atomic64_read(&rb->wr_count);

        header = (struct vtss_transport_header) {wr_seqno, size};
        vtss_ring_buffer_write(rb, wr_count, (char *)&header, sizeof(header));
        wr_count += sizeof(header);

        if (part0 && size0) {
            vtss_ring_buffer_write(rb, wr_count, part0, size0);
            wr_count += size0;
        }
        if (part1 && size1) {
            vtss_ring_buffer_write(rb, wr_count, part1, size1);
            wr_count += size1;
        }
        rb->overflowed = 0;
        atomic64_set(&rb->wr_count, RB_ALIGN(wr_count));
        DEBUG_TR("%s: wrote %ld bytes, cpu=%d, wr_seqno=%d, wr_count=%ld", trnd->name, size, cpu, wr_seqno, wr_count);
    }
    else {
        rc = -EAGAIN;
        DEBUG_TR("%s: cannot write %ld bytes", trnd->name, size);
        rb->overflowed = 1;
        atomic_inc(&trnd->lost_records);
        atomic64_add(size, &trnd->lost_bytes);
    }
    atomic_set(&rb->busy, 0);

    return rc;
}

int vtss_transport_record_write_all(void *part0, size_t size0, void *part1, size_t size1)
{
    int rc = 0;
    unsigned long flags;
    struct list_head *it;
    struct vtss_transport_data *trnd = NULL;

    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    list_for_each(it, &vtss_transport_list) {
        trnd = list_entry(it, struct vtss_transport_data, list);
        if ((trnd->name[0] != '\0') && (!atomic_read(&trnd->completed)) && trnd->type == VTSS_TR_REG) {
            rc |= vtss_transport_record_write(trnd, part0, size0, part1, size1);
        }
    }
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
    return rc;
}

static unsigned int vtss_magic_marker[2] = {UEC_MAGIC, UEC_MAGICVALUE};

static ssize_t vtss_transport_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
{
    int rc, cpu;
    unsigned long long start;
    ssize_t total = 0, len;
    struct vtss_transport_data *trnd = (struct vtss_transport_data *)file->private_data;

    if (unlikely(trnd == NULL || trnd->file == NULL || buf == NULL || size < sizeof(vtss_magic_marker))) {
        ERROR("%s: Transport is invalid", trnd->name);
        return -EINVAL;
    }

    while (!atomic_read(&trnd->completed) && !VTSS_TR_DATA_READY(trnd)) {

        if (file->f_flags & O_NONBLOCK) {
            return -EAGAIN;
        }
#ifdef VTSS_CONFIG_REALTIME
        {
            unsigned long delay;
            delay = msecs_to_jiffies(1000);
            rc = wait_event_interruptible_timeout(trnd->waitq,
                (atomic_read(&trnd->completed) || VTSS_TR_DATA_READY(trnd)), delay);
        }
#else
        rc = wait_event_interruptible(trnd->waitq,
            (atomic_read(&trnd->completed) || VTSS_TR_DATA_READY(trnd)));
#endif
        if (rc < 0) {
            ERROR("%s: Queue is empty", trnd->name);
            return -ERESTARTSYS;
        }
    }

    if (trnd->magic == 0) {
        len = sizeof(vtss_magic_marker);
        if (copy_to_user(buf, vtss_magic_marker, len)) {
            ERROR("%s: Cannot copy magic marker to user", trnd->name);
            return -EAGAIN;
        }
        size -= len; buf += len; total += len;
        trnd->magic = 1;
    }

    start = vtss_time_cpu();
    while (size > 0 && VTSS_TR_DATA_READY(trnd) && vtss_time_get_msec_from(start) < VTSS_TR_READ_TIMEOUT) {

        for (cpu = 0; cpu < hardcfg.cpu_no; cpu++) {

            struct vtss_ring_buffer *rb = trnd->ring_buffers[cpu];
            struct vtss_transport_header header;
            ssize_t filled_size = vtss_ring_buffer_filled_size(rb);

            if (filled_size >= sizeof(header)) {

                ssize_t rd_count = atomic64_read(&rb->rd_count);
                int rd_seqno = atomic_read(&trnd->rd_seqno);

                vtss_ring_buffer_read(rb, rd_count, 0, (char *)&header, sizeof(header));
                rd_count += sizeof(header);

                if (header.seqno > rd_seqno)
                    continue;
                if (header.seqno < rd_seqno) {
                    /* skip unflushed */
                    rd_count += header.size;
                    atomic64_set(&rb->rd_count, RB_ALIGN(rd_count));
                    continue;
                }
                if (header.size > size) {
                    DEBUG_TR("%s: no room (%ld bytes) in user buffer", trnd->name, size);
                    goto out;
                }
                if (filled_size >= RB_ALIGN(sizeof(header) + header.size)) {
                    len = header.size;
                    rc = vtss_ring_buffer_read(rb, rd_count, 1, (char *)buf, len);
                    if (rc) {
                        ERROR("%s: Cannot copy to user buffer", trnd->name);
                        goto out;
                    }
                    rd_count += len;
                    size -= len; buf += len; total += len;
                }
                else {
                    ERROR("%s: Record truncted: %zu bytes of %d", trnd->name, filled_size, header.size);
                    goto out;
                }
                atomic64_set(&rb->rd_count, RB_ALIGN(rd_count));
                atomic_inc(&trnd->rd_seqno);
                DEBUG_TR("%s: read %ld bytes, cpu=%d, rd_seqno=%d, rd_count=%ld", trnd->name, len, cpu, rd_seqno, rd_count);
            }
        }
    }
    if (vtss_time_get_msec_from(start) >= VTSS_TR_READ_TIMEOUT) {
        ERROR("%s: Read timeout: %lld msec, read %ld bytes", trnd->name, vtss_time_get_msec_from(start), total);
        if (!total) {
            vtss_transport_check_consistency(trnd, 1);
            return -EINVAL;
        }
    }
out:
    DEBUG_TR("%s: total read %ld bytes", trnd->name, total);
    return total;
}

static ssize_t vtss_transport_write(struct file *file, const char __user * buf, size_t count, loff_t * ppos)
{
    /* the transport is read only */
    return -EINVAL;
}

static unsigned int vtss_transport_poll(struct file *file, poll_table *poll_table)
{
    unsigned int rc = 0;
    struct vtss_transport_data *trnd = NULL;

    if (file == NULL) {
        ERROR("File is empty");
        return (POLLERR | POLLNVAL);
    }
    trnd = (struct vtss_transport_data *)file->private_data;
    if (trnd == NULL) {
        ERROR("No transport data");
        return (POLLERR | POLLNVAL);
    }
    if (trnd->file == NULL) {
        ERROR("File was already closed");
        return 0;
    }
    poll_wait(file, &trnd->waitq, poll_table);
    if (atomic_read(&trnd->completed) || (VTSS_TR_DATA_READY(trnd) && trnd->type != VTSS_TR_RB))
        rc = (POLLIN | POLLRDNORM);

    DEBUG_TR("%s: %s", trnd->name, (rc ? "READY" : "-----"));
    return rc;
}

static int vtss_transport_open(struct inode *inode, struct file *file)
{
    int rc;
    struct vtss_transport_data *trnd = VTSS_PDE_DATA(inode);

    if (trnd == NULL)
        return -ENOENT;

    rc = generic_file_open(inode, file);
    if (rc)
        return rc;

    if (atomic_read(&trnd->completed) && VTSS_TR_EMPTY(trnd)) {
        return -EINVAL;
    }
    if (atomic_inc_return(&trnd->attached) > 1) {
        atomic_dec(&trnd->attached);
        return -EBUSY;
    }
    trnd->file = file;
    file->private_data = trnd;
    /* Increase the priority for trace reader to avoid lost events */
    set_user_nice(current, -19);
    DEBUG_TR("%s: opened by user", trnd->name);
    return rc;
}

static int vtss_transport_close(struct inode *inode, struct file *file)
{
    int cpu;
    struct vtss_transport_data *trnd = VTSS_PDE_DATA(inode);

    if (!file) {
        ERROR("File is empty");
        return 0;
    }
    file->private_data = NULL;
    /* Restore default priority for trace reader */
    set_user_nice(current, 0);
    if (trnd == NULL) {
        ERROR("No transport data");
        return -ENOENT;
    }
    trnd->file = NULL;
    if (!atomic_dec_and_test(&trnd->attached)) {
        ERROR("%s: Has wrong state", trnd->name);
        atomic_set(&trnd->attached, 0);
        return -EFAULT;
    }
    atomic_set(&trnd->detached, 1);
    for (cpu = 0; cpu < hardcfg.cpu_no; cpu++) {
        vtss_ring_buffer_reset(trnd->ring_buffers[cpu]);
    }
    DEBUG_TR("%s: closed by user", trnd->name);
    return 0;
}

static const struct vtss_procfs_ops vtss_transport_fops = {
    VTSS_PROCFS_DEFAULT_OPS
    .vtss_procfs_read    = vtss_transport_read,
    .vtss_procfs_write   = vtss_transport_write,
    .vtss_procfs_open    = vtss_transport_open,
    .vtss_procfs_release = vtss_transport_close,
    .vtss_procfs_poll    = vtss_transport_poll,
};

static void vtss_transport_remove(struct vtss_transport_data *trnd)
{
    struct proc_dir_entry *procfs_root = NULL;

    if (VTSS_TR_DATA_READY(trnd)) {
        ERROR("%s: Drop %d records", trnd->name, VTSS_TR_NR_RECORDS(trnd));
    }

    if (trnd->name[0] == '\0') return;
    procfs_root = vtss_procfs_get_root();

    if (procfs_root != NULL) {
        remove_proc_entry(trnd->name, procfs_root);
    }
    DEBUG_TR("%s: removed", trnd->name);
    trnd->name[0] = '\0';
}

static void vtss_transport_destroy_trnd(struct vtss_transport_data *trnd)
{
    if (trnd->ring_buffers != NULL) {
        int cpu;
        for (cpu = 0; cpu < hardcfg.cpu_no; cpu++) {
            vtss_ring_buffer_free(trnd->ring_buffers[cpu]);
        }
        vtss_kfree(trnd->ring_buffers);
    }
    vtss_kfree(trnd);
}

#ifdef VTSS_CONFIG_REALTIME
static void vtss_transport_destroy_trnd_work(struct work_struct *work)
{
    struct vtss_work *my_work = (struct vtss_work *)work;
    struct vtss_transport_data *trnd = NULL;
    if (!my_work) {
        ERROR("No work data");
        return;
    }
    trnd = *((struct vtss_transport_data **)(&my_work->data));
    if (trnd) {
        vtss_transport_destroy_trnd(trnd);
    }
    else {
        ERROR("Trying to destroy empty transport data");
    }
    vtss_kfree(my_work);
    atomic_dec(&vtss_kernel_tasks_in_progress);
}
#endif

static void vtss_transport_init_trnd(struct vtss_transport_data *trnd)
{
    init_waitqueue_head(&trnd->waitq);
    trnd->file = NULL;
    trnd->name[0] = '\0';
    atomic_set(&trnd->refcount, 1);
    atomic64_set(&trnd->lost_bytes, 0);
    atomic_set(&trnd->lost_records, 0);
    atomic_set(&trnd->attached, 0);
    atomic_set(&trnd->detached, 0);
    atomic_set(&trnd->completed, 0);
    atomic_set(&trnd->wr_seqno, 0);
    atomic_set(&trnd->rd_seqno, 1);
    trnd->magic = 0;
    trnd->ring_buffers = NULL;
}

static struct vtss_ring_buffer **vtss_transport_find_unused_ring_buffers(int nr_pages)
{
    unsigned long flags;
    struct list_head *it;
    struct vtss_ring_buffer **ring_buffers = NULL;
    struct vtss_transport_data *trnd;

    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    list_for_each(it, &vtss_transport_list) {
        trnd = list_entry(it, struct vtss_transport_data, list);
        if (atomic_read(&trnd->detached) && trnd->ring_buffers != NULL &&
            trnd->ring_buffers[0]->nr_pages == nr_pages) {
            ring_buffers = trnd->ring_buffers;
            trnd->ring_buffers = NULL;
            DEBUG_TR("%s: will be reused", trnd->name);
            break;
        }
    }
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
    return ring_buffers;
}

static void vtss_transport_list_add(struct vtss_transport_data *trnd)
{
    unsigned long flags;

    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    list_add_tail(&trnd->list, &vtss_transport_list);
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
}

static struct vtss_transport_data *vtss_transport_create_trnd(int type)
{
    int cpu;
    int nr_pages = VTSS_TR_REG_NR_PAGES;

    struct vtss_transport_data *trnd = NULL;

    // This function cannot be called in IRQs disabled mode
    // as it allocates huge ammount of memory.
    if (irqs_disabled()) {
        DEBUG_TR("The attempt to allocate memory in IRQs disabled mode");
        return NULL;
    }
    trnd = vtss_kmalloc(sizeof(struct vtss_transport_data), GFP_KERNEL);
    if (trnd == NULL) {
        ERROR("Not enough memory for transport data");
        return NULL;
    }
    memset(trnd, 0, sizeof(struct vtss_transport_data));
    vtss_transport_init_trnd(trnd);
    trnd->type = type;

    if (type == VTSS_TR_REG) {
        if ((reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT) && !VTSS_RB_MODE)
            nr_pages = VTSS_TR_IPT_NR_PAGES;
    }
    else if (type == VTSS_TR_RB) {
        if (reqcfg.trace_cfg.trace_flags & VTSS_CFGTRACE_IPT)
            nr_pages = VTSS_RB_MSEC*VTSS_TR_IPT_NR_PAGES_PER_MSEC;
        else
            nr_pages = VTSS_RB_MSEC*VTSS_TR_REG_NR_PAGES_PER_MSEC;
    }

    trnd->ring_buffers = vtss_transport_find_unused_ring_buffers(nr_pages);
    if (trnd->ring_buffers == NULL) {
        trnd->ring_buffers = vtss_kmalloc(hardcfg.cpu_no*sizeof(char *), GFP_KERNEL);
        for (cpu = 0; cpu < hardcfg.cpu_no; cpu++) {
            trnd->ring_buffers[cpu] = vtss_ring_buffer_alloc(nr_pages);
            if (trnd->ring_buffers[cpu] == NULL)
                return NULL;
        }
    }
    return trnd;
}

extern int uid;
extern int gid;
extern int mode;

static void vtss_transport_create_trnd_name(struct vtss_transport_data *trnd, pid_t ppid, pid_t pid, uid_t cuid, gid_t cgid)
{
    int seq = -1;
    struct path path;
    char buf[MODULE_NAME_LEN + sizeof(trnd->name) + 8 /* strlen("/proc/<MODULE_NAME>/%d-%d.%d") */];

    do { /* Find out free name */
        if (++seq > 0) path_put(&path);
        snprintf(trnd->name, sizeof(trnd->name)-1, "%d-%d.%d", ppid, pid, seq);
        snprintf(buf, sizeof(buf)-1, "%s/%s", vtss_procfs_path(), trnd->name);
    } while (!kern_path(buf, 0, &path));
    /* Doesn't exist, so create it */
    return;
}

static int vtss_transport_create_pde(struct vtss_transport_data *trnd, uid_t cuid, gid_t cgid)
{
    struct proc_dir_entry *pde;
    struct proc_dir_entry *procfs_root = vtss_procfs_get_root();

    if (procfs_root == NULL) {
        ERROR("Unable to get PROCFS root");
        return 1;
    }
    pde = proc_create_data(trnd->name, (mode_t)(mode ? (mode & 0444) : 0440), procfs_root, &vtss_transport_fops, trnd);

    if (pde == NULL) {
        ERROR("Could not create '%s/%s'", vtss_procfs_path(), trnd->name);
        vtss_transport_destroy_trnd(trnd);
        return 1;
    }
#ifdef VTSS_AUTOCONF_PROCFS_OWNER
    pde->owner = THIS_MODULE;
#endif
    vtss_procfs_set_user(pde, cuid ? cuid : uid, cgid ? cgid : gid);
    return 0;
}

struct vtss_transport_data *vtss_transport_create(pid_t ppid, pid_t pid, uid_t cuid, gid_t cgid)
{
    struct vtss_transport_data *trnd = vtss_transport_create_trnd(VTSS_TR_REG);

    if (trnd == NULL) {
        if (!irqs_disabled()) ERROR("Not enough memory for transport data");
        DEBUG_TR("postponed creation of %d-%d", ppid, pid);
        return NULL;
    }
    vtss_transport_create_trnd_name(trnd, ppid, pid, cuid, cgid);
    /* Doesn't exist, so create it */
    if (vtss_transport_create_pde(trnd, cuid, cgid)) {
        ERROR("Could not create '%s/%s'", vtss_procfs_path(), trnd->name);
        vtss_transport_destroy_trnd(trnd);
        return NULL;
    }
    vtss_transport_list_add(trnd);
    DEBUG_TR("%s: type=%d, nr_pages=%d created", trnd->name, trnd->type, trnd->ring_buffers[0]->nr_pages);
    return trnd;
}

struct vtss_transport_data *vtss_transport_create_aux(struct vtss_transport_data *main_trnd, uid_t cuid, gid_t cgid, int rb)
{
    char *main_trnd_name = main_trnd->name;
    struct vtss_transport_data *trnd = vtss_transport_create_trnd(rb ? VTSS_TR_RB : VTSS_TR_CFG);

    if (trnd == NULL) {
        ERROR("Not enough memory for transport data");
        return NULL;
    }
    memcpy((void *)trnd->name, (void *)main_trnd_name, strlen(main_trnd_name));
    memcpy((void *)trnd->name + strlen(main_trnd_name), (void *)".aux", 5);
    /* Doesn't exist, so create it */
    if (vtss_transport_create_pde(trnd, cuid, cgid)) {
        ERROR("Could not create '%s/%s'", vtss_procfs_path(), trnd->name);
        vtss_transport_destroy_trnd(trnd);
        return NULL;
    }
    vtss_transport_list_add(trnd);
    DEBUG_TR("%s: type=%d, nr_pages=%d created", trnd->name, trnd->type, trnd->ring_buffers[0]->nr_pages);
    return trnd;
}

int vtss_transport_complete(struct vtss_transport_data *trnd)
{
    if (trnd == NULL)
        return -ENOENT;
    if (atomic_read(&trnd->refcount)) {
        ERROR("%s: still in use (refcount=%d)", trnd->name, atomic_read(&trnd->refcount));
    }
    atomic_inc(&trnd->completed);
    if (waitqueue_active(&trnd->waitq)) {
        DEBUG_TR("%s: wake up", trnd->name);
        wake_up_interruptible(&trnd->waitq);
    }
    DEBUG_TR("%s: completed by collector", trnd->name);
    return 0;
}

static void vtss_transport_wake_up_all(void)
{
    unsigned long flags;
    struct list_head *it;
    struct vtss_transport_data *trnd = NULL;

    if (!vtss_spin_trylock_irqsave(&vtss_transport_list_lock, flags))
        return;

    list_for_each(it, &vtss_transport_list) {
        touch_nmi_watchdog();
        trnd = list_entry(it, struct vtss_transport_data, list);
        if (trnd == NULL) {
            ERROR("No transport data");
            continue;
        }
        if (trnd->type == VTSS_TR_RB && !atomic_read(&trnd->completed)) {
            continue;
        }
        if (atomic_read(&trnd->attached)) {
            if (atomic_read(&trnd->completed) || VTSS_TR_DATA_READY(trnd)) {
                if (waitqueue_active(&trnd->waitq)) {
                    wake_up_interruptible(&trnd->waitq);
                }
            }
        }
        else {
            if (!atomic_read(&trnd->detached) && !atomic_read(&trnd->completed)) {
                /* forces to open transport by user */
                vtss_procfs_ctrl_wake_up_all();
            }
        }
    }
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
}

#if VTSS_TR_TIMER_INTERVAL
#ifdef VTSS_AUTOCONF_TIMER_SETUP
static void vtss_transport_tick(struct timer_list *unused)
#else
static void vtss_transport_tick(unsigned long val)
#endif
{
    if (atomic_read(&vtss_transport_inited) == 0) {
        DEBUG_TR("Transport tick while uninit. Ignore.");
        return;
    }
    vtss_transport_wake_up_all();
    mod_timer(&vtss_transport_timer, jiffies + VTSS_TR_TIMER_INTERVAL);

}
#endif

int vtss_transport_debug_info(struct seq_file *s)
{
    unsigned long flags;
    struct list_head *it;
    struct vtss_transport_data *trnd = NULL;

    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    list_for_each(it, &vtss_transport_list) {
        trnd = list_entry(it, struct vtss_transport_data, list);
        if (trnd->name[0] == '\0') continue;
        seq_printf(s, "\n[proc %s]\nattached=%s\ncompleted=%s\nrefcount=%d\ncaptured=%d\nlost=%d\n",
            trnd->name,
            atomic_read(&trnd->attached) ? "true" : "false",
            atomic_read(&trnd->completed) ? "true" : "false",
            atomic_read(&trnd->refcount),
            atomic_read(&trnd->rd_seqno) - 1,
            atomic_read(&trnd->lost_records));
    }
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
    return 0;
}

static void vtss_transport_prealloc_transport_items(void)
{
    int i;
    unsigned long flags;
    struct list_head *it = NULL;
    struct vtss_transport_data *trnd = NULL;

    for (i = 0; i < VTSS_TR_PREALLOC_SIZE; i++) {
        trnd = vtss_transport_create_trnd(VTSS_TR_REG);
        if (trnd) vtss_transport_list_add(trnd);
        trnd = vtss_transport_create_trnd(VTSS_TR_CFG);
        if (trnd) vtss_transport_list_add(trnd);
    }
    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    list_for_each(it, &vtss_transport_list) {
        trnd = list_entry(it, struct vtss_transport_data, list);
        atomic_set(&trnd->detached, 1);
    }
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
}

int vtss_transport_init(int rb)
{
    unsigned long flags;

    atomic_set(&vtss_ring_buffer_stopped, 0);

    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    INIT_LIST_HEAD(&vtss_transport_list);
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
    vtss_transport_prealloc_transport_items();

#if VTSS_TR_TIMER_INTERVAL
#ifdef VTSS_AUTOCONF_TIMER_SETUP
    timer_setup(&vtss_transport_timer, vtss_transport_tick, 0);
    vtss_transport_timer.expires = jiffies + VTSS_TR_TIMER_INTERVAL;
#else
    init_timer(&vtss_transport_timer);
    vtss_transport_timer.expires  = jiffies + VTSS_TR_TIMER_INTERVAL;
    vtss_transport_timer.function = vtss_transport_tick;
    vtss_transport_timer.data     = 0;
#endif
    add_timer(&vtss_transport_timer);
#endif
    atomic_set(&vtss_transport_inited, 1);
    if (rb) REPORT("Ring-buffer %d msec mode is enabled", VTSS_RB_MSEC);

    return 0;
}

static void vtss_transport_fini_trnd(struct vtss_transport_data *trnd)
{
    if (atomic_read(&trnd->lost_records)) {
        ERROR("%s: Lost %d record(s) (%ld bytes), captured %d records",
            trnd->name, atomic_read(&trnd->lost_records), (ssize_t)atomic64_read(&trnd->lost_bytes),
            atomic_read(&trnd->rd_seqno));
    }
    vtss_transport_remove(trnd);
#ifdef VTSS_CONFIG_REALTIME
    atomic_inc(&vtss_kernel_tasks_in_progress);
    if (!in_atomic() || vtss_queue_work(-1, vtss_transport_destroy_trnd_work, &trnd, sizeof(trnd))) {
        ERROR("Cannot remove transport");
        atomic_dec(&vtss_kernel_tasks_in_progress);
    }
#else
    vtss_transport_destroy_trnd(trnd);
#endif
}

void vtss_transport_fini(void)
{
    unsigned long flags;
    struct list_head *it = NULL;
    struct list_head *tmp = NULL;
    struct vtss_transport_data *trnd = NULL;
    unsigned long long start;

    if (!atomic_dec_and_test(&vtss_transport_inited)) {
        ERROR("Transport does not initialized");
        atomic_set(&vtss_transport_inited, 0);
        return;
    }
#if VTSS_TR_TIMER_INTERVAL
    del_timer_sync(&vtss_transport_timer);
#endif
    vtss_transport_wait_kernel_tasks();

    start = vtss_time_cpu();
    vtss_spin_lock_irqsave(&vtss_transport_list_lock, flags);
    while (vtss_time_get_msec_from(start) < VTSS_TR_FINI_TIMEOUT &&
           !list_empty(&vtss_transport_list)) {

        list_for_each_safe(it, tmp, &vtss_transport_list) {
            touch_nmi_watchdog();
            trnd = list_entry(it, struct vtss_transport_data, list);
            if (trnd == NULL) {
                ERROR("No transport data");
                continue;
            }
            atomic_inc(&trnd->completed);
            if (atomic_read(&trnd->attached)) {
                if (waitqueue_active(&trnd->waitq)) {
                    wake_up_interruptible(&trnd->waitq);
                }
                msleep_interruptible(1);
            }
            else {
                list_del(it);
                vtss_transport_fini_trnd(trnd);
            }
        }
    }
    list_for_each_safe(it, tmp, &vtss_transport_list) {
        trnd = list_entry(it, struct vtss_transport_data, list);
        if (trnd == NULL) continue;
        if (atomic_read(&trnd->attached)) {
            ERROR("%s: Complete timeout", trnd->name);
            if (trnd->file) {
                trnd->file->private_data = NULL;
                trnd->file = NULL;
            }
        }
        list_del(it);
        vtss_transport_fini_trnd(trnd);
    }
    INIT_LIST_HEAD(&vtss_transport_list);
    vtss_spin_unlock_irqrestore(&vtss_transport_list_lock, flags);
    vtss_transport_wait_kernel_tasks();
    REPORT("Transport stopped in %lld msec", vtss_time_get_msec_from(start));
}
