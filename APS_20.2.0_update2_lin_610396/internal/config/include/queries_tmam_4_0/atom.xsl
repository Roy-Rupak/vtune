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
                <derivedQuery displayName="%FrontendIssues" id="FrontendIssuesGridSection">
                    <valueEval>""</valueEval>
                    <valueType>string</valueType>
                    <displayAttributes>
                        <boolean:expand>true</boolean:expand>
                        <boolean:allowCollapse>false</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="FrontendIssuesGridGroup">
                            <queryRef>/ICacheMisses</queryRef>
                            <queryRef>/ITLBOverhead</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery displayName="%WastedWork" id="WastedWorkGridSection">
                    <valueEval>""</valueEval>
                    <valueType>string</valueType>
                    <displayAttributes>
                        <boolean:expand>true</boolean:expand>
                        <boolean:allowCollapse>false</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="WastedWorkGridGroup">
                            <queryRef>/BranchMispredict</queryRef>
                            <queryRef>/SMCMachineClear</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
                <derivedQuery displayName="%BackendIssues" id="BackendIssuesGridSection">
                    <valueEval>""</valueEval>
                    <valueType>string</valueType>
                    <displayAttributes>
                        <boolean:expand>true</boolean:expand>
                        <boolean:allowCollapse>false</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="BackendIssuesGridGroup">
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
                <derivedQuery id="RetiringuOpsGroup">
                    <queryInherit>/RetiringuOps</queryInherit>
                    <displayAttributes>
                        <boolean:expand>false</boolean:expand>
                        <boolean:allowCollapse>true</boolean:allowCollapse>
                    </displayAttributes>
                    <expand>
                        <vectorQuery id="RetiringuOpsGroupExpanded">
                            <queryRef>/MSAssists</queryRef>
                            <queryRef>/FPAssists</queryRef>
                            <queryRef>/SIMDAssists</queryRef>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <queryLibrary>
                <derivedQuery displayName="%ICacheMisses" id="ICacheMisses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[ICACHE.MISSES]") / query("/DerivedInstructionsRetired") ) ]]></valueEval>
                    <issueText>%ICacheMissesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/ICacheMisses") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ICACHE.MISSES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 6 * query("/PMUEventCount/PMUEventType[ITLB.MISSES]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/ITLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[ITLB.MISSES]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 14 * query("/PMUEventCount/PMUEventType[BR_INST_RETIRED.MISPRED.PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/BranchMispredict") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_INST_RETIRED.MISPRED.PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SMCMachineClear" id="SMCMachineClear">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SMCMachineClearDescriptionAll</description>
                    <helpKeyword>configs.smcmachineclear_smcmachinecleardescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 14 * query("/PMUEventCount/PMUEventType[MACHINE_CLEARS.SMC]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SMCMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/SMCMachineClear") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMiss" id="LLCMiss">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCMissDescriptionAll</description>
                    <helpKeyword>configs.llcmiss_llcmissdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 230 * query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L2_MISS.PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCMissIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/LLCMiss") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_MISS.PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCHit" id="LLCHit">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LLCHitDescriptionAll</description>
                    <helpKeyword>configs.llchit_llchitdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 12 * query("/PMUEventCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT.PS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LLCHitIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/LLCHit") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT.PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="DTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 10 * query("/PMUEventCount/PMUEventType[DATA_TLB_MISSES.DTLB_MISS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DTLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/DTLBOverhead") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[DATA_TLB_MISSES.DTLB_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="ContestedAccesses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 150 * query("/PMUEventCount/PMUEventType[EXT_SNOOP.ALL_AGENTS.HITM]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%ContestedAccessesIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/ContestedAccesses") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[EXT_SNOOP.ALL_AGENTS.HITM]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%PageWalk" id="PageWalk">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PageWalkDescriptionAll</description>
                    <helpKeyword>configs.pagewalk_pagewalkdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[PAGE_WALKS.CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%PageWalkIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/PageWalk") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%BusLock" id="BusLock">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BusLockDescriptionAll</description>
                    <helpKeyword>configs.buslock_buslockdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 20 * query("/PMUEventCount/PMUEventType[BUS_LOCK_CLOCKS.ALL_AGENTS]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%BusLockIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/BusLock") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BUS_LOCK_CLOCKS.ALL_AGENTS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 15 * query("/PMUEventCount/PMUEventType[MISALIGN_MEM_REF.LD_SPLIT.AR]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SplitLoadsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/SplitLoads") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MISALIGN_MEM_REF.LD_SPLIT.AR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 15 * query("/PMUEventCount/PMUEventType[MISALIGN_MEM_REF.ST_SPLIT.AR]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%SplitStoresIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/SplitStores") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MISALIGN_MEM_REF.ST_SPLIT.AR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( ( 9 * query("/PMUEventCount/PMUEventType[REISSUE.OVERLAP_STORE.AR]") ) / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%LoadsBlockedbyStoreForwardingIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/LoadsBlockedbyStoreForwarding") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REISSUE.OVERLAP_STORE.AR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[CYCLES_DIV_BUSY]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/DIVActive") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CYCLES_DIV_BUSY]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%RetiringuOps" id="RetiringuOps">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RetiringuOpsDescriptionAll</description>
                    <helpKeyword>configs.retiringuops_retiringuopsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS_RETIRED.ANY]") / ( 2 * query("/DerivedClockticks") ) ) ]]></valueEval>
                    <issueText>%RetiringuOpsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( query("/RetiringuOps") <= 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ANY]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%MSAssists" id="MSAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSAssistsDescriptionAll</description>
                    <helpKeyword>configs.msassists_msassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[UOPS.MS_CYCLES]") / query("/DerivedClockticks") ) ]]></valueEval>
                    <issueText>%MSAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/MSAssists") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiringuOps") <= 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS.MS_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%FPAssists" id="FPAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FPAssistsDescriptionAll</description>
                    <helpKeyword>configs.fpassists_fpassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[FP_ASSIST.S]") / query("/DerivedInstructionsRetired") ) ]]></valueEval>
                    <issueText>%FPAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/FPAssists") > 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiringuOps") <= 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[FP_ASSIST.S]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                </derivedQuery>
                <derivedQuery displayName="%SIMDAssists" id="SIMDAssists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SIMDAssistsDescriptionAll</description>
                    <helpKeyword>configs.simdassists_simdassistsdescriptionall</helpKeyword>
                    <valueEval>
                        <![CDATA[ ( query("/PMUEventCount/PMUEventType[SIMD_ASSIST]") / query("/DerivedInstructionsRetired") ) ]]></valueEval>
                    <issueText>%SIMDAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( ( ( query("/SIMDAssists") > 0.01 ) && ( query("/PMUHotspot") > 0.05 ) ) ) && ( ( ( query("/RetiringuOps") <= 0.05 ) && ( query("/PMUHotspot") > 0.05 ) ) ) ) ]]></issueEval>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[SIMD_ASSIST]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                            <derivedQuery displayName="%FrontendIssues" id="locatorFrontendIssuesGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorFrontendIssuesGridGroup">
                                        <queryRef>/locatorICacheMisses</queryRef>
                                        <queryRef>/locatorITLBOverhead</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery displayName="%WastedWork" id="locatorWastedWorkGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorWastedWorkGridGroup">
                                        <queryRef>/locatorBranchMispredict</queryRef>
                                        <queryRef>/locatorSMCMachineClear</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery displayName="%BackendIssues" id="locatorBackendIssuesGridSection">
                                <valueEval>""</valueEval>
                                <valueType>string</valueType>
                                <displayAttributes>
                                    <boolean:expand>true</boolean:expand>
                                    <boolean:allowCollapse>false</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorBackendIssuesGridGroup">
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
                            <derivedQuery id="locatorRetiringuOpsGroup">
                                <queryInherit>/locatorRetiringuOps</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="locatorRetiringuOpsGroupExpanded">
                                        <queryRef>/locatorMSAssists</queryRef>
                                        <queryRef>/locatorFPAssists</queryRef>
                                        <queryRef>/locatorSIMDAssists</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <locatorqueryLibrary>
                <derivedQuery displayName="%ICacheMisses" id="locatorICacheMisses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[ICACHE.MISSES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[ITLB.MISSES]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/ITLBOverhead") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%ITLBOverheadIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorITLBOverhead") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="locatorBranchMispredict">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BR_INST_RETIRED.MISPRED.PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/BranchMispredict") * query("/SLOTS")) / queryAll("/SLOTS", true) ) ]]></valueEval>
                    <issueText>%BranchMispredictIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorBranchMispredict") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SMCMachineClear" id="locatorSMCMachineClear">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SMCMachineClearDescriptionAll</description>
                    <helpKeyword>configs.smcmachineclear_smcmachinecleardescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MACHINE_CLEARS.SMC]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SMCMachineClear") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SMCMachineClearIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSMCMachineClear") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%LLCMiss" id="locatorLLCMiss">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LLCMissDescriptionAll</description>
                    <helpKeyword>configs.llcmiss_llcmissdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_MISS.PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MEM_LOAD_RETIRED.L2_HIT.PS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[DATA_TLB_MISSES.DTLB_MISS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[EXT_SNOOP.ALL_AGENTS.HITM]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[PAGE_WALKS.CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[BUS_LOCK_CLOCKS.ALL_AGENTS]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MISALIGN_MEM_REF.LD_SPLIT.AR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[MISALIGN_MEM_REF.ST_SPLIT.AR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( (  ( query("/PMUSampleCount/PMUEventType[REISSUE.OVERLAP_STORE.AR]") >= 10 ) ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[CYCLES_DIV_BUSY]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/DIVActive") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%DIVActiveIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorDIVActive") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%RetiringuOps" id="locatorRetiringuOps">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RetiringuOpsDescriptionAll</description>
                    <helpKeyword>configs.retiringuops_retiringuopsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS_RETIRED.ANY]") >= 10 ) && (  ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/RetiringuOps") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%RetiringuOpsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorRetiringuOps") <= 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%MSAssists" id="locatorMSAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MSAssistsDescriptionAll</description>
                    <helpKeyword>configs.msassists_msassistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[UOPS.MS_CYCLES]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
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
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[FP_ASSIST.S]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/FPAssists") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%FPAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorFPAssists") > 0.05 ) ) ]]></issueEval>
                </derivedQuery>
                <derivedQuery displayName="%SIMDAssists" id="locatorSIMDAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SIMDAssistsDescriptionAll</description>
                    <helpKeyword>configs.simdassists_simdassistsdescriptionall</helpKeyword>
                    <confidenceEval>
                        <![CDATA[ ( ( ($useCountingMode || $useAggregatedCounting) ? $TRUE : ( ( ( query("/PMUSampleCount/PMUEventType[SIMD_ASSIST]") >= 10 ) && ( query("/PMUSampleCount/PMUEventType[CPU_CLK_UNHALTED.CORE]") >= 10 ) ) ) ) && ( query("/Reliability") >= 0.5 ) && ( $shortCollectionMux ? $FALSE : $TRUE )) ]]></confidenceEval>
                    <valueEval>
                        <![CDATA[ ( (query("/SIMDAssists") * query("/DerivedClockticks")) / queryAll("/DerivedClockticks", true) ) ]]></valueEval>
                    <issueText>%SIMDAssistsIssueTextAll</issueText>
                    <issueEval>
                        <![CDATA[ ( ( query("/locatorSIMDAssists") > 0.01 ) ) ]]></issueEval>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
    <xsl:variable name="is3DXOn" select="exsl:ctx('is3DXPPresent', 0) and not(exsl:ctx('is3DXP2LMMode', 0))" />
</xsl:stylesheet>
