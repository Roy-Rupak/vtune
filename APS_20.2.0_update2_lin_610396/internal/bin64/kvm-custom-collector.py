from __future__ import print_function

import argparse
import os
import subprocess
import sys
import signal


def delete_result_on_kvm(kvm_login, kvm_result_dir):
    print('Deleting the specified result on the KVM...')
    cmd = 'ssh {} rm -rf {}'.format(kvm_login, kvm_result_dir)
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    p.wait()


def check_ssh_connection(kvm_login):
    print('Checking SSH connection to the KVM system...')
    cmd = 'ssh {} test -e /'.format(kvm_login)
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    p.wait()
    if p.returncode == 0:
        print('SSH connection works.')
    else:
        print('SSH connection failed.')
        sys.exit(1)


def check_product_on_kvm(kvm_login, vtune_bin_dir_on_kvm):
    print('Detecting the product on the KVM system...')
    cmd = 'ssh {} test -e {}'.format(kvm_login, vtune_bin_dir_on_kvm)
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    p.wait()
    if p.returncode != 0:
        print('VTune Amplifier is not detected on the KVM. '
              'Cancelling collection...')
        sys.exit(1)
    else:
        print('VTune Amplifier has been successfully detected on the KVM.')


def start_collection_on_kvm(kvm_login, vtune_bin_dir_on_kvm, kvm_result_dir):
    print('Starting collection on the KVM...')
    cmd = ['ssh', kvm_login,
           '{}/amplxe-runss'.format(vtune_bin_dir_on_kvm),
           '--collector=perf',
           '--perf-event-config="cpu-clock:u -F 10"',
           '--stdsrc-config=cswitch',
           '--duration', 'unlimited', '-r',
           kvm_result_dir]
    subprocess.Popen(cmd)


def stop_collection_on_kvm(kvm_login, vtune_bin_dir_on_kvm, kvm_result_dir):
    print('Stopping collection on the KVM...')
    cmd = ('ssh {} {}/amplxe-runss '
           '-command=stop -r {}'.format(kvm_login,
                                        vtune_bin_dir_on_kvm,
                                        kvm_result_dir))
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    p.wait()
    if p.returncode == 0:
        print('Collection has been successfully stopped.')
    else:
        print('Failed to stop collection on the KVM.')
        sys.exit(1)


def move_kvm_result_to_host(kvm_login, kvm_result_dir, data_dir):
    print('Copying the result from the KVM to the host system...')
    cmd = 'scp -r {}:{}/data.0/* {}/KVM'.format(kvm_login, kvm_result_dir,
                                                data_dir)
    p = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE)
    p.wait()
    if p.returncode == 0:
        print('KVM result has been successfully copied to the host.')
        delete_result_on_kvm(kvm_login, kvm_result_dir)
    else:
        print('Failed to copy the KVM result to the host.')
        delete_result_on_kvm(kvm_login, kvm_result_dir)
        sys.exit(1)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--kvm-ssh-login',
                        help='Specify a username and IP of the KVM to login via SSH. '
                             'Example: user@12.345.67.89',
                        required=True)
    parser.add_argument('--vtune-dir-on-kvm',
                        default='/opt/intel/vtune-amplifier',
                        help='Specify VTune Amplifier installation directory on the KVM.')
    options = parser.parse_args()
    kvm_login = options.kvm_ssh_login
    vtune_dir_on_kvm = options.vtune_dir_on_kvm

    collect_cmd = os.getenv('AMPLXE_COLLECT_CMD')
    data_dir = os.getenv('AMPLXE_DATA_DIR')

    vtune_bin_dir_on_kvm = os.path.join(vtune_dir_on_kvm, 'bin64')
    kvm_result_dir = '/tmp/kvmResultDir'

    if collect_cmd == 'start':
        check_ssh_connection(kvm_login)
        check_product_on_kvm(kvm_login, vtune_bin_dir_on_kvm)
        delete_result_on_kvm(kvm_login, kvm_result_dir)
        start_collection_on_kvm(kvm_login, vtune_bin_dir_on_kvm, kvm_result_dir)
    elif collect_cmd == 'stop':
        stop_collection_on_kvm(kvm_login, vtune_bin_dir_on_kvm, kvm_result_dir)
        print('Creating a KVM folder in the result directory on the host...')
        os.mkdir('{}/KVM'.format(data_dir))
        move_kvm_result_to_host(kvm_login, kvm_result_dir, data_dir)
    else:
        print('The script should be executed as the custom collector.')
        sys.exit(1)


if __name__ == '__main__':
    # disable Ctrl-C signal
    signal.signal(signal.SIGINT, signal.SIG_IGN)
    main()
