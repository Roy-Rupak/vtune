<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="msxsl" xmlns:str="http://exslt.org/strings" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean">
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id">stackPane</xsl:param>
  <xsl:param name="displayName">CallStackTab</xsl:param>
  <xsl:param name="description">ParallelismStackWindowDescription</xsl:param>
  <xsl:param name="metrics">MyDataColumns</xsl:param>
  <xsl:param name="contextSwitchMetrics">WaitAndContextSwitchDataMetrics</xsl:param>
  <xsl:param name="layers"/>
  <xsl:template match="/">
    <html id="{$id}" displayName="%{$displayName}">
      <helpKeywordF1>configs.stack_pane_f1020</helpKeywordF1>
      <icon file="client.dat#zip:images.xrc" image="tab_grid"/>
      <description>
        <xsl:text>%</xsl:text>
        <xsl:value-of select="$description"/>
      </description>
      <application name="stack"/>
      <filter handleList="selection,global"/>
      <event handleList="KnobChangedEvent"/>
      <additionalParams boolean:showInDiff="false"/>
      <config>
        <xsl:variable name="stackTypes">
          <item type="CPU"                  inline="true"   grouping="Function"/>
          <item type="PMU"                  inline="true"   grouping="Function"/>
          <item type="ContextSwitch"        inline="true"   grouping="InternalAddress"  metrics="{$contextSwitchMetrics}"/>
          <item type="Wait"                 inline="true"   grouping="InternalAddress"  metrics="WaitStackLayerMetrics"/>
          <item type="CStateTimer"          inline="false"  grouping="Function"         metrics="CStateWakeUpCount"/>
          <xsl:choose>
            <xsl:when test="exsl:ctx('PMU') = 'knl'">
              <item type="PMUMemoryObjectAlloc" inline="false"  grouping="InternalAddress"  metrics="LLCMissCount"/>
            </xsl:when>
            <xsl:otherwise>
              <item type="PMUMemoryObjectAlloc" inline="false"  grouping="InternalAddress"  metrics="PMULoadsAndStores"/>
            </xsl:otherwise>
          </xsl:choose>
          <item type="WaitSyncObjCreation"  inline="false"  grouping="InternalAddress"  metrics="WaitStackLayerMetrics"/>
          <item type="Signal"               inline="false"  grouping="Function"         metrics="WaitStackLayerMetrics"/>
          <item type="UserTask"             inline="false"  grouping="InternalAddress"  metrics="UserTaskTime"/>
          <item type="MemoryAlloc"          inline="false"  grouping="Function"         metrics="AllocCount"/>
        </xsl:variable>
        <layers>
          <xsl:for-each select="exsl:node-set($stackTypes)/item">
            <xsl:if test="contains(concat('/', $layers, '/'), concat('/', @type, '/'))">
              <layer displayName="%{@type}CallStackTypeName" boolean:inline="{@inline}">
                <description displayName="%{@type}CallStackDescription"/>
                <grouping>
                  <object>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="@type"/>
                    <xsl:value-of select="@grouping"/>
                  </object>
                  <callstack>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="@type"/>
                    <xsl:text>ParentCallStackNoMerge</xsl:text>
                  </callstack>
                </grouping>
                <metrics>
                  <xsl:text>/</xsl:text>
                  <xsl:choose>
                    <xsl:when test="@metrics">
                      <xsl:value-of select="@metrics"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="$metrics"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </metrics>
                <function>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="@type"/>
                  <xsl:text>Function</xsl:text>
                </function>
                <module>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="@type"/>
                  <xsl:text>StackModule</xsl:text>
                </module>
                <offset>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="@type"/>
                  <xsl:text>StackFunctionOffsetFromStart</xsl:text>
                </offset>
                <sourceFile>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="@type"/>
                  <xsl:text>StackSourceFile</xsl:text>
                </sourceFile>
                <sourceLine>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="@type"/>
                  <xsl:text>StackSourceLine</xsl:text>
                </sourceLine>
              </layer>
            </xsl:if>
          </xsl:for-each>
        </layers>
        <messages>
          <viewingLabel displayName="%ViewingLabel"/>
          <ofLabel displayName="%OfLabel"/>
          <selectedStacksLabel displayName="%SelectedStacksLabel"/>
          <noStackInformationLabel displayName="%NoStackInformationLabel"/>
          <loadingLabel displayName="%LoadingLabel"/>
          <viewSourceLabel displayName="%ViewSourceLabel"/>
          <showModulesLabel displayName="%ShowModulesLabel"/>
          <showSourceFileAndLineLabel displayName="%ShowSourceFileAndLineLabel"/>
          <showInOneLineModeLabel displayName="%ShowInOneLineModeLabel"/>
          <copyToClipboardLabel displayName="%CopyToClipboard"/>
          <unknownSourceFileLabel displayName="%UnknownSourceFileLabel"/>
          <stackLimitExceededMessage displayName="%StackLimitExceededMessage"/>
          <stackCountLimitExceededMessage displayName="%StackCountLimitExceededMessage"/>
        </messages>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
