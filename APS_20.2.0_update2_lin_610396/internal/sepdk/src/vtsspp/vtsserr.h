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
#ifndef _VTSSERR_H_
#define _VTSSERR_H_

/**
//
// VTSS Error Codes
//
*/

#define VTSS_SUCCESS         0
#define VTSS_ERR_INTERNAL   -1
#define VTSS_ERR_BADARG     -2
#define VTSS_ERR_NOMEMORY   -3
#define VTSS_ERR_NORESOURCE -4
#define VTSS_ERR_BUFFERFULL -5
#define VTSS_ERR_NOTFOUND   -6
#define VTSS_ERR_NOSUPPORT  -7
#define VTSS_ERR_BUSY       -8
#define VTSS_ERR_DENIED     -9

/// VTSS procfs errors
/// Change this value leads the fixes in client collector function "getStatus"
#define VTSS_ERR_INIT_FAILED -1001
#define VTSS_ERR_START_IN_RUN -1002
#define VTSS_ERR_RING_BUFFER_DENIED -1003

#define VTSS_ERR_OVERTIME -1003

#endif
