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
                <derivedQuery displayName="%FilledPipelineSlots" id="FilledPipelineSlotsGridSection">
                    <valueEval>""</valueEval>
                    <valueType>string</valueType>
                    <displayAttributes>
                        <boolean:expand>true</boolean:expand>
                        <boolean:allowCollapse>false</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="FilledPipelineSlotsGridGroup">
                            <derivedQuery id="RetiredPipelineSlotsGroup">
                                <queryInherit>/RetiredPipelineSlots</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="RetiredPipelineSlotsGroupExpanded">
                                        <queryRef>/Assists</queryRef>
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
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery displayName="%UnfilledPipelineSlots" id="UnfilledPipelineSlotsGridSection">
                    <valueEval>""</valueEval>
                    <valueType>string</valueType>
                    <displayAttributes>
                        <boolean:expand>true</boolean:expand>
                        <boolean:allowCollapse>false</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="UnfilledPipelineSlotsGridGroup">
                            <derivedQuery id="BackendBoundGroup">
                                <queryInherit>/BackendBound</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="BackendBoundGroupExpanded">
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
                                                    <queryRef>/DataSharing</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery displayName="%MemoryReplacements" id="MemoryReplacementsGridSection">
                                            <valueEval>""</valueEval>
                                            <valueType>string</valueType>
                                            <displayAttributes>
                                                <boolean:expand>true</boolean:expand>
                                                <boolean:allowCollapse>false</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="MemoryReplacementsGridGroup">
                                                    <queryRef>/L1DReplacementPercentage</queryRef>
                                                    <queryRef>/L2ReplacementPercentage</queryRef>
                                                    <queryRef>/LLCReplacementPercentage</queryRef>
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
                                                    <queryRef>/LoadsBlockedbyStoreForwarding</queryRef>
                                                    <queryRef>/SplitLoads</queryRef>
                                                    <queryRef>/SplitStores</queryRef>
                                                    <queryRef>/4KAliasing</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <queryRef>/DIVActive</queryRef>
                                        <queryRef>/FlagsMergeStalls</queryRef>
                                        <queryRef>/SlowLEAStalls</queryRef>
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
                                        <queryRef>/ICacheMisses</queryRef>
                                        <queryRef>/ITLBOverhead</queryRef>
                                        <queryRef>/DSBtoMITESwitchCost</queryRef>
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
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="Assists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_assistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[IDQ.MS_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%AssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/Assists") > 0.02 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.MS_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="CancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( query("/PMUEventCount/PMUEventType[UOPS_ISSUED.ANY]") - query("/PMUEventCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") + 4 * query("/PMUEventCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") ) / ( 4 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%CancelledPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 20 * query("/PMUEventCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/BranchMispredict") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="MachineClears">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machineclears_machineclearsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( ( query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") + query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.SMC]") + query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.MASKMOV]") ) * 100 ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MachineClearsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MachineClears") > 0.02 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/CancelledPipelineSlots") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MASKMOV]") >= 10 ) )  ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="BackendBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 1 - ( query("/FrontendBoundPipelineSlots") + query("/CancelledPipelineSlots") + query("/RetiredPipelineSlots") ) ) ]]></valueEval>
                    <issueText>%BackendBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMiss" id="LLCMiss">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCMissDescriptionAll</description>
                    <helpKeyword>configs.llcmiss_llcmissdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 180 * query("/PMUEventCount/PMUEventType[MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCMissIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCMiss") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHit" id="LLCHit">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCHitDescriptionAll</description>
                    <helpKeyword>configs.llchit_llchitdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( ( 26 * query("/PMUEventCount/PMUEventType[MEM_LOAD_UOPS_RETIRED.LLC_HIT_PS]") ) + ( 43 * query("/PMUEventCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS]") ) + ( 60 * query("/PMUEventCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS]") ) ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCHitIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCHit") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_RETIRED.LLC_HIT_PS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) ) || (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="DTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( ( 7 * query("/PMUEventCount/PMUEventType[DTLB_LOAD_MISSES.STLB_HIT]") ) + query("/PMUEventCount/PMUEventType[DTLB_LOAD_MISSES.WALK_DURATION]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DTLBOverhead") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[DTLB_LOAD_MISSES.STLB_HIT]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[DTLB_LOAD_MISSES.WALK_DURATION]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="ContestedAccesses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 60 * query("/PMUEventCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ContestedAccesses") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="DataSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.datasharing_datasharingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 43 * query("/PMUEventCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DataSharingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DataSharing") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L1DReplacementPercentage" id="L1DReplacementPercentage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%L1DReplacementPercentageDescriptionAll</description>
                    <helpKeyword>configs.l1dreplacementpercentage_l1dreplacementpercentagedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/L1DReplacements") / queryAll("/L1DReplacements") ) ]]></valueEval>
                    <issueText>%L1DReplacementPercentageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/L1DReplacementPercentage") > 0.75 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[L1D.REPLACEMENT]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L2ReplacementPercentage" id="L2ReplacementPercentage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%L2ReplacementPercentageDescriptionAll</description>
                    <helpKeyword>configs.l2replacementpercentage_l2replacementpercentagedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/L2Replacements") / queryAll("/L2Replacements") ) ]]></valueEval>
                    <issueText>%L2ReplacementPercentageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/L2ReplacementPercentage") > 0.75 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[L2_LINES_IN.ALL]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCReplacementPercentage" id="LLCReplacementPercentage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LLCReplacementPercentageDescriptionAll</description>
                    <helpKeyword>configs.llcreplacementpercentage_llcreplacementpercentagedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/LLCReplacements") / queryAll("/LLCReplacements") ) ]]></valueEval>
                    <issueText>%LLCReplacementPercentageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LLCReplacementPercentage") > 0.75 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS.LOCAL_DRAM_0]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 13 * query("/PMUEventCount/PMUEventType[LD_BLOCKS.STORE_FORWARD]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/LoadsBlockedbyStoreForwarding") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS.STORE_FORWARD]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 5 * query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.SPLIT_LOADS_PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitLoads") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.SPLIT_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.SPLIT_STORES_PS]") / query("/PMUEventCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES_PS]") ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SplitStores") > 0.01 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.SPLIT_STORES_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="4KAliasing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4kaliasing_4kaliasingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 5 * query("/PMUEventCount/PMUEventType[LD_BLOCKS_PARTIAL.ADDRESS_ALIAS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%4KAliasingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/4KAliasing") > 0.1 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS_PARTIAL.ADDRESS_ALIAS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[ARITH.FPU_DIV_ACTIVE]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DIVActive") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ARITH.FPU_DIV_ACTIVE]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FlagsMergeStalls" id="FlagsMergeStalls">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FlagsMergeStallsDescriptionAll</description>
                    <helpKeyword>configs.flagsmergestalls_flagsmergestallsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%FlagsMergeStallsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FlagsMergeStalls") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SlowLEAStalls" id="SlowLEAStalls">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SlowLEAStallsDescriptionAll</description>
                    <helpKeyword>configs.slowleastalls_slowleastallsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SlowLEAStallsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SlowLEAStalls") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/BackendBound") > 0.2 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="FrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") / ( 4 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%FrontendBoundPipelineSlotsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="ICacheMisses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[ICACHE.MISSES]") / query("/DerivedInstructionsRetired") ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ICacheMisses") > 0.01 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ICACHE.MISSES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 7 * query("/PMUEventCount/PMUEventType[ITLB_MISSES.STLB_HIT]") + query("/PMUEventCount/PMUEventType[ITLB_MISSES.WALK_DURATION]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/ITLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[ITLB_MISSES.STLB_HIT]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[ITLB_MISSES.WALK_DURATION]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="DSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsbtomiteswitchcost_dsbtomiteswitchcostdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[DSB2MITE_SWITCHES.PENALTY_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DSBtoMITESwitchCostIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/DSBtoMITESwitchCost") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/FrontendBoundPipelineSlots") > 0.15 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[DSB2MITE_SWITCHES.PENALTY_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SLOTS" id="SLOTS">
                    <description>%SLOTSDescriptionAll</description>
                    <helpKeyword>configs.slots_slotsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( 4 * query("/DerivedClockticks") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L1DReplacements" id="L1DReplacements">
                    <description>%L1DReplacementsDescriptionAll</description>
                    <helpKeyword>configs.l1dreplacements_l1dreplacementsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[L1D.REPLACEMENT]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[L1D.REPLACEMENT]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%L2Replacements" id="L2Replacements">
                    <description>%L2ReplacementsDescriptionAll</description>
                    <helpKeyword>configs.l2replacements_l2replacementsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[L2_LINES_IN.ALL]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[L2_LINES_IN.ALL]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCReplacements" id="LLCReplacements">
                    <description>%LLCReplacementsDescriptionAll</description>
                    <helpKeyword>configs.llcreplacements_llcreplacementsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS.LOCAL_DRAM_0]") ) ]]></valueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS.LOCAL_DRAM_0]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
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
                            <derivedQuery displayName="%FilledPipelineSlots" id="locatorFilledPipelineSlotsGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorFilledPipelineSlotsGridGroup">
                                        <derivedQuery id="locatorRetiredPipelineSlotsGroup">
                                            <queryInherit>/locatorRetiredPipelineSlots</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorRetiredPipelineSlotsGroupExpanded">
                                                    <queryRef>/locatorAssists</queryRef>
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
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery displayName="%UnfilledPipelineSlots" id="locatorUnfilledPipelineSlotsGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorUnfilledPipelineSlotsGridGroup">
                                        <derivedQuery id="locatorBackendBoundGroup">
                                            <queryInherit>/locatorBackendBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorBackendBoundGroupExpanded">
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
                                                                <queryRef>/locatorDataSharing</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <derivedQuery displayName="%MemoryReplacements" id="locatorMemoryReplacementsGridSection">
                                                        <valueEval>""</valueEval>
                                                        <valueType>string</valueType>
                                                        <displayAttributes>
                                                            <boolean:expand>true</boolean:expand>
                                                            <boolean:allowCollapse>false</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="locatorMemoryReplacementsGridGroup">
                                                                <queryRef>/locatorL1DReplacementPercentage</queryRef>
                                                                <queryRef>/locatorL2ReplacementPercentage</queryRef>
                                                                <queryRef>/locatorLLCReplacementPercentage</queryRef>
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
                                                                <queryRef>/locatorLoadsBlockedbyStoreForwarding</queryRef>
                                                                <queryRef>/locatorSplitLoads</queryRef>
                                                                <queryRef>/locatorSplitStores</queryRef>
                                                                <queryRef>/locator4KAliasing</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
                                                    <queryRef>/locatorDIVActive</queryRef>
                                                    <queryRef>/locatorFlagsMergeStalls</queryRef>
                                                    <queryRef>/locatorSlowLEAStalls</queryRef>
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
                                                    <queryRef>/locatorICacheMisses</queryRef>
                                                    <queryRef>/locatorITLBOverhead</queryRef>
                                                    <queryRef>/locatorDSBtoMITESwitchCost</queryRef>
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
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="locatorAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_assistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[IDQ.MS_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/Assists") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%AssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorAssists") > 0.02 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="locatorCancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_MISP_RETIRED.ALL_BRANCHES_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BranchMispredict") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBranchMispredict") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="locatorMachineClears">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machineclears_machineclearsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( ( ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MEMORY_ORDERING]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.MASKMOV]") >= 10 ) )  ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/MachineClears") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%MachineClearsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorMachineClears") > 0.02 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="locatorBackendBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( (  ( ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) || ( ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_ISSUED.ANY]") >= 10 ) || ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[INT_MISC.RECOVERY_CYCLES]") >= 10 ) ) ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) || ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.RETIRE_SLOTS]") >= 10 ) && ( query("/ClocktickSamples") >= 10 ) ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BackendBound") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%BackendBoundIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBackendBound") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMiss" id="locatorLLCMiss">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCMissDescriptionAll</description>
                    <helpKeyword>configs.llcmiss_llcmissdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LLCMiss") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LLCMissIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCMiss") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHit" id="locatorLLCHit">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCHitDescriptionAll</description>
                    <helpKeyword>configs.llchit_llchitdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_RETIRED.LLC_HIT_PS]") >= 10 ) ) || (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) ) || (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/LLCHit") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%LLCHitIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCHit") > 0.2 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="locatorDTLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[DTLB_LOAD_MISSES.STLB_HIT]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[DTLB_LOAD_MISSES.WALK_DURATION]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DTLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDTLBOverhead") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="locatorContestedAccesses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ContestedAccesses") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorContestedAccesses") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="locatorDataSharing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.datasharing_datasharingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DataSharing") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DataSharingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDataSharing") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L1DReplacementPercentage" id="locatorL1DReplacementPercentage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L1DReplacementPercentageDescriptionAll</description>
                    <helpKeyword>configs.l1dreplacementpercentage_l1dreplacementpercentagedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[L1D.REPLACEMENT]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/L1DReplacementPercentage") ) ]]></valueEval>
                    <issueText>%L1DReplacementPercentageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL1DReplacementPercentage") > 0.75 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%L2ReplacementPercentage" id="locatorL2ReplacementPercentage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L2ReplacementPercentageDescriptionAll</description>
                    <helpKeyword>configs.l2replacementpercentage_l2replacementpercentagedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[L2_LINES_IN.ALL]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/L2ReplacementPercentage") ) ]]></valueEval>
                    <issueText>%L2ReplacementPercentageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorL2ReplacementPercentage") > 0.75 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCReplacementPercentage" id="locatorLLCReplacementPercentage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCReplacementPercentageDescriptionAll</description>
                    <helpKeyword>configs.llcreplacementpercentage_llcreplacementpercentagedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( query("/PMUSampleCount/PMUEventType[OFFCORE_RESPONSE.DATA_IN_SOCKET.LLC_MISS.LOCAL_DRAM_0]") >= 10 ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( query("/LLCReplacementPercentage") ) ]]></valueEval>
                    <issueText>%LLCReplacementPercentageIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorLLCReplacementPercentage") > 0.75 ) ) ]]></issueEval>
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
                        <![CDATA[ ( ( query("/locatorLoadsBlockedbyStoreForwarding") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="locatorSplitLoads">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.SPLIT_LOADS_PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SplitLoads") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitLoads") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="locatorSplitStores">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.SPLIT_STORES_PS]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[MEM_UOPS_RETIRED.ALL_STORES_PS]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SplitStores") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSplitStores") > 0.01 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="locator4KAliasing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4kaliasing_4kaliasingdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[LD_BLOCKS_PARTIAL.ADDRESS_ALIAS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/4KAliasing") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%4KAliasingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locator4KAliasing") > 0.1 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="locatorDIVActive">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ARITH.FPU_DIV_ACTIVE]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DIVActive") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDIVActive") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FlagsMergeStalls" id="locatorFlagsMergeStalls">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FlagsMergeStallsDescriptionAll</description>
                    <helpKeyword>configs.flagsmergestalls_flagsmergestallsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PARTIAL_RAT_STALLS.FLAGS_MERGE_UOP_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FlagsMergeStalls") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%FlagsMergeStallsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFlagsMergeStalls") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SlowLEAStalls" id="locatorSlowLEAStalls">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SlowLEAStallsDescriptionAll</description>
                    <helpKeyword>configs.slowleastalls_slowleastallsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PARTIAL_RAT_STALLS.SLOW_LEA_WINDOW]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SlowLEAStalls") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SlowLEAStallsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSlowLEAStalls") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="locatorFrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[IDQ_UOPS_NOT_DELIVERED.CORE]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ICACHE.MISSES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ICacheMisses") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorICacheMisses") > 0.01 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="locatorITLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( (  ( query("/PMUSampleCount/PMUEventType[ITLB_MISSES.STLB_HIT]") >= 10 ) ) || ( query("/PMUSampleCount/PMUEventType[ITLB_MISSES.WALK_DURATION]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ITLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorITLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="locatorDSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsbtomiteswitchcost_dsbtomiteswitchcostdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( $useCountingMode ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[DSB2MITE_SWITCHES.PENALTY_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.THREAD]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DSBtoMITESwitchCost") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DSBtoMITESwitchCostIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDSBtoMITESwitchCost") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
</xsl:stylesheet>
