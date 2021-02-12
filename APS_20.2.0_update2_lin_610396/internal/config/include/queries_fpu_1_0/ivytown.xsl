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
                <queryRef>/VectorizationGroup</queryRef>
                <queryRef>/VectorizationGroup</queryRef>
                <queryRef>/GFLOPS</queryRef>
                <queryRef>/GSPFLOPS</queryRef>
                <queryRef>/GDPFLOPS</queryRef>
                <queryRef>/GX87FLOPS</queryRef>
                <queryRef>/GFLOPSPerProcessTime</queryRef>
                <queryRef>/FLOPSPerInstructionMultiIssue</queryRef>
                <queryRef>/FLOP</queryRef>
            </vectorQuery>
            <derivedQuery id="VectorizationGrid">
                <queryInherit>/Vectorization</queryInherit>
                <displayAttributes>
                    <boolean:expand>true</boolean:expand>
                    <boolean:allowCollapse>true</boolean:allowCollapse>
                </displayAttributes>
                <expand>
                    <vectorQuery id="VectorizationGroupExpanded">
                        <queryRef>/FPRatio</queryRef>
                        <queryRef>/PackedFPRatio</queryRef>
                        <queryRef>/ScalarFPRatio</queryRef>
                        <queryRef>/InstrSet</queryRef>
                        <queryRef>/FPInstrPerMemRead</queryRef>
                        <queryRef>/FPInstrPerMemWrite</queryRef>
                        <queryRef>/LoopType</queryRef>
                    </vectorQuery>
                </expand>
            </derivedQuery>
            <derivedQuery id="VectorizationSummary">
                <queryInherit>/Vectorization</queryInherit>
                <displayAttributes>
                    <boolean:expand>false</boolean:expand>
                    <boolean:allowCollapse>true</boolean:allowCollapse>
                </displayAttributes>
                <expand>
                    <vectorQuery id="VectorizationGroupExpanded">
                        <derivedQuery displayName="%InstructionMix" id="InstructionMixGridSection">
                            <valueEval>""</valueEval>
                            <valueType>string</valueType>
                            <displayAttributes>
                                <boolean:expand>false</boolean:expand>
                                <boolean:allowCollapse>false</boolean:allowCollapse>
                            </displayAttributes>
                            <expand>
                                <vectorQuery id="InstructionMixGridGroup">
                                    <derivedQuery id="SPFLOPSOfTotalGroup">
                                        <queryInherit>/SPFLOPSOfTotal</queryInherit>
                                        <displayAttributes>
                                            <boolean:expand>false</boolean:expand>
                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                        </displayAttributes>
                                        <expand>
                                            <vectorQuery id="SPFLOPSOfTotalGroupExpanded">
                                                <derivedQuery id="PackedSPFPRatioGroup">
                                                    <queryInherit>/PackedSPFPRatio</queryInherit>
                                                    <displayAttributes>
                                                        <boolean:expand>false</boolean:expand>
                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                    </displayAttributes>
                                                    <expand>
                                                        <vectorQuery id="PackedSPFPRatioGroupExpanded">
                                                            <queryRef>/128PackedSPFPRatio</queryRef>
                                                            <queryRef>/256PackedSPFPRatio</queryRef>
                                                        </vectorQuery>
                                                    </expand>
                                                </derivedQuery>
                                                <queryRef>/ScalarSPFPRatio</queryRef>
                                            </vectorQuery>
                                        </expand>
                                    </derivedQuery>
                                    <derivedQuery id="DPFLOPSOfTotalGroup">
                                        <queryInherit>/DPFLOPSOfTotal</queryInherit>
                                        <displayAttributes>
                                            <boolean:expand>false</boolean:expand>
                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                        </displayAttributes>
                                        <expand>
                                            <vectorQuery id="DPFLOPSOfTotalGroupExpanded">
                                                <derivedQuery id="PackedDPFPRatioGroup">
                                                    <queryInherit>/PackedDPFPRatio</queryInherit>
                                                    <displayAttributes>
                                                        <boolean:expand>false</boolean:expand>
                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                    </displayAttributes>
                                                    <expand>
                                                        <vectorQuery id="PackedDPFPRatioGroupExpanded">
                                                            <queryRef>/128PackedDPFPRatio</queryRef>
                                                            <queryRef>/256PackedDPFPRatio</queryRef>
                                                        </vectorQuery>
                                                    </expand>
                                                </derivedQuery>
                                                <queryRef>/ScalarDPFPRatio</queryRef>
                                            </vectorQuery>
                                        </expand>
                                    </derivedQuery>
                                    <queryRef>/X87FLOPSOfTotal</queryRef>
                                    <queryRef>/NonFLOP</queryRef>
                                </vectorQuery>
                            </expand>
                        </derivedQuery>
                        <queryRef>/FPInstrPerMemRead</queryRef>
                        <queryRef>/FPInstrPerMemWrite</queryRef>
                    </vectorQuery>
                </expand>
            </derivedQuery>
            <derivedQuery displayName="%X87FLOPSOfTotal" id="X87FLOPSOfTotal">
                <unitOfMeasureQueryId>UOPSForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.x87flopsoftotal_x87flopsoftotaldescriptionall</helpKeyword>
                <description>%X87FLOPSOfTotalDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/X87FLOP_INSTR") / query("/TotalUOPS") ) ]]></valueEval>
                <maxEval>1.0</maxEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%GDPFLOPS" id="GDPFLOPS">
                <valueType>double</valueType>
                <helpKeyword>configs.gdpflops_gdpflopsdescriptionall</helpKeyword>
                <description>%GDPFLOPSDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/DPFLOP") / 1000000000 ) / query("/GlobalElapsedTime") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="SPFLOP_INSTR">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%PackedSPFPRatio" id="PackedSPFPRatio">
                <unitOfMeasureQueryId>SPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.packedspfpratio_packedspfpratiodescriptionall</helpKeyword>
                <description>%PackedSPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") ) / query("/SPFLOP_INSTR") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%256PackedSPFPRatio" id="256PackedSPFPRatio">
                <unitOfMeasureQueryId>SPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.256packedspfpratio_256packedspfpratiodescriptionall</helpKeyword>
                <description>%256PackedSPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") ) / query("/SPFLOP_INSTR") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="TotalUOPS">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") ) ]]></valueEval>
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
                            <![CDATA[ ( query("/InstrSet") && !( ( query("/InstrSet") contains "AVX" ) || ( query("/InstrSet") contains "FMA" ) ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%OldInstructionSetIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="FPArithInst">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.X87]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery id="ScalarFP">
                <valueType>double</valueType>
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.X87]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%PackedDPFPRatio" id="PackedDPFPRatio">
                <unitOfMeasureQueryId>DPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.packeddpfpratio_packeddpfpratiodescriptionall</helpKeyword>
                <description>%PackedDPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") ) / query("/DPFLOP_INSTR") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%FPInstrPerMemWrite" id="FPInstrPerMemWrite">
                <valueType>double</valueType>
                <helpKeyword>configs.fpinstrpermemwrite_fpinstrpermemwritedescriptionall</helpKeyword>
                <description>%FPInstrPerMemWriteDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/FPArithInst") / query("/PMUStores") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/FPInstrPerMemWrite") < 0.5 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%TheMetricValueTextUnalignedAccessFooterText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.X87]") >= 10 ) )  ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="AdditionalIssueConditional">
                <valueEval>
                    <![CDATA[ ( ( query("/FPRatio") > 0 ) && ( query("/PMUHotspot") > 0.05 ) ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery id="DPFLOP_INSTR">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%FLOPSPerInstructionMultiIssue" id="FLOPSPerInstructionMultiIssue">
                <valueType>ratio</valueType>
                <helpKeyword>configs.flopsperinstructionmultiissue_flopsperinstructionmultiissuedescriptionall</helpKeyword>
                <description>%FLOPSPerInstructionMultiIssueDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/FLOP") / query("/FPArithInst") ) / 8 ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedFPRatio")  != 0 ) && ( query("/FLOPSPerInstructionMultiIssue")  < 0.95 ) && ( query("/FP_Arith")  > 0.05 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%InsufficientVectorCapacityText</issueText>
                    </issue>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedFPRatio")  == 0 ) && ( query("/ScalarFPRatio")  != 0 ) && ( query("/FP_Arith")  > 0.05 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%FullScalarCodeIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%Vectorization" id="Vectorization">
                <unitOfMeasureQueryId>PackedFPOpsForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.vectorization_vectorizationdescriptionall</helpKeyword>
                <description>%VectorizationDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PackedFP") / ( query("/PackedFP") + query("/ScalarFP") ) ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/Vectorization")  < 0.7  ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%BigScalarCodeIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%FLOP" id="FLOP">
                <helpKeyword>configs.flop_flopdescriptionall</helpKeyword>
                <description>%FLOPDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") * 4 + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") * 4 + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") * 8 + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") * 8 + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") * 2 + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.X87]") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") >= 10 )  ) || ( ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") >= 10 )  ) ) || ( ( query("/PMUSampleCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") >= 10 )  ) ) || ( ( query("/PMUSampleCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") >= 10 )  ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") >= 10 ) ) || ( ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") >= 10 )  ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.X87]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%128PackedDPFPRatio" id="128PackedDPFPRatio">
                <unitOfMeasureQueryId>DPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.128packeddpfpratio_128packeddpfpratiodescriptionall</helpKeyword>
                <description>%128PackedDPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") ) / query("/DPFLOP_INSTR") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/128PackedDPFPRatio") > 0.05 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%NotFullVectorCapacityIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%ScalarSPFPRatio" id="ScalarSPFPRatio">
                <unitOfMeasureQueryId>SPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.scalarspfpratio_scalarspfpratiodescriptionall</helpKeyword>
                <description>%ScalarSPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") ) / query("/SPFLOP_INSTR") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedSPFPRatio")  == 0 ) && ( query("/ScalarSPFPRatio")  != 0 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%FullScalarCodeIssueText</issueText>
                    </issue>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedSPFPRatio")  != 0 ) && ( query("/ScalarSPFPRatio")  > 0.3 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%BigScalarCodeIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%GX87FLOPS" id="GX87FLOPS">
                <valueType>double</valueType>
                <helpKeyword>configs.gx87flops_gx87flopsdescriptionall</helpKeyword>
                <description>%GX87FLOPSDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/X87FLOP_INSTR") / 1000000000 ) / query("/GlobalElapsedTime") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%FPInstrPerMemRead" id="FPInstrPerMemRead">
                <valueType>double</valueType>
                <helpKeyword>configs.fpinstrpermemread_fpinstrpermemreaddescriptionall</helpKeyword>
                <description>%FPInstrPerMemReadDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/FPArithInst") / query("/PMULoads") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/FPInstrPerMemRead") < 0.5 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%TheMetricValueTextUnalignedAccessFooterText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_COMP_OPS_EXE.X87]") >= 10 ) )  ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%256PackedDPFPRatio" id="256PackedDPFPRatio">
                <unitOfMeasureQueryId>DPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.256packeddpfpratio_256packeddpfpratiodescriptionall</helpKeyword>
                <description>%256PackedDPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") ) / query("/DPFLOP_INSTR") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%GFLOPS" id="GFLOPS">
                <valueType>double</valueType>
                <helpKeyword>configs.gflops_gflopsdescriptionall</helpKeyword>
                <description>%GFLOPSDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/FLOP") / 1000000000 ) / query("/GlobalElapsedTime") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%ScalarDPFPRatio" id="ScalarDPFPRatio">
                <unitOfMeasureQueryId>DPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.scalardpfpratio_scalardpfpratiodescriptionall</helpKeyword>
                <description>%ScalarDPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") ) / query("/DPFLOP_INSTR") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedDPFPRatio")  == 0 ) && ( query("/ScalarDPFPRatio")  != 0 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%FullScalarCodeIssueText</issueText>
                    </issue>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedDPFPRatio")  != 0 ) && ( query("/ScalarDPFPRatio")  > 0.3 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%BigScalarCodeIssueText</issueText>
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
                            <![CDATA[ ( query("/LoopType") && ( ( query("/LoopType") contains "Peel" ) || ( query("/LoopType") contains "Reminder" ) ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%OutOfBodyExecutionIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="X87FLOP_INSTR">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.X87]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%GFLOPSPerProcessTime" id="GFLOPSPerProcessTime">
                <valueType>double</valueType>
                <helpKeyword>configs.gflopsperprocesstime_gflopsperprocesstimedescriptionall</helpKeyword>
                <description>%GFLOPSPerProcessTimeDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/FLOP") / 1000000000 ) / query("/ProcessElapsedTime") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%PackedFPRatio" id="PackedFPRatio">
                <valueType>ratio</valueType>
                <helpKeyword>configs.packedfpratio_packedfpratiodescriptionall</helpKeyword>
                <description>%PackedFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/PackedFP") / query("/FPArithInst") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%NonFLOP" id="NonFLOP">
                <unitOfMeasureQueryId>UOPSForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.nonflop_nonflopdescriptionall</helpKeyword>
                <description>%NonFLOPDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/TotalUOPS") - query("/SPFLOP_INSTR") - query("/DPFLOP_INSTR") - query("/X87FLOP_INSTR") ) / query("/TotalUOPS") ) ]]></valueEval>
                <minEval>0.0</minEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%GSPFLOPS" id="GSPFLOPS">
                <valueType>double</valueType>
                <helpKeyword>configs.gspflops_gspflopsdescriptionall</helpKeyword>
                <description>%GSPFLOPSDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/SPFLOP") / 1000000000 ) / query("/GlobalElapsedTime") ) ]]></valueEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%128PackedSPFPRatio" id="128PackedSPFPRatio">
                <unitOfMeasureQueryId>SPFPForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.128packedspfpratio_128packedspfpratiodescriptionall</helpKeyword>
                <description>%128PackedSPFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") ) / query("/SPFLOP_INSTR") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/128PackedSPFPRatio") > 0.05 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%NotFullVectorCapacityIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="SPFLOP">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") * 4 + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") * 8 + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery id="PackedFP">
                <valueType>double</valueType>
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%FPRatio" id="FPRatio">
                <valueType>ratio</valueType>
                <helpKeyword>configs.fpratio_fpratiodescriptionall</helpKeyword>
                <description>%FPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/FPArithInst") / query("/TotalUOPS") ) ]]></valueEval>
                <maxEval>1.0</maxEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%SPFLOPSOfTotal" id="SPFLOPSOfTotal">
                <unitOfMeasureQueryId>UOPSForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.spflopsoftotal_spflopsoftotaldescriptionall</helpKeyword>
                <description>%SPFLOPSOfTotalDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/SPFLOP_INSTR") / query("/TotalUOPS") ) ]]></valueEval>
                <maxEval>1.0</maxEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery displayName="%DPFLOPSOfTotal" id="DPFLOPSOfTotal">
                <unitOfMeasureQueryId>UOPSForUnits</unitOfMeasureQueryId>
                <valueType>ratio</valueType>
                <helpKeyword>configs.dpflopsoftotal_dpflopsoftotaldescriptionall</helpKeyword>
                <description>%DPFLOPSOfTotalDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/DPFLOP_INSTR") / query("/TotalUOPS") ) ]]></valueEval>
                <maxEval>1.0</maxEval>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
            <derivedQuery id="DPFLOP">
                <valueEval>
                    <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE]") * 2 + query("/PMUEventCount/PMUEventType[SIMD_FP_256.PACKED_DOUBLE]") * 4 + query("/PMUEventCount/PMUEventType[FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE]") ) ]]></valueEval>
            </derivedQuery>
            <derivedQuery displayName="%ScalarFPRatio" id="ScalarFPRatio">
                <valueType>ratio</valueType>
                <helpKeyword>configs.scalarfpratio_scalarfpratiodescriptionall</helpKeyword>
                <description>%ScalarFPRatioDescriptionAll</description>
                <valueEval>
                    <![CDATA[ ( query("/ScalarFP") / query("/FPArithInst") ) ]]></valueEval>
                <issues>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedFPRatio")  == 0 ) && ( query("/ScalarFPRatio")  != 0 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%FullScalarCodeIssueText</issueText>
                    </issue>
                    <issue>
                        <issueEval>
                            <![CDATA[ ( ( query("/PackedFPRatio")  != 0 ) && ( query("/ScalarFPRatio")  > 0.3 ) && query("/AdditionalIssueConditional")  ) ]]></issueEval>
                        <issueText>%BigScalarCodeIssueText</issueText>
                    </issue>
                </issues>
                <confidenceEval>
                    <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
            </derivedQuery>
        </queryLibrary>
    </xsl:template>
</xsl:stylesheet>
