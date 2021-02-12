#!/bin/sh
#
# File: prepare-debugfs-and-gpu-environment
#
# Description: script prepare debugfs and
# GPU environment for VTune(TM) Amplifier XE.
#
# Version: 1.0
#
# """
# Copyright 2019 Intel Corporation All Rights Reserved.
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

default_user=
debugfs_group="vtune"
set_user=0
scripts="prepare-gpu-hardware-metrics.sh prepare-debugfs.sh"
command=""
dir=`dirname $0`
install=""
# help
print_usage_and_exit()
{
    err=${1:-0}
    echo ""
    echo "Usage: $0 [ option ]"
    echo ""
    echo "    -u | --user <user>"
    echo "      Specifies the user of the environment to be configured."
    echo ""
    echo "    -g | --group <group>"
    echo "      Specifies the group other than '$debugfs_group' to access debugFS."
    echo ""
    echo "    -i | --install"
    echo "      Configures the autoload debugfs boot script and then installs it to the"
    echo "      appropriate system directory and sets "
    echo "      /proc/sys/dev/i915/perf_stream_paranoid=0 permanently."
    echo ""
    echo "This script configures debugFS and makes GPU hardware metrics available."
    echo ""
    exit $err
}

# help.
if [ $# -eq 1 ] ; then
    case "$1" in
        -h | --help)
            print_usage_and_exit 0
        ;;
    esac
fi

# parse the options
while [ $# -gt 0 ] ; do
    case "$1" in
        -u | --user)
            default_user="$2"
            set_user=1
            shift
        ;;
        -g | --group)
            debugfs_group="$2"
            shift
        ;;
        -i | --install)
            install="--install"
            ;;
        *)
            echo ""
            echo "ERROR: unrecognized option $1"
            print_usage_and_exit 3
        ;;
    esac
    shift
done

if [ ${set_user} -eq 0 ] ; then
    echo "Enter the user name that requires permissions:"
    while read answers && [ -z "$answers" ];
    do
        echo "ERROR: "
        echo "The user name cannot be empty."
    done
default_user=${answers}
fi

if [ -z ${install} ] ; then
    echo "Are you configurig environment"
    echo "(t)emporarily or (p)ermanently?"
    while read answers && ( [ "t" != "$answers" ] && [ "p" != "$answers" ])
    do 
        echo "ERROR input ${answers} "
        echo "Enter 'p' to mount permanently or 't' to mount temporarily." 
    done
    if [ "$answers" = "p" ] ; then
        install="--install"
        echo 'Selected: permanently.'
    fi
    if [ "$answers" = "t" ] ; then
        echo 'Selected: temporarily.'
    fi
fi


for i in ${scripts} ; do
    case "$i" in
        "prepare-gpu-hardware-metrics.sh")
            command="${command} /bin/sh  ${dir}/${i} -u ${default_user} ${install} && "
        ;;
        "prepare-debugfs.sh")
            command="${command} /bin/sh  ${dir}/${i} --user ${default_user} ${install} -g ${debugfs_group} && "
        ;;
        *)
            command="${command} /bin/sh  ${dir}/${i} && "
        ;;
    esac
done

command=${command%???}

if [ -z "${BUSYBOX_SHELL}" ] ; then
    if [ "root" != "${USER}" ] ; then
        if [ ! -w /dev ] ; then
            echo "NOTE:  super-user or \"root\" privileges are required in order to continue."
            echo "Please enter \"root\" "
            exec su -c  "${command}"
            echo ""
            exit 0
        fi
    fi
fi
exec su -c "${command}"