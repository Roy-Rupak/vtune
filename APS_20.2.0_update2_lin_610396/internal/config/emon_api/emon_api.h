/*COPYRIGHT**
 * -------------------------------------------------------------------------
 *               INTEL CORPORATION PROPRIETARY INFORMATION
 *  This software is supplied under the terms of the accompanying license
 *  agreement or nondisclosure agreement with Intel Corporation and may not
 *  be copied or disclosed except in accordance with the terms of that
 *  agreement.
 *        Copyright (C) 2007-2019 Intel Corporation. All Rights Reserved.
 * -------------------------------------------------------------------------
**COPYRIGHT*/

#ifndef _EMON_API_H_INC_
#define _EMON_API_H_INC_

#if defined(_WIN32)
#define DRV_DLLAPI      __declspec(dllexport)
#define DRV_APICALL     __stdcall
#else
#define DRV_DLLAPI
#define DRV_APICALL
#endif


#if defined(__cplusplus)
extern "C" {
#endif

typedef void* EMON_DATA;

/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONConfig (
 *                  const char  *config_file
 *              )
 *
 * @brief       Initialize EMON API with the input config_file.
 *              After EMONStart use EMONPause and EMONResume to control the event collection.
 *
 * @param       IN const char  *config_file_name
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              if anything in config file wrong then return error
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONConfig (
    const char  *config_file
);

/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONStart (
 *                  void
 *              )
 *
 * @brief       Start EMON data collection.
 *
 * @param       void
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONStart (
    void
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONStop (
 *                  void
 *              )
 *
 * @brief       Stop EMON data collection.
 *
 * @param       void
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONStop (
    void
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONPause (
 *                  void
 *              )
 *
 * @brief       Pause a running EMON data collection.
 *
 * @param       void
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONPause (
    void
);

/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONResume (
                    void
 *              )
 *
 * @brief       Resume a paused collection.
 *
 * @param       void
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONResume (
    void
);

/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONReadCounts (
 *                  EMON_DATA  *emon_counting_data
 *              )
 *
 * @brief       Get the current event counts from an active EMON collection.
 *              A collection is active when EMON is still running, even while in the paused state.
 *
 * @param       OUT EMON_DATA *emon_counting_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONReadCounts (
    EMON_DATA  *emon_counting_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONReadMetric (
 *                  EMON_DATA  *emon_metric_data
 *              )
 *
 * @brief       Get the current metric data of an active EMON data collection.
 *              A collection is active when EMON is still running, even while in the paused state.
 *
 * @param       OUT EMON_DATA *emon_metric_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONReadMetric (
    EMON_DATA  *emon_metric_data
);

/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONMarkerCreate (
 *                  const char  *marker_name
 *              )
 *
 * @brief       Declare a new marker with the given marker_name.
 *              This name uniquely identifies the marked region of interest.
 *
 * @param       IN  const char  *marker_name  - ID for marker
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONMarkerCreate (
    const char  *marker_name
);

/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONMarkerEnter (
 *                  const char  *marker_name
 *              )
 *
 * @brief       Collect and accumulate EMON data for the selected code region associated with the given marker_name.
 *              No support for nested calls of EMONMarkerEnter. Each call to this API should be followed by a call to EMONMarkerLeave.
 *
 * @param       IN  const char  *marker_name  - ID for marker
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONMarkerEnter (
    const char  *marker_name
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONMarkerLeave (
 *                  const char  *marker_name
 *              )
 *
 * @brief       Stop accumulating EMON data associated with the given marker_name.
 *              EMONMarkerLeave should be preceded with EMONMarkerEnter API corresponding to the same marker_name.
 *
 * @param       IN  const char  *marker_name  - ID for marker
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONMarkerLeave (
    const char  *marker_name
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONReadMarkerCounts (
 *                  const char   *marker_name,
 *                  EMON_DATA    *emon_counting_data
 *              )
 *
 * @brief       Retrieve event counts associated with the given marker_name.
 *
 * @param       IN  const char   *marker_name       - ID for marker
 *              OUT EMON_DATA    *emon_counting_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONReadMarkerCounts (
    const char  *marker_name,
    EMON_DATA   *emon_counting_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONReadMarkerMetric (
 *                  const char  *marker_name,
 *                  EMON_DATA   *emon_metric_data
 *              )
 *
 * @brief       Retrieve metric data associated with the given marker_name.
 *
 * @param       IN  const char   *marker_name       - ID for marker
 *              OUT EMON_DATA    *emon_metric_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONReadMarkerMetric (
    const char  *marker_name,
    EMON_DATA   *emon_metric_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataGetEventList (
 *                  char          ***event_names,
 *                  unsigned int    *num_events
 *              )
 *
 * @brief       List the events that were collected.
 *
 * @param       OUT char         ***event_names
 *              OUT unsigned int   *num_events
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataGetEventList(
    char          ***event_names,
    unsigned int    *num_events
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataGetMetricList (
 *                  char         ***metric_names,
 *                  unsigned int   *num_metric
 *              )
 *
 * @brief       List the metrics that were collected.
 *
 * @param       OUT char         ***metric_names
 *              OUT unsigned int   *num_metric
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataGetMetricList(
    char          ***metric_names,
    unsigned int    *num_metric
);


#define EMON_API_OPERATION_TOTAL        0
#define EMON_API_OPERATION_ADDITION     1
#define EMON_API_OPERATION_SUBTRACTION  2
/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataCalculate (
 *                  EMON_DATA       emon_data_first,
 *                  EMON_DATA       emon_data_second,
 *                  double          constant_first,
 *                  double          constant_second,
 *                  unsigned int    operation,
 *                  EMON_DATA      *emon_data_result
 *              )
 *
 * @brief       Perform addition, subtraction and summation operations on EMON data.
 *              Total:       Get the summation of all unit counts/metric for emon_data,
 *                           EMONDataCalculation(emon_data, NULL, constant_first, 0, EMON_API_OPERATION_TOTAL, &emon_data_result);
 *                           The result will be: constant_first * total_of(emon_data)
 *              Addition:    Get the result from emon_data_first adds to emon_data_second,
 *                           EMONDataCalculation(emon_data_first, emon_data_second, constant_first, constant_second, EMON_API_OPERATION_ADDITION, &emon_data_result);
 *                           The result will be: constant_first * emon_data_first + constant_second * emon_data_second
 *              Subtraction: Get the result from emon_data_first subtracts to emon_data_second.
 *                           EMONDataCalculation(emon_data_first, emon_data_second, constant_first, constant_second, EMON_API_OPERATION_SUBTRACTION, &emon_data_result);
 *                           The result will be: constant_first * emon_data_first - constant_second * emon_data_second
 *
 * @param       IN   EMON_DATA       emon_data_first
 *              IN   EMON_DATA       emon_data_second
 *              IN   double          constant_first
 *              IN   double          constant_second
 *              IN   unsigned int    operation
 *              OUT  EMON_DATA      *emon_data_result
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataCalculate (
    EMON_DATA       emon_data_first,
    EMON_DATA       emon_data_second,
    double          constant_first,
    double          constant_second,
    unsigned int    operation,
    EMON_DATA      *emon_data_result
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataPrint (
 *                  EMON_DATA emon_data
 *              )
 *
 * @brief       Print all entries in the input EMON data.
 *
 * @param       IN EMON_DATA  *emon_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataPrintAll (
    EMON_DATA  emon_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataGetTimestamp (
 *                  EMON_DATA            emon_data,
 *                  unsigned long long  *timestamp
 *              )
 *
 * @brief       Retrieve timestamp value from the given emon_data.
 *
 * @param       IN   EMON_DATA            emon_data
 *              OUT  unsigned long long  *timestamp  -  Timestamp of emon_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataGetTimestamp (
    EMON_DATA            emon_data,
    unsigned long long  *timestamp
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataGetSingleEntry (
 *                  EMON_DATA       emon_data,
 *                  const char     *entry_name,
 *                  double        **single_data,
 *                  unsigned int   *num_units
 *              )
 *
 * @brief       Retrieve counts corresponding to a single event or retrieve data corresponding to a single metric.
 *
 * @param       IN   EMON_DATA       emon_data,
 *              IN   const char     *entry_name   -  Can be either an event name which specified in EMON config file or
 *                                                   an metric name which required events are specified
 *              OUT  double        **single_data  -  The counts/metric for "entry_name"
 *              OUT  unsigned int   *num_units    -  Num of units in single_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataGetSingleEntry (
    EMON_DATA       emon_data,
    const char     *entry_name,
    double        **single_data,
    unsigned int   *num_units
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONReadCountsOnCurrentCPU (
 *                  EMON_DATA      *emon_single_cpu_data
 *              )
 *
 * @brief       Get the event counts on current CPU with low overhead.
 *              The function can only be used while <read_counts_on_current_cpu> sub-tag is set to 1, and all collected events can be scheduled in single group.
 *              While use the function, it is user's responsibility to make sure EMONReadCountsOnCurrentCPU is running on the same CPU as user's program.
 *
 * @param       OUT    EMON_DATA   emon_single_cpu_data,
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONReadCountsOnCurrentCPU (
    EMON_DATA *emon_single_cpu_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          unsigned int EMONDataFree (
 *                  EMON_DATA  *emon_data
 *              )
 *
 * @brief       Destroy the EMON data which is generated from EMONReadCounts, EMONReadMetric,
 *              EMONReadMarkerCounts, EMONReadMarkerMetric and EMONDataCalculate.
 *
 * @param       IN EMON_DATA *emon_data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              <NONE>
 */
DRV_DLLAPI
unsigned int DRV_APICALL
EMONDataFree (
    EMON_DATA *emon_data
);

#if defined(__cplusplus)
}
#endif

#endif