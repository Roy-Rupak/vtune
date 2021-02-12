<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
    xmlns:str="http://exslt.org/strings" syntax="norules">
  <xsl:output indent="yes" method="xml"/>
  <xsl:param name="referenceFrequency">
    <xsl:value-of select="exsl:ctx('referenceFrequency', 1)"/>
  </xsl:param>
  <xsl:variable name="specifics" select="document('config://include/pmu_common_specifics.xsl')"/>
  <xsl:template match="/">
    <variables>
      <xsl:variable name="isVisaAvailable">
        <xsl:for-each select="str:tokenize(exsl:ctx('availablePmuTypes',''), ',')">
          <xsl:if test=".='sa' ">
             <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:for-each>
      </xsl:variable>
      <visaAvailable>
        <xsl:value-of select="$isVisaAvailable"/>
      </visaAvailable>
      <forceIMCBandwidthOnAtom>
        <xsl:choose>
          <xsl:when test="(exsl:ctx('PMU') = 'goldmont' or exsl:ctx('PMU') = 'goldmont_plus') and
               (exsl:is_experimental('force_imc_bandwidth') or $isVisaAvailable != 'true')">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </forceIMCBandwidthOnAtom>
      <clockticksEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'lwt-simics'">
            <xsl:text>totalCycles</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('clockticksEventName')">
            <xsl:copy-of select="exsl:ctx('clockticksEventName')"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'core' or exsl:ctx('PMU') = 'miccore' or exsl:ctx('PMU') = 'knc'">
            <xsl:text>CPU_CLK_UNHALTED</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'core2' or exsl:ctx('PMU') = 'core2p' or exsl:ctx('PMU') = 'atom' or exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont' or exsl:ctx('PMU') = 'goldmont' or exsl:ctx('PMU') = 'goldmont_plus' or exsl:ctx('PMU') = 'lakemont' or exsl:ctx('PMU') = 'snowridge' or exsl:ctx('PMU') = 'elkhartlake'">
            <xsl:text>CPU_CLK_UNHALTED.CORE</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'sniper'">
            <xsl:text>CPU_CLK_UNHALTED.REF</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'na'">
            <xsl:text>Cycle Count Register</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('collectFullProcTrace', 0)">
            <xsl:text>PT_CLOCKTICKS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exsl:ctx('PerfmonVersion', '4') = '1'">
                <xsl:text>CPU_CLK_UNHALTED.THREAD_P_ANY</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>CPU_CLK_UNHALTED.THREAD</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </clockticksEvent>
      <refClockticksEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'lwt-simics'">
            <xsl:text>totalCycles</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('clockticksEventName')">
            <xsl:copy-of select="exsl:ctx('clockticksEventName')"/>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'core' or exsl:ctx('PMU') = 'miccore' or exsl:ctx('PMU') = 'knc'">
            <xsl:text>CPU_CLK_UNHALTED</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b'">
            <xsl:text>CPU_CLK_UNHALTED.REF_P</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'core2' or exsl:ctx('PMU') = 'core2p' or exsl:ctx('PMU') = 'atom' or exsl:ctx('PMU') = 'sniper'">
            <xsl:text>CPU_CLK_UNHALTED.REF</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'na'">
            <xsl:text>Cycle Count Register</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('collectFullProcTrace', 0)">
            <xsl:text>PT_CLOCKTICKS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exsl:ctx('PerfmonVersion', '4') = '1'">
                <xsl:text>CPU_CLK_UNHALTED.THREAD_P_ANY</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>CPU_CLK_UNHALTED.REF_TSC</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </refClockticksEvent>
      <factorFromRefClkToTsc>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b'">
            <xsl:text>133000000</xsl:text>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont' or exsl:ctx('PMU') = 'goldmont') and exsl:ctx('cpuFamily') = 6 and exsl:ctx('cpuModel') = 93">
            <xsl:text>9360000000</xsl:text>
          </xsl:when>
          <xsl:when test="(exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont' or exsl:ctx('PMU') = 'goldmont') and exsl:ctx('cpuFamily') = 6 and exsl:ctx('cpuModel') = 101">
            <xsl:text>3744000000</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="format-number($referenceFrequency, '#')"/>
          </xsl:otherwise>
        </xsl:choose>
      </factorFromRefClkToTsc>
      <instructionsEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'lwt-simics'">
            <xsl:text>totalInstructions</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'core' or exsl:ctx('PMU') = 'miccore' or exsl:ctx('PMU') = 'knc'">
            <xsl:text>INSTRUCTIONS_EXECUTED</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'na'">
            <xsl:text>Instruction Count</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('collectFullProcTrace', 0)">
            <xsl:text>PT_INSTRUCTIONS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="exsl:ctx('PerfmonVersion', '4') = '1'">
                <xsl:text>INST_RETIRED.ANY_P</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>INST_RETIRED.ANY</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </instructionsEvent>
      <xsl:variable name="programmableClockticksEvent">
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'core2' or
                          exsl:ctx('PMU') = 'core2p' or
                          exsl:ctx('PMU') = 'atom' or
                          exsl:ctx('PMU') = 'silvermont' or
                          exsl:ctx('PMU') = 'airmont' or
                          exsl:ctx('PMU') = 'goldmont' or
                          exsl:ctx('PMU') = 'goldmont_plus' or
                          exsl:ctx('PMU') = 'lakemont' or
                          exsl:ctx('PMU') = 'snowridge' or
                          exsl:ctx('PMU') = 'elkhartlake'">
            <xsl:text>CPU_CLK_UNHALTED.CORE_P</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>CPU_CLK_UNHALTED.THREAD_P</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <programmableClockticksEvent>
        <xsl:value-of select="$programmableClockticksEvent"/>
      </programmableClockticksEvent>
      <ring123Event>
        <xsl:value-of select="concat($programmableClockticksEvent, ':sample:sa=1:cmask=1:e=yes:os=no:usr=yes:ctxsw:mg')"/>
      </ring123Event>
      <callCountQueryEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b'">
            <xsl:text>BR_INST_RETIRED.NEAR_CALL_R3</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont'">
            <xsl:text>BR_INST_RETIRED.CALL_PS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>CALL_COUNT</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </callCountQueryEvent>
      <memBandwidthEvents>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont'">
            <xsl:text>UNC_SOC_Memory_DDR_BW</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'goldmont' or exsl:ctx('PMU') = 'goldmont_plus'">
            <xsl:choose>
              <xsl:when test="exsl:is_experimental('force_imc_bandwidth') or $isVisaAvailable != 'true'">
                <xsl:text>UNC_IMC_DRAM_RW_SLICE0,UNC_IMC_DRAM_RW_SLICE1</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>UNC_SOC_All_BW</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snb' or exsl:ctx('PMU') = 'ivybridge'">
            <xsl:text>UNC_IMC_DATA_READS,UNC_IMC_DATA_WRITES</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'haswell' or exsl:ctx('PMU') = 'crystalwell' or exsl:ctx('PMU') = 'broadwell' or (exsl:ctx('PMU') = 'skylake' and exsl:ctx('targetOS', '') != 'MacOSX') or exsl:ctx('PMU') = 'cannonlake' or exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'tigerlake'">
            <xsl:text>UNC_IMC_DRAM_DATA_READS,UNC_IMC_DRAM_DATA_WRITES</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' and exsl:ctx('targetOS', '') = 'MacOSX'">
            <xsl:text>UNC_IMC_DRAM_GT_REQUESTS,UNC_IMC_DRAM_IA_REQUESTS,UNC_IMC_DRAM_IO_REQUESTS,UNC_IMC_DRAM_DATA_READS,UNC_IMC_DRAM_DATA_WRITES,UNC_EDRAM_RD_HIT:filter0=0x7,UNC_EDRAM_RD_MISS,UNC_EDRAM_PTLWR_HIT,UNC_EDRAM_PTLWR_MISS,UNC_EDRAM_WR_HIT,UNC_EDRAM_WR_MISS</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snbep' or exsl:ctx('PMU') = 'ivytown' or exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell_de' or exsl:ctx('PMU') = 'broadwell_server'">
            <xsl:text>UNC_M_CAS_COUNT.RD,UNC_M_CAS_COUNT.WR</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'skylake_server'">
            <xsl:text>UNC_M_CAS_COUNT.RD,UNC_M_CAS_COUNT.WR</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'sapphirerapids'">
            <xsl:text>UNC_M_CAS_COUNT.RD,UNC_M_CAS_COUNT.WR,UNC_M_TAGCHK.MISS_CLEAN,UNC_M_TAGCHK.MISS_DIRTY,UNC_M2M_IMC_READS.TO_PMM,UNC_M2M_IMC_WRITES.TO_PMM,UNC_M2M_TAG_HIT.NM_RD_HIT_CLEAN,UNC_M2M_TAG_HIT.NM_RD_HIT_DIRTY</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'snowridge'">
            <xsl:text>UNC_M_CAS_COUNT.RD,UNC_M_CAS_COUNT.WR</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'knl'">
            <xsl:text>UNC_M_CAS_COUNT.RD,UNC_M_CAS_COUNT.WR,UNC_E_RPQ_INSERTS,UNC_E_WPQ_INSERTS,UNC_E_EDC_ACCESS.HIT_CLEAN,UNC_E_EDC_ACCESS.HIT_DIRTY,UNC_E_EDC_ACCESS.MISS_CLEAN,UNC_E_EDC_ACCESS.MISS_DIRTY</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'knc'">
            <xsl:text>UNC_F_CH0_NORMAL_WRITE,UNC_F_CH0_NORMAL_READ,UNC_F_CH1_NORMAL_WRITE,UNC_F_CH1_NORMAL_READ</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </memBandwidthEvents>
      <qpiBandwidthEvents>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'ivytown' or exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell_de' or exsl:ctx('PMU') = 'broadwell_server'">
            <xsl:text>UNC_Q_TxL_FLITS_G0.DATA,UNC_Q_TxL_FLITS_G0.NON_DATA,UNC_Q_RxL_FLITS_G1.DRS_DATA,UNC_Q_RxL_FLITS_G2.NCB_DATA</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'sapphirerapids'">
            <xsl:text>UNC_UPI_TxL_FLITS.ALL_DATA,UNC_UPI_TxL_FLITS.NON_DATA,UNC_UPI_CLOCKTICKS,UNC_UPI_L1_POWER_CYCLES</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </qpiBandwidthEvents>
      <isPeciseClockticksAvailable>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'snb'
              or exsl:ctx('PMU') = 'ivybridge'
              or exsl:ctx('PMU') = 'snbep'
              or exsl:ctx('PMU') = 'ivytown'
              or exsl:ctx('PMU') = 'haswell'
              or exsl:ctx('PMU') = 'haswell_server'
              or exsl:ctx('PMU') = 'crystalwell'
              or exsl:ctx('PMU') = 'broadwell'
              or exsl:ctx('PMU') = 'broadwell_de'
              or exsl:ctx('PMU') = 'broadwell_server'
              or exsl:ctx('PMU') = 'skylake'
              or exsl:ctx('PMU') = 'skylake_server'
              or exsl:ctx('PMU') = 'cascadelake_server'
              or exsl:ctx('PMU') = 'cannonlake'">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isPeciseClockticksAvailable>
      <peciseClockticksEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake'">
            <xsl:text>INST_RETIRED.TOTAL_CYCLES_PS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>INST_RETIRED.PREC_DIST:cmask=10:inv=yes</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </peciseClockticksEvent>
      <peciseClockticksEventNameOnly>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake'">
            <xsl:text>INST_RETIRED.TOTAL_CYCLES_PS</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>INST_RETIRED.PREC_DIST</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </peciseClockticksEventNameOnly>
      <isLbrStackAvailable>
        <xsl:choose>
          <xsl:when test="not(contains(exsl:ctx('Hypervisor', 'None'),'KVM') or contains(exsl:ctx('Hypervisor', 'None'),'VMware')) and (exsl:ctx('PMU') = 'haswell' or exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell' or exsl:ctx('PMU') = 'broadwell_de' or exsl:ctx('PMU') = 'broadwell_server' or exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'cannonlake' or exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'sapphirerapids' or exsl:ctx('PMU') = 'goldmont' or exsl:ctx('PMU') = 'goldmont_plus' or exsl:ctx('PMU') = 'tigerlake')">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isLbrStackAvailable>
      <isPTAvailable>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'broadwell' or exsl:ctx('PMU') = 'broadwell_de' or exsl:ctx('PMU') = 'broadwell_server' or exsl:ctx('PMU') = 'skylake' or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server'">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isPTAvailable>
      <isTripCountsAvailable>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b' or exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont' or exsl:ctx('PMU') = 'knl'">
            <xsl:text>false</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>true</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isTripCountsAvailable>
      <callCountsEvents>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'nhm' or exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b'">
            <xsl:text>BR_INST_RETIRED.NEAR_CALL_R3</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'atom' or exsl:ctx('PMU') = 'core2' or exsl:ctx('PMU') = 'core2p'">
            <xsl:text>BR_INST_RETIRED.TAKEN:sa=200003:usr=yes:os=no</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont'">
            <xsl:text>BR_INST_RETIRED.CALL_PS</xsl:text>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'goldmont'">
            <xsl:text>BR_INST_RETIRED.ALL_TAKEN_BRANCHES:sa=200003:usr=yes:os=no</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>BR_INST_RETIRED.NEAR_TAKEN:sa=200003:usr=yes:os=no</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </callCountsEvents>
      <takenBranchesEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'nhm' or exsl:ctx('PMU') = 'corei7' or exsl:ctx('PMU') = 'corei7wsp' or exsl:ctx('PMU') = 'corei7wdp' or exsl:ctx('PMU') = 'corei7b'">
            <name>BR_INST_EXEC.TAKEN</name>
            <modifiers>:sa=49999:usr=yes:os=no</modifiers>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'atom' or exsl:ctx('PMU') = 'core2' or exsl:ctx('PMU') = 'core2p'">
            <name>BR_INST_RETIRED.TAKEN</name>
            <modifiers>:sa=49999:usr=yes:os=no</modifiers>
          </xsl:when>
          <xsl:when test="exsl:ctx('PMU') = 'silvermont' or exsl:ctx('PMU') = 'airmont' or exsl:ctx('PMU') = 'goldmont'">
            <name>BR_INST_RETIRED.ALL_TAKEN_BRANCHES</name>
            <modifiers></modifiers>
          </xsl:when>
          <xsl:otherwise>
            <name>BR_INST_RETIRED.NEAR_TAKEN</name>
            <modifiers>:sa=49999:usr=yes:os=no</modifiers>
          </xsl:otherwise>
        </xsl:choose>
      </takenBranchesEvent>
      <isPerfBWAvailable>
        <xsl:choose>
          <xsl:when test="(exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='NotAvailable' and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='Kernel' and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='User' and contains(exsl:ctx('LinuxPerfCapabilities', ''), 'format') and contains(exsl:ctx('LinuxPerfCapabilities', 'NotAvailable'), 'uncore_imc')) and not((exsl:ctx('PMU')='haswell' or exsl:ctx('PMU') = 'broadwell') and
                                  contains(exsl:ctx('LinuxRelease', ''), '3.10.0-327.el7.'))">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isPerfBWAvailable>
      <isDRAMBWAvailable>
        <xsl:choose>
          <xsl:when test="exsl:ctx('isSEPDriverAvailable', 0) or (exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='NotAvailable' and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='Kernel' and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='User' and contains(exsl:ctx('LinuxPerfCapabilities', ''), 'format') and contains(exsl:ctx('LinuxPerfCapabilities', 'NotAvailable'), 'uncore_imc')) and not((exsl:ctx('PMU')='haswell' or exsl:ctx('PMU') = 'broadwell') and
                                  contains(exsl:ctx('LinuxRelease', ''), '3.10.0-327.el7.'))">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isDRAMBWAvailable>
      <isInterSocketBWAvailable>
        <xsl:choose>
          <xsl:when test="exsl:ctx('isSEPDriverAvailable', 0) or (contains(exsl:ctx('LinuxPerfCapabilities', 'NotAvailable'), 'uncore_qpi') or contains(exsl:ctx('LinuxPerfCapabilities', 'NotAvailable'), 'uncore_upi'))">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isInterSocketBWAvailable>
      <isPerfIOBWAvailable>
        <xsl:choose>
          <xsl:when test="exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='NotAvailable' and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='Kernel' and exsl:ctx('LinuxPerfCredentials', 'NotAvailable')!='User' and contains(exsl:ctx('LinuxPerfCapabilities', ''), 'format') and contains(exsl:ctx('LinuxPerfCapabilities', 'NotAvailable'), 'uncore_cha') and contains(exsl:ctx('LinuxPerfCapabilities', 'NotAvailable'), 'uncore_iio') and not(exsl:ctx('PMU') = 'snbep' or exsl:ctx('PMU') = 'ivytown' or exsl:ctx('PMU') = 'haswell_server' or exsl:ctx('PMU') = 'broadwell_server')">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isPerfIOBWAvailable>
      <xsl:copy-of select="$specifics//common/PCIeBandwidthEvents"/>
      <xsl:copy-of select="$specifics//common/uncacheableReadsEventNameOnly"/>
      <ShowInboundPCIeRequestsL3MissWarning>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server'">
            <xsl:choose>
              <xsl:when test="exsl:ctx('restrictPCIeBandwidthByClass', 'None') != 'None' and exsl:ctx('pciClassParts','') != ''">
                <xsl:text>false</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:choose>
                  <xsl:when test="exsl:ctx('isSEPDriverAvailable', 0)">
                    <xsl:text>false</xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>true</xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </ShowInboundPCIeRequestsL3MissWarning>
      <xsl:copy-of select="$specifics//common/FpgaBlueStreamEvents"/>
      <latencyEvents>
        <xsl:text>MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4</xsl:text>
      </latencyEvents>
      <xsl:variable name="isPerfMetricsPossible" select="(exsl:ctx('PMU') = 'icelake' or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'sapphirerapids' or exsl:ctx('PMU') = 'tigerlake') and exsl:ctx('isSEPDriverAvailable', 0) and exsl:ctx('Hypervisor', 'None') = 'None'"/>
      <perfMetricsPossible>
        <xsl:choose>
          <xsl:when test="$isPerfMetricsPossible">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </perfMetricsPossible>
      <xsl:variable name="tmamEventsFileVar">
        <xsl:text>config://analysis_type/include/tmam/</xsl:text>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' and contains(exsl:ctx('CPU_NAME',''),'Coffeelake')">
            <xsl:text>coffeelake</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="exsl:ctx('PMU', 'empty')"></xsl:value-of>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>.cfg</xsl:text>
      </xsl:variable>
      <isTmamAvailable>
        <xsl:choose>
          <xsl:when test="exsl:is_file_exist(string($tmamEventsFileVar))">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isTmamAvailable>
      <tmamEventsFile>
        <xsl:choose>
          <xsl:when test="exsl:is_file_exist(string($tmamEventsFileVar))">
            <xsl:value-of select="$tmamEventsFileVar"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>config://analysis_type/include/tmam/empty.cfg</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </tmamEventsFile>
      <xsl:variable name="tmamEventsFileVarPM">
        <xsl:text>config://analysis_type/include/tmam/</xsl:text>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' and contains(exsl:ctx('CPU_NAME',''),'Coffeelake')">
            <xsl:text>coffeelake</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="exsl:ctx('PMU', 'empty')"></xsl:value-of>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$isPerfMetricsPossible">
          <xsl:text>_pmetrics</xsl:text>
        </xsl:if>
        <xsl:text>.cfg</xsl:text>
      </xsl:variable>
      <tmamEventsFilePM>
        <xsl:choose>
          <xsl:when test="exsl:is_file_exist(string($tmamEventsFileVarPM))">
            <xsl:value-of select="$tmamEventsFileVarPM"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>config://analysis_type/include/tmam/empty.cfg</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </tmamEventsFilePM>
      <xsl:variable name="tmamFile">
        <xsl:text>config://include/queries_tmam_</xsl:text>
        <xsl:choose>
          <xsl:when test="exsl:ctx('tmamVersion', '') = ''">
            <xsl:text>3_1</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="exsl:ctx('tmamVersion', '3_1')"></xsl:value-of>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>/</xsl:text>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'skylake' and contains(exsl:ctx('CPU_NAME',''),'Coffeelake')">
            <xsl:text>coffeelake</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="exsl:ctx('PMU', 'empty')"></xsl:value-of>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="exsl:ctx('usePerfMetrics', 0) and $isPerfMetricsPossible">
          <xsl:text>_pmetrics</xsl:text>
        </xsl:if>
        <xsl:text>.xsl</xsl:text>
      </xsl:variable>
      <tmamQueryFile>
        <xsl:choose>
          <xsl:when test="exsl:is_file_exist(string($tmamFile))">
            <xsl:value-of select="$tmamFile"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>config://include/queries_tmam_3_1/empty.xsl</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </tmamQueryFile>
      <xsl:variable name="fpuMetricsFile">
        <xsl:text>config://include/queries_fpu_</xsl:text>
        <xsl:value-of select="exsl:ctx('fpuVersion', '1_0')"></xsl:value-of>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="exsl:ctx('PMU', 'empty')"></xsl:value-of>
        <xsl:text>.xsl</xsl:text>
      </xsl:variable>
      <fpuQueryFile>
        <xsl:choose>
          <xsl:when test="exsl:is_file_exist(string($fpuMetricsFile))">
            <xsl:value-of select="$fpuMetricsFile"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>config://include/queries_fpu_1_0/empty.xsl</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </fpuQueryFile>
      <isTmamSmtAware>
        <xsl:choose>
          <xsl:when test="not(exsl:ctx('PMU')='knl' or not(exsl:ctx('isHTEnabled', 1)) or exsl:ctx('tmamVersion', '3_21') = '3_2' or exsl:ctx('tmamVersion', '3_21') = '3_14' or exsl:ctx('tmamVersion', '3_21') = '3_11' or exsl:ctx('tmamVersion', '3_21') = '3_1' or exsl:ctx('tmamVersion', '3_21') = '3_02')">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isTmamSmtAware>
      <muxRatioFixedEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='Linux' and contains(exsl:ctx('Hypervisor', 'None'),'KVM')">
            <name>INST_RETIRED.ANY</name>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="(exsl:ctx('PMU') = 'airmont')  or (exsl:ctx('PMU') = 'goldmont') or (exsl:ctx('PMU') = 'silvermont') or (exsl:ctx('PMU') = 'lakemont')">
                <name>CPU_CLK_UNHALTED.CORE</name>
              </xsl:when>
              <xsl:otherwise>
                <name>CPU_CLK_UNHALTED.THREAD</name>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </muxRatioFixedEvent>
      <muxRatioProgrEvent>
        <xsl:choose>
          <xsl:when test="exsl:ctx('targetOS')='Linux' and contains(exsl:ctx('Hypervisor', 'None'),'KVM')">
            <name>INST_RETIRED.ANY_P</name>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <xsl:when test="(exsl:ctx('PMU') = 'airmont')  or (exsl:ctx('PMU') = 'goldmont') or (exsl:ctx('PMU') = 'silvermont') or (exsl:ctx('PMU') = 'lakemont')">
                <name>CPU_CLK_UNHALTED.CORE_P</name>
              </xsl:when>
              <xsl:otherwise>
                <name>CPU_CLK_UNHALTED.THREAD_P</name>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </muxRatioProgrEvent>
      <isPTBasedCallCounts>
        <xsl:choose>
          <xsl:when test="exsl:ctx('PMU') = 'core2'
                      or exsl:ctx('PMU') = 'core2p'
                      or exsl:ctx('PMU') = 'corei7'
                      or exsl:ctx('PMU') = 'corei7wsp'
                      or exsl:ctx('PMU') = 'corei7wdp'
                      or exsl:ctx('PMU') = 'corei7b'
                      or exsl:ctx('PMU') = 'snb'
                      or exsl:ctx('PMU') = 'snbep'
                      or exsl:ctx('PMU') = 'ivytown'
                      or exsl:ctx('PMU') = 'ivybridge'
                      or exsl:ctx('PMU') = 'haswell'
                      or exsl:ctx('PMU') = 'haswell_server'
                      or exsl:ctx('PMU') = 'silvermont'
                      or exsl:ctx('PMU') = 'airmont'
                      or exsl:ctx('PMU') = 'crystalwell'
                      or exsl:ctx('PMU') = 'atom'
                      or exsl:ctx('PMU') = 'airmont'
                      or exsl:ctx('PMU') = 'broadwell'
                      or exsl:ctx('PMU') = 'broadwell_de'
                      or exsl:ctx('PMU') = 'broadwell_server'
                      or exsl:ctx('PMU') = 'knl'
                      or exsl:ctx('PMU') = 'goldmont'
                      or exsl:ctx('PMU') = 'goldmont_plus'
                      or exsl:ctx('PMU') = 'lakemont'">
            <xsl:text>false</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>true</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isPTBasedCallCounts>
      <isFlopsAvailable>
        <xsl:choose>
          <xsl:when test="(exsl:ctx('PMU') = 'ivytown' or exsl:ctx('PMU') = 'ivybridge' or exsl:ctx('PMU') = 'broadwell'
                        or exsl:ctx('PMU') = 'broadwell_de' or exsl:ctx('PMU') = 'broadwell_server' or exsl:ctx('PMU') = 'skylake'
                        or exsl:ctx('PMU') = 'skylake_server' or exsl:ctx('PMU') = 'cascadelake_server' or exsl:ctx('PMU') = 'icelake'
                        or exsl:ctx('PMU') = 'icelake_server' or exsl:ctx('PMU') = 'tigerlake')">
            <xsl:text>true</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>false</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </isFlopsAvailable>
      <cacheUsageEvents>
        <xsl:choose>
          <xsl:when test="exsl:ctx('isCATSupportedByCPU')='true'">
            <xsl:if test="exsl:ctx('isL2CATAvailable', '')='true'">
              <xsl:text>UNC_CAT_L2_MASK:intread,</xsl:text>
            </xsl:if>
            <xsl:if test="exsl:ctx('isL3CATAvailable', '')='true'">
              <xsl:text>UNC_CAT_L3_MASK:intread,</xsl:text>
            </xsl:if>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text></xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </cacheUsageEvents>
      <L3CATSegments>
        <xsl:choose>
          <xsl:when test="exsl:ctx('isL3CATAvailable', '')='true'">
            <xsl:for-each select="str:tokenize(exsl:ctx('L3CATDetails',''), ';')">
              <xsl:if test="contains(.,'ways=')">
                <xsl:value-of select="str:replace(., 'ways=', '')"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>1</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </L3CATSegments>
      <L2CATSegments>
        <xsl:choose>
          <xsl:when test="exsl:ctx('isL2CATAvailable', '')='true'">
            <xsl:for-each select="str:tokenize(exsl:ctx('L2CATDetails',''), ';')">
              <xsl:if test="contains(.,'ways=')">
                <xsl:value-of select="str:replace(., 'ways=', '')"/>
              </xsl:if>
            </xsl:for-each>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>1</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </L2CATSegments>
    </variables>
  </xsl:template>
</xsl:stylesheet>
