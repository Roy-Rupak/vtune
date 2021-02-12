<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:exsl="http://exslt.org/common" exclude-result-prefixes="msxsl" xmlns:str="http://exslt.org/strings" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean">
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="id">quickFilterPane</xsl:param>
  <xsl:param name="displayName">FilterBar</xsl:param>
  <xsl:param name="metrics">MyDataColumns</xsl:param>
  <xsl:param name="doiBy"/>
  <xsl:param name="visible">true</xsl:param>
  <xsl:param name="groupings"/>
  <xsl:param name="showCalleeAttributionKnob">true</xsl:param>
  <xsl:param name="showLoopKnob">true</xsl:param>
  <xsl:param name="showInlineKnob">true</xsl:param>
  <xsl:template match="/">
    <html id="{$id}" displayName="%{$displayName}">
      <application name="qfilter"/>
      <filter handleList="global" boolean:manageGlobalFilter="true"/>
      <config>
        <data>
          <columns>
            <column>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="$metrics"/>
            </column>
          </columns>
          <groupings>
          <xsl:for-each select="str:tokenize($groupings, '/')">
              <xsl:if test="not((exsl:is_compare_mode() and contains(., 'Thread')) or (exsl:ctx('collectPreciseClockticks') and contains(., 'CPUUsageUtilization')))">
                <grouping>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="." />
                </grouping>
              </xsl:if>
          </xsl:for-each>
          </groupings>
        </data>
        <xsl:if test="exsl:is_non_empty_table_exist('dd_callsite') or (exsl:is_non_empty_table_exist('gpu_gtpin_data')) or (exsl:ctx('gsimClockDuration', 0) > 0)">
          <knobs>
            <xsl:if test="$showCalleeAttributionKnob='true'">
              <knob id="calleeAttributionMode"/>
            </xsl:if>
            <xsl:if test="$showLoopKnob='true'">
              <knob id="loopAttributionMode"/>
            </xsl:if>
            <xsl:if test="$showInlineKnob='true'">
              <knob id="inlineAttributionMode"/>
            </xsl:if>
          </knobs>
        </xsl:if>
        <messages>
          <ofLabel displayName="%OfLabel"/>
          <metricTooltip displayName="%MetricTooltip"/>
          <clearFilterTooltip displayName="%ClearFilterTooltip"/>
          <any displayName="%Any"/>
          <filterLabel displayName="%FilterBar"/>
          <selectLabel displayName="%SelectLabel"/>
          <tooltip2dPartLabel displayName="%Tooltip2dPartLabel"/>
        </messages>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
