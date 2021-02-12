<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  xmlns:exsl="http://exslt.org/common"
  syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="headerMode">regular</xsl:param>
  <xsl:param name="packetsType">true</xsl:param>
  <xsl:param name="packetsColorByVM">false</xsl:param>
  <xsl:param name="showIODevice">true</xsl:param>
  <xsl:template match="/">
  <bag>
  <config id="mark">
    <configRulerLayers>
      <layer>
        <drawBy>
          <queryRef>/MarksGlobal</queryRef>
        </drawBy>
      </layer>
      <layer type="GlobalCrossLine" boolean:visible="false">
        <drawBy>
          <queryRef>/VSync</queryRef>
        </drawBy>
      </layer>
    </configRulerLayers>
  </config>
  <config id="frameSimple">
    <configRulerLayers>
      <layer>
        <drawBy>
          <queryRef>/Frame</queryRef>
        </drawBy>
        <colorBy>
          <queryRef>/FrameDomain</queryRef>
        </colorBy>
        <tooltipBy>
          <queryRef>/Frame</queryRef>
          <queryRef>/FrameDomain</queryRef>
          <queryRef>/FrameType</queryRef>
          <queryRef>/FrameRate</queryRef>
        </tooltipBy>
      </layer>
      <layer>
        <drawBy>
          <queryRef>/RegionGlobal</queryRef>
        </drawBy>
        <colorBy>
          <queryRef>/RegionDomain</queryRef>
        </colorBy>
        <tooltipBy>
          <queryRef>/RegionDomain</queryRef>
          <queryRef>/RegionType</queryRef>
        </tooltipBy>
      </layer>
      <layer boolean:visible="false">
        <drawBy>
          <queryRef>/BarrierGlobal</queryRef>
        </drawBy>
        <colorBy>
          <queryRef>/BarrierDomain</queryRef>
        </colorBy>
        <tooltipBy>
          <queryRef>/BarrierDomain</queryRef>
        </tooltipBy>
      </layer>
    </configRulerLayers>
    <configAreas>
      <area>
        <rowSet displayName="%FramesOverTime">
          <layer>
            <drawBy>
              <queryRef>/FrameRate</queryRef>
            </drawBy>
          </layer>
        </rowSet>
      </area>
    </configAreas>
  </config>
  <config id="frameSimpleNoRegions">
    <configRulerLayers>
      <layer>
        <drawBy>
          <queryRef>/Frame</queryRef>
        </drawBy>
        <colorBy>
          <queryRef>/FrameDomain</queryRef>
        </colorBy>
        <tooltipBy>
          <queryRef>/Frame</queryRef>
          <queryRef>/FrameDomain</queryRef>
          <queryRef>/FrameType</queryRef>
          <queryRef>/FrameRate</queryRef>
        </tooltipBy>
      </layer>
    </configRulerLayers>
    <configAreas>
      <area>
        <rowSet displayName="%FramesOverTime">
          <layer>
            <drawBy>
              <queryRef>/FrameRate</queryRef>
            </drawBy>
          </layer>
        </rowSet>
      </area>
    </configAreas>
  </config>
  <config id="frameDetailed">
    <configAreas>
      <area sizeMode="rowLimit" id="frames">
        <rowSet displayName="%FramesOverTime">
          <rowBy>
            <queryRef>/FrameDomain</queryRef>
          </rowBy>
          <columnBy>
            <queryRef>/FrameTime</queryRef>
          </columnBy>
          <layer type="Overtime">
            <drawBy>
              <queryRef>/FrameRate</queryRef>
            </drawBy>
          </layer>
          <layer type="EventMarker">
            <drawBy>
              <queryRef>/Frame</queryRef>
            </drawBy>
            <colorBy>
              <queryRef>/Frame</queryRef>
            </colorBy>
            <tooltipBy>
              <queryRef>/Frame</queryRef>
              <queryRef>/FrameType</queryRef>
              <queryRef>/FrameRate</queryRef>
            </tooltipBy>
          </layer>
        </rowSet>
      </area>
    </configAreas>
  </config>
  <config id="counters">
     <layer visibleSeriesCount="1" boolean:seriesGroupStart="true">
      <drawBy>
       <queryRef>/CounterMetrics/CounterType</queryRef>
      </drawBy>
     </layer>
     <layer visibleSeriesCount="1" boolean:seriesGroupEnd="true">
      <drawBy>
       <queryRef>/ThreadInstantValue/ThreadInstantValuesType</queryRef>
      </drawBy>
     </layer>
  </config>
  <config id="globalCounters">
    <area headerMode="" id="threads_cumulative_metrics" boolean:visible="false">
      <rowSet displayName="%CounterCount">
        <rowBy>
          <queryRef>/GenericCounterType</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/CounterMetricsNamedAsCounterRate</queryRef>
          <queryRef>/ThreadInstantValueCount</queryRef>
        </columnBy>
        <layer type="Overtime">
          <drawBy>
            <queryRef>/CounterMetricsNamedAsCounterRate</queryRef>
          </drawBy>
        </layer>
        <layer type="Overtime">
          <drawBy>
            <queryRef>/ThreadInstantValue</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
    <area id="global">
      <rowSet displayName="%GlobalCountersArea">
        <rowBy>
          <queryRef>/GenericCounterType</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/GlobalCounterMetrics</queryRef>
          <queryRef>/GlobalInstantValueCount</queryRef>
        </columnBy>
        <layer type="Overtime">
          <drawBy>
            <queryRef>/GlobalCounterMetrics</queryRef>
          </drawBy>
        </layer>
        <layer type="Overtime">
          <drawBy>
            <queryRef>/GlobalInstantValue</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="spdkGlobalCounters">
      <area id="global">
        <rowSet displayName="bdev_io_pool">
        <layer type="Overtime">
          <drawBy>
            <queryRef>/GlobalInstantValue/GlobalInstantValuesType[bdev_io_pool]</queryRef>
            <displayAttributes>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        </rowSet>
      </area>
      <area id="global">
        <rowSet displayName="buf_small_pool">
        <layer type="Overtime">
          <drawBy>
            <queryRef>/GlobalInstantValue/GlobalInstantValuesType[buf_small_pool]</queryRef>
            <displayAttributes>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        </rowSet>
      </area>
      <area id="global">
        <rowSet displayName="buf_large_pool">
        <layer type="Overtime">
          <drawBy>
            <queryRef>/GlobalInstantValue/GlobalInstantValuesType[buf_large_pool]</queryRef>
            <displayAttributes>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        </rowSet>
    </area>
  </config>
  <config id="deviceCounters">
    <area id="device_counters">
      <rowSet displayName="%DeviceDataArea">
        <rowBy>
          <queryRef>/CounterDeviceRecursive</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/DeviceTimeCounter</queryRef>
          <queryRef>/DeviceCounterCount</queryRef>
          <queryRef>/DeviceInstantValueCount</queryRef>
          <queryRef>/DeviceTaskCount</queryRef>
        </columnBy>
        <layer visibleSeriesCount="1" boolean:seriesGroupStart="true">
          <drawBy>
            <queryRef>/DeviceTimeCounter/DeviceTimeCounterType</queryRef>
          </drawBy>
        </layer>
        <layer visibleSeriesCount="1">
          <drawBy>
            <queryRef>/DeviceInstantValue/DeviceInstantValuesType</queryRef>
          </drawBy>
        </layer>
        <layer visibleSeriesCount="1" boolean:seriesGroupEnd="true">
          <drawBy>
            <queryRef>/DeviceCounterCount/DeviceCounterType</queryRef>
          </drawBy>
        </layer>
        <layer boolean:showText="true">
          <drawBy>
            <queryRef>/DeviceTask</queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>/DeviceTaskType</queryRef>
          </tooltipBy>
          <colorBy>
            <queryRef>/DeviceTaskType</queryRef>
          </colorBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="uncoreEvents">
    <area id="uncore_event">
      <rowSet displayName="%UncoreEvent">
        <rowBy>
          <queryRef>/UncoreEventType/UncorePackage</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/UncoreEventCount</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/UncoreEventCount</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="istpPState">
    <area headerMode="rich" boolean:maxLabels="true" id="phys_core">
      <rowSet displayName="%PhysCoresArea">
        <rowBy>
          <queryRef>/IstpCore</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/IstpVCoreSchedCount</queryRef>
          <queryRef>/IstpVCoreFreqCount</queryRef>
        </columnBy>
        <layer type="Overtime">
          <drawBy>
            <queryRef>/IstpFrequency</queryRef>
          </drawBy>
        </layer>
        <layer type="RowIntervalNested">
          <drawBy>
            <queryRef>/IstpVCoreSched</queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>/IstpVCoreSched</queryRef>
          </tooltipBy>
          <colorBy>
            <queryRef>/IstpVCoreSched</queryRef>
          </colorBy>
        </layer>
        <layer type="EventMarker">
          <drawBy>
            <queryRef>/IstpInterruptArrival</queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>/IstpInterruptArrival</queryRef>
          </tooltipBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="istpPower">
    <area id="istp_c_states" headerMode="rich">
      <rowSet displayName="%CPUSleepStatesWindow">
        <rowBy>
          <queryRef>/GenericIstpHwModule/IstpLocation</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/IstpModuleStateTime</queryRef>
          <queryRef>/IstpCStateTime</queryRef>
          <queryRef>/IstpSStateTime</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/IstpModuleStateTime/IstpMState</queryRef>
          </drawBy>
          <colorBy>
            <queryRef>/IstpMState</queryRef>
          </colorBy>
        </layer>
        <layer boolean:showText="true" visibleOnLevels="IstpHwModule">
          <drawBy>
            <queryRef>/IstpMStateWakeUpObject/IstpMState[MC0]</queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>/IstpMStateWakeUpObject</queryRef>
            <queryRef>/IstpMState</queryRef>
          </tooltipBy>
          <colorBy>
            <queryRef>/IstpMStateWakeUpObject</queryRef>
          </colorBy>
        </layer>
        <layer visibleOnLevels="IstpLocation">
          <drawBy>
            <queryRef>/IstpCStateTime/IstpCState</queryRef>
          </drawBy>
          <colorBy>
            <queryRef>/IstpCState</queryRef>
          </colorBy>
        </layer>
        <layer boolean:showText="true" visibleOnLevels="IstpLocation">
          <drawBy>
            <queryRef>/IstpCStateWakeUpObject</queryRef>
            <displayAttributes>
              <timelineFormat>hierarchical</timelineFormat>
            </displayAttributes>
          </drawBy>
          <tooltipBy>
            <queryRef>/IstpCStateWakeUpObject</queryRef>
            <queryRef>/IstpCState</queryRef>
          </tooltipBy>
          <colorBy>
            <queryRef>/IstpCStateWakeUpObject</queryRef>
          </colorBy>
        </layer>
      </rowSet>
    </area>
    <area id="istp_s_states" headerMode="rich">
      <rowSet displayName="%SStateWindow">
        <rowBy>
          <queryRef>/GenericIstpContext</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/IstpSStateTime</queryRef>
          <queryRef>/IstpCStateTime</queryRef>
          <queryRef>/SleepBlockerInstanceCount</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/IstpSStateTime/IstpSState</queryRef>
          </drawBy>
          <colorBy>
            <queryRef>/IstpSState</queryRef>
          </colorBy>
        </layer>
        <layer  boolean:showText="true" >
          <drawBy>
            <queryRef>/IstpSStateWakeUpObject/IstpSState[S0]</queryRef>
            <displayAttributes>
              <timelineFormat>hierarchical</timelineFormat>
            </displayAttributes>
          </drawBy>
          <colorBy>
            <queryRef>/IstpSStateWakeUpObject</queryRef>
          </colorBy>
          <tooltipBy>
            <queryRef>/IstpSStateWakeUpObject</queryRef>
          </tooltipBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/SleepBlocker</queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>/SleepBlocker</queryRef>
          </tooltipBy>
          <colorBy>
            <queryRef>/SleepBlocker</queryRef>
          </colorBy>
        </layer>
      </rowSet>
     </area>
  </config>
  <config id="eDRAMBandwidthTimeline">
    <area headerMode="rich" boolean:showYScale="true">
      <rowSet displayName="%eDRAMBandwidth">
        <rowBy>
          <queryRef>/UncorePackage</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/UncoreEventCount</queryRef>
        </columnBy>
        <layer boolean:maxLabels="false" displayName="%AverageBandwidthGB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/eDRAMReadGB</queryRef>
            <queryRef>/eDRAMWriteGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <minimumResolutionms>0</minimumResolutionms>
              <timelineFormat>area</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/eDRAMTotalGB</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="QPIBandwidthTimeline">
    <area headerMode="rich" boolean:showYScale="true" id="qpi_bw_utilization">
      <rowSet displayName="%UPIUtilizationPercent">
        <rowBy>
          <queryRef>/UncorePackage/QPILink</queryRef>
          <sort>
            <queryRef>/UncorePackage</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/UPIUtilizationPercentValue</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/UPIUtilizationPercentValue</queryRef>
            <displayAttributes>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
    <area headerMode="rich" boolean:showYScale="true" id="qpi_bw">
      <xsl:choose>
        <xsl:when test="(exsl:ctx('PMU') = 'snbep') or (exsl:ctx('PMU') = 'ivytown') or
                        (exsl:ctx('PMU') = 'haswell_server') or (exsl:ctx('PMU') = 'broadwell_server')">
          <xsl:attribute name="boolean:visible">true</xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="boolean:visible">false</xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
      <rowSet>
        <xsl:choose>
          <xsl:when test="(exsl:ctx('PMU') = 'snbep') or (exsl:ctx('PMU') = 'ivytown') or
                          (exsl:ctx('PMU') = 'haswell_server') or (exsl:ctx('PMU') = 'broadwell_server')">
            <xsl:attribute name="displayName">%QPIBandwidth</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="displayName">%UPIBandwidth</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <rowBy>
          <queryRef>/UncorePackage/QPILink</queryRef>
          <sort>
            <queryRef>/UncorePackage</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/OvertimeQPIBandwidth</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/OvertimeQPIBandwidth</queryRef>
            <displayAttributes>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:maxLabels="false">
          <drawBy>
            <queryRef>/OvertimeQPIDataReadBandwidthLine</queryRef>
          </drawBy>
        </layer>
        <layer boolean:maxLabels="false">
          <drawBy>
            <queryRef>/OvertimeQPINonDataReadBandwidthLine</queryRef>
          </drawBy>
        </layer>
        <layer boolean:maxLabels="false">
          <drawBy>
            <queryRef>/OvertimeQPIDataWriteBandwidthLine</queryRef>
          </drawBy>
        </layer>
        <layer boolean:maxLabels="false" boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/OvertimeQPINonDataWriteBandwidthLine</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="bandwidthTimelineAreas">
    <area headerMode="rich" boolean:showYScale="true" id="bw">
      <rowSet displayName="%DRAMBandwidth">
        <rowBy>
          <xsl:choose>
            <xsl:when test="exsl:IsNonEmptyTableExist('dd_uncore_event_unit')">
              <queryRef>/UncorePackage/DRAMChannel</queryRef>
            </xsl:when>
            <xsl:otherwise>
              <queryRef>/UncorePackage</queryRef>
            </xsl:otherwise>
          </xsl:choose>
          <sort>
            <queryRef>/UncorePackage</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/OvertimeBandwidth</queryRef>
        </columnBy>
        <layer boolean:maxLabels="false" displayName="%AverageBandwidthGB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/OvertimeReadBandwidthLine</queryRef>
            <queryRef>/OvertimeWriteBandwidthLine</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <minimumResolutionms>0</minimumResolutionms>
              <timelineFormat>area</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/OvertimeBandwidth</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
    <xsl:if test="exsl:ctx('is3DXPPresent', 0)">
      <area headerMode="rich" boolean:showYScale="true" id="ap_bw">
        <rowSet displayName="%APBandwidth">
          <rowBy>
            <xsl:choose>
              <xsl:when test="exsl:IsNonEmptyTableExist('dd_uncore_event_unit')">
                <queryRef>/UncorePackage/DRAMChannel</queryRef>
              </xsl:when>
              <xsl:otherwise>
                <queryRef>/UncorePackage</queryRef>
              </xsl:otherwise>
            </xsl:choose>
            <sort>
              <queryRef>/UncorePackage</queryRef>
            </sort>
          </rowBy>
          <columnBy>
            <queryRef>/APDataTransferredGB</queryRef>
          </columnBy>
          <layer displayName="%AverageBandwidthGB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
            <drawBy>
              <queryRef>/APDataReadGB</queryRef>
              <queryRef>/APDataWrittenGB</queryRef>
              <displayAttributes>
                  <timeScalems>1000</timeScalems>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelinePenWidth>1</timelinePenWidth>
              </displayAttributes>
            </drawBy>
          </layer>
          <layer boolean:scaleGroupEnd="true">
            <drawBy>
              <queryRef>/APDataTransferredGB</queryRef>
              <displayAttributes>
                <timelineFormat>line</timelineFormat>
                <timelineGraphColor>72,104,155</timelineGraphColor>
              </displayAttributes>
            </drawBy>
          </layer>
        </rowSet>
      </area>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="exsl:ctx('hbmMemoryMode', '') = ''">
        <area headerMode="rich" boolean:showYScale="true" id="bw_mcdram_flat">
          <rowSet displayName="%MCDRAMBandwidthFlat">
            <rowBy>
              <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              <sort>
                <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              </sort>
            </rowBy>
            <columnBy>
              <queryRef>/OvertimeMCDRAMFlatBandwidth</queryRef>
            </columnBy>
            <layer displayName="%AverageBandwidthGB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true" boolean:maxLabels="false">
              <drawBy>
                <queryRef>/OvertimeMCDRAMFlatReadBandwidthLine</queryRef>
                <queryRef>/OvertimeMCDRAMFlatWriteBandwidthLine</queryRef>
                <displayAttributes>
                  <timeScalems>1000</timeScalems>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelinePenWidth>1</timelinePenWidth>
                </displayAttributes>
              </drawBy>
            </layer>
            <layer boolean:scaleGroupEnd="true">
              <drawBy>
                <queryRef>/OvertimeMCDRAMFlatBandwidth</queryRef>
                <displayAttributes>
                  <timelineFormat>line</timelineFormat>
                  <timelineGraphColor>72,104,155</timelineGraphColor>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area headerMode="rich" boolean:showYScale="true" id="bw_mcdram_cache">
          <rowSet displayName="%MCDRAMBandwidthCache">
            <rowBy>
              <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              <sort>
                <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              </sort>
            </rowBy>
            <columnBy>
              <queryRef>/OvertimeMCDRAMCacheBandwidth</queryRef>
            </columnBy>
            <layer displayName="%AverageBandwidthGB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true" boolean:maxLabels="false">
              <drawBy>
                <queryRef>/OvertimeMCDRAMCacheReadBandwidthLine</queryRef>
                <queryRef>/OvertimeMCDRAMCacheWriteBandwidthLine</queryRef>
                <displayAttributes>
                  <timeScalems>1000</timeScalems>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelinePenWidth>1</timelinePenWidth>
                </displayAttributes>
              </drawBy>
            </layer>
            <layer boolean:scaleGroupEnd="true">
              <drawBy>
                <queryRef>/OvertimeMCDRAMCacheBandwidth</queryRef>
                <displayAttributes>
                  <timelineFormat>line</timelineFormat>
                  <timelineGraphColor>72,104,155</timelineGraphColor>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </xsl:when>
      <xsl:when test="exsl:ctx('hbmMemoryMode', '') = 'Flat'">
        <area headerMode="rich" boolean:showYScale="true" id="bw_mcdram_flat">
          <rowSet displayName="%MCDRAMBandwidth">
            <rowBy>
              <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              <sort>
                <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              </sort>
            </rowBy>
            <columnBy>
              <queryRef>/OvertimeMCDRAMFlatBandwidth</queryRef>
            </columnBy>
            <layer displayName="%AverageBandwidthGB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true" boolean:maxLabels="false">
              <drawBy>
                <queryRef>/OvertimeMCDRAMFlatReadBandwidthLine</queryRef>
                <queryRef>/OvertimeMCDRAMFlatWriteBandwidthLine</queryRef>
                <displayAttributes>
                  <timeScalems>1000</timeScalems>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelinePenWidth>1</timelinePenWidth>
                </displayAttributes>
              </drawBy>
            </layer>
            <layer boolean:scaleGroupEnd="true">
              <drawBy>
                <queryRef>/OvertimeMCDRAMFlatBandwidth</queryRef>
                <displayAttributes>
                  <timelineFormat>line</timelineFormat>
                  <timelineGraphColor>72,104,155</timelineGraphColor>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </xsl:when>
      <xsl:when test="exsl:ctx('hbmMemoryMode', '') = 'Cache' or exsl:ctx('hbmMemoryMode', '') = 'Hybrid'">
        <area headerMode="rich" boolean:showYScale="true" id="bw_mcdram_cache">
          <rowSet displayName="%MCDRAMBandwidth">
            <rowBy>
              <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              <sort>
                <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
              </sort>
            </rowBy>
            <columnBy>
              <queryRef>/OvertimeMCDRAMCacheBandwidth</queryRef>
            </columnBy>
            <layer boolean:scaleGroupStart="true">
              <drawBy>
                <queryRef>/OvertimeMCDRAMCacheBandwidth</queryRef>
                <displayAttributes>
                  <timelineFormat>area</timelineFormat>
                  <timelineGraphColor>72,104,155</timelineGraphColor>
                </displayAttributes>
              </drawBy>
            </layer>
            <layer boolean:maxLabels="false">
              <drawBy>
                <queryRef>/OvertimeMCDRAMCacheReadBandwidthLine</queryRef>
              </drawBy>
            </layer>
            <layer boolean:maxLabels="false" boolean:scaleGroupEnd="true">
              <drawBy>
                <queryRef>/OvertimeMCDRAMCacheWriteBandwidthLine</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </xsl:when>
    </xsl:choose>
    <area headerMode="rich" boolean:showYScale="true" id="omnipath-bw">
      <rowSet displayName="%OmniPathBandwidth">
        <rowBy>
          <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
          <sort>
            <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/OmniPathBandwidth</queryRef>
        </columnBy>
        <layer boolean:maxLabels="false" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/OmniPathOutgoingBandwidth</queryRef>
          </drawBy>
        </layer>
        <layer boolean:maxLabels="false" boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/OmniPathIncomingBandwidth</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
    <area headerMode="rich" boolean:showYScale="true" id="omnipath-packet-rate">
      <rowSet displayName="%OmniPathPacketRate">
        <rowBy>
          <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
          <sort>
            <queryRef>/UncorePackage/UncoreEventUnit</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/OmniPathPacketRate</queryRef>
        </columnBy>
        <layer boolean:maxLabels="false" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/OmniPathOutgoingPacketRate</queryRef>
          </drawBy>
        </layer>
        <layer boolean:maxLabels="false" boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/OmniPathIncomingPacketRate</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="memoryConsumption">
    <area headerMode="{$headerMode}" id="memory_usage" boolean:showYScale="true">
      <rowSet displayName="%MemoryConsumption">
        <rowBy>
          <queryRef>/GenericProcess</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/AllocCount</queryRef>
        </columnBy>
        <layer type="CountOverTime">
          <drawBy>
            <queryRef>/MemoryConsumptionOverTime</queryRef>
          </drawBy>
          <tooltipby>
            <queryRef>/MemoryConsumptionOverTime</queryRef>
          </tooltipby>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="PStateArea">
    <area headerMode="rich" boolean:maxLabels="true" id="p_states">
      <rowSet displayName="%PState">
        <rowBy boolean:useGridQuery="false">
          <queryRef>/Core</queryRef>
        </rowBy>
        <layer type="Overtime">
          <drawBy>
            <queryRef>/PStateFreq</queryRef>
          </drawBy>
          <tooltipBy>
            <queryRef>/PStateFreq</queryRef>
          </tooltipBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="CStateArea">
    <area headerMode="rich" id="package_core">
      <rowSet displayName="%CState">
        <rowBy>
          <queryRef>/Core</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/CStateTime</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/CStateTime/CState</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="aperfMperfFreq">
    <xsl:if test="exsl:IsNonEmptyTableExist('aperf_mperf_data')">
      <area boolean:showYScale="true" id="cpu_cores">
        <rowSet displayName="%CPUFrequency">
          <rowBy>
            <queryRef>/HWContextNameName</queryRef>
          </rowBy>
          <columnBy>
            <queryRef>/CPUFrequencyFromAPerfMPerf</queryRef>
          </columnBy>
          <layer>
            <drawBy>
              <queryRef>/CPUFrequencyFromAPerfMPerf</queryRef>
            </drawBy>
          </layer>
        </rowSet>
      </area>
    </xsl:if>
  </config>
  <config id="CPUIoStatePercentageArea">
    <area boolean:maxLabels="false">
      <requiredData>
        <queryRef>/CPUIoStatePercentage</queryRef>
      </requiredData>
      <rowSet displayName="%CPUActivity">
        <layer>
          <drawBy>
            <queryRef>/CPUIoStatePercentage</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="spdkIoArea">
    <area headerMode="" id="metrics_by_object">
      <rowSet displayName="%spdkIo">
        <rowBy>
          <queryRef>/SpdkIoDevice/Thread</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/SpdkIoCount</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/SpdkIoTotalCountTimeline</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/SpdkIoReadCountTimeline</queryRef>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/SpdkIoWriteCountTimeline</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="spdkIoBytesArea">
    <area headerMode="" id="metrics_by_object">
      <rowSet displayName="%spdkIoBytes">
        <rowBy>
          <queryRef>/SpdkIoDevice/Thread</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/SpdkIoCount</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/SpdkIoTotalBytes</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/SpdkIoReadBytes</queryRef>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/SpdkIoWriteBytes</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="IOQueueDepthArea">
    <area headerMode="rich">
      <rowSet displayName="%IOQueueDepth">
        <rowBy>
          <queryRef>/IOQueueDevice/IOQueuePartition</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/IOQueueCount</queryRef>
        </columnBy>
        <layer type="InstanceCountOverTime">
          <drawBy>
            <queryRef>/IOQueueCount</queryRef>
          </drawBy>
        </layer>
        <layer type="EventMarker" boolean:visible="false">
          <drawBy>
            <queryRef>/IOSlowRequests/IOBinDurationType[%SlowIORequest]</queryRef>
          </drawBy>
        </layer>
        <layer type="EventMarker" boolean:visible="false">
          <drawBy>
            <queryRef>/IOGoodRequests/IOBinDurationType[%GoodIORequest]</queryRef>
          </drawBy>
        </layer>
        <layer type="EventMarker" boolean:visible="false">
          <drawBy>
            <queryRef>/IOFastRequests/IOBinDurationType[%FastIORequest]</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="PageFaultStatArea">
    <area headerMode="rich">
      <rowSet displayName="%PageFaultStat">
        <layer type="Overtime">
          <drawBy>
            <queryRef>/PageFaultCount/PageFaultInfo</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="IOOperationArea">
    <area headerMode="rich">
      <rowSet displayName="%IOOperation">
        <rowBy>
          <queryRef>/IOPSDevice/IOPSPartition</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/IOTotalCount</queryRef>
        </columnBy>
        <layer type="InstanceCountOverTime" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/IOTotalCount</queryRef>
          </drawBy>
        </layer>
        <layer type="InstanceCountOverTime" boolean:allowToHideSeries="true" boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/IOOperationCountAll/IOOperationType</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
            </displayAttributes>
          </drawBy>
          <colorBy>
            <queryRef>/IOOperationType</queryRef>
          </colorBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="IOBytesArea">
    <area headerMode="rich">
      <rowSet displayName="%IOBytes">
        <xsl:if test="$showIODevice='true'">
          <rowBy>
            <queryRef>/IOPSDevice/IOPSPartition</queryRef>
          </rowBy>
          <columnBy>
            <queryRef>/IOTotalCount</queryRef>
          </columnBy>
        </xsl:if>
        <layer type="Overtime" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/IOBytesCount</queryRef>
          </drawBy>
        </layer>
        <layer type="Overtime" boolean:allowToHideSeries="true" boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/IOBytesCountAll/IOOperationType</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
            </displayAttributes>
          </drawBy>
          <colorBy>
            <queryRef>/IOOperationType</queryRef>
          </colorBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="IOThroughputArea">
    <area headerMode="rich">
      <rowSet displayName="%IOThroughput">
        <rowBy>
          <queryRef>/IOPSDevice/IOPSPartition</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/IOTotalCount</queryRef>
        </columnBy>
      </rowSet>
    </area>
  </config>
  <config id="SystemBandwidthArea">
    <area boolean:maxLabels="false" boolean:showYScale="true">
      <rowSet displayName="%SystemBandwidth">
        <layer>
          <drawBy>
            <queryRef>/OvertimeBandwidthSystem</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="legacyPCIeBandwidthArea">
    <area headerMode="rich" boolean:showYScale="true">
      <rowSet displayName="%PCIeBandwidth">
        <rowBy>
          <xsl:choose>
            <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'snowridge' or exsl:ctx('PMU') = 'icelake_server'">
              <queryRef>/UncorePackage/PCIeIOU</queryRef>
              <sort>
                <queryRef>/UncorePackage</queryRef>
              </sort>
            </xsl:when>
            <xsl:otherwise>
              <queryRef>/UncorePackage</queryRef>
            </xsl:otherwise>
          </xsl:choose>
        </rowBy>
        <columnBy>
          <queryRef>/PCIeOvertimeBandwidth</queryRef>
        </columnBy>
        <layer displayName="%AverageBandwidthMB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/PCIEWriteBandwidth</queryRef>
            <queryRef>/PCIEReadBandwidth</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <minimumResolutionms>0</minimumResolutionms>
              <timelineFormat>area</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/PCIeOvertimeBandwidth</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="InboundPCIeBandwidthArea">
    <area headerMode="rich" boolean:showYScale="true">
      <rowSet displayName="%InboundPCIeBandwidthSection">
        <rowBy>
          <xsl:choose>
            <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'snowridge' or exsl:ctx('PMU') = 'icelake_server'">
              <queryRef>/UncorePackage/PCIeIOU</queryRef>
              <sort>
                <queryRef>/UncorePackage</queryRef>
              </sort>
            </xsl:when>
            <xsl:otherwise>
              <queryRef>/UncorePackage</queryRef>
            </xsl:otherwise>
          </xsl:choose>
        </rowBy>
        <columnBy>
          <queryRef>/InboundPCIeBandwidth</queryRef>
        </columnBy>
        <layer displayName="%InboundPCIeBandwidthMB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/InboundPCIeWriteBandwidth</queryRef>
            <queryRef>/InboundPCIeReadBandwidth</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <minimumResolutionms>0</minimumResolutionms>
              <timelineFormat>area</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/InboundPCIeBandwidth</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="OutboundPCIeBandwidthArea">
    <area headerMode="rich" boolean:showYScale="true">
      <rowSet displayName="%OutboundPCIeBandwidthSection">
        <rowBy>
          <xsl:choose>
            <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'snowridge' or exsl:ctx('PMU') = 'icelake_server'">
              <queryRef>/UncorePackage/PCIeIOU</queryRef>
              <sort>
                <queryRef>/UncorePackage</queryRef>
              </sort>
            </xsl:when>
            <xsl:otherwise>
              <queryRef>/UncorePackage</queryRef>
            </xsl:otherwise>
          </xsl:choose>
        </rowBy>
        <columnBy>
          <queryRef>/OutboundPCIeBandwidth</queryRef>
        </columnBy>
        <layer displayName="%OutboundPCIeBandwidthMB" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/OutboundPCIeWriteBandwidth</queryRef>
            <queryRef>/OutboundPCIeReadBandwidth</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <minimumResolutionms>0</minimumResolutionms>
              <timelineFormat>area</timelineFormat>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/OutboundPCIeBandwidth</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="FPGA_QPI_BandwidthArea">
    <area headerMode="rich" boolean:showYScale="true" id="fpga_bw_qpi">
      <rowSet displayName="%FPGA_QPI_Bandwidth">
        <rowBy>
          <queryRef>/UncorePackage</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/UncoreEventCount</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/QPIFPGADataTransferredGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/QPIFPGADataReadGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <timelineFormat>line</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
              <timelineGraphColor>0,255,0</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/QPIFPGADataWrittenGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <timelineFormat>line</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
              <timelineGraphColor>255,0,0</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="FPGA_PCIE_BandwidthArea">
    <area headerMode="rich" boolean:showYScale="true" id="fpga_bw_pcie">
      <rowSet displayName="%FPGA_PCIE_Bandwidth">
        <rowBy>
          <queryRef>/UncorePackage/QPILink</queryRef>
          <sort>
            <queryRef>/UncorePackage</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/PCIEFPGADataTransferredGB</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/PCIEFPGADataTransferredGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <timelineFormat>area</timelineFormat>
              <timelineGraphColor>72,104,155</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/PCIEFPGADataReadGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <timelineFormat>line</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
              <timelineGraphColor>0,255,0</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/PCIEFPGADataWrittenGB</queryRef>
            <displayAttributes>
              <timeScalems>1000</timeScalems>
              <timelineFormat>line</timelineFormat>
              <timelinePenWidth>1</timelinePenWidth>
              <timelineGraphColor>255,0,0</timelineGraphColor>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="FPGARatiosArea">
    <area headerMode="rich" boolean:showYScale="false" id="fpga_ratios">
      <rowSet displayName="%FPGARatios">
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/FPGADataReadMissRatio</queryRef>
            <valueType>ratio</valueType>
            <maxEval>1</maxEval>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>0,255,0</timelineGraphColor>
              <timelinePenWidth>1</timelinePenWidth>
              <minimumResolutionms>0</minimumResolutionms>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/FPGADataWriteMissRatio</queryRef>
            <valueType>ratio</valueType>
            <maxEval>1</maxEval>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <timelineGraphColor>255,0,0</timelineGraphColor>
              <timelinePenWidth>1</timelinePenWidth>
              <minimumResolutionms>0</minimumResolutionms>
            </displayAttributes>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="rawEventSampleCountArea">
    <area id="raw_event_count_by_core">
      <rowSet>
        <rowBy>
          <queryRef>/PMUEventType</queryRef>
          <xsl:choose>
            <xsl:when test="exsl:IsNonEmptyTableExist('dd_core_type')">
              <queryRef>/PMUEventType/PMUPackage/PMUCoreType/PMUCore/PMUHWContext</queryRef>
            </xsl:when>
            <xsl:otherwise>
              <queryRef>/PMUEventType/PMUPackage/PMUCore/PMUHWContext</queryRef>
            </xsl:otherwise>
          </xsl:choose>
        </rowBy>
        <columnBy>
          <queryRef>/PMUSampleCount</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/PMUSampleCount</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="rawEventCountArea">
    <area id="raw_event_count_by_core">
      <rowSet>
        <rowBy>
          <queryRef>/PMUEventType</queryRef>
          <xsl:choose>
            <xsl:when test="exsl:IsNonEmptyTableExist('dd_core_type')">
              <queryRef>/PMUEventType/PMUPackage/PMUCoreType/PMUCore/PMUHWContext</queryRef>
            </xsl:when>
            <xsl:otherwise>
              <queryRef>/PMUEventType/PMUPackage/PMUCore/PMUHWContext</queryRef>
            </xsl:otherwise>
          </xsl:choose>
        </rowBy>
        <columnBy>
          <queryRef>/PMUEventCount</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/PMUEventCount</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="FPGAComputingTaskUtilizationArea">
    <area>
      <rowSet displayName="%FPGAComputingTaskUtilization">
        <layer type="InstanceCountOverTime">
          <drawBy>
            <queryRef>/FPGAComputeTaskCount/FPGAComputeTaskPurpose</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="cpuUsageByCSArea">
    <area id="cpu_usage_by_cs_per_cpu" headerMode="rich" boolean:maxLabels="true">
      <rowSet displayName="%CPUUsageOverTime">
        <rowBy>
          <queryRef>/ContextSwitchRunningPackage/ContextSwitchRunningCpu</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/CPUUsageByCS</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/CPUUsageByCS</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="ParallelFsReadWriteBytesArea">
    <area id="parallel_fs_traffic" headerMode="rich">
      <rowSet displayName="%ParallelFsReadWriteBytes">
        <rowBy>
          <queryRef>/ParallelFsType/ParallelFsObject</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/ParallelFsCount</queryRef>
        </columnBy>
        <layer boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/ParallelFsReadBytes</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/ParallelFsWriteBytes</queryRef>
          </drawBy>
        </layer>
        <layer boolean:scaleGroupEnd="true" boolean:visible="false">
          <drawBy>
            <queryRef>/ParallelFsReadWriteBytes</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="ParallelFsSumSamplesCountArea">
    <area id="parallel_fs_requests" headerMode="rich">
      <rowSet displayName="%ParallelFsSumSamplesCount">
        <rowBy>
          <queryRef>/ParallelFsType/ParallelFsObject</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/ParallelFsCount</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/ParallelFsReadSamplesCount</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/ParallelFsWriteSamplesCount</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/ParallelFsOtherSamplesCount</queryRef>
          </drawBy>
        </layer>
        <layer boolean:visible="false">
          <drawBy>
            <queryRef>/ParallelFsReqSamplesCount</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="GPUQueueArea">
    <area id="gpu_usage_over_time" rowOutlineStyle="dotted" boolean:useWideBands="false" headerMode="rich">
      <rowSet>
        <rowBy>
          <xsl:choose>
            <xsl:when test="$packetsType='true'">
              <vectorQueryInsert>/GPUPacketQueueRowBy</vectorQueryInsert>
            </xsl:when>
            <xsl:otherwise>
              <vectorQueryInsert>/GPUPacketQueueRowByProcess</vectorQueryInsert>
            </xsl:otherwise>
          </xsl:choose>
          <sort>
            <queryRef>/GPUDXTime</queryRef>
          </sort>
        </rowBy>
        <columnBy>
          <queryRef>/GPUDXTime</queryRef>
        </columnBy>
        <layer type="RowInterval" boolean:showText="true" boolean:showColoringAsLegendItems="true" displayModes="rich">
          <drawBy>
            <xsl:choose>
              <xsl:when test="$packetsType='true'">
                <queryRef>/GPUDMAPacket</queryRef>
              </xsl:when>
              <xsl:otherwise>
                <queryRef>/GPUDMAPacketByProcess</queryRef>
              </xsl:otherwise>
            </xsl:choose>
          </drawBy>
          <highlightBy int:groupId="1">
            <queryRef>/GPUDMAPacketSubmissionId</queryRef>
          </highlightBy>
          <tooltipBy>
            <vectorQueryInsert>/GPUDMAPacketDetails</vectorQueryInsert>
          </tooltipBy>
          <colorBy>
            <xsl:choose>
              <xsl:when test="$packetsColorByVM='true' and exsl:IsNonEmptyTableExist('dd_vm_info')">
                <queryRef>/GPUVM</queryRef>
              </xsl:when>
              <xsl:otherwise>
                <queryRef>/GPUNode</queryRef>
              </xsl:otherwise>
            </xsl:choose>
          </colorBy>
          <hatchBy>
            <xsl:choose>
              <xsl:when test="$packetsType='true'">
                <queryRef>/GPUDMAPacket</queryRef>
              </xsl:when>
              <xsl:otherwise>
                <queryRef>/GPUDMAPacketByProcess</queryRef>
              </xsl:otherwise>
            </xsl:choose>
          </hatchBy>
        </layer>
        <xsl:if test="not(contains(exsl:ctx('androidBoardPlatform', ''), 'sofia'))">
          <layer type="RowIntervalNested" boolean:showText="true" boolean:showColoringAsLegendItems="true" displayModes="rich">
            <drawBy>
              <xsl:choose>
                <xsl:when test="$packetsType='true'">
                  <queryRef>/QueueDMAPacket</queryRef>
                </xsl:when>
                <xsl:otherwise>
                  <queryRef>/QueueDMAPacketByProcess</queryRef>
                </xsl:otherwise>
              </xsl:choose>
            </drawBy>
            <highlightBy int:groupId="1">
              <queryRef>/GPUQueuePacketSubmissionId</queryRef>
            </highlightBy>
            <tooltipBy>
              <vectorQueryInsert>/GPUQueuePacketDetails</vectorQueryInsert>
            </tooltipBy>
            <colorBy>
              <xsl:choose>
                <xsl:when test="$packetsColorByVM='true' and exsl:IsNonEmptyTableExist('dd_vm_info')">
                  <queryRef>/GPUVM</queryRef>
                </xsl:when>
                <xsl:otherwise>
                  <queryRef>/GPUNode</queryRef>
                </xsl:otherwise>
              </xsl:choose>
            </colorBy>
            <hatchBy>
              <xsl:choose>
                <xsl:when test="$packetsType='true'">
                  <queryRef>/QueueDMAPacket</queryRef>
                </xsl:when>
                <xsl:otherwise>
                  <queryRef>/QueueDMAPacketByProcess</queryRef>
                </xsl:otherwise>
              </xsl:choose>
            </hatchBy>
          </layer>
        </xsl:if>
        <layer type="InstanceCountOverTime" boolean:showColoringAsLegendItems="true" displayModes="regular">
          <drawBy>
            <queryRef>/GPUQueue</queryRef>
          </drawBy>
          <colorBy>
            <xsl:choose>
              <xsl:when test="$packetsColorByVM='true' and exsl:IsNonEmptyTableExist('dd_vm_info')">
                <queryRef>/GPUVM</queryRef>
              </xsl:when>
              <xsl:otherwise>
                <queryRef>/GPUNode</queryRef>
              </xsl:otherwise>
            </xsl:choose>
          </colorBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="FPGA_Device_Metrics">
    <area headerMode="rich" id="fpga_device_metrics">
      <rowSet displayName="%FPGADeviceMetrics">
        <rowBy>
          <queryRef>/FPGADeviceComputeTaskType/FPGADeviceChannel</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/FPGADeviceCycles</queryRef>
        </columnBy>
        <layer>
          <drawBy>
            <queryRef>/FPGADeviceMemoryTransferSizeGlobal</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/FPGADeviceStallsPercentage</queryRef>
          </drawBy>
        </layer>
        <layer>
          <drawBy>
            <queryRef>/FPGADeviceOccupancyPercentage</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  <config id="energyConsumption">
    <area headerMode="rich" id="energy_consumption" boolean:showYScale="true">
      <rowSet displayName="%PowerUsage">
        <rowBy>
          <queryRef>/Entity</queryRef>
        </rowBy>
        <columnBy>
          <queryRef>/package_powerCountConvertedTimeline</queryRef>
        </columnBy>
        <layer type="Overtime" boolean:allowToHideSeries="true" boolean:scaleGroupStart="true">
          <drawBy>
            <queryRef>/package_powerCountConvertedTimeline</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
              <boolean:timelineShowZeroValues>true</boolean:timelineShowZeroValues>
            </displayAttributes>
          </drawBy>
          <tooltipBy>
            <queryRef>/package_powerCountConvertedTimeline</queryRef>
          </tooltipBy>
        </layer>
        <layer type="Overtime" boolean:allowToHideSeries="true" boolean:scaleGroupEnd="true">
          <drawBy>
            <queryRef>/package_powerCountConvertedTimelinePackage-Power</queryRef>
            <displayAttributes>
              <timelineFormat>line</timelineFormat>
                <boolean:timelineShowZeroValues>true</boolean:timelineShowZeroValues>
            </displayAttributes>
          </drawBy>
        </layer>
        <layer type="EventMarker" boolean:visible="false">
          <drawBy>
            <queryRef>/package_powerFieldMarker</queryRef>
          </drawBy>
        </layer>
      </rowSet>
    </area>
  </config>
  </bag>
  </xsl:template>
</xsl:stylesheet>
