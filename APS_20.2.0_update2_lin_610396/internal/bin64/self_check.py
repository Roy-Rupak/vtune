#!/usr/bin/env python
"""
Copyright 2016-2019 Intel Corporation All Rights Reserved.

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
import sys
import os
import subprocess
import shutil
import time
import getpass
import re
# Fix of:
#   LookupError: no codec search functions registered: can't find encoding
# Not remove import of 'locale'!
import locale
from tempfile import gettempdir
from optparse import OptionParser

CL_TOOL = "vtune"
PRODUCT_ABBR = "vtune"
INTERNAL_PREFIX = "amplxe-"

# messages
TPSS_CHECK_NAME = "Instrumentation based analysis check"
AH_WITH_STACKS_CHECK_NAME = "HW event-based analysis with stacks"
AH_CHECK_NAME = "HW event-based analysis check"
GE_CHECK_NAME = "HW event-based analysis check"
MA_CHECK_NAME = "HW event-based analysis with uncore events"
TH_CHECK_NAME = "HW event-based analysis with context switches"

TPSS_CHECK_ANALYSIS = "Hotspots with default knob sampling-mode=sw, Threading with default knob sampling-and-waits=sw"
AH_WITH_STACKS_CHECK_ANALYSIS = "Hotspots with knob sampling-mode=hw and knob enable-stack-collection=true, etc."
AH_CHECK_ANALYSIS = "Hotspots with knob sampling-mode=hw, HPC Performance Characterization, etc."
GE_CHECK_ANALYSIS = "Microarchitecture Exploration"
MA_CHECK_ANALYSIS = "Memory Access"
TH_CHECK_ANALYSIS = "Threading with knob sampling-and-waits=hw"

COLLECTION = "Collection"
FINALIZATION = "Finalization"
REPORT = "Report"

PERF = "Perf"
INTEL_DRIVER = "Intel driver"

COPYRIGHTS = "Intel(R) VTune(TM) Profiler Self Check Utility\n"
COPYRIGHTS += "Copyright (C) 2009-2019 Intel Corporation. All rights reserved."

FOLDER_NOT_EMPTY = "Custom folder for log is not empty."
FOLDER_NOT_AVAILABLE = "Input directory for log is not available. Use an existing directory."
TEMP_FOLDER_NOT_AVAILABLE = "Temporary directory is not available. Use the option '--log-dir' to specify a custom folder for logs."
NECESSARY_FILES_NOT_FOUND = "The necessary files could not be found."
MESSAGE_CATALOG_NOT_FOUND = "The necessary message catalogs could not be found."

SYSTEM_READY = "The system is ready to be used for performance analysis with Intel VTune Profiler."
SISTEM_NOT_READY = "The check observed a product failure on your system.\n"
SISTEM_NOT_READY += "Review errors in the output above to fix a problem or contact Intel technical support."
UNKNOWN_FAIL = "An unknown failure has occurred. Attempt the action again or contact Intel technical support."
SEE_WARNINGS = "Review warnings in the output above to find product limitations, if any."

OLD_DRIVER = "The driver installed does not match the product version."  # not user visisble
NOT_PERMISSION_FOR_DRIVER = PRODUCT_ABBR + ": Warning: VTune Profiler driver with insufficient permission is detected on the system.\n"
NOT_PERMISSION_FOR_DRIVER += PRODUCT_ABBR + ": Warning: Consider setting proper driver permissions (see the \"Sampling Drivers\" help topic).\n"
NOT_PERMISSION_FOR_DRIVER += PRODUCT_ABBR + ": Warning: Otherwise, the driverless collection with limited analysis support will be enabled by default."
NO_SEP_AVAILABLE = "The SEP driver is not available."  # not user visisble

HELP_LOG_DIR = "path to directory where to store log"

ERROR_TAG = PRODUCT_ABBR + ": Error:"
WARNING_TAG = PRODUCT_ABBR + ": Warning:"
CANNOT_LOCATE_FILE_WARNING = "Cannot locate file"
CANNOT_LOCATE_DEBUGGING_INFORMATION_WARNING = "Cannot locate debugging information for file"


class FileNotExistError(Exception):
    def __init__(self, path):
        self.path = path


def check_file_exist(path):
    if not os.path.isfile(path):
        raise FileNotExistError(path)


class Log(object):
    def __init__(self, log_path):
        self.log_location = log_path
        self.log_file = open(log_path, 'w+')

    def __del__(self):
        self.to_stdout("\nLog location: " + str(self.log_location))
        self.log_file.close()

    def to_log(self, message):
        """Write message to log.txt.

        args:
            message - string to write to file

        """
        self.log_file.write(message + '\n')
        self.log_file.flush()

    def to_stdout(self, message, temp=False):
        """Write message to stdout and log.txt.

        args:
            message - string to write to file

        """
        if temp:
            sys.stdout.write(message + '\r')
        else:
            sys.stdout.write(message + '\n')
        sys.stdout.flush()
        self.to_log(message.lstrip(' '))

    def phase_error(self, error):
        title = error.title
        description = error.description
        self.to_stdout('\n' + str(title))
        if description:
            self.to_log(str(description))


class State(object):
    def __init__(self, bin_dir, work_dir):
        self.status = 'OK'
        self.bin_dir = bin_dir
        if work_dir:
            self.work_dir = work_dir
        else:
            work_dir = self.get_temp_work_dir()
            if work_dir is None:
                sys.stdout.write("%s\n" % TEMP_FOLDER_NOT_AVAILABLE)
                self.status = 'FAIL'
            else:
                self.work_dir = work_dir

        if not self._check_dir_empty():
            sys.stdout.write("\n%s\n\n" % FOLDER_NOT_EMPTY)
            self.status = 'FAIL'

        self.product_dir = os.path.dirname(self.bin_dir)

        self.log_location = os.path.abspath(os.path.join(self.work_dir, 'log.txt'))
        self.log = Log(self.log_location)
        self.write_header()

        self.cl_path = self.get_runtool_path(CL_TOOL)
        self.runss_path = self.get_runtool_path(INTERNAL_PREFIX + 'runss')
        self.app_path = self.get_application_path()
        self.source_dir = os.path.join(os.path.dirname(self.app_path), 'src')

        try:
            self._check_necessary_files_exist()
        except FileNotExistError as e:
            self.log.to_stdout(NECESSARY_FILES_NOT_FOUND)
            self.log.to_log("Cannot find file by path: %s" % e.path)
            self.status = 'FAIL'

        self.output_indent = '    '
        self.stdout_indent = '  '

        self.has_warnings = False

        self.ignored_warnings = []
        try:
            self.get_ignored_warnings()
            self.log.to_log("Ignored warnings: %s" % self.ignored_warnings)
            if len(self.ignored_warnings) != 2:
                self.status = 'FAIL'
            else:
                self.ignored_warnings = [PRODUCT_ABBR + ': Warning: ' + warn for warn in self.ignored_warnings]
        except FileNotExistError as e:
            self.log.to_stdout(MESSAGE_CATALOG_NOT_FOUND)
            self.log.to_log("Cannot find file by path: %s" % e.path)
            self.status = 'FAIL'

    def get_temp_work_dir(self):
        temp_dir = gettempdir()
        if temp_dir:
            timestamp = time.strftime("%Y.%m.%d_%H.%M.%S")
            user_name = getpass.getuser()
            parent_dir = os.path.join(temp_dir, PRODUCT_ABBR + '-tmp-' + user_name)
            if not os.path.exists(parent_dir):
                    os.makedirs(parent_dir)
            work_dir = os.path.abspath(os.path.join(parent_dir, 'self-checker-' + timestamp))
            if not os.path.exists(work_dir):
                    os.makedirs(work_dir)
            else:
                shutil.rmtree(work_dir, ignore_errors=True)
                os.makedirs(work_dir)
            return work_dir
        else:
            return None

    def get_runtool_path(self, runtool_type):
        runtool_name = runtool_type
        if 'win32' == sys.platform:
            runtool_name += '.exe'
        runtool_path = os.path.join(self.bin_dir, runtool_name)
        return runtool_path

    def get_application_path(self):
        app_dir = os.path.join(self.product_dir, 'samples', 'en', 'C++', 'matrix')
        app_name = 'matrix'
        if sys.platform == 'win32':
            app_name += '.exe'
        app_path = os.path.join(app_dir, app_name)
        return app_path

    def get_support_path(self):
        support_name = 'support.txt'
        install_dir = os.path.dirname(self.bin_dir)
        support_path = os.path.join(install_dir, support_name)
        check_file_exist(support_path)
        return support_path

    def get_build_number(self):
        try:
            support_path = self.get_support_path()
        except FileNotExistError as e:
            self.log.to_log("Cannot find 'support.txt' by path: %s" % e.path)
        if support_path:
            support_file = open(support_path, 'r')
            try:
                data = support_file.readlines()
            finally:
                support_file.close()
            for line in data:
                if line.startswith('Build Number:'):
                    return line
        return None

    def write_header(self):
        header = "%s\n" % COPYRIGHTS
        build_number = self.get_build_number()
        if build_number:
            self.log.to_stdout(header + build_number.strip() + '\n')
        else:
            self.log.to_stdout(header)

    def append_to_work_dir(self, name):
        appended_path = os.path.join(self.work_dir, name)
        return appended_path

    def remove_dir(self, dir):
        shutil.rmtree(dir, ignore_errors=True)

    def _check_necessary_files_exist(self):
        check_file_exist(self.cl_path)
        check_file_exist(self.app_path)
        check_file_exist(self.runss_path)

    def _check_dir_empty(self):
        if not os.listdir(self.work_dir):
            return True
        return False

    def get_ignored_warnings(self):
        product_dir = self.product_dir
        perfcollector_catalog = os.path.join(product_dir, "message", "en", "perfrun1", "perfrun1.perfcollector.xmc")
        check_file_exist(perfcollector_catalog)
        file_obj = open(perfcollector_catalog, 'r', encoding="utf-8")
        try:
            data = file_obj.read()
        finally:
            file_obj.close()
        lines = data.splitlines()
        for line in lines:
            if 'CustomKernelModules' in line:
                msg = re.search('>.*<', line).group(0)[1:-1]
                self.ignored_warnings.append(msg)

        sep_catalog = os.path.join(product_dir, "message", "en", "perfrun1", "perfrun1.sep.xmc")
        check_file_exist(sep_catalog)
        file_obj = open(sep_catalog, 'r', encoding="utf-8")
        try:
            data = file_obj.read()
        finally:
            file_obj.close()
        lines = data.splitlines()
        for line in lines:
            if 'nmi-watchdog-disable' in line:
                msg = re.search('>.*<', line).group(0)[1:-1]
                self.ignored_warnings.append(msg)

    def get_result_dir_abs_path(self, test_descriptor):
        if test_descriptor.get('real_result_dir', None):
            result_dir_abs_path = test_descriptor['real_result_dir']
        else:
            result_dir_name = test_descriptor['result_dir']
            result_dir_abs_path = self.state.append_to_work_dir(result_dir_name)

        return result_dir_abs_path


vtune_base_test_descriptor = [
    {
        'name': TPSS_CHECK_NAME,
        'result_dir': 'result_tpss',
        'collect_params': [
            '-collect', 'hotspots',
            '-r',
        ],
        'show_collector': False,
        'analysis': TPSS_CHECK_ANALYSIS,
        'disabled': [],
    },
    {
        'name': AH_CHECK_NAME,
        'result_dir': 'result_ah',
        'collect_params': [
            '-collect', 'hotspots',
            '-knob sampling-mode=hw',
            '-r',
        ],
        'show_collector': True,
        'analysis': AH_CHECK_ANALYSIS,
        'disabled': ['DASHBOARD_HW_EVENT_BASED_SAMPLING_DISABLED'],
    },
    {
        'name': GE_CHECK_NAME,
        'result_dir': 'result_ge',
        'collect_params': [
            '-collect', 'uarch-exploration',
            '-r',
        ],
        'show_collector': True,
        'analysis': GE_CHECK_ANALYSIS,
        'disabled': ['DASHBOARD_HW_EVENT_BASED_SAMPLING_DISABLED'],
    },
    {
        'name': MA_CHECK_NAME,
        'result_dir': 'result_ma',
        'collect_params': [
            '-collect', 'memory-access',
            '-r',
        ],
        'show_collector': True,
        'analysis': MA_CHECK_ANALYSIS,
        'disabled': ['DASHBOARD_HW_EVENT_BASED_SAMPLING_DISABLED'],
    },
    {
        'name': AH_WITH_STACKS_CHECK_NAME,
        'result_dir': 'result_ah_with_stacks',
        'collect_params': [
            '-collect', 'hotspots',
            '-knob sampling-mode=hw',
            '-knob enable-stack-collection=true',
            '-r',
        ],
        'show_collector': True,
        'analysis': AH_WITH_STACKS_CHECK_ANALYSIS,
        'disabled': ['DASHBOARD_HW_EVENT_BASED_SAMPLING_DISABLED'],
    },
    {
        'name': TH_CHECK_NAME,
        'result_dir': 'result_th',
        'collect_params': [
            '-collect', 'threading',
            '-knob sampling-and-waits=hw',
            '-knob enable-stack-collection=false',
            '-r',
        ],
        'show_collector': True,
        'analysis': TH_CHECK_ANALYSIS,
        'disabled': ['DASHBOARD_HW_EVENT_BASED_SAMPLING_DISABLED'],
    },
]


class TestCase(object):
    def __init__(self, state):
        self.state = state
        self.log = state.log
        self.status = 'OK'

    def run(self):
        raise NotImplementedError('run() method is not implemented in test case!')

    def subprocess_wrapper(self, cl_args, indent='', grep=False, grep_args=''):
        self.log.to_log("Command line:\n%s" % ' '.join(cl_args))
        if grep:
            # Using of shell=True is dangerous
            # See: https://docs.python.org/3/library/subprocess.html#replacing-shell-pipeline
            serv_process = subprocess.Popen(cl_args, stdout=subprocess.PIPE)
            process = subprocess.Popen(["grep", grep_args], stdin=serv_process.stdout, stdout=subprocess.PIPE, encoding="utf-8")
            serv_process.stdout.close()
            stdout, stderr = process.communicate()
        else:
            process = subprocess.Popen(cl_args, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding="utf-8")
            stdout, stderr = process.communicate()
        if stdout:
            stdout = stdout.splitlines()
            self.log.to_log("Stdout:")
            for line in stdout:
                self.log.to_log(indent + line.strip())
        if stderr:
            stderr = stderr.splitlines()
            self.log.to_log("Stderr:")
            for line in stderr:
                self.log.to_log(indent + line.strip())

        return process.returncode, stdout, stderr

    def set_has_warnings(self):
        if not self.state.has_warnings:
            self.state.has_warnings = True


class VTuneBaseTest(TestCase):
    def run(self, test_descriptor):
        self.status = 'OK'

        self.log.to_log("=" * 80)
        test_title = test_descriptor['name']
        analysis_type = test_descriptor['analysis']
        test_disabled = False
        for env_var in test_descriptor['disabled']:
            env_value = os.environ.get(env_var)
            if env_value:
                test_disabled = True
                self.log.to_stdout("Test '{}' with '{}' analysis type is disabled".format(test_title, analysis_type))
                break
        if not test_disabled:
            self.log.to_stdout('Running collection...', temp=True)
            title, status, important_messages, collector = self.run_collection(test_descriptor)
            if collector:
                test_title += (' (%s)' % collector)
            self.log.to_stdout(test_title)

            example_analysis = test_descriptor.get('analysis', None)
            if example_analysis:
                self.log.to_stdout('Example of analysis types: ' + example_analysis)

            self.log.to_stdout(title + ': ' + status)

            for message in important_messages:
                self.log.to_stdout(message)

            if self.status == 'OK':
                self.log.to_log("-" * 80)
                self.log.to_stdout('Running finalization...', temp=True)
                title, status, important_messages = self.run_finalization(test_descriptor)
                self.log.to_stdout(title + ': ' + status)
                for message in important_messages:
                    self.log.to_stdout(message)

            if self.status == 'OK':
                self.log.to_log("-" * 80)
                title, status, important_messages = self.run_report(test_descriptor)
                self.log.to_stdout(title + ': ' + status)
                for message in important_messages:
                    self.log.to_stdout(message)

            if self.status == 'OK':
                self.remove_result_dir(test_descriptor)
        self.log.to_stdout('')

    def run_collection(self, test_descriptor):
        title = self.state.output_indent + COLLECTION

        args = [self.state.cl_path]
        args += test_descriptor['collect_params']
        result_dir_name = test_descriptor['result_dir']
        result_dir_abs_path = self.state.append_to_work_dir(result_dir_name)
        args += [result_dir_abs_path]
        args += ['-data-limit', '0']
        args += ['-finalization-mode', 'none', '--', self.state.app_path]
        args += ['-source-search-dir', self.state.source_dir]

        ret_code, stdout, stderr = self.subprocess_wrapper(args, indent=self.state.stdout_indent)
        # In case of mpi run vtune automatically adds hostname to result dir,
        # so we get combined result dir name from collection output
        for line in stderr:
            result_path_match = re.search(r"Using result path `(.+)'", line)
            if result_path_match:
                result_dir_abs_path = result_path_match.group(1)
                test_descriptor['real_result_dir'] = result_dir_abs_path
                break

        collector = ''
        if test_descriptor.get('show_collector', False):
            try:
                collector = self.get_collector(result_dir_abs_path)
            except FileNotExistError as e:
                self.log.to_log("Cannot find 'runsa.options' by path: %s" % e.path)

        important_messages = self.get_errors_from_stderr(stderr)

        if ret_code != 0:
            self.status = 'FAIL'
            status = 'Fail'
        else:
            status = 'Ok'

        return title, status, important_messages, collector

    def run_finalization(self, test_descriptor):
        title = self.state.output_indent + FINALIZATION

        args = [self.state.cl_path, '-finalize']
        result_dir_abs_path = self.state.get_result_dir_abs_path(test_descriptor)
        args += ['-r', result_dir_abs_path]

        ret_code, stdout, stderr = self.subprocess_wrapper(args, indent=self.state.stdout_indent)

        important_messages = self.get_errors_from_stderr(stderr)

        if ret_code != 0:
            self.status = 'FAIL'
            status = 'Fail'
        else:
            status = 'Ok'

        return title, status, important_messages

    def run_report(self, test_descriptor):
        title = self.state.output_indent + REPORT

        args = [
            self.state.cl_path,
            '-limit', '5',
            '-format', 'csv',
            '-csv-delimiter', 'comma'
        ]
        result_dir_abs_path = self.state.get_result_dir_abs_path(test_descriptor)
        args += ['-report', 'hotspots']
        args += ['-group-by', 'function']
        args += ['-r', result_dir_abs_path]

        ret_code, report, stderr = self.subprocess_wrapper(args, indent=self.state.stdout_indent)

        important_messages = self.get_errors_from_stderr(stderr)

        if ret_code != 0:
            self.status = 'FAIL'
            status = 'Fail'
            return title, status, important_messages

        multiply1_hotspot = 0
        for line in report:
            if line.strip().startswith("multiply1,"):
                multiply1_hotspot += 1
        if multiply1_hotspot == 1:
            status = 'Ok'
        else:
            self.status = 'FAIL'
            status = 'Fail'

        return title, status, important_messages

    def get_errors_from_stderr(self, stderr, show_warnings=True):
        important_messages = []
        for line in stderr:
            if line.startswith(ERROR_TAG):
                important_messages.append(line)
            elif (show_warnings and line.startswith(WARNING_TAG)):
                # Not show unuseful warning for user
                if not CANNOT_LOCATE_FILE_WARNING in line and not CANNOT_LOCATE_DEBUGGING_INFORMATION_WARNING in line:
                    if line.strip() not in self.state.ignored_warnings:
                        self.set_has_warnings()
                    important_messages.append(line)
        return important_messages

    def get_collector(self, result_dir):
        runsa_path = os.path.normpath(os.path.join(result_dir, 'config', 'runsa.options'))
        check_file_exist(runsa_path)
        runsa_options = dict()
        runsa_file = open(runsa_path, 'r')
        try:
            data = runsa_file.readlines()
        finally:
            runsa_file.close()
        for line in data:
            if line.startswith('--') and '=' in line:
                name = line.split('=')[0].lstrip('--')
                value = '='.join(line.split('=')[1:]).strip()
                runsa_options[name] = value
        if not runsa_options:
            self.log.to_log("Cannot determine collector from runsa.options.")
        else:
            collector = runsa_options.get('collector', None)
            if collector == 'perf':
                return PERF
            else:
                return INTEL_DRIVER

    def remove_result_dir(self, test_descriptor):
        result_dir_abs_path = self.state.get_result_dir_abs_path(test_descriptor)
        self.state.remove_dir(result_dir_abs_path)


class ContextValuesTest(TestCase):
    def __init__(self, state):
        TestCase.__init__(self, state)
        self.context_values = dict()
        self.sep_permission_warn = ''

    def run(self):
        self.log.to_log("=" * 80)
        self.log.to_log("Context values:")
        title, status = self.get_context_values()
        self.log.to_log(title + ': ' + status)

        self.log.to_log("=" * 80)
        self.log.to_log("Check driver:")
        title, status = self.check_driver()

    def get_context_values(self):
        title = 'Getting context values'
        args = [self.state.runss_path, "--context-value-list"]
        ret_code, stdout, stderr = self.subprocess_wrapper(args, indent=self.state.stdout_indent)
        if ret_code != 0:
            self.status = 'FAIL'
            status = 'Fail'
        else:
            status = 'OK'
            self.parse_context_values(stdout)
        return title, status

    def parse_context_values(self, stdout):
        for line in stdout:
            key = line.split(':')[0].strip()
            value = ':'.join(line.split(':')[1:]).strip()
            self.context_values[key] = value

    def check_driver(self):
        title = 'Check driver'
        is_sep_available = self.context_values.get('isSEPDriverAvailable', False)
        self.log.to_log('isSEPDriverAvailable: ' + str(is_sep_available))
        is_pax_available = self.context_values.get('isPAXDriverLoaded', False)
        self.log.to_log('isPAXDriverLoaded: ' + str(is_pax_available))
        is_sep_in_lsmod = False
        if sys.platform != 'win32':
            is_sep_in_lsmod = self.check_is_sep_in_lsmod()
            self.log.to_log('Is SEP in lsmod: ' + str(is_sep_in_lsmod))
        status = ''
        if is_sep_available == 'true':
            self.log.to_log('Ok')
        elif is_pax_available == 'true':
            self.log.to_log(OLD_DRIVER)
        elif sys.platform != 'win32' and is_sep_in_lsmod:
            self.log.to_log(NOT_PERMISSION_FOR_DRIVER)
            self.sep_permission_warn = NOT_PERMISSION_FOR_DRIVER
            self.set_has_warnings()
        else:
            self.log.to_log(NO_SEP_AVAILABLE)

        return title, status

    def check_is_sep_in_lsmod(self):
        ret_code, stdout, stderr = self.subprocess_wrapper(['lsmod'], indent=self.state.stdout_indent, grep=True, grep_args='sep')
        for line in stdout:
            if line.startswith('sep'):
                return True
        return False


class CheckDriverTest(TestCase):
    def run(self):
        self.log.to_log("=" * 80)
        self.log.to_log("SEP version:")
        title, status = self.log_sep_version()
        self.log.to_log(title + ': ' + status)

    def log_sep_version(self):
        title = 'Check driver with sep -version'
        sep_name = 'sep'
        if sys.platform == 'win32':
            sep_name += '.exe'
        sep_path = os.path.join(self.state.bin_dir, sep_name)
        check_file_exist(sep_path)
        ret_code, stdout, stderr = self.subprocess_wrapper([sep_path, '-version'], indent=self.state.stdout_indent)
        if ret_code != 0:
            self.status = 'FAIL'
            status = 'Fail'
        else:
            status = 'Ok'
            for line in stderr:
                if 'Error retrieving SEP driver version' in line:
                    self.status = 'FAIL'
                    status = 'Fail'
                    break
        return title, status


def main():
    parser = OptionParser(usage="Usage: %prog [options] arg")
    parser.add_option("--log-dir", dest="log_dir",
                      help=HELP_LOG_DIR)
    (options, args) = parser.parse_args()

    status = 0

    work_dir = ''

    if options.log_dir:
        if not os.path.exists(options.log_dir):
            sys.stdout.write("%s\n" % FOLDER_NOT_AVAILABLE)
            return 1
        work_dir = options.log_dir

    bin_dir = os.path.dirname(os.path.realpath(__file__))

    # Below state has log
    state = State(bin_dir, work_dir)

    if state.status == 'OK':
        state.log.to_log("Check of files: Ok")
    else:
        state.log.to_log("Check of files: Fail")
        return 1

    try:
        # Write context values to log
        context_values_test = ContextValuesTest(state)
        context_values_test.run()
        if context_values_test.status == 'FAIL':
            status = 1

        # Check is driver exist
        check_driver_test = CheckDriverTest(state)
        check_driver_test.run()

        # Run 3 checks for TPSS, PMU, PMU-with-stacks collections
        test_hpc = VTuneBaseTest(state)
        for descriptor in vtune_base_test_descriptor:
            test_hpc.run(descriptor)
            if test_hpc.status == 'FAIL':
                status = 1

        # WORKAROUND: need to print warning about problem with
        #             permission on sep in the end
        sep_permission_warn = context_values_test.sep_permission_warn
        if sep_permission_warn:
            state.log.to_stdout(sep_permission_warn)
            state.log.to_stdout('')

    except Exception as e:
        state.log.to_log("Exception: %s" % e)
        state.log.to_stdout('\n' + UNKNOWN_FAIL)
        return 1

    if status == 0:
        state.log.to_stdout(SYSTEM_READY)
        if state.has_warnings:
            state.log.to_stdout(SEE_WARNINGS)
    else:
        state.log.to_stdout(SISTEM_NOT_READY)

    return status


if __name__ == "__main__":
    ret_code = main()
    sys.exit(ret_code)
