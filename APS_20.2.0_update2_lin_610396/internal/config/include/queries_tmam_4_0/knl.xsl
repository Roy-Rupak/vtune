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
                            <queryRef>/ITLBOverhead</queryRef>
                            <queryRef>/BACLEARS</queryRef>
                            <queryRef>/MSEntry</queryRef>
                            <queryRef>/ICacheLineFetch</queryRef>
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
                                        <queryRef>/L1HitRate</queryRef>
                                        <queryRef>/LLCHitRateKNL</queryRef>
                                        <queryRef>/LLCHitKNL</queryRef>
                                        <queryRef>/LLCMissKNL</queryRef>
                                        <queryRef>/UTLBOverhead</queryRef>
                                        <queryRef>/SIMDComputeToL1AccessRatio</queryRef>
                                        <queryRef>/SIMDComputeToL2AccessRatio</queryRef>
                                        <queryRef>/ContestedAccessesKNL</queryRef>
                                        <queryRef>/PageWalk</queryRef>
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
                            <queryRef>/VPUUtilization</queryRef>
                            <queryRef>/DIVActive</queryRef>
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
                        <![CDATA[ ( ( 2 * query("/PMUEventCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") ) / ( 2 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PAGE_WALKS.I_SIDE_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ITLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.I_SIDE_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BACLEARS" id="BACLEARS">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BACLEARSDescriptionAll</description>
                    <helpKeyword>configs.baclears_baclearsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 5 * query("/PMUEventCount/PMUEventType[BACLEARS.ALL]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BACLEARSIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BACLEARS") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ALL]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MSEntry" id="MSEntry">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSEntryDescriptionAll</description>
                    <helpKeyword>configs.msentry_msentrydescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 3 * query("/PMUEventCount/PMUEventType[MS_DECODED.MS_ENTRY]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MSEntryIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MSEntry") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MS_DECODED.MS_ENTRY]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheLineFetch" id="ICacheLineFetch">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheLineFetchDescriptionAll</description>
                    <helpKeyword>configs.icachelinefetch_icachelinefetchdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ICacheLineFetchIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ICacheLineFetch") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="CancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 2 * query("/PMUEventCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") ) / ( 2 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%CancelledPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/CancelledPipelineSlots") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 2 * query("/PMUEventCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") ) / ( 2 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BranchMispredict") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SMCMachineClear" id="SMCMachineClear">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SMCMachineClearDescriptionAll</description>
                    <helpKeyword>configs.smcmachineclear_smcmachinecleardescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 14 * query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.SMC]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SMCMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SMCMachineClear") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MOMachineClear" id="MOMachineClear">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MOMachineClearDescriptionAll</description>
                    <helpKeyword>configs.momachineclear_momachinecleardescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 14 * query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MOMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MOMachineClear") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBoundPipelineSlots" id="BackendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.backendboundpipelineslots_backendboundpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 1 - ( query("/FrontendBoundPipelineSlots") + query("/CancelledPipelineSlots") + query("/RetiredPipelineSlots") ) ) ]]></valueEval>
                    <issueText>%BackendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( (  ( ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L1HitRate" id="L1HitRate">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%L1HitRateDescriptionAll</description>
                    <helpKeyword>configs.l1hitrate_l1hitratedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 1 - ( query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L1_MISS_LOADS]") / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") ) ) ]]></valueEval>
                    <issueText>%L1HitRateIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/L1HitRate") < 0.95 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L1_MISS_LOADS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHitRateKNL" id="LLCHitRateKNL">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LLCHitRateKNLDescriptionAll</description>
                    <helpKeyword>configs.llchitrateknl_llchitrateknldescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") / ( query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") + query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") ) ) ]]></valueEval>
                    <issueText>%LLCHitRateKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCHitRateKNL") < 0.8 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHitKNL" id="LLCHitKNL">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCHitKNLDescriptionAll</description>
                    <helpKeyword>configs.llchitknl_llchitknldescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 17 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCHitKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCHitKNL") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMissKNL" id="LLCMissKNL">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCMissKNLDescriptionAll</description>
                    <helpKeyword>configs.llcmissknl_llcmissknldescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 230 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCMissKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCMissKNL") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%UTLBOverhead" id="UTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%UTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.utlboverhead_utlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 6 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.UTLB_MISS_LOADS]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%UTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/UTLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.UTLB_MISS_LOADS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SIMDComputeToL1AccessRatio" id="SIMDComputeToL1AccessRatio">
                    <valueType>double</valueType>
                    <notApplicableGroupings>
                        <vectorQuery id="notApplicableGroupingsGroup">
                            <vectorQueryInsert>/PMUMemoryObjectGroupingQueries</vectorQueryInsert>
                        </vectorQuery>
                    </notApplicableGroupings>
                    <description>%SIMDComputeToL1AccessRatioDescriptionAll</description>
                    <helpKeyword>configs.simdcomputetol1accessratio_simdcomputetol1accessratiodescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") ) / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") ) ]]></valueEval>
                    <issueText>%SIMDComputeToL1AccessRatioIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SIMDComputeToL1AccessRatio") < 1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SIMDComputeToL2AccessRatio" id="SIMDComputeToL2AccessRatio">
                    <valueType>double</valueType>
                    <notApplicableGroupings>
                        <vectorQuery id="notApplicableGroupingsGroup">
                            <vectorQueryInsert>/PMUMemoryObjectGroupingQueries</vectorQueryInsert>
                        </vectorQuery>
                    </notApplicableGroupings>
                    <description>%SIMDComputeToL2AccessRatioDescriptionAll</description>
                    <helpKeyword>configs.simdcomputetol2accessratio_simdcomputetol2accessratiodescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") ) / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") ) ]]></valueEval>
                    <issueText>%SIMDComputeToL2AccessRatioIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( ( query("/SIMDComputeToL2AccessRatio") < 100 * query("/SIMDComputeToL1AccessRatio") ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccessesKNL" id="ContestedAccessesKNL">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%ContestedAccessesKNLDescriptionAll</description>
                    <helpKeyword>configs.contestedaccessesknl_contestedaccessesknldescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.HITM]") / ( query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") + query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES]") ) ) ]]></valueEval>
                    <issueText>%ContestedAccessesKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ContestedAccessesKNL") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.HITM]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%PageWalk" id="PageWalk">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PageWalkDescriptionAll</description>
                    <helpKeyword>configs.pagewalk_pagewalkdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PAGE_WALKS.CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%PageWalkIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/PageWalk") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[RECYCLEQ.LD_SPLITS_PS]") / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitLoads") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[RECYCLEQ.LD_SPLITS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[RECYCLEQ.ST_SPLITS]") / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES]") ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitStores") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[RECYCLEQ.ST_SPLITS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[RECYCLEQ.LD_BLOCK_ST_FORWARD_PS]") / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LoadsBlockedbyStoreForwarding") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBoundPipelineSlots") > 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[RECYCLEQ.LD_BLOCK_ST_FORWARD_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%RetiredPipelineSlots" id="RetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.ALL]") / ( 2 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%RetiredPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%VPUUtilization" id="VPUUtilization">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%VPUUtilizationDescriptionAll</description>
                    <helpKeyword>configs.vpuutilization_vpuutilizationdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") / ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") + query("/PMUEventCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") ) ) ]]></valueEval>
                    <issueText>%VPUUtilizationIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/VPUUtilization") < 0.5 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[CYCLES_DIV_BUSY.ALL]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DIVActive") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CYCLES_DIV_BUSY.ALL]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MSAssists" id="MSAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSAssistsDescriptionAll</description>
                    <helpKeyword>configs.msassists_msassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.MS]") / query("/PMUEventCount/PMUEventType[UOPS_RETIRED.ALL]") ) ]]></valueEval>
                    <issueText>%MSAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MSAssists") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.MS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FPAssists" id="FPAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FPAssistsDescriptionAll</description>
                    <helpKeyword>configs.fpassists_fpassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.FP_ASSIST]") / query("/DerivedInstructionsRetired") ) ]]></valueEval>
                    <issueText>%FPAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FPAssists") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiredPipelineSlots") > 0.7 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.FP_ASSIST]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[INST_RETIRED.ANY]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                                        <queryRef>/locatorITLBOverhead</queryRef>
                                        <queryRef>/locatorBACLEARS</queryRef>
                                        <queryRef>/locatorMSEntry</queryRef>
                                        <queryRef>/locatorICacheLineFetch</queryRef>
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
                                                    <queryRef>/locatorL1HitRate</queryRef>
                                                    <queryRef>/locatorLLCHitRateKNL</queryRef>
                                                    <queryRef>/locatorLLCHitKNL</queryRef>
                                                    <queryRef>/locatorLLCMissKNL</queryRef>
                                                    <queryRef>/locatorUTLBOverhead</queryRef>
                                                    <queryRef>/locatorSIMDComputeToL1AccessRatio</queryRef>
                                                    <queryRef>/locatorSIMDComputeToL2AccessRatio</queryRef>
                                                    <queryRef>/locatorContestedAccessesKNL</queryRef>
                                                    <queryRef>/locatorPageWalk</queryRef>
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
                                        <queryRef>/locatorVPUUtilization</queryRef>
                                        <queryRef>/locatorDIVActive</queryRef>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FrontendBoundPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFrontendBoundPipelineSlots") > 0.15 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="locatorITLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.I_SIDE_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ITLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorITLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BACLEARS" id="locatorBACLEARS">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BACLEARSDescriptionAll</description>
                    <helpKeyword>configs.baclears_baclearsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BACLEARS.ALL]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MS_DECODED.MS_ENTRY]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[FETCH_STALL.ICACHE_FILL_PENDING_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ICacheLineFetch") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ICacheLineFetchIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorICacheLineFetch") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="locatorCancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/CancelledPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%CancelledPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorCancelledPipelineSlots") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="locatorBranchMispredict">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( (  ( ( ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.NOT_DELIVERED]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( (  ( query("/PMUSampleCount/PMUEventType[NO_ALLOC_CYCLES.MISPREDICTS]") >= 10 ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BackendBoundPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%BackendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBackendBoundPipelineSlots") > 0.5 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L1HitRate" id="locatorL1HitRate">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L1HitRateDescriptionAll</description>
                    <helpKeyword>configs.l1hitrate_l1hitratedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( (  ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L1_MISS_LOADS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/L1HitRate") ) ]]></valueEval>
                    <issueText>%L1HitRateIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL1HitRate") < 0.95 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHitRateKNL" id="locatorLLCHitRateKNL">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCHitRateKNLDescriptionAll</description>
                    <helpKeyword>configs.llchitrateknl_llchitrateknldescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/LLCHitRateKNL") ) ]]></valueEval>
                    <issueText>%LLCHitRateKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCHitRateKNL") < 0.8 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHitKNL" id="locatorLLCHitKNL">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCHitKNLDescriptionAll</description>
                    <helpKeyword>configs.llchitknl_llchitknldescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LLCHitKNL") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LLCHitKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCHitKNL") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMissKNL" id="locatorLLCMissKNL">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCMissKNLDescriptionAll</description>
                    <helpKeyword>configs.llcmissknl_llcmissknldescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_MISS_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LLCMissKNL") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LLCMissKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCMissKNL") > 0.15 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%UTLBOverhead" id="locatorUTLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%UTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.utlboverhead_utlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.UTLB_MISS_LOADS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/UTLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%UTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorUTLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SIMDComputeToL1AccessRatio" id="locatorSIMDComputeToL1AccessRatio">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SIMDComputeToL1AccessRatioDescriptionAll</description>
                    <helpKeyword>configs.simdcomputetol1accessratio_simdcomputetol1accessratiodescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/SIMDComputeToL1AccessRatio") ) ]]></valueEval>
                    <issueText>%SIMDComputeToL1AccessRatioIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSIMDComputeToL1AccessRatio") < 1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SIMDComputeToL2AccessRatio" id="locatorSIMDComputeToL2AccessRatio">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SIMDComputeToL2AccessRatioDescriptionAll</description>
                    <helpKeyword>configs.simdcomputetol2accessratio_simdcomputetol2accessratiodescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.L2_HIT_LOADS_PS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/SIMDComputeToL2AccessRatio") ) ]]></valueEval>
                    <issueText>%SIMDComputeToL2AccessRatioIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSIMDComputeToL2AccessRatio") < 100 * query("/SIMDComputeToL1AccessRatio") ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccessesKNL" id="locatorContestedAccessesKNL">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ContestedAccessesKNLDescriptionAll</description>
                    <helpKeyword>configs.contestedaccessesknl_contestedaccessesknldescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.HITM]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/ContestedAccessesKNL") ) ]]></valueEval>
                    <issueText>%ContestedAccessesKNLIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorContestedAccessesKNL") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%PageWalk" id="locatorPageWalk">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%PageWalkDescriptionAll</description>
                    <helpKeyword>configs.pagewalk_pagewalkdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/PageWalk") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%PageWalkIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorPageWalk") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="locatorSplitLoads">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[RECYCLEQ.LD_SPLITS_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/SplitLoads") ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitLoads") > 0.15 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="locatorSplitStores">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[RECYCLEQ.ST_SPLITS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/SplitStores") ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitStores") > 0.15 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="locatorLoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[RECYCLEQ.LD_BLOCK_ST_FORWARD_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_LOADS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/LoadsBlockedbyStoreForwarding") ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLoadsBlockedbyStoreForwarding") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%RetiredPipelineSlots" id="locatorRetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/RetiredPipelineSlots") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%RetiredPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorRetiredPipelineSlots") > 0.7 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%VPUUtilization" id="locatorVPUUtilization">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%VPUUtilizationDescriptionAll</description>
                    <helpKeyword>configs.vpuutilization_vpuutilizationdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) && ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.PACKED_SIMD]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.SCALAR_SIMD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/VPUUtilization") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%VPUUtilizationIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorVPUUtilization") < 0.5 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="locatorDIVActive">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CYCLES_DIV_BUSY.ALL]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DIVActive") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDIVActive") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MSAssists" id="locatorMSAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MSAssistsDescriptionAll</description>
                    <helpKeyword>configs.msassists_msassistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.MS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ALL]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MSAssists") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%MSAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMSAssists") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FPAssists" id="locatorFPAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FPAssistsDescriptionAll</description>
                    <helpKeyword>configs.fpassists_fpassistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.FP_ASSIST]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[INST_RETIRED.ANY]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
