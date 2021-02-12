<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:exsl="http://exslt.org/common">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="family"/>
  <xsl:param name="gpu"/>
  <xsl:param name="queryMode">flatProfile</xsl:param>
  <xsl:template match="/">
    <srcAsm id="srcAsmPane" int:stateVersion="4">
      <asmWindow>
        <helpKeywordF1>configs.find_problem_asm_pane_f1041</helpKeywordF1>
        <gridRules>
          <gridRule>
            <configuration>
              <rowBy>
                <vectorQueryInsert>/AsmPaneRowBy</vectorQueryInsert>
              </rowBy>
              <columnBy>
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$family"/>
                  <xsl:text>SourceLine</xsl:text>
                </queryRef>
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$family"/>
                  <xsl:text>AssemblyContent</xsl:text>
                </queryRef>
                <vectorQueryInsert>/MyAsmColumns</vectorQueryInsert>
              </columnBy>
              <queryMode>
                <xsl:value-of select="$queryMode"/>
              </queryMode>
            </configuration>
          </gridRule>
          <xsl:if test="$gpu='true'">
            <gridRule>
              <condition>
                <groupings>
                  <queryId>GPUSourceComputeTask</queryId>
                  <queryId>GPUComputeTaskTypeGTPinData</queryId>
                  <queryId>GPUComputeTaskType</queryId>
                  <queryId>GPUFunction</queryId>
                  <queryId>GPUComputeTaskTypeGSimStalls</queryId>
                  <queryId>GPUSourceFunction</queryId>
				  <queryId>GSIMGenericFunction</queryId>
				  <queryId>GSIMGenericSourceFunction</queryId>
                </groupings>
              </condition>
              <configuration>
                <rowBy>
                  <vectorQueryInsert>/AsmPaneRowBy</vectorQueryInsert>
                </rowBy>
                <columnBy>
                  <xsl:choose>
                    <xsl:when test="exsl:IsNonEmptyTableExist('gsim_stall_data')">
                      <queryRef>/GSIMSourceLineFlat</queryRef>
                    </xsl:when>
                    <xsl:when test="exsl:IsNonEmptyTableExist('gpu_gtpin_data')">
                      <queryRef>/GPUSourceLineFlat</queryRef>
                    </xsl:when>
                    <xsl:otherwise>
                      <queryRef>/GPUHWSourceLineFlat</queryRef>
                    </xsl:otherwise>
                  </xsl:choose>
                  <queryRef>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$family"/>
                    <xsl:text>AssemblyContent</xsl:text>
                  </queryRef>
                  <vectorQueryInsert>/MyAsmColumns</vectorQueryInsert>
                </columnBy>
              </configuration>
            </gridRule>
          </xsl:if>
        </gridRules>
      </asmWindow>
      <srcWindow>
        <helpKeywordF1>configs.find_problem_src_pane_f1040</helpKeywordF1>
        <gridRules>
          <gridRule>
            <configuration>
              <rowBy>
                <queryRef>/SourceLineFlat</queryRef>
              </rowBy>
              <columnBy>
                <queryRef>
                  <xsl:text>/</xsl:text>
                  <xsl:value-of select="$family"/>
                  <xsl:text>SourceContent</xsl:text>
                </queryRef>
                <vectorQueryInsert>/MySrcColumns</vectorQueryInsert>
              </columnBy>
              <queryMode>
                <xsl:value-of select="$queryMode"/>
              </queryMode>
            </configuration>
          </gridRule>
          <xsl:if test="$gpu='true'">
            <gridRule>
              <condition>
                <groupings>
                  <queryId>GPUSourceComputeTask</queryId>
                  <queryId>GPUComputeTaskTypeGTPinData</queryId>
                  <queryId>GPUComputeTaskType</queryId>
                  <queryId>GPUFunction</queryId>
                  <queryId>GPUComputeTaskTypeGSimStalls</queryId>
                  <queryId>GPUSourceFunction</queryId>
				  <queryId>GSIMGenericFunction</queryId>
				  <queryId>GSIMGenericSourceFunction</queryId>
                </groupings>
              </condition>
              <configuration>
                <rowBy>
                  <xsl:choose>
                    <xsl:when test="exsl:IsNonEmptyTableExist('gsim_stall_data') and exsl:IsNonEmptyTableExist('gpu_gtpin_data')">
                      <vectorQuery id="GSIMGPUSourceLineFlat">
                        <queryRef>/GSIMSourceLineFlat</queryRef>
                        <queryRef>/GPUSourceLineFlat</queryRef>
                      </vectorQuery>
                    </xsl:when>
                    <xsl:when test="exsl:IsNonEmptyTableExist('gsim_stall_data')">
                      <queryRef>/GSIMSourceLineFlat</queryRef>
                    </xsl:when>
                    <xsl:when test="exsl:IsNonEmptyTableExist('gpu_gtpin_data')">
                      <queryRef>/GPUSourceLineFlat</queryRef>
                    </xsl:when>
                    <xsl:otherwise>
                      <queryRef>/GPUHWSourceLineFlat</queryRef>
                    </xsl:otherwise>
                  </xsl:choose>
                </rowBy>
                <columnBy>
                  <queryRef>/gSimStallEventCount/gSimStallEventType</queryRef>
                  <queryRef>
                    <xsl:text>/</xsl:text>
                    <xsl:value-of select="$family"/>
                    <xsl:text>SourceContent</xsl:text>
                  </queryRef>
                  <vectorQueryInsert>/MySrcColumns</vectorQueryInsert>
                </columnBy>
                <queryMode>bottomUp</queryMode>
              </configuration>
            </gridRule>
          </xsl:if>
        </gridRules>
      </srcWindow>
      <fileSearchWindow>
        <helpKeywordF1>configs.find_file_type_f1072</helpKeywordF1>
      </fileSearchWindow>
      <doiBy>
        <queryRef>/DataOfInterest</queryRef>
      </doiBy>
    </srcAsm>
  </xsl:template>
</xsl:stylesheet>
