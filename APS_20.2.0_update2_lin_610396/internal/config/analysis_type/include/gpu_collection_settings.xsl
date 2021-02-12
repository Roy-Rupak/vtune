<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
    syntax="norules"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:double="http://www.w3.org/2001/XMLSchema#double"
  xmlns:str="http://exslt.org/strings"
>
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="gpuHotspots">false</xsl:param>
  <xsl:param name="gpuOffload">false</xsl:param>
  <xsl:template match="/">
    <knobs>
      <xsl:variable name="commonDoc" select="document('config://collector/include/common.xsl')"/>
      <xsl:variable name="collectGTPin" select="string($commonDoc//common/variables/collectGTPin)"/>
      <programming_apis>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='MacOSX'">
            <collectorKnob knob="collectGpuMetal"><xsl:value-of select="exsl:ctx('gpuOpenCLCollection', 0)"/></collectorKnob>
          </xsl:when>
          <xsl:otherwise>
            <collectorKnob knob="collectGpuOpenCl">
              <xsl:choose>
                <xsl:when test="$collectGTPin = 'true'">true</xsl:when>
                <xsl:otherwise>
                  <xsl:value-of select="exsl:ctx('gpuOpenCLCollection', 'true')"/>
                </xsl:otherwise>
              </xsl:choose>
            </collectorKnob>
            <xsl:if test="exsl:ctx('targetOS')='Linux'">
              <collectorKnob knob="collectGpuLevelZero"><xsl:value-of select="exsl:ctx('gpuOpenCLCollection', 0)"/></collectorKnob>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </programming_apis>
      <inline>
        <xsl:choose>
          <xsl:when test="$collectGTPin = 'true'">
            <collectorKnob knob="showInlinesByDefault">true</collectorKnob>
          </xsl:when>
          <xsl:otherwise>
            <collectorKnob knob="showInlinesByDefault">false</collectorKnob>
          </xsl:otherwise>
        </xsl:choose>
      </inline>
      <xsl:variable name="runtool" select="document('config://analysis_type/include/runtool.xsl')"/>
      <xsl:variable name="runtoolToUse" select="$runtool//variables/runtoolToUse"/>
      <hostCollector>
        <xsl:choose>
          <xsl:when test="$runtoolToUse='runss'">
            <xsl:if test="not(exsl:ctx('isTPSSAvailable', 0)) and not(exsl:ctx('isPtraceAvailable', 0))">
              <xsl:value-of select="exsl:error('%RunssBasicHotspotsNotSupported')"/>
            </xsl:if>
            <xsl:if test="exsl:ctx('isPtraceScopeLimited', 0)">
              <xsl:value-of select="exsl:error('%RunssPtraceScopeLimited')"/>
            </xsl:if>
            <collectorKnob knob="collectSamplesMode">
              <xsl:choose>
                <xsl:when test="$gpuOffload = 'true' and exsl:ctx('enableStackCollect', 0)">
                  <xsl:text>stack</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:text>nostack</xsl:text>
                </xsl:otherwise>
              </xsl:choose>
            </collectorKnob>
            <collectorKnob knob="samplingInterval">10</collectorKnob>
          </xsl:when>
          <xsl:otherwise>
            <xsl:copy-of select="document('config://analysis_type/include/prerequisites.xsl')/pmu_prerequisites/*"/>
            <xsl:variable name="MainEvents" select="document('config://analysis_type/include/common_events.xsl')/events/cpi/text()"/>
            <collectorKnob knob="pmuEventConfig"><xsl:value-of select="$MainEvents"/></collectorKnob>
            <xsl:if test="$gpuOffload = 'true'">
              <collectorKnob knob="enableStackCollection"><xsl:value-of select="exsl:ctx('enableStackCollect', 0)"/></collectorKnob>
              <collectorKnob knob="preferDriverlessCollection"><xsl:value-of select="exsl:ctx('enableStackCollect', 0)"/></collectorKnob>
              <collectorKnob knob="collectPCIeBandwidth">true</collectorKnob>
            </xsl:if>
            <xsl:if test="$gpuHotspots = 'true'">
              <collectorKnob knob="eventMode">all</collectorKnob>
              <boolean:collectorKnob knob="enableCSwitch">false</boolean:collectorKnob>
              <collectorKnob knob="pmuSamplingInterval"><xsl:value-of select="format-number(exsl:ctx('samplingInterval', 1), '#.####')"/></collectorKnob>
            </xsl:if>
          </xsl:otherwise>
        </xsl:choose>
      </hostCollector>
      <bandwidth>
        <xsl:if test="exsl:ctx('collectMemoryBW', 0) and
          ((exsl:ctx('gpuProfilingModeAtk') = 'characterization' and $gpuHotspots = 'true') or
          $gpuOffload = 'true')">
          <xsl:choose>
            <xsl:when test="$runtoolToUse='runss'">
              <xsl:value-of select="exsl:error('%BandwidthIsNotWorkWithoutSampling')"/>
            </xsl:when>
            <xsl:otherwise>
              <boolean:collectorKnob knob="collectMemBandwidth">true</boolean:collectorKnob>
              <collectorKnob knob="dramBandwidthLimits">true</collectorKnob>
              <xsl:value-of select="exsl:warning('%BandwidthLimitsCollectionIsEnabledByDefaultWarning')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
      </bandwidth>
    </knobs>
  </xsl:template>
</xsl:stylesheet>
