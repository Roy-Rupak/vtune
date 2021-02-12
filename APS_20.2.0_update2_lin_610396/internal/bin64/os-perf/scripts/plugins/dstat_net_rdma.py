### This program is free software; you can redistribute it and/or modify
### it under the terms of the GNU Library General Public License as published by
### the Free Software Foundation; version 2 only
###
### This program is distributed in the hope that it will be useful,
### but WITHOUT ANY WARRANTY; without even the implied warranty of
### MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
### GNU Library General Public License for more details.
###
### You should have received a copy of the GNU Library General Public License
### along with this program; if not, write to the Free Software
### Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
### Copyright 2004-2007 Dag Wieers <dag@wieers.com>


import os

class dstat_plugin(dstat):
    """
    Performance Counters for RDMA

    Displays the delta for packets and bytes received and transmitted( unicast and multicast) per device.
    Written for Mellanox Infiniband devices, implementation may vary depending on HW vendor.
    """

    def __init__(self):
        self.nick = ('multi_rx_pkts', 'uni_rx_pkts', 'multi_tx_pkts', 'uni_tx_pkts', 'uni_tx_bytes', 'uni_rx_bytes')
        self.type = 'd'
        self.totalfilter = re.compile('^(lo|bond\d+|face|.+\.\d+)$')
        self.open('/proc/net/dev')
        self.cols = 6
        self.width = 12

    def discover(self, *objlist):
        ret = []
        devices = []
        virtual_devices = []
        for l in self.splitlines(replace=':'):
            if len(l) < 17: continue
            if l[2] == '0' and l[10] == '0': continue
            name = l[0]
            if name not in ('lo', 'face', 'eno1') and os.path.exists('/sys/class/net/{0}/device/infiniband'.format(name)):
                devices.append(name)
            # virtual devices do not have /sys/class/net/<device-name>/device endpoint
            if not (os.path.exists('/sys/class/net/{0}/device'.format(name))):
                virtual_devices.append(name)
        # create a new list by filtering out the virtual device which are created due to docker creation
        ret = [item for item in devices if item not in virtual_devices]
        ret.sort()
        for item in objlist: ret.append(item)
        return ret

    def vars(self):
        ret = []
        varlist = self.discover
        for name in varlist:
            mlx_devices = [name + '/' + device for device in
                           (os.listdir('/sys/class/net/{0}/device/infiniband'.format(name)))]
            for mlx_device in mlx_devices:
                ret.append(mlx_device)
        return ret

    def name(self):
        return ['net/' + name for name in self.vars]

    def extract(self):
        dict_of_counters = dict.fromkeys(
            ['unicast_rcv_packets', 'unicast_xmit_packets', 'port_rcv_data', 'port_xmit_data', 'multicast_rcv_packets',
             'multicast_xmit_packets'])

        for name in self.vars: self.set2[name] = (0, 0, 0, 0, 0, 0)
        for name in self.vars:
            for key, value in dict_of_counters.items():
                with open('/sys/class/net/{0}/device/infiniband/{1}/ports/1/counters/{2}'.format(name.split('/')[0], name.split('/')[1], key)) as sysfs:
                    dict_of_counters[key] = int(sysfs.read())

                if (key == 'port_rcv_data' or key == 'port_xmit_data'):
                    dict_of_counters[key] = dict_of_counters[key] * 4

            self.set2[name] = dict_of_counters.values()

        for name in self.set2.keys():
            self.val[name] = tuple([s2 - s1 for s2, s1 in zip(self.set2[name], self.set1[name])])

        if step == op.delay:
            self.set1.update(self.set2)


# vim:ts=4:sw=4:et