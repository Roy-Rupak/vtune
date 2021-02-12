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
                xmlns:int="http://www.w3.org/2001/XMLSchema#int"
                exsl:keep_exsl_namespace=""
                syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="arch"/>
  <xsl:param name="mod"/>
  <xsl:param name="sCount"/>
  <xsl:param name="ssCount"/>
  <xsl:param name="euCount"/>
  <xsl:variable name="archName">
    <xsl:choose>
      <xsl:when test="$arch"><xsl:value-of select="$arch"/></xsl:when>
      <xsl:otherwise>GEN9</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:template match="/">
    <diagram>
      <xsl:attribute name="id"><xsl:value-of select="$archName"/><xsl:if test="$sCount and $ssCount and $euCount"><xsl:value-of select="$sCount"/>x<xsl:value-of select="$ssCount"/>x<xsl:value-of select="$euCount"/><xsl:value-of select="$mod"/></xsl:if>
      </xsl:attribute>
      <graph>
        <node id="uncore">
          <node id="llc"/>
          <xsl:if test="$mod='EDRAM'">
            <node id="edram"/>
          </xsl:if>
        </node>
        <node id = "gpu">
          <node id="slice">
        <node id="ss">
          <node id = "euArray"/>
          <node id = "sampler">
            <node id="l1"/>
            <node id="l2"/>
          </node>
        </node>
          <node id="l3">
                <node id="slm"/>
              </node>
          </node>
          <node id="gti"/>
        </node>
        <node id="system">
          <node id="dram"/>
        </node>
        <node id = "cpu">
          <node id="cpuCores"/>
        </node>
        <link id="sampler_l3" from="sampler" to="l3" direction="back"/>
        <link id="euArray_l3" from="euArray" to="l3" direction="both"/>
        <link id="euArray_sampler" from="euArray" to="sampler" direction="back"/>
        <link id="l3_gti" from="l3" to="gti" direction="both"/>
        <link id="gti_llc" from="gti" to="llc" direction="both"/>
        <link id="cpu_llc" from="cpu" to="llc" direction="both"/>
        <xsl:if test="$mod='EDRAM'">
          <link id="edram_llc" from="edram" to="llc" direction="both"/>
        </xsl:if>
        <link id="llc_dram" from="llc" to="dram" direction="both"/>
      </graph>
      <display>
        <node id="slice" displayName="%slice" color="#EAEAEA" textColor="#666666">
          <xsl:if test="$sCount and not($sCount='1')">
            <xsl:attribute name="type">multiDevice</xsl:attribute>
          <xsl:attribute name="int:count">
            <xsl:value-of select="$sCount"/>
          </xsl:attribute>
          </xsl:if>
        </node>
        <node id="ss" displayName="%sS" type="multiDevice" color="white" textColor="#666666">
          <xsl:attribute name="int:count">
            <xsl:value-of select="$ssCount"/>
          </xsl:attribute>
        </node>
        <node id="euArray" displayName="%euArray" type="multiDevice" color="#C7BFD1">
          <xsl:attribute name="int:count">
            <xsl:value-of select="$euCount"/>
          </xsl:attribute>
          <rowSet>
            <queryRef displayName="%Active">/GPUEUActive</queryRef>
            <queryRef displayName="%Stalled">/GPUEUStalled</queryRef>
            <queryRef displayName="%Idle">/GPUEUIdle</queryRef>
            <queryRef displayName="%ThreadIssued">/GPUCSThreadIssuedCount</queryRef>
            <queryRef displayName="%ThreadOccupancy">/GPUEuThreadOccupancy</queryRef>
          </rowSet>
        </node>
        <node id="cpuCores" displayName="%CPUCores" type="multiDevice" color="#C7BFD1">
          <rowSet>
            <queryRef displayName="%Utilization">/GlobalCPUUtilization</queryRef>
          </rowSet>
        </node>
        <node id="cpu" displayName="%CPU" aligning="from" type="logicGroup" color="#EAEAEA"/>
        <node id="sampler" displayName="%Sampler" color="#C3D1A5">
          <rowSet>
            <queryRef displayName="%Busy">/GPUSamplerBusy</queryRef>
            <queryRef displayName="%Bottleneck">/GPUSamplerBottleneck</queryRef>
          </rowSet>
        </node>
        <node id="l1" displayName="%L1" color="#f9c499"/>
        <node id="l2" displayName="%L2" color="#f9c499"/>
        <node id="l3" displayName="%L3" color="#f9c499">
          <rowSet>
            <queryRef displayName="%MissRatio">/GPUL3MissRatio</queryRef>
          </rowSet>
        </node>
        <node id="slm" displayName="%SLM" color="#E3A471"/>
        <node id="gpu" displayName="%GPU" type="logicGroup"/>
        <node id="gti" displayName="%GTI" type="interface" color="#CDCDCD"/>
        <node id="uncore" displayName="%Uncore" type="logicGroup"/>
        <node id="system" displayName="%System" type="logicGroup"/>
        <node id="dram" displayName="%DRAMDGR" color="#edcdcb"/>
        <node id="edram" displayName="%EDRAMDGR" color="#edcdcb"/>
        <node id="llc" displayName="%LLC" color="#f9c499">
          <rowSet>
            <queryRef displayName="%MissRate">/GPULlcMissRate</queryRef>
            <queryRef displayName="%MissRatio">/GPULlcMissRatio</queryRef>
          </rowSet>
        </node>
        <link id="sampler_l3">
          <label location="center">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef displayName="%Total">/GPUL3SamplerBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%Total">/GPUL3SamplerThroughputGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%Total">/GPUL3SamplerBDWAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
        </link>
        <link id="euArray_l3" displayName="%Buffers">
          <label location="from">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef displayName="%Untyped">/GPUUntypedMemoryReadBandwidth</queryRef>
                  <queryRef displayName="%Typed">/GPUTypedMemoryReadBandwidth</queryRef>
                    <queryRef displayName="%SLM">/GPUSharedLocalMemoryReadBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%Untyped">/GPUUntypedMemoryReadGB</queryRef>
                  <queryRef displayName="%Typed">/GPUTypedMemoryReadGB</queryRef>
                    <queryRef displayName="%SLM">/GPUSharedLocalMemoryReadGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%Untyped">/GPUUntypedMemoryReadBDWAbsMaxRatio</queryRef>
                  <queryRef displayName="%Typed">/GPUTypedMemoryReadBDWAbsMaxRatio</queryRef>
                    <queryRef displayName="%SLM">/GPUSLMReadAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
          <label location="to">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef displayName="%Untyped">/GPUUntypedMemoryWriteBandwidth</queryRef>
                  <queryRef displayName="%Typed">/GPUTypedMemoryWriteBandwidth</queryRef>
                    <queryRef displayName="%SLM">/GPUSharedLocalMemoryWriteBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%Untyped">/GPUUntypedMemoryWriteGB</queryRef>
                  <queryRef displayName="%Typed">/GPUTypedMemoryWriteGB</queryRef>
                    <queryRef displayName="%SLM">/GPUSharedLocalMemoryWriteGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%Untyped">/GPUUntypedMemoryWriteBDWAbsMaxRatio</queryRef>
                  <queryRef displayName="%Typed">/GPUTypedMemoryWriteBDWAbsMaxRatio</queryRef>
                    <queryRef displayName="%SLM">/GPUSLMWriteAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
          <label location="center" displayName="%Total">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef displayName="%Total">/GPUL3ShaderBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%Total">/GPUL3ShaderThroughputGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%Total">/GPUL3ShaderBDWAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
        </link>
        <link id="l3_gti">
          <label location="center">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef displayName="%Total">/L3GTIBDWSlot</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%Total">/GTIL3Throughput</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%Total">/L3GTIBDWAbsMaxRatioSlot</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
        </link>
        <link id="gti_llc">
          <label location="from">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef>/GPUMemoryReadBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef>/GPUMemoryReadGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef>/GPUMemoryReadBDWAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
          <label location="to">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef>/GPUMemoryWriteBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef>/GPUMemoryWriteGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef>/GPUMemoryWriteBDWAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
        </link>
      </display>
    </diagram>
  </xsl:template>
</xsl:stylesheet>
