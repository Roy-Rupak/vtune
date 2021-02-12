<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:exsl="http://exslt.org/common">
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="/">
    <html id="gpuDiagramPane" displayName="%gpuDiagramPane">
      <description>%gpuDiagramPaneDescription</description>
      <helpKeywordF1>configs.caller_f1048</helpKeywordF1>
      <icon file="client.dat#zip:images.xrc" image="tab_timeline"/>
      <additionalParams boolean:showInDiff="false"/>
      <application name="diagram"/>
      <filter handleList="selection"/>
      <config>
        <graphIds>
          <rowBy>
            <queryRef>/GPUPCIID</queryRef>
          </rowBy>
          <columnBy>
            <queryRef>/GPUDataCount</queryRef>
          </columnBy>
          <selectionColumnBy>
            <queryRef>/GPUDMAPacketCountNode</queryRef>
            <queryRef>/GPUComputeTaskCount</queryRef>
          </selectionColumnBy>
        </graphIds>
        <xsl:variable name="diagramBlocksFileNameGen9">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen9)"/>
        <xsl:variable name="diagramBlocksFileNameGen91x2x6">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?sCount=1&amp;ssCount=2&amp;euCount=6&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen91x2x6)"/>
        <xsl:variable name="diagramBlocksFileNameGen91x3x6">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?sCount=1&amp;ssCount=3&amp;euCount=6&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen91x3x6)"/>
        <xsl:variable name="diagramBlocksFileNameGen91x3x6eDram">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?sCount=1&amp;ssCount=3&amp;euCount=6&amp;mod=EDRAM&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen91x3x6eDram)"/>
        <xsl:variable name="diagramBlocksFileNameGen91x3x8">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?sCount=1&amp;ssCount=3&amp;euCount=8&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen91x3x8)"/>
        <xsl:variable name="diagramBlocksFileNameGen92x3x8eDram">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?sCount=2&amp;ssCount=3&amp;euCount=8&amp;mod=EDRAM</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen92x3x8eDram)"/>
        <xsl:variable name="diagramBlocksFileNameGen93x3x8eDram">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?sCount=3&amp;ssCount=3&amp;euCount=8&amp;mod=EDRAM</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen93x3x8eDram)"/>
        <xsl:variable name="diagramBlocksFileNameGen11">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=GEN11&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameGen11)"/>
        <xsl:variable name="diagramBlocksFileNameTGLLP">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_tgllp.xsl</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameTGLLP)"/>
        <xsl:variable name="diagramBlocksFileNameTGLLPSS1">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_tgllp.xsl?mod=SS1&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameTGLLPSS1)"/>
        <xsl:variable name="diagramBlocksFileNameTGLLPSS2">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_tgllp.xsl?mod=SS2&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameTGLLPSS2)"/>
        <xsl:variable name="diagramBlocksFileNameTGLLPSS3">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_tgllp.xsl?mod=SS3&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameTGLLPSS3)"/>
        <xsl:variable name="diagramBlocksFileNameTGLLPSS6">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_tgllp.xsl?mod=SS6&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameTGLLPSS6)"/>
        <xsl:variable name="diagramBlocksFileNamDG1">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_dg1.xsl</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNamDG1)"/>
        <xsl:variable name="diagramBlocksFileNameATS">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=ATS&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameATS)"/>
        <xsl:variable name="diagramBlocksFileNameDG2">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=DG2&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameDG2)"/>
        <xsl:variable name="diagramBlocksFileNameMTL">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=MTL&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameMTL)"/>
        <xsl:variable name="diagramBlocksFileNamePVC">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=PVC&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNamePVC)"/>
        <xsl:variable name="diagramBlocksFileNameADL">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=ADL&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameADL)"/>
        <xsl:variable name="diagramBlocksFileNameRKL">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=RKL&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameRKL)"/>
        <xsl:variable name="diagramBlocksFileNameADLS">
          <xsl:text>config://viewpoint/include/gpu_gen_blocks/diagramblocks_gen9.xsl?arch=ADLS&amp;</xsl:text>
        </xsl:variable>
        <xsl:copy-of select="document($diagramBlocksFileNameADLS)"/>
      </config>
    </html>
  </xsl:template>
</xsl:stylesheet>
