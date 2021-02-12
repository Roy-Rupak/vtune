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
                                                    <derivedQuery id="DTLBOverheadGroup">
                                                        <queryInherit>/DTLBOverhead</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="DTLBOverheadGroupExpanded">
                                                                <queryRef>/Load_STLB_Hit</queryRef>
                                                                <queryRef>/Load_STLB_Miss</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
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
                                            <queryRef>/IXP_Bound</queryRef>
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
                                                    <derivedQuery id="DTLBStoreOverheadGroup">
                                                        <queryInherit>/DTLBStoreOverhead</queryInherit>
                                                        <displayAttributes>
                                                            <boolean:expand>false</boolean:expand>
                                                            <boolean:allowCollapse>true</boolean:allowCollapse>
                                                        </displayAttributes>
                                                        <expand>
                                                            <vectorQuery id="DTLBStoreOverheadGroupExpanded">
                                                                <queryRef>/Store_STLB_Hit</queryRef>
                                                                <queryRef>/Store_STLB_Miss</queryRef>
                                                            </vectorQuery>
                                                        </expand>
                                                    </derivedQuery>
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
                                                                <derivedQuery id="ALU_Op_UtilizationGroup">
                                                                    <queryInherit>/ALU_Op_Utilization</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="ALU_Op_UtilizationGroupExpanded">
                                                                            <queryRef>/Port0</queryRef>
                                                                            <queryRef>/Port1</queryRef>
                                                                            <queryRef>/Port5</queryRef>
                                                                            <queryRef>/Port6</queryRef>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
                                                                <derivedQuery id="Load_Op_UtilizationGroup">
                                                                    <queryInherit>/Load_Op_Utilization</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="Load_Op_UtilizationGroupExpanded" />
                                                                    </expand>
                                                                </derivedQuery>
                                                                <derivedQuery id="Store_Op_UtilizationGroup">
                                                                    <queryInherit>/Store_Op_Utilization</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="Store_Op_UtilizationGroupExpanded" />
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
                    </expand>
                </derivedQuery>
            </vectorQuery>
            <queryLibrary>
                <derivedQuery displayName="%RetiredPipelineSlots" id="RetiredPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%RetiredPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.retiredpipelineslots_retiredpipelineslotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BASE" id="BASE">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BASEDescriptionAll</description>
                    <helpKeyword>configs.base_basedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Arith" id="FP_Arith">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_ArithDescriptionAll</description>
                    <helpKeyword>configs.fp_arith_fp_arithdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_x87" id="FP_x87">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_x87DescriptionAll</description>
                    <helpKeyword>configs.fp_x87_fp_x87descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Scalar" id="FP_Scalar">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_ScalarDescriptionAll</description>
                    <helpKeyword>configs.fp_scalar_fp_scalardescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Vector" id="FP_Vector">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%FP_VectorDescriptionAll</description>
                    <helpKeyword>configs.fp_vector_fp_vectordescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="OTHER">
                    <queryInherit>/GeMetricBaseUops</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>configs.other_otherdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="MicroSequencer">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.microsequencer_microsequencerdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="Assists">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_assistsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="FrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FELatency" id="FELatency">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FELatencyDescriptionAll</description>
                    <helpKeyword>configs.felatency_felatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="ICacheMisses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="BranchResteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branchresteers_branchresteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mispredicts_Resteers" id="Mispredicts_Resteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Mispredicts_ResteersDescriptionAll</description>
                    <helpKeyword>configs.mispredicts_resteers_mispredicts_resteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Clears_Resteers" id="Clears_Resteers">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Clears_ResteersDescriptionAll</description>
                    <helpKeyword>configs.clears_resteers_clears_resteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Unknown_Branches" id="Unknown_Branches">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Unknown_BranchesDescriptionAll</description>
                    <helpKeyword>configs.unknown_branches_unknown_branchesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="DSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsbtomiteswitchcost_dsbtomiteswitchcostdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LCP" id="LCP">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LCPDescriptionAll</description>
                    <helpKeyword>configs.lcp_lcpdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MSSwitches" id="MSSwitches">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MSSwitchesDescriptionAll</description>
                    <helpKeyword>configs.msswitches_msswitchesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="FEBandwidth">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.febandwidth_febandwidthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthMITE" id="FEBandwidthMITE">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%FEBandwidthMITEDescriptionAll</description>
                    <helpKeyword>configs.febandwidthmite_febandwidthmitedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDSB" id="FEBandwidthDSB">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%FEBandwidthDSBDescriptionAll</description>
                    <helpKeyword>configs.febandwidthdsb_febandwidthdsbdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthLSD" id="FEBandwidthLSD">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%FEBandwidthLSDDescriptionAll</description>
                    <helpKeyword>configs.febandwidthlsd_febandwidthlsddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DSB_Coverage" id="DSB_Coverage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%DSB_CoverageDescriptionAll</description>
                    <helpKeyword>configs.dsb_coverage_dsb_coveragedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LSD_Coverage" id="LSD_Coverage">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%LSD_CoverageDescriptionAll</description>
                    <helpKeyword>configs.lsd_coverage_lsd_coveragedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="CancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="BranchMispredict">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="MachineClears">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machineclears_machineclearsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="BackendBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="MemBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.membound_membounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L1Bound" id="L1Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L1BoundDescriptionAll</description>
                    <helpKeyword>configs.l1bound_l1bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="DTLBOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_STLB_Hit" id="Load_STLB_Hit">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Load_STLB_HitDescriptionAll</description>
                    <helpKeyword>configs.load_stlb_hit_load_stlb_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_STLB_Miss" id="Load_STLB_Miss">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Load_STLB_MissDescriptionAll</description>
                    <helpKeyword>configs.load_stlb_miss_load_stlb_missdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="LoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LockLatency" id="LockLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LockLatencyDescriptionAll</description>
                    <helpKeyword>configs.locklatency_locklatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="SplitLoads">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="4KAliasing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4kaliasing_4kaliasingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FBFull" id="FBFull">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FBFullDescriptionAll</description>
                    <helpKeyword>configs.fbfull_fbfulldescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L2Bound" id="L2Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L2BoundDescriptionAll</description>
                    <helpKeyword>configs.l2bound_l2bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Bound" id="L3Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L3BoundDescriptionAll</description>
                    <helpKeyword>configs.l3bound_l3bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="ContestedAccesses">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="DataSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.datasharing_datasharingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Latency" id="L3Latency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%L3LatencyDescriptionAll</description>
                    <helpKeyword>configs.l3latency_l3latencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SQFull" id="SQFull">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%SQFullDescriptionAll</description>
                    <helpKeyword>configs.sqfull_sqfulldescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DRAMBound" id="DRAMBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.drambound_drambounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMBandwidth" id="MEMBandwidth">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MEMBandwidthDescriptionAll</description>
                    <helpKeyword>configs.membandwidth_membandwidthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMLatency" id="MEMLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MEMLatencyDescriptionAll</description>
                    <helpKeyword>configs.memlatency_memlatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LocalDRAM" id="LocalDRAM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%LocalDRAMDescriptionAll</description>
                    <helpKeyword>configs.localdram_localdramdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteDRAM" id="RemoteDRAM">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RemoteDRAMDescriptionAll</description>
                    <helpKeyword>configs.remotedram_remotedramdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteCache" id="RemoteCache">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%RemoteCacheDescriptionAll</description>
                    <helpKeyword>configs.remotecache_remotecachedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%IXP_Bound" id="IXP_Bound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%IXP_BoundDescriptionAll</description>
                    <helpKeyword>configs.ixp_bound_ixp_bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoresBound" id="StoresBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%StoresBoundDescriptionAll</description>
                    <helpKeyword>configs.storesbound_storesbounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoreLatency" id="StoreLatency">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%StoreLatencyDescriptionAll</description>
                    <helpKeyword>configs.storelatency_storelatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FalseSharing" id="FalseSharing">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%FalseSharingDescriptionAll</description>
                    <helpKeyword>configs.falsesharing_falsesharingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="SplitStores">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBStoreOverhead" id="DTLBStoreOverhead">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DTLBStoreOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlbstoreoverhead_dtlbstoreoverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_STLB_Hit" id="Store_STLB_Hit">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Store_STLB_HitDescriptionAll</description>
                    <helpKeyword>configs.store_stlb_hit_store_stlb_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_STLB_Miss" id="Store_STLB_Miss">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Store_STLB_MissDescriptionAll</description>
                    <helpKeyword>configs.store_stlb_miss_store_stlb_missdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="CoreBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.corebound_corebounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="DIVActive">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PortUtil" id="PortUtil">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%PortUtilDescriptionAll</description>
                    <helpKeyword>configs.portutil_portutildescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles0PortsUtilized" id="Cycles0PortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles0PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles0portsutilized_cycles0portsutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Serializing_Operation" id="Serializing_Operation">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Serializing_OperationDescriptionAll</description>
                    <helpKeyword>configs.serializing_operation_serializing_operationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Slow_Pause" id="Slow_Pause">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Slow_PauseDescriptionAll</description>
                    <helpKeyword>configs.slow_pause_slow_pausedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles1PortUtilized" id="Cycles1PortUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles1PortUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles1portutilized_cycles1portutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles2PortsUtilized" id="Cycles2PortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles2PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles2portsutilized_cycles2portsutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles3mPortsUtilized" id="Cycles3mPortsUtilized">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%Cycles3mPortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles3mportsutilized_cycles3mportsutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ALU_Op_Utilization" id="ALU_Op_Utilization">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%ALU_Op_UtilizationDescriptionAll</description>
                    <helpKeyword>configs.alu_op_utilization_alu_op_utilizationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port0" id="Port0">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Port0DescriptionAll</description>
                    <helpKeyword>configs.port0_port0descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port1" id="Port1">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Port1DescriptionAll</description>
                    <helpKeyword>configs.port1_port1descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port5" id="Port5">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Port5DescriptionAll</description>
                    <helpKeyword>configs.port5_port5descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port6" id="Port6">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Port6DescriptionAll</description>
                    <helpKeyword>configs.port6_port6descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_Op_Utilization" id="Load_Op_Utilization">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Load_Op_UtilizationDescriptionAll</description>
                    <helpKeyword>configs.load_op_utilization_load_op_utilizationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_Op_Utilization" id="Store_Op_Utilization">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Store_Op_UtilizationDescriptionAll</description>
                    <helpKeyword>configs.store_op_utilization_store_op_utilizationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port4" id="Port4">
                    <valueEval>0</valueEval>
                </derivedQuery>
                <derivedQuery displayName="%SLOTS" id="SLOTS">
                    <description>%SLOTSDescriptionAll</description>
                    <helpKeyword>configs.slots_slotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CORE_CLKS" id="CORE_CLKS">
                    <description>%CORE_CLKSDescriptionAll</description>
                    <helpKeyword>configs.core_clks_core_clksdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_Miss_Real_Latency" id="Load_Miss_Real_Latency">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Load_Miss_Real_LatencyDescriptionAll</description>
                    <helpKeyword>configs.load_miss_real_latency_load_miss_real_latencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Fetched_Uops" id="Fetched_Uops">
                    <description>%Fetched_UopsDescriptionAll</description>
                    <helpKeyword>configs.fetched_uops_fetched_uopsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_Any_Cycles" id="ORO_DRD_Any_Cycles">
                    <description>%ORO_DRD_Any_CyclesDescriptionAll</description>
                    <helpKeyword>configs.oro_drd_any_cycles_oro_drd_any_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_BW_Cycles" id="ORO_DRD_BW_Cycles">
                    <description>%ORO_DRD_BW_CyclesDescriptionAll</description>
                    <helpKeyword>configs.oro_drd_bw_cycles_oro_drd_bw_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ORO_Demand_RFO_C1" id="ORO_Demand_RFO_C1">
                    <description>%ORO_Demand_RFO_C1DescriptionAll</description>
                    <helpKeyword>configs.oro_demand_rfo_c1_oro_demand_rfo_c1descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_L2_Hit_Cycles" id="Store_L2_Hit_Cycles">
                    <description>%Store_L2_Hit_CyclesDescriptionAll</description>
                    <helpKeyword>configs.store_l2_hit_cycles_store_l2_hit_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L1_MISS_NET" id="LOAD_L1_MISS_NET">
                    <description>%LOAD_L1_MISS_NETDescriptionAll</description>
                    <helpKeyword>configs.load_l1_miss_net_load_l1_miss_netdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L2_HIT" id="LOAD_L2_HIT">
                    <description>%LOAD_L2_HITDescriptionAll</description>
                    <helpKeyword>configs.load_l2_hit_load_l2_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L3_HIT" id="LOAD_L3_HIT">
                    <description>%LOAD_L3_HITDescriptionAll</description>
                    <helpKeyword>configs.load_l3_hit_load_l3_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HIT" id="LOAD_XSNP_HIT">
                    <description>%LOAD_XSNP_HITDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_hit_load_xsnp_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HITM" id="LOAD_XSNP_HITM">
                    <description>%LOAD_XSNP_HITMDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_hitm_load_xsnp_hitmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_MISS" id="LOAD_XSNP_MISS">
                    <description>%LOAD_XSNP_MISSDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_miss_load_xsnp_missdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_MEM" id="LOAD_LCL_MEM">
                    <description>%LOAD_LCL_MEMDescriptionAll</description>
                    <helpKeyword>configs.load_lcl_mem_load_lcl_memdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_PMM" id="LOAD_LCL_PMM">
                    <description>%LOAD_LCL_PMMDescriptionAll</description>
                    <helpKeyword>configs.load_lcl_pmm_load_lcl_pmmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_PMM" id="LOAD_RMT_PMM">
                    <description>%LOAD_RMT_PMMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_pmm_load_rmt_pmmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_MEM" id="LOAD_RMT_MEM">
                    <description>%LOAD_RMT_MEMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_mem_load_rmt_memdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_HITM" id="LOAD_RMT_HITM">
                    <description>%LOAD_RMT_HITMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_hitm_load_rmt_hitmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_FWD" id="LOAD_RMT_FWD">
                    <description>%LOAD_RMT_FWDDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_fwd_load_rmt_fwddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Few_Uops_Executed_Threshold" id="Few_Uops_Executed_Threshold">
                    <description>%Few_Uops_Executed_ThresholdDescriptionAll</description>
                    <helpKeyword>configs.few_uops_executed_threshold_few_uops_executed_thresholddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Core_Bound_Cycles" id="Core_Bound_Cycles">
                    <description>%Core_Bound_CyclesDescriptionAll</description>
                    <helpKeyword>configs.core_bound_cycles_core_bound_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Backend_Bound_Cycles" id="Backend_Bound_Cycles">
                    <description>%Backend_Bound_CyclesDescriptionAll</description>
                    <helpKeyword>configs.backend_bound_cycles_backend_bound_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Memory_Bound_Fraction" id="Memory_Bound_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Memory_Bound_FractionDescriptionAll</description>
                    <helpKeyword>configs.memory_bound_fraction_memory_bound_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L2_Bound_Ratio" id="L2_Bound_Ratio">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%L2_Bound_RatioDescriptionAll</description>
                    <helpKeyword>configs.l2_bound_ratio_l2_bound_ratiodescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEM_Bound_Ratio" id="MEM_Bound_Ratio">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_Bound_RatioDescriptionAll</description>
                    <helpKeyword>configs.mem_bound_ratio_mem_bound_ratiodescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_DDR_Hit_Fraction" id="Mem_DDR_Hit_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_DDR_Hit_FractionDescriptionAll</description>
                    <helpKeyword>configs.mem_ddr_hit_fraction_mem_ddr_hit_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Lock_St_Fraction" id="Mem_Lock_St_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Lock_St_FractionDescriptionAll</description>
                    <helpKeyword>configs.mem_lock_st_fraction_mem_lock_st_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mispred_Clears_Fraction" id="Mispred_Clears_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mispred_Clears_FractionDescriptionAll</description>
                    <helpKeyword>configs.mispred_clears_fraction_mispred_clears_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Retire_Fraction" id="Retire_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Retire_FractionDescriptionAll</description>
                    <helpKeyword>configs.retire_fraction_retire_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%True_XSNP_HitM_Fraction" id="True_XSNP_HitM_Fraction">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%True_XSNP_HitM_FractionDescriptionAll</description>
                    <helpKeyword>configs.true_xsnp_hitm_fraction_true_xsnp_hitm_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Pipeline_Width" id="Pipeline_Width">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Pipeline_WidthDescriptionAll</description>
                    <helpKeyword>configs.pipeline_width_pipeline_widthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_L2_Store_Cost" id="Mem_L2_Store_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_L2_Store_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_l2_store_cost_mem_l2_store_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_STLB_Hit_Cost" id="Mem_STLB_Hit_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_STLB_Hit_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_stlb_hit_cost_mem_stlb_hit_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_XSNP_HitM_Cost" id="Mem_XSNP_HitM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_XSNP_HitM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_hitm_cost_mem_xsnp_hitm_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_Hit_Cost" id="MEM_XSNP_Hit_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_XSNP_Hit_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_hit_cost_mem_xsnp_hit_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_None_Cost" id="MEM_XSNP_None_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MEM_XSNP_None_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_none_cost_mem_xsnp_none_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Local_DRAM_Cost" id="Mem_Local_DRAM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Local_DRAM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_local_dram_cost_mem_local_dram_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_DRAM_Cost" id="Mem_Remote_DRAM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_DRAM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_dram_cost_mem_remote_dram_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_HitM_Cost" id="Mem_Remote_HitM_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_HitM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_hitm_cost_mem_remote_hitm_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_Fwd_Cost" id="Mem_Remote_Fwd_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Mem_Remote_Fwd_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_fwd_cost_mem_remote_fwd_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BAClear_Cost" id="BAClear_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%BAClear_CostDescriptionAll</description>
                    <helpKeyword>configs.baclear_cost_baclear_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MS_Switches_Cost" id="MS_Switches_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%MS_Switches_CostDescriptionAll</description>
                    <helpKeyword>configs.ms_switches_cost_ms_switches_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Avg_Assist_Cost" id="Avg_Assist_Cost">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%Avg_Assist_CostDescriptionAll</description>
                    <helpKeyword>configs.avg_assist_cost_avg_assist_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OneMillion" id="OneMillion">
                    <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                    <description>%OneMillionDescriptionAll</description>
                    <helpKeyword>configs.onemillion_onemilliondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Retired_Slots" id="Retired_Slots">
                    <description>%Retired_SlotsDescriptionAll</description>
                    <helpKeyword>configs.retired_slots_retired_slotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%UPC" id="UPC">
                    <description>%UPCDescriptionAll</description>
                    <helpKeyword>configs.upc_upcdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PMM_App_Direct" id="PMM_App_Direct">
                    <xsl:choose>
                        <xsl:when test="$is3DXOn">
                            <queryInherit>/GeMetricBasePercentageNotClockticks</queryInherit>
                            <description>%PMM_App_DirectDescriptionAll</description>
                            <helpKeyword>configs.pmm_app_direct_pmm_app_directdescriptionall</helpKeyword>
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
                                                                <derivedQuery id="locatorDTLBOverheadGroup">
                                                                    <queryInherit>/locatorDTLBOverhead</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="locatorDTLBOverheadGroupExpanded">
                                                                            <queryRef>/locatorLoad_STLB_Hit</queryRef>
                                                                            <queryRef>/locatorLoad_STLB_Miss</queryRef>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
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
                                                        <queryRef>/locatorIXP_Bound</queryRef>
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
                                                                <derivedQuery id="locatorDTLBStoreOverheadGroup">
                                                                    <queryInherit>/locatorDTLBStoreOverhead</queryInherit>
                                                                    <displayAttributes>
                                                                        <boolean:expand>false</boolean:expand>
                                                                        <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                    </displayAttributes>
                                                                    <expand>
                                                                        <vectorQuery id="locatorDTLBStoreOverheadGroupExpanded">
                                                                            <queryRef>/locatorStore_STLB_Hit</queryRef>
                                                                            <queryRef>/locatorStore_STLB_Miss</queryRef>
                                                                        </vectorQuery>
                                                                    </expand>
                                                                </derivedQuery>
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
                                                                            <derivedQuery id="locatorALU_Op_UtilizationGroup">
                                                                                <queryInherit>/locatorALU_Op_Utilization</queryInherit>
                                                                                <displayAttributes>
                                                                                    <boolean:expand>false</boolean:expand>
                                                                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                                </displayAttributes>
                                                                                <expand>
                                                                                    <vectorQuery id="locatorALU_Op_UtilizationGroupExpanded">
                                                                                        <queryRef>/locatorPort0</queryRef>
                                                                                        <queryRef>/locatorPort1</queryRef>
                                                                                        <queryRef>/locatorPort5</queryRef>
                                                                                        <queryRef>/locatorPort6</queryRef>
                                                                                    </vectorQuery>
                                                                                </expand>
                                                                            </derivedQuery>
                                                                            <derivedQuery id="locatorLoad_Op_UtilizationGroup">
                                                                                <queryInherit>/locatorLoad_Op_Utilization</queryInherit>
                                                                                <displayAttributes>
                                                                                    <boolean:expand>false</boolean:expand>
                                                                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                                </displayAttributes>
                                                                                <expand>
                                                                                    <vectorQuery id="locatorLoad_Op_UtilizationGroupExpanded" />
                                                                                </expand>
                                                                            </derivedQuery>
                                                                            <derivedQuery id="locatorStore_Op_UtilizationGroup">
                                                                                <queryInherit>/locatorStore_Op_Utilization</queryInherit>
                                                                                <displayAttributes>
                                                                                    <boolean:expand>false</boolean:expand>
                                                                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                                                                </displayAttributes>
                                                                                <expand>
                                                                                    <vectorQuery id="locatorStore_Op_UtilizationGroupExpanded" />
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
                </derivedQuery>
                <derivedQuery displayName="%BASE" id="locatorBASE">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BASEDescriptionAll</description>
                    <helpKeyword>configs.base_basedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Arith" id="locatorFP_Arith">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_ArithDescriptionAll</description>
                    <helpKeyword>configs.fp_arith_fp_arithdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_x87" id="locatorFP_x87">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_x87DescriptionAll</description>
                    <helpKeyword>configs.fp_x87_fp_x87descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Scalar" id="locatorFP_Scalar">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_ScalarDescriptionAll</description>
                    <helpKeyword>configs.fp_scalar_fp_scalardescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FP_Vector" id="locatorFP_Vector">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FP_VectorDescriptionAll</description>
                    <helpKeyword>configs.fp_vector_fp_vectordescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="locatorOTHER">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>configs.other_otherdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="locatorMicroSequencer">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.microsequencer_microsequencerdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Assists" id="locatorAssists">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%AssistsDescriptionAll</description>
                    <helpKeyword>configs.assists_assistsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FrontendBoundPipelineSlots" id="locatorFrontendBoundPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FrontendBoundPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.frontendboundpipelineslots_frontendboundpipelineslotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FELatency" id="locatorFELatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FELatencyDescriptionAll</description>
                    <helpKeyword>configs.felatency_felatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ICacheMisses" id="locatorICacheMisses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="locatorITLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="locatorBranchResteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branchresteers_branchresteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mispredicts_Resteers" id="locatorMispredicts_Resteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mispredicts_ResteersDescriptionAll</description>
                    <helpKeyword>configs.mispredicts_resteers_mispredicts_resteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Clears_Resteers" id="locatorClears_Resteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Clears_ResteersDescriptionAll</description>
                    <helpKeyword>configs.clears_resteers_clears_resteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Unknown_Branches" id="locatorUnknown_Branches">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Unknown_BranchesDescriptionAll</description>
                    <helpKeyword>configs.unknown_branches_unknown_branchesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DSBtoMITESwitchCost" id="locatorDSBtoMITESwitchCost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DSBtoMITESwitchCostDescriptionAll</description>
                    <helpKeyword>configs.dsbtomiteswitchcost_dsbtomiteswitchcostdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LCP" id="locatorLCP">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LCPDescriptionAll</description>
                    <helpKeyword>configs.lcp_lcpdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MSSwitches" id="locatorMSSwitches">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MSSwitchesDescriptionAll</description>
                    <helpKeyword>configs.msswitches_msswitchesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="locatorFEBandwidth">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.febandwidth_febandwidthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthMITE" id="locatorFEBandwidthMITE">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthMITEDescriptionAll</description>
                    <helpKeyword>configs.febandwidthmite_febandwidthmitedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDSB" id="locatorFEBandwidthDSB">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthDSBDescriptionAll</description>
                    <helpKeyword>configs.febandwidthdsb_febandwidthdsbdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthLSD" id="locatorFEBandwidthLSD">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthLSDDescriptionAll</description>
                    <helpKeyword>configs.febandwidthlsd_febandwidthlsddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DSB_Coverage" id="locatorDSB_Coverage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DSB_CoverageDescriptionAll</description>
                    <helpKeyword>configs.dsb_coverage_dsb_coveragedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LSD_Coverage" id="locatorLSD_Coverage">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LSD_CoverageDescriptionAll</description>
                    <helpKeyword>configs.lsd_coverage_lsd_coveragedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CancelledPipelineSlots" id="locatorCancelledPipelineSlots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CancelledPipelineSlotsDescriptionAll</description>
                    <helpKeyword>configs.cancelledpipelineslots_cancelledpipelineslotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchMispredict" id="locatorBranchMispredict">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchMispredictDescriptionAll</description>
                    <helpKeyword>configs.branchmispredict_branchmispredictdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MachineClears" id="locatorMachineClears">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MachineClearsDescriptionAll</description>
                    <helpKeyword>configs.machineclears_machineclearsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="locatorBackendBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="locatorMemBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.membound_membounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L1Bound" id="locatorL1Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L1BoundDescriptionAll</description>
                    <helpKeyword>configs.l1bound_l1bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBOverhead" id="locatorDTLBOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DTLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlboverhead_dtlboverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_STLB_Hit" id="locatorLoad_STLB_Hit">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Load_STLB_HitDescriptionAll</description>
                    <helpKeyword>configs.load_stlb_hit_load_stlb_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_STLB_Miss" id="locatorLoad_STLB_Miss">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Load_STLB_MissDescriptionAll</description>
                    <helpKeyword>configs.load_stlb_miss_load_stlb_missdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LoadsBlockedbyStoreForwarding" id="locatorLoadsBlockedbyStoreForwarding">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LoadsBlockedbyStoreForwardingDescriptionAll</description>
                    <helpKeyword>configs.loadsblockedbystoreforwarding_loadsblockedbystoreforwardingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LockLatency" id="locatorLockLatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LockLatencyDescriptionAll</description>
                    <helpKeyword>configs.locklatency_locklatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitLoads" id="locatorSplitLoads">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitLoadsDescriptionAll</description>
                    <helpKeyword>configs.splitloads_splitloadsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%4KAliasing" id="locator4KAliasing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%4KAliasingDescriptionAll</description>
                    <helpKeyword>configs.4kaliasing_4kaliasingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FBFull" id="locatorFBFull">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FBFullDescriptionAll</description>
                    <helpKeyword>configs.fbfull_fbfulldescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L2Bound" id="locatorL2Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L2BoundDescriptionAll</description>
                    <helpKeyword>configs.l2bound_l2bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Bound" id="locatorL3Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L3BoundDescriptionAll</description>
                    <helpKeyword>configs.l3bound_l3bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ContestedAccesses" id="locatorContestedAccesses">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ContestedAccessesDescriptionAll</description>
                    <helpKeyword>configs.contestedaccesses_contestedaccessesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DataSharing" id="locatorDataSharing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DataSharingDescriptionAll</description>
                    <helpKeyword>configs.datasharing_datasharingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L3Latency" id="locatorL3Latency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L3LatencyDescriptionAll</description>
                    <helpKeyword>configs.l3latency_l3latencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SQFull" id="locatorSQFull">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SQFullDescriptionAll</description>
                    <helpKeyword>configs.sqfull_sqfulldescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DRAMBound" id="locatorDRAMBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.drambound_drambounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMBandwidth" id="locatorMEMBandwidth">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEMBandwidthDescriptionAll</description>
                    <helpKeyword>configs.membandwidth_membandwidthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEMLatency" id="locatorMEMLatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEMLatencyDescriptionAll</description>
                    <helpKeyword>configs.memlatency_memlatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LocalDRAM" id="locatorLocalDRAM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LocalDRAMDescriptionAll</description>
                    <helpKeyword>configs.localdram_localdramdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteDRAM" id="locatorRemoteDRAM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RemoteDRAMDescriptionAll</description>
                    <helpKeyword>configs.remotedram_remotedramdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%RemoteCache" id="locatorRemoteCache">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%RemoteCacheDescriptionAll</description>
                    <helpKeyword>configs.remotecache_remotecachedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%IXP_Bound" id="locatorIXP_Bound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%IXP_BoundDescriptionAll</description>
                    <helpKeyword>configs.ixp_bound_ixp_bounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoresBound" id="locatorStoresBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%StoresBoundDescriptionAll</description>
                    <helpKeyword>configs.storesbound_storesbounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%StoreLatency" id="locatorStoreLatency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%StoreLatencyDescriptionAll</description>
                    <helpKeyword>configs.storelatency_storelatencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FalseSharing" id="locatorFalseSharing">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FalseSharingDescriptionAll</description>
                    <helpKeyword>configs.falsesharing_falsesharingdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SplitStores" id="locatorSplitStores">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SplitStoresDescriptionAll</description>
                    <helpKeyword>configs.splitstores_splitstoresdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DTLBStoreOverhead" id="locatorDTLBStoreOverhead">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DTLBStoreOverheadDescriptionAll</description>
                    <helpKeyword>configs.dtlbstoreoverhead_dtlbstoreoverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_STLB_Hit" id="locatorStore_STLB_Hit">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Store_STLB_HitDescriptionAll</description>
                    <helpKeyword>configs.store_stlb_hit_store_stlb_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_STLB_Miss" id="locatorStore_STLB_Miss">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Store_STLB_MissDescriptionAll</description>
                    <helpKeyword>configs.store_stlb_miss_store_stlb_missdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="locatorCoreBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.corebound_corebounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%DIVActive" id="locatorDIVActive">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DIVActiveDescriptionAll</description>
                    <helpKeyword>configs.divactive_divactivedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PortUtil" id="locatorPortUtil">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%PortUtilDescriptionAll</description>
                    <helpKeyword>configs.portutil_portutildescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles0PortsUtilized" id="locatorCycles0PortsUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles0PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles0portsutilized_cycles0portsutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Serializing_Operation" id="locatorSerializing_Operation">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Serializing_OperationDescriptionAll</description>
                    <helpKeyword>configs.serializing_operation_serializing_operationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Slow_Pause" id="locatorSlow_Pause">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Slow_PauseDescriptionAll</description>
                    <helpKeyword>configs.slow_pause_slow_pausedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles1PortUtilized" id="locatorCycles1PortUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles1PortUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles1portutilized_cycles1portutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles2PortsUtilized" id="locatorCycles2PortsUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles2PortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles2portsutilized_cycles2portsutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Cycles3mPortsUtilized" id="locatorCycles3mPortsUtilized">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Cycles3mPortsUtilizedDescriptionAll</description>
                    <helpKeyword>configs.cycles3mportsutilized_cycles3mportsutilizeddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ALU_Op_Utilization" id="locatorALU_Op_Utilization">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ALU_Op_UtilizationDescriptionAll</description>
                    <helpKeyword>configs.alu_op_utilization_alu_op_utilizationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port0" id="locatorPort0">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port0DescriptionAll</description>
                    <helpKeyword>configs.port0_port0descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port1" id="locatorPort1">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port1DescriptionAll</description>
                    <helpKeyword>configs.port1_port1descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port5" id="locatorPort5">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port5DescriptionAll</description>
                    <helpKeyword>configs.port5_port5descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Port6" id="locatorPort6">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Port6DescriptionAll</description>
                    <helpKeyword>configs.port6_port6descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_Op_Utilization" id="locatorLoad_Op_Utilization">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Load_Op_UtilizationDescriptionAll</description>
                    <helpKeyword>configs.load_op_utilization_load_op_utilizationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_Op_Utilization" id="locatorStore_Op_Utilization">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Store_Op_UtilizationDescriptionAll</description>
                    <helpKeyword>configs.store_op_utilization_store_op_utilizationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%SLOTS" id="locatorSLOTS">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%SLOTSDescriptionAll</description>
                    <helpKeyword>configs.slots_slotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CORE_CLKS" id="locatorCORE_CLKS">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CORE_CLKSDescriptionAll</description>
                    <helpKeyword>configs.core_clks_core_clksdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Load_Miss_Real_Latency" id="locatorLoad_Miss_Real_Latency">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Load_Miss_Real_LatencyDescriptionAll</description>
                    <helpKeyword>configs.load_miss_real_latency_load_miss_real_latencydescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Fetched_Uops" id="locatorFetched_Uops">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Fetched_UopsDescriptionAll</description>
                    <helpKeyword>configs.fetched_uops_fetched_uopsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_Any_Cycles" id="locatorORO_DRD_Any_Cycles">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ORO_DRD_Any_CyclesDescriptionAll</description>
                    <helpKeyword>configs.oro_drd_any_cycles_oro_drd_any_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ORO_DRD_BW_Cycles" id="locatorORO_DRD_BW_Cycles">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ORO_DRD_BW_CyclesDescriptionAll</description>
                    <helpKeyword>configs.oro_drd_bw_cycles_oro_drd_bw_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ORO_Demand_RFO_C1" id="locatorORO_Demand_RFO_C1">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%ORO_Demand_RFO_C1DescriptionAll</description>
                    <helpKeyword>configs.oro_demand_rfo_c1_oro_demand_rfo_c1descriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Store_L2_Hit_Cycles" id="locatorStore_L2_Hit_Cycles">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Store_L2_Hit_CyclesDescriptionAll</description>
                    <helpKeyword>configs.store_l2_hit_cycles_store_l2_hit_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L1_MISS_NET" id="locatorLOAD_L1_MISS_NET">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_L1_MISS_NETDescriptionAll</description>
                    <helpKeyword>configs.load_l1_miss_net_load_l1_miss_netdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L2_HIT" id="locatorLOAD_L2_HIT">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_L2_HITDescriptionAll</description>
                    <helpKeyword>configs.load_l2_hit_load_l2_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_L3_HIT" id="locatorLOAD_L3_HIT">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_L3_HITDescriptionAll</description>
                    <helpKeyword>configs.load_l3_hit_load_l3_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HIT" id="locatorLOAD_XSNP_HIT">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_XSNP_HITDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_hit_load_xsnp_hitdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_HITM" id="locatorLOAD_XSNP_HITM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_XSNP_HITMDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_hitm_load_xsnp_hitmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_XSNP_MISS" id="locatorLOAD_XSNP_MISS">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_XSNP_MISSDescriptionAll</description>
                    <helpKeyword>configs.load_xsnp_miss_load_xsnp_missdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_MEM" id="locatorLOAD_LCL_MEM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_LCL_MEMDescriptionAll</description>
                    <helpKeyword>configs.load_lcl_mem_load_lcl_memdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_LCL_PMM" id="locatorLOAD_LCL_PMM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_LCL_PMMDescriptionAll</description>
                    <helpKeyword>configs.load_lcl_pmm_load_lcl_pmmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_PMM" id="locatorLOAD_RMT_PMM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_RMT_PMMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_pmm_load_rmt_pmmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_MEM" id="locatorLOAD_RMT_MEM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_RMT_MEMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_mem_load_rmt_memdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_HITM" id="locatorLOAD_RMT_HITM">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_RMT_HITMDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_hitm_load_rmt_hitmdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%LOAD_RMT_FWD" id="locatorLOAD_RMT_FWD">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%LOAD_RMT_FWDDescriptionAll</description>
                    <helpKeyword>configs.load_rmt_fwd_load_rmt_fwddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Few_Uops_Executed_Threshold" id="locatorFew_Uops_Executed_Threshold">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Few_Uops_Executed_ThresholdDescriptionAll</description>
                    <helpKeyword>configs.few_uops_executed_threshold_few_uops_executed_thresholddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Core_Bound_Cycles" id="locatorCore_Bound_Cycles">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Core_Bound_CyclesDescriptionAll</description>
                    <helpKeyword>configs.core_bound_cycles_core_bound_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Backend_Bound_Cycles" id="locatorBackend_Bound_Cycles">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Backend_Bound_CyclesDescriptionAll</description>
                    <helpKeyword>configs.backend_bound_cycles_backend_bound_cyclesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Memory_Bound_Fraction" id="locatorMemory_Bound_Fraction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Memory_Bound_FractionDescriptionAll</description>
                    <helpKeyword>configs.memory_bound_fraction_memory_bound_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%L2_Bound_Ratio" id="locatorL2_Bound_Ratio">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%L2_Bound_RatioDescriptionAll</description>
                    <helpKeyword>configs.l2_bound_ratio_l2_bound_ratiodescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEM_Bound_Ratio" id="locatorMEM_Bound_Ratio">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEM_Bound_RatioDescriptionAll</description>
                    <helpKeyword>configs.mem_bound_ratio_mem_bound_ratiodescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_DDR_Hit_Fraction" id="locatorMem_DDR_Hit_Fraction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_DDR_Hit_FractionDescriptionAll</description>
                    <helpKeyword>configs.mem_ddr_hit_fraction_mem_ddr_hit_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Lock_St_Fraction" id="locatorMem_Lock_St_Fraction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_Lock_St_FractionDescriptionAll</description>
                    <helpKeyword>configs.mem_lock_st_fraction_mem_lock_st_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mispred_Clears_Fraction" id="locatorMispred_Clears_Fraction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mispred_Clears_FractionDescriptionAll</description>
                    <helpKeyword>configs.mispred_clears_fraction_mispred_clears_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Retire_Fraction" id="locatorRetire_Fraction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Retire_FractionDescriptionAll</description>
                    <helpKeyword>configs.retire_fraction_retire_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%True_XSNP_HitM_Fraction" id="locatorTrue_XSNP_HitM_Fraction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%True_XSNP_HitM_FractionDescriptionAll</description>
                    <helpKeyword>configs.true_xsnp_hitm_fraction_true_xsnp_hitm_fractiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Pipeline_Width" id="locatorPipeline_Width">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Pipeline_WidthDescriptionAll</description>
                    <helpKeyword>configs.pipeline_width_pipeline_widthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_L2_Store_Cost" id="locatorMem_L2_Store_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_L2_Store_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_l2_store_cost_mem_l2_store_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_STLB_Hit_Cost" id="locatorMem_STLB_Hit_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_STLB_Hit_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_stlb_hit_cost_mem_stlb_hit_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_XSNP_HitM_Cost" id="locatorMem_XSNP_HitM_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_XSNP_HitM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_hitm_cost_mem_xsnp_hitm_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_Hit_Cost" id="locatorMEM_XSNP_Hit_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEM_XSNP_Hit_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_hit_cost_mem_xsnp_hit_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MEM_XSNP_None_Cost" id="locatorMEM_XSNP_None_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MEM_XSNP_None_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_xsnp_none_cost_mem_xsnp_none_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Local_DRAM_Cost" id="locatorMem_Local_DRAM_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_Local_DRAM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_local_dram_cost_mem_local_dram_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_DRAM_Cost" id="locatorMem_Remote_DRAM_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_Remote_DRAM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_dram_cost_mem_remote_dram_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_HitM_Cost" id="locatorMem_Remote_HitM_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_Remote_HitM_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_hitm_cost_mem_remote_hitm_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Mem_Remote_Fwd_Cost" id="locatorMem_Remote_Fwd_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Mem_Remote_Fwd_CostDescriptionAll</description>
                    <helpKeyword>configs.mem_remote_fwd_cost_mem_remote_fwd_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BAClear_Cost" id="locatorBAClear_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BAClear_CostDescriptionAll</description>
                    <helpKeyword>configs.baclear_cost_baclear_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MS_Switches_Cost" id="locatorMS_Switches_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MS_Switches_CostDescriptionAll</description>
                    <helpKeyword>configs.ms_switches_cost_ms_switches_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Avg_Assist_Cost" id="locatorAvg_Assist_Cost">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Avg_Assist_CostDescriptionAll</description>
                    <helpKeyword>configs.avg_assist_cost_avg_assist_costdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OneMillion" id="locatorOneMillion">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%OneMillionDescriptionAll</description>
                    <helpKeyword>configs.onemillion_onemilliondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Retired_Slots" id="locatorRetired_Slots">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Retired_SlotsDescriptionAll</description>
                    <helpKeyword>configs.retired_slots_retired_slotsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%UPC" id="locatorUPC">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%UPCDescriptionAll</description>
                    <helpKeyword>configs.upc_upcdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PMM_App_Direct" id="locatorPMM_App_Direct">
                    <xsl:choose>
                        <xsl:when test="$is3DXOn">
                            <queryInherit>/GeMetricBaseLocator</queryInherit>
                            <description>%PMM_App_DirectDescriptionAll</description>
                            <helpKeyword>configs.pmm_app_direct_pmm_app_directdescriptionall</helpKeyword>
                        </xsl:when>
                        <xsl:otherwise>
                            <valueEval>0</valueEval>
                            <queryInherit>/GeMetricNA</queryInherit>
                        </xsl:otherwise>
                    </xsl:choose>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
    <xsl:variable name="is3DXOn" select="exsl:ctx('is3DXPPresent', 0) and not(exsl:ctx('is3DXP2LMMode', 0))" />
</xsl:stylesheet>
