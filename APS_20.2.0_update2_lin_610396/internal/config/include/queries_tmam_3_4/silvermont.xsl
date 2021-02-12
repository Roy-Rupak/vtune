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
                <derivedQuery id="FrontendBoundPipelineSlotsGroup">
                    <queryInherit>/FrontendBoundPipelineSlots</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="FrontendBoundPipelineSlotsGroupExpanded">
                            <queryRef>/ICacheMisses</queryRef>
                            <queryRef>/ITLBOverhead</queryRef>
                            <queryRef>/FarBranch</queryRef>
                            <queryRef>/BACLEARS</queryRef>
                            <queryRef>/MSEntry</queryRef>
                            <queryRef>/ICacheLineFetch</queryRef>
                            <queryRef>/PreDecodeWrong</queryRef>
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
                            <queryRef>/SMCMachineClear</queryRef>
                            <queryRef>/MOMachineClear</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery id="BackendBoundPipelineSlotsGroup">
                    <queryInherit>/BackendBoundPipelineSlots</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="BackendBoundPipelineSlotsGroupExpanded">
                            <derivedQuery displayName="%MemoryLatency" id="MemoryLatencyGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="MemoryLatencyGridGroup">
                                        <queryRef>/LLCMiss</queryRef>
                                        <queryRef>/LLCHit</queryRef>
                                        <queryRef>/DTLBOverhead</queryRef>
                                        <queryRef>/ContestedAccesses</queryRef>
                                        <queryRef>/PageWalk</queryRef>
                                        <queryRef>/BusLock</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery displayName="%MemoryReissues" id="MemoryReissuesGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="MemoryReissuesGridGroup">
                                        <queryRef>/SplitLoads</queryRef>
                                        <queryRef>/SplitStores</queryRef>
                                        <queryRef>/LoadsBlockedbyStoreForwarding</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <queryRef>/DIVActive</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery id="RetiredPipelineSlotsGroup">
                    <queryInherit>/RetiredPipelineSlots</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="RetiredPipelineSlotsGroupExpanded">
                            <queryRef>/MSAssists</queryRef>
                            <queryRef>/FPAssists</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <queryLibrary>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="FrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 2 * query("/PMUEventCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") ) / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="ICacheMisses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/ICacheLineFetch") + query("/PreDecodeWrong") ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ICacheMisses") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[DECODE_RESTRICTION.PREDECODE_WRONG]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[PAGE_WALKS.I_SIDE_CYCLES]") + ( 10 * query("/PMUEventCount/PMUEventType[PAGE_WALKS.I_SIDE_WALKS]") ) ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ITLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.I_SIDE_CYCLES]") >= 10 ) || (  ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.I_SIDE_WALKS]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FarBranch" id="FarBranch">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FarBranchDescriptionAll</description>
                    <helpKeyword>configs.farbranch_farbranchdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 100 * query("/PMUEventCount/PMUEventType[BR_INST_RETIRED.FAR_BRANCH_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%FarBranchIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FarBranch") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_INST_RETIRED.FAR_BRANCH_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BACLEARS" id="BACLEARS">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BACLEARSDescriptionAll</description>
                    <helpKeyword>configs.baclears_baclearsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 5 * query("/PMUEventCount/PMUEventType[BACLEARS.ALL]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BACLEARSIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BACLEARS") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ALL]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MSEntry" id="MSEntry">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSEntryDescriptionAll</description>
                    <helpKeyword>configs.msentry_msentrydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 3 * query("/PMUEventCount/PMUEventType[MS_DECODED.MS_ENTRY]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MSEntryIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MSEntry") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSAssists") > 0.05) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MS_DECODED.MS_ENTRY]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheLineFetch" id="ICacheLineFetch">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheLineFetchDescriptionAll</description>
                    <helpKeyword>configs.icachelinefetch_icachelinefetchdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ICacheLineFetchIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ICacheLineFetch") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%PreDecodeWrong" id="PreDecodeWrong">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PreDecodeWrongDescriptionAll</description>
                    <helpKeyword>configs.predecodewrong_predecodewrongdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 3 * query("/PMUEventCount/PMUEventType[DECODE_RESTRICTION.PREDECODE_WRONG]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%PreDecodeWrongIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/PreDecodeWrong") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[DECODE_RESTRICTION.PREDECODE_WRONG]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="CancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 2 * query("/PMUEventCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") ) / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%CancelledPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 10 * query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BranchMispredict") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SMCMachineClear" id="SMCMachineClear">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SMCMachineClearDescriptionAll</description>
                    <helpKeyword>configs.smcmachineclear_smcmachinecleardescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 14 * query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.SMC]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SMCMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SMCMachineClear") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MOMachineClear" id="MOMachineClear">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MOMachineClearDescriptionAll</description>
                    <helpKeyword>configs.momachineclear_momachinecleardescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 14 * query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MOMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MOMachineClear") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBoundPipelineSlots" id="BackendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.backendboundpipelineslots_backendboundpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 1 - ( query("/CancelledPipelineSlots") + query("/RetiredPipelineSlots") + query("/FrontendBoundPipelineSlots") ) ) ) ]]></valueEval>
                    <issueText>%BackendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMiss" id="LLCMiss">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCMissDescriptionAll</description>
                    <helpKeyword>configs.llcmiss_llcmissdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 230 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCMissIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCMiss") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHit" id="LLCHit">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCHitDescriptionAll</description>
                    <helpKeyword>configs.llchit_llchitdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 12 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCHitIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCHit") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="DTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PAGE_WALKS.D_SIDE_WALKS]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DTLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.D_SIDE_WALKS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="ContestedAccesses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 150 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.HITM_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ContestedAccesses") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.HITM_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%PageWalk" id="PageWalk">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PageWalkDescriptionAll</description>
                    <helpKeyword>configs.pagewalk_pagewalkdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PAGE_WALKS.D_SIDE_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%PageWalkIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/PageWalk") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.D_SIDE_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BusLock" id="BusLock">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BusLockDescriptionAll</description>
                    <helpKeyword>configs.buslock_buslockdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 140 * query("/PMUEventCount/PMUEventType[OFFCORE_RESPONSE:request=BUS_LOCKS:response=ANY_RESPONSE]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BusLockIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BusLock") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE:request=BUS_LOCKS:response=ANY_RESPONSE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 15 * query("/PMUEventCount/PMUEventType[REHABQ.LD_SPLITS_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitLoads") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REHABQ.LD_SPLITS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 15 * query("/PMUEventCount/PMUEventType[REHABQ.ST_SPLITS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitStores") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REHABQ.ST_SPLITS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 9 * query("/PMUEventCount/PMUEventType[REHABQ.LD_BLOCK_ST_FORWARD_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LoadsBlockedbyStoreForwarding") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REHABQ.LD_BLOCK_ST_FORWARD_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[CYCLES_DIV_BUSY.ALL]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DIVActive") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CYCLES_DIV_BUSY.ALL]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%RetiredPipelineSlots" id="RetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.ALL]") / query("/SLOTS") ) ]]></valueEval>
                    <issueText>%RetiredPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSAssists") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MSAssists" id="MSAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSAssistsDescriptionAll</description>
                    <helpKeyword>configs.msassists_msassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 2 * query("/PMUEventCount/PMUEventType[UOPS_RETIRED.MS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MSAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MSAssists") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSEntry") > 0.05) ) && ( ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSAssists") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.MS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FPAssists" id="FPAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FPAssistsDescriptionAll</description>
                    <helpKeyword>configs.fpassists_fpassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 100 * query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.FP_ASSIST]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%FPAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FPAssists") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) || ( queryOptional("/MSAssists") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.FP_ASSIST]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CORE_CLKS" id="CORE_CLKS">
                    <description>%CORE_CLKSDescriptionAll</description>
                    <helpKeyword>configs.core_clks_core_clksdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/DerivedClockticks") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SLOTS" id="SLOTS">
                    <description>%SLOTSDescriptionAll</description>
                    <helpKeyword>configs.slots_slotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/Pipeline_Width") * query("/CORE_CLKS") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Pipeline_Width" id="Pipeline_Width">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Pipeline_WidthDescriptionAll</description>
                    <helpKeyword>configs.pipeline_width_pipeline_widthdescriptionall</helpKeyword>
                    <valueEval>2</valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
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
                            <derivedQuery id="locatorFrontendBoundPipelineSlotsGroup">
                                <queryInherit>/locatorFrontendBoundPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorFrontendBoundPipelineSlotsGroupExpanded">
                                        <queryRef>/locatorICacheMisses</queryRef>
                                        <queryRef>/locatorITLBOverhead</queryRef>
                                        <queryRef>/locatorFarBranch</queryRef>
                                        <queryRef>/locatorBACLEARS</queryRef>
                                        <queryRef>/locatorMSEntry</queryRef>
                                        <queryRef>/locatorICacheLineFetch</queryRef>
                                        <queryRef>/locatorPreDecodeWrong</queryRef>
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
                                        <queryRef>/locatorSMCMachineClear</queryRef>
                                        <queryRef>/locatorMOMachineClear</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="locatorBackendBoundPipelineSlotsGroup">
                                <queryInherit>/locatorBackendBoundPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorBackendBoundPipelineSlotsGroupExpanded">
                                        <derivedQuery displayName="%MemoryLatency" id="locatorMemoryLatencyGridSection">
                                            <valueEval>""</valueEval>
                                            <valueType>string</valueType>
                                            <displayAttributes>
                                                <boolean:expand>true</boolean:expand>
                                                <boolean:allowCollapse>false</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorMemoryLatencyGridGroup">
                                                    <queryRef>/locatorLLCMiss</queryRef>
                                                    <queryRef>/locatorLLCHit</queryRef>
                                                    <queryRef>/locatorDTLBOverhead</queryRef>
                                                    <queryRef>/locatorContestedAccesses</queryRef>
                                                    <queryRef>/locatorPageWalk</queryRef>
                                                    <queryRef>/locatorBusLock</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery displayName="%MemoryReissues" id="locatorMemoryReissuesGridSection">
                                            <valueEval>""</valueEval>
                                            <valueType>string</valueType>
                                            <displayAttributes>
                                                <boolean:expand>true</boolean:expand>
                                                <boolean:allowCollapse>false</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorMemoryReissuesGridGroup">
                                                    <queryRef>/locatorSplitLoads</queryRef>
                                                    <queryRef>/locatorSplitStores</queryRef>
                                                    <queryRef>/locatorLoadsBlockedbyStoreForwarding</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <queryRef>/locatorDIVActive</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="locatorRetiredPipelineSlotsGroup">
                                <queryInherit>/locatorRetiredPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorRetiredPipelineSlotsGroupExpanded">
                                        <queryRef>/locatorMSAssists</queryRef>
                                        <queryRef>/locatorFPAssists</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <locatorqueryLibrary>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="locatorFrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FrontendBoundPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFrontendBoundPipelineSlots") > 0.15 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="locatorICacheMisses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[DECODE_RESTRICTION.PREDECODE_WRONG]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ICacheMisses") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorICacheMisses") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="locatorITLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.I_SIDE_CYCLES]") >= 10 ) || (  ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.I_SIDE_WALKS]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ITLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorITLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FarBranch" id="locatorFarBranch">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FarBranchDescriptionAll</description>
                    <helpKeyword>configs.farbranch_farbranchdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_INST_RETIRED.FAR_BRANCH_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FarBranch") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%FarBranchIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFarBranch") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BACLEARS" id="locatorBACLEARS">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BACLEARSDescriptionAll</description>
                    <helpKeyword>configs.baclears_baclearsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ALL]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BACLEARS") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%BACLEARSIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBACLEARS") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MSEntry" id="locatorMSEntry">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MSEntryDescriptionAll</description>
                    <helpKeyword>configs.msentry_msentrydescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MS_DECODED.MS_ENTRY]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MSEntry") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%MSEntryIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMSEntry") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheLineFetch" id="locatorICacheLineFetch">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ICacheLineFetchDescriptionAll</description>
                    <helpKeyword>configs.icachelinefetch_icachelinefetchdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ICacheLineFetch") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ICacheLineFetchIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorICacheLineFetch") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%PreDecodeWrong" id="locatorPreDecodeWrong">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%PreDecodeWrongDescriptionAll</description>
                    <helpKeyword>configs.predecodewrong_predecodewrongdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[DECODE_RESTRICTION.PREDECODE_WRONG]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PreDecodeWrong") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%PreDecodeWrongIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPreDecodeWrong") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="locatorCancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BranchMispredict") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBranchMispredict") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SMCMachineClear" id="locatorSMCMachineClear">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SMCMachineClearDescriptionAll</description>
                    <helpKeyword>configs.smcmachineclear_smcmachinecleardescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SMCMachineClear") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SMCMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSMCMachineClear") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MOMachineClear" id="locatorMOMachineClear">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MOMachineClearDescriptionAll</description>
                    <helpKeyword>configs.momachineclear_momachinecleardescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MOMachineClear") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%MOMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMOMachineClear") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBoundPipelineSlots" id="locatorBackendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BackendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.backendboundpipelineslots_backendboundpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BackendBoundPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%BackendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBackendBoundPipelineSlots") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMiss" id="locatorLLCMiss">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCMissDescriptionAll</description>
                    <helpKeyword>configs.llcmiss_llcmissdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LLCMiss") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LLCMissIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCMiss") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHit" id="locatorLLCHit">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCHitDescriptionAll</description>
                    <helpKeyword>configs.llchit_llchitdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LLCHit") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LLCHitIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCHit") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="locatorDTLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.D_SIDE_WALKS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DTLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDTLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="locatorContestedAccesses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.HITM_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ContestedAccesses") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorContestedAccesses") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%PageWalk" id="locatorPageWalk">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%PageWalkDescriptionAll</description>
                    <helpKeyword>configs.pagewalk_pagewalkdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.D_SIDE_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PageWalk") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%PageWalkIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPageWalk") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BusLock" id="locatorBusLock">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BusLockDescriptionAll</description>
                    <helpKeyword>configs.buslock_buslockdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE:request=BUS_LOCKS:response=ANY_RESPONSE]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BusLock") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%BusLockIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBusLock") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="locatorSplitLoads">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REHABQ.LD_SPLITS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SplitLoads") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitLoads") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="locatorSplitStores">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REHABQ.ST_SPLITS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SplitStores") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitStores") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="locatorLoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REHABQ.LD_BLOCK_ST_FORWARD_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LoadsBlockedbyStoreForwarding") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLoadsBlockedbyStoreForwarding") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="locatorDIVActive">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CYCLES_DIV_BUSY.ALL]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DIVActive") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDIVActive") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%RetiredPipelineSlots" id="locatorRetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/RetiredPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%RetiredPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorRetiredPipelineSlots") > 0.7 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MSAssists" id="locatorMSAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MSAssistsDescriptionAll</description>
                    <helpKeyword>configs.msassists_msassistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.MS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MSAssists") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%MSAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMSAssists") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FPAssists" id="locatorFPAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FPAssistsDescriptionAll</description>
                    <helpKeyword>configs.fpassists_fpassistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.FP_ASSIST]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FPAssists") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%FPAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFPAssists") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
    <xsl:variable name="is3DXOn" select="exsl:ctx('is3DXPPresent', 0) and not(exsl:ctx('is3DXP2LMMode', 0))" />
</xsl:stylesheet>
