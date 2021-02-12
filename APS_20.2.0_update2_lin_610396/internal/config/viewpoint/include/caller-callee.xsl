<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="msxsl" xmlns:str="http://exslt.org/strings" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:unsignedInt="http://www.w3.org/2001/XMLSchema#unsignedInt">
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="description">HotspotsCallerCalleeWindowDescription</xsl:param>
  <xsl:param name="errorMessage">ErrorNoDataHotspots</xsl:param>
  <xsl:param name="flatProfileColumns">ViewpointGUIandCLIColumns</xsl:param>
  <xsl:param name="callerCalleeColumns">MyDataColumns</xsl:param>
  <xsl:param name="stateVersion">no</xsl:param>
  <xsl:template match="/">
    <root>
      <html id="callerCalleePane" displayName="%CallerCalleeWindow">
        <xsl:if test="$stateVersion!='no'">
          <xsl:attribute name="int:stateVersion">
            <xsl:value-of select="$stateVersion"/>
          </xsl:attribute>
        </xsl:if>
        <description>
          <xsl:text>%</xsl:text>
          <xsl:value-of select="$description"/>
        </description>
        <helpKeywordF1>configs.caller_f1048</helpKeywordF1>
        <icon file="client.dat#zip:images.xrc" image="tab_grid"/>
        <application name="caller-callee"/>
        <filter handleList="global"/>
        <event handleList="KnobChangedEvent"/>
        <config>
          <functions queryType="flatProfile">
            <columns>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$flatProfileColumns"/>
            </columns>
            <grouping>/FlatProfileFunction</grouping>
          </functions>
          <callers queryType="selectionParentTree">
            <columns>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$callerCalleeColumns"/>
            </columns>
            <grouping>/FlatProfileCallers</grouping>
            <unsignedInt:expandLevels>1</unsignedInt:expandLevels>
          </callers>
          <callees queryType="selectionChildTree">
            <columns>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$callerCalleeColumns"/>
            </columns>
            <grouping>/FlatProfileCallees</grouping>
            <unsignedInt:expandLevels>1</unsignedInt:expandLevels>
          </callees>
          <messages>
            <xsl:if test="$errorMessage!='no'">
              <noData displayName="%{$errorMessage}"/>
            </xsl:if>
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
            <changeFocusFunctionLabel displayName="%ChangeFocusFunctionLabel"/>
          </messages>
        </config>
      </html>
    </root>
  </xsl:template>
</xsl:stylesheet>
