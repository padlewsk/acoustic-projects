/*
 * SG__MDL_DMA.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL_DMA".
 *
 * Model version              : 6.462
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Tue Jun 25 15:43:18 2024
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_SG__MDL_DMA_h_
#define RTW_HEADER_SG__MDL_DMA_h_
#include <logsrv.h>
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "SG__MDL_DMA_types.h"
#include <stddef.h>
#include <cstring>
#include "SG__MDL_DMA_cal.h"

extern "C"
{

#include "rt_nonfinite.h"

}

/* Macros for accessing real-time model data structure */
#ifndef rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmGetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm) ((rtm)->CTOutputIncnstWithState)
#endif

#ifndef rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag
#define rtmSetContTimeOutputInconsistentWithStateAtMajorStepFlag(rtm, val) ((rtm)->CTOutputIncnstWithState = (val))
#endif

#ifndef rtmGetDerivCacheNeedsReset
#define rtmGetDerivCacheNeedsReset(rtm) ((rtm)->derivCacheNeedsReset)
#endif

#ifndef rtmSetDerivCacheNeedsReset
#define rtmSetDerivCacheNeedsReset(rtm, val) ((rtm)->derivCacheNeedsReset = (val))
#endif

#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetSampleHitArray
#define rtmGetSampleHitArray(rtm)      ((rtm)->Timing.sampleHitArray)
#endif

#ifndef rtmGetStepSize
#define rtmGetStepSize(rtm)            ((rtm)->Timing.stepSize)
#endif

#ifndef rtmGetZCCacheNeedsReset
#define rtmGetZCCacheNeedsReset(rtm)   ((rtm)->zCCacheNeedsReset)
#endif

#ifndef rtmSetZCCacheNeedsReset
#define rtmSetZCCacheNeedsReset(rtm, val) ((rtm)->zCCacheNeedsReset = (val))
#endif

#ifndef rtmGet_TimeOfLastOutput
#define rtmGet_TimeOfLastOutput(rtm)   ((rtm)->Timing.timeOfLastOutput)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   (rtmGetTPtr((rtm))[0])
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                ((rtm)->Timing.t)
#endif

#ifndef rtmGetTStart
#define rtmGetTStart(rtm)              ((rtm)->Timing.tStart)
#endif

#ifndef rtmGetTimeOfLastOutput
#define rtmGetTimeOfLastOutput(rtm)    ((rtm)->Timing.timeOfLastOutput)
#endif

/* Block signals for system '<Root>/DC Blocker' */
struct B_DCBlocker_SG__MDL_DMA_T {
  real_T DCBlocker;                    /* '<Root>/DC Blocker' */
};

/* Block states (default storage) for system '<Root>/DC Blocker' */
struct DW_DCBlocker_SG__MDL_DMA_T {
  dsp_simulink_DCBlocker_SG__MD_T obj; /* '<Root>/DC Blocker' */
  boolean_T objisempty;                /* '<Root>/DC Blocker' */
  boolean_T isInitialized;             /* '<Root>/DC Blocker' */
};

/* Block signals (default storage) */
struct B_SG__MDL_DMA_T {
  real_T p11;                          /* '<Root>/ai_135' */
  real_T ai_135_o2;                    /* '<Root>/ai_135' */
  real_T src_gain_j;                   /* '<S1>/src_gain' */
  B_DCBlocker_SG__MDL_DMA_T DCBlocker1;/* '<Root>/DC Blocker' */
  B_DCBlocker_SG__MDL_DMA_T DCBlocker; /* '<Root>/DC Blocker' */
};

/* Block states (default storage) for system '<Root>' */
struct DW_SG__MDL_DMA_T {
  real_T lastSin;                      /* '<S1>/wb1_0' */
  real_T lastCos;                      /* '<S1>/wb1_0' */
  real_T lastSin_g;                    /* '<S1>/wb1_1' */
  real_T lastCos_a;                    /* '<S1>/wb1_1' */
  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_sourc;   /* synthesized block */

  void *ao_2_PWORK[5];                 /* '<Root>/ao_2' */
  void *ai_135_PWORK[4];               /* '<Root>/ai_135' */
  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_ai_13;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_ai__h;   /* synthesized block */

  uint32_T Output_DSTATE;              /* '<S2>/Output' */
  int32_T systemEnable;                /* '<S1>/wb1_0' */
  int32_T systemEnable_g;              /* '<S1>/wb1_1' */
  int8_T source_SubsysRanBC;           /* '<Root>/source' */
  boolean_T source_MODE;               /* '<Root>/source' */
  DW_DCBlocker_SG__MDL_DMA_T DCBlocker1;/* '<Root>/DC Blocker' */
  DW_DCBlocker_SG__MDL_DMA_T DCBlocker;/* '<Root>/DC Blocker' */
};

/* Real-time Model Data Structure */
struct tag_RTM_SG__MDL_DMA_T {
  struct SimStruct_tag * *childSfunctions;
  const char_T *errorStatus;
  SS_SimMode simMode;
  RTWSolverInfo solverInfo;
  RTWSolverInfo *solverInfoPtr;
  void *sfcnInfo;

  /*
   * NonInlinedSFcns:
   * The following substructure contains information regarding
   * non-inlined s-functions used in the model.
   */
  struct {
    RTWSfcnInfo sfcnInfo;
    time_T *taskTimePtrs[1];
    SimStruct childSFunctions[3];
    SimStruct *childSFunctionPtrs[3];
    struct _ssBlkInfo2 blkInfo2[3];
    struct _ssSFcnModelMethods2 methods2[3];
    struct _ssSFcnModelMethods3 methods3[3];
    struct _ssSFcnModelMethods4 methods4[3];
    struct _ssStatesInfo2 statesInfo2[3];
    ssPeriodicStatesInfo periodicStatesInfo[3];
    struct _ssPortInfo2 inputOutputPortInfo2[3];
    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      uint_T attribs[35];
      mxArray *params[35];
    } Sfcn0;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortInputs inputPortInfo[2];
      struct _ssInPortUnit inputPortUnits[2];
      struct _ssInPortCoSimAttribute inputPortCoSimAttribute[2];
      uint_T attribs[13];
      mxArray *params[13];
      struct _ssDWorkRecord dWork[1];
      struct _ssDWorkAuxRecord dWorkAux[1];
    } Sfcn1;

    struct {
      time_T sfcnPeriod[1];
      time_T sfcnOffset[1];
      int_T sfcnTsMap[1];
      struct _ssPortOutputs outputPortInfo[2];
      struct _ssOutPortUnit outputPortUnits[2];
      struct _ssOutPortCoSimAttribute outputPortCoSimAttribute[2];
      uint_T attribs[11];
      mxArray *params[11];
      struct _ssDWorkRecord dWork[1];
      struct _ssDWorkAuxRecord dWorkAux[1];
    } Sfcn2;
  } NonInlinedSFcns;

  boolean_T zCCacheNeedsReset;
  boolean_T derivCacheNeedsReset;
  boolean_T CTOutputIncnstWithState;

  /*
   * Sizes:
   * The following substructure contains sizes information
   * for many of the model attributes such as inputs, outputs,
   * dwork, sample times, etc.
   */
  struct {
    uint32_T options;
    int_T numContStates;
    int_T numU;
    int_T numY;
    int_T numSampTimes;
    int_T numBlocks;
    int_T numBlockIO;
    int_T numBlockPrms;
    int_T numDwork;
    int_T numSFcnPrms;
    int_T numSFcns;
    int_T numIports;
    int_T numOports;
    int_T numNonSampZCs;
    int_T sysDirFeedThru;
    int_T rtwGenSfcn;
  } Sizes;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T stepSize;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tStart;
    time_T tFinal;
    time_T timeOfLastOutput;
    boolean_T stopRequestedFlag;
    time_T *sampleTimes;
    time_T *offsetTimes;
    int_T *sampleTimeTaskIDPtr;
    int_T *sampleHits;
    int_T *perTaskSampleHits;
    time_T *t;
    time_T sampleTimesArray[1];
    time_T offsetTimesArray[1];
    int_T sampleTimeTaskIDArray[1];
    int_T sampleHitArray[1];
    int_T perTaskSampleHitsArray[1];
    time_T tArray[1];
  } Timing;
};

/* Block signals (default storage) */
#ifdef __cplusplus

extern "C"
{

#endif

  extern struct B_SG__MDL_DMA_T SG__MDL_DMA_B;

#ifdef __cplusplus

}

#endif

/* Block states (default storage) */
extern struct DW_SG__MDL_DMA_T SG__MDL_DMA_DW;

/*
 * Exported Global Parameters
 *
 * Note: Exported global parameters are tunable parameters with an exported
 * global storage class designation.  Code generation will declare the memory for
 * these parameters and exports their symbols.
 *
 */
extern real_T src_gain;                /* Variable: src_gain
                                        * Referenced by: '<S1>/src_gain'
                                        */

#ifdef __cplusplus

extern "C"
{

#endif

  /* Model entry point functions */
  extern void SG__MDL_DMA_initialize(void);
  extern void SG__MDL_DMA_step(void);
  extern void SG__MDL_DMA_terminate(void);

#ifdef __cplusplus

}

#endif

/* Real-time Model object */
#ifdef __cplusplus

extern "C"
{

#endif

  extern RT_MODEL_SG__MDL_DMA_T *const SG__MDL_DMA_M;

#ifdef __cplusplus

}

#endif

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'SG__MDL_DMA'
 * '<S1>'   : 'SG__MDL_DMA/source'
 * '<S2>'   : 'SG__MDL_DMA/source/cnt'
 * '<S3>'   : 'SG__MDL_DMA/source/cnt/Increment Real World'
 * '<S4>'   : 'SG__MDL_DMA/source/cnt/Wrap To Zero'
 */
#endif                                 /* RTW_HEADER_SG__MDL_DMA_h_ */
