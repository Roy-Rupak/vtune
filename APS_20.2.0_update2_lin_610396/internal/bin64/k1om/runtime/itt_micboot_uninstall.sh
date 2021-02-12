#!/bin/bash
# """
# Copyright 2014-2017 Intel Corporation All Rights Reserved.
#
# The source code, information and material ("Material") contained
# herein is owned by Intel Corporation or its suppliers or licensors,
# and title to such Material remains with Intel Corporation or its
# suppliers or licensors. The Material contains proprietary information
# of Intel or its suppliers and licensors. The Material is protected by
# worldwide copyright laws and treaty provisions. No part of the
# Material may be used, copied, reproduced, modified, published,
# uploaded, posted, transmitted, distributed or disclosed in any way
# without Intel's prior express written permission.
# 
# No license under any patent, copyright or other intellectual property
# rights in the Material is granted to or conferred upon you, either
# expressly, by implication, inducement, estoppel or otherwise. Any
# license under such intellectual property rights must be express and
# approved by Intel in writing.
# 
# Unless otherwise agreed by Intel in writing, you may not remove or
# alter this notice or any other notice embedded in Materials by Intel
# or Intel's suppliers or licensors in any way.
# """

# this script needs to be run as root/sudoer.

ITT_NAME="${NAME:=}"_itt_lib
ITT_CONF="${NAME:=}"_itt

# file mapping
conf_dir1="/etc/sysconfig/mic/conf.d"
filesys_dir1="/opt/intel/mic"
# file mapping in YOCTO build
conf_dir2="/etc/mpss/conf.d"
filesys_dir2="/var/mpss"

if [ -r ${conf_dir2} ] ; then
    conf_dir=${conf_dir2}
    itt_file_dir=${filesys_dir2}/${ITT_NAME}
else
    conf_dir=${conf_dir1}
    itt_file_dir=${filesys_dir1}/${ITT_NAME}
fi

INSTALL_DIR="${INSTALL_DIR:=$itt_file_dir}"

rm -rf "${conf_dir}/${ITT_CONF}.conf"
rm -rf "${INSTALL_DIR}"
