<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  xmlns:str="http://exslt.org/strings"
  syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="/">
    <common>
      <FpgaBlueStreamEvents>
        <xsl:text/>
      </FpgaBlueStreamEvents>
      <uncacheableReadsEventNameOnly>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server'">
            <xsl:text>MEM_LOAD_MISC_RETIRED.UC_PS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </uncacheableReadsEventNameOnly>
      <xsl:variable name='uncacheableReadsEvent'>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server'">
            <xsl:text>MEM_LOAD_MISC_RETIRED.UC_PS:sa=1009,</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <PCIeBandwidthEvents>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS') = 'QNX'">
            <xsl:text></xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snbep' or exsl:ctx('PMU') = 'ivytown'">
            <xsl:text>UNC_C_TOR_INSERTS.OPCODE:opc=0x19e,UNC_C_TOR_INSERTS.OPCODE:opc=0x194,UNC_C_TOR_INSERTS.OPCODE:opc=0x19c</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell_server'">
            <xsl:text>UNC_C_TOR_INSERTS.OPCODE:opc=0x19e,UNC_C_TOR_INSERTS.OPCODE:opc=0x180:tid=0x3e,UNC_C_TOR_INSERTS.OPCODE:opc=0x1c8:tid=0x3e,UNC_C_TOR_INSERTS.OPCODE:opc=0x187,UNC_C_TOR_INSERTS.OPCODE:opc=0x18F</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server'">
            <xsl:variable name='eventList'>
              <xsl:for-each select="str:tokenize('0,1,2,3', ',')">
                <xsl:value-of select="concat('UNC_IIO_DATA_REQ_OF_CPU.MEM_READ.PART', ., ',')"/>
                <xsl:value-of select="concat('UNC_IIO_DATA_REQ_OF_CPU.MEM_WRITE.PART', ., ',')"/>
                <xsl:value-of select="concat('UNC_IIO_DATA_REQ_BY_CPU.MEM_READ.PART', ., ',')"/>
                <xsl:value-of select="concat('UNC_IIO_DATA_REQ_BY_CPU.MEM_WRITE.PART', ., ',')"/>
              </xsl:for-each>
            </xsl:variable>
            <xsl:choose>
              <xsl:when test="exsl:ctx('restrictPCIeBandwidthByClass', 'None') != 'None' and exsl:ctx('pciClassParts','') != ''">
                <xsl:variable name="filters" select="document(concat('config://include/utils.xsl?classId=', exsl:ctx('restrictPCIeBandwidthByClass',''), '&amp;classToPartMap=', exsl:ctx('pciClassParts',''), '&amp;eventsList=', $eventList))"/>
                <xsl:value-of select="$filters//variables/chooseEventsByClass"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$eventList"/>
                <xsl:if test="exsl:ctx('isSEPDriverAvailable', 0)">
                  <xsl:text>UNC_CHA_TOR_INSERTS.IO_MISS:filter1=0x10049033:tid=0x1f0,UNC_CHA_TOR_INSERTS.IO_MISS:filter1=0x43C33:tid=0x1f0,UNC_CHA_TOR_INSERTS.IO_MISS:filter1=0x10049033:tid=0x1f8,UNC_CHA_TOR_INSERTS.IO_MISS:filter1=0x43C33:tid=0x1f8,UNC_CHA_TOR_INSERTS.IO_MISS:filter1=0x10049033:tid=0x1d8,UNC_CHA_TOR_INSERTS.IO_MISS:filter1=0x43C33:tid=0x1d8,UNC_I_COHERENT_OPS.PCITOM,UNC_I_COHERENT_OPS.RFO,UNC_I_FAF_INSERTS,</xsl:text>
                </xsl:if>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="$uncacheableReadsEvent"/>
      </PCIeBandwidthEvents>
    </common>
  </xsl:template>
</xsl:stylesheet>
