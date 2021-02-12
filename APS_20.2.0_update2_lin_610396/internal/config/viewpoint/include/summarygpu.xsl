<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="msxsl" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean">
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id">summaryPane</xsl:param>
  <xsl:param name="contextMode">false</xsl:param>
  <xsl:param name="displayName">SummaryWindow</xsl:param>
  <xsl:param name="description">HotspotsSummaryWindowDescription</xsl:param>
  <xsl:param name="resultSummaryHeaderColumn">TotalElapsedTime</xsl:param>
  <xsl:param name="resultSummaryColumns">MySummaryColumns</xsl:param>
  <xsl:param name="helpKeyWord">configs.interpret_result_summary_f1024</xsl:param>
  <xsl:param name="querySuffix"/>
  <xsl:param name="showBandwidth">false</xsl:param>
  <xsl:param name="showHottestTasks">true</xsl:param>
  <xsl:param name="showBandwidthUtilization">false</xsl:param>
  <xsl:param name="summaryInfoMaxLevelsToShow">100</xsl:param>
  <xsl:param name="manageGlobalFilter">false</xsl:param>
  <xsl:param name="showPhysicalCores">false</xsl:param>
  <xsl:param name="showGPUUsage">true</xsl:param>
  <xsl:param name="showEUArrayMetrics">true</xsl:param>
  <xsl:param name="packetsType">true</xsl:param>
  <xsl:param name="showFpuUtilization">true</xsl:param>
  <xsl:param name="showStalledIdle">true</xsl:param>
  <xsl:param name="showComputeTransfer">false</xsl:param>
  <xsl:param name="showGPUSummaryInfo">true</xsl:param>
  <xsl:param name="cpuGpuInteration">false</xsl:param>
  <xsl:param name="inKernelProfiling">false</xsl:param>
  <xsl:template match="/">
    <xsl:variable name="gpuCfg" select="document('config://viewpoint/include/gpu.cfg')"/>
    <xsl:variable name="gpuOpenCLDataCollected" select="exsl:is_non_empty_table_exist('gpu_compute_task_data')"/>
    <xsl:variable name="gpuDataCollected" select="exsl:is_non_empty_table_exist('gpu_data') or exsl:is_non_empty_table_exist('gpu_freq_data') or exsl:is_non_empty_table_exist('dma_packet_data') or $gpuOpenCLDataCollected"/>
    <xsl:variable name="summaryBlocksParams">
      <params
        querySuffix="{$querySuffix}"
        contextMode="{$contextMode}"
        packetsType="{$packetsType}"
        showHottestTasks="$showHottestTasks"
        inKernelProfiling="$inKernelProfiling"
        cpuGpuInteration="{$cpuGpuInteration}"
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
          <xsl:text>global</xsl:text>
        </xsl:attribute>
      </xsl:if>
      </filter>
      <event handleList="KnobChangedEvent"/>
      <application name="summary"/>
        <helpKeywordF1>
            <xsl:value-of select="$helpKeyWord"/>
        </helpKeywordF1>
      <description>
        <xsl:text>%</xsl:text>
        <xsl:value-of select="$description"/>
      </description>
      <icon file="client.dat#zip:images.xrc" image="tab_summary"/>
      <config>
        <xsl:if test="$contextMode='true'">
          <style>context-summary</style>
        </xsl:if>
        <sections>
          <xsl:if test="$showGPUSummaryInfo='true'">
          <section>
            <header>
              <xsl:choose>
                <xsl:when test="$contextMode='true'">
                  <column>/GPUElapsedTime</column>
                </xsl:when>
                <xsl:otherwise>
                  <column>/TotalElapsedTime</column>
                </xsl:otherwise>
              </xsl:choose>
            </header>
            <xsl:if test="($contextMode != 'true') and exsl:ctx('allowMultipleRuns', 0)">
              <description displayName="%TotalElapsedTimeMultirunNote"/>
            </xsl:if>
              <xsl:if test="$cpuGpuInteration='true'">
                <sections>
                  <xsl:if test="$showGPUUsage='true'">
                    <xsl:copy-of select="$summaryBlocks//root/gpuEnginesUsage/*"/>
                  </xsl:if>
                </sections>
              </xsl:if>
              <xsl:if test="$inKernelProfiling='true'">
                <sections>
                  <section expanded="onIssues">
                    <header>
                      <column>/GPUGpuTime</column>
                    </header>
                  </section>
                </sections>
              </xsl:if>
            </section>
          </xsl:if>
          <xsl:if test="$contextMode='false' and exsl:is_non_empty_table_exist('gpu_gtpin_data')">
           <section type="grid" expanded="true" nullValue="hide">
             <header displayName="%TopGPUDeepProfilingHotspots"/>
             <description displayName="%TopGPUDeepProfilingHotspotsDescription" />
             <grid limit="5">
               <columns>
                 <column>/GPUGTPinComputeTaskTimeSummary</column>
                 <column>/GPUGTPinComputeTaskDurationSummary</column>
                 <column>/GPUGTPinComputeTaskCountSummary</column>
                 <column>/GPUGTPinInstLatency</column>
                 <column>/GPUGTPinInstructionCount</column>
               </columns>
               <sorting>/GPUGTPinComputeTaskTimeSummary</sorting>
               <grouping>/GPUComputeTaskTypeVector</grouping>
               <href>
                 <activate tabId="gpuTimelinePane" handlerId="bottomUpPane">
                   <xsl:choose>
                     <xsl:when test="(exsl:ctx('appRunsCount', 1) > 1)">
                       <grouping>/GPUComputeTaskTypeVector</grouping>
                     </xsl:when>
                     <xsl:otherwise>
                       <xsl:choose>
                         <xsl:when test="$inKernelProfiling='true'">
                           <grouping>/GPUComputeTaskTypeVector/GPUFunction/GPUParentCallStack</grouping>
                         </xsl:when>
                         <xsl:otherwise>
                          <grouping>/GPUComputeTaskTypeVector/GPUComputeTaskInstance</grouping>
                         </xsl:otherwise>
                       </xsl:choose>
                     </xsl:otherwise>
                   </xsl:choose>
                   <row/>
                 </activate>
               </href>
             </grid>
          </section>
          </xsl:if>
          <xsl:if test="$cpuGpuInteration='false' and $inKernelProfiling='false' ">
          <xsl:if test="$showGPUUsage='true'">
            <xsl:copy-of select="$summaryBlocks//root/gpuEnginesUsage/*"/>
          </xsl:if>
          </xsl:if>
          <xsl:choose>
            <xsl:when test="(exsl:is_non_empty_table_exist('conditional_gpu_data')
            and exsl:is_non_empty_table_exist('gpu_data'))
            or (exsl:ctx('gsimClockDuration', 0) > 0)">
                <xsl:if test="$showStalledIdle='true'">
                <section expanded="onIssues">
                  <header>
                      <xsl:choose>
                        <xsl:when test="$inKernelProfiling='true'">
                          <column>/GPUEUNotActiveWhenBusyInKernel</column>
                        </xsl:when>
                        <xsl:otherwise>
                    <column>/GPUEUNotActiveWhenBusy</column>
                        </xsl:otherwise>
                      </xsl:choose>
                  </header>
                  <description displayName="%GPUEUNotActiveWhenBusyHeaderDescription" />
                  <sections>
                    <section expanded="onIssues">
                      <header>
                          <xsl:choose>
                            <xsl:when test="$inKernelProfiling='true'">
                              <column>/GPUL3BandwidthWhenBusyInKernel</column>
                            </xsl:when>
                            <xsl:otherwise>
                        <column>/GPUL3BandwidthWhenBusy</column>
                            </xsl:otherwise>
                          </xsl:choose>
                      </header>
                      <xsl:if test="$contextMode='false'">
                        <description displayName="%GPUL3BandwidthWhenBusyHeaderDescription" />
                          <sections>
                            <xsl:if test="exsl:is_non_empty_table_exist('gpu_compute_task_data')">
                              <section type="grid" expanded="true" nullValue="hide">
                                <header displayName="%TopGPUTasksWithGPUL3BandwidthProblems"/>
                                <description displayName="%TopGPUTasksWithGPUL3BandwidthProblemsDescription" />
                                <grid limit="3">
                                  <columns>
                                    <column>/GPUComputeTaskTimeWhenHighL3Bandwidth</column>
                                  </columns>
                                  <sorting>/GPUComputeTaskTimeWhenHighL3Bandwidth</sorting>
                                  <grouping>/GPUComputeTaskType</grouping>
                                  <href>
                                    <activate tabId="gpuTimelinePane" handlerId="bottomUpPane">
                                      <grouping>/GPUComputeTaskType/GPUComputeTaskInstance</grouping>
                                      <row/>
                                    </activate>
                                  </href>
                                </grid>
                                <messages>
                                  <noData displayName="%NoDataToShowForGPUTasksWithIssues"/>
                                </messages>
                              </section>
                            </xsl:if>
                          </sections>
                      </xsl:if>
                    </section>
                    <xsl:if test="(exsl:ctx('collectMemBandwidth')) and (exsl:ctx('maxLocalBandwidthGB', 0) > 0)">
                    <section expanded="onIssues">
                      <header reloadOnKnobChangePurpose="threshold">
                          <xsl:choose>
                            <xsl:when test="$inKernelProfiling='true'">
                              <column>/GPUDRAMBoundWhenBusyInKernel</column>
                            </xsl:when>
                            <xsl:otherwise>
                        <column>/GPUDRAMBoundWhenBusy</column>
                            </xsl:otherwise>
                          </xsl:choose>
                      </header>
                      <xsl:if test="$contextMode='false'">
                        <description displayName="%GPUDRAMBandwidthWhenBusyHeaderDescription" />
                          <sections>
                            <xsl:if test="exsl:is_non_empty_table_exist('gpu_compute_task_data')">
                              <section type="grid" expanded="true" nullValue="hide">
                                <header displayName="%TopGPUTasksWithGPUDRAMBandwidthProblems" reloadOnKnobChangePurpose="threshold"/>
                                <description displayName="%TopGPUTasksWithGPUDRAMBandwidthProblemsDescription" />
                                <grid limit="3">
                                  <columns>
                                    <column>/GPUComputeTaskTimeWhenHighDRAMBandwidth</column>
                                  </columns>
                                  <sorting>/GPUComputeTaskTimeWhenHighDRAMBandwidth</sorting>
                                  <grouping>/GPUComputeTaskType</grouping>
                                  <href>
                                    <activate tabId="gpuTimelinePane" handlerId="bottomUpPane">
                                      <grouping>/GPUComputeTaskType/GPUComputeTaskInstance</grouping>
                                      <row/>
                                    </activate>
                                  </href>
                                </grid>
                                <messages>
                                  <noData displayName="%NoDataToShowForGPUTasksWithIssues"/>
                                </messages>
                              </section>
                            </xsl:if>
                          </sections>
                      </xsl:if>
                    </section>
                    </xsl:if>
                    <section expanded="onIssues">
                      <header>
                          <xsl:choose>
                            <xsl:when test="$inKernelProfiling='true'">
                              <column>/GPUThreadOccupancyWhenBusyInKernel</column>
                            </xsl:when>
                            <xsl:otherwise>
                        <column>/GPUThreadOccupancyWhenBusy</column>
                            </xsl:otherwise>
                          </xsl:choose>
                      </header>
                      <xsl:if test="$contextMode='false'">
                        <description displayName="%GPUThreadOccupancyWhenBusyHeaderDescription" />
                        <xsl:if test="exsl:is_non_empty_table_exist('gpu_compute_task_data')">
                          <sections>
                            <section type="grid" expanded="true" nullValue="hide">
                              <header displayName="%TopGPUTasksWithOccupancyProblems"/>
                              <description displayName="%TopGPUTasksWithOccupancyProblemsDescription" />
                              <grid limit="3">
                                <columns>
                                  <column>/GPUComputeTaskTimeWhenLowOccupancy</column>
                                  <column>/GPUComputeGlobalDimWhenLowOccupancy</column>
                                  <column>/GPUComputeLocalDimWhenLowOccupancy</column>
                                  <column>/GPUComputeSimdWidthWhenLowOccupancy</column>
                                </columns>
                                <sorting>/GPUComputeTaskTimeWhenLowOccupancy</sorting>
                                <grouping>/GPUComputeTaskTypeWithOccupancyIssues</grouping>
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
                              <messages>
                                <noData displayName="%NoDataToShowForGPUTasksWithIssues"/>
                              </messages>
                            </section>
                          </sections>
                        </xsl:if>
                      </xsl:if>
                    </section>
                    <section expanded="onIssues">
                      <header>
                          <xsl:choose>
                            <xsl:when test="$inKernelProfiling='true'">
                              <column>/GPUSamplerBusyWhenBusyInKernel</column>
                            </xsl:when>
                            <xsl:otherwise>
                        <column>/GPUSamplerBusyWhenBusy</column>
                            </xsl:otherwise>
                          </xsl:choose>
                      </header>
                      <xsl:if test="$contextMode='false'">
                        <description displayName="%GPUSamplerBusyWhenBusyHeaderDescription" />
                        <xsl:if test="exsl:is_non_empty_table_exist('gpu_compute_task_data')">
                          <sections>
                            <section type="grid" expanded="true" nullValue="hide">
                              <header displayName="%TopGPUTasksWithSamplerAccessProblems"/>
                              <description displayName="%TopGPUTasksWithSamplerAccessProblemsDescription" />
                              <grid limit="3">
                                <columns>
                                  <column>/GPUComputeTaskTimeWhenSamplerOverutilized</column>
                                </columns>
                                <sorting>/GPUComputeTaskTimeWhenSamplerOverutilized</sorting>
                                <grouping>/GPUComputeTaskType</grouping>
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
                              <messages>
                                <noData displayName="%NoDataToShowForGPUTasksWithIssues"/>
                              </messages>
                            </section>
                          </sections>
                        </xsl:if>
                      </xsl:if>
                    </section>
                  </sections>
                </section>
                </xsl:if>
                <xsl:if test="$showFpuUtilization='true'">
                <section expanded="onIssues">
                  <header>
                      <xsl:choose>
                        <xsl:when test="$inKernelProfiling='true'">
                          <column>/GPUEuFpuBothActiveInKernel</column>
                        </xsl:when>
                        <xsl:otherwise>
                    <column>/GPUEuFpuBothActive</column>
                        </xsl:otherwise>
                      </xsl:choose>
                  </header>
                  <xsl:if test="$contextMode='false'">
                    <description displayName="%GPUFPUBoundHeaderDescription" />
                      <sections>
                        <xsl:if test="exsl:is_non_empty_table_exist('gpu_compute_task_data')">
                          <section type="grid" expanded="true" nullValue="hide">
                            <header displayName="%TopGPUTasksWithFPUProblems"/>
                            <description displayName="%TopGPUTasksWithFPUProblemsDescription" />
                            <grid limit="3">
                              <columns>
                                <column>/GPUComputeTaskTimeWhenGPUEuFpuBothActive</column>
                              </columns>
                              <sorting>/GPUComputeTaskTimeWhenGPUEuFpuBothActive</sorting>
                              <grouping>/GPUComputeTaskTypeWithFPUIssues</grouping>
                              <href>
                                <activate tabId="gpuTimelinePane" handlerId="bottomUpPane">
                                  <grouping>/GPUComputeTaskType/GPUComputeTaskInstance</grouping>
                                  <row/>
                                </activate>
                              </href>
                            </grid>
                            <messages>
                              <noData displayName="%NoDataToShowForGPUTasksWithIssues"/>
                            </messages>
                          </section>
                        </xsl:if>
                      </sections>
                  </xsl:if>
                </section>
              </xsl:if>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="$showEUArrayMetrics='true'">
                <xsl:copy-of select="$summaryBlocks//root/gpuEUArrayMetrics/*"/>
              </xsl:if>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="$showComputeTransfer='true' and $contextMode='false' ">
           <section type="grid" expanded="true">
              <header displayName="%TopGPUHotspots"/>
              <description displayName="%TopGPUHotspotsDescription"/>
             <grid limit="5">
               <columns>
                 <column>/GPUComputeTaskTimeSummary</column>
               </columns>
                <sorting>/GPUComputeTaskTimeSummary</sorting>
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
                       <grouping>/GPUComputeTaskTypeVector</grouping>
                     </xsl:when>
                     <xsl:otherwise>
                       <grouping>/GPUComputeTaskTypeVector/GPUComputeTaskInstance</grouping>
                     </xsl:otherwise>
                   </xsl:choose>
                   <row/>
                 </activate>
               </href>
             </grid>
           </section>
         </xsl:if>
          <xsl:if test="$showBandwidthUtilization='true'">
            <xsl:copy-of select="$summaryBlocks//root/bandwidthUtilizationChart/*"/>
          </xsl:if>
         <xsl:if test="$contextMode='false'">
            <section type="tree" nullValue="hide" expanded="false">
              <header displayName="%ResultInfo" />
              <description displayName="%ResultInfoDescription" />
              <tree valueAlign="left">
                <columns>
                  <column>/ResultInfo</column>
                </columns>
              </tree>
              <sections>
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
                </section>
                <xsl:if test="$gpuDataCollected='true'">
                  <section type="tree" expanded="true" valueAlign="left">
                    <header displayName="%GPU" />
                    <tree valueAlign="left">
                      <columns>
                        <column>/GPUAdapterInfo</column>
                      </columns>
                    </tree>
                    <xsl:if test="$gpuOpenCLDataCollected">
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
         </xsl:if>
        </sections>
        <xsl:copy-of select="$summaryBlocks//root/messages"/>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
