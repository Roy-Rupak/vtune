<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
  xmlns:exsl="http://exslt.org/common"
  exsl:keep_exsl_namespace=""
  xmlns:str="http://exslt.org/strings"
  str:keep_str_namespace=""
  syntax="norules" >
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="connections"/>
  <xsl:template match="/">
  <require_connection>
    <xsl:variable name="groupsList">
      <group name="group_generic">
        <item>localhost</item>
        <item>ssh</item>
        <item>adb</item>
        <item>agent</item>
      </group>
    </xsl:variable>
    <xsl:variable name="supportedConnectionsList">
      <xsl:for-each select="str:split($connections, ',')">
        <xsl:choose>
          <xsl:when test="exsl:node-set($groupsList)/group[@name=string(current())]" >
            <xsl:copy-of select="exsl:node-set($groupsList)/group[@name=string(current())]/*" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="current()" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:variable>
    <xsl:variable name="connectionType" select="exsl:ctx('connectionType','')" />
    <xsl:for-each select="exsl:node-set($supportedConnectionsList)">
      <xsl:if test="not(*[.=$connectionType])">
        <xsl:value-of select="exsl:error('%ThisAnalysisTypeIsNotApplicable')"/>
      </xsl:if>
    </xsl:for-each>
  </require_connection>
  </xsl:template>
</xsl:stylesheet>
