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
    xmlns:str="http://exslt.org/strings" str:keep_str_namespace=""
    exclude-result-prefixes="msxsl"
    xmlns:int="http://www.w3.org/2001/XMLSchema#int"
    xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id">summaryPane</xsl:param>
  <xsl:param name="contextMode">false</xsl:param>
  <xsl:param name="displayName">SummaryWindow</xsl:param>
  <xsl:param name="description">HotspotsSummaryWindowDescription</xsl:param>
  <xsl:param name="querySuffix"/>
  <xsl:param name="cpuColumns"></xsl:param>
  <xsl:param name="showResultInfo">true</xsl:param>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="section/@expanded">
    <xsl:attribute name="expanded">
      <xsl:choose>
        <xsl:when test="not(../@allowExpansionRewriting) or ../@allowExpansionRewriting='true'">
          <xsl:text>onIssues</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="../@expanded"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="/">
    <xsl:variable name="summaryBlocksParams">
        <params
          querySuffix="{$querySuffix}"
          contextMode="{$contextMode}"
          />
    </xsl:variable>
    <xsl:variable name="summaryBlocksFileName">
      <xsl:text>config://viewpoint/include/summaryblocks.xsl?</xsl:text>
      <xsl:for-each select="exsl:node-set($summaryBlocksParams)//@*">
        <xsl:value-of select="concat(name(), '=', .)"/>
        <xsl:text>&amp;</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="summaryBlocks" select="document($summaryBlocksFileName)"/>
    <xsl:variable name="summaryBlocksParamsCli">
        <params
          querySuffix="{$querySuffix}"
          cliMode="true"
          />
    </xsl:variable>
    <xsl:variable name="summaryBlocksFileNameCli">
      <xsl:text>config://viewpoint/include/summaryblocks.xsl?</xsl:text>
      <xsl:for-each select="exsl:node-set($summaryBlocksParamsCli)//@*">
        <xsl:value-of select="concat(name(), '=', .)"/>
        <xsl:text>&amp;</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="summaryBlocksCli" select="document($summaryBlocksFileNameCli)"/>
    <xsl:variable name="pmuCommon" select="document('config://include/pmu_common.xsl')"/>
    <xsl:variable name="isTmamSmtAware" select="$pmuCommon//variables/isTmamSmtAware"/>
    <xsl:variable name="isFlopsAvailable" select="$pmuCommon//variables/isFlopsAvailable"/>
    <xsl:variable name="gpuDataCollected" select="exsl:is_non_empty_table_exist('gpu_data')"/>
    <html id="{$id}" displayName="%{$displayName}">
      <xsl:if test="$contextMode='true'">
        <filter handleList="global"/>
      </xsl:if>
      <event handleList="KnobChangedEvent"/>
      <application name="summary"/>
      <helpKeywordF1>configs.interpret_result_summary_f1024</helpKeywordF1>
      <description>
        <xsl:text>%</xsl:text>
        <xsl:value-of select="$description"/>
      </description>
      <icon file="client.dat#zip:images.xrc" image="tab_summary"/>
      <config>
        <recommendations>
          <recommendation>
            <header>
              <column>/shortCollectionMuxRecommendation</column>
            </header>
          </recommendation>
        </recommendations>
        <xsl:if test="$contextMode='true'">
          <style>context-summary</style>
        </xsl:if>
        <sections>
          <xsl:choose>
            <xsl:when test="$gpuDataCollected">
              <section>
                <header>
                  <xsl:choose>
                    <xsl:when test="$contextMode='true'">
                        <column>/OpenMPElapsedTime</column>
                    </xsl:when>
                    <xsl:otherwise>
                        <column>/GlobalElapsedTime</column>
                    </xsl:otherwise>
                  </xsl:choose>
                </header>
                <sections>
                  <section type="tree">
                    <header displayName="%CPU"/>
                    <tree valueAlign="left">
                      <columns>
                        <xsl:if test="$isFlopsAvailable = 'true'">
                          <column>/GSPFLOPS</column>
                          <column>/GDPFLOPS</column>
                          <column>/GX87FLOPS</column>
                        </xsl:if>
                        <xsl:choose>
                          <xsl:when test="exsl:is_experimental('mps')">
                            <column>/IPC</column>
                          </xsl:when>
                          <xsl:otherwise>
                            <column>/CPI</column>
                          </xsl:otherwise>
                        </xsl:choose>
                        <column>/AverageFrequency</column>
                        <column>/TotalThreadCount</column>
                        <xsl:if test="exsl:is_experimental('mps')">
                          <column>/CPUTime</column>
                        </xsl:if>
                      </columns>
                    </tree>
                  </section>
                  <section  type="tree">
                    <header displayName="%GPU"/>
                    <tree valueAlign="left">
                      <columns>
                        <column>/GPUTimePrettyPrintedWhenBusyCounting</column>
                        <column>/GPUHPCEuAvgIpcRate</column>
                      </columns>
                    </tree>
                  </section>
                </sections>
              </section>
            </xsl:when>
            <xsl:otherwise>
              <section type="tree">
                <header>
                  <xsl:choose>
                    <xsl:when test="$contextMode='true'">
                        <column>/OpenMPElapsedTime</column>
                    </xsl:when>
                    <xsl:otherwise>
                        <column>/GlobalElapsedTime</column>
                    </xsl:otherwise>
                  </xsl:choose>
                </header>
                <tree valueAlign="left">
                  <columns>
                    <xsl:if test="$isFlopsAvailable = 'true'">
                      <column>/GSPFLOPS</column>
                      <column>/GDPFLOPS</column>
                      <column>/GX87FLOPS</column>
                    </xsl:if>
                    <xsl:choose>
                      <xsl:when test="exsl:is_experimental('mps')">
                        <column>/IPC</column>
                      </xsl:when>
                      <xsl:otherwise>
                        <column>/CPI</column>
                      </xsl:otherwise>
                    </xsl:choose>
                    <column>/AverageFrequency</column>
                    <column>/TotalThreadCount</column>
                    <xsl:if test="exsl:is_experimental('mps')">
                      <column>/CPUTime</column>
                    </xsl:if>
                  </columns>
                </tree>
              </section>
            </xsl:otherwise>
          </xsl:choose>
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
                <xsl:if test="(exsl:ctx('mpiRankCount', 0) > 1)">
                  <column>/MPIImbalancePercentElapsedAsString</column>
                </xsl:if>
              </columns>
            </tree>
            <sections>
              <xsl:if test="(exsl:ctx('openmpProcessCount') = 1)">
                <xsl:apply-templates select="$summaryBlocks//root/openMPTimeSections/*"/>
              </xsl:if>
              <xsl:if test="(exsl:ctx('openmpProcessCount') >= 0)">
                <xsl:choose>
                  <xsl:when test="exsl:ctx('mpiRankCount', 0) > 1">
                    <section type="tree">
                      <header>
                        <column>/CriticalMPIRank</column>
                      </header>
                      <tree valueAlign="left">
                        <xsl:if test="($contextMode='false')">
                          <xsl:attribute name="valueAlign">right</xsl:attribute>
                        </xsl:if>
                        <columns>
                          <column>/SpinBusyWaitOnMPISpinningTimeMPICriticalPercentElapsedAsString</column>
                        </columns>
                      </tree>
                      <sections>
                        <xsl:if test="(exsl:ctx('openmpProcessCount') > 0)">
                          <xsl:apply-templates select="$summaryBlocks//root/openMPTimeSections/*"/>
                        </xsl:if>
                      </sections>
                    </section>
                  </xsl:when>
                </xsl:choose>
              </xsl:if>
              <xsl:if test="not(exsl:ctx('useCountingMode', 0))">
                <xsl:apply-templates select="$summaryBlocks//root/cpuUsageChart/*"/>
              </xsl:if>
            </sections>
          </section>
          <xsl:if test="$gpuDataCollected">
            <section type="tree">
              <header displayName="%GPUHPCEUAvgUtilization">
                <column>/GPUEUAvgUtilizationWhenBusyCounting</column>
              </header>
              <tree valueAlign="left">
                <columns>
                  <column>/GPUEUStateGridSection</column>
                  <column>/GPUEuThreadOccupancyWhenBusyCounting</column>
                </columns>
              </tree>
            </section>
          </xsl:if>
          <section type="tree">
            <header displayName="%MemBound">
              <xsl:if test="(exsl:ctx('PMU') != 'knl')">
                <xsl:attribute name="displayName">%BackendBoundPipelineSlots</xsl:attribute>
              </xsl:if>
              <column>/MemBoundForHPCPC</column>
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
              <xsl:if test="(exsl:ctx('PMU') = 'knl')">
                <xsl:attribute name="reloadOnKnobChangePurpose">threshold</xsl:attribute>
              </xsl:if>
              <columns>
                <column>/MemoryBoundGroupHPCPCSummary</column>
              </columns>
            </tree>
            <sections>
              <xsl:if test="(exsl:ctx('collectMemBandwidth'))">
                  <xsl:apply-templates select="$summaryBlocks//root/bandwidthUtilizationChartMemory/*"/>
              </xsl:if>
            </sections>
          </section>
          <xsl:choose>
            <xsl:when test="(exsl:ctx('PMU') = 'knl')">
              <section type="tree" expanded="true">
                <header>
                  <column>/FPUUtilizationSummary</column>
                </header>
                <tree valueAlign="left" expandAll="true" boolean:highlightColumnsWithExpansion="false" boolean:takeExpansionFromHeaderColumn="true">
                </tree>
                <sections>
                  <xsl:if test="($contextMode='false') and not(exsl:ctx('useCountingMode', 0))">
                    <section type="grid" expanded="true" nullValue="hide" applicableUI="gui">
                      <header displayName="%TopFPU"/>
                      <description displayName="%TopFPUDescription" />
                      <grid limit="5" expanded="onIssues">
                        <columns>
                          <column>/CPUTimeConditionalOnFPRatio</column>
                          <column>/IssueedFPUUtilizationForHPCSummary</column>
                          <column>/InstrSet</column>
                          <column>/LoopType</column>
                        </columns>
                        <sorting>/CPUTimeConditionalOnFPRatio</sorting>
                        <grouping>/Function</grouping>
                        <href>
                          <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                            <grouping>/Function/ParentCallStack</grouping>
                            <row/>
                          </activate>
                        </href>
                      </grid>
                      <messages>
                        <noData displayName="%NoDataToShowForTopFPU"/>
                      </messages>
                    </section>
                  </xsl:if>
                </sections>
              </section>
            </xsl:when>
            <xsl:otherwise>
              <section type="tree">
                <header>
                  <column>/VectorizationSummary</column>
                </header>
                <tree valueAlign="left" boolean:highlightColumnsWithExpansion="false" boolean:takeExpansionFromHeaderColumn="true">
                </tree>
                <sections>
                  <xsl:if test="($contextMode='false') and not(exsl:ctx('useCountingMode', 0))">
                    <section type="grid" expanded="true" nullValue="hide" applicableUI="gui">
                      <header displayName="%TopFPU"/>
                      <description displayName="%TopFPUDescription" />
                      <grid limit="5" expanded="onIssues">
                        <columns>
                          <column>/CPUTimeConditionalOnFPRatio</column>
                          <column>/FPRatio</column>
                          <column>/PackedFPRatio</column>
                          <column>/ScalarFPRatio</column>
                          <column>/InstrSet</column>
                          <column>/LoopType</column>
                        </columns>
                        <sorting>/CPUTimeConditionalOnFPRatio</sorting>
                        <grouping>/Function</grouping>
                        <href>
                          <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                            <grouping>/Function/ParentCallStack</grouping>
                            <row/>
                          </activate>
                        </href>
                      </grid>
                      <messages>
                        <noData displayName="%NoDataToShowForTopFPU"/>
                      </messages>
                    </section>
                  </xsl:if>
                </sections>
              </section>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:if test="not(exsl:ctx('useCountingMode', 0))">
            <section type="undefined" expanded="true">
              <header>
                <column>/OmniPathUsage</column>
              </header>
              <sections>
                <xsl:apply-templates select="$summaryBlocks//root/OmniPathUsageSection/*"/>
              </sections>
            </section>
          </xsl:if>
          <xsl:if test="exsl:ctx('useCountingMode', 0)">
            <section type="undefined" expanded="true">
              <header>
                <column>/AverageOmniPathUsage</column>
              </header>
              <sections>
                <xsl:apply-templates select="$summaryBlocksCli//root/AverageOmniPathUsageSection/*"/>
              </sections>
            </section>
          </xsl:if>
          <section type="tree" expanded="true">
            <header>
              <column>/ParallelFsLustreWaittime</column>
            </header>
            <tree valueAlign="left">
              <columns>
                <column>/ParallelFsReadWriteBandwidth</column>
                <column>/ParallelFsPackageRate</column>
                <column>/ParallelFsAverageReadWritePackageSize</column>
              </columns>
            </tree>
            <sections>
              <section type="grid" expanded="false">
                <header displayName="%ParallelFsGrid"/>
                <grid limit="5">
                  <columns>
                    <column>/ParallelFsReadBytes</column>
                    <column>/ParallelFsReadSamplesCount</column>
                    <column>/ParallelFsReadWaittime</column>
                    <column>/ParallelFsWriteBytes</column>
                    <column>/ParallelFsWriteSamplesCount</column>
                    <column>/ParallelFsWriteWaittime</column>
                    <column>/ParallelFsReqSamplesCount</column>
                    <column>/ParallelFsReqWaittime</column>
                  </columns>
                  <sorting>/ParallelFsReqWaittime</sorting>
                  <grouping>/ParallelFsObject</grouping>
                </grid>
              </section>
            </sections>
          </section>
          <xsl:if test="$showResultInfo='true'">
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
                    </columns>
                  </tree>
                </section>
                <xsl:if test="$gpuDataCollected">
                  <section type="tree" expanded="true" valueAlign="left">
                    <header displayName="%GPU" />
                    <tree valueAlign="left">
                      <columns>
                        <column>/GPUAdapterInfo</column>
                      </columns>
                    </tree>
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
