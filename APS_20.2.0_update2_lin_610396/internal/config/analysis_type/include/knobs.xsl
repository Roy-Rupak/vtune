<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
  syntax="norules"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:double="http://www.w3.org/2001/XMLSchema#double"
  xmlns:str="http://exslt.org/strings"
>
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="defaultMemoryBandwidth">false</xsl:param>
  <xsl:param name="defaultMemoryBandwidthLimits">true</xsl:param>
  <xsl:param name="collectMemoryBandwidthSwitchCheck">true</xsl:param>
  <xsl:param name="defaultAnalyzeOpenMP">false</xsl:param>
  <xsl:param name="enableGPURendering">false</xsl:param>
  <xsl:param name="isOpenCLCollectionVisible">true</xsl:param>
  <xsl:param name="isGPUUsageVisible">true</xsl:param>
  <xsl:param name="isGPUUsageAvailable">true</xsl:param>
  <xsl:param name="pmuModeSwitchCheck">false</xsl:param>
  <xsl:param name="pmuSamplingIntervalDescription">none</xsl:param>
  <xsl:param name="samplingIntervalApplyKnob">none</xsl:param>
  <xsl:param name="samplingIntervalApplyKnobValue">none</xsl:param>
  <xsl:param name="gpuApplyStateKnob1">none</xsl:param>
  <xsl:param name="gpuApplyStateKnobValue1">none</xsl:param>
  <xsl:param name="gpuApplyStateKnob2">none</xsl:param>
  <xsl:param name="gpuApplyStateKnobValue2">none</xsl:param>
  <xsl:param name="forceUnlimitedStack">false</xsl:param>
  <xsl:param name="hideKnobInPerfsnapshot">false</xsl:param>
  <xsl:template match="/">
    <knobs>
      <enumKnob id="pmuSamplingCountSwitch" displayName="%PmuSamplingCountSwitch" cliName="pmu-collection-mode">
        <xsl:if test="(exsl:ctx('targetOS', '') = 'Android') or (exsl:ctx('targetOS', '') = 'QNX')">
          <xsl:attribute name="boolean:visible">false</xsl:attribute>
        </xsl:if>
        <description>%PmuSamplingCountSwitchDescription</description>
        <values>
          <value displayName="%DetailedSampling" cliName="detailed">detailed</value>
          <value displayName="%LightweightCounting" cliName="summary">summary</value>
          <defaultValue>detailed</defaultValue>
        </values>
      </enumKnob>
      <booleanKnob id="collectMemoryBW" displayName="%CollectMemoryBW" cliName="collect-memory-bandwidth">
        <xsl:choose>
          <xsl:when test="(exsl:ctx('PMU') = 'corei7') or (exsl:ctx('PMU') = 'corei7wsp') or (exsl:ctx('PMU') = 'corei7wdp') or (exsl:ctx('PMU') = 'corei7b') or (exsl:ctx('PMU') = 'core2') or (exsl:ctx('PMU') = 'core2p') or (contains(exsl:ctx('androidBoardPlatform',''), 'sofia'))">
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
            <boolean:defaultValue>false</boolean:defaultValue>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">true</xsl:attribute>
            <boolean:defaultValue>
              <xsl:value-of select="$defaultMemoryBandwidth"/>
            </boolean:defaultValue>
          </xsl:otherwise>
        </xsl:choose>
        <description>%CollectMemoryBWDescription</description>
        <xsl:choose>
          <xsl:when test="$pmuModeSwitchCheck = 'true'">
            <knobProperty name="active_state">pmuSamplingCountSwitch=detailed</knobProperty>
          </xsl:when>
          <xsl:when test="$gpuApplyStateKnob1 != 'none' and $gpuApplyStateKnobValue1 != 'none' and $gpuApplyStateKnob2 != 'none' and $gpuApplyStateKnobValue2 != 'none'">
            <knobProperty name="apply_state">
             <xsl:value-of select="concat($gpuApplyStateKnob1, '!=', $gpuApplyStateKnobValue1, ' and ', $gpuApplyStateKnob2, '!=', $gpuApplyStateKnobValue2)"/>
            </knobProperty>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </booleanKnob>
      <booleanKnob id="collectPCIeBW" displayName="%CollectPCIeBandwidth" cliName="collect-pcie-bandwidth">
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'snbep' or exsl:ctx('PMU') = 'ivytown' or exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell_server' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'snowridge' or exsl:ctx('PMU') = 'icelake_server'">
            <xsl:attribute name="boolean:visible">true</xsl:attribute>
            <xsl:choose>
              <xsl:when test="not(exsl:ctx('Hypervisor', 'None') = 'None' or (exsl:ctx('Hypervisor', 'None') = 'Microsoft Hv' and exsl:ctx('HypervisorType', 'None') = 'Hyper-V'))">
                <boolean:defaultValue>false</boolean:defaultValue>
              </xsl:when>
              <xsl:otherwise>
                <boolean:defaultValue>true</boolean:defaultValue>
              </xsl:otherwise>
            </xsl:choose>
            <boolean:defaultValue>true</boolean:defaultValue>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
            <boolean:defaultValue>false</boolean:defaultValue>
          </xsl:otherwise>
        </xsl:choose>
        <description>%CollectPCIeBandwidthDescription</description>
      </booleanKnob>
      <booleanKnob id="collectFrontendBound" displayName="%CollectFrontendBound" cliName="collect-frontend-bound">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectFrontendBoundDescription</description>
      </booleanKnob>
      <booleanKnob id="collectBadSpeculation" displayName="%CollectBadSpeculation" cliName="collect-bad-speculation">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectBadSpeculationDescription</description>
      </booleanKnob>
      <booleanKnob id="collectBackendBoundWIC" displayName="%CollectBackendBoundWIC" cliName="collect-backend_core_memory-bound">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectBackendBoundWICDescription</description>
      </booleanKnob>
      <booleanKnob id="collectBackendBound" displayName="%CollectBackendBound" cliName="collect-backend-bound">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectBackendBoundDescription</description>
      </booleanKnob>
      <booleanKnob id="collectMemoryBound" displayName="%CollectMemoryBound" cliName="collect-memory-bound">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectMemoryBoundDescription</description>
      </booleanKnob>
      <booleanKnob id="collectCoreBound" displayName="%CollectCoreBound" cliName="collect-core-bound">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectCoreBoundDescription</description>
      </booleanKnob>
      <booleanKnob id="collectRetiring" displayName="%CollectRetiring" cliName="collect-retiring">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
        <boolean:defaultValue>true</boolean:defaultValue>
        <description>%CollectRetiringDescription</description>
      </booleanKnob>
      <booleanKnob id="dramBandwidthLimitsAT" displayName="%DramBandwidthLimits" cliName="dram-bandwidth-limits">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='Windows' or exsl:ctx('targetOS')='Linux' or exsl:ctx('targetOS')='QNX'">
            <xsl:attribute name="boolean:visible">true</xsl:attribute>
            <boolean:defaultValue>
              <xsl:value-of select="$defaultMemoryBandwidthLimits"/>
            </boolean:defaultValue>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
            <boolean:defaultValue>false</boolean:defaultValue>
          </xsl:otherwise>
        </xsl:choose>
        <description>%DramBandwidthLimitsDescription</description>
        <xsl:if test="$collectMemoryBandwidthSwitchCheck = 'true'">
          <knobProperty name="active_state">collectMemoryBW=true</knobProperty>
        </xsl:if>
        <xsl:if test="$pmuModeSwitchCheck = 'true'">
          <knobProperty name="active_state">pmuSamplingCountSwitch=detailed</knobProperty>
        </xsl:if>
      </booleanKnob>
      <booleanKnob id="gpuUsageCollection" cliName="enable-gpu-usage">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='Windows'">
            <xsl:attribute name="displayName">%GpuDXCollection</xsl:attribute>
            <xsl:attribute name="boolean:visible">
              <xsl:value-of select="$isGPUUsageVisible"/>
            </xsl:attribute>
            <description>%GpuDXCollectionDescription</description>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="displayName">%IGFXFtraceEventsCollection</xsl:attribute>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
            <xsl:if test="exsl:ctx('targetOS')='Android' or exsl:ctx('targetOS')='Linux' or exsl:ctx('targetOS')='MacOSX'">
              <xsl:attribute name="boolean:visible">
                <xsl:value-of select="$isGPUUsageVisible"/>
              </xsl:attribute>
            </xsl:if>
            <description>%IGFXFtraceEventsCollectionDescription</description>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue><xsl:value-of select="$isGPUUsageAvailable = 'true'"/></boolean:defaultValue>
      </booleanKnob>
      <enumKnob id="gpuCountersCollection" displayName="%GpuCountersCollection" cliName="gpu-counters-mode">
        <xsl:attribute name="boolean:visible">
          <xsl:value-of select="exsl:ctx('targetOS')='Windows' or exsl:ctx('targetOS')='Android' or exsl:ctx('targetOS')='Linux' or exsl:ctx('targetOS')='MacOSX' or exsl:ctx('targetOS')='QNX'"/>
        </xsl:attribute>
        <description>%GpuCountersCollectionDescription</description>
        <values>
          <value displayName="%None">none</value>
          <value displayName="%GpuOverview">overview</value>
          <value displayName="%GpuComputeBasic">global-local-accesses</value>
          <xsl:if test="exsl:ctx('gpuPlatformIndex', 0)>=6">
            <value displayName="%GpuComputeExtended">compute-extended</value>
          </xsl:if>
          <xsl:if test="((exsl:ctx('gpuPlatformIndex', 0)>=6) and ((exsl:ctx('targetOS', '')='MacOSX') or ($enableGPURendering='true') or (exsl:is_experimental('gpu-render'))))">
            <value displayName="%GpuRenderBasic">render-basic</value>
          </xsl:if>
          <xsl:if test="exsl:is_experimental('gpu-metrics2')">
            <value displayName="%GpuPreset3">preset3</value>
            <value displayName="%GpuPreset5">preset5</value>
          </xsl:if>
          <xsl:if test="exsl:ctx('connectionType','') != 'ghs'">
            <value displayName="%GpuFullCompute">full-compute</value>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="((exsl:ctx('gpuPlatformIndex', 0)>=6) and ((exsl:ctx('targetOS', '')='MacOSX') or ($enableGPURendering='true') or (exsl:is_experimental('gpu-render'))))">
              <defaultValue>render-basic</defaultValue>
            </xsl:when>
            <xsl:otherwise>
              <defaultValue>overview</defaultValue>
            </xsl:otherwise>
          </xsl:choose>
        </values>
      </enumKnob>
      <doubleKnob id="samplingInterval" displayName="%SamplingInterval" cliName="sampling-interval" boolean:visible="true">
        <xsl:choose>
          <xsl:when test="$pmuSamplingIntervalDescription!='none'">
            <description><xsl:value-of select="concat('%',$pmuSamplingIntervalDescription)"/></description>
          </xsl:when>
          <xsl:otherwise>
            <description>%SamplingIntervalDescription</description>
          </xsl:otherwise>
        </xsl:choose>
        <double:min>0.01</double:min>
        <double:max>1000</double:max>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU')='knl'">
            <double:defaultValue>10</double:defaultValue>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU')='snbep' or exsl:ctx('PMU')='ivytown' or contains(exsl:ctx('PMU'), '_server')">
            <double:defaultValue>5</double:defaultValue>
          </xsl:when>
          <xsl:otherwise>
            <double:defaultValue>1</double:defaultValue>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$pmuModeSwitchCheck = 'true'">
          <knobProperty name="active_state">pmuSamplingCountSwitch=detailed</knobProperty>
        </xsl:if>
        <xsl:if test="$samplingIntervalApplyKnob != 'none' and $samplingIntervalApplyKnobValue != 'none'">
          <knobProperty name="apply_state">
            <xsl:value-of select="concat($samplingIntervalApplyKnob, '=', $samplingIntervalApplyKnobValue)"/>
          </knobProperty>
        </xsl:if>
      </doubleKnob>
      <doubleKnob id="gpuSamplingInterval" displayName="%GpuSamplingInterval" cliName="gpu-sampling-interval">
        <description>%GpuSamplingIntervalDescription</description>
        <double:min>0.1</double:min>
        <double:max>10</double:max>
        <double:defaultValue>1</double:defaultValue>
        <xsl:if test="$gpuApplyStateKnob1 != 'none' and $gpuApplyStateKnobValue1 != 'none' and $gpuApplyStateKnob2 != 'none' and $gpuApplyStateKnobValue2 != 'none'">
          <knobProperty name="apply_state">
            <xsl:value-of select="concat($gpuApplyStateKnob1, '!=', $gpuApplyStateKnobValue1, ' and ', $gpuApplyStateKnob2, '!=', $gpuApplyStateKnobValue2)"/>
          </knobProperty>
        </xsl:if>
      </doubleKnob>
      <booleanKnob id="gpuOpenCLCollection" displayName="%GpuTraceProgrammingAPIs" cliName="collect-programming-api">
        <xsl:attribute name="boolean:visible">
          <xsl:value-of select="$isOpenCLCollectionVisible"/>
        </xsl:attribute>
        <xsl:if test="$gpuApplyStateKnob1 != 'none' and $gpuApplyStateKnobValue1 != 'none' and $gpuApplyStateKnob2 != 'none' and $gpuApplyStateKnobValue2 != 'none'">
          <knobProperty name="apply_state">
            <xsl:value-of select="concat($gpuApplyStateKnob1, '!=', $gpuApplyStateKnobValue1, ' and ', $gpuApplyStateKnob2, '!=', $gpuApplyStateKnobValue2)"/>
          </knobProperty>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='Windows' or exsl:ctx('targetOS', '')='Linux'">
            <description>%GpuOpenCLCollectionDescription</description>
          </xsl:when>
          <xsl:when test="exsl:ctx('targetOS', '')='Android'">
            <xsl:attribute name="displayName">%GPUAndroidRuntimeCollection</xsl:attribute>
            <description>%GPUAndroidRuntimeCollectionDescription</description>
            <experimental>gpu-android-runtimes</experimental>
          </xsl:when>
          <xsl:otherwise>
            <description>%GpuMetalCollectionDescription</description>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="gpuMetalCollection" displayName="%GpuMetalCollection" visible="true" cliName="enable-gpu-metal">
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS', '')='MacOSX'">
            <description>%GpuMetalCollectionDescription</description>
          </xsl:when>
          <xsl:otherwise>
            <xsl:attribute name="boolean:visible">false</xsl:attribute>
          </xsl:otherwise>
        </xsl:choose>
        <boolean:defaultValue>false</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="analyzeCAT" displayName="%AnalyzeCAT" boolean:visible="false" cliName="analyze-cat">
        <xsl:if test="exsl:is_experimental('cat') and exsl:ctx('isCATSupportedByCPU')='true'">
          <xsl:attribute name="boolean:visible">true</xsl:attribute>
        </xsl:if>
        <boolean:defaultValue>false</boolean:defaultValue>
        <description>%AnalyzeCATDescription</description>
      </booleanKnob>
      <booleanKnob id="analyzeOpenMPRegions" displayName="%AnalyzeOpenMPRegions" visible="true" cliName="analyze-openmp">
        <boolean:defaultValue>
          <xsl:value-of select="$defaultAnalyzeOpenMP='true'"/>
        </boolean:defaultValue>
        <description>%AnalyzeOpenMPRegionsDescription</description>
        <xsl:if test="$pmuModeSwitchCheck = 'true'">
          <knobProperty name="active_state">pmuSamplingCountSwitch=detailed</knobProperty>
        </xsl:if>
      </booleanKnob>
      <intKnob id="samplingInterval" displayName="%SamplingInterval" cliName="sampling-interval">
        <description>%SamplingIntervalDescription</description>
        <int:min>1</int:min>
        <int:max>1000</int:max>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU')='knl'">
            <int:defaultValue>20</int:defaultValue>
          </xsl:when>
          <xsl:otherwise>
            <int:defaultValue>10</int:defaultValue>
          </xsl:otherwise>
        </xsl:choose>
      </intKnob>
      <booleanKnob id="isUArchUsageAvailable" visible="false">
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
      <xsl:variable name="commonDoc" select="document('config://collector/include/common.xsl')"/>
      <xsl:variable name="isPerfAvailable" select="string($commonDoc//common/variables/isPerfAvailable)"/>
      <xsl:variable name="usePerfForStacks" select="$commonDoc//common/variables/usePerfForStacks"/>
      <enumKnob id="stackSizeCollect" displayName="%StackSize" cliName="stack-size" visible="true">
        <xsl:if test="not($isPerfAvailable)">
          <xsl:attribute name="boolean:visible">false</xsl:attribute>
        </xsl:if>
        <knobProperty name="active_state">enableStackCollection=true</knobProperty>
        <description>%StackSizeDescriptionAT</description>
        <values>
          <value displayName="%StackSizeUnlimitedValue" cliName="0">0</value>
          <value displayName="1024" cliName="1024">1024</value>
          <value displayName="2048" cliName="2048">2048</value>
          <value displayName="4096" cliName="4096">4096</value>
          <xsl:choose>
            <xsl:when test="(exsl:ctx('targetOS', '')='Linux' or exsl:ctx('targetOS', '')='Android')">
              <xsl:choose>
                <xsl:when test="$usePerfForStacks='false' or $forceUnlimitedStack='true'">
                  <defaultValue>0</defaultValue>
                </xsl:when>
                <xsl:otherwise>
                  <defaultValue>1024</defaultValue>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
              <defaultValue>0</defaultValue>
            </xsl:otherwise>
          </xsl:choose>
        </values>
      </enumKnob>
      <stackSizeKnobLogic>
        <xsl:if test="$isPerfAvailable">
          <xsl:choose>
            <xsl:when test="not(exsl:ctx('isVTSSPPDriverAvailable', 0)) and
                            exsl:ctx('enableStackCollect', 0) and
                            exsl:ctx('stackSizeCollect', 0)=0">
              <xsl:value-of select="exsl:warning('%PerfResettingStackSize')"/>
              <collectorKnob knob="stackSize">1024</collectorKnob>
            </xsl:when>
            <xsl:otherwise>
              <collectorKnob knob="stackSize"><xsl:value-of select="exsl:ctx('stackSizeCollect', 0)"/></collectorKnob>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="exsl:ctx('stackSizeCollect', 0)!=0">
            <collectorKnob knob="stackTypeCollect">software_lbr</collectorKnob>
            <xsl:variable name="kernelVersion" select="string(exsl:ctx('LinuxRelease', ''))"/>
            <xsl:if test="$kernelVersion">
              <xsl:variable name="currentKernelVersions" select="str:tokenize($kernelVersion, '.-')"/>
              <xsl:if test="(number($currentKernelVersions[1]) &gt; number(4)) or
                            ((number($currentKernelVersions[1]) = number(4)) and
                             (number($currentKernelVersions[2]) &gt;= number(17)))">
                <boolean:collectorKnob knob="perfPreferPerCpuSamplingMode">false</boolean:collectorKnob>
              </xsl:if>
            </xsl:if>
          </xsl:if>
        </xsl:if>
      </stackSizeKnobLogic>
      <booleanKnob id="useAggregatedCountingMode" displayName="%UseAggregatedCountingMode" cliName="aggregated-counting-mode">
        <description>%UseAggregatedCountingModeDescription</description>
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
      <booleanKnob id="useGpuCountingMode" displayName="%UseGpuCountingMode" cliName="gpu-counting">
        <xsl:if test="$hideKnobInPerfsnapshot = 'true'">
          <xsl:attribute name="boolean:visible">false</xsl:attribute>
        </xsl:if>
        <description>%UseGpuCountingModeDescription</description>
        <boolean:defaultValue>true</boolean:defaultValue>
      </booleanKnob>
    </knobs>
  </xsl:template>
</xsl:stylesheet>
