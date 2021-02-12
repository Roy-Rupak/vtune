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
  <xsl:param name="showSummaryInfo">true</xsl:param>
  <xsl:param name="showTasks">
    <xsl:value-of select="exsl:is_non_empty_table_exist('task_data')"/>
  </xsl:param>
  <xsl:param name="showFrames">
    <xsl:value-of select="exsl:is_non_empty_table_exist('frame_data')"/>
  </xsl:param>
  <xsl:param name="showCPUHotspots">false</xsl:param>
  <xsl:param name="showCPUUsage">false</xsl:param>
  <xsl:param name="showBandwidthUtilization">false</xsl:param>
  <xsl:param name="showBandwidth">false</xsl:param>
  <xsl:param name="showAcceleratorOCL">false</xsl:param>
  <xsl:param name="showUtube">false</xsl:param>
  <xsl:param name="showPhysicalCores">false</xsl:param>
  <xsl:param name="enableLinksInSummaryInfo">true</xsl:param>
  <xsl:param name="showResultInfo">true</xsl:param>
  <xsl:param name="packetsType">true</xsl:param>
  <xsl:param name="summaryInfoMaxLevelsToShow">100</xsl:param>
  <xsl:param name="manageGlobalFilter">false</xsl:param>
  <xsl:param name="highlightColumnsWithExpansion">true</xsl:param>
  <xsl:param name="applicationFile">summary</xsl:param>
  <xsl:template match="/">
    <xsl:variable name="barrierDataCollected" select="exsl:is_non_empty_table_exist('barrier_data')"/>
    <xsl:variable name="needToShowFrames" select="($showFrames='true') and exsl:is_non_empty_table_exist('frame_data')"/>
    <xsl:variable name="preciseClockticsCollected" select="exsl:ctx('collectPreciseClockticks')"/>
    <xsl:variable name="summaryBlocksParams">
      <params
        querySuffix="{$querySuffix}"
        contextMode="{$contextMode}"
        packetsType="{$packetsType}"
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
        <xsl:attribute name="boolean:manageGlobalFilter">
          <xsl:value-of select="$manageGlobalFilter"/>
        </xsl:attribute>
      </filter>
      <event handleList="KnobChangedEvent"/>
      <application name="{$applicationFile}"/>
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
          <xsl:if test="$showSummaryInfo='true'">
            <section type="tree" expanded="true" id="ResultSummary">
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
                <xsl:if test="$enableLinksInSummaryInfo='true'">
                  <href>
                    <activate tabId="bottomUpPane" handlerId="bottomUpPane">
                      <column/>
                    </activate>
                  </href>
                </xsl:if>
                <columns>
                  <column>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$resultSummaryColumns"/>
                  </column>
                  <xsl:if test="($contextMode != 'true')">
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
          <xsl:if test="$showCPUHotspots='true'">
            <xsl:copy-of select="$summaryBlocks//root/cpuHotspots/*"/>
          </xsl:if>
          <xsl:if test="$showAcceleratorOCL='true'">
            <xsl:copy-of select="$summaryBlocks//root/acceleratorOCL/*"/>
          </xsl:if>
          <xsl:if test="$showTasks='true'">
            <xsl:copy-of select="$summaryBlocks//root/tasks/*"/>
          </xsl:if>
          <xsl:if test="$showCPUUsage='true'">
            <xsl:copy-of select="$summaryBlocks//root/cpuUsageChart/*"/>
          </xsl:if>
          <xsl:if test="$showBandwidth='true'">
            <xsl:copy-of select="$summaryBlocks//root/averageBandwidth/*"/>
          </xsl:if>
          <xsl:if test="$showBandwidthUtilization='true'">
            <xsl:copy-of select="$summaryBlocks//root/bandwidthUtilizationStatistic/*"/>
            <xsl:copy-of select="$summaryBlocks//root/bandwidthUtilizationChart/*"/>
          </xsl:if>
          <xsl:if test="$needToShowFrames">
            <xsl:copy-of select="$summaryBlocks//root/frameChart/*"/>
          </xsl:if>
          <xsl:if test="$showTasks='true'">
            <xsl:copy-of select="$summaryBlocks//root/taskChart/*"/>
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
