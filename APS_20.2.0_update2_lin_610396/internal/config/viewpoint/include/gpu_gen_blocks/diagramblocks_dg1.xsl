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
  <xsl:param name="mod"/>
  <xsl:template match="/">
    <diagram>
      <xsl:attribute name="id">DG1<xsl:value-of select="$mod"/>
      </xsl:attribute>
      <graph>
        <node id = "gpu">
          <node id="slice">
            <node id="ss">
              <node id = "euArray"/>
              <node id = "sampler">
                <node id="l1"/>
                <node id="l2"/>
              </node>
              <node id = "slm"/>
            </node>
            <node id="l3"/>
          </node>
          <node id="gti"/>
        </node>
          <node id="pcie"/>
        <node id="uncore">
          <node id="llc"/>
        </node>
        <node id="system">
          <node id="dram"/>
        </node>
        <node id = "cpu">
          <node id="cpuCores"/>
        </node>
        <link id="euArray_slm" from="euArray" to="slm" direction="both"/>
        <link id="sampler_l3" from="sampler" to="l3" direction="back"/>
        <link id="euArray_l3" from="euArray" to="l3" direction="both"/>
        <link id="euArray_sampler" from="euArray" to="sampler" direction="back"/>
        <link id="l3_gti" from="l3" to="gti" direction="both"/>
        <link id="gti_pcie" from="gti" to="pcie" direction="both"/>
        <link id="pcie_llc" from="pcie" to="llc" direction="both"/>
        <link id="cpu_llc" from="cpu" to="llc" direction="both"/>
        <link id="llc_dram" from="llc" to="dram" direction="both"/>
      </graph>
      <display>
        <node id="slice" displayName="%slice" color="#EAEAEA" textColor="#666666"/>
        <node id="ss" displayName="%sS" type="multiDevice" int:count="6" color="white" textColor="#666666"/>
        <node id="euArray" displayName="%euArray" type="multiDevice" int:count="16" color="#C7BFD1">
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
        <node id="cpu" displayName="%CPU" aligning="from" type="logicGroup" color="#EAEAEA">
        </node>
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
        <node id="pcie" displayName="%PCIe" color="#CDCDCD"/>
        <node id="gpu" displayName="%GPU" type="logicGroup"/>
        <node id="gti" displayName="%GTI" type="interface" color="#CDCDCD"/>
        <node id="uncore" displayName="%Uncore" type="logicGroup"/>
        <node id="system" displayName="%System" type="logicGroup"/>
        <node id="dram" displayName="%DRAMDGR" color="#edcdcb"/>
        <node id="llc" displayName="%LLC" color="#f9c499">
          <rowSet>
            <queryRef displayName="%MissRate">/GPULlcMissRate</queryRef>
            <queryRef displayName="%MissRatio">/GPULlcMissRatio</queryRef>
          </rowSet>
        </node>
        <link id="euArray_slm">
          <label location="from">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                    <queryRef>/GPUSharedLocalMemoryReadBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                    <queryRef>/GPUSharedLocalMemoryReadGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                    <queryRef>/GPUSLMReadAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
          <label location="to">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                    <queryRef>/GPUSharedLocalMemoryWriteBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                    <queryRef>/GPUSharedLocalMemoryWriteGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                    <queryRef>/GPUSLMWriteAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
        </link>
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
                  <queryRef displayName="%UntypedRead">/GPUUntypedMemoryReadBandwidth</queryRef>
                  <queryRef displayName="%TypedRead">/GPUTypedMemoryReadBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%UntypedRead">/GPUUntypedMemoryReadGB</queryRef>
                  <queryRef displayName="%TypedRead">/GPUTypedMemoryReadGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%UntypedRead">/GPUUntypedMemoryReadBDWAbsMaxRatio</queryRef>
                  <queryRef displayName="%TypedRead">/GPUTypedMemoryReadBDWAbsMaxRatio</queryRef>
                </rowSet>
              </ratio>
            </dataTransfer>
          </label>
          <label location="to">
            <dataTransfer>
              <bandwidth>
                <rowSet>
                  <queryRef displayName="%UntypedWrite">/GPUUntypedMemoryWriteBandwidth</queryRef>
                  <queryRef displayName="%TypedWrite">/GPUTypedMemoryWriteBandwidth</queryRef>
                </rowSet>
              </bandwidth>
              <size>
                <rowSet>
                  <queryRef displayName="%UntypedWrite">/GPUUntypedMemoryWriteGB</queryRef>
                  <queryRef displayName="%TypedWrite">/GPUTypedMemoryWriteGB</queryRef>
                </rowSet>
              </size>
              <ratio>
                <rowSet>
                  <queryRef displayName="%UntypedWrite">/GPUUntypedMemoryWriteBDWAbsMaxRatio</queryRef>
                  <queryRef displayName="%TypedWrite">/GPUTypedMemoryWriteBDWAbsMaxRatio</queryRef>
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
