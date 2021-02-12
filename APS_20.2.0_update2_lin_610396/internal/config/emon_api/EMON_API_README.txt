EMON API version 1.0
Copyright (C) 2018 Intel Corporation
All Rights Reserved.


1. About EMON API
=============================================
EMON API is a user level C library that provides functions to access hardware performance counters directly in user applications.
The API allows users to specify performance events, start and stop data collection and retrieve event counts inside the application.
EMON API also has functions to pause and resume an ongoing EMON collection.  EMON API needs work together with EMON data collection implicitly or explicitly.

EMON API functions include:
    1)  Start and stop EMON collection.
    2)  Pause and resume on existing EMON collection.
    3)  Read EMON count and metric data any time between the start and stop.
    4)  Use marker functions to get counting and metric collection in code region easily.
        Marker functions can mark the data collection for a certain code region, and it can accumulate data collected for the code region marked with same marker name.

Note: The package version is only available in Linux.


2. SEP/EMON Installation Instructions
=============================================
    Please refer to SEP_Install_Instructions.txt which is under <emon_install_path>/docs


3. Steps to Compile Application with EMON API
====================================
    Linux:
        1)  Set up the EMON run-time environment by sourcing the file sep_vars.sh with emon_api sub-option in the current bash shell.
            This will add the paths of EMON API header file and the libraries into CPATH, LIBRARY_PATH, and LD_LIBRARY_PATH (with emon_api option).
                source <emon_install_path>/sep_vars.sh emon_api
        2)  Include the header "emon_api.h" to your source code to integrate the APIs into the source code. Look into the examples provided in section 7.
        3)  Compile your code with libprog_api.so, for example:
                gcc -o foo foo.c -lprog_api
            If you run source sep_var.sh without emon_api option, you can add the library path in rpath:
                gcc -o foo foo.c -lprog_api -Wl,-rpath=$SEP_LIB_INSTALL_PATH
        4)  Copy the default configuration file to your workspace, and modify your configuration file if needed.
            The default configuration template is available at:
                <emon_install_path>/config/emon_api/emon_api_config_file.xml.
            The EMONConfig initialization step will fail if the configuration template has syntax errors.

    Windows(Visual Studio):
        1) From the shell window, run the file sep_vars.cmd
        2) Go to Configuration Manager, change Active solution platform to x64
        3) Go to Configuration Properties -> C/C++ -> Additional Include Directories and add <emon_install_path>/config/emon_api/
        4) Go to Configuration Properties -> Linker -> Input -> Additional Dependencies and add <emon_install_path>/<lib32|64>/prog_api.lib
        5) Copy <emon_install_path>/<lib32|64>/prog_api.dll to the project folder
        6) Compile your code by Visual Studio.

4. API function description
====================================
    1)  Control Functions:
        EMONConfig                 - Initialize EMON API with the input config_file.
                                     After EMONStart use EMONPause and EMONResume to control the event collection.
        EMONStart                  - Start EMON data collection.
        EMONStop                   - Stop EMON data collection.
        EMONPause                  - Pause a running EMON data collection.
        EMONResume                 - Resume a paused collection.

    2)  Data Read Functions:
        EMONReadCounts             - Get the current event counts from an active EMON collection.
                                     A collection is active when EMON is still running, even while in the paused state.
        EMONReadMetric             - Get the current metric data of an active EMON data collection.
        EMONReadCountsOnCurrentCPU - Get the event counts on current CPU with low overhead.
                                     The function can only be used while <read_counts_on_current_cpu> sub-tag is set to 1, and all collected events can be scheduled in single group.
                                     While use the function, it is user's responsibility to make sure EMONReadCountsOnCurrentCPU is running on the same CPU as user's program.

    3)  Marker Functions:
        EMONMarkerCreate           - Declare a new marker with the given marker_name.
                                     This name uniquely identifies the marked region of interest.
        EMONMarkerEnter            - Collect and accumulate EMON data for the selected code region associated with the given marker_name.
                                     No support for nested calls of EMONMarkerEnter. Each call to this function should be followed by a call to EMONMarkerLeave.
        EMONMarkerLeave            - Stop accumulating EMON data associated with the given marker_name.
                                     EMONMarkerLeave should be preceded with EMONMarkerEnter function corresponding to the same marker_name.
        EMONReadMarkerCounts       - Retrieve event counts associated with the given marker_name.
        EMONReadMarkerMetric       - Retrieve metric data associated with the given marker_name.

    3)  Data Post Processing Functions:
        EMONDataGetEventList       - List the events that were collected.
        EMONDataGetMetricList      - List the metrics that were collected.
        EMONDataCalculate          - Perform addition, subtraction and summation operations on EMON data.
        EMONDataPrintAll           - Print all entries in the input EMON data.
        EMONDataGetTimestamp       - Retrieve timestamp value from the given emon_data.
        EMONDataGetSingleEntry     - Retrieve counts corresponding to a single event or retrieve data corresponding to a single metric.
        EMONDataFree               - Destroy the EMON data which is generated from EMONReadCounts, EMONReadMetric, EMONReadMarkerCounts, EMONReadMarkerMetric and EMONDataCalculate.


5. Configuration file description
====================================
    Configuration file is used to define the interested hardware events, monitoring duration, and the desired performance metrics.
    The configuration file is platform specific. It is in XML file containing two sections.
    The first section specified under the XML tag <emon_config> can be used to configure EMON input options.
    The second section specified under the XML tag <metric> can be used to configure data metrics.
    The default configuration template is available at:
        <emon_install_path>/config/emon_api/emon_api_config_file.xml

    1)  XML Tag <emon_config>: Use this XML section to configure inputs to the EMON process.
                               The <emon_config> XML tag contains seven sub-tags that are described below.
        <emon_event>                 - List of events for EMON to perform data collection.
                                       By default EMON collects fixed counter Core events if the event list specified here contains only Uncore events.
        <duration>                   - Time (in seconds) that an event set (group) is monitored for. Default value is 0.1s.
        <start_paused>               - EMON collection will be paused immediately after start if this tag is set to 1.
        <output_file>                - This tag should be used to specify output file name for EMON API collection. The data is output to STDOUT if the value of this tag is specified as STDOUT.
        <print_system_time>          - EMONDataPrintAll function will print system time if this tag is set to 1.
        <additional_options>         - Any option that the user likes to add to EMON commandline can be specified with this tag.
        <read_counts_on_current_cpu> - While the tag is set to 1 and all collected events can be scheduled in a single group, user can use EMONReadCountsOnCurrentCPU to read counts on current CPU with low overhead.

    2)  XML Tag <metric>: Use this XML section to provide metric definitions. Each event requires a unique name that can be referenced in EMONReadMetric function.
                          The <metric> tag contains four sub-tags that are described below.
        <event>                      - Specify which events will be used in the FORMULA.
        <time>                       - Please refer to section 6.
        <constant>                   - Please refer to section 6.
        <formula>                    - If user specifies <event alias="a">CPU_CLK_UNHALTED.THREAD</event>, then in <formula>, a = INST_RETIRED.ANY.


6. Example for user-defined metric
====================================
    User can add their own metric in configuration file, for example, user can add this configuration in <metric> section in configuration file:

        <metric name="INSTRUCTIONS_PER_CORE_CYCLE_USER">
            <event alias="a">INST_RETIRED.ANY</event>
            <event alias="b">CPU_CLK_UNHALTED.THREAD</event>
            <formula>a/b</formula>
        </metric>

    Then in the source code, use the following two function to get INSTRUCTIONS_PER_CORE_CYCLE_USER metric result:
        EMONReadMetric(&emon_metric_data);
        EMONReadMarkerMetric("marker", &emon_metric_data);

    For <time>, there are two preserved time event: TIME_SLICE_IN_SECONDS and TIME_STAMP_IN_CYCLES. Alias must be hardcoded to "t". For example:
        <time alias="t">TIME_STAMP_IN_CYCLES</time>

    For <constant>, there are two kinds of constants: pre-defined and user-defined.
        pre-defined constant  - Name must be specified as the pre-defined constant name. For example:
                                <constant alias="c">system.tsc_freq</constant>
        user-defined constant - Name is the value of this constant. For example:
                                <constant alias="socket_count">2</constant>

    List of available pre-defined constant:
        TSC_FREQ
        NUM_SOCKETS
        NUM_LOGIC_PROCESSORS_PER_SOCKET
        NUM_LOGIC_PROCESSORS_PER_CORE
        NUM_ACTIVE_PROCESSORS_PER_CORE


7. Example for EMON API Usage
====================================
    This section illustrate EMON API usage with multiple examples.

    7.1) Setting up Basic EMON API
    ------------------------------------
        1) Initialize EMON API using EMONConfig.
        2) Use EMONSTART to start running EMON.
        3) Use EMONReadCounts to get current EMON counting data.
        4) Use EMONReadMetric to get current EMON metric data.
        5) Use EMONStop to stop and terminate EMON process.

        #include "emon_api.h"

        void main () {

            EMON_DATA emon_counting_data, emon_metric_data;

            EMONConfig ("emon_api_config_file.xml");

            EMONStart ();

            // Run your code here ...

            EMONReadCounts (&emon_counting_data);

            EMONReadMetric (&emon_metric_data);

            // Print All entried in emon_data

            EMONDataPrintAll (emon_counting_data);

            EMONDataPrintAll (emon_metric_data);

            // Finalize

            EMONDataFree(&emon_counting_data);

            EMONDataFree(&emon_metric_data);

            EMONStop();

        }

        With default emon_api_config_file.xml, the output will be:

        10/20/2017 14:05:11.783
        CPU_CLK_UNHALTED.REF_TSC   2,717,399,141   15,486,848   9,161,632   889,376   9,770,352
        CPU_CLK_UNHALTED.THREAD    2,717,399,141   11,194,426   6,079,950   580,290   6,532,721
        INST_RETIRED.ANY           2,717,399,141   15,288,229   2,731,290   179,219   4,381,973
        10/20/2017 14:05:11.785
        CPI               2,717,399,141   0.732225   2.226036   3.237882   1.490817
        CPU_UTILIZATION   2,717,399,141   0.569914   0.337147   0.032729   0.359548

    7.2) Setting up EMON API Marker Mode in C
    ------------------------------------
        1) Initialize EMON API using EMONConfig.
        2) Use EMONSTART to start running EMON.
        3) Use EMONMarkerCreate with marker's name.
        4) Use EMONMarkerEnter to get instance while entering.
        5) Use EMONMarkerLeave to get instance while leaving.
        6) Use EMONReadMarkerCounts to get EMON counting data in marker
        7) Use EMONReadMarkerMetric to get EMON metric data in marker
        8) Use EMONStop to stop and terminate EMON process.

        #include "emon_api.h"

        void main() {

            EMON_DATA emon_counting_data, emon_metric_data;

            EMONConfig("emon_api_config_file.xml");

            EMONStart();

            EMONMarkerCreate("marker");

            for (int i = 0; i < TEST_NUM; i++) {

                EMONMarkerEnter("marker");

                // Run your code here ...

                EMONMarkerLeave("marker");

            }

            EMONReadMarkerCounts("marker", &emon_counting_data);

            EMONReadMarkerMetric("marker", &emon_metric_data);

            EMONDataPrintAll(emon_counting_data);

            EMONDataPrintAll(emon_metric_data);

            EMONDataFree(&emon_counting_data);

            EMONDataFree(&emon_metric_data);

            EMONStop();

        }

        With default emon_api_config_file.xml, the output will be:

        10/20/2017 14:24:25.221
        CPU_CLK_UNHALTED.REF_TSC   15,978,345,101   5,532,224   110,146,304   2,691,536   5,222,816
        CPU_CLK_UNHALTED.THREAD    15,978,345,101   3,825,949   81,441,992    2,031,221   3,640,297
        INST_RETIRED.ANY           15,978,345,101   1,981,251   113,650,303   890,435     1,749,502
        10/20/2017 14:24:25.222
        CPI               15,978,345,101   1.931077   0.716602   2.281156   2.080762
        CPU_UTILIZATION   15,978,345,101   0.034623   0.689347   0.016845   0.032687

    7.3) Setting up EMON API for Post Processing Data in C
    ------------------------------------

        #include "emon_api.h"

        #include <stdio.h>

        void main () {

            EMON_DATA emon_data_before, emon_data_after, emon_data_result;

            char **event_list;

            char *event_name;

            unsigned int num_events, num_event_counts, i, j ;

            unsigned long long tsc;

            double *emon_event_counts;

            EMONConfig("emon_api_config_file.xml");

            EMONStart();

            // Get collecting event list

            EMONDataGetEventList(&event_list, &num_events);

            // Other code segment..

            EMONReadCounts(&emon_data_before);

            // Code segment which is for EMON collection

            EMONReadCounts(&emon_data_after);

            // Get the diff between before and after EMON data.

            EMONDataCalculate(emon_data_after,
                              emon_data_before,
                              1,
                              1,
                              EMON_API_OPERATION_SUBTRACTION,
                              &emon_data_result);

            // Get Elapsed time in emon_data_result

            EMONDataGetTimestamp(emon_data_result, &tsc);

            printf("Elapsed time: %llu\n", tsc);

            // For each event, print all cpu’s counts

            for (i = 0; i < num_events; i++) {

                event_name = event_list[i];

                EMONDataGetSingleEntry(emon_data_result,
                                       event_name,
                                       &emon_event_counts,
                                       &num_event_counts);

                printf("%s\t", event_name);

                for (j = 0; j < num_event_counts; j++) {

                    printf("%llu\t", (unsigned long long)emon_event_counts[j]);

                }

                printf("\n");

            }


            EMONDataFree(&emon_data_before);

            EMONDataFree(&emon_data_after);

            EMONDataFree(&emon_data_result);

            EMONStop();

        }

        With default emon_api_config_file.xml, the output will be:

        CPU_CLK_UNHALTED.REF_TSC   3076736   59171120   3288544   3394720
        CPU_CLK_UNHALTED.THREAD    2380403   40196372   2591800   2248627
        INST_RETIRED.ANY           857774    53232784   1322691   951480

