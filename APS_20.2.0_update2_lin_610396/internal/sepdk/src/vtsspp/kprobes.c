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
#include "kprobes.h"

static int vtss_init_kprobe(struct kprobe *kp, const char *name)
{
    kprobe_pre_handler_t pre_handler = kp->pre_handler;

    memset(kp, 0, sizeof(struct kprobe));
    kp->pre_handler = pre_handler;
    kp->symbol_name = name;
    return 0;
}

int vtss_register_kprobe(struct kprobe *kp, const char *name)
{
    int rc = 0;

    rc = vtss_init_kprobe(kp, name);
    if (rc) return rc;

    if (!kp->pre_handler) DEBUG_PROBE(".pre_handler field is empty");

    rc = register_kprobe(kp);
    if (rc) {
        DEBUG_PROBE("unable to register kprobe '%s'", name);
        kp->addr = NULL;
    }
    else DEBUG_PROBE("registered '%s' probe", name);

    return rc;
}

int vtss_unregister_kprobe(struct kprobe *kp)
{
    if (kp->addr) {
        unregister_kprobe(kp);
        kp->addr = NULL;
        DEBUG_PROBE("unregistered '%s' probe", kp->symbol_name);
    }
    return 0;
}

int vtss_register_kretprobe(struct kretprobe *rp, const char *name)
{
    int rc = 0;
    kretprobe_handler_t handler = rp->handler;
    kretprobe_handler_t entry_handler = rp->entry_handler;
    size_t data_size = rp->data_size;

    memset(rp, 0, sizeof(struct kretprobe));
    rp->handler = handler;
    rp->entry_handler = entry_handler;
    rp->data_size = data_size;

    rc = vtss_init_kprobe(&rp->kp, name);
    if (rc) return rc;

    if (!rp->entry_handler) DEBUG_PROBE(".entry_handler field is empty");
    if (!rp->handler) DEBUG_PROBE(".handler field is empty");
    rp->maxactive = 32; /* probe up to 32 instances concurrently */

    rc = register_kretprobe(rp);
    if (rc) {
        DEBUG_PROBE("unable to register kretprobe '%s'", name);
        rp->kp.addr = NULL;
    }
    else DEBUG_PROBE("registered '%s' probe", name);

    return rc;
}

int vtss_unregister_kretprobe(struct kretprobe *rp)
{
    if (rp->kp.addr) {
        unregister_kretprobe(rp);
        rp->kp.addr = NULL;
        DEBUG_PROBE("unregistered '%s' probe", rp->kp.symbol_name);
        if (rp->nmissed) WARNING("Missed probing of '%s' %d times", rp->kp.symbol_name, rp->nmissed);
    }
    return 0;
}

#ifdef VTSS_AUTOCONF_JPROBE
int vtss_register_jprobe(struct jprobe *jp, const char *name)
{
    int rc = 0;

    rc = vtss_init_kprobe(&jp->kp, name);
    if (rc) return rc;

    if (!jp->entry) DEBUG_PROBE(".entry field is empty");

    rc = register_jprobe(jp);
    if (rc) {
        DEBUG_PROBE("unable to register jprobe '%s'", name);
        jp->kp.addr = NULL;
    }
    else DEBUG_PROBE("registered '%s' probe", name);

    return rc;
}

int vtss_unregister_jprobe(struct jprobe *jp)
{
    if (jp->kp.addr) {
        unregister_jprobe(jp);
        jp->kp.addr = NULL;
    }
    return 0;
}
#endif
