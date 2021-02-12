#!/usr/bin/env python
"""
Copyright 2017 Intel Corporation All Rights Reserved.

The source code, information and material ("Material") contained
herein is owned by Intel Corporation or its suppliers or licensors,
and title to such Material remains with Intel Corporation or its
suppliers or licensors. The Material contains proprietary information
of Intel or its suppliers and licensors. The Material is protected by
worldwide copyright laws and treaty provisions. No part of the
Material may be used, copied, reproduced, modified, published,
uploaded, posted, transmitted, distributed or disclosed in any way
without Intel's prior express written permission.

No license under any patent, copyright or other intellectual property
rights in the Material is granted to or conferred upon you, either
expressly, by implication, inducement, estoppel or otherwise. Any
license under such intellectual property rights must be express and
approved by Intel in writing.

Unless otherwise agreed by Intel in writing, you may not remove or
alter this notice or any other notice embedded in Materials by Intel
or Intel's suppliers or licensors in any way.
"""

import subprocess
import sys
import os
import glob
import re
from optparse import OptionParser

messages = {"invalidResultTemplate"    : "invalid result template, too many groups with @",
            "invalidResultPath"        : "result path %s doesn't exist",
            "resultDirectoryExists"    : "result %s already exists",
            "reportFileExists"         : "report file %s already exists",
            "wrongResultLocation"      : "directory %s does not exist",
            "fileCreationUnknownError" : "cannot create output file",
            "collectionStarted"        : "collecting results...",
            "collectionFailed"         : "collection failed",
            "reportCretionStarted"     : "\nCreating report...",
            "reportCretionFailed"      : "report creation failed",
            "reportCretionPassed"      : "\nPGO report file was created: %s",
            "help"                     : "usage: %s [options] -- app arg1 arg2 ...\n" +\
                                         "Options:\n" +\
                                         "    -h, --help                       Show this help.\n" +\
                                         "    -r NAME, --result=NAME           Specify a result directory and a PGO report name template.\n" +\
                                         "                                     Default template is r@@@pgo,\n" +\
                                         "                                     where @@@ is an automatically incremented number of the result.\n" +\
                                         "    -c COMPILER, --compiler=COMPILER Specify a compiler for a PGO report format. Supported values are:\n" +\
                                         "                                     icc - Intel C/C++ and Intel Fortran compilers 2018 beta and higher\n" +\
                                         "                                     gcc - GCC compiler version 5.0 and higher\n" +\
                                         "                                     clang - Clang compiler version 3.8 and higher\n" +\
                                         "                                     clang-old - Clang compiler versions 3.5-3.7.\n" +\
                                         "                                     Default value is icc."
           }

def getScriptDir():
    return os.path.dirname(os.path.realpath(__file__))

def getNewResultName(resPathTemplate):
    path = os.path.realpath(os.path.dirname(resPathTemplate))
    exp = os.path.basename(resPathTemplate)
    patchedExpr = re.sub("@+", "(\d+)", exp, 1)
    if patchedExpr.find("@") != -1:
        print(messages["invalidResultTemplate"])
        return None
    if not os.path.isdir(path):
        print(messages["invalidResultPath"] % path)
        return None
    m = re.compile(patchedExpr)
    maxIndex = -1
    res = [f for f in os.listdir(path) if m.search(f)]
    for item in res:
        m = re.search(patchedExpr, item)
        if len(m.groups()) == 1:
            index = int(m.group(1))
            if index > maxIndex:
                maxIndex = index
    return os.path.join(path, re.sub("@+", '%03d' % (maxIndex + 1), exp, 1))

def checkAndGetReportFileName(resName, suffix):
    realFileName = os.path.realpath(resName)
    if os.path.exists(realFileName):
        print(messages["resultDirectoryExists"] % realFileName)
        return None
    if os.path.exists(realFileName + suffix):
        print(messages["resultDirectoryExists"] % (realFileName + suffix))
        return None
    if not os.path.exists(os.path.dirname(realFileName)):
        print(messages["wrongResultLocation"] % os.path.dirname(realFileName))
        return None
    return realFileName + suffix

def getReportFile(fileName):
    try:
        resFile = open(fileName, "w")
        return resFile
    except:
        print(messages["fileCreationUnknownError"])
        return None

usage = "usage: %prog [options] -- app arg1 arg2 ..."
parser = OptionParser(add_help_option=False, usage=usage)
parser.add_option("-r", "--result", dest="filename", default="r@@@pgo")
parser.add_option('-h', '--help', dest='help', action='store_true')
parser.add_option('-s', '--script', dest='scriptFile')
parser.add_option("-c", "--compiler", dest='compiler', default="icc")
(options, args) = parser.parse_args()
if options.help:
    print(messages["help"] % options.scriptFile)
    sys.exit(1)

scriptDir = getScriptDir()
productCl = os.path.join(scriptDir, "vtune")
resName = getNewResultName(options.filename)
if not resName:
    sys.exit(1)

suffix = "_" + options.compiler + ".pgo"

outputFileName = checkAndGetReportFileName(resName, suffix)
if not outputFileName:
    sys.exit(1)

if options.compiler == "icc":
    reportOptions = ["-R", "pgo-input", "--format=csv", "-csv-delimiter=comma"]
elif options.compiler == "clang":
    reportOptions = ["-R", "pgo", "--report-knob", "compiler=" + "clang", "--report-knob", "output=" + outputFileName]
elif options.compiler == "clang-old":
    reportOptions = ["-R", "pgo", "--report-knob", "compiler=" + "clang-old", "--report-knob", "output=" + outputFileName]
elif options.compiler == "gcc":
    reportOptions = ["-R", "pgo", "--report-knob", "compiler=" + "gcc", "--report-knob", "output=" + outputFileName]
else:
    print(messages["help"] % options.scriptFile)
    sys.exit(1)

myEnv = os.environ
if "AMPLXE_EXPERIMENTAL" in myEnv.keys():
    myEnv["AMPLXE_EXPERIMENTAL"] += ",pgo"
else:
    myEnv["AMPLXE_EXPERIMENTAL"] = "pgo"

print(messages["collectionStarted"])
proc = subprocess.Popen([productCl, "-data-limit=0", "-no-summary", "-r", resName, "-c", "pgo", "--"] + args, stdout = sys.stdout, stderr = sys.stderr, env=myEnv)
ret = proc.wait()
if ret != 0:
    print(messages["collectionFailed"])
    sys.exit(ret)

outputFile = getReportFile(outputFileName)
if not outputFile:
    sys.exit(1)
print(messages["reportCretionStarted"])
if options.compiler == "icc":
    output = outputFile
else:
    output = sys.stdout
proc = subprocess.Popen([productCl, "-r", resName] + reportOptions, stdout = output, stderr = sys.stderr, env=myEnv)
ret = proc.wait()
outputFile.close()
if ret != 0:
    print(messages["reportCretionFailed"])
    sys.exit(ret)
print(messages["reportCretionPassed"] % outputFileName)
