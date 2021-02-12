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
                <queryRef>/FPUUtilizationGroup</queryRef>
                <queryRef>/SummaryFPUUtilization</queryRef>
            </vectorQuery>
            <derivedQuery id="FPUUtilizationGrid">
                <queryInherit>/FPUUtilization</queryInherit>
                <displayAttributes>
                    <boolean:expand>true</boolean:expand>
                    <boolean:allowCollapse>true</boolean:allowCollapse>
                </displayAttributes>
                <expand>
                    <vectorQuery id="FPUUtilizationGroupExpanded">
                        <derivedQuery displayName="%InstructionMix" id="InstructionMixGridSection">
                            <valueEval>""</valueEval>
                            <valueType>string</valueType>
                            <displayAttributes>
                                <boolean:expand>false</boolean:expand>
                                <boolean:allowCollapse>false</boolean:allowCollapse>
                            </displayAttributes>
                            <expand>
                                <vectorQuery id="InstructionMixGridGroup">
                                    <queryRef>/PackedFPRatio</queryRef>
                                    <queryRef>/ScalarFPRatio</queryRef>
                                </vectorQuery>
                            </expand>
                        </derivedQuery>
                        <queryRef>/InstrSet</queryRef>
                        <queryRef>/LoopType</queryRef>
                    </vectorQuery>
                </expand>
            </derivedQuery>
            <derivedQuery id="FPUUtilizationSummary">
                <queryInherit>/FPUUtilization</queryInherit>
                <displayAttributes>
                    <boolean:expand>false</boolean:expand>
                    <boolean:allowCollapse>true</boolean:allowCollapse>
                </displayAttributes>
                <expand>
                    <vectorQuery id="FPUUtilizationGroupExpanded">
                        <derivedQuery displayName="%InstructionMix" id="InstructionMixGridSection">
                            <valueEval>""</valueEval>
                            <valueType>string</valueType>
                            <displayAttributes>
                                <boolean:expand>false</boolean:expand>
                                <boolean:allowCollapse>false</boolean:allowCollapse>
                            </displayAttributes>
                            <expand>
                                <vectorQuery id="InstructionMixGridGroup">
                                    <queryRef>/PackedFPRatio</queryRef>
                                    <queryRef>/ScalarFPRatio</queryRef>
                                </vectorQuery>
                            </expand>
                        </derivedQuery>
                    </vectorQuery>
                </expand>
            </derivedQuery>
            <derivedQuery id="AdditionalIssueConditional">
                <valueEval>
                    <![CDATA[ ( ( query("/FPRatio") > 0 ) && ( query("/PMUHotspot") > 0.05 ) ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%FPUUtilization" id="FPUUtilization">
                <valueType>double</valueType>
                <helpKeyword>configs.fpuutilization_fpuutilizationdescriptionall</helpKeyword>
                <description>%FPUUtilizationDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/VPInstPerCycle") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="FPRatio">
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") ) / query("/INST_RETIRED") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery id="CLK">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%InstrSet" id="InstrSet">
                <valueType>string</valueType>
                <helpKeyword>configs.instrset_instrsetdescriptionall</helpKeyword>
                <description>%InstrSetDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PMUVectInstSet") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( query("/InstrSet") && !( ( query("/InstrSet") contains "AVX512F_512(512)" ) || ( query("/InstrSet") contains "FMA(512)" ) ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%OldInstructionSetIssueTextSIMD</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%LoopType" id="LoopType">
                <valueType>string</valueType>
                <helpKeyword>configs.looptype_looptypedescriptionall</helpKeyword>
                <description>%LoopTypeDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PMULoopCharacterization") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( query("/LoopType") && ( ( query("/LoopType") contains "peel" ) || ( query("/LoopType") contains "reminder" ) ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%OutOfBodyExecutionIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%SummaryFPUUtilization" id="SummaryFPUUtilization">
                <valueType>double</valueType>
                <helpKeyword>configs.summaryfpuutilization_summaryfpuutilizationdescriptionall</helpKeyword>
                <description>%SummaryFPUUtilizationDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/VPInstPerCycle") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="INST_RETIRED">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[INST_RETIRED.ANY]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%PackedFPRatioSIMD" id="PackedFPRatio">
                <valueType>ratio</valueType>
                <helpKeyword>configs.packedfpratio_packedfpratiodescriptionall</helpKeyword>
                <description>%PackedFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") / ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") ) ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="VPInstPerCycle">
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") ) / query("/CLK") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%ScalarFPRatioSIMD" id="ScalarFPRatio">
                <valueType>ratio</valueType>
                <helpKeyword>configs.scalarfpratio_scalarfpratiodescriptionall</helpKeyword>
                <description>%ScalarFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") / ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") ) ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedFPRatio")  != 0 ) && ( query("/ScalarFPRatio")  > 0.15 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%BigScalarIssueText</issueText>
                    </issue>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedFPRatio")  == 0 ) && ( query("/ScalarFPRatio")  != 0 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%OnlyScalarIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
        </queryLibrary>
    </xsl:template>
</xsl:stylesheet>
