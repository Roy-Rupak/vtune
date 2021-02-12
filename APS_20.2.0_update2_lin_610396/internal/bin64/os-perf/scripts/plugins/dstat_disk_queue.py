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
    I/O queue depth of bandwidth utilization for block devices.
    Includes the Software RAID devices
    The value is instantaneous at the time of reading

    """

    def __init__(self):
        self.nick = ('queue', )
        self.scale = 1000
        self.type = 'd'
        self.diskfilter = re.compile('^(dm-\d+|[hsv]d[a-z]+\d+)$')
        self.open('/proc/diskstats')
        self.cols = 1

    def discover(self, *objlist):
        ret = []
        for l in self.splitlines():
            if len(l) < 13: continue
            if l[3:] == ['0',] * 11: continue
            name = l[2]
            ret.append(name)
        for item in objlist: ret.append(item)
        if not ret:
            raise Exception('No suitable block devices found to monitor')
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
        return ['qu/'+sysfs_dev(name) for name in self.vars]

    def extract(self):
        for name in self.vars: self.set1[name] = (0)
        for l in self.splitlines():
            if len(l) < 13: continue
            name = l[2]
            if l[3:] == ['0',] * 11: continue
            if name in self.vars:
                self.val[name] = (int(l[11]))
            for diskset in self.vars:
                if diskset in list(op.diskset):
                    for disk in op.diskset[diskset]:
                        if re.match('^'+disk+'$', name):
                            self.val[diskset] = ( int(l[11]) )

# vim:ts=4:sw=4:et 
