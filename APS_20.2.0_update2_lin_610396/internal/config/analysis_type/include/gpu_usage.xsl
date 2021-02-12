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
  <xsl:template match="/">
   <root>
    <variables>
      <xsl:variable name="gpuUsageErrorMessageWin">
          <xsl:if test="exsl:ctx('targetOS', '')='Windows'">
        <xsl:choose>
          <xsl:when test="exsl:ctx('isGpuBusynessAvailable', 'no')='yes'"/>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exsl:ctx('isGpuBusynessAvailable', 'no')='notAccessible'"><xsl:value-of select="string('%GpuDXAccessDenied')"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="string('%GpuDXUnknownError')"/></xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:if>
      </xsl:variable>
          <xsl:variable name="gpuBusinessOk">
        <xsl:if test="exsl:ctx('targetOS', '')!='Windows'">
            <xsl:variable name="gpuBusynessStatus">
              <xsl:choose>
                <xsl:when test="(contains(exsl:ctx('isGpuBusynessAvailable', ''), 'unsupportedHardware'))">%UnsupportedGFX</xsl:when>
                <xsl:when test="(contains(exsl:ctx('isGpuBusynessAvailable', ''), 'notAccessible'))">
                  <xsl:choose>
                    <xsl:when test="exsl:ctx('targetOS', '')='MacOSX'">%IGFXDtraceEventsNotAvailable</xsl:when>
                    <xsl:when test="(exsl:ctx('targetOS', '')='Linux' or exsl:ctx('targetOS', '')='Android') and (contains(exsl:ctx('isFtraceAvailable', ''), 'yes'))">
                      <xsl:choose>
                        <xsl:when test="(contains(exsl:ctx('isGpuBusynessAvailable', ''), 'i915TracepointsConfigOff')) or (contains(exsl:ctx('isGpuBusynessAvailable', ''), 'KernelConfigNotFound'))">
                          <xsl:variable name="minMajorVersion" select="number(4)"/>
                          <xsl:variable name="minMinorVersion" select="number(14)"/>
                          <xsl:variable name="minPatchVersion" select="number(0)"/>
                          <xsl:variable name="kernelVersion" select="string(exsl:ctx('LinuxRelease', ''))"/>
                          <xsl:if test="$kernelVersion">
                            <xsl:variable name="currentKernelVersions" select="str:tokenize($kernelVersion, '.-')"/>
                            <xsl:choose>
                              <xsl:when test="(number($currentKernelVersions[1]) &gt; $minMajorVersion) or ((number($currentKernelVersions[1]) = $minMajorVersion) and (number($currentKernelVersions[2]) &gt; $minMinorVersion)) or ((number($currentKernelVersions[1]) = $minMajorVersion) and (number($currentKernelVersions[2]) = $minMinorVersion) and not (number($currentKernelVersions[3]) &lt; $minPatchVersion))">%IGFXTracepointsConfigOff</xsl:when>
                              <xsl:otherwise>%IGFXFtraceNotAvailableLinux</xsl:otherwise>
                            </xsl:choose>
                          </xsl:if>
                        </xsl:when>
                        <xsl:otherwise>%IGFXFtraceNotAvailableLinux</xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>notErrorOrWarning</xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
                <xsl:when test="(contains(exsl:ctx('isGpuBusynessAvailable', ''), 'i915ForciblyLoadedSystemAllow'))">%IGFXDriverForciblyLoadedSystemAllow</xsl:when>
                <xsl:when test="(contains(exsl:ctx('isGpuBusynessAvailable', ''), 'i915ForciblyLoadedSystemDeny'))">%IGFXDriverForciblyLoadedSystemDeny</xsl:when>
                <xsl:when test="(contains(exsl:ctx('isGpuBusynessAvailable', ''), 'i915ForciblyLoaded'))">%IGFXDriverForciblyLoaded</xsl:when>
                <xsl:otherwise>yes</xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="$gpuBusynessStatus != 'yes'">
                <xsl:choose>
                  <xsl:when test="$gpuBusynessStatus = 'notErrorOrWarning'"></xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="$gpuBusynessStatus"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:when>
            <xsl:otherwise>yes</xsl:otherwise>
          </xsl:choose>
          </xsl:if>
          </xsl:variable>
          <xsl:variable name="gpuFtraceOk">
        <xsl:if test="exsl:ctx('targetOS', '')!='Windows'">
            <xsl:if test="exsl:ctx('targetOS', '')='Linux' or exsl:ctx('targetOS', '')='Android'">
              <xsl:for-each select="str:tokenize(exsl:ctx('isFtraceAvailable',''), ',')">
                <xsl:variable name="gpuFtraceStatus">
                  <xsl:choose>
                    <xsl:when test=".='debugfsNotExists'">%IGFXDebugFSExistenceError</xsl:when>
                    <xsl:when test=".='debugfsNotAccessible'">%IGFXDebugFSAccessError</xsl:when>
                    <xsl:when test=".='debugfsOffInConfigs'">%IGFXDebugFSConfigError</xsl:when>
                    <xsl:when test=".='debugfsIsNotValidFsType'">%IGFXDebugFSInvalidTypeError</xsl:when>
                    <xsl:when test=".='ftraceAccessError'">
                      <xsl:choose>
                        <xsl:when test="not(contains(exsl:ctx('isFtraceAvailable',''), 'debugfs'))">%IGFXFtraceAccessError</xsl:when>
                        <xsl:otherwise>notErrorOrWarning</xsl:otherwise>
                      </xsl:choose>
                    </xsl:when>
                    <xsl:when test=".='ftraceConfigError'">%IGFXFtraceConfigError</xsl:when>
                    <xsl:when test=".='ftraceUnknownError'">%IGFXFtraceUnknownError</xsl:when>
                    <xsl:when test=".='yes'">yes</xsl:when>
                    <xsl:otherwise>yes</xsl:otherwise>
                  </xsl:choose>
                </xsl:variable>
                <xsl:choose>
                  <xsl:when test="$gpuFtraceStatus != 'yes'">
                    <xsl:choose>
                      <xsl:when test="$gpuFtraceStatus = 'notErrorOrWarning'"></xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="$gpuFtraceStatus"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>yes</xsl:otherwise>
                </xsl:choose>
              </xsl:for-each>
            </xsl:if>
           </xsl:if>
          </xsl:variable>
        <xsl:variable name="gpuUsageErrorMessageLin">
          <xsl:choose>
            <xsl:when test="$gpuBusinessOk != 'yes' and $gpuBusinessOk != ''">
            <xsl:value-of select="string($gpuBusinessOk)"/>
            </xsl:when>
            <xsl:when test="$gpuFtraceOk != 'yes' and exsl:ctx('targetOS', '')!='MacOSX'">
            <xsl:value-of select="string($gpuFtraceOk)"/>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
        </xsl:variable>
        <xsl:variable name="gpuUsageAvail">
          <xsl:choose>
            <xsl:when test="exsl:ctx('targetOS', '')='Windows'">
              <xsl:value-of select="exsl:ctx('isGpuBusynessAvailable', 'no')='yes'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$gpuBusinessOk = 'yes' and ($gpuFtraceOk = 'yes' or exsl:ctx('targetOS', '')='MacOSX')"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <gpuUsageAvailable>
          <xsl:value-of select="$gpuUsageAvail"/>
        </gpuUsageAvailable>
        <gpuUsageErrorMessage>
          <xsl:choose>
            <xsl:when test="exsl:ctx('targetOS', '')='Windows'">
              <xsl:value-of select="$gpuUsageErrorMessageWin"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$gpuUsageErrorMessageLin"/>
            </xsl:otherwise>
          </xsl:choose>
        </gpuUsageErrorMessage>
    </variables>
   </root>
  </xsl:template>
</xsl:stylesheet>
