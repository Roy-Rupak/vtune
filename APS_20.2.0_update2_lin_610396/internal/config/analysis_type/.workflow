<?xml version="1.0" encoding="utf-8"?>
<bag
   xsl:version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:exsl="http://exslt.org/common"
   xmlns:boolean="http://www.w3.org/2001/XMLSchema#boolean"
   exsl:keep_exsl_namespace=""
   syntax="norules"
>
  <workflow displayName="%AlgorithmAnalysisWorkflowName">
    <description>%HotspotsAnalysisWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%HotspotsAtypeName"/>
      <item idToUse="%ProcessorTraceAtypeName"/>
      <item idToUse="%MemoryConsumptionATypeName"/>
      <item idToUse="%AdvancedHotspotsAtypeName"/>
      <item idToUse="%PythonBasicHotspotsAtypeName"/>
      <item idToUse="%SniperHotspotsAtypeName"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow displayName="%MicroarchitectureAnalysisWorkflowName">
    <description>%MicroarchitectureAnalysisWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%MicroarchitectureExplorationAtypeName"/>
      <item idToUse="%CommonGeneralExplorationAtypeName"/>
      <item idToUse="%MemoryAccessAtypeName"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow displayName="%ParallelismAnalysisWorkflowName">
    <description>%ParallelismAnalysisWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%ConcurrencyAtypeName"/>
      <item idToUse="%LocksAndWaitsAtypeName"/>
      <item idToUse="%ThreadingAtypeName"/>
      <item idToUse="%HPCPerfCharAtypeName"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow displayName="%IOAnalysisWorkflowName">
    <description>%IOAnalysisWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%IOAtypeName"/>
      <item idToUse="%IOAtypeNamePreview"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow displayName="%AcceleratorsAnalysisWorkflowName">
    <description>%AcceleratorsAnalysisWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%GpuOffloadAtypeName"/>
      <item idToUse="%GpuHotspotsAtypeName"/>
      <item idToUse="%GpuComputeMediaHotspotsAtypeName"/>
      <item idToUse="%GpuProfilingHotspotsAtypeName"/>
      <item idToUse="%GpuProfilingExpHotspotsAtypeName"/>
      <item idToUse="%FPGAAtypeName"/>
      <item idToUse="%FPGAInteractionAtypeName"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow  displayName="%PlatformProfilingATypes">
    <description>%PlatformProfilingATypesDescription</description>
    <hierarchy>
      <item idToUse="%SystemOverviewAtypeName"/>
      <item idToUse="%IceAnalysisAtypeName"/>
      <item idToUse="%DataPlaneUtilizationATypeName"/>
      <item idToUse="%ThrottlingAtypeName"/>
      <item idToUse="%VPPpreviewAtypeName"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow displayName="%OtherAnalysisWorkflowName">
    <description>%OtherAnalysisWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%GraphicsRenderingAtypeName"/>
      <item idToUse="%CPUGPUConcurrencyAtypeName"/>
      <item idToUse="%CommonBandwidthAtypeName"/>
      <item idToUse="%VectorizationAtypeName"/>
      <item idToUse="%TSXExplorationAtypeName"/>
      <item idToUse="%TSXHotspotsAtypeName"/>
      <item idToUse="%SGXHotspotsAtypeName"/>
      <item idToUse="%MPSAtypeName"/>
      <item idToUse="%SniperMAAtypeName"/>
      <workflow displayName="%SoCAdvancedAnalysisTypes">
        <description>%SoCAdvancedAnalysisTypesDescription</description>
        <hierarchy>
          <item idToUse="%SoCBandwidthAtypeName"/>
        </hierarchy>
        <boolean:property name="expanded">true</boolean:property>
      </workflow>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
    <property name="stateInGUI">hide</property>
  </workflow>
  <workflow  displayName="%UTCustomAnalysisTypes">
    <description>%UTCustomAnalysisTypesDescription</description>
    <hierarchy>
      <remainingItems/>
      <userItems/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <workflow displayName="%PerfSnapshotWorkflowName">
    <description>%PerfSnapshotWorkflowDescription</description>
    <hierarchy>
      <item idToUse="%PerfSnapAtypeName"/>
    </hierarchy>
    <boolean:property name="expanded">true</boolean:property>
  </workflow>
  <defaultItem idToUse="%HotspotsAtypeName"/>
</bag>
