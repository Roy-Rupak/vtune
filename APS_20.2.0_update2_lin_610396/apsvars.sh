#!/bin/sh

#Copyright 2017 Intel Corporation All Rights Reserved.
#
#The source code, information and material ("Material") contained
#herein is owned by Intel Corporation or its suppliers or licensors,
#and title to such Material remains with Intel Corporation or its
#suppliers or licensors. The Material contains proprietary information
#of Intel or its suppliers and licensors. The Material is protected by
#worldwide copyright laws and treaty provisions. No part of the
#Material may be used, copied, reproduced, modified, published,
#uploaded, posted, transmitted, distributed or disclosed in any way
#without Intel's prior express written permission.
#
#No license under any patent, copyright or other intellectual property
#rights in the Material is granted to or conferred upon you, either
#expressly, by implication, inducement, estoppel or otherwise. Any
#license under such intellectual property rights must be express and
#approved by Intel in writing.
#
#Unless otherwise agreed by Intel in writing, you may not remove or
#alter this notice or any other notice embedded in Materials by Intel
#or Intel's suppliers or licensors in any way.

invalidInstall()
{
    echo "Invalid product installation. Please reinstall the tool."
}

absolutize_path() # <file> <parentDir>
{
    firstChar=`echo "$1" | cut -c1`
    if [ "$firstChar" = "/" ]; then
       echo "$1"
    else
       echo "$2/$1"
    fi
}

follow_link() # <file>
{
    file="$1"
    parentDir=`dirname "$file"`
    if [ ! -h "$file" ]; then
       echo "$file"
    else
        link=`/bin/ls -l "$file" | sed -e "s/.*->[ ]*//"`
        link=`absolutize_path "$link" "$parentDir"`
        follow_link "$link"
    fi
    }

# Detect this script dir name
VTUNE_SCRIPT_PATH=`follow_link "${BASH_SOURCE}"`
VTUNE_SCRIPT_PATH=`dirname "${VTUNE_SCRIPT_PATH}"`
VTUNE_SCRIPT_PATH=`( cd "$VTUNE_SCRIPT_PATH"; pwd -P)` # guarantees an absolute path name

if [ `uname` = "Darwin" ]; then
  VTUNE_BIN_DIR=
elif [ `uname -m` = "x86_64" ]; then
  VTUNE_BIN_DIR=bin64
else
  VTUNE_BIN_DIR=bin32
fi

if [ -x ${VTUNE_SCRIPT_PATH}/internal ]; then
    VTUNE_CL_PATH=${VTUNE_SCRIPT_PATH}/internal/${VTUNE_BIN_DIR}
else
    VTUNE_CL_PATH=${VTUNE_SCRIPT_PATH}/${VTUNE_BIN_DIR}
fi

export PATH=${VTUNE_CL_PATH}:${PATH}

if [ ! -x ${VTUNE_CL_PATH}/amplxe-python ] ; then
    invalidInstall
fi
