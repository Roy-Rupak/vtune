<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="msxsl" xmlns:str="http://exslt.org/strings" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:unsignedInt="http://www.w3.org/2001/XMLSchema#unsignedInt">
  <xsl:output method="xml" indent="yes"/>
  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="masterPane[@id='flatProfilePane']">
        <masterPane id="callerCalleePane"/>
  </xsl:template>
  <xsl:template match="pane[@id='flatProfilePane']">
        <pane id="callerCalleePane" placeId="resultsArea"/>
  </xsl:template>
  <xsl:template match="*[@id='callersPane'] | *[@id='calleesPane']">
  </xsl:template>
  <xsl:template match="//topDown[@id='flatProfilePane']">
        <html id="callerCalleePane" displayName="%CallerCalleeWindow">
          <xsl:copy-of select="./description"/>
          <xsl:copy-of select="./helpKeywordF1"/>
          <xsl:copy-of select="./icon"/>
          <application name="caller-callee"/>
          <filter handleList="global"/>
          <event handleList="KnobChangedEvent"/>
          <config>
            <functions queryType="flatProfile">
              <columns>/ViewpointGUIandCLIColumns</columns>
              <grouping>/FlatProfileFunction</grouping>
            </functions>
            <callers queryType="selectionParentTree">
              <columns>
                <xsl:value-of select="../bottomUp[@id='callersPane']/columnBy/queryInherit"/>
              </columns>
              <grouping>/FlatProfileCallers</grouping>
            </callers>
            <callees queryType="selectionChildTree">
              <columns>
                <xsl:value-of select="../bottomUp[@id='callersPane']/columnBy/queryInherit"/>
              </columns>
              <grouping>/FlatProfileCallees</grouping>
            </callees>
            <messages>
              <noData displayName="%{./errorMessage}"/>
              <ofLabel displayName="%OfLabel"/>
              <loadingLabel displayName="%LoadingLabel"/>
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
              <byLabel displayName="%ByLabel"/>
              <formulaLabel displayName="%FormulaLabel"/>
              <totalDataTooltip displayName="%TotalDataTooltip"/>
              <selfDataTooltip displayName="%SelfDataTooltip"/>
              <thresholdLabel displayName="%ThresholdLabel"/>
              <viewSourceLabel displayName="%ViewSourceLabel"/>
              <noDataLabel displayName="%ErrorNoData"/>
            </messages>
          </config>
        </html>
  </xsl:template>
  <xsl:template match="bottomUp | topDown">
    <html id="{./@id}" displayName="{./@displayName}">
      <xsl:copy-of select="./description"/>
      <xsl:copy-of select="./helpKeywordF1"/>
      <xsl:copy-of select="./icon"/>
      <application name="grid"/>
      <filter handleList="global"/>
      <event handleList="KnobChangedEvent"/>
      <config>
        <groupings expandVectorQueries="grouping">
          <grouping>
            <xsl:if test="./rowBy/vectorQueryInsert">
              <xsl:value-of select="./rowBy/vectorQueryInsert"/>
            </xsl:if>
            <xsl:if test="./rowBy/queryRef">
              <xsl:value-of select="./rowBy/queryRef"/>
            </xsl:if>
          </grouping>
        </groupings>
        <groupingItems expandVectorQueries="groupingItem">
          <groupingItem>
            <xsl:if test="./rowBy/vectorQueryInsert">
              <xsl:value-of select="./rowBy/vectorQueryInsert"/>
            </xsl:if>
            <xsl:if test="./rowBy/queryRef">
              <xsl:value-of select="./rowBy/queryRef"/>
            </xsl:if>
          </groupingItem>
          <xsl:if test="./doiBy/queryRef">
            <groupingItem>
              <xsl:value-of select="./doiBy/queryRef"/>
            </groupingItem>
          </xsl:if>
          <xsl:if test="./groupingItems/vectorQueryInsert">
            <groupingItem>
              <xsl:value-of select="./groupingItems/vectorQueryInsert"/>
            </groupingItem>
          </xsl:if>
        </groupingItems>
        <grid>
          <xsl:attribute name="queryType">auto</xsl:attribute>
          <columns>
            <xsl:choose>
              <xsl:when test="./columnBy/queryInherit">
                <xsl:value-of select="./columnBy/queryInherit"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="./columnBy/vectorQueryInsert"/>
              </xsl:otherwise>
            </xsl:choose>
          </columns>
          <xsl:if test="./rowBy/sort/queryRef">
            <sorting>
              <xsl:value-of select="./rowBy/sort/queryRef"/>
            </sorting>
          </xsl:if>
          <xsl:if test="./rowBy/default/queryRef">
            <grouping>
              <xsl:value-of select="./rowBy/default/queryRef"/>
            </grouping>
          </xsl:if>
          <xsl:if test="./displayAttributes/unsignedInt:expandLevels">
            <unsignedInt:expandLevels>
              <xsl:value-of select="./displayAttributes/unsignedInt:expandLevels"/>
            </unsignedInt:expandLevels>
          </xsl:if>
        </grid>
        <messages>
          <noData displayName="{./errorMessage}"/>
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
          <filterInLabel displayName="%FilterInBySelection"/>
          <filterOutLabel displayName="%FilterOutBySelection"/>
          <copyCellToClipboardLabel displayName="%CopyCellToClipboardLabel"/>
          <copyRowsToClipboardLabel displayName="%CopyRowsToClipboardLabel"/>
          <exportToCSVLabel displayName="%ExportToCSVLabel"/>
          <failedToSaveFileLabel displayName="%FailedToSaveFileLabel"/>
          <searchTooltip displayName="%SearchTooltip"/>
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
        </messages>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
