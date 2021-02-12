/* ***********************************************************************************************

  This file is provided under a dual BSD/GPLv2 license.  When using or
  redistributing this file, you may do so under either license.

  GPL LICENSE SUMMARY

  Copyright (C) 2019-2019 Intel Corporation. All rights reserved.

  This program is free software; you can redistribute it and/or modify
  it under the terms of version 2 of the GNU General Public License as
  published by the Free Software Foundation.

  This program is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
  The full GNU General Public License is included in this distribution
  in the file called LICENSE.GPL.

  BSD LICENSE

  Copyright (C) 2019-2019 Intel Corporation. All rights reserved.
  All rights reserved.

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions
  are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in
      the documentation and/or other materials provided with the
      distribution.
    * Neither the name of Intel Corporation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ***********************************************************************************************
*/


#ifndef _PMU_INFO_MMIO_H_INC_
#define _PMU_INFO_MMIO_H_INC_

static U32 mmio_atm_visa_offset[] = {
	0x28, 0x34, 0x38, 0x44, 0x48, 0x54, 0x58, 0x64, 0x68, 0x74, 0x78, 0x84, 0x88,
	0x94, 0x98, 0xA4, 0
};

static U32 mmio_bxt_visa_offset[] = {
	0x5028, 0x5034, 0x5038, 0x5044, 0x5048, 0x5054, 0x5058, 0x5064, 0x5068,
	0x5074, 0x5078, 0x5084, 0x5088, 0x5094, 0
};

static PMU_MMIO_UNIT_INFO_NODE atm_mmio_info_list[] = {
	{
		{{{0, 0, 0, 0x0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x8}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xC}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x10}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x14}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x18}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x1C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x20}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x24}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x28}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x2C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x30}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x34}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x38}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x40}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x44}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x48}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x4C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x50}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x54}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x58}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x5C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x60}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x64}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x68}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x6C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x70}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x74}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x78}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x7C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x80}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x84}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x88}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x8C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x90}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x94}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x98}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xA0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xA4}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xA8}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xAC}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xB0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E80}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E84}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E8C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E88}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E90}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E94}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x3E98}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9680}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9684}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9688}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x968C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9880}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9884}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9888}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9900}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9904}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9908}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x990C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9910}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9914}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9918}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9980}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9984}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x9988}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0x998C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xD800}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xD804}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xD808}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xD880}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xD884}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xD888}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE600}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE604}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE608}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE644}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE648}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE64C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE658}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE65C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0xE660}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
		{{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
		mmio_atm_visa_offset
	},
	{
		{{{0, 0, 0, 0}}, 0, 0, 0, 0x0},
		{{{0, 0, 0, 0}}, 0, 0, 0, 0x0},
		NULL
	}
};

static PMU_MMIO_UNIT_INFO_NODE bxt_mmio_info_list[] = {
        {
                {{{0, 0, 2, 0x80}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x84}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x88}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x8C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x90}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xAC}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xB0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xB4}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xB8}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xBC}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xC0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5000}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5008}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x500C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5010}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5014}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5018}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x501C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5020}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5024}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5028}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x502C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5030}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5034}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5038}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x503C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5040}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5044}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5048}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x504C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5050}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5054}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5058}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x505C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5060}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5064}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5068}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x506C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5070}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5074}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5078}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x507C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5080}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5084}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5088}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x508C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5090}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5094}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x5098}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x509C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x50A0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x50A4}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x50A8}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x6C00}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x6C04}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x6C80}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x6C84}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 0, 0x6D48}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x7080}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x7084}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x7100}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0x7104}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA180}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA188}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA184}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA200}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA204}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA280}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA284}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xA288}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE400}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE404}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE408}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE600}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE604}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE608}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE60C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xE610}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEB00}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEB04}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEB08}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEC00}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEC04}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEC08}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEC0C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEC10}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEE00}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEE04}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEE08}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEE0C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xEE10}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xF480}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xF484}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xF488}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xF48C}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 2, 0xF490}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0xFFFFFFFFULL},
                {{{0, 0, 0, 0}}, 0, MMIO_SINGLE_BAR_TYPE, 0, 0x0},
                mmio_bxt_visa_offset
        },
        {
                {{{0, 0, 0, 0}}, 0, 0, 0, 0x0},
                {{{0, 0, 0, 0}}, 0, 0, 0, 0x0},
                NULL
        }
};

#endif