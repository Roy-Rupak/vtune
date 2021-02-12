<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
    syntax="norules"    >
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="useEventBasedCounts">false</xsl:param>
  <xsl:template match="/">
    <xsl:variable name="SAVDEFAULT">
      <xsl:text>:sa=</xsl:text>
      <xsl:value-of select="format-number(round(exsl:ctx('referenceFrequency', 1000000000) * (1.0 div 1000)), '#')"/>
    </xsl:variable>
    <xsl:variable name="SAV2MDEFAULT"><xsl:text>:sa=2000003</xsl:text></xsl:variable>
    <xsl:variable name="SAV1MDEFAULT"><xsl:text>:sa=1000003</xsl:text></xsl:variable>
    <xsl:variable name="SAV200KDEFAULT"><xsl:text>:sa=200003</xsl:text></xsl:variable>
    <xsl:variable name="SAV100KDEFAULT"><xsl:text>:sa=100003</xsl:text></xsl:variable>
    <xsl:variable name="SAV50KDEFAULT"><xsl:text>:sa=50003</xsl:text></xsl:variable>
    <xsl:variable name="SAV10KDEFAULT"><xsl:text>:sa=10003</xsl:text></xsl:variable>
    <xsl:variable name="SAV">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAVDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="SAV2M">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAV2MDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="SAV1M">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAV1MDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="SAV200K">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAV200KDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="SAV100K">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAV100KDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="SAV50K">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAV50KDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="SAV10K">
      <xsl:if test="$useEventBasedCounts='false'"><xsl:value-of select="$SAV10KDEFAULT"/></xsl:if>
    </xsl:variable>
    <xsl:variable name="pmuCommon" select="document('config://include/pmu_common.xsl')"/>
    <xsl:variable name="tmamEventsFile" select="$pmuCommon//variables/tmamEventsFile"/>
    <events>
      <cpi>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'core'">
            <xsl:text>CPU_CLK_UNHALTED</xsl:text>
            <xsl:value-of select="$SAV"></xsl:value-of>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'nhm') or (exsl:ctx('PMU') = 'corei7') or (exsl:ctx('PMU') = 'corei7wsp')  or (exsl:ctx('PMU') = 'corei7wdp') or (exsl:ctx('PMU') = 'corei7b')">
            <xsl:choose>
              <xsl:when test="exsl:ctx('PerfmonVersion', '4') = '1'">
                <xsl:value-of select="concat(
                              'CPU_CLK_UNHALTED.THREAD_P_ANY',$SAV,
                              ',INST_RETIRED.ANY_P:sample',$SAVDEFAULT)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('CPU_CLK_UNHALTED.THREAD',$SAV)"/>
                <xsl:text>,CPU_CLK_UNHALTED.REF_P:sample:sa</xsl:text>
                <xsl:value-of select="round(133000000 * (1.0 div 1000))"></xsl:value-of>
                <xsl:value-of select="concat(',INST_RETIRED.ANY:sample',$SAVDEFAULT)"/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'atom') or (exsl:ctx('PMU') = 'core2') or (exsl:ctx('PMU') = 'core2p')">
            <xsl:value-of select="concat('CPU_CLK_UNHALTED.CORE',$SAV)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF:sample',$SAVDEFAULT)"/>
            <xsl:value-of select="concat(',INST_RETIRED.ANY:sample',$SAVDEFAULT)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'silvermont') or (exsl:ctx('PMU') = 'airmont') or (exsl:ctx('PMU') = 'goldmont') or (exsl:ctx('PMU') = 'goldmont_plus') or (exsl:ctx('PMU') = 'lakemont') or (exsl:ctx('PMU') = 'snowridge') or (exsl:ctx('PMU') = 'elkhartlake')">
            <xsl:value-of select="concat('CPU_CLK_UNHALTED.CORE',$SAV)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_TSC:sample',$SAVDEFAULT)"/>
            <xsl:value-of select="concat(',INST_RETIRED.ANY:sample',$SAVDEFAULT)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'knl')">
            <xsl:value-of select="concat('CPU_CLK_UNHALTED.THREAD',$SAV)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_TSC:sample',$SAVDEFAULT)"/>
            <xsl:value-of select="concat(',INST_RETIRED.ANY:sample',$SAVDEFAULT)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exsl:ctx('PerfmonVersion', '4') = '1'">
                <xsl:value-of select="concat(
                              'CPU_CLK_UNHALTED.THREAD_P_ANY',$SAV,
                              ',INST_RETIRED.ANY_P:sample',$SAVDEFAULT)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat('CPU_CLK_UNHALTED.THREAD',$SAV)"/>
                <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_TSC:sample',$SAVDEFAULT)"/>
                <xsl:value-of select="concat(',INST_RETIRED.ANY:sample',$SAVDEFAULT)"/>
                <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_XCLK',$SAV100K)"/>
                <xsl:value-of select="concat(',CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE',$SAV100K)"/>
                <xsl:choose>
                  <xsl:when test="(exsl:ctx('PMU') = 'snb') or (exsl:ctx('PMU') = 'snbep') or (exsl:ctx('PMU') = 'ivybridge') or (exsl:ctx('PMU') = 'ivytown') or (exsl:ctx('PMU') = 'haswell') or (exsl:ctx('PMU') = 'crystalwell') or (exsl:ctx('PMU') = 'haswell_server') or (exsl:ctx('PMU') = 'broadwell') or (exsl:ctx('PMU') = 'broadwell_de') or (exsl:ctx('PMU') = 'broadwell_server') or (exsl:ctx('PMU') = 'skylake') or (exsl:ctx('PMU') = 'skylake_server') or (exsl:ctx('PMU') = 'cascadelake_server')">
                  </xsl:when>
                  <xsl:when test="(exsl:ctx('PMU') = 'lakefield')">
                    <xsl:value-of select="concat(',CPU_CLK_UNHALTED.CORE',$SAV)"/>
                  </xsl:when>
                  <xsl:when test="(exsl:ctx('PMU') = 'cannonlake')">
                    <xsl:value-of select="concat(',CPU_CLK_UNHALTED.CORE',$SAV)"/>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="concat(',CPU_CLK_UNHALTED.DISTRIBUTED',$SAV)"/>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </cpi>
      <memboundHPC>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake' or exsl:ctx('PMU') = 'sapphirerapids'">
            <xsl:value-of select="document($tmamEventsFile)/main/HPC_Tree/BaseEvents"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake'">
            <xsl:value-of select="concat('CYCLE_ACTIVITY.STALLS_L1D_MISS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L2_MISS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L3_MISS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_MEM_ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',EXE_ACTIVITY.1_PORTS_UTIL',$SAV2M)"/>
            <xsl:value-of select="concat(',EXE_ACTIVITY.2_PORTS_UTIL',$SAV2M)"/>
            <xsl:value-of select="concat(',EXE_ACTIVITY.BOUND_ON_STORES',$SAV2M)"/>
            <xsl:value-of select="concat(',EXE_ACTIVITY.EXE_BOUND_0_PORTS',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',INT_MISC.RECOVERY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_ISSUED.ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_RETIRED.L3_MISS_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',L1D_PEND_MISS.FB_FULL:cmask=1',$SAV2M)"/>
            <xsl:value-of select="concat(',L1D_PEND_MISS.PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_RETIRED.FB_HIT_PS',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_RETIRED.L1_MISS_PS',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_RETIRED.L2_HIT_PS',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_RETIRED.L3_HIT_PS',$SAV200K)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4',$SAV2M)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_INST_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_INST_RETIRED.ALL_STORES_PS',$SAV100K)"/>
            <xsl:if test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server'">
              <xsl:value-of select="concat(',MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_L3_MISS_RETIRED.REMOTE_DRAM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD',$SAV100K)"/>
            </xsl:if>
            <xsl:if test="exsl:ctx('PMU') = 'cascadelake_server'">
              <xsl:value-of select="concat(',MEM_LOAD_RETIRED.LOCAL_PMM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_L3_MISS_RETIRED.REMOTE_PMM_PS',$SAV100K)"/>
              <xsl:if test="exsl:ctx('Hypervisor', 'None') = 'None' or (exsl:ctx('Hypervisor', 'None') = 'Microsoft Hv' and exsl:ctx('HypervisorType', 'None') = 'Hyper-V')">
                <xsl:value-of select="concat(',OCR.ALL_READS.L3_MISS_LOCAL_DRAM.ANY_SNOOP',$SAV100K)"/>
                <xsl:value-of select="concat(',OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP',$SAV100K)"/>
              </xsl:if>
            </xsl:if>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE',$SAV10K)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_XCLK',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'broadwell') or (exsl:ctx('PMU') = 'broadwell_de') or (exsl:ctx('PMU') = 'broadwell_server')">
            <xsl:value-of select="concat('CYCLE_ACTIVITY.STALLS_L1D_MISS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L2_MISS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_MEM_ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_TOTAL',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',INT_MISC.RECOVERY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.L3_HIT_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.L3_MISS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',RESOURCE_STALLS.SB',$SAV2M)"/>
            <xsl:value-of select="concat(',RS_EVENTS.EMPTY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=1',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=2',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=3',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_ISSUED.ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=4',$SAV2M)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES_PS',$SAV100K)"/>
            <xsl:if test="exsl:ctx('PMU') = 'broadwell_server'">
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_PS',$SAV100K)"/>
              <xsl:if test="exsl:ctx('Hypervisor', 'None') = 'None' or (exsl:ctx('Hypervisor', 'None') = 'Microsoft Hv' and exsl:ctx('HypervisorType', 'None') = 'Hyper-V')">
                <xsl:value-of select="concat(',OFFCORE_RESPONSE:request=ALL_READS:response=LLC_MISS.LOCAL_DRAM',$SAV100K)"/>
                <xsl:value-of select="concat(',OFFCORE_RESPONSE:request=ALL_READS:response=LLC_MISS.REMOTE_DRAM',$SAV100K)"/>
              </xsl:if>
            </xsl:if>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE',$SAV10K)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_XCLK',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'ivybridge') or (exsl:ctx('PMU') = 'ivytown')">
            <xsl:value-of select="concat('CYCLE_ACTIVITY.CYCLES_NO_EXECUTE',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L1D_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L2_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_LDM_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',INT_MISC.RECOVERY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.LLC_HIT_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.LLC_MISS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD',$SAV2M)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=6',$SAV2M)"/>
            <xsl:value-of select="concat(',RESOURCE_STALLS.SB',$SAV2M)"/>
            <xsl:value-of select="concat(',RS_EVENTS.EMPTY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CYCLES_GE_1_UOP_EXEC',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CYCLES_GE_2_UOPS_EXEC',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CYCLES_GE_3_UOPS_EXEC',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=1',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=2',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=3',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_ISSUED.ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES_PS',$SAV100K)"/>
            <xsl:if test="exsl:ctx('PMU') = 'ivytown'">
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_MISS_RETIRED.LOCAL_DRAM',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_DRAM',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_HITM',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_MISS_RETIRED.REMOTE_FWD',$SAV100K)"/>
            </xsl:if>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE',$SAV10K)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_XCLK',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'haswell')  or (exsl:ctx('PMU') = 'crystalwell') or (exsl:ctx('PMU') = 'haswell_server')">
            <xsl:value-of select="concat('CYCLE_ACTIVITY.CYCLES_NO_EXECUTE',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L1D_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_LDM_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L2_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',INT_MISC.RECOVERY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.L3_HIT_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.L3_MISS_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD',$SAV2M)"/>
            <xsl:value-of select="concat(',OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=6',$SAV2M)"/>
            <xsl:value-of select="concat(',RESOURCE_STALLS.SB',$SAV2M)"/>
            <xsl:value-of select="concat(',RS_EVENTS.EMPTY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=1',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=2',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE:cmask=3',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_ISSUED.ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES_PS',$SAV100K)"/>
            <xsl:if test="exsl:ctx('PMU') = 'haswell_server'">
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.LOCAL_DRAM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_DRAM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_HITM_PS',$SAV100K)"/>
              <xsl:value-of select="concat(',MEM_LOAD_UOPS_L3_MISS_RETIRED.REMOTE_FWD_PS',$SAV100K)"/>
            </xsl:if>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE',$SAV10K)"/>
            <xsl:value-of select="concat(',CPU_CLK_UNHALTED.REF_XCLK',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'knl'">
            <xsl:value-of select="concat('MEM_UOPS_RETIRED.L2_MISS_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.L2_HIT_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.ALL',$SAV2M)"/>
            <xsl:value-of select="concat(',NO_ALLOC_CYCLES.MISPREDICTS',$SAV2M)"/>
            <xsl:value-of select="concat(',NO_ALLOC_CYCLES.NOT_DELIVERED',$SAV2M)"/>
            <xsl:value-of select="concat(',L2_PREFETCHER.ALLOC_XQ',$SAV100K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snb'">
            <xsl:value-of select="concat('CYCLE_ACTIVITY.CYCLES_NO_DISPATCH',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L1D_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',INT_MISC.RECOVERY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',RESOURCE_STALLS.SB',$SAV2M)"/>
            <xsl:value-of select="concat(',RS_EVENTS.EMPTY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_DISPATCHED.THREAD',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_ISSUED.ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L2_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.LLC_HIT_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM_PS',$SAV50K)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE_CYCLES_GE_1',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE_CYCLES_GE_2',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE_CYCLES_GE_3',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES_PS',$SAV100K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snbep'">
            <xsl:value-of select="concat('CYCLE_ACTIVITY.CYCLES_NO_DISPATCH',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L1D_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',IDQ_UOPS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE',$SAV2M)"/>
            <xsl:value-of select="concat(',INT_MISC.RECOVERY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',RESOURCE_STALLS.SB',$SAV2M)"/>
            <xsl:value-of select="concat(',RS_EVENTS.EMPTY_CYCLES',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_DISPATCHED.THREAD',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_ISSUED.ANY',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
            <xsl:value-of select="concat(',CYCLE_ACTIVITY.STALLS_L2_PENDING',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.LLC_HIT',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.LLC_MISS',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_NONE',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HIT',$SAV50K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_LLC_HIT_RETIRED.XSNP_HITM',$SAV50K)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE_CYCLES_GE_1',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE_CYCLES_GE_2',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.CORE_CYCLES_GE_3',$SAV2M)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES_PS',$SAV100K)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </memboundHPC>
      <memAccess>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'core2' or exsl:ctx('PMU') = 'core2p'">
            <xsl:value-of select="concat('BUS_DRDY_CLOCKS.THIS_AGENT',$SAV100K)"/>
            <xsl:value-of select="concat(',BUS_TRANS_BURST.SELF',$SAV200K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'corei7b'">
            <xsl:value-of select="concat('OFFCORE_RESPONSE_0.DEMAND_DATA_RD.ANY_LLC_MISS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_INST_RETIRED.LOADS',$SAV2M)"/>
            <xsl:text>,UNC_M_B_CMD.RD_BCMD</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snb'">
            <xsl:value-of select="concat('MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snbep'">
            <xsl:value-of select="concat('MEM_LOAD_UOPS_RETIRED.LLC_MISS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'ivybridge' or exsl:ctx('PMU') = 'ivytown' or exsl:ctx('PMU') = 'haswell' or exsl:ctx('PMU') = 'crystalwell' or exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell' or exsl:ctx('PMU') = 'broadwell_de' or exsl:ctx('PMU') = 'broadwell_server'">
            <xsl:value-of select="concat('MEM_UOPS_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4',$SAV10K)"/>
            <xsl:if test="exsl:ctx('PMU') = 'broadwell_server'">
              <xsl:if test="exsl:ctx('Hypervisor', 'None') = 'None' or (exsl:ctx('Hypervisor', 'None') = 'Microsoft Hv' and exsl:ctx('HypervisorType', 'None') = 'Hyper-V')">
                <xsl:value-of select="concat(',OFFCORE_RESPONSE:request=ALL_READS:response=LLC_MISS.LOCAL_DRAM',$SAV100K)"/>
                <xsl:value-of select="concat(',OFFCORE_RESPONSE:request=ALL_READS:response=LLC_MISS.REMOTE_DRAM',$SAV100K)"/>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake'">
            <xsl:value-of select="concat('MEM_INST_RETIRED.ALL_LOADS_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_INST_RETIRED.ALL_STORES_PS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4',$SAV10K)"/>
            <xsl:if test="exsl:ctx('PMU') = 'cascadelake_server'">
              <xsl:if test="exsl:ctx('Hypervisor', 'None') = 'None' or (exsl:ctx('Hypervisor', 'None') = 'Microsoft Hv' and exsl:ctx('HypervisorType', 'None') = 'Hyper-V')">
                <xsl:value-of select="concat(',OCR.ALL_READS.L3_MISS_LOCAL_DRAM.ANY_SNOOP',$SAV100K)"/>
                <xsl:value-of select="concat(',OCR.ALL_READS.L3_MISS_REMOTE_HOP1_DRAM.ANY_SNOOP',$SAV100K)"/>
              </xsl:if>
            </xsl:if>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake' or exsl:ctx('PMU') = 'sapphirerapids'">
            <xsl:value-of select="concat('MEM_INST_RETIRED.ALL_LOADS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_INST_RETIRED.ALL_STORES',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4',$SAV10K)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snowridge'">
            <xsl:value-of select="concat('MEM_UOPS_RETIRED.ALL_LOADS',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_UOPS_RETIRED.ALL_STORES',$SAV100K)"/>
            <xsl:value-of select="concat(',MEM_LOAD_UOPS_RETIRED.DRAM_HIT',$SAV100K)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </memAccess>
      <fpu>
        <xsl:choose>
          <xsl:when test="(exsl:ctx('PMU') = 'ivybridge') or (exsl:ctx('PMU') = 'ivytown')">
            <xsl:value-of select="concat('FP_COMP_OPS_EXE.SSE_PACKED_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_COMP_OPS_EXE.SSE_PACKED_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',SIMD_FP_256.PACKED_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',SIMD_FP_256.PACKED_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_COMP_OPS_EXE.SSE_SCALAR_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_COMP_OPS_EXE.SSE_SCALAR_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_COMP_OPS_EXE.X87',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.THREAD',$SAV2M)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'broadwell') or (exsl:ctx('PMU') = 'broadwell_de') or (exsl:ctx('PMU') = 'broadwell_server')">
            <xsl:value-of select="concat('FP_ARITH_INST_RETIRED.SCALAR_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.SCALAR_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',INST_RETIRED.X87',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake' or exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake' or exsl:ctx('PMU') = 'sapphirerapids')">
            <xsl:value-of select="concat('FP_ARITH_INST_RETIRED.SCALAR_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.SCALAR_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE',$SAV2M)"/>
            <xsl:value-of select="concat(',UOPS_EXECUTED.X87',$SAV2M)"/>
            <xsl:choose>
              <xsl:when test="(exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake')">
                <xsl:value-of select="concat(',UOPS_RETIRED.RETIRE_SLOTS',$SAV2M)"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="concat(',UOPS_RETIRED.SLOTS',$SAV2M)"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:value-of select="concat(',UOPS_EXECUTED.THREAD',$SAV2M)"/>
            <xsl:if test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake' or exsl:ctx('PMU') = 'sapphirerapids'">
              <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE',$SAV2M)"/>
              <xsl:value-of select="concat(',FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE',$SAV2M)"/>
            </xsl:if>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'knl')">
            <xsl:value-of select="concat('UOPS_RETIRED.SCALAR_SIMD',$SAV200K)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.PACKED_SIMD',$SAV200K)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </fpu>
      <retired>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'knl' or exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont'">
            <xsl:value-of select="concat('UOPS_RETIRED.ALL:sample',$SAV2MDEFAULT)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'goldmont'">
            <xsl:value-of select="concat('UOPS_RETIRED.ANY:sample',$SAV2MDEFAULT)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snowridge'">
            <xsl:value-of select="concat('TOPDOWN_RETIRING.ALL:sample',$SAV2MDEFAULT)"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake' or exsl:ctx('PMU') = 'sapphirerapids'">
            <xsl:value-of select="concat('TOPDOWN.SLOTS:sample',$SAV2MDEFAULT)"/>
            <xsl:value-of select="concat(',UOPS_RETIRED.SLOTS:sample',$SAV2MDEFAULT)"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('UOPS_RETIRED.RETIRE_SLOTS:sample',$SAV2MDEFAULT)"/>
          </xsl:otherwise>
        </xsl:choose>
      </retired>
      <retired_perf_metrics>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake' or exsl:ctx('PMU') = 'sapphirerapids'">
            <xsl:value-of select="concat('TOPDOWN.SLOTS:perf_metrics',$SAV2MDEFAULT)"/>
          </xsl:when>
        </xsl:choose>
      </retired_perf_metrics>
      <pgo>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'nhm' or exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b'">
            <xsl:text>BR_INST_RETIRED.NEAR_CALL_R3</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'atom' or exsl:ctx('PMU') = 'core2' or exsl:ctx('PMU') = 'core2p'">
            <xsl:value-of select="concat('BR_INST_RETIRED.TAKEN',$SAV200K, 'usr=yes:os=no')"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont'">
            <xsl:text>BR_INST_RETIRED.ALL_TAKEN_BRANCHES</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="concat('BR_INST_RETIRED.NEAR_TAKEN',$SAV200K, 'usr=yes:os=no')"/>
          </xsl:otherwise>
        </xsl:choose>
      </pgo>
    </events>
  </xsl:template>
</xsl:stylesheet>
