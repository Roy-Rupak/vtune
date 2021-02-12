<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:unsignedLong="http://www.w3.org/2001/XMLSchema#unsignedLong" xmlns:str="http://exslt.org/strings" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace="" syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="runtool"/>
  <xsl:param name="isVTSSFlow">false</xsl:param>
  <xsl:variable name="pmuCommon" select="document('config://include/pmu_common.xsl')"/>
  <xsl:variable name="refClkEvent" select="$pmuCommon//variables/refClockticksEvent"/>
  <xsl:variable name="clkEvent" select="$pmuCommon//variables/clockticksEvent"/>
  <xsl:variable name="factorFromRefClkToTsc" select="$pmuCommon//variables/factorFromRefClkToTsc"/>
  <xsl:variable name="takenBranchesEventName" select="$pmuCommon//variables/takenBranchesEvent/name"></xsl:variable>
  <xsl:variable name="takenBranchesEventCfg" select="concat($pmuCommon//variables/takenBranchesEvent/name, $pmuCommon//variables/takenBranchesEvent/modifiers)"></xsl:variable>
  <xsl:variable name="latencyEvents" select="$pmuCommon//variables/latencyEvents"/>
  <xsl:variable name="muxRatioFixedEventName" select="$pmuCommon//variables/muxRatioFixedEvent/name"></xsl:variable>
  <xsl:variable name="muxRatioProgrEventName" select="$pmuCommon//variables/muxRatioProgrEvent/name"></xsl:variable>
  <xsl:decimal-format name="double-en" decimal-separator="." grouping-separator=""/>
  <xsl:template match="/">
    <common>
      <xsl:variable name="forceSystemWide" select="exsl:ctx('systemWideDiskIO', 0) or
                                                   exsl:ctx('systemWideGR', 0) or
                                                   exsl:ctx('forceSystemWide', 0)"/>
      <xsl:variable name="isSystemWideUserChosen" select="exsl:ctx('targetType', '') = 'system'
                                                         or exsl:ctx('analyzeSystemWide', 0)"/>
      <xsl:variable name="isSystemWide" select="$isSystemWideUserChosen or $forceSystemWide"/>
      <collector>
        <xsl:if test="exsl:ctx('allowMultipleRuns', 0)">
          <collectorOption option="allow-multiple-runs"/>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="exsl:ctx('ringBuffer', 0) > 0 or exsl:ctx('targetRingBuffer', 0) > 0">
            <xsl:if test="exsl:ctx('allowMultipleRuns', 0)">
              <xsl:value-of select="exsl:error('%RingBufferUnsupportedMultipleRunsMode')"/>
            </xsl:if>
            <collectorOption option="data-limit-mb">0</collectorOption>
            <collectorOption option="ring-buffer">
              <xsl:choose>
               <xsl:when test="exsl:ctx('ringBuffer', 0) > 0">
                 <xsl:value-of select="exsl:ctx('ringBuffer', 0)"/>
                </xsl:when>
                <xsl:otherwise>
                 <xsl:value-of select="format-number(exsl:ctx('targetRingBuffer', 0), '#.####')"/>
                </xsl:otherwise>
              </xsl:choose>
            </collectorOption>
          </xsl:when>
          <xsl:otherwise>
            <collectorOption option="data-limit-mb">
                 <xsl:value-of select="exsl:ctx('dataLimit', 0)"/>
            </collectorOption>
          </xsl:otherwise>
        </xsl:choose>
        <collectorOption option="disk-space-limit">0</collectorOption>
        <xsl:if test="exsl:ctx('collectFPGAOpenCl', 'false')='true'">
          <xsl:if test="exsl:ctx('fpgaOnBoard', 'None') = 'None'">
            <xsl:value-of select="exsl:error('%FPGADeviceNotFound')"/>
          </xsl:if>
          <xsl:if test="exsl:ctx('targetType')='system'">
            <xsl:value-of select="exsl:error('%RunssUnsupportedTargetType')"/>
          </xsl:if>
          <collectorOption option="type">opencl</collectorOption>
          <collectorOption option="itt-config">task</collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('analyzeEnergyConsumption', 0)">
          <xsl:if test="exsl:ctx('targetOS') = 'Windows' and not(exsl:ctx('isEnergyCollectionSupported', 1))">
            <xsl:value-of select="exsl:error('%AdministratorPrivilegesForEnergy')"/>
          </xsl:if>
          <xsl:if test="exsl:ctx('targetOS') = 'Linux' and not(exsl:ctx('isEnergyCollectionSupported', 1))">
            <xsl:value-of select="exsl:error('%RootPrivilegesForEnergy')"/>
          </xsl:if>
          <xsl:if test="not(exsl:ctx('isSocwatchDriverLoaded', 0))">
            <xsl:value-of select="exsl:error('%SocwatchDriverIsNotLoaded')"/>
          </xsl:if>
          <xsl:if test="exsl:ctx('OSBitness', '')='32'">
            <xsl:value-of select="exsl:error('%EnergyUnsupportedForX86')"/>
          </xsl:if>
          <collectorOption option="pwr-config">power</collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('targetOS')='Windows' or exsl:ctx('targetOS')='Linux' or exsl:ctx('targetOS')='Android'">
            <xsl:if test="exsl:ctx('collectGpuOpenCl', 0)">
              <xsl:if test="exsl:ctx('targetType', '') = 'attach' and exsl:ctx('isPtraceScopeLimited', 0) and not(exsl:ctx('RootPrivileges', 0))">
                <xsl:value-of select="exsl:error('%RunssPtraceScopeLimited')"/>
              </xsl:if>
              <xsl:if test="exsl:ctx('openclSourceAsm', 0)">
                <xsl:choose>
                  <xsl:when test="exsl:ctx('targetOS')='Windows' and not(exsl:ctx('isGENDebugInfoAvailable', 0))">
                    <xsl:value-of select="exsl:warning('%GENDebugInfoIsNotAvailable')"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <collectorOption option="type">opencl_ex</collectorOption>
                    <xsl:if test="exsl:ctx('gpuCounters', 'none')='none' and exsl:ctx('isGpuHWMetricsCollectionPossible', 'true')='true' and not(exsl:ctx('disableGPUSysinfo'))">
                      <collectorOption option="gpu-config">sysinfo</collectorOption>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
              <collectorOption option="type">opencl,mediasdk</collectorOption>
              <xsl:if test="exsl:ctx('collectGpuLevelZero', 0)">
                <collectorOption option="type">level_zero</collectorOption>
              </xsl:if>
              <xsl:if test="exsl:ctx('targetOS')='Windows' or exsl:ctx('targetOS')='Linux'">
                <xsl:choose>
                  <xsl:when test="exsl:is_experimental('opencl-trace-epoch')">
                    <collectorOption option="opencl-trace-mode">epoch</collectorOption>
                  </xsl:when>
                  <xsl:when test="exsl:is_experimental('opencl-trace-completion')">
                    <collectorOption option="opencl-trace-mode">completion</collectorOption>
                  </xsl:when>
                  <xsl:otherwise>
                    <collectorOption option="opencl-trace-mode">default</collectorOption>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
              <collectorOption option="itt-config">task</collectorOption>
            </xsl:if>
          <xsl:if test="exsl:ctx('collectGpuCm', 0) and exsl:ctx('targetOS')='Windows'">
            <xsl:choose>
              <xsl:when test="exsl:ctx('isMdfEtwAvailable', 0)">
                <collectorOption option="stdsrc-config">mdf</collectorOption>
              </xsl:when>
              <xsl:otherwise>
                <collectorOption option="type">cm</collectorOption>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('targetOS', '')='Android'">
          <xsl:if test="exsl:ctx('collectGpuOpenCl', 0) and exsl:is_experimental('gpu-android-runtimes')">
            <xsl:if test="exsl:ctx('targetType', '') = 'attach' and exsl:ctx('isPtraceScopeLimited', 0) and not(exsl:ctx('RootPrivileges', 0))">
              <xsl:value-of select="exsl:error('%RunssPtraceScopeLimited')"/>
            </xsl:if>
            <collectorOption option="ptrace">opencl</collectorOption>
            <collectorOption option="itt-config">task,frame</collectorOption>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('targetOS', '')='MacOSX'">
          <xsl:if test="exsl:ctx('collectGpuMetal', 0)">
            <collectorOption option="type">metal</collectorOption>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('targetOS', '')='Linux' or exsl:ctx('targetOS')='Windows'">
          <xsl:if test="exsl:ctx('collectGpuLevelZero', 0)">
            <collectorOption option="type">level_zero</collectorOption>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('targetOS')='Windows' or exsl:ctx('targetOS')='Android' or exsl:ctx('targetOS')='Linux' or exsl:ctx('targetOS')='MacOSX' or exsl:ctx('targetOS')='QNX'">
          <xsl:if test="exsl:ctx('gpuCounters','none')!='none' and exsl:ctx('gpuCounters','none')!='off' and exsl:ctx('gpuCounters', 0)">
             <xsl:variable name="gpuPreset">
              <xsl:choose>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'frequency'">
                  <item>frequency</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'overview'">
                  <item>preset1</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'global-local-accesses'">
                  <item>preset2</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'compute-extended'">
                  <item>preset7</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'preset3'">
                  <item>preset3</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'render-basic'">
                  <item>preset4</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'preset5'">
                  <item>preset5</item>
                </xsl:when>
                <xsl:when test="exsl:ctx('gpuCounters','none') = 'full-compute'">
                  <item>preset1</item>
                  <item>preset2</item>
                </xsl:when>
                <xsl:otherwise>
                  <item>none</item>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:variable name="GPUMetricsDisabledInBios">
              <xsl:choose>
                <xsl:when test="exsl:ctx('isPAVPEnabled', 0) and (exsl:ctx('gpuPlatformIndex', 0)=4 or exsl:ctx('gpuPlatformIndex', 0)=8)">
                  true
                </xsl:when>
                <xsl:otherwise>false</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:if test="exsl:ctx('GPUMetricsDisabledInBios', 'false') = 'true'">
              <xsl:value-of select="exsl:warning('%GpuMetricsDisabledInBios')"/>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="exsl:ctx('isGpuHWMetricsCollectionPossible', 'true') = 'true'">
                <xsl:choose>
                  <xsl:when test="(exsl:ctx('gpuCounters','none') = 'full-compute') and not(exsl:ctx('allowMultipleRuns', 0))">
                    <xsl:variable name="gpuConfigurationError">%GpuFullComputeSetNeedsMultipleRunsMode</xsl:variable>
                    <xsl:choose>
                      <xsl:when test="exsl:ctx('errorsAsWarnings', 0)">
                        <xsl:value-of select="exsl:warning($gpuConfigurationError)"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="exsl:error($gpuConfigurationError)"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:for-each select="exsl:node-set($gpuPreset)/item">
                      <xsl:variable name="text">
                        <xsl:value-of select="current()"/>
                        <xsl:text>:timer=</xsl:text>
                        <xsl:value-of select="format-number(exsl:ctx('gpuSamplingInterval', 1) * 1000, '#')"/>
                        <xsl:text>us</xsl:text>
                      </xsl:variable>
                      <collectorOption option="gpu-config">
                        <xsl:value-of select="$text"/>
                      </collectorOption>
                      <xsl:if test="exsl:ctx('useGpuCounting', 0)">
                        <collectorOption option="gpu-counting"/>
                      </xsl:if>
                    </xsl:for-each>
                    <xsl:if test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true')='RemoteDesktopWarning'">
                      <xsl:value-of select="exsl:warning('%GpuRemoteDesktopWarning')"/>
                    </xsl:if>
                    <xsl:if test="exsl:ctx('i915Status', 'true') = 'DriverInCustomLocation'">
                      <xsl:value-of select="exsl:warning('%i915InCustomLocationWarning')"/>
                    </xsl:if>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:variable name="gpuDriverError">
                  <xsl:if test="exsl:ctx('targetOS')='Linux' and exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'UnsupportedInterfaceVersion'">
                    <xsl:choose>
                      <xsl:when test="exsl:ctx('i915Status', 'true') = 'MissingDriver'">
                        %GpuMissingDriver
                      </xsl:when>
                      <xsl:when test="exsl:ctx('i915Status', 'true') = 'InsufficientPermissions'">
                        %GpuInsufficientPermissionsLinux
                      </xsl:when>
                      <xsl:when test="exsl:ctx('i915Status', 'true') = 'KernelNotPatched'">
                        %GpuKernelNotPatched
                      </xsl:when>
                    </xsl:choose>
                  </xsl:if>
                </xsl:variable>
                <xsl:if test="$gpuDriverError != ''">
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('errorsAsWarnings', 0)">
                      <xsl:value-of select="exsl:warning($gpuDriverError)"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="exsl:error($gpuDriverError)"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
                <xsl:variable name="kernelVersion" select="string(exsl:ctx('LinuxRelease', ''))"/>
                <xsl:variable name="currentKernelVersions" select="str:tokenize($kernelVersion, '.-')"/>
                <xsl:variable name="isLinuxKernel4p14OrGreater" select="(number($currentKernelVersions[1]) &gt; number(4)) or
                   (number($currentKernelVersions[1]) = number(4) and (number($currentKernelVersions[2]) &gt;= number(14)))"/>
                <xsl:variable name="gpuHwMetricsError">
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('selectedGPUAdapter', 'true') = 'GPUNotFound'">
                      %GpuDriverNotResponding
                    </xsl:when>
                    <xsl:when test="exsl:ctx('selectedGPUAdapter', 'true') = 'InvalidBDFValue'">
                      %SelectedGpuNotFound
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'NotSelectedAdapter'">
                      %MetricsNotAvailableForSelectedGpu
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'RemoteDesktopError'">
                      %GpuRemoteDesktopError
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'DriverNotResponding'">
                      %GpuDriverNotResponding
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'UnsupportedHardware'">
                      %GpuUnsupportedHardware
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'InsufficientPermissions'">
                      <xsl:choose>
                        <xsl:when test="exsl:ctx('targetOS')='Linux'">
                          %GpuInsufficientPermissionsLinux
                        </xsl:when>
                        <xsl:otherwise>
                          %GpuInsufficientPermissions
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="(exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'KernelNotPatched') and
                                    not($isLinuxKernel4p14OrGreater)">
                      %GpuKernelNotPatched
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'LibNotFound'">
                      <xsl:choose>
                        <xsl:when test="exsl:ctx('targetOS')='Linux'">
                          <xsl:choose>
                            <xsl:when test="$isLinuxKernel4p14OrGreater">
                              %GpuLibNotFoundLinuxNewKernel
                            </xsl:when>
                            <xsl:otherwise>
                              %GpuLibNotFoundLinux
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:when>
                        <xsl:when test="exsl:ctx('targetOS')='Windows'">
                          %GpuLibNotFoundWindows
                        </xsl:when>
                        <xsl:otherwise>
                          %GpuLibNotFound
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'LibLoadFailed'">
                      <xsl:choose>
                        <xsl:when test="exsl:ctx('targetOS')='Linux'">
                          <xsl:choose>
                            <xsl:when test="$isLinuxKernel4p14OrGreater">
                              %GpuLibLoadFailedLinuxNewKernel
                            </xsl:when>
                            <xsl:otherwise>
                              %GpuLibLoadFailedLinux
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:when>
                        <xsl:when test="exsl:ctx('targetOS')='Windows'">
                          %GpuLibLoadFailedWindows
                        </xsl:when>
                        <xsl:otherwise>
                          %GpuLibLoadFailed
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'UnsupportedInterfaceVersion'">
                      <xsl:choose>
                        <xsl:when test="(exsl:ctx('targetOS')='Linux') and ($isLinuxKernel4p14OrGreater)">
                          %GpuUnsupportedInterfaceVersionLinuxNewKernel
                        </xsl:when>
                        <xsl:when test="(exsl:ctx('targetOS')='Linux') and not($isLinuxKernel4p14OrGreater)">
                          %GpuUnsupportedInterfaceVersionLinux
                        </xsl:when>
                        <xsl:when test="exsl:ctx('targetOS')='Windows'">
                          %GpuUnsupportedInterfaceVersionWindows
                        </xsl:when>
                        <xsl:otherwise>
                          %GpuUnsupportedInterfaceVersion
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'InitializationError'">
                      <xsl:choose>
                        <xsl:when test="exsl:ctx('targetOS')='Linux'">
                          <xsl:choose>
                            <xsl:when test="$isLinuxKernel4p14OrGreater">
                              %GpuLibInitErrorLinuxNewKernel
                            </xsl:when>
                            <xsl:otherwise>
                              <xsl:choose>
                                <xsl:when test="contains(exsl:ctx('LinuxRelease', ''), '3.10')   or
                                                contains(exsl:ctx('LinuxRelease', ''), '3.14.5') or
                                                contains(exsl:ctx('LinuxRelease', ''), '4.4')    or
                                                contains(exsl:ctx('LinuxRelease', ''), '4.7')">
                                  %GpuLibInitErrorLinux
                                </xsl:when>
                                <xsl:otherwise>
                                  %GpuKernelNotSupported
                                </xsl:otherwise>
                              </xsl:choose>
                            </xsl:otherwise>
                          </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>
                          %GpuCountersNotSupported
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'valueNotPresent'">
                        %GpuCountersAgentNotAvailable
                    </xsl:when>
                    <xsl:when test="exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true') = 'false'">
                        %GpuCountersNotSupported
                    </xsl:when>
                  </xsl:choose>
                </xsl:variable>
                <xsl:if test="$gpuHwMetricsError != ''">
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('errorsAsWarnings', 0)">
                      <xsl:value-of select="exsl:warning($gpuHwMetricsError)"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="exsl:error($gpuHwMetricsError)"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
               </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('mrteMode', '') != 'native'">
          <collectorOption option="mrte-type"><xsl:copy-of select="exsl:ctx('mrteType', '')"/></collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('collectOpenMPRegions', 0)">
          <collectorOption option="itt-config">openmp</collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('noCollectionMode',0) and (exsl:ctx('PMU') = 'knl') and (exsl:ctx('finalizationModeknl','full') = 'full')">
          <xsl:value-of select="exsl:warning('%RecomedndFinalizationModeDeferred')"/>
        </xsl:if>
        <xsl:if test="exsl:ctx('collectMemObjects', 0)">
         <xsl:choose>
          <xsl:when test="exsl:ctx('allowMultipleRuns', 0)">
           <xsl:value-of select="exsl:error('%MemObjectsUnsupportedMultipleRunsMode')"/>
          </xsl:when>
          <xsl:otherwise>
           <collectorOption option="type">
            <xsl:text>memory</xsl:text>
           </collectorOption>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:if>
        <xsl:if test="exsl:ctx('collectMemObjects', 0)">
          <collectorOption option="memory-strategy">
            <xsl:text>obj-size-min=</xsl:text>
            <xsl:copy-of select="exsl:ctx('memoryObjectMinSize', 1)"/>
            <xsl:text>,hash-table-size=0</xsl:text>
          </collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('gpuUsage', 0) and exsl:ctx('targetOS')!='Windows'">
          <xsl:variable name="gpu_usage" select="document('config://analysis_type/include/gpu_usage.xsl?errorLevel=error')"/>
          <xsl:variable name="gpuUsageErrorMessage" select="$gpu_usage//root/variables/gpuUsageErrorMessage"/>
          <xsl:variable name="gpuUsageAvailable" select="$gpu_usage//root/variables/gpuUsageAvailable"/>
          <xsl:if test="not($gpuUsageAvailable = 'true')">
          <xsl:choose>
            <xsl:when test="not(exsl:ctx('errorsAsWarnings', 0))">
              <xsl:value-of select="exsl:error(string($gpuUsageErrorMessage))"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="exsl:warning(string($gpuUsageErrorMessage))"/>
            </xsl:otherwise>
          </xsl:choose>
          </xsl:if>
          <xsl:if test="$gpuUsageAvailable = 'true'">
            <collectorOption option="stdsrc-config">igfx</collectorOption>
            <xsl:if test="exsl:ctx('gpuPlatformIndex', 1) &lt; 6 or exsl:ctx('gpuPlatformIndex', 1) &gt; 9">
              <collectorOption option="stdsrc-config">igfx-wait</collectorOption>
            </xsl:if>
            <xsl:if test="exsl:ctx('gpuCounters', 'none')='none' and exsl:ctx('areGpuHardwareMetricsAvailableKnob', 'true')='true' and not(exsl:ctx('disableGPUSysinfo', 0))">
              <collectorOption option="gpu-config">sysinfo</collectorOption>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="exsl:ctx('isVSyncAvailable', 'no')='yes'">
                <collectorOption option="stdsrc-config">vsync</collectorOption>
              </xsl:when>
              <xsl:when test="exsl:ctx('isVSyncAvailable', 'no')='no'">
                <xsl:if test="not(exsl:is_experimental('platform-profiling'))">
                  <xsl:value-of select="exsl:warning('%VSyncNotAvailable')"/>
                </xsl:if>
              </xsl:when>
            </xsl:choose>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('collectGpuOpenCl', 0) or exsl:ctx('collectGpuMetal', 0)">
          <collectorOption option="gpu-kernels-to-profile">
           <xsl:variable name="kernelsFilter">
            <xsl:for-each select="str:tokenize(exsl:ctx('kernelsToProfile',''), ',')">
              <xsl:variable name="kernelConfig">
                <xsl:value-of select="."/>
              </xsl:variable>
              <xsl:variable name="kernelConfigs">
                  <xsl:if test="not(contains($kernelConfig, '#'))">
                    <xsl:value-of select="concat($kernelConfig, '#1#1#4294967295')"/>
                  </xsl:if>
                  <xsl:if test="contains(exsl:ctx('kernelsToProfile'), '#')">
                    <xsl:value-of select="$kernelConfig"/>
                  </xsl:if>
              </xsl:variable>
            </xsl:for-each>
           </xsl:variable>
            <xsl:value-of select="exsl:ctx('kernelsToProfile','')"/>
          </collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('isGTPinCollectionAvailable', 'valueNotPresent')='true'">
          <collectorOption option="gpu-profiling-type">
            <xsl:value-of select="exsl:ctx('gpuProfilingMode', '')"/>
          </collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('enableThreadAffinity', 0)">
          <xsl:if test="exsl:ctx('targetType', '') = 'system'">
            <xsl:value-of select="exsl:error('%AffinitySystemWidetargetError')"/>
          </xsl:if>
          <xsl:if test="exsl:ctx('analyzeSystemWide', 0)">
            <xsl:value-of select="exsl:error('%AffinityAnalyzeSystemError')"/>
          </xsl:if>
          <collectorOption option="ptrace">thread_affinity</collectorOption>
        </xsl:if>
        <xsl:if test="exsl:ctx('enableParallelFsCollection', 0)">
          <xsl:choose>
            <xsl:when test="exsl:ctx('useCountingMode', 0)">
              <collectorOption option="parallel-fs-config">counting</collectorOption>
            </xsl:when>
            <xsl:otherwise test="exsl:ctx('useCountingMode', 0)">
              <collectorOption option="parallel-fs-config">sampling</collectorOption>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <xsl:if test="exsl:ctx('useAOCLProfile', 0)">
          <xsl:if test="exsl:ctx('fpgaOnBoard', 'None') = 'None'">
            <xsl:value-of select="exsl:error('%FPGADeviceNotFound')"/>
          </xsl:if>
          <xsl:if test="not(exsl:ctx('isAOCLAvailable', 0))">
            <xsl:value-of select="exsl:error('%FPGAAoclNotAvailable')"/>
          </xsl:if>
          <collectorOption option="aocl-profile"/>
          <xsl:if test="not(exsl:ctx('fpgaSourceFile', '') = '')">
            <collectorOption option="aocl-source-file">
              <xsl:value-of select="exsl:ctx('fpgaSourceFile', '')"/>
            </collectorOption>
          </xsl:if>
        </xsl:if>
        <xsl:if test="exsl:ctx('wrapperScriptPath') or exsl:ctx('wrapperScriptContent')">
          <collectorOption option="wrapper-script">
            <xsl:choose>
              <xsl:when test="exsl:ctx('wrapperScriptPath')">
                <xsl:choose>
                  <xsl:when test="exsl:readFileContent(exsl:ctx('wrapperScriptPath'))">
                    <xsl:value-of select="exsl:base64Encode(exsl:readFileContent(exsl:ctx('wrapperScriptPath')))"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="exsl:error('%ReadWrapperScriptFileContentError')"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="exsl:base64Encode(exsl:ctx('wrapperScriptContent'))"/>
              </xsl:otherwise>
            </xsl:choose>
          </collectorOption>
        </xsl:if>
      </collector>
      <finalization>
        <loadParameters id="load">
          <unsignedLong:loadOption option="iptRegionsToLoad">
            <xsl:value-of select="exsl:ctx('iptRegionsToLoad', 0)"/>
          </unsignedLong:loadOption>
          <boolean:loadOption option="processKernelBinaries">
            <xsl:value-of select="exsl:ctx('processKernelBinaries', 0)"/>
          </boolean:loadOption>
          <unsignedLong:loadOption option="samplesToLoad">
            <xsl:choose>
              <xsl:when test="exsl:ctx('finalizationMode', 'fast') = 'fast'">
                5000000
              </xsl:when>
              <xsl:otherwise>
                0
              </xsl:otherwise>
            </xsl:choose>
          </unsignedLong:loadOption>
          <loadOption option="takenBranchesEvent">
            <xsl:value-of select="$takenBranchesEventName"/>
          </loadOption>
          <boolean:loadOption option="enableMemoryUsageDataLoading">
            <xsl:value-of select="exsl:ctx('collectMemObjects', 0) and exsl:ctx('analyzeMemoryConsumption', 0)"/>
          </boolean:loadOption>
          <boolean:loadOption option="OptionLoadLbrStackToDb">
            <xsl:value-of select="exsl:ctx('loadLbrStackToDb', 1)"/>
          </boolean:loadOption>
          <boolean:loadOption option="OptionLoadRawLbrData">
            <xsl:value-of select="exsl:ctx('loadRawLbrData', 1)"/>
          </boolean:loadOption>
          <boolean:loadOption option="OptionLoadStacks">
            <xsl:value-of select="exsl:ctx('enableStackCollection', 0) or exsl:ctx('enableVTSSCollection', 0)"/>
          </boolean:loadOption>
          <int:loadOption option="OptionStackType">
            <xsl:choose>
              <xsl:when test="exsl:ctx('stackTypeCollect', '') = 'software'">0</xsl:when>
              <xsl:when test="exsl:ctx('stackTypeCollect', '') = 'lbr'">1</xsl:when>
              <xsl:when test="exsl:ctx('stackTypeCollect', '') = 'software_lbr'">2</xsl:when>
            </xsl:choose>
          </int:loadOption>
          <boolean:loadOption option="OptionMultipleFrameDomains">true</boolean:loadOption>
          <xsl:choose>
            <xsl:when test="$runtool = 'runss'">
              <boolean:loadOption option="EnableTasksRegionsLoading">true</boolean:loadOption>
            </xsl:when>
            <xsl:otherwise>
              <boolean:loadOption option="enableProcessOfInterestHandling">
                <xsl:value-of select="not($isSystemWide)"/>
              </boolean:loadOption>
            </xsl:otherwise>
          </xsl:choose>
          <loadOption option="OptionLoadMuxRatioFixedEvent">
            <xsl:value-of select="$muxRatioFixedEventName"/>
          </loadOption>
          <loadOption option="OptionLoadMuxRatioProgrEvent">
            <xsl:value-of select="$muxRatioProgrEventName"/>
          </loadOption>
          <int:loadOption option="OptionLoadSkippedFramesThreshold">
            <xsl:value-of select="number(90)"/>
          </int:loadOption>
          <int:loadOption option="HugeResultThresholdMb">
            <xsl:choose>
              <xsl:when test="$runtool = 'runss'">100</xsl:when>
              <xsl:otherwise>250</xsl:otherwise>
            </xsl:choose>
          </int:loadOption>
          <boolean:loadOption option="enableAnalyzeSystemWide">
            <xsl:value-of select="$isSystemWide"/>
          </boolean:loadOption>
          <boolean:loadOption option="systemWideDiskIO">
            <xsl:value-of select="exsl:ctx('systemWideDiskIO', 0)"/>
          </boolean:loadOption>
          <boolean:loadOption option="enableArrayObjectsLoading">
              <xsl:value-of select="exsl:ctx('collectMemObjects', 0)"/>
          </boolean:loadOption>
          <xsl:if test="$runtool = 'runsa' or $runtool = 'sniper'">
            <boolean:loadOption option="loadDiskIO">
              <xsl:value-of select="exsl:ctx('systemWideDiskIO', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enablePebsLoading">
              <xsl:value-of select="exsl:ctx('loadPebsData', 0)"/>
            </boolean:loadOption>
            <int:loadOption option="arrayObjectSizeMinThreshold">
              <xsl:value-of select="exsl:ctx('memoryObjectMinSize', 1)"/>
            </int:loadOption>
            <boolean:loadOption option="arrayObjectGrouper">
              <xsl:value-of select="exsl:ctx('enableMemoryObjectGrouper', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enableTripCounts">
              <xsl:value-of select="exsl:ctx('collectTripCounts', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enableActivePowerConsumptionDataLoading">
              <xsl:value-of select="exsl:ctx('analyzeActivePowerConsumption', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enableIdlePowerConsumptionDataLoading">
              <xsl:value-of select="exsl:ctx('analyzeIdlePowerConsumption', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="OptionEnableThreadNamingAsCreationModule">
              <xsl:value-of select="exsl:ctx('nameThreadsAsCreationModule', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="OptionForceSchedAndCounterMetricsGrouper">
              <xsl:value-of select="exsl:ctx('forceSchedAndCounterMetricsGrouper', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="OptionHandleLostEvents">
              <xsl:value-of select="exsl:ctx('handleLostEvents', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="OptionSuppressCSVSyntaxWarnings">
              <xsl:value-of select="exsl:ctx('suppressCSVSyntaxWarnings', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enablePTHotspots">
              <xsl:value-of select="exsl:ctx('collectFullProcTrace', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enableTSXforPT">
              <xsl:value-of select="exsl:ctx('collectPTforTSX', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enableIoWaitAnalysis">
              <xsl:value-of select="exsl:ctx('collectIoWaits', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="enableIoWaitAnalysisViaFunctions">
              <xsl:value-of select="exsl:ctx('collectIoWaits', 0) and exsl:ctx('isIowaitTracingAvailable', 'yes')='yes'"/>
            </boolean:loadOption>
            <boolean:loadOption option="ignorePowerData">
              <xsl:value-of select="exsl:ctx('ignorePowerData', 0)"/>
            </boolean:loadOption>
            <boolean:loadOption option="OptionForceContextSwitchesLoad">
              <xsl:value-of select="exsl:ctx('systemWideContextSwitch', 0)"/>
            </boolean:loadOption>
            <xsl:if test="exsl:ctx('cswitchMode', 'null') != 'null'">
              <int:loadOption option="WhatToLoadFromContextSwitchData">
                <xsl:choose>
                  <xsl:when test="exsl:ctx('cswitchMode', 'null') = 'none'">0</xsl:when>
                  <xsl:when test="exsl:ctx('cswitchMode', 'null') = 'active'">1</xsl:when>
                  <xsl:when test="exsl:ctx('cswitchMode', 'null') = 'inactive'">2</xsl:when>
                  <xsl:when test="exsl:ctx('cswitchMode', 'null') = 'both'">3</xsl:when>
                </xsl:choose>
              </int:loadOption>
            </xsl:if>
            <xsl:if test="exsl:ctx('gpuUsage', 1)">
              <boolean:loadOption option="OptionEnableGPUQueueFrames">
                <xsl:value-of select="exsl:is_experimental('platform-profiling') or exsl:ctx('createGPUQueueFrames', 0)"/>
              </boolean:loadOption>
            </xsl:if>
            <xsl:if test="exsl:ctx('apsMode', 0)">
                <boolean:loadOption option="OptionEnableApsMode">true</boolean:loadOption>
            </xsl:if>
          </xsl:if>
          <boolean:loadOption option="needRecalculateCollectionBounds">
             <xsl:value-of select="exsl:ctx('adjustCollectionBoundsByOMPApps', 0)"/>
          </boolean:loadOption>
          <loadOption option="androidBoardPlatform">
            <xsl:value-of select="exsl:ctx('androidBoardPlatform', '')"/>
          </loadOption>
          <loadOption option="LauncherName">amplxe-runss</loadOption>
          <loadOption option="OptionLatencyEvents"><xsl:value-of select="$latencyEvents"/></loadOption>
          <loadOption option="OptionReferenceFrequency">
            <xsl:value-of select="format-number(exsl:ctx('referenceFrequency'), '#')"/>
          </loadOption>
          <loadOption option="OptionRefClkEventName">
            <xsl:value-of select="$refClkEvent"/>
          </loadOption>
          <loadOption option="OptionClkEventName">
            <xsl:value-of select="$clkEvent"/>
          </loadOption>
          <loadOption option="OptionFactorFromRefClkToTsc">
            <xsl:value-of select="$factorFromRefClkToTsc"/>
          </loadOption>
          <loadOption option="OptionPStateTriggerEvent">
            <xsl:value-of select="$refClkEvent"/>
          </loadOption>
          <boolean:loadOption option="iptLoadPmuEvents">
            <xsl:value-of select="exsl:ctx('iptCollectEvents', 0)"/>
          </boolean:loadOption>
          <unsignedLong:loadOption option="anomalyRegionBinCount">256</unsignedLong:loadOption>
          <boolean:loadOption option="EnableInterruptsLoading">
            <xsl:value-of select="exsl:ctx('enableInterrupts', 0)"/>
          </boolean:loadOption>
        </loadParameters>
        <transformParameters id="transform">
          <transformation name="Cache instance data" boolean:deferred="true">
            <transformOption option="OptionInstanceTablesToCache">pmu_data,region_data,barrier_data,barrier_imbalance_data,sched_data</transformOption>
          </transformation>
          <xsl:if test="$runtool != 'runss' or exsl:ctx('collectSamplesMode', 'off') != 'off'">
            <xsl:choose>
              <xsl:when test="exsl:ctx('cpuByIoWaits', 0)">
                <transformation name="Compute CPU Usage with IOwaits" boolean:deferred="true">
                  <transformOption option="OptionCPUIoUsageTableName">cpu_io_usage_data</transformOption>
                </transformation>
              </xsl:when>
              <xsl:otherwise>
                <transformation name="Compute CPU Usage" boolean:deferred="true">
                <transformOption option="OptionCPUUsageTableName">cpu_usage_data</transformOption>
                <transformOption option="OptionPMUName">
                  <xsl:value-of select="exsl:ctx('PMU')"/>
                </transformOption>
                <transformOption option="OptionRefClkEventName">
                  <xsl:value-of select="$refClkEvent"/>
                </transformOption>
                <transformOption option="OptionClkEventName">
                  <xsl:value-of select="$clkEvent"/>
                </transformOption>
                <transformOption option="OptionFactorFromRefClkToTsc">
                  <xsl:value-of select="$factorFromRefClkToTsc"/>
                </transformOption>
                <xsl:choose>
                  <xsl:when test="$runtool = 'runss'">
                    <transformOption option="OptionRunningTableName">cpu_data</transformOption>
                  </xsl:when>
                </xsl:choose>
                <boolean:transformOption option="OptionSystemWideContextSwitchEnabled">
                  <xsl:value-of select="exsl:ctx('systemWideContextSwitch', 0)"/>
                </boolean:transformOption>
               </transformation>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>
          <transformation name="Fill Elapsed Time" boolean:deferred="true">
          </transformation>
          <xsl:if test="$runtool = 'runss' and (exsl:ctx('collectWaitsMode', 'off') != 'off' or exsl:ctx('collectIoMode', 'off') != 'off')">
            <transformation name="Compute Concurrency">
              <transformOption option="OptionComputedWaitTableName">wait_data</transformOption>
              <transformOption option="OptionConcurrencyTableName">concurrency_data</transformOption>
            </transformation>
          </xsl:if>
          <xsl:if test="not (exsl:ctx('analyzeFullProcTrace', 0))">
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">
                <xsl:choose>
                  <xsl:when test="$runtool = 'runss'">1</xsl:when>
                  <xsl:otherwise>0</xsl:otherwise>
                </xsl:choose>
              </int:transformOption>
              <transformOption option="OptionInstanceTable">
                <xsl:choose>
                  <xsl:when test="$runtool = 'runss'">cpu_data</xsl:when>
                  <xsl:otherwise>pmu_data</xsl:otherwise>
                </xsl:choose>
              </transformOption>
              <transformOption option="OptionGroupings">
                <xsl:choose>
                  <xsl:when test="$runtool = 'runss'">
                    <xsl:text>cpu_data::dd_sample.callsite.bottom_user_cs.code_loc.mod_seg.mod_file/cpu_data::dd_sample.callsite.type_cs.code_loc.func_range.func_inst.function.subtype/cpu_data::dd_sample.callsite.type_cs.code_loc.func_range.func_inst.function.type/dd_band::dd_thread/dd_band::dd_thread.process</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>dd_band::dd_thread/dd_band::dd_thread.process/pmu_data::dd_sample.callsite.bottom_user_cs.code_loc.mod_seg.mod_file/pmu_data::dd_sample.callsite.type_cs.code_loc.func_range.func_inst.function.subtype/pmu_data::dd_sample.callsite.type_cs.code_loc.func_range.func_inst.function.type/pmu_data::dd_sample.cpu/pmu_data::dd_sample.cpu.core/pmu_data::dd_sample.cpu.core.package/pmu_data::dd_sample.event_type</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </transformOption>
            </transformation>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="$runtool = 'runss'">
              <transformation name="Fill timeline db" boolean:deferred="true">
                <int:transformOption option="OptionType">2</int:transformOption>
                <transformOption option="OptionInstanceTable">wait_data</transformOption>
                <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
              </transformation>
            </xsl:when>
            <xsl:otherwise>
              <transformation name="Fill timeline db" boolean:deferred="true">
                <int:transformOption option="OptionType">2</int:transformOption>
                <transformOption option="OptionInstanceTable">sched_data</transformOption>
                <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
              </transformation>
            </xsl:otherwise>
          </xsl:choose>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">0</int:transformOption>
            <transformOption option="OptionInstanceTable">device_counter_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_device_info/device_counter_data::dd_counter.type</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">1</int:transformOption>
            <transformOption option="OptionInstanceTable">device_time_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_device_info/device_time_data::dd_counter.type</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">3</int:transformOption>
            <transformOption option="OptionInstanceTable">device_task_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_device_info</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">0</int:transformOption>
            <transformOption option="OptionInstanceTable">fpga_samples_data</transformOption>
            <transformOption option="OptionGroupings">fpga_samples_data::dd_compute_sample.compute_task.type/fpga_samples_data::dd_compute_sample.event_type/fpga_samples_data::dd_compute_sample.compute_channel/fpga_samples_data::dd_compute_sample.compute_channel.mem_type/fpga_samples_data::dd_compute_sample.compute_channel.operation_type</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">2</int:transformOption>
            <transformOption option="OptionInstanceTable">ipt_region_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">2</int:transformOption>
            <transformOption option="OptionInstanceTable">task_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">3</int:transformOption>
            <transformOption option="OptionInstanceTable">task_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
          </transformation>
          <xsl:if test="$runtool != 'runsa_knc'">
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">0</int:transformOption>
              <transformOption option="OptionInstanceTable">gpu_data</transformOption>
              <transformOption option="OptionGroupings">gpu_data::dd_sample.uncore_event_type</transformOption>
            </transformation>
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">1</int:transformOption>
              <transformOption option="OptionInstanceTable">gpu_compute_task_data</transformOption>
              <transformOption option="OptionGroupings"></transformOption>
            </transformation>
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">2</int:transformOption>
              <transformOption option="OptionInstanceTable">gpu_compute_task_data</transformOption>
              <transformOption option="OptionGroupings">gpu_compute_task_data::dd_compute_task.queue/gpu_compute_task_data::dd_compute_task.submit_thread</transformOption>
            </transformation>
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">3</int:transformOption>
              <transformOption option="OptionInstanceTable">compute_task_queue_data</transformOption>
              <transformOption option="OptionGroupings">compute_task_queue_data::dd_compute_task.queue</transformOption>
            </transformation>
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">2</int:transformOption>
              <transformOption option="OptionInstanceTable">dma_packet_data</transformOption>
              <transformOption option="OptionGroupings">dd_band::dd_gpu_node</transformOption>
            </transformation>
            <transformation name="Fill timeline db" boolean:deferred="true">
              <int:transformOption option="OptionType">3</int:transformOption>
              <transformOption option="OptionInstanceTable">dma_queue_data</transformOption>
              <transformOption option="OptionGroupings">dd_band::dd_gpu_node</transformOption>
            </transformation>
          </xsl:if>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">0</int:transformOption>
            <transformOption option="OptionInstanceTable">uncore_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_package/uncore_data::dd_uncore_sample.uncore_event_type/uncore_data::dd_uncore_sample.pci_device_info/uncore_data::dd_uncore_sample.uncore_event_type.unit</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">0</int:transformOption>
            <transformOption option="OptionInstanceTable">global_counter_data</transformOption>
            <transformOption option="OptionGroupings">global_counter_data::dd_counter.type</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">0</int:transformOption>
            <transformOption option="OptionInstanceTable">counter_data</transformOption>
            <transformOption option="OptionGroupings">counter_data::dd_counter.type/dd_band::dd_thread/dd_band::dd_thread.process</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">2</int:transformOption>
            <transformOption option="OptionInstanceTable">region_data</transformOption>
            <transformOption option="OptionGroupings"></transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">3</int:transformOption>
            <transformOption option="OptionInstanceTable">ipt_module_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
          </transformation>
          <transformation name="Fill timeline db" boolean:deferred="true">
            <int:transformOption option="OptionType">2</int:transformOption>
            <transformOption option="OptionInstanceTable">ipt_tip_data</transformOption>
            <transformOption option="OptionGroupings">dd_band::dd_thread</transformOption>
          </transformation>
          <transformation name="Fill duration bins" boolean:suppressErrors="true" boolean:deferred="false">
            <transformOption option="OptionBinValueTable">dd_region_bin</transformOption>
            <transformOption option="OptionObjectTable">dd_region</transformOption>
            <transformOption option="OptionDomainColumn">domain</transformOption>
            <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <transformation name="Fill duration bins" boolean:suppressErrors="true" boolean:deferred="false">
            <transformOption option="OptionBinValueTable">dd_task_duration_bin</transformOption>
            <transformOption option="OptionObjectTable">dd_task</transformOption>
            <transformOption option="OptionDomainColumn">type</transformOption>
            <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <transformation name="Fill duration bins" boolean:suppressErrors="true" boolean:deferred="false">
            <transformOption option="OptionBinValueTable">dd_interrupt_duration_bin</transformOption>
            <transformOption option="OptionObjectTable">dd_interrupt</transformOption>
            <transformOption option="OptionDomainColumn">id</transformOption>
            <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <transformation name="Fill duration bins" boolean:suppressErrors="true" boolean:deferred="false">
              <transformOption option="OptionBinValueTable">dd_io_operation_duration_bin</transformOption>
              <transformOption option="OptionObjectTable">dd_io_operation</transformOption>
              <transformOption option="OptionDomainColumn">type</transformOption>
              <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <transformation name="Fill bins by attribute column" boolean:suppressErrors="true" boolean:deferred="false">
            <transformOption option="OptionBinValueTable">dd_spdk_io_bandwidth_bin</transformOption>
            <transformOption option="OptionObjectTable">dd_spdk_io_sample</transformOption>
            <transformOption option="OptionDomainColumn">device</transformOption>
            <transformOption option="OptionValueColumn">bandwidth</transformOption>
            <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <transformation name="Fill duration bins" boolean:suppressErrors="true" boolean:deferred="false">
            <transformOption option="OptionBinValueTable">dd_spdk_io_latency_bin</transformOption>
            <transformOption option="OptionObjectTable">dd_spdk_io_sample</transformOption>
            <transformOption option="OptionDomainColumn">device</transformOption>
            <transformOption option="OptionValueColumn">latency</transformOption>
            <transformOption option="OptionBinColumn">latency_bin</transformOption>
            <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <transformation name="Fill duration bins" boolean:deferred="false">
              <transformOption option="OptionBinValueTable">dd_dma_packet_duration_bin</transformOption>
              <transformOption option="OptionObjectTable">dd_dma_packet</transformOption>
              <transformOption option="OptionDomainColumn">perf_tag</transformOption>
              <transformOption option="OptionObjectDomainColumn">perf_tag</transformOption>
              <int:transformOption option="OptionMaxBinNum">20</int:transformOption>
          </transformation>
          <xsl:if test="$runtool = 'runsa'">
            <transformation name="HBM Memory Mode" boolean:deferred="true">
              <transformOption option="OptionUncEEdcAccessMissDirty">UNC_E_EDC_ACCESS.MISS_DIRTY_ALL_UNITS</transformOption>
              <transformOption option="OptionUncEEdcAccessMissClean">UNC_E_EDC_ACCESS.MISS_CLEAN_ALL_UNITS</transformOption>
            </transformation>
          </xsl:if>
          <xsl:if test="$runtool = 'runsa'">
            <transformation name="3DXP Memory Mode" boolean:deferred="true">
              <transformOption option="Option3DXPAccesses">APDataTransferredGB</transformOption>
              <transformOption option="Option2LMMisses">2LMCacheMisses</transformOption>
            </transformation>
          </xsl:if>
          <xsl:if test="not(exsl:ctx('apsMode', 0))">
            <transformation name="Critical MPI Rank" boolean:deferred="true">
              <transformOption option="OptionBusyWaitQueryId">SpinBusyWaitOnMPISpinningTimeSummary</transformOption>
              <transformOption option="OptionProcessQueryId">ProcessID</transformOption>
              <transformOption option="OptionBinDurationMs">100</transformOption>
            </transformation>
          </xsl:if>
          <xsl:if test="$runtool = 'runsa' or $runtool = 'sniper'">
            <xsl:if test="exsl:ctx('gpuUsage', 0)">
              <transformation name="Compute GPU Usage" boolean:deferred="true">
              </transformation>
            </xsl:if>
            <xsl:if test="exsl:ctx('systemWideContextSwitch', 0) and exsl:ctx('gpuUsage', 0)">
              <transformation name="Compute CPU and GPU Usage" boolean:deferred="true">
              </transformation>
            </xsl:if>
            <xsl:if test="exsl:ctx('enableMemoryObjectCorrelation', 1) or exsl:ctx('collectMemObjects', 0)">
              <transformation name="Correlate samples with memory objects" boolean:deferred="false">
                <transformOption option="OptionKernMemStart_x86">0xC0400000</transformOption>
                <transformOption option="OptionKernMemStart_x86_64">0xFFFF80000000000</transformOption>
              </transformation>
              <transformation name="Correlate samples with data segments" boolean:deferred="true"/>
            </xsl:if>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%DRAM</transformOption>
              <transformOption option="OptionQueryId">OvertimeBandwidth</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
              <boolean:transformOption option="OptionSplitByPackage">true</boolean:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
              <xsl:choose>
                <xsl:when test="(exsl:ctx('PMU') = 'snbep')">
                  <int:transformOption option="OptionDomainMax">52</int:transformOption>
                </xsl:when>
                <xsl:when test="(exsl:ctx('PMU') = 'ivytown')">
                  <int:transformOption option="OptionDomainMax">60</int:transformOption>
                </xsl:when>
                <xsl:when test="(exsl:ctx('PMU') = 'haswell_server')">
                  <int:transformOption option="OptionDomainMax">60</int:transformOption>
                </xsl:when>
                <xsl:when test="(exsl:ctx('PMU') = 'knc')">
                  <int:transformOption option="OptionDomainMax">350</int:transformOption>
                </xsl:when>
                <xsl:when test="(exsl:ctx('PMU') = 'knl')">
                  <int:transformOption option="OptionDomainMax">90</int:transformOption>
                </xsl:when>
                <xsl:when test="(exsl:ctx('PMU') = 'broadwell_server')">
                  <int:transformOption option="OptionDomainMax">65</int:transformOption>
                </xsl:when>
                <xsl:when test="(exsl:ctx('PMU') = 'skylake_server') or (exsl:ctx('PMU') = 'cascadelake_server')">
                  <int:transformOption option="OptionDomainMax">70</int:transformOption>
                </xsl:when>
                <xsl:otherwise>
                  <int:transformOption option="OptionDomainMax">25</int:transformOption>
                </xsl:otherwise>
              </xsl:choose>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
              <transformOption option="OptionDomain">%eDRAM</transformOption>
              <transformOption option="OptionQueryId">eDRAMTotalBandwidth</transformOption>
              <int:transformOption option="OptionDomainMax">50</int:transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
              <boolean:transformOption option="OptionSplitByPackage">true</boolean:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <transformation name="Network bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
              <transformOption option="OptionQueryId">NetworkReceiveRate</transformOption>
              <transformOption option="OptionRestrictionQuery">NetworkPort</transformOption>
              <transformOption option="OptionRowByQueryName">NetworkPort</transformOption>
              <boolean:transformOption option="OptionSplitBandwidth">true</boolean:transformOption>
              <transformOption option="OptionInstanceTableName">network_rx_utilization_data</transformOption>
              <int:transformOption option="OptionDomainMax">40000</int:transformOption>
              <transformOption option="OptionTransformationPrefix">rx_</transformOption>
              <transformOption option="OptionBinDurationMs">0.001</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">100</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <transformation name="Network bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
              <transformOption option="OptionQueryId">NetworkTransmitRate</transformOption>
              <transformOption option="OptionRestrictionQuery">NetworkPort</transformOption>
              <transformOption option="OptionRowByQueryName">NetworkPort</transformOption>
              <boolean:transformOption option="OptionSplitBandwidth">true</boolean:transformOption>
              <transformOption option="OptionInstanceTableName">network_tx_utilization_data</transformOption>
              <int:transformOption option="OptionDomainMax">40000</int:transformOption>
              <transformOption option="OptionTransformationPrefix">tx_</transformOption>
              <transformOption option="OptionBinDurationMs">0.001</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">100</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <xsl:if test="(exsl:ctx('PMU') = 'snbep') or (exsl:ctx('PMU') = 'ivytown') or
                          (exsl:ctx('PMU') = 'haswell_server') or (exsl:ctx('PMU') = 'broadwell_server')">
              <transformation name="Single-Unit bandwidth utilization" boolean:deferred="true">
                <transformOption option="OptionDomain">%QPI</transformOption>
                <transformOption option="OptionQueryId">OvertimeQPIWriteBandwidth</transformOption>
                <transformOption option="OptionBinDurationMs">10</transformOption>
                <int:transformOption option="OptionMaxUtilizationBinNum">20</int:transformOption>
                <boolean:transformOption option="OptionSplitByUnit">true</boolean:transformOption>
                <transformOption option="OptionGrouperList"></transformOption>
                <transformOption option="OptionRestrictionQuery">UncorePackage</transformOption>
                <xsl:choose>
                  <xsl:when test="(exsl:ctx('PMU') = 'ivytown')">
                    <int:transformOption option="OptionDomainMax">13</int:transformOption>
                  </xsl:when>
                  <xsl:when test="(exsl:ctx('PMU') = 'haswell_server') or (exsl:ctx('PMU') = 'broadwell_server')">
                    <int:transformOption option="OptionDomainMax">16</int:transformOption>
                  </xsl:when>
                  <xsl:otherwise>
                    <int:transformOption option="OptionDomainMax">17</int:transformOption>
                  </xsl:otherwise>
                </xsl:choose>
              </transformation>
            </xsl:if>
            <transformation name="Single-Unit bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%UPIUtilization</transformOption>
              <transformOption option="OptionQueryId">UPIUtilizationBaseValue</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">100</int:transformOption>
              <int:transformOption option="OptionDomainMax">100</int:transformOption>
              <boolean:transformOption option="OptionSplitByUnit">true</boolean:transformOption>
              <boolean:transformOption option="OptionSingleUnitUtilizationOnly">true</boolean:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
              <transformOption option="OptionRestrictionQuery"></transformOption>
            </transformation>
            <xsl:if test="(exsl:ctx('PMU') = 'snbep') or (exsl:ctx('PMU') = 'ivytown') or
                          (exsl:ctx('PMU') = 'haswell_server') or (exsl:ctx('PMU') = 'broadwell_server')">
              <transformation name="Bandwidth utilization" boolean:deferred="true">
                <transformOption option="OptionDomain">%QPIOutgoingTotal</transformOption>
                <transformOption option="OptionQueryId">OvertimeQPIWriteBandwidth</transformOption>
                <transformOption option="OptionBinDurationMs">10</transformOption>
                <int:transformOption option="OptionMaxUtilizationBinNum">20</int:transformOption>
                <int:transformOption option="OptionDomainMax">34</int:transformOption>
                <transformOption option="OptionGrouperList"></transformOption>
              </transformation>
            </xsl:if>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%FPGA_QPI_Bandwidth</transformOption>
              <transformOption option="OptionQueryId">QPIFPGADataTransferredGB</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">20</int:transformOption>
              <int:transformOption option="OptionDomainMax">20</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%PCIeBandwidthMB</transformOption>
              <transformOption option="OptionQueryId">PCIeTotalBandwidth</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">20</int:transformOption>
              <int:transformOption option="OptionDomainMax">20</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%FPGAPCIeLink0Bandwidth</transformOption>
              <transformOption option="OptionQueryId">PCIEFPGADataTransferredGB_L0</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">20</int:transformOption>
              <int:transformOption option="OptionDomainMax">20</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%FPGAPCIeLink1Bandwidth</transformOption>
              <transformOption option="OptionQueryId">PCIEFPGADataTransferredGB_L1</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">20</int:transformOption>
              <int:transformOption option="OptionDomainMax">20</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%MCDRAMFlat</transformOption>
              <transformOption option="OptionQueryId">OvertimeMCDRAMFlatBandwidth</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
              <int:transformOption option="OptionDomainMax">350</int:transformOption>
              <transformOption option="OptionHbmMemoryModePrerequisiteValues"></transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%MCDRAMCache</transformOption>
              <transformOption option="OptionQueryId">OvertimeMCDRAMCacheBandwidth</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
              <int:transformOption option="OptionDomainMax">350</int:transformOption>
              <transformOption option="OptionHbmMemoryModePrerequisiteValues"></transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%MCDRAM</transformOption>
              <transformOption option="OptionQueryId">OvertimeMCDRAMFlatBandwidth</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
              <int:transformOption option="OptionDomainMax">350</int:transformOption>
              <transformOption option="OptionHbmMemoryModePrerequisiteValues">Flat</transformOption>
            </transformation>
            <transformation name="Bandwidth utilization" boolean:deferred="true">
              <transformOption option="OptionDomain">%MCDRAM</transformOption>
              <transformOption option="OptionQueryId">OvertimeMCDRAMCacheBandwidth</transformOption>
              <transformOption option="OptionBinDurationMs">10</transformOption>
              <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
              <transformOption option="OptionGrouperList"></transformOption>
              <int:transformOption option="OptionDomainMax">350</int:transformOption>
              <transformOption option="OptionHbmMemoryModePrerequisiteValues">Cache,Hybrid</transformOption>
            </transformation>
          </xsl:if>
          <xsl:if test="exsl:ctx('showGPUBandwidthHistogram', 1)">
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUMemoryRead</transformOption>
            <transformOption option="OptionQueryId">GPUMemoryReadGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuGtiReadThroughputAbsMaxValue</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUMemoryWrite</transformOption>
            <transformOption option="OptionQueryId">GPUMemoryWriteGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuGtiWriteThroughputAbsMaxValue</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUL3SamplerThroughput</transformOption>
            <transformOption option="OptionQueryId">GPUL3SamplerThroughputGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuL3SamplerThroughputAbsMaxValue</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUL3ShaderThroughput</transformOption>
            <transformOption option="OptionQueryId">GPUL3ShaderThroughputGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">GPUL3ShaderBDWAbsMax</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUSharedLocalMemoryRead</transformOption>
            <transformOption option="OptionQueryId">GPUSharedLocalMemoryReadGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">GPUSLMReadBDWMax</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUSharedLocalMemoryWrite</transformOption>
            <transformOption option="OptionQueryId">GPUSharedLocalMemoryWriteGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">GPUSLMWriteBDWMax</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUTypedMemoryRead</transformOption>
            <transformOption option="OptionQueryId">GPUTypedMemoryReadGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuTypedBytesReadAbsMaxValue</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUTypedMemoryWrite</transformOption>
            <transformOption option="OptionQueryId">GPUTypedMemoryWriteGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuTypedBytesWrittenAbsMaxValue</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUUntypedMemoryRead</transformOption>
            <transformOption option="OptionQueryId">GPUUntypedMemoryReadGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuUntypedBytesReadAbsMaxValue</transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:suppressErrors="true" boolean:deferred="true">
            <transformOption option="OptionDomain">%GPUUntypedMemoryWrite</transformOption>
            <transformOption option="OptionQueryId">GPUUntypedMemoryWriteGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <xsl:if test="exsl:is_experimental('gpu-frame-grouping')">
              <transformOption option="OptionGrouperList"></transformOption>
            </xsl:if>
            <transformOption option="OptionDomainMaxCtx">gpuUntypedBytesWrittenAbsMaxValue</transformOption>
          </transformation>
          </xsl:if>
          <transformation name="Bandwidth utilization" boolean:deferred="true">
            <transformOption option="OptionDomain">%3DXPDomain</transformOption>
            <transformOption option="OptionQueryId">APDataTransferredGB</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <boolean:transformOption option="OptionSplitByPackage">true</boolean:transformOption>
            <transformOption option="OptionGrouperList"></transformOption>
            <int:transformOption option="OptionDomainMax">30</int:transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:deferred="true">
            <transformOption option="OptionDomain">%OmniPathOutgoingBandwidthDomain</transformOption>
            <transformOption option="OptionQueryId">OmniPathOutgoingBandwidth</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <transformOption option="OptionGrouperList"></transformOption>
            <int:transformOption option="OptionDomainMax">12</int:transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:deferred="true">
            <transformOption option="OptionDomain">%OmniPathIncomingBandwidthDomain</transformOption>
            <transformOption option="OptionQueryId">OmniPathIncomingBandwidth</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <transformOption option="OptionGrouperList"></transformOption>
            <int:transformOption option="OptionDomainMax">12</int:transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:deferred="true">
            <transformOption option="OptionDomain">%OmniPathOutgoingPacketRateDomain</transformOption>
            <transformOption option="OptionQueryId">OmniPathOutgoingPacketRate</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <transformOption option="OptionGrouperList"></transformOption>
            <int:transformOption option="OptionDomainMax">150</int:transformOption>
          </transformation>
          <transformation name="Bandwidth utilization" boolean:deferred="true">
            <transformOption option="OptionDomain">%OmniPathIncomingPacketRateDomain</transformOption>
            <transformOption option="OptionQueryId">OmniPathIncomingPacketRate</transformOption>
            <xsl:choose>
              <xsl:when test="exsl:ctx('gsimClockDuration', 0) > 0">
                <transformOption option="OptionBinDurationMs">0.000001</transformOption>
              </xsl:when>
              <xsl:otherwise>
                <transformOption option="OptionBinDurationMs">10</transformOption>
              </xsl:otherwise>
            </xsl:choose>
            <int:transformOption option="OptionMaxUtilizationBinNum">50</int:transformOption>
            <transformOption option="OptionGrouperList"></transformOption>
            <int:transformOption option="OptionDomainMax">150</int:transformOption>
          </transformation>
          <xsl:if test="(exsl:ctx('gpuCounters', 'none') = 'full-compute')">
            <xsl:variable name="gpuConditionalTransformations">
              <item name="EuActive"/>
              <item name="EuStall"/>
              <item name="EuIdle"/>
              <item name="EuThreadOccupancy"/>
              <item name="EuFpuBothActive"/>
              <item name="EuSendActive"/>
              <item name="TypedReadsPerCacheLine"/>
              <item name="TypedWritesPerCacheLine"/>
              <item name="UntypedReadsPerCacheLine"/>
              <item name="UntypedWritesPerCacheLine"/>
              <item name="L3ShaderThroughput"/>
              <item name="SamplerL1Misses"/>
              <item name="EuAvgIpcRate"/>
              <item name="UntypedBytesWritten"/>
              <item name="UntypedBytesRead"/>
              <item name="SlmBytesRead"/>
              <item name="SlmBytesWritten"/>
              <item name="TypedBytesWritten"/>
              <item name="TypedBytesRead"/>
              <item name="SamplerBusy"/>
              <item name="SamplerBottleneck"/>
              <item name="L3Misses"/>
              <item name="GtiReadThroughput"/>
              <item name="GtiWriteThroughput"/>
              <item name="LlcMiss"/>
              <item name="CsThreads"/>
              <item name="GtiL3Throughput"/>
            </xsl:variable>
            <xsl:for-each select="exsl:node-set($gpuConditionalTransformations)/item">
              <transformation name="Conditional GPU metric" boolean:deferred="true">
                <transformOption option="OptionConditionalQueryId">
                  <xsl:text>Is</xsl:text>
                  <xsl:value-of select="@name"/>
                  <xsl:text>SamplesExist</xsl:text>
                </transformOption>
                <transformOption option="OptionDirectAttrFieldName">
                  <xsl:value-of select="@name"/>
                  <xsl:text>_exist</xsl:text>
                </transformOption>
                <transformOption option="OptionBinDurationMs">
                  <xsl:value-of select="format-number(exsl:ctx('gpuSamplingInterval', 1), '###.####', 'double-en')"/>
                </transformOption>
              </transformation>
            </xsl:for-each>
            <xsl:variable name="gpuConditionalTransformations2">
              <item name="GPUBusyAndEuStall"/>
              <item name="GPUBusyAndEuThreadOccupancy"/>
              <item name="GPUBusyAndSamplerBusy"/>
            </xsl:variable>
            <xsl:for-each select="exsl:node-set($gpuConditionalTransformations2)/item">
              <transformation name="Conditional GPU metric" boolean:deferred="true">
                <transformOption option="OptionConditionalQueryId">
                  <xsl:text>Is</xsl:text>
                  <xsl:value-of select="@name"/>
                  <xsl:text>SamplesExist</xsl:text>
                </transformOption>
                <transformOption option="OptionDirectAttrFieldName">
                  <xsl:value-of select="@name"/>
                  <xsl:text>_exist</xsl:text>
                </transformOption>
                <transformOption option="OptionBinDurationMs">
                  <xsl:value-of select="format-number(exsl:ctx('gpuSamplingInterval', 1), '###.####', 'double-en')"/>
                </transformOption>
              </transformation>
            </xsl:for-each>
          </xsl:if>
          <transformation name="Conditional GPU metric" boolean:deferred="true">
            <transformOption option="OptionConditionalQueryId">IsGPUBusy</transformOption>
            <transformOption option="OptionDirectAttrFieldName">gpu_busy</transformOption>
            <transformOption option="OptionBinDurationMs">
              <xsl:value-of select="format-number(exsl:ctx('gpuSamplingInterval', 1) div 4, '###.####', 'double-en')"/>
            </transformOption>
            <transformOption option="OptionNodeName">Render and GPGPU</transformOption>
          </transformation>
          <transformation name="Configure GPU groupers" boolean:deferred="true"/>
          <xsl:if test="$runtool = 'runsa'">
            <transformation name="Configure small groupers" boolean:deferred="true"/>
          </xsl:if>
          <transformation name="Calculate GPU packet stages" boolean:deferred="false">
            <transformOption option="OptionPacketNameFilter">Render and GPGPU</transformOption>
          </transformation>
          <transformation name="Calculate GPU packet queue depth" boolean:deferred="false"/>
          <transformation name="Fill thread affinity name" boolean:deferred="false"/>
          <transformation name="Calculate OpenMP serial time" boolean:deferred="false"/>
          <xsl:if test="exsl:is_experimental('gpu-data-transfer')">
            <transformation name="Attribute compute data transfers" boolean:deferred="false"/>
          </xsl:if>
        </transformParameters>
        <resolveParameters id="resolve">
          <xsl:choose>
            <xsl:when test="exsl:ctx('apsMode', 0)">
              <resolutionType name="functions_as_types"/>
              <resolutionType name="system"/>
              <resolutionType name="bottom_user"/>
            </xsl:when>
            <xsl:when test="exsl:ctx('inKernelProfiling', 0)">
              <resolutionType name="loop"/>
            </xsl:when>
            <xsl:otherwise>
              <resolutionType name="thread_name"/>
              <xsl:if test="exsl:ctx('resolveCallsites', 1)">
                <resolutionType name="interrupt_name"/>
                <resolutionType name="bottom_user"/>
                <resolutionType name="function"/>
                <resolutionType name="source_line"/>
                <resolutionType name="system"/>
                <xsl:if test="$runtool = 'runss'">
                  <resolutionType name="sync_object_name"/>
                  <resolutionType name="cstate_object_name"/>
                </xsl:if>
                <resolutionType name="call_target"/>
                <resolutionType name="inline"/>
                <resolutionType name="loop"/>
                <xsl:if test="exsl:ctx('basicBlockAnalysis', 0)">
                  <resolutionType name="basic_block"/>
                </xsl:if>
                <xsl:if test="exsl:ctx('advancedLoopAnalysis', 0)">
                  <resolutionType name="vectorization_isa"/>
                  <engineKnob id='loopAttributionMode'>loopAndFunction</engineKnob>
                  <resolutionType name="optreport"/>
                </xsl:if>
                <xsl:if test="not(exsl:ctx('showInlinesByDefault')) and (exsl:ctx('forceShowInlines', 0) = 0)">
                  <engineKnob id="inlineAttributionMode">off</engineKnob>
                </xsl:if>
                <xsl:if test="exsl:ctx('collectMemObjects', 0)">
                  <engineKnob id='calleeAttributionMode'>bottomUser</engineKnob>
                </xsl:if>
                <resolutionType name="global_data"/>
                <xsl:if test="exsl:ctx('mrteType', '') = 'python'">
                  <engineKnob id='calleeAttributionMode'>bottomUser</engineKnob>
                </xsl:if>
                <xsl:if test="not (exsl:ctx('calleeAttributionMode', 'undefined') = 'undefined')">
                  <engineKnob id='calleeAttributionMode'><xsl:value-of select="exsl:ctx('calleeAttributionMode', '')"/></engineKnob>
                </xsl:if>
                <xsl:if test="exsl:ctx('analyzeFullProcTrace', 0)">
                  <engineKnob id='calleeAttributionMode'>internal</engineKnob>
                </xsl:if>
                <xsl:if test="exsl:ctx('forceLoopAndFunctionMode', 0)">
                  <engineKnob id='loopAttributionMode'>loopAndFunction</engineKnob>
                </xsl:if>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
        </resolveParameters>
        <setknobsParameters id="setknobs">
          <xsl:if test="exsl:ctx('useHPCCPUUtilizationThresholds', 0)">
            <engineKnob id='utilizationThreshold'>
              <![CDATA[
              <bag xmlns:double="http://www.w3.org/2001/XMLSchema#double"
                   xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean">
                <minValueThresholds boolean:scaled="true">
                  <double:minValueThreshold name="%Idle" boolean:readonly="true">-1</double:minValueThreshold>
                  <double:minValueThreshold name="%Poor" boolean:readonly="true">0.0000001</double:minValueThreshold>
                  <double:minValueThreshold name="%Ok">0.399</double:minValueThreshold>
                  <double:minValueThreshold name="%Ideal">1.0</double:minValueThreshold>
                  <double:minValueThreshold name="%Over">1.001</double:minValueThreshold>
                </minValueThresholds>
              </bag>
              ]]>
            </engineKnob>
          </xsl:if>
        </setknobsParameters>
      </finalization>
      <variables>
        <xsl:variable name="isPerfAvailable" select="(exsl:ctx('targetOS', '')='Linux' or
                                                      exsl:ctx('targetOS', '')='Android'
                                                     ) and
                                                 exsl:ctx('HypervisorType', 'None') != 'ACRN'
                                                 and
                                                 exsl:ctx('connectionType', '') != 'tcp'"/>
        <isPerfAvailable>
          <xsl:if test="$isPerfAvailable">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </isPerfAvailable>
        <xsl:variable name="isVTSSAvailable" select="exsl:ctx('isVTSSPPDriverAvailable', 0) and
                                                     not($isSystemWide) and
                                                     exsl:ctx('OSBitness', '')!='32'"/>
        <isVTSSAvailable>
          <xsl:if test="$isVTSSAvailable">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </isVTSSAvailable>
        <isSystemWideForced>
          <xsl:if test="$forceSystemWide and not($isSystemWideUserChosen)">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </isSystemWideForced>
        <isSystemWide>
          <xsl:if test="$isSystemWide or exsl:ctx('perfForceSystemWide', 0)">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </isSystemWide>
        <isSWStackAvailable>
          <xsl:if test="$isPerfAvailable or $isVTSSAvailable">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </isSWStackAvailable>
        <preferredNonSWStackType>
          <xsl:choose>
            <xsl:when test="exsl:ctx('targetOS', '')='FreeBSD'">
              <xsl:text>framepointer</xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text>lbr</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </preferredNonSWStackType>
        <xsl:variable name="LinuxKernelVersion" select="string(exsl:ctx('LinuxRelease', ''))"/>
        <xsl:variable name="currentLinuxKernelVersions" select="str:tokenize($LinuxKernelVersion, '.-')"/>
        <usePerfForStacks>
          <xsl:choose>
            <xsl:when test="$isPerfAvailable and
                            (contains(exsl:ctx('LinuxPerfStackCapabilities', ''), 'dwarf') and
                             exsl:ctx('LinuxPerfCredentials', 'Restricted')!='Restricted' and
                             (exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='User' or
                              (exsl:ctx('LinuxPerfCredentials', 'NotAvailable')='User' and
                               exsl:ctx('eventMode', '')!='os'
                              ) and
                              not(exsl:ctx('isVTSSPPDriverAvailable', 0))
                             ) or
                             $isSystemWide or
                             not(exsl:ctx('isVTSSPPDriverAvailable', 0))
                            )">
                <xsl:text>true</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>false</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </usePerfForStacks>
        <perfContextSwitchesState>
          <xsl:choose>
            <xsl:when test="not((number($currentLinuxKernelVersions[1]) &gt; number(4)) or
                            ((number($currentLinuxKernelVersions[1]) = number(4)) and (number($currentLinuxKernelVersions[2]) &gt; number(2))))">
                <xsl:text>oldKernel</xsl:text>
            </xsl:when>
            <xsl:when test="exsl:ctx('LinuxPerfCredentials', 'Restricted')='Restricted' or
                                exsl:ctx('LinuxPerfCredentials', 'User')='User'">
                <xsl:text>restrictedCredentials</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>available</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </perfContextSwitchesState>
        <canUsePerfForContextSwitchesWithTypes>
          <xsl:choose>
            <xsl:when test="(number($currentLinuxKernelVersions[1]) &gt; number(4)) or
              ((number($currentLinuxKernelVersions[1]) = number(4)) and (number($currentLinuxKernelVersions[2]) &gt; number(16)))">
                <xsl:text>true</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>false</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </canUsePerfForContextSwitchesWithTypes>
        <collectGTPin>
          <xsl:value-of select="(exsl:ctx('gpuProfilingModeAtk', '') = 'characterization' and exsl:ctx('metricsGroup', '') = 'instruction-count') or exsl:ctx('gpuProfilingModeAtk', '') = 'source-analysis'"/>
        </collectGTPin>
      </variables>
    </common>
  </xsl:template>
</xsl:stylesheet>
