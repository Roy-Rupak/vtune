/*COPYRIGHT**
 * -------------------------------------------------------------------------
 *               INTEL CORPORATION PROPRIETARY INFORMATION
 *  This software is supplied under the terms of the accompanying license
 *  agreement or nondisclosure agreement with Intel Corporation and may not
 *  be copied or disclosed except in accordance with the terms of that
 *  agreement.
 *        Copyright (C) 2018 Intel Corporation. All Rights Reserved.
 * -------------------------------------------------------------------------
**COPYRIGHT*/

#ifndef _EMON_METRIC_API_H_INC_
#define _EMON_METRIC_API_H_INC_

#if defined(_WIN32)
#define DRV_DLLAPI  __declspec(dllexport)
#define DRV_APICALL __stdcall
#else
#define DRV_DLLAPI
#define DRV_APICALL
#endif

#if defined(__cplusplus)
extern "C" {
#endif


/*
 **********************************************************
 * Error codes
 **********************************************************
 */

#define EMONAPI_SUCCESS                   0    /* success                                        */
#define EMONAPI_INVALID_CONFIG            1    /* invalid value in one of the config variables   */
#define EMONAPI_NO_CONFIG                 2    /* config not set up                              */
#define EMONAPI_INVALID_PARAM             3    /* invalid parameter                              */
#define EMONAPI_DRIVER_OPEN_ERROR         4    /* failed to open driver                          */
#define EMONAPI_DRIVER_CLOSE_ERROR        5    /* failed to close driver                         */
#define EMONAPI_COLLECTION_RUNNING        6    /* EMON collection is aalready running            */
#define EMONAPI_UNEXPECTED_NULL_PTR       7    /* encountered unexpected NULL pointer            */
#define EMONAPI_UNMATCHED_START_STOP_PAIR 8    /* stop and the start command pair does not match */
#define EMONAPI_COLLECT_START_ERROR       9    /* failed to start EMON collection                */
#define EMONAPI_COLLECT_STOP_ERROR        10   /* failed to stop EMON collection                 */
#define EMONAPI_NO_METRIC_BUF_HEADER      11   /* failed to obtain EMON metric buffer header     */
#define EMONAPI_NO_EMON_DATA_BUFFER       12   /* failed to obtain EMON data buffer              */
#define EMONAPI_METRIC_CALC_ERROR         13   /* EMON metric calculation failed                 */
#define EMONAPI_INAVLID_METRIC            14   /* invalid metric name                            */
#define EMONAPI_INVALID_UNIT_NUMBER       15   /* invalid unit number                            */
#define EMONAPI_NO_MEMORY                 16   /* memory is not available for allocation         */
#define EMONAPI_MUTEX_CREATION_FAILED     17   /* creation of mutex failed                       */

typedef unsigned int EMONAPI_ERROR;


/*
 **********************************************************
 * Structures
 **********************************************************
 */

typedef void* EMON_METRIC_DATA;
typedef void* EMON_DATA;

typedef struct EMON_METRIC_CONFIG_NODE_S EMON_METRIC_CONFIG_NODE;
typedef        EMON_METRIC_CONFIG_NODE  *EMON_METRIC_CONFIG;

struct EMON_METRIC_CONFIG_NODE_S {
    float duration;
    int   accumulate;
    char *metric_list;
};

#define EMON_METRIC_CONFIG_duration(x)    (x)->duration
#define EMON_METRIC_CONFIG_accumulate(x)  (x)->accumulate
#define EMON_METRIC_CONFIG_metric_list(x) (x)->metric_list


/*
 **********************************************************
 * Function declarations
 **********************************************************
 */

/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricInit (
 *                                      EMON_METRIC_CONFIG emon_metric_config
 *                                           )
 *
 * @brief       Initialize EMON metric API with the provided configuration.
 *
 * @param       IN EMON_METRIC_CONFIG emon_metric_config
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricInit (
    EMON_METRIC_CONFIG emon_metric_config
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricStart (
 *                                             void
 *                                            )
 *
 * @brief       Start EMON metric collection.
 *
 * @param       void
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricStart (
    void
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricStop (
 *                                            void
 *                                           )
 *
 * @brief       Stop EMON data collection.
 *
 * @param       void
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricStop (
    void
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricRead (
 *                                       EMON_DATA   *emon_data,
 *                                           )
 *
 * @brief       Get the current EMON data from an active EMON collection.
 *
 * @param       OUT EMON_DATA   *emon_data
 *                      Buffer to obtain the EMON data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricRead (
    EMON_DATA *emon_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricCalculate (
 *                                          EMON_DATA         emon_data_before,
 *                                          EMON_DATA         emon_data_after,
 *                                          EMON_METRIC_DATA *emon_metric_data
 *                                                )
 *
 * @brief       Caculates the metrics based on the delta on 2 datasets provided
 *
 * @param       IN  EMON_DATA         emon_data_before
 *                 event counts obtained through the call EMONMetricRead
 *              IN  EMON_DATA         emon_data_after
 *                 event counts obtained through the call EMONMetricRead
 *              OUT EMON_METRIC_DATA *emon_metric_data
 *                 metric value based on delta between emon_data_before
 *                 and emon_data_after
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricCalculate (
    EMON_DATA         emon_data_before,
    EMON_DATA         emon_data_after,
    EMON_METRIC_DATA *emon_metric_data
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricGetAggregateCount (
 *                                          EMON_METRIC_DATA  emon_metric_data,
 *                                          char             *metric_name,
 *                                          double           *count
 *                                                        )
 *
 * @brief       Provides the aggregate metric value across the system
 *              of the given metric
 *
 * @param       IN  EMON_METRIC_DATA  emon_metric_data
 *                 Metric data obtained through the call EMONMetricCalculate
 *              IN  char             *metric_name
 *                 Name of the metric for which the aggregate value is needed
 *              OUT double           *count
 *                 Output variable to obtain the aggregate value
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricGetAggregateCount (
    EMON_METRIC_DATA  emon_metric_data,
    char             *metric_name,
    double           *count
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricGetAllUnitCount (
 *                                          EMON_METRIC_DATA  emon_metric_data,
 *                                          char             *metric_name,
 *                                          unsigned int     *num_units,
 *                                          double          **count
 *                                                      )
 *
 * @brief       Provides the metric value of the given metric for each core/unit
 *
 * @param       IN  EMON_METRIC_DATA  emon_metric_data
 *                 Metric data obtained through the call EMONMetricCalculate
 *              IN  char             *metric_name
 *                 Name of the metric for which the metric values are needed
 *              OUT unsigned int     *num_units
 *                 Number of cores/units available in the system.
 *                 This is also the length of the count array
 *              OUT double          **count
 *                 Output variable to obtain the metric values
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricGetAllUnitCount (
    EMON_METRIC_DATA   emon_metric_data,
    char              *metric_name,
    unsigned int      *num_units,
    double           **count
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricGetUnitCount (
 *                                          EMON_METRIC_DATA  emon_metric_data,
 *                                          char             *metric_name,
 *                                          unsigned int      unit_num,
 *                                          double           *count
 *                                                   )
 *
 * @brief       Provides the metric value of the given metric
 *              for a specific core/unit
 *
 * @param       IN  EMON_METRIC_DATA  emon_metric_data
 *                 Metric data obtained through the call EMONMetricCalculate
 *              IN  char             *metric_name
 *                 Name of the metric for which the metric value is needed
 *              IN  unsigned int      unit_num
 *                 The core/unit number for which the metric value is needed
 *              OUT double           *count
 *                 Output variable to obtain the metric value
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricGetUnitCount (
    EMON_METRIC_DATA  emon_metric_data,
    char             *metric_name,
    unsigned int      unit_num,
    double           *count
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricGetTsc (
 *                                       EMON_METRIC_DATA    emon_metric_data,
 *                                       unsigned long long *tsc
 *                                             )
 *
 * @brief       Provides tsc for the metric data
 *
 * @param       IN  EMON_METRIC_DATA    emon_metric_data
 *                 Metric data obtained through the call EMONMetricCalculate
 *              IN  unsigned long long *tsc
 *                 tsc for the metric data
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              None
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricGetTsc (
    EMON_METRIC_DATA    emon_metric_data,
    unsigned long long *tsc
);


/* ------------------------------------------------------------------------- */
/*!
 * @fn          EMONAPI_ERROR EMONMetricCleanup (
 *                                      unsigned int emon_metric_data_count,
 *                                      unsigned int emon_data_count,
 *                                      unsigned int count,
 *                                      unsigned int total_count,
 *                                      ...
 *                                              )
 *
 * @brief       Clean up of EMON metric API. This should be the last call.
 *
 * @param       unsigned int emon_metric_data_count
 *               number of variable of type EMON_METRIC_DATA being passed for deallocation
 *              unsigned int emon_data_count
 *               number of variable of type EMON_DATA being passed for deallocation
 *              unsigned int count
 *               number of variable of type char * being passed for deallocation
 *              unsigned int total_count
 *               total number: emon_metric_data_count + emon_data + count
 *              ...
 *               list of variables to be deallocated
 *
 * @return      0 if successful, otherwise error
 *
 * <I>Special Notes:</I>
 *              The list of variables should follow the following order strictly.
 *              Otherwise it will result in seg fault
 *              1. EMON_METRIC_DATA variables
 *              2. EMON_DATA variables
 *              3. char * variables
 */
DRV_DLLAPI
EMONAPI_ERROR DRV_APICALL
EMONMetricCleanup (
    unsigned int emon_metric_data_count,
    unsigned int emon_data_count,
    unsigned int count,
    unsigned int total_count,
    ...
);


#if defined(__cplusplus)
}
#endif

#endif
