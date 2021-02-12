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
  <xsl:output indent="yes" method="xml"/>
  <xsl:template match="/">
    <common>
      <knobs>
        <groupKnob id="groupForFinalizationControl">
          <knobProperty name="knob_control_id">RadioButtonGroup</knobProperty>
            <knobs>
              <enumKnob id="finalizationMode" displayName="%FinalizationMode" cliName="finalization-mode">
                <description>%FinalizationModeDescription</description>
                <values>
                  <value displayName="%FinalizationModeFull">full</value>
                  <value displayName="%FinalizationModeSampleThinning">fast</value>
                  <xsl:if test="exsl:ctx('noCollectionMode',0) or exsl:ctx('CLIENT_ID', 'GUI') = 'CLI'">
                    <value displayName="%FinalizationModeDeferred">deferred</value>
                  </xsl:if>
                  <xsl:if test="exsl:ctx('CLIENT_ID', 'GUI') = 'CLI'">
                    <value displayName="%FinalizationModeNone">none</value>
                  </xsl:if>
                  <defaultValue>fast</defaultValue>
                </values>
              </enumKnob>
           </knobs>
        </groupKnob>
        <xsl:if test="exsl:is_experimental('wrapper-script-enable')">
          <stringKnob id="wrapperScriptContent" displayName="%WrapperScriptCollector" cliName="wrapper-script">
            <knobProperty name="knob_control_id">file-content</knobProperty>
          </stringKnob>
          <stringKnob id="wrapperScriptPath" displayName="%WrapperScriptCollector" cliName="wrapper-script-path">
            <knobProperty name="applicableUI">cli</knobProperty>
          </stringKnob>
        </xsl:if>
      </knobs>
    </common>
  </xsl:template>
</xsl:stylesheet>
