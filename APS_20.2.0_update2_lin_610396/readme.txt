---------------------------------------
Intel(R) VTune(TM) Profiler - Application Performance Snapshot README
---------------------------------------
Use Intel(R) VTune(TM) Profiler - Application Performance Snapshot (APS) to get a quick view into
the use of available hardware (CPU, GPU, and Memory) by a shared memory or MPI application.
Application Performance Snapshot analyzes the time spent by your application on:
•	MPI
•	MPI and OpenMP imbalance
•	Memory access efficiency
•	Vectorization
•	I/O
•	Memory footprint
After the analysis completes, APS displays opportunities for performance optimization 
for systems that use Intel(R) platforms.

Use APS as a first step in application performance analysis to get a
simple snapshot of key optimization areas.

-------------
Options
-------------
1.	When running  Application Performance Snapshot , use these software tools 

to get an advanced metric set:

•	Intel(R) C/C++ or Fortran Compiler (for OpenMP* metrics support)
•	MPICH or OpenMPI-based MPI implementation (for MPI analysis)
•	Intel(R) MPI Library 2017 or newer (for MPI imbalance metric calculation)

2.	 Enable system-wide monitoring to reduce collection overhead and
collect memory bandwidth measurements. Use one of these options to enable
system-wide monitoring:
•	Set the /proc/sys/kernel/perf_event_paranoid value to 0 (or less)
•	Install Intel(R) VTune Profiler drivers. Driver sources are available in <APS_install_dir>/internal/sepdk/src. See installation instructions online at https://software.intel.com/en-us/vtune-amplifier-help-sep-driver

------------------------------
Analyze Non-MPI Applications
------------------------------
1. Set environment variables:
   $ source <install-dir>/apsvars.sh
2. Collect performance data:
   $ aps <my_app> <app_parameters>
3. Review the report that appears in the command window or 
open the aps_result.html report.

--------------------------
Analyze MPI Applications
--------------------------
1. Set environment variables:
   $ source <install-dir>/apsvars.sh
2. Collect performance data:
   $ <mpi_launcher> <mpi_parameters> aps <my_app> <app_parameters>
   NOTE: aps must be the last MPI launcher argument.
3. Generate a report based on the data collected:
   $ aps --report=aps_result_<date>
4. Review the report that appears in the command window or 
open the aps_result.html report.
5. If your application is MPI-bound, run this command to
   get more information about MPI usage with detailed reports:
   $ aps-report <option> app_result_<date>

-----------------
Metrics Reference
-----------------
•	Elapsed Time: 
Execution time of specified application in seconds.

•	SP GFLOPS: 
Number of single precision giga-floating point operations calculated per second. 

•	DP GFLOPS: 
Number of double precision giga-floating point operations calculated per second 
(SP and DP GFLOPS metrics are only available for 3rd Generation Intel(R) Core. processors, 5th Generation Intel processors and newer versions)

•	Cycles per Instruction Retired (CPI): 
The amount of time (in cycles) taken by each executed instruction. A CPI of 1 (one) is considered acceptable for high performance computing (HPC) applications, but this value can be different for different application domains. The CPI value tends to be greater when there is/are:
o	Long latency memory, floating-point, or SIMD operations
o	Non-retired instructions due to branch mispredictions
o	Instruction starvation at the front end.

•	MPI Time: 
Average time per process spent in MPI calls. This metric does not include the time spent in MPI_Finalize. High values could be caused by:
o	High wait times inside the library
o	Active communications
o	Sub-optimal settings of the MPI library. 
The metric is available for MPICH-based and OpenMPI MPIs.

•	MPI Imbalance: 
CPU time spent by ranks spinning in waits on communication operations. A high value can be caused by: 
o	Application workload imbalance between ranks
o	Non-optimal communication schema or MPI library settings.
This metric is available only for Intel(R) MPI Library version 2017 and newer versions.

•	OpenMP Imbalance: 
Percentage of elapsed time that your application wastes at OpenMP* synchronization barriers due to load imbalance. This metric is only available for Intel(R) OpenMP* Runtime Library.

•	CPU Utilization: 
An estimate of the utilization of all logical CPU cores on the system by your application. Use this metric to help evaluate the parallel efficiency of your application. A utilization of 1n 00% means that your application keeps all of the logical CPU cores busy for the entire time that it runs. Note that the metric does not distinguish between useful application work and the time spent in parallel runtimes. Therefore, the metric is shown only if MPI or OpenMP runtime metrics are unavailable.

•	Memory Stalls: 
This metric describes how memory subsystem issues affect application performance. The metric measures a fraction of slots where pipeline could be stalled due to demand load or store instructions. If the metric value is high, review the Cache and DRAM Stalls and the percentage of remote accesses metrics to understand the nature of memory-related performance bottlenecks.
The DRAM Bandwidth Bound metric allows the detection of applications that reach memory bandwidth limit that can significantly increase latency of memory access operations. 

•	Vectorization:
This metric represents the percentage of packed (vectorized) floating point operations. 
o	0% means that the code is fully scalar.
o	100% means the code is fully vectorized. 
The metric does not take into account the actual vector length used by the code for vector instructions. As a result, if the code is fully vectorized and uses a legacy instruction set that loaded only half a vector length, the Vectorization metric still shows 100%. 
The second level vectorization metrics allow for rough estimates of the size of floating point work with particular precision. Use them to see the actual vector length of vector instructions with particular precision. Partial vector length can provide information about legacy instruction set usage and show an opportunity to recompile the code with a modern instruction set. This can lead to additional performance improvement.

•	I/O Operations: 
The time spent by the application while reading data from the disk or writing data to the disk. Read and Write values denote mean and maximum amounts of data read and written during the elapsed time. This metric is only available for MPI applications.

•	Memory Footprint: 
Average per-rank and per-node consumption of both virtual and resident memory.

•	Intel Omni-Path Fabric Interconnect Bandwidth and Packet Rate: 
Average Pick and Bound (time in high bandwidth consumption) interconnect bandwidth and packet rate per compute node, broken down by outgoing and incoming values. High values of Bound metric can lead to higher latency network communications. The interconnect metrics are available for compute nodes with Intel Omni-Path Fabric when you install the VTune Profiler driver.

--------------------
Additional Resources
--------------------
•	Intel(R) Performance Snapshot User Forum:
https://software.intel.com/en-us/forums/intel-performance-snapshot

•	Application Performance Snapshot Web Page:
https://software.intel.com/sites/products/snapshots/application-snapshot/

•	Application Performance Snapshot User Guide:
https://software.intel.com/en-us/application-snapshot-user-guide

-------------------------------------------------------------------------------
Intel and the Intel logo are trademarks of Intel Corporation in the U.S. and/or
other countries.
* Other names and brands may be claimed as the property of others.

Copyright 2016-2019 Intel Corporation

This software and the related documents are Intel copyrighted materials, and your use of them is governed by the express license under which they were provided to you (License). Unless the License provides otherwise, you may not use, modify, copy, publish, distribute, disclose or transmit this software or the related documents without Intel's prior written permission.

This software and the related documents are provided as is, with no express or implied warranties, other than those that are expressly stated in the License.
