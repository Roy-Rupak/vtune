<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    exclude-result-prefixes="msxsl"
    xmlns:exsl="http://exslt.org/common"
    xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
    exsl:keep_exsl_namespace=""
    syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="querySuffix"/>
  <xsl:param name="contextMode">false</xsl:param>
  <xsl:param name="packetsType" select="exsl:is_non_empty_table_exist('dma_packet_data') and exsl:ctx('targetOS')!='MacOSX'"/>
  <xsl:param name="showPMUEvents">false</xsl:param>
  <xsl:param name="showPhysicalCores">false</xsl:param>
  <xsl:param name="showHottestTasks">true</xsl:param>
  <xsl:param name="cpuGpuInteration">false</xsl:param>
  <xsl:param name="inKernelProfiling">false</xsl:param>
  <xsl:variable name="pmuCommon" select="document('config://include/pmu_common.xsl')"/>
  <xsl:variable name="isTmamSmtAware" select="$pmuCommon//variables/isTmamSmtAware"/>
  <xsl:variable name="preciseClockticsCollected" select="exsl:ctx('collectPreciseClockticks')"/>
  <xsl:variable name="gpuOpenCLDataCollected" select="exsl:is_non_empty_table_exist('gpu_compute_task_data')"/>
  <xsl:variable name="gpuDataCollected" select="exsl:is_non_empty_table_exist('gpu_data') or exsl:is_non_empty_table_exist('gpu_freq_data') or exsl:is_non_empty_table_exist('dma_packet_data') or $gpuOpenCLDataCollected"/>
  <xsl:variable name="uncacheableReadsEventNameOnly" select="$pmuCommon//variables/uncacheableReadsEventNameOnly"/>
  <xsl:variable name="uncacheableReadsCollected" select="string($uncacheableReadsEventNameOnly) != '' and exsl:is_value_exist('dd_sample_event_name', 'value', string($uncacheableReadsEventNameOnly))"/>
  <xsl:param name="cliMode">false</xsl:param>
  <xsl:param name="eventsSummaryHrefActivate">bottomUpPane</xsl:param>
  <xsl:param name="samplesSummaryHrefActivate">sampleCountBottomUpPane</xsl:param>
  <xsl:param name="uncoreEventsSummaryHrefActivate">uncoreBottomUpPane</xsl:param>
  <xsl:param name="cpuHotspotsHrefActivateTabId">bottomUpPane</xsl:param>
  <xsl:param name="resultSummaryHrefActivateTabId">bottomUpPane</xsl:param>
  <xsl:param name="averageBandwidthHrefActivateTabId">bottomUpPane</xsl:param>
  <xsl:template match="/">
  <xsl:variable name="isRunssMode" select="exsl:ctx('runss:enable', 0) or (exsl:ctx('runsa:enable', 'na') = 'na' and exsl:ctx('runss:enable', 'na') = 'na' and exsl:IsTableExist('cpu_data'))"/>
  <xsl:variable name="mpiRankQuerySuffix">
    <xsl:choose>
      <xsl:when test="exsl:ctx('mpiRankCount', 0) > 1">
        <xsl:text>MpiCriticalRank</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text></xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
    <root>
      <memoryConsumptionChart>
        <section type="histogram" expanded="true">
          <header displayName="%MemoryConsumptionHistogram"/>
          <description displayName="%MemoryConsumptionHistogramDescription"/>
            <histogram allRows="true">
              <columns>
                <column>/AllocInstanceCount</column>
              </columns>
              <grouping>/AllocCountInfo</grouping>
            </histogram>
        </section>
      </memoryConsumptionChart>
      <memoryConsumptionTopFiveObjects>
        <section type="grid" expanded="true">
          <header displayName="%MemoryConsumptionTopFiveObjects"/>
          <description displayName="%MemoryConsumptionTopFiveObjectsDescription" />
          <grid limit="5">
            <columns>
              <column>/MemoryAllocContribution</column>
              <column>/AllocCountDelta</column>
              <column>/AllocInstanceCount</column>
              <column>/MemoryAllocFunctionModule</column>
            </columns>
            <sorting>/MemoryAllocContribution</sorting>
            <grouping>/Function</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/Function/MemoryAllocCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </memoryConsumptionTopFiveObjects>
      <openMPTimeSections>
        <section type="undefined" expanded="onIssues" allowExpansionRewriting="false">
          <xsl:if test="($contextMode='true')">
            <xsl:attribute name="expanded">false</xsl:attribute>
          </xsl:if>
          <header>
            <column>
              <xsl:text>/SerialTime</xsl:text>
              <xsl:value-of select="$mpiRankQuerySuffix"/>
              <xsl:text>AndPercentElapsedAsString</xsl:text>
            </column>
          </header>
          <sections>
            <section type="grid" expanded="true" allowExpansionRewriting="false">
              <header displayName="%TopSerialHotspots"/>
              <description displayName="%TopSerialHotspotsDescription" />
              <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
                <columns>
                  <column>
                    <xsl:text>/FunctionModule</xsl:text>
                  </column>
                  <column>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$querySuffix"/>
                    <xsl:value-of select="$mpiRankQuerySuffix"/>
                    <xsl:text>SerialCPUTime</xsl:text>
                  </column>
                </columns>
                <sorting>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$querySuffix"/>
                  <xsl:value-of select="$mpiRankQuerySuffix"/>
                  <xsl:text>SerialCPUTime</xsl:text>
                </sorting>
                <grouping>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$querySuffix"/>
                  <xsl:text>Function</xsl:text>
                </grouping>
                <href>
                  <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                    <grouping>/Function/ParentCallStack</grouping>
                    <row/>
                  </activate>
                </href>
              </grid>
               <messages>
                <noData displayName="%NoDataSerialHotspots"/>
              </messages>
            </section>
          </sections>
        </section>
        <section type="tree" expanded="onIssues">
          <header>
            <column>
              <xsl:text>/ParallelExecutionWallTime</xsl:text>
              <xsl:value-of select="$querySuffix"/>
              <xsl:value-of select="$mpiRankQuerySuffix"/>
              <xsl:text>AndPercentElapsedAsString</xsl:text>
            </column>
          </header>
          <tree valueAlign="right">
             <columns>
               <column>
                 <xsl:text>/IdealRegionTime</xsl:text>
                 <xsl:value-of select="$querySuffix"/>
                <xsl:value-of select="$mpiRankQuerySuffix"/>
                 <xsl:text>AndPercentElapsedAsString</xsl:text>
               </column>
               <column>
                <xsl:text>/RegionPotentialGain</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:value-of select="$mpiRankQuerySuffix"/>
                <xsl:text>AndPercentElapsedAsStringForSummary</xsl:text>
               </column>
             </columns>
           </tree>
           <sections>
             <xsl:if test="($contextMode='false')">
               <section type="grid" expanded="true" applicableUI="gui" allowExpansionRewriting="false">
                 <header displayName="%TopRegions"/>
                 <description displayName="%TopRegionsDescription" />
                 <grid limit="5">
                   <columns>
                     <column>
                       <xsl:text>/RegionPotentialGain</xsl:text>
                       <xsl:value-of select="$querySuffix"/>
                       <xsl:value-of select="$mpiRankQuerySuffix"/>
                       <xsl:text>Short</xsl:text>
                     </column>
                     <column>
                       <xsl:text>/RegionPotentialGain</xsl:text>
                       <xsl:value-of select="$querySuffix"/>
                       <xsl:value-of select="$mpiRankQuerySuffix"/>
                       <xsl:text>PercentElapsedShort</xsl:text>
                     </column>
                     <column>
                       <xsl:text>/RegionTime</xsl:text>
                       <xsl:value-of select="$mpiRankQuerySuffix"/>
                     </column>
                   </columns>
                   <sorting>
                     <xsl:text>/RegionPotentialGain</xsl:text>
                     <xsl:value-of select="$querySuffix"/>
                     <xsl:value-of select="$mpiRankQuerySuffix"/>
                     <xsl:text>Short</xsl:text>
                   </sorting>
                   <grouping>/RegionDomain</grouping>
                   <href>
                     <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                       <xsl:choose>
                         <xsl:when test="exsl:IsNonEmptyTableExist('barrier_data')">
                           <grouping>/RegionDomain/BarrierDomain/Function/ParentCallStack</grouping>
                         </xsl:when>
                          <xsl:otherwise>
                           <grouping>/RegionDomain/Function/ParentCallStack</grouping>
                         </xsl:otherwise>
                       </xsl:choose>
                       <row/>
                     </activate>
                   </href>
                 </grid>
               </section>
             </xsl:if>
           </sections>
         </section>
      </openMPTimeSections>
      <cpuUsageChart>
        <section type="histogram" expanded="true" id="CPUUsageChart">
          <header displayName="%CPUUsageChart"/>
          <description displayName="%CPUUsageChartDescription"/>
          <histogram allRows="true">
            <slider knob="utilizationThreshold">
              <xsl:if test="$contextMode='true'">
                <xsl:attribute name="readonly">
                  <xsl:text>true</xsl:text>
                </xsl:attribute>
              </xsl:if>
            </slider>
            <color>/CPUUsageUtilization</color>
            <columns>
              <column>/CpuUsageElapsedTime</column>
            </columns>
            <grouping>/CPUUsage</grouping>
            <markers>
              <marker>/TargetUtilization</marker>
              <xsl:choose>
                <xsl:when test="not($isRunssMode) and exsl:IsTableExist('pmu_data') and not(exsl:ctx('PMU')='knl') and exsl:ctx('isHTEnabled', 1) and ($isTmamSmtAware = 'true')">
                  <marker>/AveragePhysicalCPUUsage</marker>
                  <marker>/AverageLogicalCPUUsage</marker>
                </xsl:when>
                <xsl:otherwise>
                  <marker>/AverageCPUUsage</marker>
                </xsl:otherwise>
              </xsl:choose>
            </markers>
          </histogram>
        </section>
      </cpuUsageChart>
      <bandwidthUtilizationStatistic>
        <section type="grid" expanded="true" applicableUI="cli">
         <header displayName="%BandwidthUtilizationStatistic"/>
         <grid reloadOnKnobChangePurpose="knobDependentData">
          <columns>
           <column>/BandwidthDomainMax</column>
           <column>/BandwidthMax</column>
           <column>/AverageBandwidth</column>
           <column>/HighUtilizationTime</column>
          </columns>
          <grouping>/BandwidthDomain</grouping>
         </grid>
        </section>
      </bandwidthUtilizationStatistic>
      <bandwidthUtilizationChart>
        <section expanded="true" applicableUI="gui">
          <header displayName="%BandwidthUtilizationInfo"/>
          <description displayName="%BandwidthUtilizationInfoDescription"/>
          <domain>/BandwidthDomain</domain>
          <sections>
            <section type="histogram" expanded="true" allowExpansionRewriting="false">
              <header displayName="%BandwidthUtilizationChart"/>
              <description displayName="%BandwidthUtilizationChartDescription"/>
              <histogram allRows="true">
                <xsl:if test="(exsl:ctx('PMU') = 'knl')">
                  <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
                </xsl:if>
                <slider knob="bandwidthThreshold"/>
                <color>/BandwidthUtilizationType</color>
                <columns>
                  <column>/BandwidthUtilizationElapsedTime</column>
                </columns>
                <grouping>/BandwidthUtilizationBinValue</grouping>
                <markers>
                  <grouping>/BandwidthDomain</grouping>
                  <marker>/AverageBandwidth</marker>
                  <marker>/MaxBandwidth</marker>
                </markers>
              </histogram>
            </section>
            <section type="grid" expanded="true" applicableUI="gui" allowExpansionRewriting="false">
              <xsl:choose>
                <xsl:when test="exsl:IsNonEmptyTableExist('memory_object_data')">
                  <header displayName="%HighBandwidthUtilizationObjects"/>
                  <description displayName="%HighBandwidthUtilizationObjectsDescription"/>
                  <grid limit="5" reloadOnKnobChangePurpose="knobDependentData">
                    <columns>
                      <column>/HighUtilizationLLCMissCount</column>
                    </columns>
                    <sorting>/HighUtilizationLLCMissCount</sorting>
                    <grouping>/PMUMemoryObject</grouping>
                    <href>
                      <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                      <grouping>/BandwidthDomain/BandwidthUtilizationType/PMUMemoryObject/PMUMemoryObjectStack</grouping>
                        <rows>
                           <row value="domain"></row>
                           <row type="value" value="constant">%HighBandwidth</row>
                           <row value="data"></row>
                        </rows>
                      </activate>
                    </href>
                  </grid>
                </xsl:when>
                <xsl:otherwise>
                  <header displayName="%HighBandwidthUtilizationFunctions"/>
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('PMU') = 'knl'">
                      <description displayName="%HighBandwidthUtilizationFunctionsKNLDescription"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <description displayName="%HighBandwidthUtilizationFunctionsDescription"/>
                    </xsl:otherwise>
                  </xsl:choose>
                  <grid limit="5" reloadOnKnobChangePurpose="knobDependentData">
                    <xsl:choose>
                      <xsl:when test="exsl:ctx('PMU') = 'knl'">
                        <columns>
                          <column>/HighUtilizationLLCInputRequestsKNL</column>
                        </columns>
                        <sorting>/HighUtilizationLLCInputRequestsKNL</sorting>
                      </xsl:when>
                      <xsl:otherwise>
                        <columns>
                          <column>/HighUtilizationLLCMissCount</column>
                        </columns>
                        <sorting>/HighUtilizationLLCMissCount</sorting>
                      </xsl:otherwise>
                    </xsl:choose>
                    <grouping>/Function</grouping>
                    <href>
                      <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                      <grouping>/BandwidthDomain/BandwidthUtilizationType/Function/ParentCallStack</grouping>
                        <rows>
                           <row value="domain"></row>
                           <row type="value" value="constant">%HighBandwidth</row>
                           <row value="data"></row>
                        </rows>
                      </activate>
                    </href>
                  </grid>
                </xsl:otherwise>
              </xsl:choose>
            </section>
          </sections>
        </section>
      </bandwidthUtilizationChart>
      <bandwidthUtilizationChartMemory>
        <section expanded="true" applicableUI="gui">
          <header displayName="%BandwidthUtilizationInfo"/>
          <description displayName="%BandwidthUtilizationInfoDescription"/>
          <domain>/BandwidthDomainMemory</domain>
          <sections>
            <section type="histogram" expanded="true" allowExpansionRewriting="false">
              <header displayName="%BandwidthUtilizationChart"/>
              <description displayName="%BandwidthUtilizationChartDescription"/>
              <histogram allRows="true">
                <xsl:if test="(exsl:ctx('PMU') = 'knl')">
                  <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
                </xsl:if>
                <slider knob="bandwidthThreshold"/>
                <color>/BandwidthUtilizationType</color>
                <columns>
                  <column>/BandwidthUtilizationElapsedTime</column>
                </columns>
                <grouping>/BandwidthUtilizationBinValue</grouping>
                <markers>
                  <grouping>/BandwidthDomainMemory</grouping>
                  <marker>/AverageBandwidth</marker>
                  <marker>/MaxBandwidth</marker>
                </markers>
              </histogram>
            </section>
            <section type="grid" expanded="true" applicableUI="gui" allowExpansionRewriting="false">
              <xsl:choose>
                <xsl:when test="exsl:IsNonEmptyTableExist('memory_object_data')">
                  <header displayName="%HighBandwidthUtilizationObjects"/>
                  <description displayName="%HighBandwidthUtilizationObjectsDescription"/>
                  <grid limit="5" reloadOnKnobChangePurpose="knobDependentData">
                    <columns>
                      <column>/HighUtilizationLLCMissCount</column>
                    </columns>
                    <sorting>/HighUtilizationLLCMissCount</sorting>
                    <grouping>/PMUMemoryObject</grouping>
                    <href>
                      <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                      <grouping>/BandwidthDomain/BandwidthUtilizationType/PMUMemoryObject/PMUMemoryObjectStack</grouping>
                        <rows>
                           <row value="domain"></row>
                           <row type="value" value="constant">%HighBandwidth</row>
                           <row value="data"></row>
                        </rows>
                      </activate>
                    </href>
                  </grid>
                </xsl:when>
                <xsl:otherwise>
                  <header displayName="%HighBandwidthUtilizationFunctions"/>
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('PMU') = 'knl'">
                      <description displayName="%HighBandwidthUtilizationFunctionsKNLDescription"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <description displayName="%HighBandwidthUtilizationFunctionsDescription"/>
                    </xsl:otherwise>
                  </xsl:choose>
                  <grid limit="5" reloadOnKnobChangePurpose="knobDependentData">
                    <columns>
                      <column>/HighUtilizationLLCMissCount</column>
                    </columns>
                    <sorting>/HighUtilizationLLCMissCount</sorting>
                    <grouping>/Function</grouping>
                    <href>
                      <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                      <grouping>/BandwidthDomain/BandwidthUtilizationType/Function/ParentCallStack</grouping>
                        <rows>
                           <row value="domain"></row>
                           <row type="value" value="constant">%HighBandwidth</row>
                           <row value="data"></row>
                        </rows>
                      </activate>
                    </href>
                  </grid>
                </xsl:otherwise>
              </xsl:choose>
            </section>
          </sections>
        </section>
        <xsl:if test="not(exsl:ctx('useCountingMode', 0))">
          <section type="grid" expanded="true" applicableUI="cli">
            <header displayName="%BandwidthUtilizationStatistic"/>
            <grid reloadOnKnobChangePurpose="knobDependentData">
              <columns>
                <column>/BandwidthDomainMax</column>
                <column>/BandwidthMax</column>
                <column>/AverageBandwidth</column>
                <column>/HighUtilizationTime</column>
              </columns>
              <grouping>/BandwidthDomainMemory</grouping>
            </grid>
          </section>
        </xsl:if>
      </bandwidthUtilizationChartMemory>
      <topOpenMPProcess>
        <section type="grid" expanded="true" applicableUI="gui">
          <header displayName="%TopOpenMPProcesses"/>
          <description displayName="%TopOpenMPProcessesDescription" />
          <grid limit="5">
            <columns>
              <column>/ProcessID</column>
              <column>/SpinBusyWaitOnMPISpinningTime</column>
              <column>/SpinBusyWaitOnMPISpinningTimePercentElapsed</column>
              <column>
                <xsl:text>/RegionPotentialGain</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>/OpenMPThreadCountAggregationSum</xsl:text>
              </column>
              <column>
                <xsl:text>/RegionPotentialGain</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>PercentElapsedShort/OpenMPThreadCountAggregationSum</xsl:text>
              </column>
              <column>/SerialTimeShort</column>
              <column>/SerialTimePercentElapsedShort</column>
            </columns>
            <sorting>/SpinBusyWaitOnMPISpinningTime</sorting>
            <grouping>/GenericProcess</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <xsl:choose>
                  <xsl:when test="exsl:is_non_empty_table_exist('barrier_data')">
                    <grouping>/GenericProcess/RegionDomain/BarrierDomain/Function/ParentCallStack</grouping>
                  </xsl:when>
                  <xsl:otherwise>
                    <grouping>/GenericProcess/RegionDomain/Function/ParentCallStack</grouping>
                  </xsl:otherwise>
                </xsl:choose>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </topOpenMPProcess>
      <gpuEnginesUsage>
        <section expanded="onIssues">
          <header displayName="%GPUEnginesUsageTime">
            <column>/GPUUtilizationMax</column>
          </header>
          <description displayName="%GPUUtilizationDescription"/>
          <sections>
            <xsl:if test="exsl:is_non_empty_table_exist('cpu_gpu_usage_data')">
              <section type="tree" expanded="true">
                <header displayName="%DevicesConcurrencyAndUsage"/>
                <tree valueAlign="right">
                  <columns>
                    <column>/CPUGPUBothActive</column>
                    <column>/CPUOnlyActive</column>
                    <column>/GPUOnlyActive</column>
                    <column>/CPUGPUBothIdle</column>
                    <column>/CPUActiveTime</column>
                    <column>/GPUActiveTime</column>
                  </columns>
                </tree>
              </section>
            </xsl:if>
              <section type="grid" expanded="onIssues">
                <header displayName="%GPUEnginesUsageTime"/>
                <xsl:choose>
                  <xsl:when test="exsl:is_non_empty_table_exist('dma_packet_data')">
                    <description displayName="%GPUEnginesUsageTimeDescription"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <description displayName="%GPUEnginesUsageTimeNoPacketsDescription"/>
                  </xsl:otherwise>
                </xsl:choose>
                <grid>
                  <columns>
                    <column>/GPUTimeContext</column>
                    <column>/GPUUtilization</column>
                  </columns>
                  <sorting>/GPUUtilization</sorting>
                  <xsl:choose>
                    <xsl:when test="$packetsType='true'">
                      <grouping>/GPUNode/GPUDMAPacketPerfTagType</grouping>
                    </xsl:when>
                    <xsl:otherwise>
                      <grouping>/GPUNode</grouping>
                    </xsl:otherwise>
                  </xsl:choose>
                    <xsl:if test="$cpuGpuInteration='true'">
                      <href>
                        <activate tabId="gpuTimelinePane" handlerId="bottomUpPane">
                          <grouping>/Function/ParentCallStack</grouping>
                          <row/>
                        </activate>
                      </href>
                    </xsl:if>
                </grid>
              </section>
              <xsl:if test="exsl:is_non_empty_table_exist('dma_packet_data')">
              <section type="histogram" expanded="false">
                <header displayName="%DMAQueueDepthHistogramHeader"/>
                <description displayName="%DMAQueueDepthHistogramEscription"/>
                <histogram>
                  <columns>
                    <column>/QueueDepthDuration</column>
                  </columns>
                  <domain>/GPUNode</domain>
                  <grouping>/QueueDepth</grouping>
                  <markers>
                    <grouping>/GPUNode</grouping>
                    <marker>/QueueDepthAggregatedAvg</marker>
                  </markers>
                </histogram>
              </section>
              <xsl:if test="$packetsType='true'">
                <section type="histogram" expanded="false">
                  <header displayName="%DMAPacketDurationHistogramHeader"/>
                  <description displayName="%DMAPacketDurationHistogramDescription"/>
                  <histogram>
                    <columns>
                      <column>/GPUDMAPacketInstanceCountDerived</column>
                    </columns>
                    <domain>/GPUDMAPacketPerfTagForDuration</domain>
                    <grouping>/GPUDMAPacketDuration</grouping>
                    <markers>
                      <grouping>/GPUDMAPacketPerfTagForDuration</grouping>
                      <marker>/GPUDMAPacketInstanceAggregatedAvg</marker>
                    </markers>
                  </histogram>
                </section>
              </xsl:if>
              </xsl:if>
            <xsl:if test="$contextMode='false'">
                <xsl:if test="$showHottestTasks='true' and exsl:is_non_empty_table_exist('gpu_compute_task_data')">
                <section type="grid" expanded="false">
                  <header displayName="%TopGPUHotspots"/>
                  <description displayName="%TopGPUHotspotsDescription" />
                  <grid limit="5">
                    <columns>
                      <column>/GPUComputeTaskTimeSummary</column>
                      <column>/GPUComputeTaskDurationSummary</column>
                      <column>/GPUComputeTaskCountSummary</column>
                    </columns>
                    <sorting>/GPUComputeTaskTime</sorting>
                    <xsl:choose>
                      <xsl:when test="exsl:ctx('gpuHwCollection', 0)">
                        <grouping>/GPUComputeTaskTypeWithIssues</grouping>
                      </xsl:when>
                      <xsl:otherwise>
                        <grouping>/GPUComputeTaskType</grouping>
                      </xsl:otherwise>
                    </xsl:choose>
                    <href>
                      <activate tabId="gpuTimelinePane" handlerId="bottomUpPane">
                        <xsl:choose>
                          <xsl:when test="(exsl:ctx('appRunsCount', 1) > 1)">
                            <grouping>/GPUComputeTaskType</grouping>
                          </xsl:when>
                          <xsl:otherwise>
                            <grouping>/GPUComputeTaskType/GPUComputeTaskInstance</grouping>
                          </xsl:otherwise>
                        </xsl:choose>
                        <row/>
                      </activate>
                    </href>
                  </grid>
                </section>
              </xsl:if>
            </xsl:if>
          </sections>
            <section>
              <header>
                <column>/PausedTime</column>
              </header>
            </section>
        </section>
      </gpuEnginesUsage>
      <gpuEUArrayMetrics>
        <xsl:if test="exsl:is_non_empty_table_exist('gpu_data')">
          <section type="tree" expanded="true">
            <header displayName="%GPUEUArrayMetrics" />
            <tree valueAlign="right">
              <columns>
                <column>/GPUEUActive</column>
                <column>/GPUEUStalled</column>
                <column>/GPUEUIdle</column>
              </columns>
            </tree>
          </section>
        </xsl:if>
      </gpuEUArrayMetrics>
      <spdkIO>
        <xsl:if test="not(exsl:IsNonEmptyTableExist('spdk_io_data'))">
          <section>
            <boolean:allowCollapse>false</boolean:allowCollapse>
            <header displayName="%SpdkInfo"/>
            <description displayName="%SpdkVTuneSupportInfoDescription"/>
          </section>
        </xsl:if>
        <section type="tree" nullValue="hide" expanded="true">
          <header displayName="%SpdkInfo"/>
          <tree valueAlign="left">
            <columns>
              <column>/SpdkIoReadCount/SpdkIoDevice</column>
              <column>/SpdkIoReadBytesStr/SpdkIoDevice</column>
              <column>/SpdkIoWriteCount/SpdkIoDevice</column>
              <column>/SpdkIoWriteBytesStr/SpdkIoDevice</column>
              <column>/SpdkIoEffectiveTime/SpdkIoEffectiveTimeThread</column>
            </columns>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/SpdkIoDevice/Thread</grouping>
              </activate>
            </href>
          </tree>
        </section>
        <section expanded="true" applicableUI="gui">
          <header displayName="%SpdkBandwidthInfo"/>
          <description displayName="%SpdkBandwidthInfoDescription"/>
          <domain>/SpdkIOBinType</domain>
          <sections>
            <section type="histogram" expanded="true">
              <header displayName="%SpdkBandwidthHistogram"/>
              <description displayName="%SpdkBandwidthHistogramDescription"/>
              <histogram allRows="true">
                <slider knob="spdkIoBandwidthThreshold"/>
                <color>/SpdkIOBinValueType</color>
                <columns>
                  <column>/SpdkIoTime</column>
                </columns>
                <grouping>/SpdkIoBinValue</grouping>
              </histogram>
            </section>
            <section type="grid" expanded="true">
              <header displayName="%SpdkOperationsGrid"/>
              <description displayName="%SpdkOperationsGridDescription" />
              <grid reloadOnKnobChangePurpose="knobDependentData">
                <columns>
                  <column>/SpdkIoReadCount</column>
                  <column>/SpdkIoWriteCount</column>
                </columns>
                <grouping>/SpdkIOBinValueType</grouping>
              </grid>
            </section>
         </sections>
        </section>
        <section expanded="true" applicableUI="gui">
          <header displayName="%SpdkLatencyInfo"/>
          <description displayName="%SpdkLatencyInfoDescription"/>
          <domain>/SpdkIOBinType</domain>
          <sections>
            <section type="histogram" expanded="true">
              <header displayName="%SpdkLatencyHistogram"/>
              <description displayName="%SpdkLatencyHistogramDescription"/>
              <histogram allRows="true">
                <slider knob="spdkIoLatencyThreshold"/>
                <color>/SpdkIOBinValueType</color>
                <columns>
                  <column>/SpdkIoTime</column>
                </columns>
                <grouping>/SpdkIoLatencyBinValue</grouping>
              </histogram>
            </section>
            <section type="grid" expanded="true">
              <header displayName="%SpdkLatencyGrid"/>
              <description displayName="%SpdkLatencyGridDescription" />
              <grid reloadOnKnobChangePurpose="knobDependentData">
                <columns>
                  <column>/SpdkIoReadCount</column>
                  <column>/SpdkIoWriteCount</column>
                </columns>
                <grouping>/SpdkIOLatencyBinValueType</grouping>
              </grid>
            </section>
         </sections>
        </section>
      </spdkIO>
      <dpdkIO>
        <xsl:choose>
          <xsl:when test="not(exsl:is_non_empty_table_exist('dpdk_rx_burst_data') or exsl:is_non_empty_table_exist('dpdk_dequeue_burst_data'))">
            <section>
              <boolean:allowCollapse>false</boolean:allowCollapse>
              <header displayName="%DpdkInfo"/>
              <description displayName="%DpdkVTuneSupportInfoDescription"/>
            </section>
          </xsl:when>
          <xsl:otherwise>
            <xsl:if test="exsl:is_non_empty_table_exist('dpdk_rx_burst_data')">
              <section type="histogram" expanded="true">
                <header displayName="%DpdkRxBatchStatistics"/>
                <description displayName="%DpdkRxBatchStatisticsDescription"/>
                <histogram allRows="true">
                  <columns>
                    <column>/DpdkRxBurstCallTypeCount</column>
                  </columns>
                  <domain>/DpdkRxBurstCallDomain</domain>
                  <grouping>/DpdkRxBurstNumFetchedPackets</grouping>
                </histogram>
              </section>
            </xsl:if>
            <xsl:if test="exsl:is_non_empty_table_exist('dpdk_dequeue_burst_data')">
              <section type="histogram" expanded="true">
                <header displayName="%DpdkDequeueStatistics"/>
                <description displayName="%DpdkDequeueStatisticsDescription"/>
                <histogram allRows="true">
                  <columns>
                    <column>/DpdkDequeueCallCount</column>
                  </columns>
                  <domain>/DpdkDequeueDomain</domain>
                  <grouping>/DpdkDequeueNumPackets</grouping>
                </histogram>
              </section>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </dpdkIO>
      <memObjects>
        <section type="grid" expanded="true">
          <xsl:choose>
            <xsl:when test="exsl:ctx('PMU') = 'knl'">
              <header displayName="%TopMemoryObjects"/>
              <description displayName="%TopMemoryObjectsDescription" />
            </xsl:when>
            <xsl:otherwise>
              <header displayName="%TopMemoryObjectsByTotalLatency"/>
              <description displayName="%TopMemoryObjectsByTotalLatencyDescription" />
            </xsl:otherwise>
          </xsl:choose>
          <grid limit="5">
            <columns>
              <xsl:if test="exsl:ctx('PMU') != 'knl'">
                <column>/TotalLatencyPercent</column>
              </xsl:if>
              <column>/PMULoads</column>
              <column>/PMUStores</column>
              <column>/LLCMissCount</column>
            </columns>
            <xsl:choose>
              <xsl:when test="exsl:ctx('PMU') = 'knl'">
                <sorting>/LLCMissCount</sorting>
              </xsl:when>
              <xsl:otherwise>
                <sorting>/TotalLatencyPercent</sorting>
              </xsl:otherwise>
            </xsl:choose>
            <grouping>/PMUMemoryObject</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/PMUMemoryObject/Function/PMUMemoryObjectStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </memObjects>
      <latencyChart>
        <section type="histogram" expanded="true">
          <header displayName="%LatencyChart"/>
          <description displayName="%LatencyChartDescription"/>
          <histogram>
            <columns>
              <column>/LatencyLoads</column>
            </columns>
            <grouping>/PMULoadLatency</grouping>
          </histogram>
        </section>
      </latencyChart>
      <abortCyclesChart>
        <section type="histogram" expanded="true">
          <header displayName="%AbortCyclesChart"/>
          <description displayName="%AbortCyclesChartDescription"/>
          <histogram>
            <columns>
              <column>
                <xsl:choose>
                  <xsl:when test="exsl:ctx('collectPTforTSX')">
                    <xsl:text>/PTTSXAborted</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>/TSXAborted</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </column>
            </columns>
            <grouping>
              <xsl:choose>
                <xsl:when test="exsl:ctx('collectPTforTSX')">
                  <xsl:text>/PTTransactionalCyclesAborted</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>/PMUTsxAbortCycles</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </grouping>
          </histogram>
        </section>
      </abortCyclesChart>
      <power>
        <xsl:choose>
          <xsl:when test="exsl:ctx('ModulePState', 'none') = 'true'">
            <section type="grid" expanded="true">
              <header displayName="%TopFrequencyWakeUps">
                <href>
                  <activate tabId="bottomUpCPPane" handlerId="bottomUpCPPane">
                    <grouping>/HWModule</grouping>
                  </activate>
                </href>
              </header>
              <grid limit="5">
                <columns>
                  <column>/ModulePStateTime/ModulePStateType[%PState]</column>
                  <column>/ModulePStateTimePercentTop5/ModulePStateType[%PState]</column>
                </columns>
                <sorting>/ModulePStateTimePercentTop5</sorting>
                <grouping>/ModulePState</grouping>
              </grid>
            </section>
          </xsl:when>
          <xsl:otherwise>
            <section type="grid" expanded="true">
              <header displayName="%TopFrequencyWakeUps">
                <href>
                  <activate tabId="bottomUpCPPane" handlerId="bottomUpCPPane">
                    <grouping>/Core</grouping>
                  </activate>
                </href>
              </header>
              <grid limit="5">
                <columns>
                  <column>/PStateTime/PStateType[%PState]</column>
                  <column>/PStateTimePercentTop5/PStateType[%PState]</column>
                </columns>
                <sorting>/PStateTimePercentTop5</sorting>
                <grouping>/PState</grouping>
              </grid>
            </section>
          </xsl:otherwise>
        </xsl:choose>
        <section type="grid" expanded="true">
          <header displayName="%TopSleepStateWakeUps">
            <href>
              <activate tabId="bottomUpCPane" handlerId="bottomUpCPane"/>
            </href>
          </header>
          <grid limit="5">
            <columns>
              <column>/CStateWakeUpCount</column>
              <column>/CStateWakeUpCountPercentTop5</column>
            </columns>
            <sorting>/CStateWakeUpCountPercentTop5</sorting>
            <grouping>/CStateWakeUpObject</grouping>
          </grid>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopSCDevices">
            <href>
              <activate tabId="bottomUpDStatePane" handlerId="bottomUpDStatePane"/>
            </href>
          </header>
          <grid limit="5">
            <columns>
              <column>/TotalTimeInD0PercentTop5</column>
            </columns>
            <sorting>/TotalTimeInD0PercentTop5</sorting>
            <grouping>/DStateDevice</grouping>
          </grid>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopKWLProcesses">
            <href>
              <activate tabId="bottomUpWLPane" handlerId="bottomUpWLPane"/>
            </href>
          </header>
          <grid limit="5">
            <columns>
              <column>/KernelWakelockCount</column>
              <column>/KernelWakelockTimePercentTop5</column>
            </columns>
            <sorting>/KernelWakelockTimePercentTop5</sorting>
            <grouping>/KernelWakelockLockProcess</grouping>
          </grid>
        </section>
      </power>
      <istp>
        <section type="histogram" expanded="true">
          <header displayName="%InterruptDurationChart"/>
          <description displayName="%InterruptDurationChartDescription"/>
          <histogram>
            <slider knob="taskThreshold"/>
            <color>/IstpTaskDurationType</color>
            <columns>
              <column>/IstpTaskCount</column>
            </columns>
            <domain>/IstpDurationTaskType</domain>
            <grouping>/IstpTaskDuration</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%FunctionDurationChart"/>
          <description displayName="%FunctionDurationChartDescription"/>
          <histogram>
            <slider knob="taskThreshold"/>
            <color>/IstpFunctionDurationType</color>
            <columns>
              <column>/IstpFunctionCount</column>
            </columns>
            <domain>/IstpDurationFunctionType</domain>
            <grouping>/IstpFunctionDuration</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%CTDurationChart"/>
          <description displayName="%CTDurationChartDescription"/>
          <histogram>
            <slider knob="criticalTimingThreshold"/>
            <color>/CriticalTimingDurationType</color>
            <columns>
              <column>/CriticalTimingCount</column>
            </columns>
            <domain>/CriticalTimingDurationDomain</domain>
            <grouping>/CriticalTimingDuration</grouping>
          </histogram>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%VirtCoresArea"/>
          <description displayName="%VirtCoresAreaDescription"/>
          <grid limit="16">
            <columns>
              <column>/IstpTaskCountSummary</column>
              <column>/IstpFunctionCountSummary</column>
              <column>/IstpInterruptCountSummary</column>
              <column>/IstpClockCyclesDerived</column>
              <column>/IstpSyncCounters</column>
              <column>/IstpVCPUUtilization</column>
              <column>/IstpVCPUActiveTime</column>
              <column>/IstpVCPUInactiveTime</column>
              <column>/IstpCStateWakeUpCount</column>
            </columns>
            <grouping>/IstpLocation</grouping>
          </grid>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopTasks"/>
          <description displayName="%TopTasksDescription" />
          <grid limit="10">
            <columns>
              <column>/IstpTaskTime</column>
              <column>/IstpTaskCountSummary</column>
              <column>/IstpClockCyclesDerived</column>
              <column>/IstpSyncCounters</column>
            </columns>
            <sorting>/IstpTaskTime</sorting>
            <grouping>/GenericIstpThread</grouping>
            <href>
              <activate tabId="timelinePane" handlerId="bottomUpPane">
                <grouping>/GenericIstpThread/IstpTaskDurationType</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopFunctions"/>
          <description displayName="%TopFunctionsDescription" />
          <grid limit="10">
            <columns>
              <column>/IstpFunctionTime</column>
              <column>/IstpFunctionCountSummary</column>
              <column>/IstpClockCyclesDerived</column>
              <column>/IstpSyncCounters</column>
            </columns>
            <sorting>/IstpFunctionTime</sorting>
            <grouping>/IstpFunctionType</grouping>
            <href>
              <activate tabId="timelinePane" handlerId="bottomUpPane">
                <grouping>/IstpFunctionType/IstpFunctionDurationType</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </istp>
      <istpPower>
        <section type="tree" expanded="true">
          <header>
            <column>/IstpWakeUpsPerSecond</column>
          </header>
          <tree valueAlign="right">
            <columns>
              <column>/IstpVCPUUtilization</column>
              <column>/IstpVCPUActiveTime</column>
              <column>/IstpVCPUInactiveTime</column>
              <column>/IstpCStateWakeUpCount</column>
            </columns>
          </tree>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopCStateWakeUpObjects"/>
          <grid limit="10">
            <columns>
              <column>/IstpCStateCount/IstpCState[C0]</column>
            </columns>
            <sorting>/IstpCStateCount</sorting>
            <grouping>/IstpCStateWakeUpObject</grouping>
          </grid>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%CStateHistogram"/>
          <description displayName="%CStateHistogramDescription"/>
          <histogram>
           <columns>
            <column>/IstpCStateTime</column>
           </columns>
           <grouping>/IstpCState</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%FrequencyHistogram"/>
          <description displayName="%FrequencyHistogramDescription"/>
            <histogram>
              <columns>
                <column>/IstpPStateTime</column>
              </columns>
              <grouping>/IstpFrequency</grouping>
            </histogram>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopFrequencyWakeUps"/>
          <grid limit="5">
            <columns>
              <column>/IstpPStateTime</column>
            </columns>
            <sorting>/IstpPStateTime</sorting>
            <grouping>/IstpFrequency</grouping>
          </grid>
        </section>
        <section type="tree" expanded="true">
          <header displayName="%SystemSleepSummaryInfo"/>
          <tree valueAlign="right">
            <columns>
              <column>/IstpTotalTimeInS0</column>
              <column>/IstpTotalTimeNotInS0</column>
              <column>/IstpSStateWakeUpCount</column>
            </columns>
          </tree>
        </section>
        <section type="grid" expanded="true">
          <header displayName="%TopSStateWakeUpObjects"/>
          <grid limit="10">
            <columns>
              <column>/IstpSStateCount/IstpSState[S0]</column>
            </columns>
            <sorting>/IstpSStateCount</sorting>
            <grouping>/IstpSStateWakeUpObject</grouping>
          </grid>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%SStateHistogram"/>
          <description displayName="%SStateHistogramDescription"/>
          <histogram>
           <columns>
            <column>/IstpSStateTime</column>
           </columns>
           <grouping>/IstpSState</grouping>
          </histogram>
        </section>
      </istpPower>
      <averageBandwidth>
        <section type="grid" expanded="true" id="AverageBandwidth">
          <header displayName="%AverageDramBandwidth"/>
          <grid>
            <columns>
              <column>/SummaryBandwidth</column>
              <column>/SummaryReadBandwidth</column>
              <column>/SummaryWriteBandwidth</column>
            </columns>
            <grouping>/UncorePackage</grouping>
            <href>
              <activate handlerId="bottomUpPane">
                <xsl:attribute name="tabId">
                  <xsl:value-of select="$averageBandwidthHrefActivateTabId"/>
                </xsl:attribute>
                <grouping>/GenericPackage/HWContext/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </averageBandwidth>
      <acceleratorOCL>
        <section type="grid" expanded="true">
          <header displayName="%FPGATopTasks"/>
          <description displayName="%FPGATopTasksDescription" />
          <grid limit="5">
            <columns>
              <column>/FPGAComputeTaskTime</column>
              <column>/FPGAComputeTaskCount</column>
            </columns>
            <grouping>/FPGAComputeTaskType</grouping>
            <sorting>/FPGAComputeTaskTime</sorting>
            <href>
              <activate tabId="timelinePane" handlerId="bottomUpPane">
                <grouping>/FPGAComputeTaskType/FPGAComputeTaskInstance</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </acceleratorOCL>
      <CPUGPUUsage>
        <section type="tree" expanded="true">
          <header displayName="%DevicesConcurrencyAndUsage" />
          <tree valueAlign="right">
            <columns>
              <column>/CPUGPUBothActive</column>
              <column>/CPUOnlyActive</column>
              <column>/GPUOnlyActive</column>
              <column>/CPUGPUBothIdle</column>
              <column>/CPUActiveTime</column>
              <column>/GPUActiveTime</column>
            </columns>
          </tree>
        </section>
      </CPUGPUUsage>
      <cpuHotspots>
        <section type="grid" expanded="true" id="TopHotspots">
          <header displayName="%TopHotspots"/>
          <description displayName="%TopHotspotsDescription" />
          <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
            <columns>
              <column>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>FunctionModule</xsl:text>
              </column>
              <xsl:choose>
                <xsl:when test="$preciseClockticsCollected">
                  <column>/PreciseClockticks</column>
                </xsl:when>
                <xsl:otherwise>
                  <column>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$querySuffix"/>
                    <xsl:text>TimeSummary</xsl:text>
                  </column>
                </xsl:otherwise>
              </xsl:choose>
            </columns>
            <sorting>
              <xsl:choose>
                <xsl:when test="$preciseClockticsCollected">
                  <xsl:text>/PreciseClockticks</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$querySuffix"/>
                  <xsl:text>TimeSummary</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </sorting>
            <grouping>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$querySuffix"/>
              <xsl:text>Function</xsl:text>
            </grouping>
            <href>
              <activate handlerId="bottomUpPane">
                <xsl:attribute name="tabId">
                  <xsl:value-of select="$cpuHotspotsHrefActivateTabId"/>
                </xsl:attribute>
                <grouping>/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
        <xsl:if test="exsl:is_compare_mode()">
          <section type="grid" expanded="true">
            <header displayName="%TopHotspotsSortedByDiff"/>
            <description displayName="%TopHotspotsSortedByDiffDescription" />
            <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
              <columns>
                <column>
                  <xsl:text>/</xsl:text>
                  <xsl:text>FunctionModule</xsl:text>
                </column>
                <column>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$querySuffix"/>
                  <xsl:text>TimeDiff</xsl:text>
                </column>
              </columns>
              <sorting>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>TimeDiff</xsl:text>
              </sorting>
              <grouping>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>Function</xsl:text>
              </grouping>
              <href>
                <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                  <grouping>/Function/ParentCallStack</grouping>
                  <row/>
                </activate>
              </href>
            </grid>
          </section>
        </xsl:if>
      </cpuHotspots>
      <pmuEvents>
        <section type="grid" expanded="true">
          <header displayName="%PMUEvents"/>
          <grid allRows="true">
            <columns>
              <xsl:if test="exsl:IsNonEmptyTableExist('dd_core_type')">
                <column>/PMUEventCoreType</column>
              </xsl:if>
              <column>/PMUEventCount</column>
              <column>/PMUSampleCount</column>
              <column>/PMUEventsPerSample</column>
              <column>/PMUEventIsPrecise</column>
            </columns>
            <xsl:if test="not(exsl:ctx('useCountingMode', 0))">
              <href>
                <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                  <column/>
                </activate>
              </href>
            </xsl:if>
            <sorting>/PMUEventTypeDistinct</sorting>
            <grouping>/PMUEventTypeDistinct</grouping>
          </grid>
        </section>
      </pmuEvents>
      <uncoreEvents>
        <section type="grid" expanded="true">
          <header displayName="%UncoreEvent"/>
          <grid allRows="true">
            <columns>
              <column>/UncoreEventCount</column>
            </columns>
            <href>
              <activate tabId="uncoreBottomUpPane" handlerId="uncoreBottomUpPane">
                <column/>
              </activate>
            </href>
            <sorting>/UncoreEventType</sorting>
            <grouping>/UncoreEventType</grouping>
          </grid>
        </section>
      </uncoreEvents>
      <waitObjects>
        <section type="grid" expanded="true">
          <header displayName="%TopWaitObjects"/>
          <description displayName="%TopWaitObjectsDescription" />
          <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
            <columns>
              <column>/WaitModule</column>
              <column>/WaitTime</column>
              <column>/WaitCount</column>
            </columns>
            <sorting>/WaitTime</sorting>
            <grouping>/SyncObject</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/SyncObject/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </waitObjects>
      <waitObjectsWithPoorCPUUtilization>
        <section type="grid" expanded="true">
          <header displayName="%TopWaitObjects"/>
          <description displayName="%TopWaitObjectsDescription" />
          <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
            <columns>
              <column>/WaitModule</column>
              <column>/WaitTimeWithPoorCPUUtilization</column>
              <column>/WaitTimeWithPoorCPUUtilizationPercents</column>
              <column>/WaitCount</column>
            </columns>
            <sorting>/WaitTimeWithPoorCPUUtilization</sorting>
            <grouping>/SyncObject</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/SyncObject/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </waitObjectsWithPoorCPUUtilization>
      <inactiveWaitTimeWithPoorCPUUtilization>
        <section type="grid" expanded="true">
          <header displayName="%TopFunctionsByInactiveWaitTime"/>
          <description displayName="%TopFunctionsByInactiveWaitTimeDescription" />
          <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
            <columns>
              <column>/FunctionModule</column>
              <xsl:choose>
                <xsl:when test="not(exsl:ctx('hideContextSwitchesType',0))">
                  <column>/InactiveWaitTimeWithPoorCPUUtilizationGrid</column>
                  <column>/InactiveSyncWaitTimeWithPoorCPUUtilization</column>
                  <column>/InactiveSyncWaitCountWithPoorCPUUtilization</column>
                  <column>/PreemptionWaitTimeWithPoorCPUUtilization</column>
                  <column>/PreemptionWaitCountWithPoorCPUUtilization</column>
                </xsl:when>
                <xsl:otherwise>
                  <column>/InactiveWaitTimeWithPoorCPUUtilization</column>
                  <column>/InactiveWaitCountWithPoorCPUUtilization</column>
                </xsl:otherwise>
              </xsl:choose>
            </columns>
            <xsl:choose>
              <xsl:when test="not(exsl:ctx('hideContextSwitchesType',0))">
                <sorting>/InactiveWaitTimeWithPoorCPUUtilizationGrid</sorting>
              </xsl:when>
              <xsl:otherwise>
                <sorting>/InactiveWaitTimeWithPoorCPUUtilization</sorting>
              </xsl:otherwise>
            </xsl:choose>
            <grouping>/Function</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </inactiveWaitTimeWithPoorCPUUtilization>
      <topFunctionWithSpinOverheadTime>
        <section type="grid" expanded="true" id="topFunctionWithSpinOverheadTime">
          <header displayName="%topFunctionWithSpinOverheadTime"/>
          <description displayName="%topFunctionWithSpinOverheadTimeDescription"/>
          <grid limit="5" reloadOnKnobChangePurpose="cs_attribution">
            <columns>
              <column>/FunctionModule</column>
              <column>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>OverheadAndSpinTimeWithSummaryIssues</xsl:text>
              </column>
              <column>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>OverheadAndSpinTimePercentage</xsl:text>
              </column>
            </columns>
            <sorting>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>OverheadAndSpinTimeWithSummaryIssues</xsl:text>
            </sorting>
            <grouping>/Function</grouping>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </topFunctionWithSpinOverheadTime>
      <hwContextChart>
        <section type="histogram" expanded="true">
          <header displayName="%HWContextBalanceHistogram"/>
          <description displayName="%HWContextBalanceHistogramDescription"/>
          <histogram>
            <columns>
              <column>/RefTime</column>
            </columns>
            <grouping>/PMUHWContext</grouping>
          </histogram>
        </section>
      </hwContextChart>
      <tasks>
        <section type="grid" expanded="true" id="TopTasks">
          <header displayName="%TopTasks"/>
          <description displayName="%TopTasksDescription" />
          <grid limit="5">
            <columns>
              <column>/TaskTime</column>
              <column>/TaskCount</column>
            </columns>
            <grouping>/TaskType</grouping>
            <sorting>/TaskTime</sorting>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/TaskType/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </tasks>
      <interrupts>
        <section type="grid" expanded="true">
          <header displayName="%TopInterrupts"/>
          <description displayName="%TopInterruptsDescription" />
          <grid limit="5">
            <columns>
              <column>/InterruptTime</column>
              <column>/InterruptCount</column>
            </columns>
            <grouping>/Interrupt</grouping>
            <sorting>/InterruptTime</sorting>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <grouping>/Interrupt/InterruptDurationType/Function/ParentCallStack</grouping>
                <row/>
              </activate>
            </href>
          </grid>
        </section>
      </interrupts>
      <threadConcurrency>
        <section type="histogram" expanded="true">
          <header displayName="%ThreadConcurrencyChart"/>
          <description displayName="%ThreadConcurrencyChartDescription"/>
          <histogram>
            <slider knob="utilizationThreshold">
              <xsl:if test="$contextMode='true'">
                <xsl:attribute name="readonly">
                  <xsl:text>true</xsl:text>
                </xsl:attribute>
              </xsl:if>
            </slider>
            <color>/ConcurrencyUtilization</color>
            <columns>
              <column>/ConcurrencyElapsedTime</column>
            </columns>
            <grouping>/SimultaneouslyRunningThreads</grouping>
            <markers>
              <marker>/TargetConcurrency</marker>
            </markers>
          </histogram>
        </section>
      </threadConcurrency>
      <regionCPUUsageChart>
        <section type="histogram" expanded="true">
          <header displayName="%RegionCPUUsageChart"/>
          <description displayName="%RegionCPUUsageChartDescription"/>
          <histogram allRows="true">
            <slider knob="utilizationThreshold" readonly="true"/>
            <color>/CPUUsageUtilization</color>
            <columns>
              <column>/RegionCpuUsageElapsedTime</column>
            </columns>
            <domain>/RegionDomain</domain>
            <grouping>/CPUUsage</grouping>
            <sorting>/RegionCPUUsageChartSorting</sorting>
            <markers>
              <grouping>/RegionDomain</grouping>
              <marker>/TargetUtilization</marker>
              <marker>/AvgRegionCPUUsage</marker>
            </markers>
          </histogram>
        </section>
      </regionCPUUsageChart>
      <frameChart>
        <section type="histogram" expanded="true" id="FrameRateChart">
          <header displayName="%FrameRateChart"/>
          <description displayName="%FrameRateChartDescription"/>
          <histogram>
            <slider knob="frameThreshold"/>
            <color>/FrameType</color>
            <columns>
              <column>/FrameCount</column>
            </columns>
            <domain>/FrameDomain</domain>
            <grouping>/FrameRate</grouping>
          </histogram>
        </section>
      </frameChart>
      <regionDurationChart>
        <section type="histogram" expanded="true">
          <header displayName="%RegionDurationChart"/>
          <description displayName="%RegionDurationChartDescription"/>
          <histogram>
            <slider knob="regionThreshold"/>
            <color>/RegionType</color>
            <columns>
              <column>/RegionInstanceCount</column>
            </columns>
            <domain>/RegionDomain</domain>
            <grouping>/RegionDuration</grouping>
          </histogram>
        </section>
      </regionDurationChart>
      <anomalyRegionDurationChart>
        <section expanded="true" applicableUI="gui">
          <header displayName="%AnomalyRegionDuration"/>
          <description displayName="%AnomalyRegionDurationDescription"/>
          <domain>/RawIptRegionDomain</domain>
          <sections>
            <section type="histogram" expanded="true">
              <header displayName="%AnomalyRegionDurationChart"/>
              <description displayName="%AnomalyRegionDurationChartDescription"/>
              <histogram>
                <slider knob="codeRegionOfInterestThreshold"/>
                <color>/RawIptRegionDurationName</color>
                <columns>
                  <column>/RawIptRegionCount</column>
                </columns>
              <grouping>/RawIptRegionDuration</grouping>
            </histogram>
            </section>
            <section type="grid" expanded="true" allowExpansionRewriting="false">
              <header displayName="%AnomalyRegionByDuration"/>
              <grid limit="3" reloadOnKnobChangePurpose="codeRegionOfInterestThreshold">
                <columns>
                  <column>/RawIptRegionCount</column>
                </columns>
                <grouping>/RawIptRegionDurationName</grouping>
              </grid>
            </section>
          </sections>
        </section>
      </anomalyRegionDurationChart>
      <taskChart>
        <section type="histogram" expanded="true" id="TaskDurationChart">
          <header displayName="%TaskDurationChart"/>
          <description displayName="%TaskDurationChartDescription"/>
          <histogram>
            <slider knob="taskThreshold"/>
            <color>/TaskDurationType</color>
            <columns>
              <column>/TaskCount</column>
            </columns>
            <domain>/TaskType</domain>
            <grouping>/TaskDuration</grouping>
            <sorting>/TaskTime</sorting>
          </histogram>
        </section>
      </taskChart>
      <interruptsChart>
        <section type="histogram" expanded="true" id="InterruptDurationChart">
          <header displayName="%InterruptDurationChart"/>
          <description displayName="%InterruptDurationChartDescription"/>
          <histogram>
            <slider knob="interruptThreshold"/>
            <color>/InterruptDurationType</color>
            <columns>
              <column>/InterruptCount</column>
            </columns>
            <domain>/Interrupt</domain>
            <grouping>/InterruptDuration</grouping>
            <sorting>/InterruptTime</sorting>
          </histogram>
        </section>
      </interruptsChart>
      <ioChart>
        <section type="histogram" expanded="true">
          <header displayName="%IODurationChart"/>
          <description displayName="%IODurationChartDescription"/>
          <histogram>
            <slider knob="ioOperationThreshold"/>
            <color>/IOBinDurationType</color>
            <columns>
              <column>/IOQueueOperationCount</column>
            </columns>
            <domain>/IOBinType</domain>
            <grouping>/IOBinDuration</grouping>
          </histogram>
        </section>
      </ioChart>
      <powerChart>
        <section type="histogram" expanded="true">
          <header displayName="%FrequencyHistogram">
            <href>
              <activate tabId="bottomUpCPPane" handlerId="bottomUpCPPane">
                <grouping>/Core</grouping>
              </activate>
            </href>
          </header>
          <description displayName="%FrequencyHistogramDescription"/>
          <histogram xAxisType="ordinal">
            <columns>
              <column>/PStateTime</column>
            </columns>
            <domain>/PStateType</domain>
            <grouping>/PStateFreq</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%ModuleFrequencyHistogram">
            <href>
              <activate tabId="bottomUpCPPane" handlerId="bottomUpCPPane">
                <grouping>/HWModule</grouping>
              </activate>
            </href>
          </header>
          <description displayName="%ModuleFrequencyHistogramDescription"/>
          <histogram xAxisType="ordinal">
            <columns>
              <column>/ModulePStateTime</column>
            </columns>
            <grouping>/ModulePStateType/ModulePStateFreq</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%SleepStateHistogram">
            <href>
              <activate tabId="bottomUpCPane" handlerId="bottomUpCPane"/>
            </href>
          </header>
          <description displayName="%SleepStateHistogramDescription"/>
          <histogram xAxisType="ordinal">
            <columns>
              <column>/CStateTime</column>
            </columns>
            <grouping>/CState</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%SStateHistogram">
            <href>
              <activate tabId="bottomUpSStatePane" handlerId="bottomUpSStatePane"/>
            </href>
          </header>
          <description displayName="%SStateHistogramDescription"/>
          <histogram xAxisType="ordinal">
            <columns>
              <column>/SStateTime</column>
            </columns>
            <grouping>/SState</grouping>
          </histogram>
        </section>
        <section type="histogram" expanded="true">
          <header displayName="%GFXSleepStateHistogram">
            <href>
              <activate tabId="bottomUpGfxPane" handlerId="bottomUpGfxPane"/>
            </href>
          </header>
          <description displayName="%GFXSleepStateHistogramDescription"/>
          <histogram xAxisType="ordinal">
            <columns>
              <column>/GfxCStateTime</column>
            </columns>
            <grouping>/DeviceCStateName</grouping>
            <sorting>/DeviceCStateName</sorting>
          </histogram>
        </section>
      </powerChart>
      <resultInfo>
        <section type="tree" nullValue="hide" expanded="true" id="ResultInfo">
          <header displayName="%ResultInfo" />
          <description displayName="%ResultInfoDescription" />
          <tree valueAlign="left">
            <columns>
              <column>/ResultInfo</column>
            </columns>
          </tree>
          <sections>
            <xsl:if test="exsl:ctx('finalizationMode', 'fast') = 'fast'">
              <section type="undefined" expanded="true" valueAlign="left">
                <boolean:allowCollapse>false</boolean:allowCollapse>
                <header displayName="%fastFinalizationNotification" />
              </section>
            </xsl:if>
            <section type="tree" expanded="true" valueAlign="left">
              <header displayName="%CPU" />
              <tree valueAlign="left">
                <columns>
                  <column>/CPUInfo</column>
                  <xsl:if test="$showPhysicalCores='true'">
                    <column>/PhysicalCoreCount</column>
                  </xsl:if>
                </columns>
              </tree>
              <sections>
                <section type="tree" valueAlign="left">
                  <header displayName="%CATSupport" />
                  <tree valueAlign="left">
                    <columns>
                      <column>/CATSupport</column>
                    </columns>
                  </tree>
                </section>
              </sections>
            </section>
            <xsl:if test="($gpuDataCollected='true')">
              <section type="tree" expanded="true" valueAlign="left">
                <header displayName="%GPU" />
                <tree valueAlign="left">
                  <columns>
                    <column>/GPUAdapterInfo</column>
                  </columns>
                </tree>
                <xsl:if test="($gpuOpenCLDataCollected='true')">
                  <sections>
                    <section type="tree" expanded="true" valueAlign="left">
                      <header displayName="%GPUOpenCLInfo" />
                      <tree valueAlign="left">
                        <columns>
                          <column>/GPUOpenCLInfo</column>
                        </columns>
                      </tree>
                    </section>
                  </sections>
                </xsl:if>
              </section>
            </xsl:if>
          </sections>
        </section>
      </resultInfo>
      <powerCState>
        <section type="tree" expanded="true">
          <header>
            <column>/WakeUpsPerSecondPerCore</column>
          </header>
          <tree valueAlign="right">
            <columns>
              <column>/TotalElapsedTime</column>
              <column>/AvailableCoreTime</column>
              <column>/CPUUtilization</column>
              <column>/TotalTimeNotInC0</column>
              <column>/CStateWakeUpCount</column>
              <column>/CStateIRQWakeUps</column>
              <column>/CStateTimerWakeUps</column>
            </columns>
          </tree>
          <sections>
            <xsl:if test="$showPMUEvents='true'">
              <section type="tree" expanded="true">
                <header displayName="%PMUEventsSummary" />
                <tree valueAlign="right">
                  <columns>
                    <column>/MyDataColumns</column>
                    <column>/PausedTime</column>
                    <column>/FrameCount</column>
                  </columns>
                </tree>
              </section>
            </xsl:if>
            <section type="tree" expanded="true">
              <header displayName="%SystemSleepSummaryInfo" />
              <tree valueAlign="right">
                <columns>
                  <column>/TotalTimeInS0</column>
                  <column>/TotalTimeNotInS0</column>
                </columns>
              </tree>
            </section>
            <xsl:if test="exsl:ctx('OS', 'none') = 'Linux'">
              <section type="tree" expanded="true">
                <header displayName="%KernelWakelockSummaryInfo" />
                <tree valueAlign="right">
                  <columns>
                    <column>/KernelWakelockCount</column>
                  </columns>
                </tree>
              </section>
              <section type="tree" expanded="true">
                <header displayName="%UserWakelockSummaryInfo" />
                <tree valueAlign="right">
                  <columns>
                    <column>/UserWakelockCount</column>
                  </columns>
                </tree>
              </section>
            </xsl:if>
          </sections>
        </section>
      </powerCState>
      <OmniPathUsageSection>
        <section type="tree" expanded="true" allowExpansionRewriting="false">
          <xsl:if test="$cliMode='true'">
            <xsl:attribute name="applicableUI">cli</xsl:attribute>
          </xsl:if>
          <header displayName="%OmniPathBandwidthSection"/>
          <tree valueAlign="left">
            <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
            <columns>
              <column>/OmniPathOutgoingBandwidthBoundUncore</column>
              <column>/OmniPathIncomingBandwidthBoundUncore</column>
            </columns>
          </tree>
          <sections>
            <section type="histogram" expanded="false" allowExpansionRewriting="false" applicableUI="gui">
              <header displayName="%BandwidthUtilizationChart"/>
              <description displayName="%OmniPathBandwidthChartDescription"/>
              <histogram allRows="true">
                <xsl:if test="(exsl:ctx('PMU') = 'knl')">
                  <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
                </xsl:if>
                <slider knob="bandwidthThreshold"/>
                <color>/BandwidthUtilizationType</color>
                <columns>
                  <column>/BandwidthUtilizationElapsedTime</column>
                </columns>
                <domain>/BandwidthDomainOmniPath</domain>
                <grouping>/BandwidthUtilizationBinValue</grouping>
                <markers>
                  <grouping>/BandwidthDomainOmniPath</grouping>
                  <marker>/AverageBandwidth</marker>
                  <marker>/MaxBandwidth</marker>
                </markers>
              </histogram>
            </section>
            <section type="grid" expanded="true" applicableUI="cli">
              <header displayName="%BandwidthUtilizationStatistic"/>
              <grid reloadOnKnobChangePurpose="knobDependentData">
                <columns>
                  <column>/BandwidthDomainMax</column>
                  <column>/BandwidthMax</column>
                  <column>/AverageBandwidth</column>
                  <column>/HighUtilizationTime</column>
                </columns>
                <grouping>/BandwidthDomainOmniPath</grouping>
              </grid>
            </section>
          </sections>
        </section>
        <section type="tree" expanded="true" allowExpansionRewriting="false">
          <xsl:if test="$cliMode='true'">
            <xsl:attribute name="applicableUI">cli</xsl:attribute>
          </xsl:if>
          <header displayName="%OmniPathPacketRateSection"/>
          <tree valueAlign="left">
            <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
            <columns>
              <column>/OmniPathOutgoingPacketRateBoundUncore</column>
              <column>/OmniPathIncomingPacketRateBoundUncore</column>
            </columns>
          </tree>
          <sections>
            <section type="histogram" expanded="false" allowExpansionRewriting="false" applicableUI="gui">
              <header displayName="%PacketRateChart"/>
              <description displayName="%PacketRateChartDescription"/>
              <histogram allRows="true">
                <xsl:if test="(exsl:ctx('PMU') = 'knl')">
                  <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
                </xsl:if>
                <slider knob="bandwidthThreshold"/>
                <color>/BandwidthUtilizationType</color>
                <columns>
                  <column>/BandwidthUtilizationElapsedTime</column>
                </columns>
                <domain>/BandwidthDomainOmniPathPacketRate</domain>
                <grouping>/BandwidthUtilizationBinValuePacketRate</grouping>
                <markers>
                  <grouping>/BandwidthDomainOmniPathPacketRate</grouping>
                  <marker>/AveragePacketRate</marker>
                  <marker>/MaxBandwidth</marker>
                </markers>
              </histogram>
            </section>
            <section type="grid" expanded="true" applicableUI="cli">
              <header displayName="%PacketRateGrid"/>
              <grid reloadOnKnobChangePurpose="knobDependentData">
                <columns>
                  <column>/BandwidthDomainMax</column>
                  <column>/BandwidthMax</column>
                  <column>/AveragePacketRate</column>
                  <column>/HighPacketRateTime</column>
                </columns>
                <grouping>/BandwidthDomainOmniPathPacketRate</grouping>
              </grid>
            </section>
          </sections>
        </section>
      </OmniPathUsageSection>
      <AverageOmniPathUsageSection>
        <section type="tree" expanded="true" allowExpansionRewriting="false">
          <header displayName="%OmniPathBandwidthSection"/>
          <tree valueAlign="left">
            <columns>
              <column>/AverageOmniPathOutgoingBandwidth</column>
              <column>/AverageOmniPathIncomingBandwidth</column>
            </columns>
          </tree>
          <section expanded="false" applicableUI="gui" allowExpansionRewriting="false">
            <header displayName="%BandwidthUtilizationInfo"/>
            <description displayName="%BandwidthUtilizationInfoDescription"/>
            <domain>/BandwidthDomainOmniPath</domain>
          </section>
        </section>
        <section type="tree" expanded="true" allowExpansionRewriting="false">
          <header displayName="%OmniPathPacketRateSection"/>
          <tree valueAlign="left">
            <columns>
              <column>/AverageOmniPathOutgoingPacketRate</column>
              <column>/AverageOmniPathIncomingPacketRate</column>
            </columns>
          </tree>
          <section expanded="false" applicableUI="gui" allowExpansionRewriting="false">
            <header displayName="%PacketRateInfo"/>
            <description displayName="%PacketRateInfoDescription"/>
            <domain>/BandwidthDomainOmniPathPacketRate</domain>
          </section>
        </section>
      </AverageOmniPathUsageSection>
      <PMUEventsContextSummary>
        <section type="grid" expanded="true">
          <header displayName="%PMUEvents"/>
          <grid allRows="true">
            <columns>
              <column>/PMUEventCount</column>
            </columns>
            <href>
              <activate>
                <xsl:attribute name="tabId">
                  <xsl:value-of select="$eventsSummaryHrefActivate"/>
                </xsl:attribute>
                <xsl:attribute name="handlerId">
                  <xsl:value-of select="$eventsSummaryHrefActivate"/>
                </xsl:attribute>
                <column/>
              </activate>
            </href>
            <sorting>/PMUEventType</sorting>
            <grouping>/PMUEventType</grouping>
          </grid>
        </section>
      </PMUEventsContextSummary>
      <PMUSamplesContextSummary>
        <section type="grid" expanded="true">
          <header displayName="%PMUEventSamples"/>
          <grid allRows="true">
            <columns>
              <column>/PMUSampleCount</column>
            </columns>
            <href>
              <activate>
                <xsl:attribute name="tabId">
                  <xsl:value-of select="$samplesSummaryHrefActivate"/>
                </xsl:attribute>
                <xsl:attribute name="handlerId">
                  <xsl:value-of select="$samplesSummaryHrefActivate"/>
                </xsl:attribute>
                <column/>
              </activate>
            </href>
            <sorting>/PMUEventType</sorting>
            <grouping>/PMUEventType</grouping>
          </grid>
        </section>
      </PMUSamplesContextSummary>
      <PMUUncoreEventsContextSummary>
        <section type="grid" expanded="true">
          <header displayName="%PMUUncoreEvents"/>
          <grid allRows="true">
            <columns>
              <column>/UncoreEventCount</column>
            </columns>
            <href>
              <activate>
                <xsl:attribute name="tabId">
                  <xsl:value-of select="$uncoreEventsSummaryHrefActivate"/>
                </xsl:attribute>
                <xsl:attribute name="handlerId">
                  <xsl:value-of select="$uncoreEventsSummaryHrefActivate"/>
                </xsl:attribute>
                <column/>
              </activate>
            </href>
            <sorting>/UncoreEventType</sorting>
            <grouping>/UncoreEventType</grouping>
          </grid>
        </section>
      </PMUUncoreEventsContextSummary>
      <PCIeTrafficSummary>
        <section type="tree" expanded="true" id="PCIeTrafficSummary" allowExpansionRewriting="false">
          <header displayName="%PCIeTrafficSummary"/>
          <tree valueAlign="right" highlightColumnsWithExpansion="false">
            <columns>
              <column>/InboundPCIeReadSummary</column>
              <column>/InboundPCIeWriteSummary</column>
              <column>/OutboundPCIeReadSummary</column>
              <column>/OutboundPCIeWriteSummary</column>
            </columns>
            <href>
              <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                <xsl:choose>
                  <xsl:when test="exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell_server'">
                    <grouping>/UncorePackage</grouping>
                  </xsl:when>
                  <xsl:otherwise>
                    <grouping>/UncorePackage/M2PCIe</grouping>
                  </xsl:otherwise>
                </xsl:choose>
              </activate>
            </href>
          </tree>
        </section>
        <xsl:if test="$uncacheableReadsCollected">
          <section type="grid" expanded="true" id="UncacheableReadTopHotspots">
            <header displayName="%UncacheableReadTopHotspots"/>
            <description displayName="%UncacheableReadTopHotspotsDescription" />
            <grid limit="5">
              <columns>
                <column>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$querySuffix"/>
                  <xsl:text>FunctionModule</xsl:text>
                </column>
                <column>/UncacheableReadsPerSecond</column>
              </columns>
              <sorting>/UncacheableReadsPerSecond</sorting>
              <grouping>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$querySuffix"/>
                <xsl:text>Function</xsl:text>
              </grouping>
              <href>
                <activate handlerId="bottomUpPane">
                  <xsl:attribute name="tabId">
                    <xsl:value-of select="$cpuHotspotsHrefActivateTabId"/>
                  </xsl:attribute>
                  <grouping>/Function/ParentCallStack</grouping>
                  <row/>
                </activate>
              </href>
            </grid>
          </section>
        </xsl:if>
      </PCIeTrafficSummary>
      <resultSummary>
        <section type="tree" expanded="true" id="ResultSummary">
          <header>
            <column>/TotalElapsedTime</column>
          </header>
          <tree valueAlign="right" autoExpansionLimit="2" highlightColumnsWithExpansion="true">
            <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
            <href>
              <activate handlerId="bottomUpPane">
                <xsl:attribute name="tabId">
                  <xsl:value-of select="$resultSummaryHrefActivateTabId"/>
                </xsl:attribute>
                <column/>
              </activate>
            </href>
            <columns>
              <column>/MySummaryColumns</column>
              <column>/TotalThreadCount</column>
              <column>/PausedTime</column>
            </columns>
          </tree>
        </section>
      </resultSummary>
      <messages>
        <noValue displayName="%NoMetricValue"/>
        <xsl:choose>
          <xsl:when test="$contextMode='true'">
            <noValueDescription displayName="%NoMetricValueFilterDescription"/>
          </xsl:when>
          <xsl:otherwise>
            <noValueDescription displayName="%NoMetricValueDescription"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
          <xsl:when test="$contextMode='true'">
            <noData displayName="%NoDataToShowWithFilter"/>
          </xsl:when>
          <xsl:otherwise>
            <noData displayName="%NoDataToShowOnActiveTime"/>
          </xsl:otherwise>
        </xsl:choose>
        <notChanged displayName="%NotChanged"/>
        <unexpectedError displayName="%UnexpectedErrorOnLoadingData" />
        <notSummableValue displayName="%NotSummable" />
        <notSummableValueDescription displayName="%NotSummableDescription" />
        <other displayName="%Others" />
        <detailsLink  displayName="%DetailsLink"/>
        <apply displayName="%Apply"/>
        <applyWarning displayName="%ApplyButtonWarning"/>
        <applyWaiting displayName="%ApplyButtonWaiting"/>
        <colorbandTooltip displayName="%ColorbandTooltip"/>
        <copyToClipboard displayName="%CopyToClipboard"/>
      </messages>
    </root>
  </xsl:template>
</xsl:stylesheet>
