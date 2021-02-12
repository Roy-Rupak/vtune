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
  <xsl:param name="displayName">SummaryWindow</xsl:param>
  <xsl:param name="description">HotspotsSummaryWindowDescription</xsl:param>
  <xsl:param name="summaryInfoMaxLevelsToShow">2</xsl:param>
  <xsl:param name="highlightColumnsWithExpansion">true</xsl:param>
  <xsl:param name="querySuffix"/>
  <xsl:template match="/">
    <xsl:variable name="isRunssMode" select="exsl:ctx('runss:enable', 0) or (exsl:ctx('runsa:enable', 'na') = 'na' and exsl:ctx('runss:enable', 'na') = 'na' and exsl:IsTableExist('cpu_data'))"/>
    <xsl:variable name="summaryBlocksParams">
      <params
        querySuffix="{$querySuffix}"
        contextMode="false"
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
    <xsl:variable name="pmuCommon" select="document('config://include/pmu_common.xsl')"/>
    <xsl:variable name="isTmamSmtAware" select="$pmuCommon//variables/isTmamSmtAware"/>
    <html id="{$id}" displayName="%{$displayName}">
      <event handleList="KnobChangedEvent"/>
      <application name="summary"/>
      <helpKeywordF1>configs.interpret_result_summary_f1024</helpKeywordF1>
      <description>
        <xsl:text>%</xsl:text>
        <xsl:value-of select="$description"/>
      </description>
      <icon file="client.dat#zip:images.xrc" image="tab_summary"/>
      <config>
        <sections>
          <section type="tree" expanded="true" id="ResultSummary">
            <header>
              <column>/TotalElapsedTime</column>
            </header>
            <tree valueAlign="right" int:autoExpansionLimit="{$summaryInfoMaxLevelsToShow}" boolean:highlightColumnsWithExpansion="{$highlightColumnsWithExpansion}">
              <xsl:if test="not(exsl:ctx('useCountingMode', 0)) or $isRunssMode">
                <href>
                  <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                    <column/>
                  </activate>
                </href>
              </xsl:if>
              <columns>
                <column>/PausedTime</column>
              </columns>
            </tree>
          </section>
          <section type="undefined" expanded="true" id="EffectiveCPUUtilization">
            <header>
              <xsl:choose>
                <xsl:when test="$isRunssMode">
                  <column>/CPUEffectiveCPUUtilizationString</column>
                </xsl:when>
                <xsl:otherwise>
                  <column>/PMUEffectiveCPUUtilizationString</column>
                </xsl:otherwise>
              </xsl:choose>
            </header>
            <sections>
              <xsl:copy-of select="$summaryBlocks//root/cpuUsageChart/*"/>
              <xsl:if test="exsl:ctx('openmpProcessCount') = 1">
                <section type="undefined" expanded="true">
                  <header>
                    <column>/OpenMPSectionHeader</column>
                  </header>
                  <sections>
                    <xsl:copy-of select="$summaryBlocks//root/openMPTimeSections/*"/>
                  </sections>
                </section>
              </xsl:if>
              <xsl:if test="(exsl:ctx('openmpProcessCount') > 1)">
                <xsl:if test="(exsl:ctx('mpiRankCount', 0)) > 1">
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
              <xsl:choose>
                <xsl:when test="$isRunssMode">
                  <section type="tree" expanded="true" id="TotalThreadCount">
                    <header>
                      <column>/TotalThreadCountWithIssues</column>
                    </header>
                    <tree valueAlign="right" int:autoExpansionLimit="{$summaryInfoMaxLevelsToShow}" boolean:highlightColumnsWithExpansion="{$highlightColumnsWithExpansion}">
                      <columns>
                        <column>/CPUThreadOversubscriptionString</column>
                      </columns>
                    </tree>
                  </section>
                </xsl:when>
                <xsl:otherwise>
                  <section type="undefined" id="TotalThreadCount">
                    <header>
                      <column>/TotalThreadCountWithIssues</column>
                    </header>
                  </section>
                </xsl:otherwise>
              </xsl:choose>
              <xsl:choose>
                <xsl:when test="$isRunssMode">
                  <section type="undefined" expanded="true" id="WaitTime">
                    <header>
                      <column>/WaitTimeWithPoorCPUUtilizationString</column>
                    </header>
                    <sections>
                      <xsl:copy-of select="$summaryBlocks//root/waitObjectsWithPoorCPUUtilization/*"/>
                    </sections>
                  </section>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('hideContextSwitchesType',0)">
                      <section type="undefined" expanded="true" id="InactiveWaitTime">
                        <header>
                          <column>/InactiveWaitTimeWithPoorCPUUtilizationString</column>
                        </header>
                        <sections>
                          <xsl:copy-of select="$summaryBlocks//root/inactiveWaitTimeWithPoorCPUUtilization/*"/>
                        </sections>
                      </section>
                    </xsl:when>
                    <xsl:otherwise>
                      <section type="tree" expanded="true" id="InactiveWaitTime">
                        <header>
                          <column>/InactiveWaitTimeWithPoorCPUUtilizationString</column>
                        </header>
                        <tree valueAlign="right" boolean:highlightColumnsWithExpansion="{$highlightColumnsWithExpansion}">
                          <columns>
                            <column>/InactiveSyncWaitTimeWithPoorCPUUtilization</column>
                            <column>/PreemptionWaitTimeWithPoorCPUUtilization</column>
                          </columns>
                        </tree>
                        <sections>
                          <xsl:copy-of select="$summaryBlocks//root/inactiveWaitTimeWithPoorCPUUtilization/*"/>
                        </sections>
                      </section>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:otherwise>
              </xsl:choose>
              <section type="undefined" expanded="onIssues" id="CPUOverheadAndSpinTime">
                <header>
                  <column>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$querySuffix"/>
                    <xsl:text>OverheadAndSpinTimeString</xsl:text>
                  </column>
                </header>
                <sections>
                  <xsl:copy-of select="$summaryBlocks//root/topFunctionWithSpinOverheadTime/*"/>
                </sections>
              </section>
            </sections>
          </section>
          <xsl:copy-of select="$summaryBlocks//root/resultInfo/*"/>
        </sections>
        <xsl:copy-of select="$summaryBlocks//root/messages"/>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
