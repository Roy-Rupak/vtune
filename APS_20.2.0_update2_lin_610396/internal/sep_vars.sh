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

if [ $# -gt 1 ];
then
    echo "Usage: sep_vars.sh [emon_api]"
elif [ $# -eq 1 ]; then
    if [ "$1" != "emon_api" ]; then
      echo "Usage: sep_vars.sh [emon_api]"
    fi
fi

PLATFORM=`uname -m`
OPERATING_SYS=`uname -s`
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
OS_BITNESS=""

export SEP_LOC_PATH="${SCRIPT_DIR}"
export MTOOL_PATH="${SCRIPT_DIR}/reporting_tools/mtool"
export ANDROID_TARGET_PATH="${SCRIPT_DIR}/android_target"
export PERL5LIB="${MTOOL_PATH}/modules:${PERL5LIB}"
export EMON_API_HEADER_PATH="${SCRIPT_DIR}/config/emon_api"

if [[ "${OPERATING_SYS}" == 'Linux' ]]; then
    if [[ "${PLATFORM}" == 'x86_64' ]]; then
        OS_BITNESS="64"
    elif [[ "${PLATFORM}" == 'i686' ]]; then
        OS_BITNESS="32"
    fi
elif [[ "${OPERATING_SYS}" == 'FreeBSD' ]]; then
    OS_BITNESS="64"
fi

export SEP_INSTALL_PATH="${SEP_LOC_PATH}/bin${OS_BITNESS}"
export SEP_LIB_INSTALL_PATH="${SEP_LOC_PATH}/lib${OS_BITNESS}"

export PATH="${SEP_INSTALL_PATH}:${MTOOL_PATH}:${ANDROID_TARGET_PATH}:${PATH}"
export CPATH="${EMON_API_HEADER_PATH}:${CPATH}"
export LIBRARY_PATH="${SEP_LIB_INSTALL_PATH}:${LIBRARY_PATH}"
export PYTHONPATH="${SEP_LOC_PATH}/config/edp:${PYTHONPATH}"

if [ "$1" == "emon_api" ]; then
    export LD_LIBRARY_PATH="${SEP_LIB_INSTALL_PATH}:${LD_LIBRARY_PATH}"
fi

export SEP_BASE_DIR="${SEP_INSTALL_PATH}"
if [[ "${PLATFORM}" == 'x86_64' ]]; then
    export INTEL_LIBITTNOTIFY64="${SEP_LOC_PATH}/lib${OS_BITNESS}/libittnotify_collector.so"
else
    export INTEL_LIBITTNOTIFY32="${SEP_LOC_PATH}/lib${OS_BITNESS}/libittnotify_collector.so"
fi

# show settings of various environment variables
echo "PATH=${PATH}"
echo "CPATH=${CPATH}"
echo "LIBRARY_PATH=${LIBRARY_PATH}"
echo "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
echo "SEP_BASE_DIR=${SEP_BASE_DIR}"
echo SEP is currently installed under $SEP_INSTALL_PATH

