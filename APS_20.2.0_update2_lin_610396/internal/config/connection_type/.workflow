<?xml version="1.0" encoding="utf-8"?>
<bag
   xsl:version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:exsl="http://exslt.org/common"
   exsl:keep_exsl_namespace=""
   syntax="norules"
>
  <workflow displayName="%RealConnection">
    <description>%RealConnectionFolderDescription</description>
    <hierarchy>
       <item idToUse="%LocalhostConnection"/>
       <item idToUse="%AdbConnection"/>
       <item idToUse="%SshConnection"/>
       <item idToUse="%MicConnection"/>
       <item idToUse="%MicOffloadConnection"/>
       <item idToUse="%EmulatorConnection"/>
       <item idToUse="%IntegrityConnection"/>
       <item idToUse="%SniperConnection"/>
       <item idToUse="%TcpIpConnection"/>
       <item idToUse="%AgentConnection"/>
    </hierarchy>
  </workflow>

  <workflow displayName="%OtherPMU">
    <description>%OtherPMUFolderDescription</description>
    <hierarchy>
      <item idToUse="get-commandline-localhost"/>
      <item idToUse="get-commandline-mic-native"/>
      <item idToUse="get-commandline-mic-offload"/>
    </hierarchy>
  </workflow>

  <xsl:choose>
    <xsl:when test="exsl:ctx('defaultConnection','') = 'adb'">
      <defaultItem idToUse="%AdbConnection"/>
    </xsl:when>
    <xsl:when test="exsl:ctx('defaultConnection','') = 'ssh'">
      <defaultItem idToUse="%SshConnection"/>
    </xsl:when>
    <xsl:when test="exsl:ctx('defaultConnection','') = 'localhost'">
      <defaultItem idToUse="%LocalhostConnection"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:choose>
         <xsl:when test="exsl:ctx('hostOS', '') = 'MacOSX'">
           <defaultItem idToUse="%SshConnection"/>
         </xsl:when>
         <xsl:otherwise>
           <defaultItem idToUse="%LocalhostConnection"/>
         </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>

</bag>
