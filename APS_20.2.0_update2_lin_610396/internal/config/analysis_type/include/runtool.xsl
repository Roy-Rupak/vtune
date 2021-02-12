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
    <variables>
      <xsl:variable name="isRunssApplicable" select="exsl:ctx('targetType', '') != 'system' and
                                                     exsl:ctx('connectionType', '') != 'sniper' and
                                                     (exsl:ctx('isTPSSAvailable', 0) or exsl:ctx('isPtraceAvailable', 0)) and
                                                     not(exsl:ctx('isPtraceScopeLimited', 0))"/>
      <isRunssApplicable>
        <xsl:value-of select="$isRunssApplicable"/>
      </isRunssApplicable>
      <runtoolToUse>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='Linux' and (contains(exsl:ctx('Hypervisor', ''), 'KVM') or contains(exsl:ctx('Hypervisor', ''), 'xen') or contains(exsl:ctx('Hypervisor', ''), 'VMware'))">runsa</xsl:when>
          <xsl:when test="exsl:ctx('PMU', '') = '' or exsl:ctx('PMU', '') = 'Unknown'">
            <xsl:choose>
              <xsl:when test="$isRunssApplicable">runss</xsl:when>
              <xsl:otherwise>runsa</xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exsl:ctx('targetOS')='Windows' and not(exsl:ctx('AdministratorPrivileges', 'false'))">runss</xsl:when>
              <xsl:when test="(exsl:ctx('enableStackCollect', 0) and not(exsl:ctx('isVTSSPPDriverAvailable', 0))) or
                              (not(exsl:ctx('enableStackCollect', 0)) and not(exsl:ctx('isSEPDriverAvailable', 0)))">
                <xsl:choose>
                  <xsl:when test="(exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='NotAvailable'
                                  and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='User'
                                  and contains(exsl:ctx('LinuxPerfCapabilities', ''), 'format') and exsl:ctx('gpuCountersCollection', 'none')!='full-compute')">
                    <xsl:choose>
                      <xsl:when test="(exsl:ctx('ringBuffer', 0) > 0) or (exsl:ctx('targetRingBuffer', 0) > 0)">
                        <xsl:choose>
                          <xsl:when test="$isRunssApplicable">runss</xsl:when>
                          <xsl:otherwise>runsa</xsl:otherwise>
                        </xsl:choose>
                      </xsl:when>
                      <xsl:otherwise>runsa</xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:choose>
                      <xsl:when test="$isRunssApplicable">runss</xsl:when>
                      <xsl:otherwise>runsa</xsl:otherwise>
                    </xsl:choose>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>runsa</xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </runtoolToUse>
    </variables>
  </xsl:template>
</xsl:stylesheet>
