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


class dstat_plugin(dstat):
    """
    Time spent servicing the read and write transactions per device.

    Displays the cumulative time for read and write I/O transactions per device.
    Includes the Software RAID devices
    """

    def __init__(self):
        self.nick = ('reads', 'writs' )
        self.type = 'd'
        self.scale = 1000
        self.diskfilter = re.compile('^(dm-\d+|[hsv]d[a-z]+\d+)$')
        self.open('/proc/diskstats')
        self.cols = 2

    def discover(self, *objlist):
        ret = []
        for l in self.splitlines():
            if len(l) < 13: continue
            if l[3:] == ['0',] * 11: continue
            name = l[2]
            ret.append(name)
        for item in objlist: ret.append(item)
        if not ret:
            raise Exception("No suitable block devices found to monitor")
        return ret

    def vars(self):
        ret = []
        if op.disklist:
            varlist = list(op.disklist)
        else:
            varlist = []
            for name in self.discover:
                if self.diskfilter.match(name): continue
                if name not in blockdevices(): continue
                varlist.append(name)
            varlist.sort()
        for name in varlist:
            if name in self.discover + list(op.diskset):
                ret.append(name)
        return ret

    def name(self):
        return ['tim/'+sysfs_dev(name) for name in self.vars]

    def extract(self):
        for name in self.vars: self.set2[name] = (0, 0)
        for l in self.splitlines():
            if len(l) < 13: continue
            if l[3] == '0' and l[7] == '0': continue
            name = l[2]
            if l[3:] == ['0',] * 11: continue
            if name in self.vars:
                self.set2[name] = ( self.set2[name][0] + int(l[6]), self.set2[name][1] + int(l[10]))
            for diskset in self.vars:
                if diskset in list(op.diskset):
                    for disk in op.diskset[diskset]:
                        if re.match('^'+disk+'$', name):
                            self.set2[diskset] = ( self.set2[diskset][0] + int(l[6]), self.set2[diskset][1] + int(l[10]) )
        for name in self.set2.keys():
            self.val[name] = (
                (self.set2[name][0] - self.set1[name][0]),
                (self.set2[name][1] - self.set1[name][1]),
            )
        if step == op.delay:
            self.set1.update(self.set2)

# vim:ts=4:sw=4:et 
