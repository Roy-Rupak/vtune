#!/bin/sh
#
# Description:
#
#     Create a copy of VTune(TM) Amplifier Perf tool with performance monitoring
#     privileges and limit access to the new executable for other users in the
#     system who are not in the specified group.
#
#     Following capabilities will be set for the new executable:
#         'cap_sys_admin,cap_sys_ptrace,cap_syslog=ep';
# 
#         'cap_syslog' will be ommited on kernels which doesn't support it;
#
#          Note: 'cap_sys_ptrace' could be ommited on kernels which doesn't
#                require it for context switches;
#
#     Prerequisites:
#         - extended attributes are supported by the file system;
#         - 'setcap' command is available;
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

SCRIPT_DIR=$(cd -P "$(dirname "$0")" && pwd)
PERF_EXE="amplxe-perf"
PERF_EXE_PRIV="amplxe-perf-priv"
GROUP_NAME="vtune"
COMMAND_NAME="setup"

print_msg()
{
    MSG="$*"
    echo "$MSG"
}

print_nnl()
{
    MSG="$*"
    echo -n "$MSG"
}

print_err()
{
    MSG="$*"
    if [ -w /dev/stderr ] ; then
        echo "$MSG" >> /dev/stderr
    else
        echo "$MSG"
    fi
}

print_usage_and_exit()
{
    err=${1:-0}
    print_msg ""
    print_msg "Usage: $0 [ options ]"
    print_msg ""
    print_msg " where \"options\" are:"
    print_msg ""
    print_msg "    -h | --help"
    print_msg "      prints out usage"
    print_msg ""
    print_msg "    -g | --group <group>"
    print_msg "      restricts access to the privileged executable to users in the specified"
    print_msg "      group; if this option is not provided, the group '$GROUP_NAME' will be used"
    print_msg ""
    print_msg "    -c | --command <command>"
    print_msg "      use this option to specify action: 'setup' or 'remove'; if this option"
    print_msg "      is not specified, it defaults to 'setup'"
    print_msg ""
    exit $err
}

create_binary_and_set_capabilities()
{
    BIN_DIR="$(dirname "${SCRIPT_DIR}")/$1"
    PRIVILIGED_BINARY="${BIN_DIR}/${PERF_EXE_PRIV}"

    if ! [ -x "$(command -v setcap)" ] ; then
        print_err "ERROR: unable to find command \"setcap\"."
        exit 255
    fi

    if [ ! -f "${BIN_DIR}/${PERF_EXE}" ] ; then
        echo "ERROR: the binary file \"${BIN_DIR}/${PERF_EXE}\" does not exist."
        exit 102
    fi

    cp "${BIN_DIR}/${PERF_EXE}" "${PRIVILIGED_BINARY}"
    if [ $? -ne 0 ]; then
        print_err "ERROR: failed to create \"${BIN_DIR}/${PERF_EXE_PRIV}\"."
        exit 103
    fi

    chgrp ${GROUP_NAME} "${PRIVILIGED_BINARY}"
    if [ $? -ne 0 ]; then
        print_err "ERROR: failed to set group for \"${BIN_DIR}/${PERF_EXE_PRIV}\"."
        rm "${PRIVILIGED_BINARY}"
        exit 104
    fi

    chmod o-rwx,g+x "${PRIVILIGED_BINARY}"
    if [ $? -ne 0 ]; then
        print_err "ERROR: failed to chmod \"${BIN_DIR}/${PERF_EXE_PRIV}\"."
        rm "${PRIVILIGED_BINARY}"
        exit 105
    fi

    setcap "cap_sys_admin,cap_sys_ptrace,cap_syslog=ep" "${PRIVILIGED_BINARY}" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        setcap "cap_sys_admin,cap_sys_ptrace=ep" "${PRIVILIGED_BINARY}"
        if [ $? -ne 0 ]; then
            print_err "ERROR: failed to assign the required capabilities to \"${BIN_DIR}/${PERF_EXE_PRIV}\"."
            rm "${PRIVILIGED_BINARY}"
            exit 106
        fi
    fi
}

remove_binary()
{
    BIN_DIR="$(dirname "${SCRIPT_DIR}")/$1"
    PRIVILIGED_BINARY="${BIN_DIR}/${PERF_EXE_PRIV}"

    if [ -f "${PRIVILIGED_BINARY}" ] ; then
        echo "Removing \"${BIN_DIR}/${PERF_EXE_PRIV}\""
        rm "${PRIVILIGED_BINARY}"
        if [ $? -ne 0 ]; then
            print_err "ERROR: failed to remove \"${BIN_DIR}/${PERF_EXE_PRIV}\"."
            exit 107
        fi
    fi
}

if [ $# -eq 1 ] ; then
    case "$1" in
        -h | --help)
        print_usage_and_exit 0
        ;;
    esac
fi

while [ $# -gt 0 ] ; do
    case "$1" in
        -g | --group)
            GROUP_NAME="$2"
            shift
            ;;

        -c | --command)
            case "$2" in
                setup | remove)
                 COMMAND_NAME="$2"
                 shift
                 ;;
            *)
                print_err ""
                print_err "ERROR: unrecognized command $2."
                print_usage_and_exit 100
                ;;
            esac

            shift
            ;;
        *)
            print_err ""
            print_err "ERROR: unrecognized option $1."
            print_usage_and_exit 101
            ;;
    esac
    shift $(( $# > 0 ? 1 : 0 ))
done

if [ $COMMAND_NAME = "setup" ] ; then
    if [ $(id -u) -ne 0 ] ; then
        print_msg "NOTE: super-user or \"root\" privileges are required."
        print_nnl "Please enter \"root\" "
        exec su -c "/bin/sh $0 $@"
        print_msg ""
        exit 0
    fi

    create_binary_and_set_capabilities "bin64"
fi

if [ $COMMAND_NAME = "remove" ] ; then
    remove_binary "bin64"
fi

print_msg "Done"

exit 0
