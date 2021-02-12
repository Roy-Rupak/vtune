<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  xmlns:double="http://www.w3.org/2001/XMLSchema#double"
  syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="enablePython">false</xsl:param>
  <xsl:template match="/">
    <knobs>
      <stringKnob id="pmuEventConfig" displayName="%PmuEventConfig" cliName="event-config">
        <knobProperty name="queryEventsOption">--event-value-list</knobProperty>
        <knobProperty name="knob_control_id">HWEventConfig</knobProperty>
        <boolean:knobProperty name="specifyPlatformType">true</boolean:knobProperty>
        <knobProperty name="HWTableInfo">pmuHWTableInfo</knobProperty>
        <description>%PmuEventConfigDescription</description>
        <value></value>
        <defaultValue></defaultValue>
      </stringKnob>
      <booleanKnob id="useEventBasedCounts" displayName="%UseEventBasedCounts">
        <description>%UseEventBasedCountsDescription</description>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="enableHWBasedCSCollection" displayName="%EnableHWBasedCSCollection">
        <boolean:defaultValue>
          <xsl:value-of select="exsl:is_experimental('lbr-stack-stitching')"/>
        </boolean:defaultValue>
        <description>%EnableHWBasedCSCollectionDescription</description>
        <experimental>lbr-stack-stitching</experimental>
      </booleanKnob>
      <booleanKnob id="useCountingMode" displayName="%UseCountingMode" cliName="counting-mode">
        <description>%UseCountingModeDescription</description>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <xsl:choose>
        <xsl:when test="exsl:ctx('targetOS', '')='Windows'">
          <booleanKnob id="gpuUsage" displayName="%GpuDX" boolean:visible="true" cliName="enable-gpu-usage">
            <description>%GpuDXDescription</description>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gpuDX', 'false')='true'">
                <boolean:defaultValue>true</boolean:defaultValue>
              </xsl:when>
              <xsl:otherwise>
                <boolean:defaultValue>false</boolean:defaultValue>
              </xsl:otherwise>
            </xsl:choose>
          </booleanKnob>
        </xsl:when>
        <xsl:otherwise>
          <booleanKnob id="gpuUsage" displayName="%IGFXFtraceEvents" boolean:visible="true" cliName="enable-gpu-usage">
            <description>%IGFXFtraceEventsDescription</description>
            <boolean:defaultValue>false</boolean:defaultValue>
          </booleanKnob>
        </xsl:otherwise>
      </xsl:choose>
      <enumKnob id="gpuCounters" displayName="%GpuCounters" cliName="gpu-counters-mode">
        <xsl:attribute name="boolean:visible">
          <xsl:value-of select="exsl:ctx('targetOS', '')='Windows' or exsl:ctx('targetOS', '')='Android' or exsl:ctx('targetOS', '')='Linux' or exsl:ctx('targetOS', '')='MacOSX' or exsl:ctx('targetOS', '')='QNX'"/>
        </xsl:attribute>
        <description>%GpuCountersDescription</description>
        <values>
          <value displayName="%None">none</value>
          <xsl:choose>
            <xsl:when test="exsl:is_experimental('gpu-frequency')">
              <value displayName="%GPUCollectFrequency">frequency</value>
            </xsl:when>
          </xsl:choose>
          <value displayName="%GpuCollectOverview">overview</value>
          <value displayName="%GpuCollectComputeBasic">global-local-accesses</value>
          <xsl:if test="exsl:ctx('gpuPlatformIndex', 0)>=6">
            <value displayName="%GpuComputeExtended">compute-extended</value>
          </xsl:if>
          <value displayName="%GpuCollectRenderBasic">render-basic</value>
          <xsl:if test="exsl:is_experimental('gpu-metrics2')">
            <value displayName="%GpuCollectPreset3">preset3</value>
            <value displayName="%GpuCollectPreset5">preset5</value>
          </xsl:if>
          <xsl:if test="exsl:ctx('connectionType','') != 'ghs'">
            <value displayName="%GpuFullCompute">full-compute</value>
          </xsl:if>
          <defaultValue>none</defaultValue>
        </values>
      </enumKnob>
      <doubleKnob id="gpuSamplingInterval" displayName="%GpuSamplingInterval" cliName="gpu-sampling-interval">
        <xsl:attribute name="boolean:visible">
          <xsl:value-of select="exsl:ctx('targetOS')='Windows' or exsl:ctx('targetOS')='Android' or exsl:ctx('targetOS')='Linux' or exsl:ctx('targetOS')='MacOSX' or exsl:ctx('targetOS')='QNX'"/>
        </xsl:attribute>
        <description>%GpuSamplingIntervalDescription</description>
        <double:min>0.01</double:min>
        <double:max>1000</double:max>
        <double:defaultValue>1</double:defaultValue>
      </doubleKnob>
      <booleanKnob id="collectGpuOpenCl" displayName="%GpuTraceProgrammingAPIs" visible="true" cliName="collect-programming-api">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='Windows' or exsl:ctx('targetOS', '')='Linux'">
            <description>%CollectGpuOpenClModeDescription</description>
          </xsl:when>
          <xsl:when test="exsl:ctx('targetOS', '')='Android'">
            <xsl:attribute name="displayName">%CollectAndroidGpuRuntimes</xsl:attribute>
            <description>%CollectAndroidGpuRuntimesModeDescription</description>
            <experimental>gpu-android-runtimes</experimental>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="showGPUBandwidthHistogram" visible="false">
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="collectGpuMetal" displayName="%CollectGpuMetal" visible="true" cliName="enable-gpu-metal">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='MacOSX'">
            <description>%CollectGpuMetalModeDescription</description>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="collectGpuLevelZero" displayName="%CollectGpuLevelZero" visible="true" cliName="enable-gpu-level-zero">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='Linux'">
            <description>%CollectGpuLevelZeroModeDescription</description>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="collectGpuCm" displayName="%CollectGpuCm" boolean:visible="false" cliName="enable-gpu-cm">
        <description>%CollectGpuCmModeDescription</description>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='Windows' and exsl:is_experimental('gpu-cm')">
            <boolean:defaultValue>true</boolean:defaultValue>
          </xsl:when>
          <xsl:otherwise>
            <boolean:defaultValue>false</boolean:defaultValue>
          </xsl:otherwise>
        </xsl:choose>
      </booleanKnob>
      <booleanKnob id="advancedLoopAnalysis" displayName="%AdvabncedLoopAnalysis" cliName="analyze-loops">
        <xsl:attribute name="boolean:visible">
          <xsl:value-of select="exsl:ctx('targetOS') != 'MacOSX'"/>
        </xsl:attribute>
        <description>%AdvancedLoopAnalysisDescription</description>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="showInlinesByDefault" boolean:visible="false">
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="openclSourceAsm" boolean:visible="false">
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
      <xsl:variable name="areGpuHardwareMetricsAvailableVar">
        <xsl:choose>
          <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailable', 'valueNotPresent') = 'valueNotPresent'">
            <xsl:value-of select="exsl:ctx('isGPUAnalysisAvailable', 'valueNotPresent')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="exsl:ctx('areGpuHardwareMetricsAvailable', 'valueNotPresent')"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <stringKnob id="areGpuHardwareMetricsAvailableKnob" boolean:visible="false">
        <defaultValue>
          <xsl:value-of select="$areGpuHardwareMetricsAvailableVar"/>
        </defaultValue>
      </stringKnob>
      <stringKnob id="isGpuHWMetricsCollectionPossible" boolean:visible="false">
        <defaultValue>
          <xsl:choose>
            <xsl:when test="$areGpuHardwareMetricsAvailableVar='true' or $areGpuHardwareMetricsAvailableVar='RemoteDesktopWarning'">true</xsl:when>
            <xsl:otherwise>false</xsl:otherwise>
          </xsl:choose>
        </defaultValue>
      </stringKnob>
      <stringKnob id="isFtraceAvailableKnob" boolean:visible="false">
        <defaultValue>
           <xsl:value-of select="exsl:ctx('isFtraceAvailable', 'valueNotPresent')"/>
        </defaultValue>
      </stringKnob>
      <enumKnob id="mrteType" displayName="%MrteType" cliName="mrte-type">
        <description>%MrteTypeDescription</description>
        <values>
          <xsl:choose>
            <xsl:when test="exsl:ctx('targetOS', '') = 'Windows'">
              <value displayName="%MrteTypeJavaNet">java,dotnet</value>
              <xsl:if test="$enablePython != 'false'">
                <value displayName="%MrteTypeJavaNetPython">java,dotnet,python</value>
                <value displayName="%MrteTypePython">python</value>
              </xsl:if>
              <defaultValue>java,dotnet</defaultValue>
            </xsl:when>
            <xsl:otherwise>
              <value displayName="%MrteTypeJava">java</value>
              <xsl:if test="$enablePython != 'false' and exsl:ctx('targetOS', '') = 'Linux'">
                <value displayName="%MrteTypeJavaPython">java,python</value>
                <value displayName="%MrteTypePython">python</value>
              </xsl:if>
              <defaultValue>java</defaultValue>
            </xsl:otherwise>
          </xsl:choose>
        </values>
      </enumKnob>
      <booleanKnob id="collectOpenMPRegions" displayName="%AnalyzeOpenMPRegions" visible="true" cliName="analyze-openmp">
        <boolean:defaultValue>false</boolean:defaultValue>
        <description>%AnalyzeOpenMPRegionsDescription</description>
      </booleanKnob>
      <enumKnob id="calleeAttributionMode" displayName="%CalleeAttributionMode" boolean:visible="false">
        <description>%CalleeAttributionMode</description>
        <values>
          <value displayName="%NoneCalleeAttributionMode">none</value>
          <value displayName="%BottomUserCalleeAttributionMode">bottomUser</value>
          <value displayName="%TopSystemCalleeAttributionMode">topSystem</value>
          <value displayName="%InternalCalleeAttributionMode">internal</value>
          <value displayName="%UndefinedCalleeAttributionMode">undefined</value>
        </values>
        <defaultValue>undefined</defaultValue>
      </enumKnob>
      <booleanKnob id="collectMemObjects" displayName="%CollectMemObjects" boolean:visible="false">
       <xsl:if test="exsl:ctx('targetOS')='Linux'">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
       </xsl:if>
       <description>%CollectMemObjectsDescription</description>
       <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="analyzeMemoryConsumption" displayName="%AnalyzeMemoryConsumption" boolean:visible="false">
        <xsl:if test="exsl:ctx('targetOS')='Linux' and exsl:is_experimental('memory-consumption')">
         <xsl:attribute name="boolean:visible">true</xsl:attribute>
        </xsl:if>
        <description>%AnalyzeMemoryConsumptionDescription</description>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <intKnob id="memoryObjectMinSize" displayName="%MemoryObjectMinSize" boolean:visible="false">
       <xsl:if test="exsl:ctx('targetOS')='Linux'">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
       </xsl:if>
       <description>%MemoryObjectMinSize</description>
       <int:min>1</int:min>
       <int:defaultValue>1024</int:defaultValue>
      </intKnob>
      <stringKnob id="tmamVersionCurrent" displayName="%TmamVersion" boolean:visible="false">
        <defaultValue>4_0</defaultValue>
      </stringKnob>
      <stringKnob id="fpuVersion" displayName="%FpuVersion" boolean:visible="false">
        <defaultValue>1_0</defaultValue>
      </stringKnob>
      <stringKnob id="numaVersionCurrent" displayName="%NumaVersion" boolean:visible="false">
        <defaultValue>1_0</defaultValue>
      </stringKnob>
      <booleanKnob id="forceSchedAndCounterMetricsGrouper" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="handleLostEvents" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="ignorePowerData" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="enableOpenglesInstrumentation" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="collectFPGAOpenCl" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="enableDramBandwidthLimitsWarning" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <enumKnob id="gpuProfilingMode" displayName="%GpuProfilingMode" boolean:visible="true" cliName="gpu-profiling-mode">
        <description>%GpuProfilingModeDescription</description>
        <values>
          <value displayName="%GpuProfilingModeNone">none</value>
          <value displayName="%GpuProfilingModeBBLatency">bblatency</value>
          <value displayName="%GpuProfilingModeMemLatency">memlatency</value>
          <value displayName="%GpuProfilingModeInstCount">instcount</value>
          <defaultValue>none</defaultValue>
        </values>
      </enumKnob>
      <stringKnob id="kernelsToProfile" displayName="%GpuProfilingKernels" cliName="gpu-kernels-to-profile">
        <description>%GpuProfilingKernelsDescription</description>
        <knobProperty name="knob_control_id">KernelGrid</knobProperty>
        <defaultValue>*#1#1#4294967295</defaultValue>
      </stringKnob>
      <stringKnob id="systemCollectorConfig" displayName="%SystemCollectorConfig" boolean:visible="false" cliName="system-collector-config">
          <defaultValue></defaultValue>
      </stringKnob>
      <booleanKnob id="enableThreadAffinity" displayName="%enableThreadAffinity" cliName="enable-thread-affinity">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='Linux'">
            <xsl:attribute name="boolean:visible">true</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="enableParallelFsCollection" displayName="%enableParallelFsCollection" cliName="enable-parallel-fs-collection">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='Linux' and exsl:is_experimental('lustre')">
            <xsl:attribute name="boolean:visible">true</xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="collectSWHotspots" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="isUArchUsageAvailable" visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="inKernelProfilingAnalysis" visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="analyzeEnergyConsumption" displayName="%AnalyzeEnergyConsumption" visible="true">
        <description>%AnalyzeEnergyConsumptionDescription</description>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="enableMemoryObjectCorrelation" visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="usePerfMetrics" visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="useAggregatedCounting" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="useGpuCounting" boolean:visible="false">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="useAOCLProfile" displayName="%UseAOCLProfile" cliName="aocl-profile">
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <stringKnob id="fpgaSourceFile" displayName="%FpgaSourceFile" cliName="source-file-fpga">
        <description>%FpgaSourceFileDescription</description>
        <defaultValue></defaultValue>
      </stringKnob>
    </knobs>
  </xsl:template>
</xsl:stylesheet>
