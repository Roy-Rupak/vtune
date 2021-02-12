<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  exclude-result-prefixes="msxsl"
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  xmlns:exsl="http://exslt.org/common"
  syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="/">
  <bag>
    <config id="gSimTimelineExecute">
      <configAreas>
        <area id="execute_ipc">
          <rowSet displayName="IPC">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/Ipc_0_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/Ipc_1_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/Ipc_2_gSimExecute</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_mathinstructions">
          <rowSet displayName="Math operations per clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_0_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_1_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_2_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_3_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_4_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_5_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_6_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_7_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_8_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_9_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_10_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_11_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_12_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_13_gSimExecute_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_14_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_15_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_16_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_17_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_18_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_19_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_20_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_21_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_22_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_23_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MathInstructions_24_gSimExecute</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_nonmathinstructions">
          <rowSet displayName="Non-math operations per clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_0_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_1_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_2_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_3_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_4_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_5_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_6_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_7_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_8_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_9_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_10_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_11_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_12_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_13_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_14_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_15_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_16_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_17_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_18_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_19_gSimExecute</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NonMathInstructions_20_gSimExecute</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_eu_dependencies">
          <rowSet displayName="Dependency State of Threads">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/EuDependencies_0_gSimExecute</queryRef>
                <queryRef>/EuDependencies_1_gSimExecute</queryRef>
                <queryRef>/EuDependencies_2_gSimExecute</queryRef>
                <queryRef>/EuDependencies_3_gSimExecute</queryRef>
                <queryRef>/EuDependencies_4_gSimExecute</queryRef>
                <queryRef>/EuDependencies_5_gSimExecute</queryRef>
                <queryRef>/EuDependencies_6_gSimExecute</queryRef>
                <queryRef>/EuDependencies_7_gSimExecute</queryRef>
                <queryRef>/EuDependencies_8_gSimExecute</queryRef>
                <queryRef>/EuDependencies_9_gSimExecute</queryRef>
                <queryRef>/EuDependencies_10_gSimExecute</queryRef>
                <queryRef>/EuDependencies_11_gSimExecute</queryRef>
                <queryRef>/EuDependencies_12_gSimExecute</queryRef>
                <queryRef>/EuDependencies_13_gSimExecute</queryRef>
                <queryRef>/EuDependencies_14_gSimExecute</queryRef>
                <queryRef>/EuDependencies_15_gSimExecute</queryRef>
                <queryRef>/EuDependencies_16_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_cache_misses">
          <rowSet displayName="I-Cache Misses per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/ICacheMisses_0_gSimExecute</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_eu_static_dynamic">
          <rowSet displayName="Different SIMD Ops per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/EuStaticDynamSimd_0_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_1_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_2_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_3_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_4_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_5_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_6_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_7_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_8_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_9_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_10_gSimExecute</queryRef>
                <queryRef>/EuStaticDynamSimd_11_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_eu_types">
          <rowSet displayName="Different Op Types per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/EuTypes_0_gSimExecute</queryRef>
                <queryRef>/EuTypes_1_gSimExecute</queryRef>
                <queryRef>/EuTypes_2_gSimExecute</queryRef>
                <queryRef>/EuTypes_3_gSimExecute</queryRef>
                <queryRef>/EuTypes_4_gSimExecute</queryRef>
                <queryRef>/EuTypes_5_gSimExecute</queryRef>
                <queryRef>/EuTypes_6_gSimExecute</queryRef>
                <queryRef>/EuTypes_7_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_eu_pipes">
          <rowSet displayName="Ops Pushed to EM/FPU Pipes per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/EuPipes_0_gSimExecute</queryRef>
                <queryRef>/EuPipes_1_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_grf_read_conflicts">
          <rowSet displayName="GRF Bank Conflicts per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GrfReadConflicts_0_gSimExecute</queryRef>
                <queryRef>/GrfReadConflicts_1_gSimExecute</queryRef>
                <queryRef>/GrfReadConflicts_2_gSimExecute</queryRef>
                <queryRef>/GrfReadConflicts_3_gSimExecute</queryRef>
                <queryRef>/GrfReadConflicts_4_gSimExecute</queryRef>
                <queryRef>/GrfReadConflicts_5_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_send_types">
          <rowSet displayName="Send Instructions of Different Types per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SendTypes_0_gSimExecute</queryRef>
                <queryRef>/SendTypes_1_gSimExecute</queryRef>
                <queryRef>/SendTypes_2_gSimExecute</queryRef>
                <queryRef>/SendTypes_3_gSimExecute</queryRef>
                <queryRef>/SendTypes_4_gSimExecute</queryRef>
                <queryRef>/SendTypes_5_gSimExecute</queryRef>
                <queryRef>/SendTypes_6_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="execute_grf_read_write">
          <rowSet displayName="Number of GRF read attempts per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GrfReadWrite_0_gSimExecute</queryRef>
                <queryRef>/GrfReadWrite_1_gSimExecute</queryRef>
                <queryRef>/GrfReadWrite_2_gSimExecute</queryRef>
                <queryRef>/GrfReadWrite_3_gSimExecute</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </configAreas>
    </config>
    <config id="gSimTimelineHDC">
      <configAreas>
        <area id="hdc_traffic">
          <rowSet displayName="Num. HDC message types per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/Traffic_0_gSimHDC</queryRef>
                <queryRef>/Traffic_1_gSimHDC</queryRef>
                <queryRef>/Traffic_2_gSimHDC</queryRef>
                <queryRef>/Traffic_3_gSimHDC</queryRef>
                <queryRef>/Traffic_4_gSimHDC</queryRef>
                <queryRef>/Traffic_5_gSimHDC</queryRef>
                <queryRef>/Traffic_6_gSimHDC</queryRef>
                <queryRef>/Traffic_7_gSimHDC</queryRef>
                <queryRef>/Traffic_8_gSimHDC</queryRef>
                <queryRef>/Traffic_9_gSimHDC</queryRef>
                <queryRef>/Traffic_10_gSimHDC</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_msg_lengths">
          <rowSet displayName="HDC Msg and Data Lengths per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MsgLengths_0_gSimHDC</queryRef>
                <queryRef>/MsgLengths_1_gSimHDC</queryRef>
                <queryRef>/MsgLengths_2_gSimHDC</queryRef>
                <queryRef>/MsgLengths_3_gSimHDC</queryRef>
                <queryRef>/MsgLengths_4_gSimHDC</queryRef>
                <queryRef>/MsgLengths_5_gSimHDC</queryRef>
                <queryRef>/MsgLengths_6_gSimHDC</queryRef>
                <queryRef>/MsgLengths_7_gSimHDC</queryRef>
                <queryRef>/MsgLengths_8_gSimHDC</queryRef>
                <queryRef>/MsgLengths_9_gSimHDC</queryRef>
                <queryRef>/MsgLengths_10_gSimHDC</queryRef>
                <queryRef>/MsgLengths_11_gSimHDC</queryRef>
                <queryRef>/MsgLengths_12_gSimHDC</queryRef>
                <queryRef>/MsgLengths_13_gSimHDC</queryRef>
                <queryRef>/MsgLengths_14_gSimHDC</queryRef>
                <queryRef>/MsgLengths_15_gSimHDC</queryRef>
                <queryRef>/MsgLengths_16_gSimHDC</queryRef>
                <queryRef>/MsgLengths_17_gSimHDC</queryRef>
                <queryRef>/MsgLengths_18_gSimHDC</queryRef>
                <queryRef>/MsgLengths_19_gSimHDC</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_num_l3_per_hdc_msg">
          <rowSet displayName="Req. counts of msgs pre-compression per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NumL3PerHdcMsg_0_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_1_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_2_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_3_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_4_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_5_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_6_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_7_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_8_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_9_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_10_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_11_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_12_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_13_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_14_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_15_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_16_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_17_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_18_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_19_gSimHDC</queryRef>
                <queryRef>/NumL3PerHdcMsg_20_gSimHDC</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_l1_stall_bypass">
          <rowSet displayName="Req. counts of msgs pre-compression per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/L1StallBypass_0_gSimHDC</queryRef>
                <queryRef>/L1StallBypass_1_gSimHDC</queryRef>
                <queryRef>/L1StallBypass_2_gSimHDC</queryRef>
                <queryRef>/L1StallBypass_3_gSimHDC</queryRef>
                <queryRef>/L1StallBypass_4_gSimHDC</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_tlb_hit_miss">
          <rowSet displayName="HDC TLB Hit/Miss per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbHitMiss_0_gSimHDC</queryRef>
                <queryRef>/TlbHitMiss_1_gSimHDC</queryRef>
                <queryRef>/TlbHitMiss_2_gSimHDC</queryRef>
                <queryRef>/TlbHitMiss_3_gSimHDC</queryRef>
                <queryRef>/TlbHitMiss_4_gSimHDC</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
         <area id="hdc_entry_tracker">
          <rowSet displayName="HDC Trackers Full per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/EntryCycleTracker_0_gSimHDC</queryRef>
                <queryRef>/EntryCycleTracker_1_gSimHDC</queryRef>
              </drawBy>
              <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_data_rtn_len">
          <rowSet displayName="HDC Trackers Full per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/DataRtnLngths_0_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_1_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_2_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_3_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_4_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_5_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_6_gSimHDC</queryRef>
                <queryRef>/DataRtnLngths_7_gSimHDC</queryRef>
              </drawBy>
              <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_message_phases">
          <rowSet displayName="HDC Msg and Data Lengths per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/MessagePhases_0_gSimHDC</queryRef>
                <queryRef>/MessagePhases_1_gSimHDC</queryRef>
                <queryRef>/MessagePhases_2_gSimHDC</queryRef>
                <queryRef>/MessagePhases_3_gSimHDC</queryRef>
                <queryRef>/MessagePhases_4_gSimHDC</queryRef>
                <queryRef>/MessagePhases_5_gSimHDC</queryRef>
                <queryRef>/MessagePhases_6_gSimHDC</queryRef>
                <queryRef>/MessagePhases_7_gSimHDC</queryRef>
                <queryRef>/MessagePhases_8_gSimHDC</queryRef>
                <queryRef>/MessagePhases_9_gSimHDC</queryRef>
                <queryRef>/MessagePhases_10_gSimHDC</queryRef>
                <queryRef>/MessagePhases_11_gSimHDC</queryRef>
              </drawBy>
              <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
            </layer>
          </rowSet>
        </area>
        <area id="hdc_sampler_l1">
          <rowSet displayName="Sampler L1 Cache Events per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SamplerL1Cache_0_gSimHDC</queryRef>
                <queryRef>/SamplerL1Cache_1_gSimHDC</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </configAreas>
    </config>
    <config id="gSimTimelineL3">
      <configAreas>
        <area id="l3_traffic">
          <rowSet displayName="Num. of L3 Requests per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/Traffic_0_gSimL3</queryRef>
                <queryRef>/Traffic_1_gSimL3</queryRef>
                <queryRef>/Traffic_2_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_bank_hit_misses">
          <rowSet displayName="Num. of L3 Hits\Misses per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/BankHitsMisses_1_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_2_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_3_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_4_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_5_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_6_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_7_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_8_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_9_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_10_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_11_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_12_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_13_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_14_gSimL3</queryRef>
                <queryRef>/BankHitsMisses_15_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_colliding_read_hit_misses">
          <rowSet displayName="Num. of L3 Reads per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/CollidingHitsMisses_4_gSimL3</queryRef>
                <queryRef>/CollidingHitsMisses_5_gSimL3</queryRef>
                <queryRef>/CollidingHitsMisses_6_gSimL3</queryRef>
                <queryRef>/CollidingHitsMisses_7_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_coliding_write_hit_misses">
          <rowSet displayName="Num. of L3 Writes per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/CollidingHitsMisses_0_gSimL3</queryRef>
                <queryRef>/CollidingHitsMisses_1_gSimL3</queryRef>
                <queryRef>/CollidingHitsMisses_2_gSimL3</queryRef>
                <queryRef>/CollidingHitsMisses_3_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_slm_traffic">
          <rowSet displayName="SLM Requests per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SLMtraffic_0_gSimL3</queryRef>
                <queryRef>/SLMtraffic_1_gSimL3</queryRef>
                <queryRef>/SLMtraffic_2_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_atomics">
          <rowSet displayName="L3 Atomic Requests per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/Atomics_0_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_bank_full_write_misses">
          <rowSet displayName="Full-line write misses per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/BankFullWriteMisses_0_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_1_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_2_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_3_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_4_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_5_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_6_gSimL3</queryRef>
                <queryRef>/BankFullWriteMisses_7_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_partial_writes">
          <rowSet displayName="Full/Partial Writes per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/PartialWrites_0_gSimL3</queryRef>
                <queryRef>/PartialWrites_1_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_bank_evictions">
          <rowSet displayName="L3 Evictions per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/L3BankEvictions_0_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_1_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_2_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_3_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_4_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_5_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_6_gSimL3</queryRef>
                <queryRef>/L3BankEvictions_7_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_ram_traffic">
          <rowSet displayName="Data Array Accesses per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/RamTraffic_0_gSimL3</queryRef>
                <queryRef>/RamTraffic_1_gSimL3</queryRef>
                <queryRef>/RamTraffic_2_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_sq_full">
          <rowSet displayName="Total SuperQ Stalls per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SqFull_0_gSimL3</queryRef>
                <queryRef>/SqFull_1_gSimL3</queryRef>
                <queryRef>/SqFull_2_gSimL3</queryRef>
                <queryRef>/SqFull_3_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_num_has_parent">
          <rowSet displayName="Super Address Conflicts per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/NumHasParent_0_gSimL3</queryRef>
                <queryRef>/NumHasParent_1_gSimL3</queryRef>
                <queryRef>/NumHasParent_2_gSimL3</queryRef>
                <queryRef>/NumHasParent_3_gSimL3</queryRef>
                <queryRef>/NumHasParent_4_gSimL3</queryRef>
                <queryRef>/NumHasParent_5_gSimL3</queryRef>
                <queryRef>/NumHasParent_6_gSimL3</queryRef>
                <queryRef>/NumHasParent_7_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_sq_slots">
          <rowSet displayName="State of SuperQ Entries">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SqSlots_0_gSimL3</queryRef>
                <queryRef>/SqSlots_1_gSimL3</queryRef>
                <queryRef>/SqSlots_2_gSimL3</queryRef>
                <queryRef>/SqSlots_3_gSimL3</queryRef>
                <queryRef>/SqSlots_4_gSimL3</queryRef>
                <queryRef>/SqSlots_5_gSimL3</queryRef>
                <queryRef>/SqSlots_6_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_sq_occupancy">
          <rowSet displayName="Requests Super Occupancy">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SqOccupancy_0_gSimL3</queryRef>
                <queryRef>/SqOccupancy_1_gSimL3</queryRef>
                <queryRef>/SqOccupancy_2_gSimL3</queryRef>
                <queryRef>/SqOccupancy_3_gSimL3</queryRef>
                <queryRef>/SqOccupancy_4_gSimL3</queryRef>
                <queryRef>/SqOccupancy_5_gSimL3</queryRef>
                <queryRef>/SqOccupancy_6_gSimL3</queryRef>
                <queryRef>/SqOccupancy_7_gSimL3</queryRef>
                <queryRef>/SqOccupancy_8_gSimL3</queryRef>
                <queryRef>/SqOccupancy_9_gSimL3</queryRef>
                <queryRef>/SqOccupancy_10_gSimL3</queryRef>
                <queryRef>/SqOccupancy_11_gSimL3</queryRef>
                <queryRef>/SqOccupancy_12_gSimL3</queryRef>
                <queryRef>/SqOccupancy_13_gSimL3</queryRef>
                <queryRef>/SqOccupancy_14_gSimL3</queryRef>
                <queryRef>/SqOccupancy_15_gSimL3</queryRef>
                <queryRef>/SqOccupancy_16_gSimL3</queryRef>
                <queryRef>/SqOccupancy_17_gSimL3</queryRef>
                <queryRef>/SqOccupancy_18_gSimL3</queryRef>
                <queryRef>/SqOccupancy_19_gSimL3</queryRef>
                <queryRef>/SqOccupancy_20_gSimL3</queryRef>
                <queryRef>/SqOccupancy_21_gSimL3</queryRef>
                <queryRef>/SqOccupancy_22_gSimL3</queryRef>
                <queryRef>/SqOccupancy_23_gSimL3</queryRef>
                <queryRef>/SqOccupancy_24_gSimL3</queryRef>
                <queryRef>/SqOccupancy_25_gSimL3</queryRef>
                <queryRef>/SqOccupancy_26_gSimL3</queryRef>
                <queryRef>/SqOccupancy_27_gSimL3</queryRef>
                <queryRef>/SqOccupancy_28_gSimL3</queryRef>
                <queryRef>/SqOccupancy_29_gSimL3</queryRef>
                <queryRef>/SqOccupancy_30_gSimL3</queryRef>
                <queryRef>/SqOccupancy_31_gSimL3</queryRef>
                <queryRef>/SqOccupancy_32_gSimL3</queryRef>
                <queryRef>/SqOccupancy_33_gSimL3</queryRef>
                <queryRef>/SqOccupancy_34_gSimL3</queryRef>
                <queryRef>/SqOccupancy_35_gSimL3</queryRef>
                <queryRef>/SqOccupancy_36_gSimL3</queryRef>
                <queryRef>/SqOccupancy_37_gSimL3</queryRef>
                <queryRef>/SqOccupancy_38_gSimL3</queryRef>
                <queryRef>/SqOccupancy_39_gSimL3</queryRef>
                <queryRef>/SqOccupancy_40_gSimL3</queryRef>
                <queryRef>/SqOccupancy_41_gSimL3</queryRef>
                <queryRef>/SqOccupancy_42_gSimL3</queryRef>
                <queryRef>/SqOccupancy_43_gSimL3</queryRef>
                <queryRef>/SqOccupancy_44_gSimL3</queryRef>
                <queryRef>/SqOccupancy_45_gSimL3</queryRef>
                <queryRef>/SqOccupancy_46_gSimL3</queryRef>
                <queryRef>/SqOccupancy_47_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_traffic_clients">
          <rowSet displayName="L3 Requests from Diff Clients per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TrafficClients_0_gSimL3</queryRef>
                <queryRef>/TrafficClients_1_gSimL3</queryRef>
                <queryRef>/TrafficClients_2_gSimL3</queryRef>
                <queryRef>/TrafficClients_3_gSimL3</queryRef>
                <queryRef>/TrafficClients_4_gSimL3</queryRef>
                <queryRef>/TrafficClients_5_gSimL3</queryRef>
                <queryRef>/TrafficClients_6_gSimL3</queryRef>
                <queryRef>/TrafficClients_7_gSimL3</queryRef>
                <queryRef>/TrafficClients_8_gSimL3</queryRef>
                <queryRef>/TrafficClients_9_gSimL3</queryRef>
                <queryRef>/TrafficClients_10_gSimL3</queryRef>
                <queryRef>/TrafficClients_11_gSimL3</queryRef>
                <queryRef>/TrafficClients_12_gSimL3</queryRef>
                <queryRef>/TrafficClients_13_gSimL3</queryRef>
                <queryRef>/TrafficClients_14_gSimL3</queryRef>
                <queryRef>/TrafficClients_15_gSimL3</queryRef>
                <queryRef>/TrafficClients_16_gSimL3</queryRef>
                <queryRef>/TrafficClients_17_gSimL3</queryRef>
                <queryRef>/TrafficClients_18_gSimL3</queryRef>
                <queryRef>/TrafficClients_19_gSimL3</queryRef>
                <queryRef>/TrafficClients_20_gSimL3</queryRef>
                <queryRef>/TrafficClients_21_gSimL3</queryRef>
                <queryRef>/TrafficClients_22_gSimL3</queryRef>
                <queryRef>/TrafficClients_23_gSimL3</queryRef>
                <queryRef>/TrafficClients_24_gSimL3</queryRef>
                <queryRef>/TrafficClients_25_gSimL3</queryRef>
                <queryRef>/TrafficClients_26_gSimL3</queryRef>
                <queryRef>/TrafficClients_27_gSimL3</queryRef>
                <queryRef>/TrafficClients_28_gSimL3</queryRef>
                <queryRef>/TrafficClients_29_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_urb_banks">
          <rowSet displayName="Events Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/UrbBanks_0_gSimL3</queryRef>
                <queryRef>/UrbBanks_1_gSimL3</queryRef>
                <queryRef>/UrbBanks_2_gSimL3</queryRef>
                <queryRef>/UrbBanks_3_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_part_wr_combining">
          <rowSet displayName="Events Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/PartWrCombining_0_gSimL3</queryRef>
                <queryRef>/PartWrCombining_1_gSimL3</queryRef>
                <queryRef>/PartWrCombining_2_gSimL3</queryRef>
                <queryRef>/PartWrCombining_3_gSimL3</queryRef>
                <queryRef>/PartWrCombining_4_gSimL3</queryRef>
                <queryRef>/PartWrCombining_5_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="l3_gb_per_sec">
          <rowSet displayName="L3 Gigabytes Per Second">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GBperSec_0_gSimL3</queryRef>
                <queryRef>/GBperSec_1_gSimL3</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </configAreas>
    </config>
    <config id="gSimTimelineMemory">
      <configAreas>
        <area id="gti_requests">
          <rowSet displayName="GTI Requests">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GtiRequests_0_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GtiRequests_1_gSimMemory</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="gti_gam_traffic">
          <rowSet displayName="GAM traffic">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_0_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_1_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_2_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_3_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_4_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_5_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_6_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GamTraffic_7_gSimMemory</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="gti_traffic">
          <rowSet displayName="GTI Requests">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/GtiTraffic_0_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_1_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_2_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_3_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_4_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_5_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_6_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_7_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_8_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_9_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_10_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_11_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_12_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_13_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_14_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_15_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_16_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_17_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_18_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_19_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_20_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_21_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_22_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_23_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_24_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_25_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_26_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_27_gSimMemory</queryRef>
                <queryRef>/GtiTraffic_28_gSimMemory</queryRef>
                <displayAttributes>
                  <timelineFormat>area</timelineFormat>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineObjectType>interval</timelineObjectType>
              </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="gti_tlb_traffic">
          <rowSet displayName="TLB traffic">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_0_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_1_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_2_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_3_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_4_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_5_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_6_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_7_gSimMemory</queryRef>
              </drawBy>
            </layer>
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/TlbTraffic_8_gSimMemory</queryRef>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </configAreas>
    </config>
    <config id="gSimTimelineSampler">
      <configAreas>
        <area id="sampler_l1_hit_miss">
          <rowSet displayName="Sampler L1 Requests Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/L1HitMiss_0_gSimSampler</queryRef>
                <queryRef>/L1HitMiss_1_gSimSampler</queryRef>
                <queryRef>/L1HitMiss_2_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="sampler_l2_hit_miss">
          <rowSet displayName="Sampler L2 Requests Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SamplerL2HitMiss_0_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_1_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_2_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_3_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_4_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_5_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_6_gSimSampler</queryRef>
                <queryRef>/SamplerL2HitMiss_7_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="sampler_surface_format">
          <rowSet displayName="Events Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SurfaceFormat_0_gSimSampler</queryRef>
                <queryRef>/SurfaceFormat_1_gSimSampler</queryRef>
                <queryRef>/SurfaceFormat_2_gSimSampler</queryRef>
                <queryRef>/SurfaceFormat_3_gSimSampler</queryRef>
                <queryRef>/SurfaceFormat_4_gSimSampler</queryRef>
                <queryRef>/SurfaceFormat_5_gSimSampler</queryRef>
                <queryRef>/SurfaceFormat_6_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="sampler_bpt">
          <rowSet displayName="Events Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/SA_2_0_gSimSampler</queryRef>
                <queryRef>/SA_2_1_gSimSampler</queryRef>
                <queryRef>/SA_2_2_gSimSampler</queryRef>
                <queryRef>/SA_2_3_gSimSampler</queryRef>
                <queryRef>/SA_2_4_gSimSampler</queryRef>
                <queryRef>/SA_2_5_gSimSampler</queryRef>
                <queryRef>/SA_2_6_gSimSampler</queryRef>
                <queryRef>/SA_2_7_gSimSampler</queryRef>
                <queryRef>/SA_2_8_gSimSampler</queryRef>
                <queryRef>/SA_2_9_gSimSampler</queryRef>
                <queryRef>/SA_2_10_gSimSampler</queryRef>
                <queryRef>/SA_2_11_gSimSampler</queryRef>
                <queryRef>/SA_2_12_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="sampler_req_dimensions">
          <rowSet displayName="Request of Diff Dimensions Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/ReqDimensions_0_gSimSampler</queryRef>
                <queryRef>/ReqDimensions_1_gSimSampler</queryRef>
                <queryRef>/ReqDimensions_2_gSimSampler</queryRef>
                <queryRef>/ReqDimensions_3_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="sampler_st_bank_conflicts">
          <rowSet displayName="Bank Conflicts Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/StBankConflicts_0_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
        <area id="sampler_bank_breakdown">
          <rowSet displayName="L1 Banks Used Per Clock">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/BankBreakdown_0_gSimSampler</queryRef>
                <queryRef>/BankBreakdown_1_gSimSampler</queryRef>
                <queryRef>/BankBreakdown_2_gSimSampler</queryRef>
                <queryRef>/BankBreakdown_3_gSimSampler</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </configAreas>
    </config>
    <config id="gSimTimelineThreads">
      <configAreas>
        <area id="threads_threads_ffids">
          <rowSet displayName="Threads Active">
            <layer type="CountOverTime">
              <drawBy>
                <queryRef>/ThreadsFFIDs_0_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_1_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_2_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_3_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_4_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_5_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_6_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_7_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_8_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_9_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_10_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_11_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_12_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_13_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_14_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_15_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_16_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_17_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_18_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_19_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_20_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_21_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_22_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_23_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_24_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_25_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_26_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_27_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_28_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_29_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_30_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_31_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_32_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_33_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_34_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_35_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_36_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_37_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_38_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_39_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_40_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_41_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_42_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_43_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_44_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_45_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_46_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_47_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_48_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_49_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_50_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_51_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_52_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_53_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_54_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_55_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_56_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_57_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_58_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_59_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_60_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_61_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_62_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_63_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_64_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_65_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_66_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_67_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_68_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_69_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_70_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_71_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_72_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_73_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_74_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_75_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_76_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_77_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_78_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_79_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_80_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_81_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_82_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_83_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_84_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_85_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_88_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_89_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_90_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_91_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_92_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_93_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_94_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_95_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_96_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_97_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_98_gSimThreads</queryRef>
                <queryRef>/ThreadsFFIDs_99_gSimThreads</queryRef>
                <displayAttributes>
                  <minimumResolutionms>0</minimumResolutionms>
                  <timelineFormat>area</timelineFormat>
                  <timelineObjectType>interval</timelineObjectType>
                </displayAttributes>
              </drawBy>
            </layer>
          </rowSet>
        </area>
      </configAreas>
    </config>
  </bag>
  </xsl:template>
</xsl:stylesheet>
