<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:exsl="http://exslt.org/common">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id"/>
  <xsl:param name="displayName"/>
  <xsl:param name="description"/>
  <xsl:param name="globalEventAreaName"/>
  <xsl:param name="headerMode">regular</xsl:param>
  <xsl:param name="cpuDataQuery"/>
  <xsl:param name="samplePointsQuery">none</xsl:param>
  <xsl:param name="samplePointsTooltipQuery">none</xsl:param>
  <xsl:param name="samplePointsLayerName">none</xsl:param>
  <xsl:param name="cpuDataByThreadQuery">
    <xsl:value-of select="$cpuDataQuery"/>
  </xsl:param>
  <xsl:param name="cpuDataCumulativeQuery">
    <xsl:value-of select="$cpuDataQuery"/>
  </xsl:param>
  <xsl:param name="taskQuery">Task</xsl:param>
  <xsl:param name="helpKeyword"/>
  <xsl:param name="frameMode">frameSimple</xsl:param>
  <xsl:param name="contextSwitches">true</xsl:param>
  <xsl:param name="waits">false</xsl:param>
  <xsl:param name="gpu">false</xsl:param>
  <xsl:param name="tasksAndFrames">false</xsl:param>
  <xsl:param name="platform">
    <xsl:value-of select="$tasksAndFrames='true'"/>
  </xsl:param>
  <xsl:param name="openmpAnalysis">false</xsl:param>
  <xsl:param name="gpuCounters">off</xsl:param>
  <xsl:param name="visibleSeriesCount">-1</xsl:param>
  <xsl:param name="cpuOverheadAndSpinTimeQuery">none</xsl:param>
  <xsl:param name="cpuOverheadAndSpinTimeCumulativeQuery">none</xsl:param>
  <xsl:param name="sortByCPUData">false</xsl:param>
  <xsl:param name="rowByPrefix">PMU</xsl:param>
  <xsl:param name="rawEventCount">false</xsl:param>
  <xsl:param name="rawEventSampleCount">false</xsl:param>
  <xsl:param name="uncoreEvents">false</xsl:param>
  <xsl:param name="io">false</xsl:param>
  <xsl:param name="spdkio">false</xsl:param>
  <xsl:param name="dpdkio">false</xsl:param>
  <xsl:param name="pcie">false</xsl:param>
  <xsl:param name="pcieLegacy">false</xsl:param>
  <xsl:param name="fpga">false</xsl:param>
  <xsl:param name="cat">false</xsl:param>
  <xsl:param name="cpuUsageByCS">false</xsl:param>
  <xsl:param name="threadsLifetime">true</xsl:param>
  <xsl:param name="showAcceleratorOCL">false</xsl:param>
  <xsl:param name="iptData">false</xsl:param>
  <xsl:param name="rawIptData">false</xsl:param>
  <xsl:param name="packetsColorByVM">false</xsl:param>
  <xsl:param name="showCpuPerThread">true</xsl:param>
  <xsl:param name="packetsType">true</xsl:param>
  <xsl:param name="memoryConsumption">false</xsl:param>
  <xsl:param name="showOnlyGPUThreads">false</xsl:param>
  <xsl:param name="cpuGpuInteration">false</xsl:param>
  <xsl:param name="inKernelProfiling">false</xsl:param>
  <xsl:param name="showThreadArea">true</xsl:param>
  <xsl:variable name="showGlobalEvents" select="$rawEventSampleCount='false' and $rawEventCount='false' and $io='false' and $memoryConsumption='false'"/>
  <xsl:variable name="showSystemBandwidth" select="$tasksAndFrames='false'"/>
  <xsl:variable name="timelineBlocksParams">
    <params
      headerMode="{$headerMode}"
      packetsType="{$packetsType}"
      packetsColorByVM="{$packetsColorByVM}"
        />
  </xsl:variable>
  <xsl:variable name="timelineBlocksFileName">
    <xsl:text>config://viewpoint/include/timelineblocks.xsl?</xsl:text>
    <xsl:for-each select="exsl:node-set($timelineBlocksParams)//@*">
      <xsl:value-of select="concat(name(), '=', .)"/>
      <xsl:text>&amp;</xsl:text>
    </xsl:for-each>
  </xsl:variable>
  <xsl:variable name="timelineblocks" select="document($timelineBlocksFileName)"/>
  <xsl:variable name="gpuCfg" select="document('config://viewpoint/include/gpu.cfg')"/>
  <xsl:template match="/">
    <xsl:if test="not(exsl:is_compare_mode())">
      <html id="{$id}">
        <xsl:call-template name="paneAttributes"/>
        <application name="timeline"/>
        <filter handleList="selection,global"/>
        <event handleList="KnobChangedEvent"/>
        <additionalParams boolean:showInDiff="false"/>
        <config>
          <xsl:call-template name="config"/>
        </config>
      </html>
    </xsl:if>
  </xsl:template>
  <xsl:template name="paneAttributes">
    <xsl:attribute name="displayName">
      <xsl:choose>
        <xsl:when test="$tasksAndFrames">%PlatformTimelineWindow</xsl:when>
        <xsl:otherwise>
          %<xsl:value-of select="$displayName"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <helpKeywordF1>
      <xsl:choose>
        <xsl:when test="$tasksAndFrames">intel.phe.configs.platform_view_f1179</xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$helpKeyword"/>
        </xsl:otherwise>
      </xsl:choose>
    </helpKeywordF1>
    <description>
      <xsl:choose>
        <xsl:when test="$tasksAndFrames">%PlatformTimelineWindowDescription</xsl:when>
        <xsl:otherwise>
          <xsl:text>%</xsl:text>
          <xsl:value-of select="$description"/>
        </xsl:otherwise>
      </xsl:choose>
    </description>
    <icon file="client.dat#zip:images.xrc" image="tab_timeline"/>
  </xsl:template>
  <xsl:template name="config">
    <xsl:variable name="isGPUComputeJoinRequired" select="$tasksAndFrames='false' or $platform='true'"/>
    <xsl:variable name="gpuComputeJoinRowByNumber">
      <xsl:choose>
        <xsl:when test="$isGPUComputeJoinRequired='true'">1</xsl:when>
        <xsl:otherwise>0</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="isGPUJoinRequired" select="($gpu='true') or ($platform='true')"/>
    <xsl:variable name="isTaskHierarchical" select="($isGPUJoinRequired='true') or ($tasksAndFrames='true')"/>
    <xsl:variable name="gpuJoinRowByNumber">
      <xsl:choose>
        <xsl:when test="$isGPUJoinRequired='true'">
          <xsl:value-of select="$gpuComputeJoinRowByNumber+1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$gpuComputeJoinRowByNumber"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="isRegionRowByJoinRequied" select="exsl:is_non_empty_table_exist('dd_region')"/>
    <xsl:variable name="regionJoinRowByNumber">
      <xsl:choose>
        <xsl:when test="$isRegionRowByJoinRequied='true'">
          <xsl:value-of select="$gpuJoinRowByNumber+1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$gpuJoinRowByNumber"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="isBarrierRowByJoinRequired" select="exsl:is_non_empty_table_exist('dd_barrier')"/>
    <xsl:variable name="barrierJoinRowByNumber">
      <xsl:choose>
        <xsl:when test="$isBarrierRowByJoinRequired='true'">
          <xsl:value-of select="$regionJoinRowByNumber+1"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$regionJoinRowByNumber"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="preciseClockticsCollected" select="exsl:ctx('collectPreciseClockticks')"/>
    <ruler>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='mark']/configRulerLayers/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id=$frameMode]/configRulerLayers/*"/>
    </ruler>
    <xsl:copy-of select="$timelineblocks//bag/config[@id=$frameMode]/configAreas/*"/>
    <xsl:if test="$platform='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='GPUQueueArea']/*"/>
      <xsl:copy-of select="$gpuCfg//graphicsTimelineBottom/area[@id='computing_queue']"/>
    </xsl:if>
    <area headerMode="{$headerMode}" id="metrics_by_object">
      <rowSet>
        <rowBy>
          <vectorQueryInsert>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$rowByPrefix"/>
            <xsl:text>TimelineRowBy</xsl:text>
          </vectorQueryInsert>
          <xsl:choose>
            <xsl:when test="$isGPUJoinRequired='true'">
              <sort>
                <queryRef>/GPUDXTime</queryRef>
              </sort>
            </xsl:when>
            <xsl:when test="$sortByCPUData='true'">
              <sort>
                <xsl:choose>
                  <xsl:when test="$preciseClockticsCollected">
                    <queryRef>/PreciseClockticks</queryRef>
                  </xsl:when>
                  <xsl:otherwise>
                    <queryRef>
                      <xsl:text>/</xsl:text>
                      <xsl:value-of select="$cpuDataQuery"/>
                    </queryRef>
                  </xsl:otherwise>
                </xsl:choose>
              </sort>
            </xsl:when>
          </xsl:choose>
        </rowBy>
        <columnBy>
            <xsl:choose>
              <xsl:when test="$showOnlyGPUThreads='true'">
                <queryRef>/GPUDXTime</queryRef>
                <queryRef>/GPUComputeTaskTimeGPUName</queryRef>
                <queryRef>/TaskTime</queryRef>
              </xsl:when>
              <xsl:otherwise>
                <xsl:if test="$cpuDataQuery">
                  <queryRef>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$cpuDataQuery"/>
                  </queryRef>
                </xsl:if>
                <queryRef>/PreciseClockticks</queryRef>
                <xsl:if test="$rowByPrefix">
                  <queryRef>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$rowByPrefix"/>
                    <xsl:text>UserTime</xsl:text>
                  </queryRef>
                </xsl:if>
                <xsl:if test="$waits='true'">
                  <queryRef>/WaitTime</queryRef>
                </xsl:if>
                <queryRef>/TaskTime</queryRef>
                <queryRef>/CounterMetrics</queryRef>
                <queryRef>/GPUComputeTaskTimeGPUName</queryRef>
                <queryRef>/GPUDXTime</queryRef>
                <queryRef>/RegionTime</queryRef>
                <queryRef>/BarrierInstanceCount</queryRef>
                <queryRef>/SchedTime</queryRef>
                <queryRef>/ContextSwitchCount</queryRef>
                <queryRef>/FPGAComputeTaskTime</queryRef>
              </xsl:otherwise>
            </xsl:choose>
        </columnBy>
          <xsl:if test="$showOnlyGPUThreads='false'">
        <queryMode>allRows</queryMode>
          </xsl:if>
        <xsl:if test="$threadsLifetime='true'">
          <layer>
            <drawBy>
              <queryRef>/ThreadLifeTime</queryRef>
            </drawBy>
          </layer>
        </xsl:if>
        <xsl:if test="$waits='true'">
          <layer type="RowInterval" visibleOnLevels="Thread">
            <drawBy>
              <queryRef>/Waits</queryRef>
            </drawBy>
            <tooltipBy>
              <queryRef>/WaitSyncObj</queryRef>
              <queryRef>/WaitSourceFile</queryRef>
              <queryRef>/WaitSourceLine</queryRef>
              <queryRef>/WaitSignalSourceFile</queryRef>
              <queryRef>/WaitSignalSourceLine</queryRef>
            </tooltipBy>
            <diveBy>
              <queryRef>/WaitCS</queryRef>
            </diveBy>
          </layer>
        </xsl:if>
        <xsl:if test="$contextSwitches='true'">
          <layer type="RowInterval" visibleOnLevels="Thread" boolean:showColoringAsLegendItems="true">
            <drawBy>
              <queryRef>/ContextSwitches</queryRef>
            </drawBy>
            <xsl:if test="not(exsl:ctx('hideContextSwitchesType',0))">
              <colorBy>
                <queryRef>/ContextSwitchReason</queryRef>
              </colorBy>
            </xsl:if>
            <tooltipBy>
              <queryRef>/ContextSwitchCpu</queryRef>
              <xsl:if test="not(exsl:ctx('hideContextSwitchesType',0))">
                <queryRef>/ContextSwitchReason</queryRef>
              </xsl:if>
              <queryRef>/ContextSwitchSourceFile</queryRef>
              <queryRef>/ContextSwitchSourceLine</queryRef>
            </tooltipBy>
            <diveBy>
              <queryRef>/ContextSwitchCS</queryRef>
            </diveBy>
          </layer>
        </xsl:if>
        <xsl:if test="$showCpuPerThread='true'">
          <layer>
            <xsl:attribute name="visibleSeriesCount">
              <xsl:value-of select="$visibleSeriesCount"/>
            </xsl:attribute>
            <xsl:attribute name="boolean:visible">
              <xsl:value-of select="not($preciseClockticsCollected)"/>
            </xsl:attribute>
            <xsl:if test="$cpuOverheadAndSpinTimeQuery!='none'">
              <xsl:attribute name="boolean:scaleGroupStart">true</xsl:attribute>
            </xsl:if>
            <drawBy>
              <xsl:if test="$cpuDataQuery">
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$cpuDataByThreadQuery"/>
                </queryRef>
              </xsl:if>
            </drawBy>
          </layer>
        </xsl:if>
        <xsl:if test="$cat='true'">
          <xsl:if test="exsl:ctx('isL3CATAvailable', '')='true'">
            <layer boolean:visible="false">
              <drawBy>
                <queryRef>/L3CATPercentageAvailability</queryRef>
              </drawBy>
            </layer>
          </xsl:if>
          <xsl:if test="exsl:ctx('isL2CATAvailable', '')='true'">
            <layer boolean:visible="false">
              <drawBy>
                <queryRef>/L2CATPercentageAvailability</queryRef>
              </drawBy>
            </layer>
          </xsl:if>
        </xsl:if>
        <xsl:if test="$cpuOverheadAndSpinTimeQuery!='none'">
          <layer>
            <xsl:attribute name="boolean:visible">
              <xsl:value-of select="not($preciseClockticsCollected)"/>
            </xsl:attribute>
            <drawBy>
              <queryRef>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$cpuOverheadAndSpinTimeQuery"/>
              </queryRef>
            </drawBy>
          </layer>
          <layer displayModes="rich,regular" boolean:scaleGroupEnd="true">
            <xsl:attribute name="boolean:visible">
              <xsl:value-of select="not($preciseClockticsCollected)"/>
            </xsl:attribute>
            <drawBy>
              <queryRef>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$rowByPrefix"/>
                <xsl:text>SpinBusyWaitOnMPISpinningTimeForTimeline</xsl:text>
              </queryRef>
            </drawBy>
          </layer>
          <layer displayModes="super_tiny">
            <drawBy>
              <queryRef>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$rowByPrefix"/>
                <xsl:text>UserTime</xsl:text>
              </queryRef>
            </drawBy>
          </layer>
          <layer displayModes="super_tiny" boolean:visible="false">
            <drawBy>
              <queryRef>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$rowByPrefix"/>
                <xsl:text>OverheadAndSpinTime</xsl:text>
              </queryRef>
            </drawBy>
          </layer>
          <layer displayModes="super_tiny">
            <drawBy>
              <queryRef>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$rowByPrefix"/>
                <xsl:text>SpinBusyWaitOnMPISpinningTimeForTimeline</xsl:text>
              </queryRef>
            </drawBy>
          </layer>
        </xsl:if>
        <layer>
          <xsl:attribute name="boolean:visible">
            <xsl:value-of select="$preciseClockticsCollected"/>
          </xsl:attribute>
          <drawBy>
            <queryRef>/PreciseClockticks</queryRef>
          </drawBy>
        </layer>
        <xsl:if test="$samplePointsQuery!='none'">
          <layer type="EventMarker" boolean:visible="false">
            <xsl:if test="$samplePointsLayerName!='none'">
              <xsl:attribute name="displayName">
                <xsl:value-of select="concat('%',$samplePointsLayerName)"/>
              </xsl:attribute>
            </xsl:if>
            <drawBy>
              <queryRef>
                <xsl:text>/</xsl:text>
                <xsl:value-of select="$samplePointsQuery"/>
              </queryRef>
            </drawBy>
            <xsl:if test="$samplePointsTooltipQuery!='none'">
              <tooltipBy>
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$samplePointsTooltipQuery"/>
                </queryRef>
              </tooltipBy>
            </xsl:if>
          </layer>
        </xsl:if>
        <xsl:if test="$isGPUJoinRequired='true'">
          <layer type="InstanceCountOverTime">
            <drawBy>
              <instanceCountQuery>
                <queryInherit>/GPUUsageForGridRow</queryInherit>
                <maxEval>exsl:ctx('logicalGPUCount', 0) + 1</maxEval>
              </instanceCountQuery>
            </drawBy>
          </layer>
        </xsl:if>
        <xsl:copy-of select="$timelineblocks//bag/config[@id='counters']/*"/>
        <layer visibleOnLevels="Thread" boolean:showText="true">
          <xsl:if test="$showAcceleratorOCL='true'">
            <xsl:attribute name="type">RowIntervalNested</xsl:attribute>
          </xsl:if>
          <drawBy>
            <queryRef>
              <xsl:choose>
                <xsl:when test="$isTaskHierarchical='true'">
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$taskQuery"/>
                  <xsl:text>Hierarchical</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$taskQuery"/>
                </xsl:otherwise>
              </xsl:choose>
            </queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$taskQuery"/>
              <xsl:text>Type</xsl:text>
            </queryRef>
            <queryRef>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$taskQuery"/>
              <xsl:text>DurationType</xsl:text>
            </queryRef>
            <queryRef>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$taskQuery"/>
              <xsl:text>EndCallStack</xsl:text>
            </queryRef>
          </tooltipBy>
          <colorBy>
            <queryRef>/TaskType</queryRef>
          </colorBy>
          <highlightBy int:groupId="3">
            <queryRef>/TaskGroupKey</queryRef>
          </highlightBy>
        </layer>
        <layer type="EventMarker" visibleOnLevels="Thread" boolean:visible="false">
          <drawBy>
            <queryRef>/SlowTaskMarker/TaskDurationType[%SlowTask]</queryRef>
          </drawBy>
        </layer>
        <xsl:if test="$dpdkio='true'">
          <layer visibleOnLevels="Thread">
            <drawBy>
              <queryRef>/DpdkRxSpinTime</queryRef>
            </drawBy>
          </layer>
          <layer visibleOnLevels="Thread">
            <drawBy>
              <queryRef>/DpdkDequeueSpinTime</queryRef>
            </drawBy>
          </layer>
        </xsl:if>
        <xsl:if test="$spdkio='true'">
          <layer visibleOnLevels="Thread">
            <drawBy>
              <queryRef>/SpdkIoEffectiveTime</queryRef>
            </drawBy>
          </layer>
          <layer visibleOnLevels="Thread" boolean:allowToHideSeries="true" boolean:showColoringAsLegendItems="true">
            <drawBy>
              <queryRef>/SpdkIoOperation/SpdkIOBinValueType</queryRef>
            </drawBy>
            <colorBy>
              <queryRef>/SpdkIOBinValueType</queryRef>
            </colorBy>
          </layer>
          <layer visibleOnLevels="Thread" boolean:allowToHideSeries="true" boolean:visible="false" boolean:showColoringAsLegendItems="true">
            <drawBy>
              <queryRef>/SpdkIoOperationLatency/SpdkIOLatencyBinValueType</queryRef>
            </drawBy>
            <colorBy>
              <queryRef>/SpdkIOLatencyBinValueType</queryRef>
            </colorBy>
          </layer>
        </xsl:if>
        <layer type="Transition" boolean:visible="false" visibleOnLevels="Thread">
          <drawBy>
            <queryRef>/TaskTransition</queryRef>
          </drawBy>
        </layer>
        <xsl:if test="$waits='true'">
          <layer type="Transition" boolean:visible="false" visibleOnLevels="Thread">
            <drawBy>
              <queryRef>/Transitions</queryRef>
            </drawBy>
            <tooltipBy>
              <queryRef>/WaitSyncObj</queryRef>
              <queryRef>/WaitsSourceFile</queryRef>
              <queryRef>/WaitsSourceLine</queryRef>
              <queryRef>/WaitSignalSourceFile</queryRef>
              <queryRef>/WaitSignalSourceLine</queryRef>
            </tooltipBy>
            <diveBy>
              <queryRef>/WaitSignalCS</queryRef>
            </diveBy>
          </layer>
        </xsl:if>
        <xsl:if test="$isGPUComputeJoinRequired='true'">
          <layer visibleOnLevels="GPUComputeSubmitThread">
            <drawBy>
              <queryRef>/GPUComputeTask</queryRef>
            </drawBy>
            <tooltipBy>
              <queryRef>/GPUComputeTask</queryRef>
              <queryRef>/GPUComputeTaskPurposeShortName</queryRef>
              <queryRef>/GPUComputeGlobalDim</queryRef>
              <queryRef>/GPUComputeLocalDim</queryRef>
              <queryRef>/GPUComputeSimdWidth</queryRef>
            </tooltipBy>
            <highlightBy int:groupId="2">
              <queryRef>/GPUComputeTask</queryRef>
            </highlightBy>
            <hatchBy>
              <queryRef>/GPUComputeTaskPurpose</queryRef>
            </hatchBy>
          </layer>
        </xsl:if>
        <xsl:if test="$showAcceleratorOCL='true'">
          <layer>
            <drawBy>
              <queryRef>/FPGAComputeTask</queryRef>
            </drawBy>
            <tooltipBy>
              <queryRef>/FPGAComputeTask</queryRef>
              <queryRef>/FPGAComputeTaskPurposeShortName</queryRef>
              <queryRef>/FPGAComputeGlobalDim</queryRef>
              <queryRef>/FPGAComputeLocalDim</queryRef>
              <queryRef>/FPGAComputeSimdWidth</queryRef>
            </tooltipBy>
          </layer>
        </xsl:if>
        <xsl:if test="$isRegionRowByJoinRequied='true'">
          <layer visibleOnLevels="Process" type="EventMarker">
            <drawBy>
              <queryRef>/Region</queryRef>
            </drawBy>
            <colorBy>
              <queryRef>/RegionDomain</queryRef>
            </colorBy>
            <tooltipBy>
              <queryRef>/RegionDomain</queryRef>
              <queryRef>/RegionType</queryRef>
            </tooltipBy>
          </layer>
        </xsl:if>
        <xsl:if test="$isBarrierRowByJoinRequired='true'">
          <layer visibleOnLevels="Process,BarrierProcess" type="EventMarker" boolean:visible="false">
            <drawBy>
              <queryRef>/Barrier</queryRef>
            </drawBy>
            <colorBy>
              <queryRef>/BarrierDomain</queryRef>
            </colorBy>
            <tooltipBy>
              <queryRef>/BarrierDomain</queryRef>
            </tooltipBy>
          </layer>
        </xsl:if>
        <xsl:if test ="$iptData='true'">
          <layer>
            <drawBy>
              <queryRef>/IptRegion</queryRef>
            </drawBy>
          </layer>
          <layer>
            <drawBy>
              <queryRef>/CbrFrequency</queryRef>
            </drawBy>
          </layer>
        </xsl:if>
        <xsl:if test ="$rawIptData='true'">
          <layer>
            <drawBy>
              <queryRef>/RawIptRegion</queryRef>
            </drawBy>
          </layer>
          <layer>
            <drawBy>
              <queryRef>/RawCbrFrequency</queryRef>
            </drawBy>
          </layer>
        </xsl:if>
      </rowSet>
    </area>
    <xsl:copy-of select="$timelineblocks//bag/config[@id='ParallelFsReadWriteBytesArea']/*"/>
    <xsl:copy-of select="$timelineblocks//bag/config[@id='ParallelFsSumSamplesCountArea']/*"/>
    <xsl:if test="$showAcceleratorOCL='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='FPGAComputingTaskUtilizationArea']/*"/>
    </xsl:if>
    <xsl:if test="$cpuUsageByCS='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='cpuUsageByCSArea']/*"/>
    </xsl:if>
    <xsl:if test="$rawEventCount='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='rawEventCountArea']/*"/>
    </xsl:if>
    <xsl:if test="$rawEventSampleCount='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='rawEventSampleCountArea']/*"/>
    </xsl:if>
    <xsl:if test="$gpu!='true' or $platform='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='globalCounters']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='deviceCounters']/*"/>
    </xsl:if>
    <xsl:copy-of select="$timelineblocks//bag/config[@id='FPGA_Device_Metrics']/*"/>
    <xsl:if test="$fpga='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='FPGA_QPI_BandwidthArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='FPGA_PCIE_BandwidthArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='FPGARatiosArea']/*"/>
    </xsl:if>
    <xsl:if test="$cpuGpuInteration!='true' or exsl:ctx('gpuHwCollection', 0)">
        <xsl:copy-of select="$gpuCfg//graphicsTimelineCommonBasic/*"/>
        <xsl:copy-of select="$gpuCfg//cpugpuInteractionTimeline/*"/>
    </xsl:if>
    <xsl:if test="$cpuGpuInteration!='true'and $platform='false'">
        <xsl:copy-of select="$gpuCfg//graphicsTimelineCommon/*"/>
        <xsl:copy-of select="$gpuCfg//graphicsTimelineOverview/*"/>
        <xsl:copy-of select="$gpuCfg//graphicsTimelineComputeBasic/*"/>
        <xsl:copy-of select="$gpuCfg//graphicsTimelineComputeExtended/*"/>
      <xsl:if test="$inKernelProfiling!='true'">
        <xsl:copy-of select="$gpuCfg//graphicsTimelineBottom/*"/>
      </xsl:if>
    </xsl:if>
    <xsl:if test="$tasksAndFrames='false' or $platform='true'">
      <xsl:choose>
        <xsl:when test="exsl:is_non_empty_table_exist('dma_packet_data')">
          <xsl:copy-of select="$gpuCfg//timeline/*"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="$gpuCfg//timelineNoPackets/*"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="$showGlobalEvents='true'">
      <area>
        <rowSet displayName="%{$globalEventAreaName}">
          <layer>
            <xsl:attribute name="visibleSeriesCount">
              <xsl:value-of select="$visibleSeriesCount"/>
            </xsl:attribute>
            <xsl:attribute name="boolean:visible">
              <xsl:value-of select="not($preciseClockticsCollected)"/>
            </xsl:attribute>
            <drawBy>
              <xsl:if test="$cpuDataQuery">
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$cpuDataCumulativeQuery"/>
                </queryRef>
              </xsl:if>
            </drawBy>
          </layer>
          <xsl:if test="$cpuOverheadAndSpinTimeCumulativeQuery!='none'">
            <layer>
              <xsl:attribute name="boolean:visible">
                <xsl:value-of select="not($preciseClockticsCollected)"/>
              </xsl:attribute>
              <drawBy>
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$cpuOverheadAndSpinTimeCumulativeQuery"/>
                </queryRef>
              </drawBy>
            </layer>
            <layer>
              <xsl:attribute name="boolean:visible">
                <xsl:value-of select="not($preciseClockticsCollected)"/>
              </xsl:attribute>
              <drawBy>
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$rowByPrefix"/>
                  <xsl:text>SpinBusyWaitOnMPISpinningTimeGlobal</xsl:text>
                </queryRef>
              </drawBy>
            </layer>
          </xsl:if>
          <layer>
            <drawBy>
              <queryRef>/CPUGPUConcurrency</queryRef>
            </drawBy>
          </layer>
          <layer>
            <xsl:attribute name="boolean:visible">
              <xsl:value-of select="$preciseClockticsCollected"/>
            </xsl:attribute>
            <drawBy>
              <queryRef>/PreciseClockticks</queryRef>
            </drawBy>
          </layer>
        </rowSet>
      </area>
    </xsl:if>
    <xsl:if test="$uncoreEvents='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='uncoreEvents']/*"/>
    </xsl:if>
    <xsl:if test="$pcieLegacy='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='legacyPCIeBandwidthArea']/*"/>
    </xsl:if>
    <xsl:if test="$pcie='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='InboundPCIeBandwidthArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='OutboundPCIeBandwidthArea']/*"/>
    </xsl:if>
    <xsl:copy-of select="$timelineblocks//bag/config[@id='eDRAMBandwidthTimeline']/*"/>
    <xsl:choose>
      <xsl:when test="$platform='true' or $openmpAnalysis='true' or $gpu='true'">
        <xsl:copy-of select="$timelineblocks//bag/config[@id='bandwidthTimelineAreas']/*"/>
        <xsl:if test="$showAcceleratorOCL!='true'">
          <xsl:copy-of select="$timelineblocks//bag/config[@id='QPIBandwidthTimeline']/*"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="$showSystemBandwidth='true'">
        <xsl:copy-of select="$timelineblocks//bag/config[@id='SystemBandwidthArea']/*"/>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="$io='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='spdkGlobalCounters']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='IOQueueDepthArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='PageFaultStatArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='IOOperationArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='IOBytesArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='IOThroughputArea']/*"/>
    </xsl:if>
    <xsl:if test="$spdkio='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='spdkIoArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='spdkIoBytesArea']/*"/>
    </xsl:if>
    <xsl:if test="$io='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='CPUIoStatePercentageArea']/*"/>
    </xsl:if>
    <xsl:if test="$platform='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='aperfMperfFreq']/*"/>
    </xsl:if>
    <xsl:copy-of select="$gpuCfg//gpuCoreFrequency/*"/>
    <xsl:if test="$tasksAndFrames='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='PStateArea']/*"/>
      <xsl:copy-of select="$timelineblocks//bag/config[@id='CStateArea']/*"/>
    </xsl:if>
    <xsl:if test="$memoryConsumption='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='memoryConsumption']/*"/>
    </xsl:if>
    <xsl:if test="$tasksAndFrames='true'">
      <xsl:copy-of select="$timelineblocks//bag/config[@id='energyConsumption']/*"/>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
