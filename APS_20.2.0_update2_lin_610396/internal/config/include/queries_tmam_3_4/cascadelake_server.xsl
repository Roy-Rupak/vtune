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
        <bag>
            <vectorQuery id="GETopDown" xmlns:blob="http://www.intel.com/2009/BagSchema#blob" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:byte="http://www.w3.org/2001/XMLSchema#byte" xmlns:double="http://www.w3.org/2001/XMLSchema#double" xmlns:float="http://www.w3.org/2001/XMLSchema#float" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:long="http://www.w3.org/2001/XMLSchema#long" xmlns:null="http://www.intel.com/2009/BagSchema#null" xmlns:short="http://www.w3.org/2001/XMLSchema#short" xmlns:unsignedByte="http://www.w3.org/2001/XMLSchema#unsignedByte" xmlns:unsignedInt="http://www.w3.org/2001/XMLSchema#unsignedInt" xmlns:unsignedLong="http://www.w3.org/2001/XMLSchema#unsignedLong" xmlns:unsignedShort="http://www.w3.org/2001/XMLSchema#unsignedShort">
                <derivedQuery id="RetiredPipelineSlotsGroup">
                    <queryInherit>/RetiredPipelineSlots</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="RetiredPipelineSlotsGroupExpanded">
                            <derivedQuery id="BASEGroup">
                                <queryInherit>/BASE</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="BASEGroupExpanded">
                                        <derivedQuery id="FP_ArithGroup">
                                            <queryInherit>/FP_Arith</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="FP_ArithGroupExpanded">
                                                    <queryRef>/FP_x87</queryRef>
                                                    <queryRef>/FP_Scalar</queryRef>
                                                    <queryRef>/FP_Vector</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <queryRef>/OTHER</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="MicroSequencerGroup">
                                <queryInherit>/MicroSequencer</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="MicroSequencerGroupExpanded">
                                        <queryRef>/Assists</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery id="FrontendBoundPipelineSlotsGroup">
                    <queryInherit>/FrontendBoundPipelineSlots</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="FrontendBoundPipelineSlotsGroupExpanded">
                            <derivedQuery id="FELatencyGroup">
                                <queryInherit>/FELatency</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="FELatencyGroupExpanded">
                                        <queryRef>/ICacheMisses</queryRef>
                                        <queryRef>/ITLBOverhead</queryRef>
                                        <derivedQuery id="BranchResteersGroup">
                                            <queryInherit>/BranchResteers</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="BranchResteersGroupExpanded">
                                                    <queryRef>/Mispredicts_Resteers</queryRef>
                                                    <queryRef>/Clears_Resteers</queryRef>
                                                    <queryRef>/Unknown_Branches</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <queryRef>/DSBtoMITESwitchCost</queryRef>
                                        <queryRef>/LCP</queryRef>
                                        <queryRef>/MSSwitches</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="FEBandwidthGroup">
                                <queryInherit>/FEBandwidth</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="FEBandwidthGroupExpanded">
                                        <queryRef>/FEBandwidthMITE</queryRef>
                                        <queryRef>/FEBandwidthDSB</queryRef>
                                        <queryRef>/FEBandwidthLSD</queryRef>
                                        <queryRef>/DSB_Coverage</queryRef>
                                        <queryRef>/LSD_Coverage</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery id="CancelledPipelineSlotsGroup">
                    <queryInherit>/CancelledPipelineSlots</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="CancelledPipelineSlotsGroupExpanded">
                            <queryRef>/BranchMispredict</queryRef>
                            <queryRef>/MachineClears</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery id="BackendBoundGroup">
                    <queryInherit>/BackendBound</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="BackendBoundGroupExpanded">
                            <derivedQuery id="MemBoundGroup">
                                <queryInherit>/MemBound</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="MemBoundGroupExpanded">
                                        <derivedQuery id="L1BoundGroup">
                                            <queryInherit>/L1Bound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="L1BoundGroupExpanded">
                                                    <queryRef>/DTLBOverhead</queryRef>
                                                    <queryRef>/LoadsBlockedbyStoreForwarding</queryRef>
                                                    <queryRef>/LockLatency</queryRef>
                                                    <queryRef>/SplitLoads</queryRef>
                                                    <queryRef>/4KAliasing</queryRef>
                                                    <queryRef>/FBFull</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <queryRef>/L2Bound</queryRef>
                                        <derivedQuery id="L3BoundGroup">
                                            <queryInherit>/L3Bound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="L3BoundGroupExpanded">
                                                    <queryRef>/ContestedAccesses</queryRef>
                                                    <queryRef>/DataSharing</queryRef>
                                                    <queryRef>/L3Latency</queryRef>
                                                    <queryRef>/SQFull</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery id="DRAMBoundGroup">
                                            <queryInherit>/DRAMBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="DRAMBoundGroupExpanded">
                                                    <queryRef>/MEMBandwidth</queryRef>
                                                    <derivedQuery id="MEMLatencyGroup">
                                                        <queryInherit>/MEMLatency</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="MEMLatencyGroupExpanded">
                                                                <queryRef>/LocalDRAM</queryRef>
                                                                <queryRef>/RemoteDRAM</queryRef>
                                                                <queryRef>/RemoteCache</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <xsl:if test="$is3DXOn">
                                            <derivedQuery id="IXP_BoundGroup">
                                                <queryInherit>/IXP_Bound</queryInherit>
                                                <displayAttributes>
                                                    <boolean:expand>false</boolean:expand>
                                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                                </displayAttributes>
                                                <expand>
                                                    <vectorQuery id="IXP_BoundGroupExpanded">
                                                        <xsl:if test="$is3DXOn">
                                                            <queryRef>/Local_PMM</queryRef>
                                                        </xsl:if>
                                                        <xsl:if test="$is3DXOn">
                                                            <queryRef>/Remote_PMM</queryRef>
                                                        </xsl:if>
                                                    </vectorQuery>
                                                </expand>
                                            </derivedQuery>
                                        </xsl:if>
                                        <derivedQuery id="StoresBoundGroup">
                                            <queryInherit>/StoresBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="StoresBoundGroupExpanded">
                                                    <queryRef>/StoreLatency</queryRef>
                                                    <queryRef>/FalseSharing</queryRef>
                                                    <queryRef>/SplitStores</queryRef>
                                                    <queryRef>/DTLBStoreOverhead</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="CoreBoundGroup">
                                <queryInherit>/CoreBound</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="CoreBoundGroupExpanded">
                                        <queryRef>/DIVActive</queryRef>
                                        <derivedQuery id="PortUtilGroup">
                                            <queryInherit>/PortUtil</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="PortUtilGroupExpanded">
                                                    <derivedQuery id="Cycles0PortsUtilizedGroup">
                                                        <queryInherit>/Cycles0PortsUtilized</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="Cycles0PortsUtilizedGroupExpanded">
                                                                <derivedQuery id="Serializing_OperationGroup">
                                                                    <queryInherit>/Serializing_Operation</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="Serializing_OperationGroupExpanded">
                                                                            <queryRef>/Slow_Pause</queryRef>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <queryRef>/Cycles1PortUtilized</queryRef>
                                                    <queryRef>/Cycles2PortsUtilized</queryRef>
                                                    <derivedQuery id="Cycles3mPortsUtilizedGroup">
                                                        <queryInherit>/Cycles3mPortsUtilized</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="Cycles3mPortsUtilizedGroupExpanded">
                                                                <queryRef>/Port0</queryRef>
                                                                <queryRef>/Port1</queryRef>
                                                                <queryRef>/Port2</queryRef>
                                                                <queryRef>/Port3</queryRef>
                                                                <queryRef>/Port4</queryRef>
                                                                <queryRef>/Port5</queryRef>
                                                                <queryRef>/Port6</queryRef>
                                                                <queryRef>/Port7</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <queryRef>/FLOPSPerInstructionMultiIssue</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <queryLibrary>
                <derivedQuery displayName="%RetiredPipelineSlots" id="RetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%RetiredPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BASE" id="BASE">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BASEDescriptionAll</description>
                    <helpKeyword>configs.base_basedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/RetiredPipelineSlots") - query("/MicroSequencer") ) ]]></valueEval>
                    <issueText>%BASEIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BASE") > 0.6 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MS_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_Arith" id="FP_Arith">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_ArithDescriptionAll</description>
                    <helpKeyword>configs.fp_arith_fp_arithdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/FP_x87") + query("/FP_Scalar") + query("/FP_Vector") ) ]]></valueEval>
                    <issueText>%FP_ArithIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FP_Arith") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BASE") > 0.6 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.X87]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) || ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_x87" id="FP_x87">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_x87DescriptionAll</description>
                    <helpKeyword>configs.fp_x87_fp_x87descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.X87]") / query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.THREAD]") ) ]]></valueEval>
                    <issueText>%FP_x87IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FP_x87") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FP_Arith") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/BASE") > 0.6 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.X87]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_Scalar" id="FP_Scalar">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_ScalarDescriptionAll</description>
                    <helpKeyword>configs.fp_scalar_fp_scalardescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") ) / query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") ) ]]></valueEval>
                    <issueText>%FP_ScalarIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FP_Scalar") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FP_Arith") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/BASE") > 0.6 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_Vector" id="FP_Vector">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_VectorDescriptionAll</description>
                    <helpKeyword>configs.fp_vector_fp_vectordescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") + query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") + query("/PMUEventCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") ) / query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") ) ]]></valueEval>
                    <issueText>%FP_VectorIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FP_Vector") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FP_Arith") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/BASE") > 0.6 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="OTHER">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>configs.other_otherdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 1 - query("/FP_Arith") ) ]]></valueEval>
                    <issueText>%OTHERIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/OTHER") > 0.3 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BASE") > 0.6 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.X87]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) || ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="MicroSequencer">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.microsequencer_microsequencerdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Retire_Uop_Fraction") * query("/PMUEventCount/PMUEventType[IDQ.MS_UOPS]") / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%MicroSequencerIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/MicroSequencer") > 0.05 ) || ( queryOptional("/MSSwitches") > 0.05) ) && ( ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MS_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="Assists">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_assistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Avg_Assist_Cost") * ( query("/PMUEventCount/PMUEventType[FP_ASSIST.ANY]") + query("/PMUEventCount/PMUEventType[OTHER_ASSISTS.ANY]") ) / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%AssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Assists") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/MicroSequencer") > 0.05 ) || ( queryOptional("/MSSwitches") > 0.05) && ( ( query("/RetiredPipelineSlots") > 0.75 ) || ( queryOptional("/MicroSequencer") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[FP_ASSIST.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[OTHER_ASSISTS.ANY]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="FrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FELatency" id="FELatency">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FELatencyDescriptionAll</description>
                    <helpKeyword>configs.felatency_felatencydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Pipeline_Width") * query("/PMUEventCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]") / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%FELatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="ICacheMisses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[ICACHE_16B.IFDATA_STALL]") + 2 * query("/PMUEventCount/PMUEventType[ICACHE_16B.IFDATA_STALL:cmask=1:e=yes]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ICacheMisses") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[ICACHE_16B.IFDATA_STALL]") >= 10 ) || (  ( query("/PMUSampleCount/PMUEventType[ICACHE_16B.IFDATA_STALL:cmask=1:e=yes]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[ICACHE_64B.IFTAG_STALL]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ITLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ICACHE_64B.IFTAG_STALL]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="BranchResteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branchresteers_branchresteersdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") + query("/BAClear_Cost") * query("/PMUEventCount/PMUEventType[BACLEARS.ANY]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BranchResteersIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BranchResteers") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) || (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ANY]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mispredicts_Resteers" id="Mispredicts_Resteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Mispredicts_ResteersDescriptionAll</description>
                    <helpKeyword>configs.mispredicts_resteers_mispredicts_resteersdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Mispred_Clears_Fraction") * query("/PMUEventCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%Mispredicts_ResteersIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Mispredicts_Resteers") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/Clears_Resteers") > 0.05) || ( queryOptional("/BranchMispredict") > 0.05) ) && ( ( ( query("/BranchResteers") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) ) ) || ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Clears_Resteers" id="Clears_Resteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Clears_ResteersDescriptionAll</description>
                    <helpKeyword>configs.clears_resteers_clears_resteersdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 1 - query("/Mispred_Clears_Fraction") ) * query("/PMUEventCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%Clears_ResteersIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Clears_Resteers") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/Mispredicts_Resteers") > 0.05) || ( queryOptional("/BranchMispredict") > 0.05) ) && ( ( ( query("/BranchResteers") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) ) ) ) || ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Unknown_Branches" id="Unknown_Branches">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Unknown_BranchesDescriptionAll</description>
                    <helpKeyword>configs.unknown_branches_unknown_branchesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/BranchResteers") - query("/PMUEventCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%Unknown_BranchesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Unknown_Branches") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BranchResteers") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) || (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ANY]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="DSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsbtomiteswitchcost_dsbtomiteswitchcostdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[DSB2MITE_SWITCHES.PENALTY_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DSBtoMITESwitchCostIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DSBtoMITESwitchCost") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[DSB2MITE_SWITCHES.PENALTY_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LCP" id="LCP">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LCPDescriptionAll</description>
                    <helpKeyword>configs.lcp_lcpdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[ILD_STALL.LCP]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LCPIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LCP") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ILD_STALL.LCP]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MSSwitches" id="MSSwitches">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSSwitchesDescriptionAll</description>
                    <helpKeyword>configs.msswitches_msswitchesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/MS_Switches_Cost") * query("/PMUEventCount/PMUEventType[IDQ.MS_SWITCHES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MSSwitchesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MSSwitches") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MicroSequencer") > 0.05) || ( queryOptional("/Serializing_Operation") > 0.1) ) && ( ( ( query("/FELatency") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[IDQ.MS_SWITCHES]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="FEBandwidth">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.febandwidth_febandwidthdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/FrontendBoundPipelineSlots") - query("/FELatency") ) ]]></valueEval>
                    <issueText>%FEBandwidthIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FEBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthMITE" id="FEBandwidthMITE">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FEBandwidthMITEDescriptionAll</description>
                    <helpKeyword>configs.febandwidthmite_febandwidthmitedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[IDQ.ALL_MITE_CYCLES_ANY_UOPS]") - query("/PMUEventCount/PMUEventType[IDQ.ALL_MITE_CYCLES_4_UOPS]") ) / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%FEBandwidthMITEIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FEBandwidthMITE") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FEBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.ALL_MITE_CYCLES_ANY_UOPS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[IDQ.ALL_MITE_CYCLES_4_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDSB" id="FEBandwidthDSB">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FEBandwidthDSBDescriptionAll</description>
                    <helpKeyword>configs.febandwidthdsb_febandwidthdsbdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[IDQ.ALL_DSB_CYCLES_ANY_UOPS]") - query("/PMUEventCount/PMUEventType[IDQ.ALL_DSB_CYCLES_4_UOPS]") ) / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%FEBandwidthDSBIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FEBandwidthDSB") > 0.3 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FEBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.ALL_DSB_CYCLES_ANY_UOPS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[IDQ.ALL_DSB_CYCLES_4_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthLSD" id="FEBandwidthLSD">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FEBandwidthLSDDescriptionAll</description>
                    <helpKeyword>configs.febandwidthlsd_febandwidthlsddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[LSD.CYCLES_ACTIVE]") - query("/PMUEventCount/PMUEventType[LSD.CYCLES_4_UOPS]") ) / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%FEBandwidthLSDIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FEBandwidthLSD") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FEBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[LSD.CYCLES_ACTIVE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[LSD.CYCLES_4_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DSB_Coverage" id="DSB_Coverage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%DSB_CoverageDescriptionAll</description>
                    <helpKeyword>configs.dsb_coverage_dsb_coveragedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[IDQ.DSB_UOPS]") / query("/Fetched_Uops") ) ]]></valueEval>
                    <issueText>%DSB_CoverageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/DSB_Coverage") < 0.7 ) ) && ( ( ( query("/FEBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.DSB_UOPS]") >= 10 ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.DSB_UOPS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[LSD.UOPS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MITE_UOPS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MS_UOPS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LSD_Coverage" id="LSD_Coverage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LSD_CoverageDescriptionAll</description>
                    <helpKeyword>configs.lsd_coverage_lsd_coveragedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[LSD.UOPS]") / query("/Fetched_Uops") ) ]]></valueEval>
                    <issueText>%LSD_CoverageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ) && ( ( ( query("/FEBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/FrontendBoundPipelineSlots") > 0.2 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[LSD.UOPS]") >= 10 ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.DSB_UOPS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[LSD.UOPS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MITE_UOPS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MS_UOPS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="CancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_ISSUED.ANY]") - query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") + query("/Pipeline_Width") * query("/Recovery_Cycles") ) / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%CancelledPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/CancelledPipelineSlots") > 0.1 ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Mispred_Clears_Fraction") * query("/CancelledPipelineSlots") ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BranchMispredict") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/Mispredicts_Resteers") > 0.05) || ( queryOptional("/Clears_Resteers") > 0.05) ) && ( ( query("/CancelledPipelineSlots") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="MachineClears">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machineclears_machineclearsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/CancelledPipelineSlots") - query("/BranchMispredict") ) ]]></valueEval>
                    <issueText>%MachineClearsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MachineClears") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/CancelledPipelineSlots") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="BackendBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 1 - ( query("/FrontendBoundPipelineSlots") + query("/CancelledPipelineSlots") + query("/RetiredPipelineSlots") ) ) ]]></valueEval>
                    <issueText>%BackendBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/BackendBound") > 0.1 ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="MemBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.membound_membounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Memory_Bound_Fraction") * query("/BackendBound") ) ]]></valueEval>
                    <issueText>%MemBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L1Bound" id="L1Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L1BoundDescriptionAll</description>
                    <helpKeyword>configs.l1bound_l1bounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") - query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%L1BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) ) && ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="DTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/Mem_STLB_Hit_Cost") * query("/PMUEventCount/PMUEventType[DTLB_LOAD_MISSES.STLB_HIT]") + query("/PMUEventCount/PMUEventType[DTLB_LOAD_MISSES.WALK_ACTIVE]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DTLBOverhead") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[DTLB_LOAD_MISSES.STLB_HIT]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[DTLB_LOAD_MISSES.WALK_ACTIVE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 13 * query("/PMUEventCount/PMUEventType[LD_BLOCKS.STORE_FORWARD]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LoadsBlockedbyStoreForwarding") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS.STORE_FORWARD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LockLatency" id="LockLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LockLatencyDescriptionAll</description>
                    <helpKeyword>configs.locklatency_locklatencydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Mem_Lock_St_Fraction") * query("/ORO_Demand_RFO_C1") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LockLatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LockLatency") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/StoreLatency") > 0.1) ) && ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) || ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Load_Miss_Real_Latency") * query("/PMUEventCount/PMUEventType[LD_BLOCKS.NO_SR]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitLoads") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.PENDING]") >= 10 ) && ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) )  ) ) || ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS.NO_SR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="4KAliasing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4kaliasing_4kaliasingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[LD_BLOCKS_PARTIAL.ADDRESS_ALIAS]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%4KAliasingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/4KAliasing") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS_PARTIAL.ADDRESS_ALIAS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FBFull" id="FBFull">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FBFullDescriptionAll</description>
                    <helpKeyword>configs.fbfull_fbfulldescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Load_Miss_Real_Latency") * query("/PMUEventCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%FBFullIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/FBFull") > 0.3 ) || ( queryOptional("/SQFull") > 0.3) || ( queryOptional("/MEMBandwidth") > 0.1) || ( queryOptional("/StoreLatency") > 0.1) ) && ( ( ( ( query("/L1Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) || ( queryOptional("/Cycles1PortUtilized") > 0.2) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.PENDING]") >= 10 ) && ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) )  ) ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L2Bound" id="L2Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L2BoundDescriptionAll</description>
                    <helpKeyword>configs.l2bound_l2bounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 1 if query("/FBFull") < 1.5 else query("/LOAD_L2_HIT") / ( query("/LOAD_L2_HIT") + query("/PMUEventCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") ) ) * query("/L2_Bound_Ratio") ) ]]></valueEval>
                    <issueText>%L2BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/L2Bound") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L3Bound" id="L3Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L3BoundDescriptionAll</description>
                    <helpKeyword>configs.l3bound_l3bounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") - query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%L3BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/L3Bound") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="ContestedAccesses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Mem_XSNP_HitM_Cost") * ( query("/LOAD_XSNP_HITM") + query("/LOAD_XSNP_MISS") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ContestedAccesses") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/FalseSharing") > 0.1) ) && ( ( ( query("/L3Bound") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="DataSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.datasharing_datasharingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/MEM_XSNP_Hit_Cost") * query("/LOAD_XSNP_HIT") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DataSharingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DataSharing") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/L3Bound") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L3Latency" id="L3Latency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L3LatencyDescriptionAll</description>
                    <helpKeyword>configs.l3latency_l3latencydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/MEM_XSNP_None_Cost") * query("/LOAD_L3_HIT") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%L3LatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/L3Latency") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MEMLatency") > 0.1) ) && ( ( ( query("/L3Bound") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SQFull" id="SQFull">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SQFullDescriptionAll</description>
                    <helpKeyword>configs.sqfull_sqfulldescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/SQ_Full_Cycles") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%SQFullIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SQFull") > 0.3 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/FBFull") > 0.3) || ( queryOptional("/MEMBandwidth") > 0.1) ) && ( ( ( query("/L3Bound") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") >= 10 )  ) ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DRAMBound" id="DRAMBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.drambound_drambounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/MEM_Bound_Ratio") - query("/IXP_Bound") ) if query("/IXP_App_Direct") else query("/MEM_Bound_Ratio") ) ]]></valueEval>
                    <issueText>%DRAMBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DRAMBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) || ( ( ( (  ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) && ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) || ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) if ( ( ( query("/OneMillion") * ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") ) + ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") ) ) ) > ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") ) ) ) else ( 0 ) ) ) ) if ( query("/IXP_App_Direct") ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MEMBandwidth" id="MEMBandwidth">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MEMBandwidthDescriptionAll</description>
                    <helpKeyword>configs.membandwidth_membandwidthdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/ORO_DRD_BW_Cycles") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MEMBandwidthIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MEMBandwidth") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/FBFull") > 0.3) || ( queryOptional("/SQFull") > 0.3) ) && ( ( ( query("/DRAMBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MEMLatency" id="MEMLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MEMLatencyDescriptionAll</description>
                    <helpKeyword>configs.memlatency_memlatencydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/ORO_DRD_Any_Cycles") / query("/DerivedClockticks") - query("/MEMBandwidth") ) ]]></valueEval>
                    <issueText>%MEMLatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MEMLatency") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/L3Latency") > 0.1) ) && ( ( ( query("/DRAMBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LocalDRAM" id="LocalDRAM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LocalDRAMDescriptionAll</description>
                    <helpKeyword>configs.localdram_localdramdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Mem_Local_DRAM_Cost") * query("/LOAD_LCL_MEM") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LocalDRAMIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LocalDRAM") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MEMLatency") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/L3Latency") > 0.1) && ( ( query("/DRAMBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%RemoteDRAM" id="RemoteDRAM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RemoteDRAMDescriptionAll</description>
                    <helpKeyword>configs.remotedram_remotedramdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Mem_Remote_DRAM_Cost") * query("/LOAD_RMT_MEM") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%RemoteDRAMIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/RemoteDRAM") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MEMLatency") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/L3Latency") > 0.1) && ( ( query("/DRAMBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%RemoteCache" id="RemoteCache">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RemoteCacheDescriptionAll</description>
                    <helpKeyword>configs.remotecache_remotecachedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/Mem_Remote_HitM_Cost") * query("/LOAD_RMT_HITM") + query("/Mem_Remote_Fwd_Cost") * query("/LOAD_RMT_FWD") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%RemoteCacheIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/RemoteCache") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MEMLatency") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/L3Latency") > 0.1) && ( ( query("/DRAMBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%IXP_Bound" id="IXP_Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%IXP_BoundDescriptionAll</description>
                    <helpKeyword>configs.ixp_bound_ixp_bounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMEM_Bound_AppDirect") ) ]]></valueEval>
                    <issueText>%IXP_BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/IXP_Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( (  ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) && ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) || ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) if ( ( ( query("/OneMillion") * ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") ) + ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") ) ) ) > ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") ) ) ) else ( 0 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Local_PMM" id="Local_PMM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Local_PMMDescriptionAll</description>
                    <helpKeyword>configs.local_pmm_local_pmmdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 4 * query("/Mem_Local_DRAM_Cost") * query("/LOAD_LCL_IXP") / query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%Local_PMMIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ) && ( ( ( query("/IXP_Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Remote_PMM" id="Remote_PMM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Remote_PMMDescriptionAll</description>
                    <helpKeyword>configs.remote_pmm_remote_pmmdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 3 * query("/Mem_Remote_DRAM_Cost") * query("/LOAD_RMT_IXP") / query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%Remote_PMMIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ) && ( ( ( query("/IXP_Bound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%StoresBound" id="StoresBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%StoresBoundDescriptionAll</description>
                    <helpKeyword>configs.storesbound_storesbounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%StoresBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/StoresBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%StoreLatency" id="StoreLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%StoreLatencyDescriptionAll</description>
                    <helpKeyword>configs.storelatency_storelatencydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/Store_L2_Hit_Cycles") + ( 1 - query("/Mem_Lock_St_Fraction") ) * query("/ORO_Demand_RFO_C1") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%StoreLatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/StoreLatency") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/LockLatency") > 0.2) || ( queryOptional("/FBFull") > 0.3) ) && ( ( ( query("/StoresBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[L2_RQSTS.RFO_HIT]") >= 10 )  ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) ) || ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FalseSharing" id="FalseSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FalseSharingDescriptionAll</description>
                    <helpKeyword>configs.falsesharing_falsesharingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/Mem_Remote_HitM_Cost") * query("/PMUEventCount/PMUEventType[OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_MISS.REMOTE_HITM]") + query("/Mem_XSNP_HitM_Cost") * query("/PMUEventCount/PMUEventType[OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.HITM_OTHER_CORE]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%FalseSharingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FalseSharing") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/ContestedAccesses") > 0.2) ) && ( ( ( query("/StoresBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_MISS.REMOTE_HITM]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE:request=DEMAND_RFO:response=L3_HIT.HITM_OTHER_CORE]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.SPLIT_STORES_PS]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitStores") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/Port4") > 0.6) ) && ( ( ( query("/StoresBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.SPLIT_STORES_PS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBStoreOverhead" id="DTLBStoreOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBStoreOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlbstoreoverhead_dtlbstoreoverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/Mem_STLB_Hit_Cost") * query("/PMUEventCount/PMUEventType[DTLB_STORE_MISSES.STLB_HIT]") + query("/PMUEventCount/PMUEventType[DTLB_STORE_MISSES.WALK_ACTIVE]") ) / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%DTLBStoreOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DTLBStoreOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/StoresBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/MemBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[DTLB_STORE_MISSES.STLB_HIT]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[DTLB_STORE_MISSES.WALK_ACTIVE]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="CoreBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.corebound_corebounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/BackendBound") - query("/MemBound") ) ]]></valueEval>
                    <issueText>%CoreBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DIVActive") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%PortUtil" id="PortUtil">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PortUtilDescriptionAll</description>
                    <helpKeyword>configs.portutil_portutildescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/Backend_Bound_Cycles") - query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") - query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") ) / query("/DerivedClockticks") if ( query("/PMUEventCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") < query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") ) else ( query("/Backend_Bound_Cycles") - query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") - query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") - query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%PortUtilIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) if ( ( ( query("/PMUSampleCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") ) < ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") ) ) ) else ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles0PortsUtilized" id="Cycles0PortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles0PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles0portsutilized_cycles0portsutilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Cycles_0_Ports_Utilized") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Cycles0PortsUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Cycles0PortsUtilized") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_NONE]") >= 10 ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Serializing_Operation" id="Serializing_Operation">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Serializing_OperationDescriptionAll</description>
                    <helpKeyword>configs.serializing_operation_serializing_operationdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PARTIAL_RAT_STALLS.SCOREBOARD]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%Serializing_OperationIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Serializing_Operation") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSSwitches") > 0.05) ) && ( ( ( query("/Cycles0PortsUtilized") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PARTIAL_RAT_STALLS.SCOREBOARD]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Slow_Pause" id="Slow_Pause">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Slow_PauseDescriptionAll</description>
                    <helpKeyword>configs.slow_pause_slow_pausedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 140 * query("/PMUEventCount/PMUEventType[ROB_MISC_EVENTS.PAUSE_INST]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%Slow_PauseIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Slow_Pause") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/Serializing_Operation") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSSwitches") > 0.05) && ( ( query("/Cycles0PortsUtilized") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[ROB_MISC_EVENTS.PAUSE_INST]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles1PortUtilized" id="Cycles1PortUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles1PortUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles1portutilized_cycles1portutilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Cycles_1_Port_Utilized") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Cycles1PortUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Cycles1PortUtilized") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/L1Bound") > 0.1) ) && ( ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_1]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") >= 10 ) ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles2PortsUtilized" id="Cycles2PortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles2PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles2portsutilized_cycles2portsutilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Cycles_2_Ports_Utilized") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Cycles2PortsUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Cycles2PortsUtilized") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles3mPortsUtilized" id="Cycles3mPortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles3mPortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles3mportsutilized_cycles3mportsutilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Cycles_3m_Ports_Utilized") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Cycles3mPortsUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port0" id="Port0">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port0DescriptionAll</description>
                    <helpKeyword>configs.port0_port0descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_0]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port0IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port0") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_0]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port1" id="Port1">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port1DescriptionAll</description>
                    <helpKeyword>configs.port1_port1descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_1]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port1IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port1") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_1]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port2" id="Port2">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port2DescriptionAll</description>
                    <helpKeyword>configs.port2_port2descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_2]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port2IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port2") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_2]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port3" id="Port3">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port3DescriptionAll</description>
                    <helpKeyword>configs.port3_port3descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_3]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port3IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port3") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_3]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port4" id="Port4">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port4DescriptionAll</description>
                    <helpKeyword>configs.port4_port4descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_4]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port4IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port4") > 0.6 ) || ( queryOptional("/SplitStores") > 0.2) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_4]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port5" id="Port5">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port5DescriptionAll</description>
                    <helpKeyword>configs.port5_port5descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_5]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port5IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port5") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_5]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port6" id="Port6">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port6DescriptionAll</description>
                    <helpKeyword>configs.port6_port6descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_6]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port6IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port6") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_6]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Port7" id="Port7">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port7DescriptionAll</description>
                    <helpKeyword>configs.port7_port7descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_7]") / query("/CORE_CLKS") ) ]]></valueEval>
                    <issueText>%Port7IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Port7") > 0.6 ) ) && ( ( ( query("/Cycles3mPortsUtilized") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/PortUtil") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( ( query("/CoreBound") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) && ( query("/BackendBound") > 0.1 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_7]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SLOTS" id="SLOTS">
                    <description>%SLOTSDescriptionAll</description>
                    <helpKeyword>configs.slots_slotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Pipeline_Width") * query("/CORE_CLKS") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CORE_CLKS" id="CORE_CLKS">
                    <description>%CORE_CLKSDescriptionAll</description>
                    <helpKeyword>configs.core_clks_core_clksdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( ( query("/DerivedClockticks") / 2 ) * ( 1 + query("/PMUEventCount/PMUEventType[CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE]") / query("/PMUEventCount/PMUEventType[CPU_CLK_UNHALTED.REF_XCLK]") ) ) if query("/SMT_on") else query("/DerivedClockticks") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 )  ) || (  ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.REF_XCLK]") >= 10 ) ) ) ) ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Load_Miss_Real_Latency" id="Load_Miss_Real_Latency">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Load_Miss_Real_LatencyDescriptionAll</description>
                    <helpKeyword>configs.load_miss_real_latency_load_miss_real_latencydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[L1D_PEND_MISS.PENDING]") / ( query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") + 1 ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.PENDING]") >= 10 ) && ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) )  ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Fetched_Uops" id="Fetched_Uops">
                    <description>%Fetched_UopsDescriptionAll</description>
                    <helpKeyword>configs.fetched_uops_fetched_uopsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[IDQ.DSB_UOPS]") + query("/PMUEventCount/PMUEventType[LSD.UOPS]") + query("/PMUEventCount/PMUEventType[IDQ.MITE_UOPS]") + query("/PMUEventCount/PMUEventType[IDQ.MS_UOPS]") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.DSB_UOPS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[LSD.UOPS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MITE_UOPS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[IDQ.MS_UOPS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Recovery_Cycles" id="Recovery_Cycles">
                    <description>%Recovery_CyclesDescriptionAll</description>
                    <helpKeyword>configs.recovery_cycles_recovery_cyclesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SQ_Full_Cycles" id="SQ_Full_Cycles">
                    <description>%SQ_Full_CyclesDescriptionAll</description>
                    <helpKeyword>configs.sq_full_cycles_sq_full_cyclesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") / 2 ) if query("/SMT_on") else query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") >= 10 )  ) ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_0_Ports_Utilized" id="Cycles_0_Ports_Utilized">
                    <description>%Cycles_0_Ports_UtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_0_ports_utilized_cycles_0_ports_utilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_NONE]") / 2 if query("/SMT_on") else query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_NONE]") >= 10 ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_1_Port_Utilized" id="Cycles_1_Port_Utilized">
                    <description>%Cycles_1_Port_UtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_1_port_utilized_cycles_1_port_utilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_1]") - query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") ) / 2 if query("/SMT_on") else query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_1]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") >= 10 ) ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_2_Ports_Utilized" id="Cycles_2_Ports_Utilized">
                    <description>%Cycles_2_Ports_UtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_2_ports_utilized_cycles_2_ports_utilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") - query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") ) / 2 if query("/SMT_on") else query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_3m_Ports_Utilized" id="Cycles_3m_Ports_Utilized">
                    <description>%Cycles_3m_Ports_UtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_3m_ports_utilized_cycles_3m_ports_utilizeddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") / 2 if query("/SMT_on") else query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_Any_Cycles" id="ORO_DRD_Any_Cycles">
                    <description>%ORO_DRD_Any_CyclesDescriptionAll</description>
                    <helpKeyword>configs.oro_drd_any_cycles_oro_drd_any_cyclesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/DerivedClockticks") < query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ? query("/DerivedClockticks") : query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_BW_Cycles" id="ORO_DRD_BW_Cycles">
                    <description>%ORO_DRD_BW_CyclesDescriptionAll</description>
                    <helpKeyword>configs.oro_drd_bw_cycles_oro_drd_bw_cyclesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/DerivedClockticks") < query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ? query("/DerivedClockticks") : query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ORO_Demand_RFO_C1" id="ORO_Demand_RFO_C1">
                    <description>%ORO_Demand_RFO_C1DescriptionAll</description>
                    <helpKeyword>configs.oro_demand_rfo_c1_oro_demand_rfo_c1descriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/DerivedClockticks") < query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ? query("/DerivedClockticks") : query("/PMUEventCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Store_L2_Hit_Cycles" id="Store_L2_Hit_Cycles">
                    <description>%Store_L2_Hit_CyclesDescriptionAll</description>
                    <helpKeyword>configs.store_l2_hit_cycles_store_l2_hit_cyclesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[L2_RQSTS.RFO_HIT]") * query("/Mem_L2_Store_Cost") * ( 1 - query("/Mem_Lock_St_Fraction") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[L2_RQSTS.RFO_HIT]") >= 10 )  ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L1_MISS" id="LOAD_L1_MISS">
                    <description>%LOAD_L1_MISSDescriptionAll</description>
                    <helpKeyword>configs.load_l1_miss_load_l1_missdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") + 1 ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L1_MISS_NET" id="LOAD_L1_MISS_NET">
                    <description>%LOAD_L1_MISS_NETDescriptionAll</description>
                    <helpKeyword>configs.load_l1_miss_net_load_l1_miss_netdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/LOAD_L1_MISS") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L2_HIT" id="LOAD_L2_HIT">
                    <description>%LOAD_L2_HITDescriptionAll</description>
                    <helpKeyword>configs.load_l2_hit_load_l2_hitdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) + 1 ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L3_HIT" id="LOAD_L3_HIT">
                    <description>%LOAD_L3_HITDescriptionAll</description>
                    <helpKeyword>configs.load_l3_hit_load_l3_hitdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) + 1 ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HIT" id="LOAD_XSNP_HIT">
                    <description>%LOAD_XSNP_HITDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_hit_load_xsnp_hitdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HITM" id="LOAD_XSNP_HITM">
                    <description>%LOAD_XSNP_HITMDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_hitm_load_xsnp_hitmdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_MISS" id="LOAD_XSNP_MISS">
                    <description>%LOAD_XSNP_MISSDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_miss_load_xsnp_missdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_MEM" id="LOAD_LCL_MEM">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_LCL_MEMDescriptionAll</description>
                    <helpKeyword>configs.load_lcl_mem_load_lcl_memdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LCL_PMM_COUNT" id="LCL_PMM_COUNT">
                    <description>%LCL_PMM_COUNTDescriptionAll</description>
                    <helpKeyword>configs.lcl_pmm_count_lcl_pmm_countdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%RMT_PMM_COUNT" id="RMT_PMM_COUNT">
                    <description>%RMT_PMM_COUNTDescriptionAll</description>
                    <helpKeyword>configs.rmt_pmm_count_rmt_pmm_countdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_IXP" id="LOAD_LCL_IXP">
                    <description>%LOAD_LCL_IXPDescriptionAll</description>
                    <helpKeyword>configs.load_lcl_ixp_load_lcl_ixpdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/LCL_PMM_COUNT") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_IXP" id="LOAD_RMT_IXP">
                    <description>%LOAD_RMT_IXPDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_ixp_load_rmt_ixpdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/RMT_PMM_COUNT") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_MEM" id="LOAD_RMT_MEM">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_RMT_MEMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_mem_load_rmt_memdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_HITM" id="LOAD_RMT_HITM">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_RMT_HITMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_hitm_load_rmt_hitmdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_FWD" id="LOAD_RMT_FWD">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_RMT_FWDDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_fwd_load_rmt_fwddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") * ( 1 + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") / query("/LOAD_L1_MISS_NET") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Few_Uops_Executed_Threshold" id="Few_Uops_Executed_Threshold">
                    <description>%Few_Uops_Executed_ThresholdDescriptionAll</description>
                    <helpKeyword>configs.few_uops_executed_threshold_few_uops_executed_thresholddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") if ( query("/IPC") > 1.8 ) else 0 ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Backend_Bound_Cycles" id="Backend_Bound_Cycles">
                    <description>%Backend_Bound_CyclesDescriptionAll</description>
                    <helpKeyword>configs.backend_bound_cycles_backend_bound_cyclesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") + query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") + query("/Few_Uops_Executed_Threshold") ) + ( query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") + query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Memory_Bound_Fraction" id="Memory_Bound_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Memory_Bound_FractionDescriptionAll</description>
                    <helpKeyword>configs.memory_bound_fraction_memory_bound_fractiondescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") + query("/PMUEventCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") ) / query("/Backend_Bound_Cycles") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L2_Bound_Ratio" id="L2_Bound_Ratio">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%L2_Bound_RatioDescriptionAll</description>
                    <helpKeyword>configs.l2_bound_ratio_l2_bound_ratiodescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") - query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MEM_Bound_Ratio" id="MEM_Bound_Ratio">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_Bound_RatioDescriptionAll</description>
                    <helpKeyword>configs.mem_bound_ratio_mem_bound_ratiodescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") / query("/DerivedClockticks") + query("/L2_Bound_Ratio") - query("/L2Bound") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_DDR_Hit_Fraction" id="Mem_DDR_Hit_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_DDR_Hit_FractionDescriptionAll</description>
                    <helpKeyword>configs.mem_ddr_hit_fraction_mem_ddr_hit_fractiondescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 19 * query("/LOAD_RMT_MEM") + 10 * ( query("/LOAD_LCL_MEM") + query("/LOAD_RMT_FWD") + query("/LOAD_RMT_HITM") ) ) / ( ( 19 * query("/LOAD_RMT_MEM") + 10 * ( query("/LOAD_LCL_MEM") + query("/LOAD_RMT_FWD") + query("/LOAD_RMT_HITM") ) ) + ( 25 * query("/LOAD_LCL_IXP") + 33 * query("/LOAD_RMT_IXP") ) ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) && ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) || ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Lock_St_Fraction" id="Mem_Lock_St_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Lock_St_FractionDescriptionAll</description>
                    <helpKeyword>configs.mem_lock_st_fraction_mem_lock_st_fractiondescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") / query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%PMEM_Bound_AppDirect" id="PMEM_Bound_AppDirect">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%PMEM_Bound_AppDirectDescriptionAll</description>
                    <helpKeyword>configs.pmem_bound_appdirect_pmem_bound_appdirectdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( ( ( 1 - query("/Mem_DDR_Hit_Fraction") ) * query("/MEM_Bound_Ratio") ) if ( query("/OneMillion") * ( query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") + query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") ) > query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") ) else 0 ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( (  ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) && ( ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) || ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) ) ) ) ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L3_MISS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( 1 ) if ( ( query("/FBFull") < 1.5 ) ) else ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) && ( ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS]") >= 10 ) )  ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD]") >= 10 ) ) ) ) )  ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) ) ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L1D_MISS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_L2_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) if ( ( ( query("/OneMillion") * ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS]") ) + ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.LOCAL_PMM_PS]") ) ) ) > ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") ) ) ) else ( 0 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mispred_Clears_Fraction" id="Mispred_Clears_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mispred_Clears_FractionDescriptionAll</description>
                    <helpKeyword>configs.mispred_clears_fraction_mispred_clears_fractiondescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") / ( query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") + query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.COUNT]") ) ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Retire_Uop_Fraction" id="Retire_Uop_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Retire_Uop_FractionDescriptionAll</description>
                    <helpKeyword>configs.retire_uop_fraction_retire_uop_fractiondescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") / query("/PMUEventCount/PMUEventType[UOPS_ISSUED.ANY]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Pipeline_Width" id="Pipeline_Width">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Pipeline_WidthDescriptionAll</description>
                    <helpKeyword>configs.pipeline_width_pipeline_widthdescriptionall</helpKeyword>
                    <valueEval>4</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_L2_Store_Cost" id="Mem_L2_Store_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_L2_Store_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_l2_store_cost_mem_l2_store_costdescriptionall</helpKeyword>
                    <valueEval>11</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_STLB_Hit_Cost" id="Mem_STLB_Hit_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_STLB_Hit_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_stlb_hit_cost_mem_stlb_hit_costdescriptionall</helpKeyword>
                    <valueEval>9</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_XSNP_HitM_Cost" id="Mem_XSNP_HitM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_XSNP_HitM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_hitm_cost_mem_xsnp_hitm_costdescriptionall</helpKeyword>
                    <valueEval>60</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_Hit_Cost" id="MEM_XSNP_Hit_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_XSNP_Hit_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_hit_cost_mem_xsnp_hit_costdescriptionall</helpKeyword>
                    <valueEval>43</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_None_Cost" id="MEM_XSNP_None_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_XSNP_None_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_none_cost_mem_xsnp_none_costdescriptionall</helpKeyword>
                    <valueEval>41</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Local_DRAM_Cost" id="Mem_Local_DRAM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Local_DRAM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_local_dram_cost_mem_local_dram_costdescriptionall</helpKeyword>
                    <valueEval>200</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_DRAM_Cost" id="Mem_Remote_DRAM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_DRAM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_dram_cost_mem_remote_dram_costdescriptionall</helpKeyword>
                    <valueEval>310</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_HitM_Cost" id="Mem_Remote_HitM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_HitM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_hitm_cost_mem_remote_hitm_costdescriptionall</helpKeyword>
                    <valueEval>200</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_Fwd_Cost" id="Mem_Remote_Fwd_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_Fwd_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_fwd_cost_mem_remote_fwd_costdescriptionall</helpKeyword>
                    <valueEval>180</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BAClear_Cost" id="BAClear_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%BAClear_CostDescriptionAll</description>
                    <helpKeyword>configs.baclear_cost_baclear_costdescriptionall</helpKeyword>
                    <valueEval>9</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MS_Switches_Cost" id="MS_Switches_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MS_Switches_CostDescriptionAll</description>
                    <helpKeyword>configs.ms_switches_cost_ms_switches_costdescriptionall</helpKeyword>
                    <valueEval>2</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Avg_Assist_Cost" id="Avg_Assist_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Avg_Assist_CostDescriptionAll</description>
                    <helpKeyword>configs.avg_assist_cost_avg_assist_costdescriptionall</helpKeyword>
                    <valueEval>100</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%OneMillion" id="OneMillion">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%OneMillionDescriptionAll</description>
                    <helpKeyword>configs.onemillion_onemilliondescriptionall</helpKeyword>
                    <valueEval>1000000</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SMT_on" id="SMT_on">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%SMT_onDescriptionAll</description>
                    <helpKeyword>configs.smt_on_smt_ondescriptionall</helpKeyword>
                    <valueEval>$isHTEnabled</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( 1 ) if ( ( knob.nthreads >= 2 ) ) else ( 0 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%IXP_App_Direct" id="IXP_App_Direct">
                    <xsl:choose>
                        <xsl:when test="$is3DXOn">
                            <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                            <description>%IXP_App_DirectDescriptionAll</description>
                            <helpKeyword>configs.ixp_app_direct_ixp_app_directdescriptionall</helpKeyword>
                            <valueEval>1</valueEval>
                            <confidenceEval>
                                <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                        </xsl:when>
                        <xsl:otherwise>
                            <valueEval>0</valueEval>
                            <queryInherit>/GeMetricNA</queryInherit>
                        </xsl:otherwise>
                    </xsl:choose>
                </derivedQuery>
            </queryLibrary>
            <vectorQuery id="locatorGETopDown" xmlns:blob="http://www.intel.com/2009/BagSchema#blob" xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean" xmlns:byte="http://www.w3.org/2001/XMLSchema#byte" xmlns:double="http://www.w3.org/2001/XMLSchema#double" xmlns:float="http://www.w3.org/2001/XMLSchema#float" xmlns:int="http://www.w3.org/2001/XMLSchema#int" xmlns:long="http://www.w3.org/2001/XMLSchema#long" xmlns:null="http://www.intel.com/2009/BagSchema#null" xmlns:short="http://www.w3.org/2001/XMLSchema#short" xmlns:unsignedByte="http://www.w3.org/2001/XMLSchema#unsignedByte" xmlns:unsignedInt="http://www.w3.org/2001/XMLSchema#unsignedInt" xmlns:unsignedLong="http://www.w3.org/2001/XMLSchema#unsignedLong" xmlns:unsignedShort="http://www.w3.org/2001/XMLSchema#unsignedShort">
                <derivedQuery displayName="Locators" id="LocatorsGridSection">
                    <valueEval>0</valueEval>
                    <valueType>double</valueType>
                    <displayAttributes>
                        <boolean:expand>true</boolean:expand>
                        <boolean:allowCollapse>false</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="LocatorsGridGroup">
                            <derivedQuery id="locatorRetiredPipelineSlotsGroup">
                                <queryInherit>/locatorRetiredPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorRetiredPipelineSlotsGroupExpanded">
                                        <derivedQuery id="locatorBASEGroup">
                                            <queryInherit>/locatorBASE</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorBASEGroupExpanded">
                                                    <derivedQuery id="locatorFP_ArithGroup">
                                                        <queryInherit>/locatorFP_Arith</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorFP_ArithGroupExpanded">
                                                                <queryRef>/locatorFP_x87</queryRef>
                                                                <queryRef>/locatorFP_Scalar</queryRef>
                                                                <queryRef>/locatorFP_Vector</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <queryRef>/locatorOTHER</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery id="locatorMicroSequencerGroup">
                                            <queryInherit>/locatorMicroSequencer</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorMicroSequencerGroupExpanded">
                                                    <queryRef>/locatorAssists</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="locatorFrontendBoundPipelineSlotsGroup">
                                <queryInherit>/locatorFrontendBoundPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorFrontendBoundPipelineSlotsGroupExpanded">
                                        <derivedQuery id="locatorFELatencyGroup">
                                            <queryInherit>/locatorFELatency</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorFELatencyGroupExpanded">
                                                    <queryRef>/locatorICacheMisses</queryRef>
                                                    <queryRef>/locatorITLBOverhead</queryRef>
                                                    <derivedQuery id="locatorBranchResteersGroup">
                                                        <queryInherit>/locatorBranchResteers</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorBranchResteersGroupExpanded">
                                                                <queryRef>/locatorMispredicts_Resteers</queryRef>
                                                                <queryRef>/locatorClears_Resteers</queryRef>
                                                                <queryRef>/locatorUnknown_Branches</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <queryRef>/locatorDSBtoMITESwitchCost</queryRef>
                                                    <queryRef>/locatorLCP</queryRef>
                                                    <queryRef>/locatorMSSwitches</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery id="locatorFEBandwidthGroup">
                                            <queryInherit>/locatorFEBandwidth</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorFEBandwidthGroupExpanded">
                                                    <queryRef>/locatorFEBandwidthMITE</queryRef>
                                                    <queryRef>/locatorFEBandwidthDSB</queryRef>
                                                    <queryRef>/locatorFEBandwidthLSD</queryRef>
                                                    <queryRef>/locatorDSB_Coverage</queryRef>
                                                    <queryRef>/locatorLSD_Coverage</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="locatorCancelledPipelineSlotsGroup">
                                <queryInherit>/locatorCancelledPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorCancelledPipelineSlotsGroupExpanded">
                                        <queryRef>/locatorBranchMispredict</queryRef>
                                        <queryRef>/locatorMachineClears</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="locatorBackendBoundGroup">
                                <queryInherit>/locatorBackendBound</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorBackendBoundGroupExpanded">
                                        <derivedQuery id="locatorMemBoundGroup">
                                            <queryInherit>/locatorMemBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorMemBoundGroupExpanded">
                                                    <derivedQuery id="locatorL1BoundGroup">
                                                        <queryInherit>/locatorL1Bound</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorL1BoundGroupExpanded">
                                                                <queryRef>/locatorDTLBOverhead</queryRef>
                                                                <queryRef>/locatorLoadsBlockedbyStoreForwarding</queryRef>
                                                                <queryRef>/locatorLockLatency</queryRef>
                                                                <queryRef>/locatorSplitLoads</queryRef>
                                                                <queryRef>/locator4KAliasing</queryRef>
                                                                <queryRef>/locatorFBFull</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <queryRef>/locatorL2Bound</queryRef>
                                                    <derivedQuery id="locatorL3BoundGroup">
                                                        <queryInherit>/locatorL3Bound</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorL3BoundGroupExpanded">
                                                                <queryRef>/locatorContestedAccesses</queryRef>
                                                                <queryRef>/locatorDataSharing</queryRef>
                                                                <queryRef>/locatorL3Latency</queryRef>
                                                                <queryRef>/locatorSQFull</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <derivedQuery id="locatorDRAMBoundGroup">
                                                        <queryInherit>/locatorDRAMBound</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorDRAMBoundGroupExpanded">
                                                                <queryRef>/locatorMEMBandwidth</queryRef>
                                                                <derivedQuery id="locatorMEMLatencyGroup">
                                                                    <queryInherit>/locatorMEMLatency</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="locatorMEMLatencyGroupExpanded">
                                                                            <queryRef>/locatorLocalDRAM</queryRef>
                                                                            <queryRef>/locatorRemoteDRAM</queryRef>
                                                                            <queryRef>/locatorRemoteCache</queryRef>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <xsl:if test="$is3DXOn">
                                                        <derivedQuery id="locatorIXP_BoundGroup">
                                                            <queryInherit>/locatorIXP_Bound</queryInherit>
                                                            <displayAttributes>
                                                                <boolean:expand>false</boolean:expand>
                                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                                            </displayAttributes>
                                                            <expand>
                                                                <vectorQuery id="locatorIXP_BoundGroupExpanded">
                                                                    <xsl:if test="$is3DXOn">
                                                                        <queryRef>/locatorLocal_PMM</queryRef>
                                                                    </xsl:if>
                                                                    <xsl:if test="$is3DXOn">
                                                                        <queryRef>/locatorRemote_PMM</queryRef>
                                                                    </xsl:if>
                                                                </vectorQuery>
                                                            </expand>
                                                        </derivedQuery>
                                                    </xsl:if>
                                                    <derivedQuery id="locatorStoresBoundGroup">
                                                        <queryInherit>/locatorStoresBound</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorStoresBoundGroupExpanded">
                                                                <queryRef>/locatorStoreLatency</queryRef>
                                                                <queryRef>/locatorFalseSharing</queryRef>
                                                                <queryRef>/locatorSplitStores</queryRef>
                                                                <queryRef>/locatorDTLBStoreOverhead</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery id="locatorCoreBoundGroup">
                                            <queryInherit>/locatorCoreBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorCoreBoundGroupExpanded">
                                                    <queryRef>/locatorDIVActive</queryRef>
                                                    <derivedQuery id="locatorPortUtilGroup">
                                                        <queryInherit>/locatorPortUtil</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorPortUtilGroupExpanded">
                                                                <derivedQuery id="locatorCycles0PortsUtilizedGroup">
                                                                    <queryInherit>/locatorCycles0PortsUtilized</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="locatorCycles0PortsUtilizedGroupExpanded">
                                                                            <derivedQuery id="locatorSerializing_OperationGroup">
                                                                                <queryInherit>/locatorSerializing_Operation</queryInherit>
                                                                                <displayAttributes>
                                                                                    <boolean:expand>false</boolean:expand>
                                                                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                                </displayAttributes>
                                                                                <expand>
                                                                                    <vectorQuery id="locatorSerializing_OperationGroupExpanded">
                                                                                        <queryRef>/locatorSlow_Pause</queryRef>
                                                                                    </vectorQuery>
                                                                                </expand>
                                                                            </derivedQuery>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
                                                                <queryRef>/locatorCycles1PortUtilized</queryRef>
                                                                <queryRef>/locatorCycles2PortsUtilized</queryRef>
                                                                <derivedQuery id="locatorCycles3mPortsUtilizedGroup">
                                                                    <queryInherit>/locatorCycles3mPortsUtilized</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="locatorCycles3mPortsUtilizedGroupExpanded">
                                                                            <queryRef>/locatorPort0</queryRef>
                                                                            <queryRef>/locatorPort1</queryRef>
                                                                            <queryRef>/locatorPort2</queryRef>
                                                                            <queryRef>/locatorPort3</queryRef>
                                                                            <queryRef>/locatorPort4</queryRef>
                                                                            <queryRef>/locatorPort5</queryRef>
                                                                            <queryRef>/locatorPort6</queryRef>
                                                                            <queryRef>/locatorPort7</queryRef>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
                                                                <queryRef>/locatorFLOPSPerInstructionMultiIssue</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <locatorqueryLibrary>
                <derivedQuery displayName="%RetiredPipelineSlots" id="locatorRetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/RetiredPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%RetiredPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorRetiredPipelineSlots") > 0.75 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BASE" id="locatorBASE">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BASEDescriptionAll</description>
                    <helpKeyword>configs.base_basedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[INST_RETIRED.PREC_DIST]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[INST_RETIRED.PREC_DIST]") / queryAll("/PMUEventCount/PMUEventType[INST_RETIRED.PREC_DIST]", true)) * queryAll("/BASE", true) ) ]]></valueEval>
                    <issueText>%BASEIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBASE") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_Arith" id="locatorFP_Arith">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_ArithDescriptionAll</description>
                    <helpKeyword>configs.fp_arith_fp_arithdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.X87]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) || ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( ( query("/locatorFP_x87") + query("/locatorFP_Scalar") + query("/locatorFP_Vector") ) ) ]]></valueEval>
                    <issueText>%FP_ArithIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFP_Arith") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_x87" id="locatorFP_x87">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_x87DescriptionAll</description>
                    <helpKeyword>configs.fp_x87_fp_x87descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.X87]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( ( (query("/FP_x87") * query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.THREAD]")) / queryAll("/PMUEventCount/PMUEventType[UOPS_EXECUTED.THREAD]", true) ) ) ]]></valueEval>
                    <issueText>%FP_x87IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFP_x87") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_Scalar" id="locatorFP_Scalar">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_ScalarDescriptionAll</description>
                    <helpKeyword>configs.fp_scalar_fp_scalardescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( ( (query("/FP_Scalar") * query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]")) / queryAll("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]", true) ) ) ]]></valueEval>
                    <issueText>%FP_ScalarIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFP_Scalar") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FP_Vector" id="locatorFP_Vector">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_VectorDescriptionAll</description>
                    <helpKeyword>configs.fp_vector_fp_vectordescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( ( (query("/FP_Vector") * query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]")) / queryAll("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]", true) ) ) ]]></valueEval>
                    <issueText>%FP_VectorIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFP_Vector") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="locatorOTHER">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>configs.other_otherdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.X87]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_SINGLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.SCALAR_DOUBLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) || ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/OTHER") * query("/PMUEventCount/PMUEventType[UOPS_EXECUTED.THREAD]")) / queryAll("/PMUEventCount/PMUEventType[UOPS_EXECUTED.THREAD]", true) ) ]]></valueEval>
                    <issueText>%OTHERIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorOTHER") > 0.3 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="locatorMicroSequencer">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.microsequencer_microsequencerdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[IDQ.MS_UOPS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[IDQ.MS_UOPS]") / queryAll("/PMUEventCount/PMUEventType[IDQ.MS_UOPS]", true)) * queryAll("/MicroSequencer", true) ) ]]></valueEval>
                    <issueText>%MicroSequencerIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMicroSequencer") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="locatorAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_assistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( query("/PMUSampleCount/PMUEventType[FP_ASSIST.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[OTHER_ASSISTS.ANY]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Assists") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%AssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorAssists") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="locatorFrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_16_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_16_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_16_PS]", true)) * queryAll("/FrontendBoundPipelineSlots", true) ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFrontendBoundPipelineSlots") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FELatency" id="locatorFELatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FELatencyDescriptionAll</description>
                    <helpKeyword>configs.felatency_felatencydescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_16_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_16_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_16_PS]", true)) * queryAll("/FELatency", true) ) ]]></valueEval>
                    <issueText>%FELatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFELatency") > 0.15 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="locatorICacheMisses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.L2_MISS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.L2_MISS_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.L2_MISS_PS]", true)) * queryAll("/ICacheMisses", true) ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorICacheMisses") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="locatorITLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.STLB_MISS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.STLB_MISS_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.STLB_MISS_PS]", true)) * queryAll("/ITLBOverhead", true) ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorITLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="locatorBranchResteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branchresteers_branchresteersdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") / queryAll("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]", true)) * queryAll("/BranchResteers", true) ) ]]></valueEval>
                    <issueText>%BranchResteersIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBranchResteers") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Mispredicts_Resteers" id="locatorMispredicts_Resteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mispredicts_ResteersDescriptionAll</description>
                    <helpKeyword>configs.mispredicts_resteers_mispredicts_resteersdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") / queryAll("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]", true)) * queryAll("/Mispredicts_Resteers", true) ) ]]></valueEval>
                    <issueText>%Mispredicts_ResteersIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMispredicts_Resteers") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Clears_Resteers" id="locatorClears_Resteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Clears_ResteersDescriptionAll</description>
                    <helpKeyword>configs.clears_resteers_clears_resteersdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) ) ) ) || ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Clears_Resteers") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%Clears_ResteersIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorClears_Resteers") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Unknown_Branches" id="locatorUnknown_Branches">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Unknown_BranchesDescriptionAll</description>
                    <helpKeyword>configs.unknown_branches_unknown_branchesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) || (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ANY]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( query("/PMUSampleCount/PMUEventType[INT_MISC.CLEAR_RESTEER_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Unknown_Branches") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%Unknown_BranchesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorUnknown_Branches") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="locatorDSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsbtomiteswitchcost_dsbtomiteswitchcostdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.DSB_MISS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.DSB_MISS_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.DSB_MISS_PS]", true)) * queryAll("/DSBtoMITESwitchCost", true) ) ]]></valueEval>
                    <issueText>%DSBtoMITESwitchCostIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDSBtoMITESwitchCost") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LCP" id="locatorLCP">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LCPDescriptionAll</description>
                    <helpKeyword>configs.lcp_lcpdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ILD_STALL.LCP]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LCP") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LCPIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLCP") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MSSwitches" id="locatorMSSwitches">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MSSwitchesDescriptionAll</description>
                    <helpKeyword>configs.msswitches_msswitchesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[IDQ.MS_SWITCHES]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[IDQ.MS_SWITCHES]") / queryAll("/PMUEventCount/PMUEventType[IDQ.MS_SWITCHES]", true)) * queryAll("/MSSwitches", true) ) ]]></valueEval>
                    <issueText>%MSSwitchesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMSSwitches") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="locatorFEBandwidth">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.febandwidth_febandwidthdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS]", true)) * queryAll("/FEBandwidth", true) ) ]]></valueEval>
                    <issueText>%FEBandwidthIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFEBandwidth") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthMITE" id="locatorFEBandwidthMITE">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthMITEDescriptionAll</description>
                    <helpKeyword>configs.febandwidthmite_febandwidthmitedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[FRONTEND_RETIRED.DSB_MISS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.DSB_MISS_PS]") / queryAll("/PMUEventCount/PMUEventType[FRONTEND_RETIRED.DSB_MISS_PS]", true)) * queryAll("/FEBandwidthMITE", true) ) ]]></valueEval>
                    <issueText>%FEBandwidthMITEIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFEBandwidthMITE") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDSB" id="locatorFEBandwidthDSB">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthDSBDescriptionAll</description>
                    <helpKeyword>configs.febandwidthdsb_febandwidthdsbdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.ALL_DSB_CYCLES_ANY_UOPS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[IDQ.ALL_DSB_CYCLES_4_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FEBandwidthDSB") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%FEBandwidthDSBIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFEBandwidthDSB") > 0.3 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthLSD" id="locatorFEBandwidthLSD">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthLSDDescriptionAll</description>
                    <helpKeyword>configs.febandwidthlsd_febandwidthlsddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[LSD.CYCLES_ACTIVE]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[LSD.CYCLES_4_UOPS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FEBandwidthLSD") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%FEBandwidthLSDIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFEBandwidthLSD") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DSB_Coverage" id="locatorDSB_Coverage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DSB_CoverageDescriptionAll</description>
                    <helpKeyword>configs.dsb_coverage_dsb_coveragedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[IDQ.DSB_UOPS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[IDQ.DSB_UOPS]") / queryAll("/PMUEventCount/PMUEventType[IDQ.DSB_UOPS]", true)) * queryAll("/DSB_Coverage", true) ) ]]></valueEval>
                    <issueText>%DSB_CoverageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDSB_Coverage") < 0.7 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LSD_Coverage" id="locatorLSD_Coverage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LSD_CoverageDescriptionAll</description>
                    <helpKeyword>configs.lsd_coverage_lsd_coveragedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[LSD.UOPS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[LSD.UOPS]") / queryAll("/PMUEventCount/PMUEventType[LSD.UOPS]", true)) * queryAll("/LSD_Coverage", true) ) ]]></valueEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="locatorCancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/CancelledPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%CancelledPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCancelledPipelineSlots") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="locatorBranchMispredict">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") / queryAll("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]", true)) * queryAll("/BranchMispredict", true) ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBranchMispredict") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="locatorMachineClears">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machineclears_machineclearsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.COUNT]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.COUNT]") / queryAll("/PMUEventCount/PMUEventType[MACHINE_CLEARS.COUNT]", true)) * queryAll("/MachineClears", true) ) ]]></valueEval>
                    <issueText>%MachineClearsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMachineClears") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="locatorBackendBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BackendBound") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%BackendBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBackendBound") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="locatorMemBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.membound_membounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MemBound") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%MemBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMemBound") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L1Bound" id="locatorL1Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L1BoundDescriptionAll</description>
                    <helpKeyword>configs.l1bound_l1bounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_HIT_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L1_HIT_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L1_HIT_PS]", true)) * queryAll("/L1Bound", true) ) ]]></valueEval>
                    <issueText>%L1BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL1Bound") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="locatorDTLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.STLB_MISS_LOADS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.STLB_MISS_LOADS_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.STLB_MISS_LOADS_PS]", true)) * queryAll("/DTLBOverhead", true) ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDTLBOverhead") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="locatorLoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS.STORE_FORWARD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LoadsBlockedbyStoreForwarding") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLoadsBlockedbyStoreForwarding") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LockLatency" id="locatorLockLatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LockLatencyDescriptionAll</description>
                    <helpKeyword>configs.locklatency_locklatencydescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]", true)) * queryAll("/LockLatency", true) ) ]]></valueEval>
                    <issueText>%LockLatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLockLatency") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="locatorSplitLoads">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.SPLIT_LOADS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.SPLIT_LOADS_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.SPLIT_LOADS_PS]", true)) * queryAll("/SplitLoads", true) ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitLoads") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="locator4KAliasing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4kaliasing_4kaliasingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS_PARTIAL.ADDRESS_ALIAS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/4KAliasing") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%4KAliasingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locator4KAliasing") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FBFull" id="locatorFBFull">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FBFullDescriptionAll</description>
                    <helpKeyword>configs.fbfull_fbfulldescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.PENDING]") >= 10 ) && ( ( ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L1_MISS_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.FB_HIT_PS]") >= 10 ) )  ) ) || ( query("/PMUSampleCount/PMUEventType[L1D_PEND_MISS.FB_FULL:cmask=1]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FBFull") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%FBFullIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFBFull") > 0.3 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L2Bound" id="locatorL2Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L2BoundDescriptionAll</description>
                    <helpKeyword>configs.l2bound_l2bounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT_PS]", true)) * queryAll("/L2Bound", true) ) ]]></valueEval>
                    <issueText>%L2BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL2Bound") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L3Bound" id="locatorL3Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L3BoundDescriptionAll</description>
                    <helpKeyword>configs.l3bound_l3bounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]", true)) * queryAll("/L3Bound", true) ) ]]></valueEval>
                    <issueText>%L3BoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL3Bound") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="locatorContestedAccesses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS]", true)) * queryAll("/ContestedAccesses", true) ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorContestedAccesses") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="locatorDataSharing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.datasharing_datasharingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]", true)) * queryAll("/DataSharing", true) ) ]]></valueEval>
                    <issueText>%DataSharingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDataSharing") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L3Latency" id="locatorL3Latency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L3LatencyDescriptionAll</description>
                    <helpKeyword>configs.l3latency_l3latencydescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_HIT_PS]", true)) * queryAll("/L3Latency", true) ) ]]></valueEval>
                    <issueText>%L3LatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL3Latency") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SQFull" id="locatorSQFull">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SQFullDescriptionAll</description>
                    <helpKeyword>configs.sqfull_sqfulldescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") >= 10 )  ) ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_BUFFER.SQ_FULL]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SQFull") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%SQFullIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSQFull") > 0.3 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DRAMBound" id="locatorDRAMBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.drambound_drambounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L3_MISS_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_MISS_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L3_MISS_PS]", true)) * queryAll("/DRAMBound", true) ) ]]></valueEval>
                    <issueText>%DRAMBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDRAMBound") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MEMBandwidth" id="locatorMEMBandwidth">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEMBandwidthDescriptionAll</description>
                    <helpKeyword>configs.membandwidth_membandwidthdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MEMBandwidth") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%MEMBandwidthIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMEMBandwidth") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MEMLatency" id="locatorMEMLatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEMLatencyDescriptionAll</description>
                    <helpKeyword>configs.memlatency_memlatencydescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD]") ) >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4]") ) >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MEMLatency") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%MEMLatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMEMLatency") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LocalDRAM" id="locatorLocalDRAM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LocalDRAMDescriptionAll</description>
                    <helpKeyword>configs.localdram_localdramdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS]", true)) * queryAll("/LocalDRAM", true) ) ]]></valueEval>
                    <issueText>%LocalDRAMIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLocalDRAM") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%RemoteDRAM" id="locatorRemoteDRAM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RemoteDRAMDescriptionAll</description>
                    <helpKeyword>configs.remotedram_remotedramdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS]", true)) * queryAll("/RemoteDRAM", true) ) ]]></valueEval>
                    <issueText>%RemoteDRAMIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorRemoteDRAM") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%RemoteCache" id="locatorRemoteCache">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RemoteCacheDescriptionAll</description>
                    <helpKeyword>configs.remotecache_remotecachedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS]", true)) * queryAll("/RemoteCache", true) ) ]]></valueEval>
                    <issueText>%RemoteCacheIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorRemoteCache") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%StoresBound" id="locatorStoresBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%StoresBoundDescriptionAll</description>
                    <helpKeyword>configs.storesbound_storesbounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]", true)) * queryAll("/StoresBound", true) ) ]]></valueEval>
                    <issueText>%StoresBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorStoresBound") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%StoreLatency" id="locatorStoreLatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%StoreLatencyDescriptionAll</description>
                    <helpKeyword>configs.storelatency_storelatencydescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[L2_RQSTS.RFO_HIT]") >= 10 )  ) || (  ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) ) || ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.LOCK_LOADS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) >= 10 if ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") ) < ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) else ( query("/PMUSampleCount/PMUEventType[OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO]") ) >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/StoreLatency") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%StoreLatencyIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorStoreLatency") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FalseSharing" id="locatorFalseSharing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FalseSharingDescriptionAll</description>
                    <helpKeyword>configs.falsesharing_falsesharingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS]", true)) * queryAll("/FalseSharing", true) ) ]]></valueEval>
                    <issueText>%FalseSharingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFalseSharing") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="locatorSplitStores">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.SPLIT_STORES_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.SPLIT_STORES_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.SPLIT_STORES_PS]", true)) * queryAll("/SplitStores", true) ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitStores") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBStoreOverhead" id="locatorDTLBStoreOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DTLBStoreOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlbstoreoverhead_dtlbstoreoverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[MEM_INST_RETIRED.STLB_MISS_STORES_PS]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.STLB_MISS_STORES_PS]") / queryAll("/PMUEventCount/PMUEventType[MEM_INST_RETIRED.STLB_MISS_STORES_PS]", true)) * queryAll("/DTLBStoreOverhead", true) ) ]]></valueEval>
                    <issueText>%DTLBStoreOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDTLBStoreOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="locatorCoreBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.corebound_corebounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) ) || (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/CoreBound") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%CoreBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCoreBound") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="locatorDIVActive">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( query("/PMUSampleCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") >= 10 ) )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PMUEventCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") / queryAll("/PMUEventCount/PMUEventType[ARITH.DIVIDER_ACTIVE]", true)) * queryAll("/DIVActive", true) ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDIVActive") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%PortUtil" id="locatorPortUtil">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%PortUtilDescriptionAll</description>
                    <helpKeyword>configs.portutil_portutildescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) && ( ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) if ( ( ( query("/PMUSampleCount/PMUEventType[ARITH.DIVIDER_ACTIVE]") ) < ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") ) ) ) else ( ( ( ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) || ( ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) if ( ( query("/IPC") > 1.8 ) ) else ( 0 ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) ) || ( query("/PMUSampleCount/PMUEventType[CYCLE_ACTIVITY.STALLS_MEM_ANY]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.BOUND_ON_STORES]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PortUtil") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%PortUtilIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPortUtil") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles0PortsUtilized" id="locatorCycles0PortsUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles0PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles0portsutilized_cycles0portsutilizeddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_NONE]") >= 10 ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.EXE_BOUND_0_PORTS]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Cycles0PortsUtilized") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Cycles0PortsUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCycles0PortsUtilized") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Serializing_Operation" id="locatorSerializing_Operation">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Serializing_OperationDescriptionAll</description>
                    <helpKeyword>configs.serializing_operation_serializing_operationdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PARTIAL_RAT_STALLS.SCOREBOARD]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Serializing_Operation") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%Serializing_OperationIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSerializing_Operation") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Slow_Pause" id="locatorSlow_Pause">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Slow_PauseDescriptionAll</description>
                    <helpKeyword>configs.slow_pause_slow_pausedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[ROB_MISC_EVENTS.PAUSE_INST]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Slow_Pause") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%Slow_PauseIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSlow_Pause") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles1PortUtilized" id="locatorCycles1PortUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles1PortUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles1portutilized_cycles1portutilizeddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_1]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") >= 10 ) ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.1_PORTS_UTIL]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Cycles1PortUtilized") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Cycles1PortUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCycles1PortUtilized") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles2PortsUtilized" id="locatorCycles2PortsUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles2PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles2portsutilized_cycles2portsutilizeddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_2]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[EXE_ACTIVITY.2_PORTS_UTIL]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Cycles2PortsUtilized") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Cycles2PortsUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCycles2PortsUtilized") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Cycles3mPortsUtilized" id="locatorCycles3mPortsUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles3mPortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles3mportsutilized_cycles3mportsutilizeddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) && ( ( 2 ) if ( query("/SMT_on") ) else ( ( query("/PMUSampleCount/PMUEventType[UOPS_EXECUTED.CORE_CYCLES_GE_3]") >= 10 ) ) ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Cycles3mPortsUtilized") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Cycles3mPortsUtilizedIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCycles3mPortsUtilized") > 0.7 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port0" id="locatorPort0">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port0DescriptionAll</description>
                    <helpKeyword>configs.port0_port0descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_0]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port0") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port0IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort0") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port1" id="locatorPort1">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port1DescriptionAll</description>
                    <helpKeyword>configs.port1_port1descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_1]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port1") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port1IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort1") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port2" id="locatorPort2">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port2DescriptionAll</description>
                    <helpKeyword>configs.port2_port2descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_2]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port2") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port2IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort2") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port3" id="locatorPort3">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port3DescriptionAll</description>
                    <helpKeyword>configs.port3_port3descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_3]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port3") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port3IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort3") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port4" id="locatorPort4">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port4DescriptionAll</description>
                    <helpKeyword>configs.port4_port4descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_4]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port4") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port4IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort4") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port5" id="locatorPort5">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port5DescriptionAll</description>
                    <helpKeyword>configs.port5_port5descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_5]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port5") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port5IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort5") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port6" id="locatorPort6">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port6DescriptionAll</description>
                    <helpKeyword>configs.port6_port6descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_6]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port6") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port6IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort6") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%Port7" id="locatorPort7">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port7DescriptionAll</description>
                    <helpKeyword>configs.port7_port7descriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_DISPATCHED_PORT.PORT_7]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Port7") * query("/CORE_CLKS")) / queryAll("/CORE_CLKS", true) ) ]]></valueEval>
                    <issueText>%Port7IssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPort7") > 0.6 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FLOPSPerInstructionMultiIssue" id="locatorFLOPSPerInstructionMultiIssue">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FLOPSPerInstructionMultiIssueDescriptionAll</description>
                    <helpKeyword>configs.flopsperinstructionmultiissue_flopsperinstructionmultiissuedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/FLOPSPerInstructionMultiIssue") ) ]]></valueEval>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
    <xsl:variable name="is3DXOn" select="exsl:ctx('is3DXPPresent', 0) and not(exsl:ctx('is3DXP2LMMode', 0))" />
</xsl:stylesheet>
