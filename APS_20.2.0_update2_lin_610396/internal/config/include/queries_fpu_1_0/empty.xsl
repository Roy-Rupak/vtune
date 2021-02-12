<?xml version='1.0' encoding='utf-8'?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet exclude-result-prefixes="msxsl" syntax="norules" version="1.0" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:exsl="http://exslt.org/common" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output indent="yes" method="xml" />
    <xsl:template match="/">
        <queryLibrary>
            <vectorQuery id="FPUMetrics">
                <queryRef>/FPUUtilizationGroup</queryRef>
                <queryRef>/GFLOPS</queryRef>
            </vectorQuery>
            <derivedQuery id="FPUUtilizationSummary">
                <queryInherit>/FPUUtilization</queryInherit>
                <displayAttributes>
                    <boolean:expand>false</boolean:expand>
                    <boolean:allowCollapse>true</boolean:allowCollapse>
                </displayAttributes>
                <expand>
                    <vectorQuery id="FPUUtilizationGroupExpanded" />
                </expand>
            </derivedQuery>
            <derivedQuery displayName="%GFLOPS" id="GFLOPS">
                <valueType>string</valueType>
                <helpKeyword>configs.gflops_gflopsdescriptionall</helpKeyword>
                <description>%GFLOPSDescriptionAll</description>
                <valueEval>
                    <xsl:text>"</xsl:text>
                    <xsl:copy-of select="exsl:message('viewpoint', '%NotSupported')" />
                    <xsl:text>"</xsl:text>
                </valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%FPUUtilization" id="FPUUtilization">
                <valueType>string</valueType>
                <helpKeyword>configs.fpuutilization_fpuutilizationdescriptionall</helpKeyword>
                <description>%FPUUtilizationDescriptionAll</description>
                <valueEval>
                    <xsl:text>"</xsl:text>
                    <xsl:copy-of select="exsl:message('viewpoint', '%NotSupported')" />
                    <xsl:text>"</xsl:text>
                </valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
        </queryLibrary>
    </xsl:template>
</xsl:stylesheet>
