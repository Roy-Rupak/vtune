#!/bin/sh

#
# File: prepare-debugfs
#
# Description: script which either installs bootscript which prepares
#     debugfs for VTune(TM) Amplifier XE, or performs this operation once
#
# Version: 1.0
#
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

PATH="/sbin:/usr/sbin:/bin:/usr/bin/:/usr/local/sbin:/usr/local/bin:/usr/local/gnu/bin:.:"${PATH}
export PATH

# ------------------------------- OUTPUT -------------------------------------
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

# ------------------------------ COMMANDS ------------------------------------
GREP="grep"
LN="ln"
RM="rm"
SED="sed"
SU="su"
WHICH="which"
MOUNT="mount"
UMOUNT="umount"
CHMOD="chmod"
CHGRP="chgrp"
AWK="awk"
HEAD="head"
FIND="find"

COMMANDS_TO_CHECK="${LN} ${RM} ${SED} ${WHICH} ${MOUNT} ${UMOUNT} ${CHMOD} ${CHGRP} ${AWK} ${HEAD} ${FIND}"

#
# Note: Busybox has a restricted shell environment, and 
#       conventional system utilities may not be present;
#       so need to account for this ...
#

# busybox binary check
BUSYBOX_SHELL=` ${GREP} --help 2>&1 | ${GREP} BusyBox`

if [ -z "${BUSYBOX_SHELL}" ] ; then
    COMMANDS_TO_CHECK="${SU} ${COMMANDS_TO_CHECK}"
fi

# if any of the COMMANDS_TO_CHECK are not executable, then exit script
OK="true"
for c in ${COMMANDS_TO_CHECK} ; do
    CMD=`${WHICH} $c 2>&1` ;
    if [ -z "${CMD}" ] ; then
        OK="false"
        print_err "ERROR: unable to find command \"$c\" !"
    fi
done

if [ ${OK} != "true" ] ; then
    print_err "Please add the location to the above commands to your PATH and re-run the script ... exiting."
    exit 255
fi

# ------------------------------ VARIABLES -----------------------------------

SCRIPT=$0
SCRIPT_ARGS="$@"
SCRIPT_DIR=`dirname $PWD/$SCRIPT`
BOOTSCRIPT=vtune_debugfs

# ------------------------------ FUNCTIONS -----------------------------------

# function to show usage and exit
default_group='vtune'

print_usage_and_exit()
{
    err=${1:-0}
    print_msg ""
    print_msg "Usage: $0 [ option ]"
    print_msg ""
    print_msg " where \"option\" is one of the following:"
    print_msg ""
    print_msg "    -h | --help"
    print_msg "      Prints out usage."
    print_msg ""
    print_msg "    -i | --install"
    print_msg "      Configures the autoload debugfs boot script and then installs it in the "
    print_msg "      appropriate system directory."
    print_msg ""
    print_msg "    --user <user>"
    print_msg "      Adds the specified user to the group with debugFS access permissions. "
    print_msg ""
    print_msg "    -u | --uninstall"
    print_msg "      Uninstalls a previously installed debugfs boot script and "
    print_msg "      reverts configuration."
    print_msg ""
    print_msg "    -g | --group <group>"
    print_msg "      Specifies the group other than '$debugfs_group' to access debugFS."
    print_msg ""
    print_msg "    -c | --check"
    print_msg "      Performs mount and permisions check."
    print_msg ""
    print_msg "    -r | --revert"
    print_msg "      Reverts debugfs configuration."
    print_msg ""
    print_msg "    -b | --batch"
    print_msg "      Run in non-interactive mode (exit in case of already changed permissions)."
    print_msg ""
    print_msg " Without options, script will configure debugfs."
    exit $err
}

# --------------------------------- MAIN -------------------------------------

# if only help option specified, then show options
if [ $# -eq 1 ] ; then
    case "$1" in
        -h | --help)
        print_usage_and_exit 0
        ;;
    esac
fi

# check if USER is root
if [ -z "${BUSYBOX_SHELL}" ] ; then
    if [ "root" != "${USER}" ] ; then
        if [ ! -w /dev ] ; then
            print_msg "NOTE:  super-user or \"root\" privileges are required in order to continue."
            print_nnl "Please enter \"root\" "
            exec ${SU} -c "/bin/sh ${SCRIPT} ${SCRIPT_ARGS}"
            print_msg ""
            exit 0
        fi
    fi
fi

# parse the options
install_boot_script=0
uninstall_boot_script=0
configure_debugfs=1
exit_after_check=0
interactive=1
username=""

while [ $# -gt 0 ] ; do
    case "$1" in
        -i | --install)
            install_boot_script=1
            interactive=0
            ;;
        -u | --uninstall)
            configure_debugfs=0
            uninstall_boot_script=1
            interactive=0
            ;;
        -c | --check)
            exit_after_check=1
            interactive=0
            ;;
        -r | --revert)
            configure_debugfs=0
            ;;
        -g | --group)
            default_group="$2"
            shift
            ;;
        -b | --batch)
            interactive=0
            ;;
        --user)
            username="$2"
            shift
            ;;
        *)
            print_err ""
            print_err "ERROR: unrecognized option $1"
            print_usage_and_exit 3
            ;;
    esac
    shift
done

check_mounts_and_perms()
{
    print_msg "Checking if kernel supports debugfs"
    kernel_config="/boot/config-$(uname -r)"
    if [ -f "$kernel_config" ]; then 
        if [ -z "$(${GREP} 'CONFIG_DEBUG_FS=y' $kernel_config)" ]; then
            print_err "ERROR: Your kernel does not support debugfs"
            exit 23
        fi
    else
        print_msg "Kernel config file is absent, skipping check"
    fi
    print_msg "debugfs is supported"

    print_msg "Checking if debugfs is mounted on /sys/kernel/debug"
    if [ -z "$(${MOUNT} | ${GREP} debugfs)" ]; then
        if [ -d "/sys/kernel/debug/tracing" ]; then
            print_msg "Already mounted on /sys/kernel/debug"
        else
            print_msg "Not mounted, mounting to check"
            mount -t debugfs none /sys/kernel/debug
            if [ $? -ne 0 ]; then
                print_err "Failed to mount debugfs"
                exit 24
            fi
        fi
    fi
    print_msg "debugfs is mounted"

    found_changed=0
    mountpoint=$(${MOUNT} | ${GREP} debugfs | ${AWK} '{print $3};' | ${HEAD} -n1)
    if [ -z "$mountpoint" ]; then
        mountpoint="/sys/kernel/debug"
    fi
    print_msg "Mount point is $mountpoint, checking group ownership"
    for entryinfo in $(${FIND} $mountpoint -maxdepth 1 -printf "%p,%g\n"); do
        name=$(echo $entryinfo | cut -d, -f1)
        group=$(echo $entryinfo | cut -d, -f2)
        if [ "$group" != "${default_group}" ] && [ "$group" != "root" ]; then
            print_msg "WARNING: entry $name is owned by group '$group' which is different than 'root' and '$default_group'"
            found_changed=1
        fi
    done
    print_msg "group ownership is ok"

    if [ $found_changed -eq 1 ]; then
        if [ $interactive -eq 0 ]; then
            print_err "Some entries have changed permissions. Mode is non-interactive so just exiting"
            exit 25
        else
            print_msg "Some entries have changed permissions. Continue at your own risk. "
            print_msg "Some software relying on debugfs may become unstable. "
            print_nnl "Continue? ( y/n ) ? [n] "
            read answer
            if [ -z "$answer" ] || [ "n" = "$answer" ]; then
                print_err "Exiting per user decision"
                exit 26
            fi
        fi
    fi
}

configure_debugfs()
{
    if [ -z "$(${MOUNT} | grep ' /sys/kernel/debug ')" ] && [ ! -d "/sys/kernel/debug" ]; then
        print_msg "Mounting debugfs to /sys/kernel/debug"
        ${MOUNT} -t debugfs none /sys/kernel/debug
        if [ $? -ne 0 ]; then
            print_err "Failed to mount debugfs"
            exit 27
        fi
    fi

    print_msg "Changing group ownership"
    ${CHGRP} -R $default_group /sys/kernel/debug
    if [ $? -ne 0 ]; then
        print_err "Failed to change group ownership"
        exit 28
    fi

    print_msg "Changing permissions"
    ${CHMOD} -R g+rwx /sys/kernel/debug/
    if [ $? -ne 0 ]; then
        print_err "Failed to change permissions"
        exit 29
    fi
}

revert_debugfs()
{
    print_msg "Reverting debugfs access permissions"
    ${CHMOD} -R g-rwx /sys/kernel/debug
    if [ $? -ne 0 ]; then
        print_err "Failed to change permissions"
        exit 30
    fi

    print_msg "Reverting group ownership"
    ${CHGRP} -R root /sys/kernel/debug
    if [ $? -ne 0 ]; then
        print_err "Failed to change group ownership"
        exit 31
    fi
}

distro=
DEFAULT_REDHAT_BOOT_INSTALL="/etc/rc.d/init.d"
DEFAULT_SUSE_BOOT_INSTALL="/etc/init.d"
DEFAULT_DEBIAN_BOOT_INSTALL="/etc/init.d"
DEFAULT_BOOT_INSTALL=
LSB_BIN=
RUNLEVEL_DIR=
RELATIVE_BOOT_INSTALL=
check_distro()
{
    if [ -f "/etc/redhat-release" ]; then
        distro="redhat"
    elif [ -f "/etc/SuSE-release" ]; then
        distro="suse"
    else
        distro="debian"
    fi
    if [ "redhat" = "$distro" ]; then
        DEFAULT_BOOT_INSTALL=${DEFAULT_REDHAT_BOOT_INSTALL}
        RUNLEVEL_DIR=/etc/rc.d
        RELATIVE_BOOT_INSTALL=../init.d
    else
        LSB_BIN=/usr/lib/lsb
        if [ "suse" = "$distro" ]; then
            DEFAULT_BOOT_INSTALL=${DEFAULT_SUSE_BOOT_INSTALL}
            RUNLEVEL_DIR=/etc/init.d
            RELATIVE_BOOT_INSTALL=.
        else
            DEFAULT_BOOT_INSTALL=${DEFAULT_DEBIAN_BOOT_INSTALL}
            RUNLEVEL_DIR=/etc
            RELATIVE_BOOT_INSTALL=../init.d
        fi
    fi
}

create_boot_script()
{
    SCRIPT_PATH="$1"
    ${RM} -f $SCRIPT_PATH
    cat > $SCRIPT_PATH <<EOF
#!/bin/sh

#
# File: $BOOTSCRIPT
#
# Description: script to configure debugfs at boot time
#
# Version: 1.0
#
# Copyright (C) 2013 Intel Corporation.  All Rights Reserved.
# 
#

### BEGIN INIT INFO ###
# Provides: $BOOTSCRIPT
# Required-Start: \$syslog
# Required-Stop: \$syslog
# Default-Start: 2 3 4 5
# Default-Stop: 0
# Short-Description: configures the debugfs at boot/shutdown time
# Description: configures the debugfs at boot/shutdown time
### END INIT INFO ###

# source the function library, if it exists

[ -r /etc/rc.d/init.d/functions ] && . /etc/rc.d/init.d/functions

if [ ! -d ${SCRIPT_DIR} ] ; then
  echo "Unable to access the script directory \"\${DRIVER_DIR}\" !"
  exit 101
fi

if [ ! -f ${SCRIPT_DIR}/${SCRIPT} ] ; then
  echo "The boot script \"${SCRIPT_DIR}/${SCRIPT}\" does not exist!"
  exit 102
fi

# define function to configure the debugfs
start() {
    echo "Configuring debugfs access permissions for VTune Amplifier"
    (cd ${SCRIPT_DIR} && ./${SCRIPT} --batch --group ${default_group})
    RETVAL=\$?
    return \$RETVAL
}

# define function to unconfigure the debugfs
stop() {
    echo "Unconfiguring debugfs access permissions for VTune Amplifier "
    (cd ${SCRIPT_DIR} && ./${SCRIPT} --revert)
    RETVAL=\$?
    return \$RETVAL
}

# define function to query whether debugfs is configured
# actually does nothing
status() {
    return 0
}

# parse command-line options and execute

RETVAL=0

case "\$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: \$0 {start|stop|restart|status}"
        exit 1
esac

exit \$RETVAL
EOF
    chmod a+rx $SCRIPT_PATH
}

install_boot_script()
{
    check_distro
    if [ -w ${DEFAULT_BOOT_INSTALL} ] ; then
        print_nnl "Creating boot script ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT} ... "
        create_boot_script ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT}
        if [ -r ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT} ] ; then
            print_msg "done."
        else
            print_err "Unable to create boot script ... exiting."
            exit 32
        fi
    else
        print_err "Unable to write to ${DEFAULT_BOOT_INSTALL} ... exiting."
        exit 33
    fi

    # configure autoload ...
    print_nnl "Configuring autoload of ${BOOTSCRIPT} driver for runlevels 2 through 5 ... "
    if [ "suse" = "${distro}" ]; then
        ${LSB_BIN}/install_initd ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT}
    elif [ "redhat" = "${distro}" -o "debian" = "${distro}" ]; then
        [ -w ${RUNLEVEL_DIR}/rc2.d ] && ${LN} -sf ${RELATIVE_BOOT_INSTALL}/${BOOTSCRIPT} ${RUNLEVEL_DIR}/rc2.d/S99${BOOTSCRIPT}
        [ -w ${RUNLEVEL_DIR}/rc3.d ] && ${LN} -sf ${RELATIVE_BOOT_INSTALL}/${BOOTSCRIPT} ${RUNLEVEL_DIR}/rc3.d/S99${BOOTSCRIPT}
        [ -w ${RUNLEVEL_DIR}/rc4.d ] && ${LN} -sf ${RELATIVE_BOOT_INSTALL}/${BOOTSCRIPT} ${RUNLEVEL_DIR}/rc4.d/S99${BOOTSCRIPT}
        [ -w ${RUNLEVEL_DIR}/rc5.d ] && ${LN} -sf ${RELATIVE_BOOT_INSTALL}/${BOOTSCRIPT} ${RUNLEVEL_DIR}/rc5.d/S99${BOOTSCRIPT}
    else
        print_nnl "WARNING: unable to create symlinks ... "
    fi
    print_msg "done."
}

uninstall_boot_script()
{
    check_distro
    if [ -f ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT} ] ; then
        print_nnl "Removing ${BOOTSCRIPT} boot script and symlinks for runlevels 2 through 5 ... "
        if [ "suse" = "${distro}" ]; then
            ${LSB_BIN}/remove_initd ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT}
            err=$?
            if [ $err -ne 0 ] ; then
                print_err "${LSB_BIN}/remove_initd returned error $err ... exiting."
                exit 34
            fi
        elif [ "redhat" = "${distro}" -o "debian" = "${distro}" ] ; then
            [ -w ${RUNLEVEL_DIR}/rc2.d ] && ${RM} -f ${RUNLEVEL_DIR}/rc2.d/S99${BOOTSCRIPT}
            [ -w ${RUNLEVEL_DIR}/rc3.d ] && ${RM} -f ${RUNLEVEL_DIR}/rc3.d/S99${BOOTSCRIPT}
            [ -w ${RUNLEVEL_DIR}/rc4.d ] && ${RM} -f ${RUNLEVEL_DIR}/rc4.d/S99${BOOTSCRIPT}
            [ -w ${RUNLEVEL_DIR}/rc5.d ] && ${RM} -f ${RUNLEVEL_DIR}/rc5.d/S99${BOOTSCRIPT}
        else
            print_nnl "WARNING: unable to remove symlinks ... "
        fi
        [ -w ${DEFAULT_BOOT_INSTALL} ] && ${RM} -f ${DEFAULT_BOOT_INSTALL}/${BOOTSCRIPT}
        print_msg "done."
    else
        print_msg "No previously installed ${BOOTSCRIPT} boot script was found."
    fi
}

if ! groups ${username} | grep ${default_group} > /dev/null ; then
    `usermod -a -G ${default_group} ${username}`
fi

if [ $configure_debugfs -eq 1 ]; then
    check_mounts_and_perms
    result=$?
    if [ $exit_after_check -eq 1 ]; then
        exit $result
    fi
    configure_debugfs
    if [ $install_boot_script -eq 1 ]; then
        uninstall_boot_script
        install_boot_script
    fi
else
    revert_debugfs
    if [ $uninstall_boot_script -eq 1 ]; then
        uninstall_boot_script
    fi
fi