<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
    syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="/">
    <constants>
      <hasDRAMCache>
        <xsl:choose>
          <xsl:when test="contains(exsl:ctx('pmuId',''),'knh') or contains(exsl:ctx('pmuId',''),'knl')">true</xsl:when>
          <xsl:otherwise>false</xsl:otherwise>
        </xsl:choose>
      </hasDRAMCache>
      <hasL3Cache>
        <xsl:choose>
          <xsl:when test="contains(exsl:ctx('pmuId',''),'knh') or contains(exsl:ctx('pmuId',''),'knl')">false</xsl:when>
          <xsl:otherwise>true</xsl:otherwise>
        </xsl:choose>
      </hasL3Cache>
    </constants>
  </xsl:template>
</xsl:stylesheet>
