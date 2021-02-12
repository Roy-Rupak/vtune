<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
    xmlns:str="http://exslt.org/strings" syntax="norules">
  <xsl:output indent="yes" method="xml"/>
     <xsl:param name="classId"/>
     <xsl:param name="classToPartMap"/>
     <xsl:param name="eventsList"/>
  <xsl:template match="/">
    <variables>
      <chooseEventsByClass>
       <xsl:for-each select="str:tokenize($classToPartMap, ';')">
          <xsl:variable name='className' select="substring-before(.,':')"/>
          <xsl:variable name='parts' select="substring-after(.,':')"/>
          <xsl:if test="$className = $classId">
            <xsl:for-each select="str:tokenize($parts, ',')">
              <xsl:variable name='part' select="."/>
              <xsl:for-each select="str:tokenize($eventsList, ',')">
                <xsl:variable name='partNumber' select="translate(., translate(., '0123456789', ''), '')" />
                <xsl:if test="$partNumber = $part">
                  <xsl:value-of select="concat(., ',')"/>
                </xsl:if>
              </xsl:for-each>
            </xsl:for-each>
          </xsl:if>
       </xsl:for-each>
      </chooseEventsByClass>
    </variables>
  </xsl:template>
</xsl:stylesheet>
