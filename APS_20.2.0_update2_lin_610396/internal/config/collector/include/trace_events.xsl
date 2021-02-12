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
  <xsl:param name="runtool"/>
  <xsl:param name="isVTSSFlow">false</xsl:param>
  <xsl:template match="/">
    <common>
      <knobs></knobs>
      <collector></collector>
    </common>
  </xsl:template>
</xsl:stylesheet>
