<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="msxsl" xmlns:str="http://exslt.org/strings" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:unsignedInt="http://www.w3.org/2001/XMLSchema#unsignedInt">
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id">bottomUpPane</xsl:param>
  <xsl:param name="displayName">BottomUpWindow</xsl:param>
  <xsl:param name="description">HotspotsBottomUpWindowDescription</xsl:param>
  <xsl:param name="helpKeyword">configs.bottom_up_f1109</xsl:param>
  <xsl:param name="errorMessage">no</xsl:param>
  <xsl:param name="groupings"></xsl:param>
  <xsl:param name="defaultGrouping">no</xsl:param>
  <xsl:param name="sorting">no</xsl:param>
  <xsl:param name="columns">ViewpointGUIandCLIColumns</xsl:param>
  <xsl:param name="groupingItems">BottomUpGroupingItems</xsl:param>
  <xsl:param name="queryType">bottomUp</xsl:param>
  <xsl:param name="stackMode"></xsl:param>
  <xsl:param name="stateVersion">no</xsl:param>
  <xsl:param name="expandLevels">no</xsl:param>
  <xsl:param name="localized">no</xsl:param>
  <xsl:param name="iptDetails">no</xsl:param>
  <xsl:template match="/">
    <html id="{$id}">
      <xsl:attribute name="displayName">
        <xsl:if test="$localized='no'">
          <xsl:text>%</xsl:text>
        </xsl:if>
        <xsl:copy-of select="translate($displayName, '~', ' ')"/>
      </xsl:attribute>
      <xsl:if test="$stateVersion!='no'">
        <xsl:attribute name="int:stateVersion">
          <xsl:value-of select="$stateVersion"/>
        </xsl:attribute>
      </xsl:if>
      <description>
        <xsl:if test="$localized='no'">
          <xsl:text>%</xsl:text>
        </xsl:if>
        <xsl:copy-of select="translate($description, '~', ' ')"/>
      </description>
      <helpKeywordF1>
        <xsl:value-of select="$helpKeyword"/>
      </helpKeywordF1>
      <icon file="client.dat#zip:images.xrc" image="tab_grid"/>
      <application name="grid"/>
      <filter handleList="global"/>
      <event handleList="KnobChangedEvent"/>
      <config>
        <xsl:if test="exsl:is_experimental('ipt-frame-summary') or exsl:is_experimental('ipt-function-summary') or $iptDetails!='no'">
          <boolean:allowLoadingDetails>true</boolean:allowLoadingDetails>
        </xsl:if>
        <groupings expandVectorQueries="grouping">
          <grouping>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$groupings"/>
          </grouping>
        </groupings>
        <groupingItems expandVectorQueries="groupingItem">
          <groupingItem>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$groupings"/>
          </groupingItem>
          <xsl:if test="$groupingItems!='no'">
            <groupingItem>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$groupingItems"/>
            </groupingItem>
          </xsl:if>
        </groupingItems>
        <grid queryType="{$queryType}" stackMode="{$stackMode}">
          <columns>
            <xsl:text>/</xsl:text>
            <xsl:value-of select="$columns"/>
          </columns>
          <xsl:if test="$sorting!='no'">
            <sorting>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$sorting"/>
            </sorting>
          </xsl:if>
          <xsl:if test="$defaultGrouping!='no'">
            <grouping>
              <xsl:value-of select="$defaultGrouping"/>
            </grouping>
          </xsl:if>
          <xsl:if test="$expandLevels!='no'">
            <unsignedInt:expandLevels>
              <xsl:value-of select="$expandLevels"/>
            </unsignedInt:expandLevels>
          </xsl:if>
        </grid>
        <messages>
          <xsl:if test="$errorMessage!='no'">
            <noData displayName="%{$errorMessage}"/>
          </xsl:if>
          <ofLabel displayName="%OfLabel"/>
          <loadingLabel displayName="%LoadingLabel"/>
          <stacksAsTreeTooltip displayName="%StacksAsTreeTooltip"/>
          <stacksAsChainTooltip displayName="%StacksAsChainTooltip"/>
          <groupingCustomizationTooltip displayName="%GroupingCustomizationTooltip"/>
          <selectAllLabel displayName="%SelectAllLabel"/>
          <expandSelectedRowsLabel displayName="%ExpandSelectedRowsLabel"/>
          <collapseAllLabel displayName="%CollapseAllLabel"/>
          <hideColumnLabel displayName="%HideColumnLabel"/>
          <showAllColumnsLabel displayName="%ShowAllColumnsLabel"/>
          <showDataAsLabel displayName="%ShowDataAsLabel"/>
          <columnHelpLabel displayName="%ColumnHelpLabel"/>
          <loadMoreDataLabel displayName="%LoadIPTBySelection"/>
          <filterInLabel displayName="%FilterInBySelection"/>
          <filterOutLabel displayName="%FilterOutBySelection"/>
          <copyCellToClipboardLabel displayName="%CopyCellToClipboardLabel"/>
          <copyRowsToClipboardLabel displayName="%CopyRowsToClipboardLabel"/>
          <exportToCSVLabel displayName="%ExportToCSVLabel"/>
          <failedToSaveFileLabel displayName="%FailedToSaveFileLabel"/>
          <searchTooltip displayName="%SearchTooltip"/>
          <searchTooltipMac displayName="%SearchTooltipMac"/>
          <byLabel displayName="%ByLabel"/>
          <formulaLabel displayName="%FormulaLabel"/>
          <totalDataTooltip displayName="%TotalDataTooltip"/>
          <selfDataTooltip displayName="%SelfDataTooltip"/>
          <thresholdLabel displayName="%ThresholdLabel"/>
          <selectGroupingLabel displayName="%SelectGroupingLabel"/>
          <customizeGroupingLabel displayName="%CustomizeGroupingLabel"/>
          <groupingItemsLimitLabel displayName="%GroupingItemsLimitLabel"/>
          <closeGroupingLabel displayName="%CloseGroupingLabel"/>
          <viewSourceLabel displayName="%ViewSourceLabel"/>
          <noDataLabel displayName="%ErrorNoData"/>
          <pinLabel displayName="%PinLabel"/>
        </messages>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
