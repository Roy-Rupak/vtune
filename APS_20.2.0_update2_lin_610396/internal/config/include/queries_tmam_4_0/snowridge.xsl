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
                                        <queryRef>/FPDIV</queryRef>
                                        <queryRef>/OTHER</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <queryRef>/MicroSequencer</queryRef>
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
                                        <queryRef>/BACLEARS</queryRef>
                                        <queryRef>/BranchResteers</queryRef>
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
                                        <queryRef>/FEBandwidthCisc</queryRef>
                                        <queryRef>/FEBandwidthDecode</queryRef>
                                        <queryRef>/PreDecodeWrong</queryRef>
                                        <queryRef>/FEBandwidthOther</queryRef>
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
                            <derivedQuery id="MachineClearsGroup">
                                <queryInherit>/MachineClears</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="MachineClearsGroupExpanded">
                                        <queryRef>/MachineClearsNuke</queryRef>
                                        <queryRef>/MOMachineClear</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
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
                            <derivedQuery id="CoreBoundGroup">
                                <queryInherit>/CoreBound</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="CoreBoundGroupExpanded">
                                        <queryRef>/MemoryScheduler</queryRef>
                                        <queryRef>/NonMemoryScheduler</queryRef>
                                        <queryRef>/BERegister</queryRef>
                                        <queryRef>/BEReorderBuffer</queryRef>
                                        <queryRef>/BEStoreBuffer</queryRef>
                                        <queryRef>/BEAllocRestriction</queryRef>
                                        <queryRef>/Serializing_Operation</queryRef>
                                    </vectorQuery>
                                </expand>
                            </derivedQuery>
                            <derivedQuery id="MemBoundGroup">
                                <queryInherit>/MemBound</queryInherit>
                                <displayAttributes>
                                    <boolean:expand>false</boolean:expand>
                                    <boolean:allowCollapse>true</boolean:allowCollapse>
                                </displayAttributes>
                                <expand>
                                    <vectorQuery id="MemBoundGroupExpanded">
                                        <queryRef>/L2Bound</queryRef>
                                        <queryRef>/L3Bound</queryRef>
                                        <queryRef>/DRAMBound</queryRef>
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
                <derivedQuery displayName="%FPDIV" id="FPDIV">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FPDIVDescriptionAll</description>
                    <helpKeyword>configs.fpdiv_fpdivdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%OTHER" id="OTHER">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%OTHERDescriptionAll</description>
                    <helpKeyword>configs.other_otherdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MicroSequencer" id="MicroSequencer">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MicroSequencerDescriptionAll</description>
                    <helpKeyword>configs.microsequencer_microsequencerdescriptionall</helpKeyword>
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
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%ICacheMissesDescriptionAll</description>
                    <helpKeyword>configs.icachemisses_icachemissesdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%ITLBOverhead" id="ITLBOverhead">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%ITLBOverheadDescriptionAll</description>
                    <helpKeyword>configs.itlboverhead_itlboverheaddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BACLEARS" id="BACLEARS">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BACLEARSDescriptionAll</description>
                    <helpKeyword>configs.baclears_baclearsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="BranchResteers">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branchresteers_branchresteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="FEBandwidth">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.febandwidth_febandwidthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthCisc" id="FEBandwidthCisc">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthCiscDescriptionAll</description>
                    <helpKeyword>configs.febandwidthcisc_febandwidthciscdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDecode" id="FEBandwidthDecode">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthDecodeDescriptionAll</description>
                    <helpKeyword>configs.febandwidthdecode_febandwidthdecodedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PreDecodeWrong" id="PreDecodeWrong">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%PreDecodeWrongDescriptionAll</description>
                    <helpKeyword>configs.predecodewrong_predecodewrongdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthOther" id="FEBandwidthOther">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%FEBandwidthOtherDescriptionAll</description>
                    <helpKeyword>configs.febandwidthother_febandwidthotherdescriptionall</helpKeyword>
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
                <derivedQuery displayName="%MachineClearsNuke" id="MachineClearsNuke">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MachineClearsNukeDescriptionAll</description>
                    <helpKeyword>configs.machineclearsnuke_machineclearsnukedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MOMachineClear" id="MOMachineClear">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MOMachineClearDescriptionAll</description>
                    <helpKeyword>configs.momachineclear_momachinecleardescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="BackendBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="CoreBound">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.corebound_corebounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemoryScheduler" id="MemoryScheduler">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%MemorySchedulerDescriptionAll</description>
                    <helpKeyword>configs.memoryscheduler_memoryschedulerdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%NonMemoryScheduler" id="NonMemoryScheduler">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%NonMemorySchedulerDescriptionAll</description>
                    <helpKeyword>configs.nonmemoryscheduler_nonmemoryschedulerdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BERegister" id="BERegister">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BERegisterDescriptionAll</description>
                    <helpKeyword>configs.beregister_beregisterdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BEReorderBuffer" id="BEReorderBuffer">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BEReorderBufferDescriptionAll</description>
                    <helpKeyword>configs.bereorderbuffer_bereorderbufferdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BEStoreBuffer" id="BEStoreBuffer">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BEStoreBufferDescriptionAll</description>
                    <helpKeyword>configs.bestorebuffer_bestorebufferdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BEAllocRestriction" id="BEAllocRestriction">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%BEAllocRestrictionDescriptionAll</description>
                    <helpKeyword>configs.beallocrestriction_beallocrestrictiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Serializing_Operation" id="Serializing_Operation">
                    <queryInherit>/GeMetricBaseSlots</queryInherit>
                    <description>%Serializing_OperationDescriptionAll</description>
                    <helpKeyword>configs.serializing_operation_serializing_operationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="MemBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.membound_membounddescriptionall</helpKeyword>
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
                <derivedQuery displayName="%DRAMBound" id="DRAMBound">
                    <queryInherit>/GeMetricBaseClockticks</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.drambound_drambounddescriptionall</helpKeyword>
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
                                                    <queryRef>/locatorFPDIV</queryRef>
                                                    <queryRef>/locatorOTHER</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <queryRef>/locatorMicroSequencer</queryRef>
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
                                                    <queryRef>/locatorBACLEARS</queryRef>
                                                    <queryRef>/locatorBranchResteers</queryRef>
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
                                                    <queryRef>/locatorFEBandwidthCisc</queryRef>
                                                    <queryRef>/locatorFEBandwidthDecode</queryRef>
                                                    <queryRef>/locatorPreDecodeWrong</queryRef>
                                                    <queryRef>/locatorFEBandwidthOther</queryRef>
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
                                        <derivedQuery id="locatorMachineClearsGroup">
                                            <queryInherit>/locatorMachineClears</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorMachineClearsGroupExpanded">
                                                    <queryRef>/locatorMachineClearsNuke</queryRef>
                                                    <queryRef>/locatorMOMachineClear</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
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
                                        <derivedQuery id="locatorCoreBoundGroup">
                                            <queryInherit>/locatorCoreBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorCoreBoundGroupExpanded">
                                                    <queryRef>/locatorMemoryScheduler</queryRef>
                                                    <queryRef>/locatorNonMemoryScheduler</queryRef>
                                                    <queryRef>/locatorBERegister</queryRef>
                                                    <queryRef>/locatorBEReorderBuffer</queryRef>
                                                    <queryRef>/locatorBEStoreBuffer</queryRef>
                                                    <queryRef>/locatorBEAllocRestriction</queryRef>
                                                    <queryRef>/locatorSerializing_Operation</queryRef>
                                                </vectorQuery>
                                            </expand>
                                        </derivedQuery>
                                        <derivedQuery id="locatorMemBoundGroup">
                                            <queryInherit>/locatorMemBound</queryInherit>
                                            <displayAttributes>
                                                <boolean:expand>false</boolean:expand>
                                                <boolean:allowCollapse>true</boolean:allowCollapse>
                                            </displayAttributes>
                                            <expand>
                                                <vectorQuery id="locatorMemBoundGroupExpanded">
                                                    <queryRef>/locatorL2Bound</queryRef>
                                                    <queryRef>/locatorL3Bound</queryRef>
                                                    <queryRef>/locatorDRAMBound</queryRef>
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
                <derivedQuery displayName="%FPDIV" id="locatorFPDIV">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FPDIVDescriptionAll</description>
                    <helpKeyword>configs.fpdiv_fpdivdescriptionall</helpKeyword>
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
                <derivedQuery displayName="%BACLEARS" id="locatorBACLEARS">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BACLEARSDescriptionAll</description>
                    <helpKeyword>configs.baclears_baclearsdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BranchResteers" id="locatorBranchResteers">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BranchResteersDescriptionAll</description>
                    <helpKeyword>configs.branchresteers_branchresteersdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidth" id="locatorFEBandwidth">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthDescriptionAll</description>
                    <helpKeyword>configs.febandwidth_febandwidthdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthCisc" id="locatorFEBandwidthCisc">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthCiscDescriptionAll</description>
                    <helpKeyword>configs.febandwidthcisc_febandwidthciscdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthDecode" id="locatorFEBandwidthDecode">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthDecodeDescriptionAll</description>
                    <helpKeyword>configs.febandwidthdecode_febandwidthdecodedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%PreDecodeWrong" id="locatorPreDecodeWrong">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%PreDecodeWrongDescriptionAll</description>
                    <helpKeyword>configs.predecodewrong_predecodewrongdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%FEBandwidthOther" id="locatorFEBandwidthOther">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%FEBandwidthOtherDescriptionAll</description>
                    <helpKeyword>configs.febandwidthother_febandwidthotherdescriptionall</helpKeyword>
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
                <derivedQuery displayName="%MachineClearsNuke" id="locatorMachineClearsNuke">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MachineClearsNukeDescriptionAll</description>
                    <helpKeyword>configs.machineclearsnuke_machineclearsnukedescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MOMachineClear" id="locatorMOMachineClear">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MOMachineClearDescriptionAll</description>
                    <helpKeyword>configs.momachineclear_momachinecleardescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BackendBound" id="locatorBackendBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BackendBoundDescriptionAll</description>
                    <helpKeyword>configs.backendbound_backendbounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%CoreBound" id="locatorCoreBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%CoreBoundDescriptionAll</description>
                    <helpKeyword>configs.corebound_corebounddescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemoryScheduler" id="locatorMemoryScheduler">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MemorySchedulerDescriptionAll</description>
                    <helpKeyword>configs.memoryscheduler_memoryschedulerdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%NonMemoryScheduler" id="locatorNonMemoryScheduler">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%NonMemorySchedulerDescriptionAll</description>
                    <helpKeyword>configs.nonmemoryscheduler_nonmemoryschedulerdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BERegister" id="locatorBERegister">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BERegisterDescriptionAll</description>
                    <helpKeyword>configs.beregister_beregisterdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BEReorderBuffer" id="locatorBEReorderBuffer">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BEReorderBufferDescriptionAll</description>
                    <helpKeyword>configs.bereorderbuffer_bereorderbufferdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BEStoreBuffer" id="locatorBEStoreBuffer">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BEStoreBufferDescriptionAll</description>
                    <helpKeyword>configs.bestorebuffer_bestorebufferdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%BEAllocRestriction" id="locatorBEAllocRestriction">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%BEAllocRestrictionDescriptionAll</description>
                    <helpKeyword>configs.beallocrestriction_beallocrestrictiondescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%Serializing_Operation" id="locatorSerializing_Operation">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%Serializing_OperationDescriptionAll</description>
                    <helpKeyword>configs.serializing_operation_serializing_operationdescriptionall</helpKeyword>
                </derivedQuery>
                <derivedQuery displayName="%MemBound" id="locatorMemBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%MemBoundDescriptionAll</description>
                    <helpKeyword>configs.membound_membounddescriptionall</helpKeyword>
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
                <derivedQuery displayName="%DRAMBound" id="locatorDRAMBound">
                    <queryInherit>/GeMetricBaseLocator</queryInherit>
                    <description>%DRAMBoundDescriptionAll</description>
                    <helpKeyword>configs.drambound_drambounddescriptionall</helpKeyword>
                </derivedQuery>
            </locatorqueryLibrary>
        </bag>
    </xsl:template>
    <xsl:variable name="isHTOn" select="exsl:ctx('isHTEnabled', 0) or (exsl:ctx('logicalCPUCount', 1) &gt; exsl:ctx('physicalCoreCount', 1))" />
    <xsl:variable name="is3DXOn" select="exsl:ctx('is3DXPPresent', 0) and not(exsl:ctx('is3DXP2LMMode', 0))" />
</xsl:stylesheet>
