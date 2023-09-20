/*
 * SG__MDL.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL".
 *
 * Model version              : 6.26
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Tue Sep 19 11:24:47 2023
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_SG__MDL_h_
#define RTW_HEADER_SG__MDL_h_
#include <logsrv.h>
#include "rtwtypes.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "SG__MDL_types.h"
#include "SG__MDL_cal.h"
#include <cstring>
#include <stddef.h>

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

#ifndef rtmCounterLimit
#define rtmCounterLimit(rtm, idx)      ((rtm)->Timing.TaskCounters.cLimit[(idx)])
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetErrorStatusPointer
#define rtmGetErrorStatusPointer(rtm)  ((const char_T **)(&((rtm)->errorStatus)))
#endif

#ifndef rtmStepTask
#define rtmStepTask(rtm, idx)          ((rtm)->Timing.TaskCounters.TID[(idx)] == 0)
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

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                ((rtm)->Timing.t)
#endif

#ifndef rtmGetTStart
#define rtmGetTStart(rtm)              ((rtm)->Timing.tStart)
#endif

#ifndef rtmTaskCounter
#define rtmTaskCounter(rtm, idx)       ((rtm)->Timing.TaskCounters.TID[(idx)])
#endif

#ifndef rtmGetTimeOfLastOutput
#define rtmGetTimeOfLastOutput(rtm)    ((rtm)->Timing.timeOfLastOutput)
#endif

/* Block signals for system '<Root>/Subsystem' */
struct B_Subsystem_SG__MDL_T {
  real_T Multiply2;                    /* '<S1>/Multiply2' */
};

/* Block states (default storage) for system '<Root>/Subsystem' */
struct DW_Subsystem_SG__MDL_T {
  real_T lastSin;                      /* '<S1>/Sine Wave2' */
  real_T lastCos;                      /* '<S1>/Sine Wave2' */
  int32_T systemEnable;                /* '<S1>/Sine Wave2' */
};

/* Block signals (default storage) */
struct B_SG__MDL_T {
  real_T TmpTaskTransAtforallsubsystemsI;/* '<Root>/Subsystem' */
  real_T TmpTaskTransAtforallsubsystem_k;/* '<Root>/Subsystem1' */
  real_T TmpTaskTransAtforallsubsystem_l;/* '<Root>/Subsystem2' */
  real_T TmpTaskTransAtforallsubsystem_m;/* '<Root>/Subsystem3' */
  real_T ImpAsg_InsertedFor_Out1_at_inpo[4];
  B_Subsystem_SG__MDL_T Subsystem3;    /* '<Root>/Subsystem3' */
  B_Subsystem_SG__MDL_T Subsystem2;    /* '<Root>/Subsystem2' */
  B_Subsystem_SG__MDL_T Subsystem1;    /* '<Root>/Subsystem1' */
  B_Subsystem_SG__MDL_T Subsystem;     /* '<Root>/Subsystem' */
};

/* Block states (default storage) for system '<Root>' */
struct DW_SG__MDL_T {
  real_T TmpTaskTransAtSubsystemOutport1;/* synthesized block */
  real_T TmpTaskTransAtSubsystem1Outport;/* synthesized block */
  real_T TmpTaskTransAtSubsystem2Outport;/* synthesized block */
  real_T TmpTaskTransAtSubsystem3Outport;/* synthesized block */
  real_T TmpTaskTransAtforallsubsystemsO;/* synthesized block */
  real_T TmpTaskTransAtforallsubsystem_i;/* synthesized block */
  real_T TmpTaskTransAtforallsubsyste_iw;/* synthesized block */
  real_T TmpTaskTransAtforallsubsystem_a;/* synthesized block */
  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Subsy;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Sub_l;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Sub_g;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Sub_a;   /* synthesized block */

  void* sw_buf_1;                      /* synthesized block */
  void* sw_buf_2;                      /* synthesized block */
  void* sw_buf_3;                      /* synthesized block */
  void* sw_buf_4;                      /* synthesized block */
  void* sw_buf_5;                      /* synthesized block */
  void* sw_buf_6;                      /* synthesized block */
  void* sw_buf_7;                      /* synthesized block */
  void* sw_buf_8;                      /* synthesized block */
  DW_Subsystem_SG__MDL_T Subsystem3;   /* '<Root>/Subsystem3' */
  DW_Subsystem_SG__MDL_T Subsystem2;   /* '<Root>/Subsystem2' */
  DW_Subsystem_SG__MDL_T Subsystem1;   /* '<Root>/Subsystem1' */
  DW_Subsystem_SG__MDL_T Subsystem;    /* '<Root>/Subsystem' */
};

/* Real-time Model Data Structure */


/* Declare global externs for instrumentation */
extern void profileStart_SG_MDL(uint32_T);
extern void profileEnd_SG_MDL(uint32_T);
struct tag_RTM_SG__MDL_T {
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
    struct {
      uint32_T TID[1];
      uint32_T cLimit[1];
    } TaskCounters;

    time_T tStart;
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

  extern struct B_SG__MDL_T SG__MDL_B;

#ifdef __cplusplus

}

#endif

/* Block states (default storage) */
extern struct DW_SG__MDL_T SG__MDL_DW;
extern void AdvanceTaskCounters(void);

#ifdef __cplusplus

extern "C"
{

#endif

  /* Model entry point functions */
  extern void SG__MDL_initialize(void);
  extern void Periodic_Task_step(void);
  extern void Periodic_Task1_step(void);
  extern void Periodic_Task2_step(void);
  extern void Periodic_Task3_step(void);
  extern void Periodic_Task4_step(void);
  extern void Periodic_Task5_step(void);
  extern void SG__MDL_terminate(void);

#ifdef __cplusplus

}

#endif

/* Real-time Model object */
#ifdef __cplusplus

extern "C"
{

#endif

  extern RT_MODEL_SG__MDL_T *const SG__MDL_M;

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
 * '<Root>' : 'SG__MDL'
 * '<S1>'   : 'SG__MDL/Subsystem'
 * '<S2>'   : 'SG__MDL/Subsystem1'
 * '<S3>'   : 'SG__MDL/Subsystem2'
 * '<S4>'   : 'SG__MDL/Subsystem3'
 * '<S5>'   : 'SG__MDL/for all subsystems'
 * '<S6>'   : 'SG__MDL/for all subsystems/For Each Subsystem'
 */
#endif                                 /* RTW_HEADER_SG__MDL_h_ */
