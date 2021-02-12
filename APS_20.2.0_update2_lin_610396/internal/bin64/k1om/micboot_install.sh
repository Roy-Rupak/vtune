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

abspath="$(cd "${0%/*}" 2>/dev/null; echo "$PWD"/"${0##*/}")"
orig_dir=`dirname "$abspath"`

DRYRUN=no
while [ $# -gt 0 ] ; do
  case "$1" in
    --dry-run)
        DRYRUN=yes
        echo "Enable dry run mode"
        ;;
    --mpss-version=*)
       MPSS_VERSION=`echo $1 | sed s?^--mpss-version=??g`
       echo "Set mpss version to ${MPSS_VERSION}"
       ;;
    *)
       echo ""
       echo "Invalid option: \"$1\""
       ;;
  esac
  shift
done

MIC_DIR=/amplxe
NAME=amplxe
if [ -r "${orig_dir}/../../config/product_info.cfg" ] ; then
    MIC_DIR_TMP=`cat "${orig_dir}/../../config/product_info.cfg" | grep defaultTargetInstallPath_mic | cut -d "=" -f 2 | sed -e 's/^"//'  -e 's/"$//'`
    if [ "${MIC_DIR_TMP}" != "" ]; then
        MIC_DIR=$MIC_DIR_TMP
        NAME=`echo "$MIC_DIR_TMP" | sed -r 's/\//_/g'`
    fi
fi

INSTALL_ROOT=/opt/intel/mic
if [ -r "/etc/mpss/conf.d" ] ; then
    INSTALL_ROOT=/var/mpss
fi


DRYRUN=$DRYRUN "${orig_dir}/sep_micboot_install.sh" $*
DRYRUN=$DRYRUN NAME=$NAME INSTALL_DIR=$INSTALL_ROOT/$MIC_DIR "${orig_dir}/runtime/itt_micboot_install.sh"
MPSS_VERSION=$MPSS_VERSION  DRYRUN=$DRYRUN NAME=$NAME MIC_DIR=$MIC_DIR INSTALL_DIR=$INSTALL_ROOT/$MIC_DIR "${orig_dir}/install_mic.sh"
