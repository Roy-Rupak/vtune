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
  <xsl:template match="timeline">
    <xsl:if test="not(exsl:is_compare_mode())">
      <html id="{./@id}" displayName="{./@displayName}">
        <xsl:apply-templates select="./*[not(self::area) and not(self::ruler)]"/>
        <application name="timeline"/>
        <filter handleList="selection,global"/>
        <event handleList="KnobChangedEvent"/>
        <additionalParams boolean:showInDiff="false"/>
        <config>
          <xsl:apply-templates select="./area | ./ruler"/>
        </config>
        <messages>
          <noDataLabel displayName="%ErrorNoData"/>
        </messages>
      </html>
    </xsl:if>
  </xsl:template>
  <xsl:template match="timeline/*[not(self::area) and not(self::ruler)]">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="area | ruler">
    <xsl:copy>
      <xsl:apply-templates select="node() | @*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
