<?xml version="1.0" encoding="utf-8"?>
<!--

 Copyright © 2009-2020 Intel Corporation. All rights reserved.

 The information contained herein is the exclusive property of
 Intel Corporation and may not be disclosed, examined, or reproduced in
 whole or in part without explicit written authorization from the Company.

-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl" xmlns:exsl="http://exslt.org/common" exsl:keep_exsl_namespace=""
  xmlns:int="http://www.w3.org/2001/XMLSchema#int"
  xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
  syntax="norules">
  <xsl:template match="/">
    <kvmKnobs>
      <groupKnob id="kvmProfileGuest" boolean:visible="false">
      <xsl:if test="(
        exsl:ctx('connectionType', '') = 'localhost' and exsl:ctx('hostOS', '') = 'Linux'
        )">
        <xsl:attribute name="boolean:visible">true</xsl:attribute>
      </xsl:if>
        <knobProperty name="knob_control_id">KvmProfileGuest</knobProperty>
        <knobProperty name="view.expand">true</knobProperty>
        <knobs>
          <booleanKnob id="analyzeKvmGuest" displayName="%AnalyzeKvmGuest" cliName="analyze-kvm-guest">
            <description>%AnalyzeKvmGuestDescription</description>
            <boolean:defaultValue>false</boolean:defaultValue>
          </booleanKnob>
          <stringKnob id="kvmGuestKallsyms" displayName="%KvmGuestKallsyms" cliName="kvm-guest-kallsyms">
            <description>%KvmGuestKallsymsDescription</description>
            <value></value>
            <defaultValue></defaultValue>
          </stringKnob>
          <stringKnob id="kvmGuestModules" displayName="%KvmGuestModules" cliName="kvm-guest-modules">
            <description>%KvmGuestModulesDescription</description>
            <value></value>
            <defaultValue></defaultValue>
          </stringKnob>
        </knobs>
      </groupKnob>
    </kvmKnobs>
  </xsl:template>
</xsl:stylesheet>
