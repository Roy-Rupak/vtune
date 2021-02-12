<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
    exclude-result-prefixes="msxsl"
    xmlns:exsl="http://exslt.org/common"
    exsl:keep_exsl_namespace=""
    syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="/">
  <root>
    <pmu_prerequisites>
      <xsl:if test="exsl:ctx('PMU', '') = ''">
        <xsl:value-of select="exsl:error('%UnknownPMUForAT')"/>
      </xsl:if>
      <xsl:if test="not (
        exsl:ctx('PMU') = 'core2'
        or exsl:ctx('PMU') = 'core2p'
        or exsl:ctx('PMU') = 'corei7'
        or exsl:ctx('PMU') = 'corei7wsp'
        or exsl:ctx('PMU') = 'corei7wdp'
        or exsl:ctx('PMU') = 'corei7b'
        or exsl:ctx('PMU') = 'snb'
        or exsl:ctx('PMU') = 'snbep'
        or exsl:ctx('PMU') = 'ivytown'
        or exsl:ctx('PMU') = 'ivybridge'
        or exsl:ctx('PMU') = 'haswell'
        or exsl:ctx('PMU') = 'haswell_server'
        or exsl:ctx('PMU') = 'silvermont'
        or exsl:ctx('PMU') = 'airmont'
        or exsl:ctx('PMU') = 'crystalwell'
        or exsl:ctx('PMU') = 'atom'
        or exsl:ctx('PMU') = 'airmont'
        or exsl:ctx('PMU') = 'broadwell'
        or exsl:ctx('PMU') = 'skylake'
        or exsl:ctx('PMU') = 'skylake_server'
        or exsl:ctx('PMU') = 'cascadelake_server'
        or exsl:ctx('PMU') = 'broadwell_de'
        or exsl:ctx('PMU') = 'broadwell_server'
        or exsl:ctx('PMU') = 'knl'
        or exsl:ctx('PMU') = 'goldmont'
        or exsl:ctx('PMU') = 'goldmont_plus'
        or exsl:ctx('PMU') = 'cannonlake'
        or exsl:ctx('PMU') = 'lakemont'
        or exsl:ctx('PMU') = 'icelake'
        or exsl:ctx('PMU') = 'snowridge'
        or exsl:ctx('PMU') = 'icelake_server'
        or exsl:ctx('PMU') = 'elkhartlake'
        or exsl:ctx('PMU') = 'tigerlake'
        or exsl:ctx('PMU') = 'sapphirerapids'
        )">
        <xsl:value-of select="exsl:error('%ThisAnalysisTypeIsNotApplicable')"/>
      </xsl:if>
    </pmu_prerequisites>
  </root>
 </xsl:template>
</xsl:stylesheet>
