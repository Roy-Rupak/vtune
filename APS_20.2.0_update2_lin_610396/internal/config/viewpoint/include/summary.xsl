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
    xmlns:exsl="http://exslt.org/common"
    exclude-result-prefixes="msxsl"
    xmlns:int="http://www.w3.org/2001/XMLSchema#int"
    xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id">summaryPane</xsl:param>
  <xsl:param name="contextMode">false</xsl:param>
  <xsl:param name="displayName">SummaryWindow</xsl:param>
  <xsl:param name="description">HotspotsSummaryWindowDescription</xsl:param>
  <xsl:param name="resultSummaryHeaderColumn">TotalElapsedTime</xsl:param>
  <xsl:param name="resultSummaryColumns">MySummaryColumns</xsl:param>
  <xsl:param name="helpKeyWord">configs.interpret_result_summary_f1024</xsl:param>
  <xsl:param name="querySuffix"/>
  <xsl:param name="showSummaryInfo">true</xsl:param>
  <xsl:param name="showTasks">
    <xsl:value-of select="exsl:is_non_empty_table_exist('task_data')"/>
  </xsl:param>
  <xsl:param name="showFrames">
    <xsl:value-of select="exsl:is_non_empty_table_exist('frame_data')"/>
  </xsl:param>
  <xsl:param name="showCPUHotspots">false</xsl:param>
  <xsl:param name="showCPUUsage">false</xsl:param>
  <xsl:param name="showGPUUsage">false</xsl:param>
  <xsl:param name="showEUArrayMetrics">false</xsl:param>
  <xsl:param name="showCPUGPUUsage">false</xsl:param>
  <xsl:param name="showPMUEvents">false</xsl:param>
  <xsl:param name="showUncoreEvents">false</xsl:param>
  <xsl:param name="showUtube">false</xsl:param>
  <xsl:param name="showRecommendations">false</xsl:param>
  <xsl:param name="showOpenMP">false</xsl:param>
  <xsl:param name="enableMPIAnalysis">true</xsl:param>
  <xsl:param name="showThreadConcurrency">false</xsl:param>
  <xsl:param name="showWaitObjects">false</xsl:param>
  <xsl:param name="showBandwidth">false</xsl:param>
  <xsl:param name="showInterrupts">false</xsl:param>
  <xsl:param name="showHWContextHistogram">false</xsl:param>
  <xsl:param name="showBandwidthUtilization">false</xsl:param>
  <xsl:param name="showMemObjects">false</xsl:param>
  <xsl:param name="showLatencyChart">false</xsl:param>
  <xsl:param name="showAbortCycles">false</xsl:param>
  <xsl:param name="showPhysicalCores">false</xsl:param>
  <xsl:param name="enableLinksInSummaryInfo">true</xsl:param>
  <xsl:param name="showResultInfo">true</xsl:param>
  <xsl:param name="showPower">false</xsl:param>
  <xsl:param name="showISTP">false</xsl:param>
  <xsl:param name="showIstpPower">false</xsl:param>
  <xsl:param name="showPcieTraffic">false</xsl:param>
  <xsl:param name="showIO">false</xsl:param>
  <xsl:param name="showSpdkIO">false</xsl:param>
  <xsl:param name="showDpdkIO">false</xsl:param>
  <xsl:param name="showMemoryConsumptionHistogram">false</xsl:param>
  <xsl:param name="showMemoryConsumptionTopFiveGrid">false</xsl:param>
  <xsl:param name="showAcceleratorOCL">false</xsl:param>
  <xsl:param name="packetsType">true</xsl:param>
  <xsl:param name="summaryInfoMaxLevelsToShow">100</xsl:param>
  <xsl:param name="manageGlobalFilter">false</xsl:param>
  <xsl:param name="highlightColumnsWithExpansion">true</xsl:param>
  <xsl:param name="applicationFile">summary</xsl:param>
  <xsl:param name="applicationSubPage"></xsl:param>
  <xsl:param name="showAnomalyDetection">false</xsl:param>
  <xsl:template match="/">
    <xsl:variable name="gpuCfg" select="document('config://viewpoint/include/gpu.cfg')"/>
    <xsl:variable name="barrierDataCollected" select="exsl:is_non_empty_table_exist('barrier_data')"/>
    <xsl:variable name="needToShowFrames" select="($showFrames='true') and exsl:is_non_empty_table_exist('frame_data')"/>
    <xsl:variable name="pmuCommon" select="document('config://include/pmu_common.xsl')"/>
    <xsl:variable name="isTmamSmtAware" select="$pmuCommon//variables/isTmamSmtAware"/>
    <xsl:variable name="isRunssMode" select="exsl:ctx('runss:enable', 0) or (exsl:ctx('runsa:enable', 'na') = 'na' and exsl:ctx('runss:enable', 'na') = 'na' and exsl:IsTableExist('cpu_data'))"/>
    <xsl:variable name="isLittleCorePlatform" select="exsl:ctx('PMU') = 'knl' or exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont' or exsl:ctx('PMU') = 'goldmont' or exsl:ctx('PMU') = 'goldmont_plus'"/>
    <xsl:variable name="summaryBlocksParams">
      <params
        querySuffix="{$querySuffix}"
        contextMode="{$contextMode}"
        packetsType="{$packetsType}"
        showPMUEvents="{$showPMUEvents}"
        showPhysicalCores="{$showPhysicalCores}"
       />
    </xsl:variable>
    <xsl:variable name="summaryBlocksFileName">
      <xsl:text>config://viewpoint/include/summaryblocks.xsl?</xsl:text>
      <xsl:for-each select="exsl:node-set($summaryBlocksParams)//@*">
        <xsl:if test=". and .!=''">
          <xsl:value-of select="concat(name(), '=', .)"/>
          <xsl:text>&amp;</xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="summaryBlocks" select="document($summaryBlocksFileName)"/>
    <html id="{$id}" displayName="%{$displayName}">
      <filter>
      <xsl:if test="$contextMode='true'">
        <xsl:attribute name="handleList">
          <xsl:text>selection,global</xsl:text>
        </xsl:attribute>
      </xsl:if>
        <xsl:attribute name="boolean:manageGlobalFilter">
          <xsl:value-of select="$manageGlobalFilter"/>
        </xsl:attribute>
      </filter>
      <event handleList="KnobChangedEvent"/>
      <application name="{$applicationFile}"/>
      <xsl:if test="$applicationSubPage != ''">
          <subPage href="{$applicationSubPage}"/>
      </xsl:if>
      <helpKeywordF1>
        <xsl:value-of select="$helpKeyWord"/>
      </helpKeywordF1>
      <description>
        <xsl:text>%</xsl:text>
        <xsl:value-of select="$description"/>
      </description>
      <icon file="client.dat#zip:images.xrc" image="tab_summary"/>
      <config>
        <xsl:if test="$showRecommendations='true'">
          <recommendations>
            <recommendation>
              <header>
                <column>/shortCollectionMuxRecommendation</column>
              </header>
            </recommendation>
          </recommendations>
        </xsl:if>
        <xsl:if test="$contextMode='true'">
          <style>context-summary</style>
        </xsl:if>
        <sections>
          <xsl:if test="$showSummaryInfo='true'">
            <section type="tree" expanded="true" id="ResultSummary">
              <xsl:if test="not($isLittleCorePlatform) and ($showUtube='true') and not(exsl:is_compare_mode())">
                <xsl:attribute name="applicableUI">cli</xsl:attribute>
              </xsl:if>
              <header>
                <column>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$resultSummaryHeaderColumn"/>
                </column>
              </header>
              <tree valueAlign="right" int:autoExpansionLimit="{$summaryInfoMaxLevelsToShow}" boolean:highlightColumnsWithExpansion="{$highlightColumnsWithExpansion}">
                <xsl:if test="$showBandwidthUtilization = 'true'">
                  <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
                </xsl:if>
                <xsl:if test="$enableLinksInSummaryInfo='true' and (not(exsl:ctx('useCountingMode', 0)) or $isRunssMode)">
                  <href>
                    <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                      <column/>
                    </activate>
                  </href>
                </xsl:if>
                <columns>
                  <xsl:if test="exsl:ctx('systemWideDiskIO', 0) = 1 and exsl:ctx('targetOS') != 'Windows'">
                    <column>/IoWaitTime</column>
                  </xsl:if>
                  <column>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$resultSummaryColumns"/>
                  </column>
                  <xsl:if test="($contextMode != 'true') and ($showPower != 'true') and ($showISTP != 'true')">
                    <column>/TotalThreadCount</column>
                    <column>/PausedTime</column>
                    <xsl:if test="$needToShowFrames">
                      <column>/FrameCount</column>
                    </xsl:if>
                  </xsl:if>
                </columns>
              </tree>
            </section>
            <xsl:if test="not($isLittleCorePlatform) and ($showUtube='true') and not(exsl:is_compare_mode())">
              <section type="utube" applicableUI="gui" expanded="true">
                <header>
                  <column>
                    <xsl:text>/</xsl:text>
                    <xsl:choose>
                      <xsl:when test="($contextMode != 'true')">
                        <xsl:value-of select="$resultSummaryHeaderColumn"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>UArchEfficiency</xsl:text>
                      </xsl:otherwise>
                    </xsl:choose>
                  </column>
                </header>
                <xsl:if test="($showUtube='true')">
                  <utube mode="full"
                         frontEndBound="/FrontendBoundPipelineSlots"
                         badSpec="/CancelledPipelineSlots"
                         memoryBound="/MemBound"
                         coreBound="/CoreBound"
                         retiring="/RetiredPipelineSlots"
                         description="%uTubeDescription"
                         displayName="%uTube">
                    <xsl:choose>
                      <xsl:when test="exsl:ctx('shortCollectionMux', 0)">
                        <shortCollection>true</shortCollection>
                      </xsl:when>
                      <xsl:otherwise>
                        <shortCollection>false</shortCollection>
                      </xsl:otherwise>
                    </xsl:choose>
                  </utube>
                </xsl:if>
                <tree valueAlign="right" int:autoExpansionLimit="{$summaryInfoMaxLevelsToShow}" boolean:highlightColumnsWithExpansion="{$highlightColumnsWithExpansion}">
                  <xsl:if test="$showBandwidthUtilization = 'true'">
                    <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
                  </xsl:if>
                  <xsl:if test="$enableLinksInSummaryInfo='true' and (not(exsl:ctx('useCountingMode', 0)) or $isRunssMode)">
                    <href>
                      <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                        <column/>
                      </activate>
                    </href>
                  </xsl:if>
                  <columns>
                    <xsl:if test="exsl:ctx('systemWideDiskIO', 0) = 1 and exsl:ctx('targetOS') != 'Windows'">
                      <column>/IoWaitTime</column>
                    </xsl:if>
                    <column>
                      <xsl:text>/</xsl:text>
                      <xsl:value-of select="$resultSummaryColumns"/>
                    </column>
                    <xsl:if test="($contextMode != 'true') and ($showPower != 'true') and ($showISTP != 'true')">
                      <column>/TotalThreadCount</column>
                      <column>/PausedTime</column>
                      <xsl:if test="$needToShowFrames">
                        <column>/FrameCount</column>
                      </xsl:if>
                    </xsl:if>
                  </columns>
                </tree>
              </section>
            </xsl:if>
          </xsl:if>
          <xsl:if test="$showPcieTraffic='true'">
            <xsl:copy-of select="$summaryBlocks//root/PCIeTrafficSummary/*"/>
          </xsl:if>
          <xsl:if test="$showSpdkIO='true'">
            <xsl:copy-of select="$summaryBlocks//root/spdkIO/*"/>
          </xsl:if>
          <xsl:if test="$showDpdkIO='true'">
            <xsl:copy-of select="$summaryBlocks//root/dpdkIO/*"/>
          </xsl:if>
          <xsl:if test="$showOpenMP='true'">
            <xsl:if test="exsl:ctx('openmpProcessCount') = 1">
              <section type="tree" expanded="true">
                <header>
                  <column>/OpenMPSectionHeader</column>
                </header>
                <sections>
                  <xsl:copy-of select="$summaryBlocks//root/openMPTimeSections/*"/>
                </sections>
              </section>
            </xsl:if>
            <xsl:if test="(exsl:ctx('openmpProcessCount') > 1)">
              <xsl:if test="$enableMPIAnalysis='true' and exsl:is_experimental('mpi-analysis')">
                <section type="grid" expanded="true">
                  <header displayName="%MPIAnalisysMainMetrics"/>
                  <description displayName="%MPIAnalisysMainMetricsDescription" />
                  <grid>
                    <columns>
                      <column>/SerialTime</column>
                      <column>/SpinBusyWaitOnMPISpinningTime</column>
                      <column>/RegionTime</column>
                      <column>/RegionPotentialGainCPUShort/OpenMPThreadCountAggregationSum</column>
                    </columns>
                    <grouping>/GenericProcessAggregatedMinAvgMax</grouping>
                  </grid>
                </section>
              </xsl:if>
              <xsl:copy-of select="$summaryBlocks//root/topOpenMPProcess/*"/>
            </xsl:if>
          </xsl:if>
          <xsl:if test="$showMemoryConsumptionTopFiveGrid='true'">
            <xsl:copy-of select="$summaryBlocks//root/memoryConsumptionTopFiveObjects/*"/>
          </xsl:if>
          <xsl:if test="$showMemoryConsumptionHistogram='true'">
            <xsl:copy-of select="$summaryBlocks//root/memoryConsumptionChart/*"/>
          </xsl:if>
          <xsl:if test="$showPower='true'">
            <xsl:copy-of select="$summaryBlocks//root/powerCState/*"/>
          </xsl:if>
          <xsl:if test="$showGPUUsage='true'">
            <xsl:copy-of select="$summaryBlocks//root/gpuEnginesUsage/*"/>
          </xsl:if>
          <xsl:if test="$showEUArrayMetrics='true'">
            <xsl:copy-of select="$summaryBlocks//root/gpuEUArrayMetrics/*"/>
          </xsl:if>
          <xsl:if test="$showCPUGPUUsage='true' and exsl:is_non_empty_table_exist('cpu_gpu_usage_data')">
            <xsl:copy-of select="$summaryBlocks//root/CPUGPUUsage/*"/>
          </xsl:if>
          <xsl:if test="$showBandwidthUtilization='true'">
            <xsl:copy-of select="$summaryBlocks//root/bandwidthUtilizationStatistic/*"/>
            <xsl:copy-of select="$summaryBlocks//root/bandwidthUtilizationChart/*"/>
          </xsl:if>
          <xsl:if test="$showCPUHotspots='true' and (not(exsl:ctx('useCountingMode', 0)) or $isRunssMode)">
            <xsl:copy-of select="$summaryBlocks//root/cpuHotspots/*"/>
          </xsl:if>
          <xsl:if test="$showPMUEvents='true'">
            <xsl:copy-of select="$summaryBlocks//root/pmuEvents/*"/>
          </xsl:if>
          <xsl:if test="$showUncoreEvents='true'">
            <xsl:copy-of select="$summaryBlocks//root/uncoreEvents/*"/>
          </xsl:if>
          <xsl:if test="$showWaitObjects='true'">
            <xsl:copy-of select="$summaryBlocks//root/waitObjects/*"/>
          </xsl:if>
          <xsl:if test="$showHWContextHistogram='true'">
            <xsl:copy-of select="$summaryBlocks//root/hwContextChart/*"/>
          </xsl:if>
          <xsl:if test="$showMemObjects='true' and exsl:ctx('analyzeMemoryObjects') = 'true'">
            <xsl:copy-of select="$summaryBlocks//root/memObjects/*"/>
          </xsl:if>
          <xsl:if test="$showLatencyChart='true'">
            <xsl:copy-of select="$summaryBlocks//root/latencyChart/*"/>
          </xsl:if>
          <xsl:if test="$showAbortCycles='true'">
            <xsl:copy-of select="$summaryBlocks//root/abortCyclesChart/*"/>
          </xsl:if>
          <xsl:if test="$showPower='true'">
            <xsl:copy-of select="$summaryBlocks//root/power/*"/>
          </xsl:if>
          <xsl:if test="$showISTP = 'true'">
            <xsl:copy-of select="$summaryBlocks//root/istp/*"/>
          </xsl:if>
          <xsl:if test="$showIstpPower = 'true'">
            <xsl:copy-of select="$summaryBlocks//root/istpPower/*"/>
          </xsl:if>
          <xsl:if test="$showBandwidth='true'">
            <xsl:copy-of select="$summaryBlocks//root/averageBandwidth/*"/>
          </xsl:if>
          <xsl:if test="$showAcceleratorOCL='true'">
            <xsl:copy-of select="$summaryBlocks//root/acceleratorOCL/*"/>
          </xsl:if>
          <xsl:if test="$showTasks='true'">
            <xsl:copy-of select="$summaryBlocks//root/tasks/*"/>
          </xsl:if>
          <xsl:if test="$showInterrupts='true' and exsl:is_non_empty_table_exist('interrupt_data')">
            <xsl:copy-of select="$summaryBlocks//root/interrupts/*"/>
          </xsl:if>
          <xsl:if test="$showThreadConcurrency='true'">
            <xsl:copy-of select="$summaryBlocks//root/threadConcurrency/*"/>
          </xsl:if>
          <xsl:if test="$showCPUUsage='true'">
            <xsl:choose>
              <xsl:when test="(not(exsl:ctx('useCountingMode', 0)) or $isRunssMode)">
                <section type="tree" expanded="true">
                  <header>
                    <xsl:choose>
                      <xsl:when test="exsl:ctx('PMU')='knl' or not(exsl:ctx('isHTEnabled', 1)) or ($isTmamSmtAware = 'false')">
                        <column>/AverageCPUUtilizationOpenMP</column>
                      </xsl:when>
                      <xsl:otherwise>
                        <column>/AveragePhysicalCPUUtilizationOpenMPSummaryString</column>
                      </xsl:otherwise>
                    </xsl:choose>
                  </header>
                  <tree valueAlign="left">
                    <xsl:choose>
                      <xsl:when test="$contextMode='false'">
                        <xsl:attribute name="valueAlign">right</xsl:attribute>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:attribute name="expandAll">true</xsl:attribute>
                      </xsl:otherwise>
                    </xsl:choose>
                    <columns>
                      <xsl:choose>
                        <xsl:when test="exsl:ctx('PMU')='knl' or not(exsl:ctx('isHTEnabled', 1)) or ($isTmamSmtAware = 'false')">
                          <column>/AverageCPUUsageOpenMPWithThreadConcurrency</column>
                        </xsl:when>
                        <xsl:otherwise>
                          <column>/AverageCPUUtilizationOpenMPBigCoresSummaryString</column>
                        </xsl:otherwise>
                      </xsl:choose>
                    </columns>
                  </tree>
                  <sections>
                    <xsl:copy-of select="$summaryBlocks//root/cpuUsageChart/*"/>
                  </sections>
                </section>
              </xsl:when>
              <xsl:otherwise>
                <section type="tree" expanded="true">
                  <header displayName="%CPUUtilization"/>
                  <tree valueAlign="right">
                   <columns>
                     <xsl:choose>
                       <xsl:when test="exsl:ctx('PMU')='knl' or not(exsl:ctx('isHTEnabled', 1)) or ($isTmamSmtAware = 'false')">
                          <column>/AverageCPUUtilizationCountingMode</column>
                        </xsl:when>
                        <xsl:otherwise>
                          <column>/AveragePhysicalCPUUtilizationCountingMode</column>
                          <column>/AverageLogicalCPUUtilizationCountingMode</column>
                        </xsl:otherwise>
                     </xsl:choose>
                   </columns>
                  </tree>
                </section>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <xsl:if test="$showOpenMP='true' and (exsl:ctx('openmpProcessCount') = 1)">
            <xsl:copy-of select="$summaryBlocks//root/regionCPUUsageChart/*"/>
          </xsl:if>
          <xsl:if test="$needToShowFrames">
            <xsl:copy-of select="$summaryBlocks//root/frameChart/*"/>
          </xsl:if>
          <xsl:if test="$showOpenMP='true' and exsl:is_non_empty_table_exist('region_data')">
            <xsl:copy-of select="$summaryBlocks//root/regionDurationChart/*"/>
          </xsl:if>
          <xsl:if test="$showTasks='true'">
            <xsl:copy-of select="$summaryBlocks//root/taskChart/*"/>
          </xsl:if>
          <xsl:if test="$showInterrupts='true'">
            <xsl:copy-of select="$summaryBlocks//root/interruptsChart/*"/>
          </xsl:if>
          <xsl:if test="$showIO='true'">
            <xsl:copy-of select="$summaryBlocks//root/ioChart/*"/>
          </xsl:if>
          <xsl:if test="$showAnomalyDetection='true'">
            <xsl:copy-of select="$summaryBlocks//root/anomalyRegionDurationChart/*"/>
          </xsl:if>
          <xsl:if test="$showPower='true'">
            <xsl:copy-of select="$summaryBlocks//root/powerChart/*"/>
          </xsl:if>
          <xsl:if test="$showResultInfo='true'">
            <xsl:copy-of select="$summaryBlocks//root/resultInfo/*"/>
          </xsl:if>
        </sections>
        <xsl:copy-of select="$summaryBlocks//root/messages"/>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
