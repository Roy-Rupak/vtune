#!/bin/sh
#
# =============================================================================
# Filename: sep_vars.sh
# Version: 1.02
# Purpose: SEP Runtime environment setup script
# Description: This script should be used to set up the run-time environment
#              for SEP.  It requires sh.  Run this script before running any
#              SEP executable, e.g., sep or sfdump5
#
# Usage: source sep_vars.sh
#
# Copyright(C) 2004-2018 Intel Corporation.  All Rights Reserved.
# =============================================================================

PLATFORM=`uname -m`
OPERATING_SYS=`uname -s`

if [[ "$0" == "sh" ]]; then
    echo "please run or source this script under the same directory"
    SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"
else
    echo "It's not a busybox shell. please select correct script"
    return
fi

export SEP_INSTALL_PATH="${SCRIPT_DIR}"
export MTOOL_PATH="${SCRIPT_DIR}/reporting_tools/mtool"
export ANDROID_TARGET_PATH="${SCRIPT_DIR}/android_target"
export PERL5LIB="${MTOOL_PATH}/modules:${PERL5LIB}"
export EMON_API_HEADER_PATH="${SCRIPT_DIR}/config/emon_api"

if [[ "${OPERATING_SYS}" == 'Linux' ]]; then
    if [[ "${PLATFORM}" == 'x86_64' ]]; then
        export SEP_INSTALL_PATH="${SEP_INSTALL_PATH}/bin64"
    elif [[ "${PLATFORM}" == 'i686' ]]; then
        export SEP_INSTALL_PATH="${SEP_INSTALL_PATH}/bin32"
    else
        export SEP_INSTALL_PATH="${SEP_INSTALL_PATH}/bin"
    fi
else
    export SEP_INSTALL_PATH="${SEP_INSTALL_PATH}/bin"
fi

export PATH="${SEP_INSTALL_PATH}:${MTOOL_PATH}:${ANDROID_TARGET_PATH}:${PATH}"
export CPATH="${EMON_API_HEADER_PATH}:${CPATH}"
export LIBRARY_PATH="${SEP_INSTALL_PATH}:${LIBRARY_PATH}"
export LD_LIBRARY_PATH="${SEP_INSTALL_PATH}:${LD_LIBRARY_PATH}"
export SEP_BASE_DIR="${SEP_INSTALL_PATH}"

# show settings of various environment variables
echo "PATH=${PATH}"
echo "CPATH=${CPATH}"
echo "LIBRARY_PATH=${LIBRARY_PATH}"
echo "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
echo "SEP_BASE_DIR=${SEP_BASE_DIR}"
echo SEP is currently installed under $SEP_INSTALL_PATH

