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
                                        <queryRef>/BranchResteers</queryRef>
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
                                                    <queryRef>/Cycles0PortsUtilized</queryRef>
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
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
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
            </vectorQuery>
            <queryLibrary>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="FrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontend_bound_pipeline_slots_f1018</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FELatency" id="FELatency">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FELatencyDescriptionAll</description>
                    <helpKeyword>configs.front_end_latency_f1082</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="ICacheMisses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icache_misses_f1019</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlb_overhead_f1023</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="BranchResteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branch_resteers_f1338</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="DSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsb_to_mite_f1012</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LCP" id="LCP">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LCPDescriptionAll</description>
                    <helpKeyword>configs.length_changing_prefixes_f1066</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MSSwitches" id="MSSwitches">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSSwitchesDescriptionAll</description>
                    <helpKeyword>configs.ms_switches_f1357</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="FEBandwidth">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.front_end_bandwidth_f1062</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthMITE" id="FEBandwidthMITE">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FEBandwidthMITEDescriptionAll</description>
                    <helpKeyword>configs.bandwidth_mite_f1079</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDSB" id="FEBandwidthDSB">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FEBandwidthDSBDescriptionAll</description>
                    <helpKeyword>configs.bandwidth_dsb_f1076</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthLSD" id="FEBandwidthLSD">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FEBandwidthLSDDescriptionAll</description>
                    <helpKeyword>configs.front_end_bandwidth_lsd_f1420</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="CancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelled_pipeline_slots_f1007</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branch_mispredict_f1005</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="MachineClears">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machine_clears_f1036</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="BackendBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.back_end_bound_f1056</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="MemBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.memory_bound_f1070</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L1Bound" id="L1Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L1BoundDescriptionAll</description>
                    <helpKeyword>configs.l1_bound_f1064</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="DTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlb_overhead_f1013</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loads_blocked_f1034</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LockLatency" id="LockLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LockLatencyDescriptionAll</description>
                    <helpKeyword>configs.lock_latency_f1419</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.split_loads_f1093</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="4KAliasing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4k_aliasing_f1002</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FBFull" id="FBFull">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FBFullDescriptionAll</description>
                    <helpKeyword>configs.fb_full_f1424</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L2Bound" id="L2Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L2BoundDescriptionAll</description>
                    <helpKeyword>configs.l2_bound_f1063</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Bound" id="L3Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L3BoundDescriptionAll</description>
                    <helpKeyword>configs.l3_bound_f1065</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="ContestedAccesses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contested_accesses_f1009</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="DataSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.data_sharing_f1010</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Latency" id="L3Latency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L3LatencyDescriptionAll</description>
                    <helpKeyword>configs.l3_latency_f1125</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SQFull" id="SQFull">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SQFullDescriptionAll</description>
                    <helpKeyword>configs.sq_full_f1380</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DRAMBound" id="DRAMBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.dram_bound_f1058</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMBandwidth" id="MEMBandwidth">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MEMBandwidthDescriptionAll</description>
                    <helpKeyword>configs.memory_bandwidth_f1067</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMLatency" id="MEMLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MEMLatencyDescriptionAll</description>
                    <helpKeyword>configs.memory_latency_f1038</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LocalDRAM" id="LocalDRAM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LocalDRAMDescriptionAll</description>
                    <helpKeyword>configs.local_dram_f1401</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteDRAM" id="RemoteDRAM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RemoteDRAMDescriptionAll</description>
                    <helpKeyword>configs.remote_dram_f1410</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteCache" id="RemoteCache">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RemoteCacheDescriptionAll</description>
                    <helpKeyword>configs.remote_cache_f1412</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoresBound" id="StoresBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%StoresBoundDescriptionAll</description>
                    <helpKeyword>configs.store_bound_f1084</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoreLatency" id="StoreLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%StoreLatencyDescriptionAll</description>
                    <helpKeyword>configs.store_latency_f1425</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FalseSharing" id="FalseSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FalseSharingDescriptionAll</description>
                    <helpKeyword>configs.false_sharing_f1061</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.split_stores_f1054</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBStoreOverhead" id="DTLBStoreOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBStoreOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlb_store_overhead_f1057</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="CoreBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.core_bound_f1060</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.div_active_f1059</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PortUtil" id="PortUtil">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PortUtilDescriptionAll</description>
                    <helpKeyword>configs.port_utilization_f1083</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles0PortsUtilized" id="Cycles0PortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles0PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_0_ports_utilized_f1377</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles1PortUtilized" id="Cycles1PortUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles1PortUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_1_port_utilized_f1359</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles2PortsUtilized" id="Cycles2PortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles2PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_2_ports_utilized_f1360</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles3mPortsUtilized" id="Cycles3mPortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles3mPortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_3__ports_utilized_f1351</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port0" id="Port0">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port0DescriptionAll</description>
                    <helpKeyword>configs.port_0_f1409</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port1" id="Port1">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port1DescriptionAll</description>
                    <helpKeyword>configs.port_1_f1408</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port2" id="Port2">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port2DescriptionAll</description>
                    <helpKeyword>configs.port_2_f1407</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port3" id="Port3">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port3DescriptionAll</description>
                    <helpKeyword>configs.port_3_f1406</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port4" id="Port4">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port4DescriptionAll</description>
                    <helpKeyword>configs.port_4_f1405</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port5" id="Port5">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port5DescriptionAll</description>
                    <helpKeyword>configs.port_5_f1404</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port6" id="Port6">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port6DescriptionAll</description>
                    <helpKeyword>configs.port_6_f1403</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port7" id="Port7">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Port7DescriptionAll</description>
                    <helpKeyword>configs.port_7_f1402</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RetiredPipelineSlots" id="RetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retired_pipleine_slots_f1050</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BASE" id="BASE">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BASEDescriptionAll</description>
                    <helpKeyword>configs.general_retirement_f1071</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Arith" id="FP_Arith">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_ArithDescriptionAll</description>
                    <helpKeyword>configs.fp_arithmetic_f1431</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_x87" id="FP_x87">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_x87DescriptionAll</description>
                    <helpKeyword>configs.fp_x87_f1436</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Scalar" id="FP_Scalar">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_ScalarDescriptionAll</description>
                    <helpKeyword>configs.fp_scalar_f1433</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Vector" id="FP_Vector">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_VectorDescriptionAll</description>
                    <helpKeyword>configs.fp_vector_f1399</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="OTHER">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>-</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="MicroSequencer">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.mocrocode_sequencer_f1085</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="Assists">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_f1003</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SLOTS" id="SLOTS">
                    <description>%SLOTSDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%CORE_CLKS" id="CORE_CLKS">
                    <description>%CORE_CLKSDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Load_Miss_Real_Latency" id="Load_Miss_Real_Latency">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Load_Miss_Real_LatencyDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Recovery_Cycles" id="Recovery_Cycles">
                    <description>%Recovery_CyclesDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%L2_Bound_Fraction" id="L2_Bound_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%L2_Bound_FractionDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%SQ_Full_Cycles" id="SQ_Full_Cycles">
                    <description>%SQ_Full_CyclesDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_0_Ports_Utilized" id="Cycles_0_Ports_Utilized">
                    <description>%Cycles_0_Ports_UtilizedDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_1_Port_Utilized" id="Cycles_1_Port_Utilized">
                    <description>%Cycles_1_Port_UtilizedDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_2_Ports_Utilized" id="Cycles_2_Ports_Utilized">
                    <description>%Cycles_2_Ports_UtilizedDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Cycles_3m_Ports_Utilized" id="Cycles_3m_Ports_Utilized">
                    <description>%Cycles_3m_Ports_UtilizedDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_Any_Cycles" id="ORO_DRD_Any_Cycles">
                    <description>%ORO_DRD_Any_CyclesDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_BW_Cycles" id="ORO_DRD_BW_Cycles">
                    <description>%ORO_DRD_BW_CyclesDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%ORO_Demand_RFO_C1" id="ORO_Demand_RFO_C1">
                    <description>%ORO_Demand_RFO_C1DescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Store_L2_Hit_Cycles" id="Store_L2_Hit_Cycles">
                    <description>%Store_L2_Hit_CyclesDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L1_MISS_CLT" id="LOAD_L1_MISS_CLT">
                    <description>%LOAD_L1_MISS_CLTDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L1_MISS_NET" id="LOAD_L1_MISS_NET">
                    <description>%LOAD_L1_MISS_NETDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L2_HIT" id="LOAD_L2_HIT">
                    <description>%LOAD_L2_HITDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L3_HIT" id="LOAD_L3_HIT">
                    <description>%LOAD_L3_HITDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HIT" id="LOAD_XSNP_HIT">
                    <description>%LOAD_XSNP_HITDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HITM" id="LOAD_XSNP_HITM">
                    <description>%LOAD_XSNP_HITMDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_MISS" id="LOAD_XSNP_MISS">
                    <description>%LOAD_XSNP_MISSDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_MEM" id="LOAD_LCL_MEM">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_LCL_MEMDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_MEM" id="LOAD_RMT_MEM">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_RMT_MEMDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_HITM" id="LOAD_RMT_HITM">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_RMT_HITMDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_FWD" id="LOAD_RMT_FWD">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LOAD_RMT_FWDDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Few_Uops_Executed_Threshold" id="Few_Uops_Executed_Threshold">
                    <description>%Few_Uops_Executed_ThresholdDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Backend_Bound_Cycles" id="Backend_Bound_Cycles">
                    <description>%Backend_Bound_CyclesDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Memory_Bound_Fraction" id="Memory_Bound_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Memory_Bound_FractionDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Lock_St_Fraction" id="Mem_Lock_St_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Lock_St_FractionDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mispred_Clears_Fraction" id="Mispred_Clears_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mispred_Clears_FractionDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Retire_Uop_Fraction" id="Retire_Uop_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Retire_Uop_FractionDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Pipeline_Width" id="Pipeline_Width">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Pipeline_WidthDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_L2_Store_Cost" id="Mem_L2_Store_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_L2_Store_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_STLB_Hit_Cost" id="Mem_STLB_Hit_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_STLB_Hit_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_4K_Alias_Cost" id="Mem_4K_Alias_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_4K_Alias_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_XSNP_HitM_Cost" id="Mem_XSNP_HitM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_XSNP_HitM_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_Hit_Cost" id="MEM_XSNP_Hit_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_XSNP_Hit_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_None_Cost" id="MEM_XSNP_None_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_XSNP_None_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Local_DRAM_Cost" id="Mem_Local_DRAM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Local_DRAM_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_DRAM_Cost" id="Mem_Remote_DRAM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_DRAM_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_HitM_Cost" id="Mem_Remote_HitM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_HitM_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_Fwd_Cost" id="Mem_Remote_Fwd_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_Fwd_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%MS_Switches_Cost" id="MS_Switches_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MS_Switches_CostDescriptionAll</description>
                </derivedQuery>
                <derivedQuery displayName="%SMT_on" id="SMT_on">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%SMT_onDescriptionAll</description>
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
                                                    <queryRef>/locatorBranchResteers</queryRef>
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
                                                                <queryRef>/locatorCycles0PortsUtilized</queryRef>
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
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
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
                        </vectorQuery>
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <locatorqueryLibrary>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="locatorFrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontend_bound_pipeline_slots_f1018</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FELatency" id="locatorFELatency">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FELatencyDescriptionAll</description>
                    <helpKeyword>configs.front_end_latency_f1082</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="locatorICacheMisses">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icache_misses_f1019</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="locatorITLBOverhead">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlb_overhead_f1023</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="locatorBranchResteers">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branch_resteers_f1338</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="locatorDSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsb_to_mite_f1012</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LCP" id="locatorLCP">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%LCPDescriptionAll</description>
                    <helpKeyword>configs.length_changing_prefixes_f1066</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MSSwitches" id="locatorMSSwitches">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%MSSwitchesDescriptionAll</description>
                    <helpKeyword>configs.ms_switches_f1357</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="locatorFEBandwidth">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.front_end_bandwidth_f1062</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthMITE" id="locatorFEBandwidthMITE">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FEBandwidthMITEDescriptionAll</description>
                    <helpKeyword>configs.bandwidth_mite_f1079</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDSB" id="locatorFEBandwidthDSB">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FEBandwidthDSBDescriptionAll</description>
                    <helpKeyword>configs.bandwidth_dsb_f1076</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthLSD" id="locatorFEBandwidthLSD">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FEBandwidthLSDDescriptionAll</description>
                    <helpKeyword>configs.front_end_bandwidth_lsd_f1420</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="locatorCancelledPipelineSlots">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelled_pipeline_slots_f1007</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="locatorBranchMispredict">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branch_mispredict_f1005</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="locatorMachineClears">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machine_clears_f1036</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="locatorBackendBound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.back_end_bound_f1056</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="locatorMemBound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.memory_bound_f1070</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L1Bound" id="locatorL1Bound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%L1BoundDescriptionAll</description>
                    <helpKeyword>configs.l1_bound_f1064</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="locatorDTLBOverhead">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlb_overhead_f1013</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="locatorLoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loads_blocked_f1034</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LockLatency" id="locatorLockLatency">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%LockLatencyDescriptionAll</description>
                    <helpKeyword>configs.lock_latency_f1419</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="locatorSplitLoads">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.split_loads_f1093</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="locator4KAliasing">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4k_aliasing_f1002</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FBFull" id="locatorFBFull">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FBFullDescriptionAll</description>
                    <helpKeyword>configs.fb_full_f1424</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L2Bound" id="locatorL2Bound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%L2BoundDescriptionAll</description>
                    <helpKeyword>configs.l2_bound_f1063</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Bound" id="locatorL3Bound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%L3BoundDescriptionAll</description>
                    <helpKeyword>configs.l3_bound_f1065</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="locatorContestedAccesses">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contested_accesses_f1009</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="locatorDataSharing">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.data_sharing_f1010</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Latency" id="locatorL3Latency">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%L3LatencyDescriptionAll</description>
                    <helpKeyword>configs.l3_latency_f1125</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SQFull" id="locatorSQFull">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%SQFullDescriptionAll</description>
                    <helpKeyword>configs.sq_full_f1380</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DRAMBound" id="locatorDRAMBound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.dram_bound_f1058</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMBandwidth" id="locatorMEMBandwidth">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%MEMBandwidthDescriptionAll</description>
                    <helpKeyword>configs.memory_bandwidth_f1067</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMLatency" id="locatorMEMLatency">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%MEMLatencyDescriptionAll</description>
                    <helpKeyword>configs.memory_latency_f1038</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LocalDRAM" id="locatorLocalDRAM">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%LocalDRAMDescriptionAll</description>
                    <helpKeyword>configs.local_dram_f1401</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteDRAM" id="locatorRemoteDRAM">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%RemoteDRAMDescriptionAll</description>
                    <helpKeyword>configs.remote_dram_f1410</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteCache" id="locatorRemoteCache">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%RemoteCacheDescriptionAll</description>
                    <helpKeyword>configs.remote_cache_f1412</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoresBound" id="locatorStoresBound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%StoresBoundDescriptionAll</description>
                    <helpKeyword>configs.store_bound_f1084</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoreLatency" id="locatorStoreLatency">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%StoreLatencyDescriptionAll</description>
                    <helpKeyword>configs.store_latency_f1425</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FalseSharing" id="locatorFalseSharing">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FalseSharingDescriptionAll</description>
                    <helpKeyword>configs.false_sharing_f1061</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="locatorSplitStores">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.split_stores_f1054</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBStoreOverhead" id="locatorDTLBStoreOverhead">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%DTLBStoreOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlb_store_overhead_f1057</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="locatorCoreBound">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.core_bound_f1060</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="locatorDIVActive">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.div_active_f1059</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PortUtil" id="locatorPortUtil">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%PortUtilDescriptionAll</description>
                    <helpKeyword>configs.port_utilization_f1083</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles0PortsUtilized" id="locatorCycles0PortsUtilized">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Cycles0PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_0_ports_utilized_f1377</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles1PortUtilized" id="locatorCycles1PortUtilized">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Cycles1PortUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_1_port_utilized_f1359</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles2PortsUtilized" id="locatorCycles2PortsUtilized">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Cycles2PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_2_ports_utilized_f1360</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles3mPortsUtilized" id="locatorCycles3mPortsUtilized">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Cycles3mPortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles_of_3__ports_utilized_f1351</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port0" id="locatorPort0">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port0DescriptionAll</description>
                    <helpKeyword>configs.port_0_f1409</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port1" id="locatorPort1">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port1DescriptionAll</description>
                    <helpKeyword>configs.port_1_f1408</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port2" id="locatorPort2">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port2DescriptionAll</description>
                    <helpKeyword>configs.port_2_f1407</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port3" id="locatorPort3">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port3DescriptionAll</description>
                    <helpKeyword>configs.port_3_f1406</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port4" id="locatorPort4">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port4DescriptionAll</description>
                    <helpKeyword>configs.port_4_f1405</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port5" id="locatorPort5">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port5DescriptionAll</description>
                    <helpKeyword>configs.port_5_f1404</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port6" id="locatorPort6">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port6DescriptionAll</description>
                    <helpKeyword>configs.port_6_f1403</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port7" id="locatorPort7">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%Port7DescriptionAll</description>
                    <helpKeyword>configs.port_7_f1402</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RetiredPipelineSlots" id="locatorRetiredPipelineSlots">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retired_pipleine_slots_f1050</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BASE" id="locatorBASE">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%BASEDescriptionAll</description>
                    <helpKeyword>configs.general_retirement_f1071</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Arith" id="locatorFP_Arith">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FP_ArithDescriptionAll</description>
                    <helpKeyword>configs.fp_arithmetic_f1431</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_x87" id="locatorFP_x87">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FP_x87DescriptionAll</description>
                    <helpKeyword>configs.fp_x87_f1436</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Scalar" id="locatorFP_Scalar">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FP_ScalarDescriptionAll</description>
                    <helpKeyword>configs.fp_scalar_f1433</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Vector" id="locatorFP_Vector">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%FP_VectorDescriptionAll</description>
                    <helpKeyword>configs.fp_vector_f1399</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="locatorOTHER">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>-</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="locatorMicroSequencer">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.mocrocode_sequencer_f1085</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="locatorAssists">
                    <queryInherit>/GeMetricBasePercentage</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_f1003</helpKeyword>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
</xsl:stylesheet>
