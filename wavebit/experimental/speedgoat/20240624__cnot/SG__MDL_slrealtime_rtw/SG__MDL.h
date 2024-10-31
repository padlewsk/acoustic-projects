/*
 * SG__MDL.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL".
 *
 * Model version              : 6.524
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Thu Oct 31 16:05:59 2024
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
#include "verify/verifyIntrf.h"
#include "SG__MDL_types.h"
#include <stddef.h>
#include <cstring>

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

/* Block states (default storage) for system '<Root>/For Each Subsystem' */
struct DW_CoreSubsys_SG__MDL_T {
  dsp_simulink_DCBlocker_SG__MD_T obj; /* '<S2>/DC Blocker1' */
  boolean_T objisempty;                /* '<S2>/DC Blocker1' */
  boolean_T isInitialized;             /* '<S2>/DC Blocker1' */
};

/* Block signals for system '<S3>/For Each Subsystem1' */
struct B_CoreSubsys_SG__MDL_c_T {
  real_T Gain;                         /* '<S6>/Gain' */
};

/* Block states (default storage) for system '<S3>/For Each Subsystem1' */
struct DW_CoreSubsys_SG__MDL_f_T {
  real_T DiscreteTransferFcn_states[2];/* '<S6>/Discrete Transfer Fcn' */
  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Gain_;   /* synthesized block */

  uint32_T Output_DSTATE;              /* '<S8>/Output' */
};

/* Block signals (default storage) */
struct B_SG__MDL_T {
  real_T ai_135_o1;                    /* '<Root>/ai_135' */
  real_T ai_135_o2;                    /* '<Root>/ai_135' */
  real_T ImpAsg_InsertedFor_signal_at_in[2];
                              /* '<S6>/ImpAsg_InsertedFor_signal_at_inport_0' */
  real_T ImpAsg_InsertedFor_p_at_inport_[2];
                                   /* '<S2>/ImpAsg_InsertedFor_p_at_inport_0' */
  boolean_T acq;                       /* '<S20>/Enabled Resettable Delay' */
  B_CoreSubsys_SG__MDL_c_T CoreSubsys_p[2];/* '<S3>/For Each Subsystem1' */
};

/* Block states (default storage) for system '<Root>' */
struct DW_SG__MDL_T {
  void *ai_135_PWORK[4];               /* '<Root>/ai_135' */
  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Demux;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_Dem_f;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_ai_13;   /* synthesized block */

  struct {
    void *AQHandles;
  } TAQSigLogging_InsertedFor_ai__h;   /* synthesized block */

  void *ao_2_PWORK[5];                 /* '<Root>/ao_2' */
  struct {
    void *AQHandles[2];
    void *SLRTSigHandles[2];
  } TAQSigLogging_InsertedFor_In1_a;   /* synthesized block */

  struct {
    void *AQHandles[2];
  } TAQSigLogging_InsertedFor_In1_e;   /* synthesized block */

  uint32_T Count_reg_DSTATE;           /* '<S12>/Count_reg' */
  boolean_T DelayInput1_DSTATE;        /* '<S11>/Delay Input1' */
  boolean_T EnabledResettableDelay_DSTATE;/* '<S20>/Enabled Resettable Delay' */
  int8_T Subsystem_SubsysRanBC;        /* '<Root>/Subsystem' */
  int8_T EnabledSubsystem_SubsysRanBC; /* '<Root>/Enabled Subsystem' */
  DW_CoreSubsys_SG__MDL_f_T CoreSubsys_p[2];/* '<S3>/For Each Subsystem1' */
  DW_CoreSubsys_SG__MDL_T CoreSubsys[2];/* '<Root>/For Each Subsystem' */
};

/* Constant parameters (default storage) */
struct ConstP_SG__MDL_T {
  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P1_Size[2];

  /* Pooled Parameter (Expression: boardType)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled3;

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P2_Size[2];

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled4;

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P3_Size[2];

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled5;

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P5_Size[2];

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled6[2];

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P6_Size[2];

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled7[4];

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P9_Size[2];

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled8;

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T setup_135_P16_Size[2];

  /* Pooled Parameter (Expression: parDacVoltageRange)
   * Referenced by:
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  real_T pooled9[16];

  /* Pooled Parameter (Expression: )
   * Referenced by: '<Root>/setup_135'
   */
  real_T setup_135_P26_Size[2];

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by: '<Root>/setup_135'
   */
  real_T pooled10;

  /* Computed Parameter: setup_135_P30_Size
   * Referenced by: '<Root>/setup_135'
   */
  real_T setup_135_P30_Size[2];

  /* Expression: parFrameTriggerDivider
   * Referenced by: '<Root>/setup_135'
   */
  real_T setup_135_P30;

  /* Computed Parameter: setup_135_P34_Size
   * Referenced by: '<Root>/setup_135'
   */
  real_T setup_135_P34_Size[2];

  /* Expression: parDioPullRefFront
   * Referenced by: '<Root>/setup_135'
   */
  real_T setup_135_P34;

  /* Computed Parameter: ao_2_P7_Size
   * Referenced by: '<Root>/ao_2'
   */
  real_T ao_2_P7_Size[2];

  /* Expression: parDacInitValues
   * Referenced by: '<Root>/ao_2'
   */
  real_T ao_2_P7[2];

  /* Computed Parameter: ao_2_P8_Size
   * Referenced by: '<Root>/ao_2'
   */
  real_T ao_2_P8_Size[2];

  /* Expression: parDacReset
   * Referenced by: '<Root>/ao_2'
   */
  real_T ao_2_P8[2];
};

/* Constant parameters with dynamic initialization (default storage) */
struct ConstInitP_SG__MDL_T {
  /* Pooled Parameter (Expression: )
   * Referenced by: '<Root>/setup_135'
   */
  real_T setup_135_P31_Size[2];
};

/* Real-time Model Data Structure */
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
      struct _ssPortOutputs outputPortInfo[2];
      struct _ssOutPortUnit outputPortUnits[2];
      struct _ssOutPortCoSimAttribute outputPortCoSimAttribute[2];
      uint_T attribs[11];
      mxArray *params[11];
      struct _ssDWorkRecord dWork[1];
      struct _ssDWorkAuxRecord dWorkAux[1];
    } Sfcn1;

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

  extern struct B_SG__MDL_T SG__MDL_B;

#ifdef __cplusplus

}

#endif

/* Block states (default storage) */
extern struct DW_SG__MDL_T SG__MDL_DW;

/* Constant parameters (default storage) */
extern const ConstP_SG__MDL_T SG__MDL_ConstP;

/* Constant parameters with dynamic initialization (default storage) */
extern ConstInitP_SG__MDL_T SG__MDL_ConstInitP;/* constant parameters */

/*
 * Exported Global Parameters
 *
 * Note: Exported global parameters are tunable parameters with an exported
 * global storage class designation.  Code generation will declare the memory for
 * these parameters and exports their symbols.
 *
 */
extern real_T dtf_a[6];                /* Variable: dtf_a
                                        * Referenced by: '<Root>/Constant6'
                                        */
extern real_T dtf_b[6];                /* Variable: dtf_b
                                        * Referenced by: '<Root>/Constant'
                                        */
extern real_T freq_0;                  /* Variable: freq_0
                                        * Referenced by: '<Root>/Constant5'
                                        */
extern real_T harm_corr[2];            /* Variable: harm_corr
                                        * Referenced by: '<Root>/Constant8'
                                        */
extern real_T i2u;                     /* Variable: i2u
                                        * Referenced by: '<S6>/Gain'
                                        */
extern real_T phi[2];                  /* Variable: phi
                                        * Referenced by: '<Root>/Constant4'
                                        */
extern real_T rho[2];                  /* Variable: rho
                                        * Referenced by: '<Root>/Constant1'
                                        */
extern real_T rho_corr[2];             /* Variable: rho_corr
                                        * Referenced by: '<Root>/Constant7'
                                        */
extern real_T sens_p[2];               /* Variable: sens_p
                                        * Referenced by: '<Root>/sens_p'
                                        */
extern real_T src_gain;                /* Variable: src_gain
                                        * Referenced by: '<S6>/src_gain'
                                        */
extern real_T theta[2];                /* Variable: theta
                                        * Referenced by: '<Root>/Constant3'
                                        */
extern real_T ts_ctr;                  /* Variable: ts_ctr
                                        * Referenced by: '<S6>/Constant'
                                        */
extern uint32_T N_trig;                /* Variable: N_trig
                                        * Referenced by: '<Root>/Constant2'
                                        */
extern boolean_T enable_source;        /* Variable: enable_source
                                        * Referenced by: '<Root>/enable_source'
                                        */
extern boolean_T rec;                  /* Variable: rec
                                        * Referenced by: '<Root>/rec'
                                        */

#ifdef __cplusplus

extern "C"
{

#endif

  /* Model entry point functions */
  extern void SG__MDL_initialize(void);
  extern void SG__MDL_step(void);
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
 * '<S1>'   : 'SG__MDL/Enabled Subsystem'
 * '<S2>'   : 'SG__MDL/For Each Subsystem'
 * '<S3>'   : 'SG__MDL/Subsystem'
 * '<S4>'   : 'SG__MDL/Triggered Pulse'
 * '<S5>'   : 'SG__MDL/Enabled Subsystem/File Log'
 * '<S6>'   : 'SG__MDL/Subsystem/For Each Subsystem1'
 * '<S7>'   : 'SG__MDL/Subsystem/For Each Subsystem1/MATLAB Function'
 * '<S8>'   : 'SG__MDL/Subsystem/For Each Subsystem1/cnt'
 * '<S9>'   : 'SG__MDL/Subsystem/For Each Subsystem1/cnt/Increment Real World'
 * '<S10>'  : 'SG__MDL/Subsystem/For Each Subsystem1/cnt/Wrap To Zero'
 * '<S11>'  : 'SG__MDL/Triggered Pulse/Detect Rise Positive'
 * '<S12>'  : 'SG__MDL/Triggered Pulse/HDL Counter'
 * '<S13>'  : 'SG__MDL/Triggered Pulse/Unit Delay Enabled Resettable Synchronous'
 * '<S14>'  : 'SG__MDL/Triggered Pulse/Detect Rise Positive/Positive'
 * '<S15>'  : 'SG__MDL/Triggered Pulse/HDL Counter/Add_wrap'
 * '<S16>'  : 'SG__MDL/Triggered Pulse/HDL Counter/Dir_logic'
 * '<S17>'  : 'SG__MDL/Triggered Pulse/HDL Counter/Sub_wrap'
 * '<S18>'  : 'SG__MDL/Triggered Pulse/HDL Counter/Add_wrap/Compare To Constant'
 * '<S19>'  : 'SG__MDL/Triggered Pulse/HDL Counter/Sub_wrap/Compare To Constant'
 * '<S20>'  : 'SG__MDL/Triggered Pulse/Unit Delay Enabled Resettable Synchronous/Unit Delay Enabled Resettable'
 */
#endif                                 /* RTW_HEADER_SG__MDL_h_ */
