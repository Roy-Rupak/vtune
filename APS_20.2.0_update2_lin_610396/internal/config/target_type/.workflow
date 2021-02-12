<?xml version="1.0" encoding="utf-8"?>
<bag
    xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
    xsl:version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    exsl:keep_exsl_namespace=""
    syntax="norules"
>
  <item idToUse="%Attach"/>
  <item idToUse="%System"/>
  <item idToUse="%Launch"/>
  <item idToUse="%AndroidRun"/>
  <item idToUse="%SniperRun"/>

  <xsl:choose>
    <xsl:when test="
      exsl:ctx('connectionType') = 'modem-stb'
      or exsl:ctx('connectionType') = 'modem-cdc'
      or exsl:ctx('connectionType') = 'modem-dvc'
      or exsl:ctx('connectionType') = 'ghs'
      ">
      <defaultItem idToUse="%System"/>
    </xsl:when>
    <xsl:when test="exsl:ctx('connectionType', '') = 'sniper'">
      <defaultItem idToUse="%SniperRun"/>
    </xsl:when>
    <xsl:otherwise>
      <defaultItem idToUse="%Launch"/>
    </xsl:otherwise>
  </xsl:choose>
</bag>
