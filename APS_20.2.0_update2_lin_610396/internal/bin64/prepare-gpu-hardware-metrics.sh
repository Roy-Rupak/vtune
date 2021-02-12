#!/bin/sh
#
# File: prepare-gpu-hardware-metrics
#
# Description: script add user into video group and set paranoid = 0
# for Enable GPU analysis for non-privileged users
#
# Version: 1.0
#
# """
# Copyright 2019-2020 Intel Corporation All Rights Reserved.
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
#.
# No license under any patent, copyright or other intellectual property
# rights in the Material is granted to or conferred upon you, either
# expressly, by implication, inducement, estoppel or otherwise. Any
# license under such intellectual property rights must be express and
# approved by Intel in writing.
#.
# Unless otherwise agreed by Intel in writing, you may not remove or
# alter this notice or any other notice embedded in Materials by Intel
# or Intel's suppliers or licensors in any way.
# """

default_groups=
pci_devices="/sys/bus/pci/devices/*"
for device in $pci_devices
do
  drm_path="${device}/drm/"
  if [ -d "$drm_path" ] ; then
    i915_is_load=`readlink ${device}/driver | tail -c5 | grep i915`
    if [ ! -z "${i915_is_load=}" ] ; then
      for driver_folder in $drm_path*
      do
        driver_interface_path=/dev/dri/$(basename $driver_folder)
        if [ -e "$driver_interface_path" ] ; then
          group=$(stat -c '%G' $driver_interface_path)
          case "$default_groups" in
            *$group*) ;;
            *       ) default_groups="$default_groups $group" ;;
          esac
        fi
      done
    fi
  fi
done
if [ ! -z "${default_groups}" ] ; then
default_groups=`echo ${default_groups} | cut -c 1-`
fi


default_user=
SCRIPT=$0
SCRIPT_ARGS="$@"
set_user=0
interactive=1
permanently=0
set_groups=0

print_usage_and_exit()
{
    err=${1:-0}
    echo ""
    echo "Usage: $0 [ option ]"
    echo ""
    echo " where \"option\" is one of the following:"
    echo ""
    echo "    -u | --user <user>"
    echo "      Specifies the user of the environment to be configured."
    echo ""
    echo "    -g | --group <group>"
    echo "      Use this option to specify groups other than "${default_groups}" to access video device."
    echo ""
    echo "    -i | --install"
    echo "      Sets /proc/sys/dev/i915/perf_stream_paranoid=0 permanently."
    echo ""
    echo "    -b | --batch"
    echo "      Run in non-interactive mode."
    echo ""
    echo " Without options, script will adds user into groups: ${default_groups} and "
    echo " sets /proc/sys/dev/i915/perf_stream_paranoid value to 0."
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
        -g | --group)
            default_groups="$2"
            set_groups=1
            shift
        ;;
        -u | --user)
            default_user="$2"
            set_groups=1
            set_user=1
            shift
        ;;
        -b | --batch)
            interactive=0
        ;;
        -i | --install)
            permanently=1
        ;;
        *)
            echo ""
            echo "ERROR: unrecognized option $1"
            print_usage_and_exit 3
        ;;
    esac
    shift
done

# check if USER is root.
if [ -z "${BUSYBOX_SHELL}" ] ; then
    if [ "root" != "${USER}" ] ; then
        if [ ! -w /dev ] ; then
            if [ ${interactive} -eq 0 ] ; then
                echo "Error:"
                echo "Super-user or \"root\" privileges are required."
                exit 2
            fi
            echo "NOTE:  super-user or \"root\" privileges are required in order to continue."
            echo "Please enter \"root\" "
            exec su -c "/bin/sh ${SCRIPT} ${SCRIPT_ARGS}"
        fi
    fi
fi

add_to_group(){
  group=$1
  if [ ${interactive} -eq 1 ] ; then
      if [ ${set_user} -eq 0 ] ||  [ ${set_groups} -eq 0 ]  ; then
          echo "Do you want add user to \"${group}\" groups [y/n]"
          read answer
          if [ "$answer" = "y" ] && [ ${set_user} -eq 0 ] ; then
              echo "Enter the user name for whom you want to set permissions:"
              while read answer && [ -z "$answer" ];
              do
                  echo "ERROR: "
                  echo "The user name can not be empty."
              done
              default_user=${answer}
              set_user=1
          fi
      fi
  fi

  if [ ${set_user} -eq 1 ] ; then
      tmp=`id ${default_user} | grep  ${group}`
      if [ -z "$tmp" ] ; then
          if [ 'grep  ${group} /etc/group' ] ; then
              echo "Adding user: \"${default_user}\" into group: \"${group}\"."
              usermod -a -G ${group} ${default_user}
              if [ $? -ne 0 ]; then
                  echo "Failed to add user \"${default_user}\" to group \"${group}\"."
                  return 1
              fi
              echo "User \"${default_user}\" successfully added into group: \"${group}\"."
              echo "Re-login required"
          else
              echo "Group \"${group}\" does not exist"
          fi
      else
          echo "User is already member of group ${group}"
      fi
  fi
  return 0
}

user_added=0
for group in $default_groups
do
    add_to_group $group
done

check=`sysctl -a 2> /dev/null | grep dev.i915.perf_stream_paranoid`
if [ -z "$check" ] ; then
    echo "error :"
    echo "dev.i915.perf_stream_paranoid not found"
    exit 2
fi

if [ ${interactive} -eq 1 ] && [ ${permanently} -eq 0 ] ; then 
    echo "Do you want set perf_stream_paranoid to 0?"
    while true
    do
        echo "(R)eject, set (t)emporarily or set (p)ermanently?"
        read answer
        if [ "$answer" = "t" ] ; then
            echo 'Selected: temporarily'
            set `sysctl -w dev.i915.perf_stream_paranoid=0` via /etc/sysctl.d/
            exit 0
        fi
        if [ "$answer" = "p" ] ; then
            echo 'Selected: permanently'
            tmp=`grep "dev.i915.perf_stream_paranoid=" /etc/sysctl.conf`
            if  [ -z "$tmp" ] ; then
                echo "dev.i915.perf_stream_paranoid=0" >> /etc/sysctl.conf
            else 
                sed '/dev.i915.perf_stream_paranoid/d' /etc/sysctl.conf > /etc/sysctl.conf_tmp
                cat /etc/sysctl.conf_tmp > /etc/sysctl.conf
                rm -f /etc/sysctl.conf_tmp
                echo "dev.i915.perf_stream_paranoid=0" >> /etc/sysctl.conf
            fi
            set `sysctl -w dev.i915.perf_stream_paranoid=0` via /etc/sysctl.d/
            exit 0
        fi
        if [ "$answer" = "R" ] ;  then
            echo 'Selected: reject.'
            echo "The value of /proc/sys/dev/i915/perf_stream_paranoid is not set."
            exit 0
        fi
        echo "Invalid value ${answer}"
    done
else
    if [ ${permanently} -eq 0 ] ; then
        set `sysctl -w dev.i915.perf_stream_paranoid=0` via /etc/sysctl.d/
        exit 0
    fi
    if [ ${permanently} -eq 1 ] ;  then
        tmp=`grep "dev.i915.perf_stream_paranoid=" /etc/sysctl.conf`
        if  [ -z "$tmp" ] ; then
            echo "dev.i915.perf_stream_paranoid=0" >> /etc/sysctl.conf
        else 
            sed '/dev.i915.perf_stream_paranoid/d' /etc/sysctl.conf > /etc/sysctl.conf_tmp
            cat /etc/sysctl.conf_tmp > /etc/sysctl.conf
            rm -f /etc/sysctl.conf_tmp
            echo "dev.i915.perf_stream_paranoid=0" >> /etc/sysctl.conf
        fi
        set `sysctl -w dev.i915.perf_stream_paranoid=0` via /etc/sysctl.d/
        exit 0
    fi
fi
