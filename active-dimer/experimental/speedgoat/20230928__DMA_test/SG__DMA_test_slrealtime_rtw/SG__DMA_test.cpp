/*
 * SG__DMA_test.cpp
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__DMA_test".
 *
 * Model version              : 12.21
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Fri Oct 20 13:52:25 2023
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "SG__DMA_test.h"
#include "SG__DMA_test_private.h"
#include "SG__DMA_test_cal.h"
#include "crl_mutex.hpp"
#include "rtwtypes.h"
#include <cstring>

extern "C"
{

#include "rt_nonfinite.h"

}

/* Block signals (default storage) */
B_SG__DMA_test_T SG__DMA_test_B;

/* Block states (default storage) */
DW_SG__DMA_test_T SG__DMA_test_DW;

/* Real-time model */
RT_MODEL_SG__DMA_test_T SG__DMA_test_M_ = RT_MODEL_SG__DMA_test_T();
RT_MODEL_SG__DMA_test_T *const SG__DMA_test_M = &SG__DMA_test_M_;
void Root_InterruptSetup_callback(void)
{
  // 2.  Call the framework to get the msg receive coid to use in the pulse send in the ISR
  Root_InterruptSetup_D.coid = slrealtime::taskConnectionID( 1 );
  IO135_start_public( Root_InterruptSetup_D.context, 0 );
}

const struct sigevent *Root_InterruptSetup_ISR(void *data, int id)
{
  // For the real interrupt, call the boardISR here
  bool needService = IO135_isr_public( Root_InterruptSetup_D.context );
  if (needService ) {
    Root_InterruptSetup_D.count++;

    // Call the INIT macro again to send the current count.
    SIGEV_PULSE_INT_INIT( &Root_InterruptSetup_D.sig_pulse,
                         Root_InterruptSetup_D.coid,
                         Root_InterruptSetup_D.pri,
                         _PULSE_CODE_MINAVAIL,
                         Root_InterruptSetup_D.count );
    return &Root_InterruptSetup_D.sig_pulse;
  }

  // return a sigevent none if the board didn't interrupt.
  return &Root_InterruptSetup_D.sig_none;
}

// SimulinkRealTime Target Async Interrupt Block '<Root>/Interrupt Setup'
// Same function for interrupt or polling mode.
void Root_InterruptSetup_fc(void)
{
  {
    /* Reset subsysRan breadcrumbs */
    srClearBC(SG__DMA_test_DW.Subsystem_SubsysRanBC);

    /* RateTransition: '<Root>/Rate Transition' */
    rtw_slrealtime_mutex_lock(SG__DMA_test_DW.RateTransition_d0_SEMAPHORE);
    SG__DMA_test_DW.RateTransition_RDBuf =
      SG__DMA_test_DW.RateTransition_LstBufWR;
    rtw_slrealtime_mutex_unlock(SG__DMA_test_DW.RateTransition_d0_SEMAPHORE);
    SG__DMA_test_B.RateTransition =
      SG__DMA_test_DW.RateTransition_Buf[SG__DMA_test_DW.RateTransition_RDBuf];

    /* S-Function (slhwinterrupt): '<Root>/Interrupt Setup' */

    /* Output and update for function-call system: '<Root>/Subsystem' */
    rtw_slrealtime_mutex_lock(SG__DMA_test_M->Timing.semIdForTask1);
    SG__DMA_test_M->Timing.clockTick1 = SG__DMA_test_M->Timing.rtmClockTickBuf1;
    SG__DMA_test_M->Timing.clockTickH1 =
      SG__DMA_test_M->Timing.rtmBufClockTickBufH1;
    rtw_slrealtime_mutex_unlock(SG__DMA_test_M->Timing.semIdForTask1);
    SG__DMA_test_M->Timing.t[1] = SG__DMA_test_M->Timing.clockTick1 *
      SG__DMA_test_M->Timing.stepSize1 + SG__DMA_test_M->Timing.clockTickH1 *
      SG__DMA_test_M->Timing.stepSize1 * 4294967296.0;

    /* Gain: '<S1>/Gain1' */
    SG__DMA_test_B.Gain1 = SG__DMA_test_cal->Gain1_Gain *
      SG__DMA_test_B.RateTransition;

    /* Gain: '<S1>/Gain4' */
    SG__DMA_test_B.Gain4 = SG__DMA_test_cal->Gain4_Gain *
      SG__DMA_test_B.RateTransition;

    /* S-Function (sg_IO132_IO133_da_s_v2): '<S1>/IO135_AnalogOutput ' */

    /* Level2 S-Function Block: '<S1>/IO135_AnalogOutput ' (sg_IO132_IO133_da_s_v2) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[0];
      sfcnOutputs(rts,1);
    }

    /* S-Function (sg_IO132_IO133_ad_s_v2): '<S1>/IO135_AnalogInput ' */

    /* Level2 S-Function Block: '<S1>/IO135_AnalogInput ' (sg_IO132_IO133_ad_s_v2) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[1];
      sfcnOutputs(rts,1);
    }

    SG__DMA_test_DW.Subsystem_SubsysRanBC = 4;

    /* End of Outputs for S-Function (slhwinterrupt): '<Root>/Interrupt Setup' */
  }
}

/* Model step function */
void SG__DMA_test_step(void)
{
  int8_T wrBufIdx;

  /* S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/IO135_Setup ' */

  /* Level2 S-Function Block: '<Root>/IO135_Setup ' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[2];
    sfcnOutputs(rts,0);
  }

  /* S-Function (sg_IO104_DMA_setup_s): '<Root>/Setup (v2) ' */

  /* Level2 S-Function Block: '<Root>/Setup (v2) ' (sg_IO104_DMA_setup_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[3];
    sfcnOutputs(rts,0);
  }

  /* S-Function (sg_IO104_DMA_ad_s): '<Root>/Analog input (v2) ' */

  /* Level2 S-Function Block: '<Root>/Analog input (v2) ' (sg_IO104_DMA_ad_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[4];
    sfcnOutputs(rts,0);
  }

  /* S-Function (sdspchirp): '<Root>/Chirp' */
  /* DSP System Toolbox Chirp (sdspchirp) - '<Root>/Chirp' */
  /* Unidirectional Logarithmic  */
  {
    real_T *y = &SG__DMA_test_B.Chirp;
    real_T instantPhase = 0.0;
    instantPhase = (SG__DMA_test_DW.Chirp_SWEEP_DIRECTION == 0) ?
      SG__DMA_test_DW.Chirp_BETA*SG__DMA_test_cal->Chirp_f0*(pow
      (SG__DMA_test_DW.Chirp_MIN_FREQ,SG__DMA_test_DW.Chirp_CURRENT_STEP /
       SG__DMA_test_cal->Chirp_t1) - 1.0) : SG__DMA_test_DW.Chirp_PERIOD_THETA -
        SG__DMA_test_DW.Chirp_BETA*SG__DMA_test_cal->Chirp_f0*(pow
        (SG__DMA_test_DW.Chirp_MIN_FREQ,(SG__DMA_test_cal->Chirp_Tsweep-
        SG__DMA_test_DW.Chirp_CURRENT_STEP) / SG__DMA_test_cal->Chirp_t1) - 1.0);
    instantPhase -= (int_T)instantPhase;
    *y = cos(DSP_TWO_PI * (instantPhase + SG__DMA_test_DW.Chirp_ACC_PHASE) +
             SG__DMA_test_cal->Chirp_phase);
    SG__DMA_test_DW.Chirp_CURRENT_STEP += 5.0E-5;/* Go to next time step */
    if (SG__DMA_test_DW.Chirp_CURRENT_STEP > (SG__DMA_test_cal->Chirp_Tsweep +
         DBL_EPSILON)) {
      SG__DMA_test_DW.Chirp_CURRENT_STEP = SG__DMA_test_DW.Chirp_CURRENT_STEP -
        SG__DMA_test_cal->Chirp_Tsweep;
      SG__DMA_test_DW.Chirp_ACC_PHASE += instantPhase;
      if (SG__DMA_test_DW.Chirp_ACC_PHASE > 1.0) {
        SG__DMA_test_DW.Chirp_ACC_PHASE -= floor(SG__DMA_test_DW.Chirp_ACC_PHASE);
      }
    }
  }

  /* Gain: '<Root>/Gain' */
  SG__DMA_test_B.Gain = SG__DMA_test_cal->Gain_Gain * SG__DMA_test_B.Chirp;

  /* S-Function (sg_IO104_DMA_da_s): '<Root>/Analog output (v2) ' */

  /* Level2 S-Function Block: '<Root>/Analog output (v2) ' (sg_IO104_DMA_da_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[5];
    sfcnOutputs(rts,0);
  }

  /* RateTransition: '<Root>/Rate Transition' */
  rtw_slrealtime_mutex_lock(SG__DMA_test_DW.RateTransition_d0_SEMAPHORE);
  wrBufIdx = static_cast<int8_T>(SG__DMA_test_DW.RateTransition_LstBufWR + 1);
  if (wrBufIdx == 3) {
    wrBufIdx = 0;
  }

  if (wrBufIdx == SG__DMA_test_DW.RateTransition_RDBuf) {
    wrBufIdx = static_cast<int8_T>(wrBufIdx + 1);
    if (wrBufIdx == 3) {
      wrBufIdx = 0;
    }
  }

  rtw_slrealtime_mutex_unlock(SG__DMA_test_DW.RateTransition_d0_SEMAPHORE);
  SG__DMA_test_DW.RateTransition_Buf[wrBufIdx] = SG__DMA_test_B.Chirp;
  SG__DMA_test_DW.RateTransition_LstBufWR = wrBufIdx;

  /* End of RateTransition: '<Root>/Rate Transition' */

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++SG__DMA_test_M->Timing.clockTick0)) {
    ++SG__DMA_test_M->Timing.clockTickH0;
  }

  SG__DMA_test_M->Timing.t[0] = SG__DMA_test_M->Timing.clockTick0 *
    SG__DMA_test_M->Timing.stepSize0 + SG__DMA_test_M->Timing.clockTickH0 *
    SG__DMA_test_M->Timing.stepSize0 * 4294967296.0;
  rtw_slrealtime_mutex_lock(SG__DMA_test_M->Timing.semIdForTask1);
  SG__DMA_test_M->Timing.rtmClockTickBuf1 = SG__DMA_test_M->Timing.clockTick0;
  SG__DMA_test_M->Timing.rtmBufClockTickBufH1 =
    SG__DMA_test_M->Timing.clockTickH0;
  rtw_slrealtime_mutex_unlock(SG__DMA_test_M->Timing.semIdForTask1);
}

/* Model initialize function */
void SG__DMA_test_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));
  rtsiSetSolverName(&SG__DMA_test_M->solverInfo,"FixedStepDiscrete");
  SG__DMA_test_M->solverInfoPtr = (&SG__DMA_test_M->solverInfo);

  /* Initialize timing info */
  {
    int_T *mdlTsMap = SG__DMA_test_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "SG__DMA_test_M points to
       static memory which is guaranteed to be non-NULL" */
    SG__DMA_test_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    SG__DMA_test_M->Timing.sampleTimes =
      (&SG__DMA_test_M->Timing.sampleTimesArray[0]);
    SG__DMA_test_M->Timing.offsetTimes =
      (&SG__DMA_test_M->Timing.offsetTimesArray[0]);

    /* task periods */
    SG__DMA_test_M->Timing.sampleTimes[0] = (5.0E-5);

    /* task offsets */
    SG__DMA_test_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(SG__DMA_test_M, &SG__DMA_test_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = SG__DMA_test_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    SG__DMA_test_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(SG__DMA_test_M, -1);
  SG__DMA_test_M->Timing.stepSize0 = 5.0E-5;
  SG__DMA_test_M->Timing.stepSize1 = 5.0E-5;
  SG__DMA_test_M->solverInfoPtr = (&SG__DMA_test_M->solverInfo);
  SG__DMA_test_M->Timing.stepSize = (5.0E-5);
  rtsiSetFixedStepSize(&SG__DMA_test_M->solverInfo, 5.0E-5);
  rtsiSetSolverMode(&SG__DMA_test_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  (void) std::memset((static_cast<void *>(&SG__DMA_test_B)), 0,
                     sizeof(B_SG__DMA_test_T));

  /* states (dwork) */
  (void) std::memset(static_cast<void *>(&SG__DMA_test_DW), 0,
                     sizeof(DW_SG__DMA_test_T));

  /* child S-Function registration */
  {
    RTWSfcnInfo *sfcnInfo = &SG__DMA_test_M->NonInlinedSFcns.sfcnInfo;
    SG__DMA_test_M->sfcnInfo = (sfcnInfo);
    rtssSetErrorStatusPtr(sfcnInfo, (&rtmGetErrorStatus(SG__DMA_test_M)));
    SG__DMA_test_M->Sizes.numSampTimes = (2);
    rtssSetNumRootSampTimesPtr(sfcnInfo, &SG__DMA_test_M->Sizes.numSampTimes);
    SG__DMA_test_M->NonInlinedSFcns.taskTimePtrs[0] = &(rtmGetTPtr
      (SG__DMA_test_M)[0]);
    SG__DMA_test_M->NonInlinedSFcns.taskTimePtrs[1] = &(rtmGetTPtr
      (SG__DMA_test_M)[1]);
    rtssSetTPtrPtr(sfcnInfo,SG__DMA_test_M->NonInlinedSFcns.taskTimePtrs);
    rtssSetTStartPtr(sfcnInfo, &rtmGetTStart(SG__DMA_test_M));
    rtssSetTFinalPtr(sfcnInfo, &rtmGetTFinal(SG__DMA_test_M));
    rtssSetTimeOfLastOutputPtr(sfcnInfo, &rtmGetTimeOfLastOutput(SG__DMA_test_M));
    rtssSetStepSizePtr(sfcnInfo, &SG__DMA_test_M->Timing.stepSize);
    rtssSetStopRequestedPtr(sfcnInfo, &rtmGetStopRequested(SG__DMA_test_M));
    rtssSetDerivCacheNeedsResetPtr(sfcnInfo,
      &SG__DMA_test_M->derivCacheNeedsReset);
    rtssSetZCCacheNeedsResetPtr(sfcnInfo, &SG__DMA_test_M->zCCacheNeedsReset);
    rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo,
      &SG__DMA_test_M->CTOutputIncnstWithState);
    rtssSetSampleHitsPtr(sfcnInfo, &SG__DMA_test_M->Timing.sampleHits);
    rtssSetPerTaskSampleHitsPtr(sfcnInfo,
      &SG__DMA_test_M->Timing.perTaskSampleHits);
    rtssSetSimModePtr(sfcnInfo, &SG__DMA_test_M->simMode);
    rtssSetSolverInfoPtr(sfcnInfo, &SG__DMA_test_M->solverInfoPtr);
  }

  SG__DMA_test_M->Sizes.numSFcns = (6);

  /* register each child */
  {
    (void) std::memset(static_cast<void *>
                       (&SG__DMA_test_M->NonInlinedSFcns.childSFunctions[0]), 0,
                       6*sizeof(SimStruct));
    SG__DMA_test_M->childSfunctions =
      (&SG__DMA_test_M->NonInlinedSFcns.childSFunctionPtrs[0]);

    {
      int_T i;
      for (i = 0; i < 6; i++) {
        SG__DMA_test_M->childSfunctions[i] =
          (&SG__DMA_test_M->NonInlinedSFcns.childSFunctions[i]);
      }
    }

    /* Level2 S-Function Block: SG__DMA_test/<S1>/IO135_AnalogOutput  (sg_IO132_IO133_da_s_v2) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[0];

      /* timing info */
      time_T *sfcnPeriod = SG__DMA_test_M->NonInlinedSFcns.Sfcn0.sfcnPeriod;
      time_T *sfcnOffset = SG__DMA_test_M->NonInlinedSFcns.Sfcn0.sfcnOffset;
      int_T *sfcnTsMap = SG__DMA_test_M->NonInlinedSFcns.Sfcn0.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__DMA_test_M->NonInlinedSFcns.blkInfo2[0]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__DMA_test_M->NonInlinedSFcns.inputOutputPortInfo2[0]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__DMA_test_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__DMA_test_M->NonInlinedSFcns.methods2[0]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__DMA_test_M->NonInlinedSFcns.methods3[0]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__DMA_test_M->NonInlinedSFcns.methods4[0]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__DMA_test_M->NonInlinedSFcns.statesInfo2[0]);
        ssSetPeriodicStatesInfo(rts,
          &SG__DMA_test_M->NonInlinedSFcns.periodicStatesInfo[0]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 2);
        ssSetPortInfoForInputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.inputPortInfo[0]);
        ssSetPortInfoForInputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.inputPortInfo[0]);
        _ssSetPortInfo2ForInputUnits(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.inputPortUnits[0]);
        ssSetInputPortUnit(rts, 0, 0);
        ssSetInputPortUnit(rts, 1, 0);
        _ssSetPortInfo2ForInputCoSimAttribute(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.inputPortCoSimAttribute[0]);
        ssSetInputPortIsContinuousQuantity(rts, 0, 0);
        ssSetInputPortIsContinuousQuantity(rts, 1, 0);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0, &SG__DMA_test_B.Gain1);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidthAsInt(rts, 0, 1);
        }

        /* port 1 */
        {
          ssSetInputPortRequiredContiguous(rts, 1, 1);
          ssSetInputPortSignal(rts, 1, &SG__DMA_test_B.Gain4);
          _ssSetInputPortNumDimensions(rts, 1, 1);
          ssSetInputPortWidthAsInt(rts, 1, 1);
        }
      }

      /* path info */
      ssSetModelName(rts, "IO135_AnalogOutput ");
      ssSetPath(rts, "SG__DMA_test/Subsystem/IO135_AnalogOutput ");
      ssSetRTModel(rts,SG__DMA_test_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.params;
        ssSetSFcnParamsCount(rts, 13);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogOutput_P13_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &SG__DMA_test_DW.IO135_AnalogOutput_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn0.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 1);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 0, 5);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__DMA_test_DW.IO135_AnalogOutput_PWORK[0]);
      }

      /* registration */
      sg_IO132_IO133_da_s_v2(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, -1.0);
      ssSetOffsetTime(rts, 0, -2.0);
      sfcnTsMap[0] = 1;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCsAsInt(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);
      _ssSetInputPortConnected(rts, 1, 1);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
      ssSetInputPortBufferDstPort(rts, 1, -1);
    }

    /* Level2 S-Function Block: SG__DMA_test/<S1>/IO135_AnalogInput  (sg_IO132_IO133_ad_s_v2) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[1];

      /* timing info */
      time_T *sfcnPeriod = SG__DMA_test_M->NonInlinedSFcns.Sfcn1.sfcnPeriod;
      time_T *sfcnOffset = SG__DMA_test_M->NonInlinedSFcns.Sfcn1.sfcnOffset;
      int_T *sfcnTsMap = SG__DMA_test_M->NonInlinedSFcns.Sfcn1.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__DMA_test_M->NonInlinedSFcns.blkInfo2[1]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__DMA_test_M->NonInlinedSFcns.inputOutputPortInfo2[1]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__DMA_test_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__DMA_test_M->NonInlinedSFcns.methods2[1]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__DMA_test_M->NonInlinedSFcns.methods3[1]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__DMA_test_M->NonInlinedSFcns.methods4[1]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__DMA_test_M->NonInlinedSFcns.statesInfo2[1]);
        ssSetPeriodicStatesInfo(rts,
          &SG__DMA_test_M->NonInlinedSFcns.periodicStatesInfo[1]);
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.outputPortInfo[0]);
        ssSetPortInfoForOutputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 2);
        _ssSetPortInfo2ForOutputUnits(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.outputPortUnits[0]);
        ssSetOutputPortUnit(rts, 0, 0);
        ssSetOutputPortUnit(rts, 1, 0);
        _ssSetPortInfo2ForOutputCoSimAttribute(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.outputPortCoSimAttribute[0]);
        ssSetOutputPortIsContinuousQuantity(rts, 0, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 1, 0);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidthAsInt(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((real_T *) &SG__DMA_test_B.IO135_AI_CH1));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidthAsInt(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((real_T *) &SG__DMA_test_B.IO135_AI_CH2));
        }
      }

      /* path info */
      ssSetModelName(rts, "IO135_AnalogInput ");
      ssSetPath(rts, "SG__DMA_test/Subsystem/IO135_AnalogInput ");
      ssSetRTModel(rts,SG__DMA_test_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.params;
        ssSetSFcnParamsCount(rts, 11);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       SG__DMA_test_cal->IO135_AnalogInput_P11_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &SG__DMA_test_DW.IO135_AnalogInput_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn1.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 1);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 0, 4);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__DMA_test_DW.IO135_AnalogInput_PWORK[0]);
      }

      /* registration */
      sg_IO132_IO133_ad_s_v2(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, -1.0);
      ssSetOffsetTime(rts, 0, -2.0);
      sfcnTsMap[0] = 1;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCsAsInt(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetOutputPortConnected(rts, 0, 1);
      _ssSetOutputPortConnected(rts, 1, 1);
      _ssSetOutputPortBeingMerged(rts, 0, 0);
      _ssSetOutputPortBeingMerged(rts, 1, 0);

      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: SG__DMA_test/<Root>/IO135_Setup  (sg_IO132_IO133_setup_s_v2) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[2];

      /* timing info */
      time_T *sfcnPeriod = SG__DMA_test_M->NonInlinedSFcns.Sfcn2.sfcnPeriod;
      time_T *sfcnOffset = SG__DMA_test_M->NonInlinedSFcns.Sfcn2.sfcnOffset;
      int_T *sfcnTsMap = SG__DMA_test_M->NonInlinedSFcns.Sfcn2.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__DMA_test_M->NonInlinedSFcns.blkInfo2[2]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__DMA_test_M->NonInlinedSFcns.inputOutputPortInfo2[2]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__DMA_test_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__DMA_test_M->NonInlinedSFcns.methods2[2]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__DMA_test_M->NonInlinedSFcns.methods3[2]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__DMA_test_M->NonInlinedSFcns.methods4[2]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__DMA_test_M->NonInlinedSFcns.statesInfo2[2]);
        ssSetPeriodicStatesInfo(rts,
          &SG__DMA_test_M->NonInlinedSFcns.periodicStatesInfo[2]);
      }

      /* path info */
      ssSetModelName(rts, "IO135_Setup ");
      ssSetPath(rts, "SG__DMA_test/IO135_Setup ");
      ssSetRTModel(rts,SG__DMA_test_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn2.params;
        ssSetSFcnParamsCount(rts, 35);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__DMA_test_cal->IO135_Setup_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__DMA_test_cal->IO135_Setup_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__DMA_test_cal->IO135_Setup_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__DMA_test_cal->IO135_Setup_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__DMA_test_cal->IO135_Setup_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__DMA_test_cal->IO135_Setup_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__DMA_test_cal->IO135_Setup_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__DMA_test_cal->IO135_Setup_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__DMA_test_cal->IO135_Setup_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__DMA_test_cal->IO135_Setup_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__DMA_test_cal->IO135_Setup_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)SG__DMA_test_cal->IO135_Setup_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)SG__DMA_test_cal->IO135_Setup_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)SG__DMA_test_cal->IO135_Setup_P14_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)SG__DMA_test_cal->IO135_Setup_P15_Size);
        ssSetSFcnParam(rts, 15, (mxArray*)SG__DMA_test_cal->IO135_Setup_P16_Size);
        ssSetSFcnParam(rts, 16, (mxArray*)SG__DMA_test_cal->IO135_Setup_P17_Size);
        ssSetSFcnParam(rts, 17, (mxArray*)SG__DMA_test_cal->IO135_Setup_P18_Size);
        ssSetSFcnParam(rts, 18, (mxArray*)SG__DMA_test_cal->IO135_Setup_P19_Size);
        ssSetSFcnParam(rts, 19, (mxArray*)SG__DMA_test_cal->IO135_Setup_P20_Size);
        ssSetSFcnParam(rts, 20, (mxArray*)SG__DMA_test_cal->IO135_Setup_P21_Size);
        ssSetSFcnParam(rts, 21, (mxArray*)SG__DMA_test_cal->IO135_Setup_P22_Size);
        ssSetSFcnParam(rts, 22, (mxArray*)SG__DMA_test_cal->IO135_Setup_P23_Size);
        ssSetSFcnParam(rts, 23, (mxArray*)SG__DMA_test_cal->IO135_Setup_P24_Size);
        ssSetSFcnParam(rts, 24, (mxArray*)SG__DMA_test_cal->IO135_Setup_P25_Size);
        ssSetSFcnParam(rts, 25, (mxArray*)SG__DMA_test_cal->IO135_Setup_P26_Size);
        ssSetSFcnParam(rts, 26, (mxArray*)SG__DMA_test_cal->IO135_Setup_P27_Size);
        ssSetSFcnParam(rts, 27, (mxArray*)SG__DMA_test_cal->IO135_Setup_P28_Size);
        ssSetSFcnParam(rts, 28, (mxArray*)SG__DMA_test_cal->IO135_Setup_P29_Size);
        ssSetSFcnParam(rts, 29, (mxArray*)SG__DMA_test_cal->IO135_Setup_P30_Size);
        ssSetSFcnParam(rts, 30, (mxArray*)SG__DMA_test_cal->IO135_Setup_P31_Size);
        ssSetSFcnParam(rts, 31, (mxArray*)SG__DMA_test_cal->IO135_Setup_P32_Size);
        ssSetSFcnParam(rts, 32, (mxArray*)SG__DMA_test_cal->IO135_Setup_P33_Size);
        ssSetSFcnParam(rts, 33, (mxArray*)SG__DMA_test_cal->IO135_Setup_P34_Size);
        ssSetSFcnParam(rts, 34, (mxArray*)SG__DMA_test_cal->IO135_Setup_P35_Size);
      }

      /* registration */
      sg_IO132_IO133_setup_s_v2(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 5.0E-5);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCsAsInt(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: SG__DMA_test/<Root>/Setup (v2)  (sg_IO104_DMA_setup_s) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[3];

      /* timing info */
      time_T *sfcnPeriod = SG__DMA_test_M->NonInlinedSFcns.Sfcn3.sfcnPeriod;
      time_T *sfcnOffset = SG__DMA_test_M->NonInlinedSFcns.Sfcn3.sfcnOffset;
      int_T *sfcnTsMap = SG__DMA_test_M->NonInlinedSFcns.Sfcn3.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__DMA_test_M->NonInlinedSFcns.blkInfo2[3]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__DMA_test_M->NonInlinedSFcns.inputOutputPortInfo2[3]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__DMA_test_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__DMA_test_M->NonInlinedSFcns.methods2[3]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__DMA_test_M->NonInlinedSFcns.methods3[3]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__DMA_test_M->NonInlinedSFcns.methods4[3]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__DMA_test_M->NonInlinedSFcns.statesInfo2[3]);
        ssSetPeriodicStatesInfo(rts,
          &SG__DMA_test_M->NonInlinedSFcns.periodicStatesInfo[3]);
      }

      /* path info */
      ssSetModelName(rts, "Setup (v2) ");
      ssSetPath(rts, "SG__DMA_test/Setup (v2) ");
      ssSetRTModel(rts,SG__DMA_test_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn3.params;
        ssSetSFcnParamsCount(rts, 29);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__DMA_test_cal->Setupv2_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__DMA_test_cal->Setupv2_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__DMA_test_cal->Setupv2_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__DMA_test_cal->Setupv2_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__DMA_test_cal->Setupv2_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__DMA_test_cal->Setupv2_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__DMA_test_cal->Setupv2_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__DMA_test_cal->Setupv2_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__DMA_test_cal->Setupv2_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__DMA_test_cal->Setupv2_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__DMA_test_cal->Setupv2_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)SG__DMA_test_cal->Setupv2_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)SG__DMA_test_cal->Setupv2_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)SG__DMA_test_cal->Setupv2_P14_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)SG__DMA_test_cal->Setupv2_P15_Size);
        ssSetSFcnParam(rts, 15, (mxArray*)SG__DMA_test_cal->Setupv2_P16_Size);
        ssSetSFcnParam(rts, 16, (mxArray*)SG__DMA_test_cal->Setupv2_P17_Size);
        ssSetSFcnParam(rts, 17, (mxArray*)SG__DMA_test_cal->Setupv2_P18_Size);
        ssSetSFcnParam(rts, 18, (mxArray*)SG__DMA_test_cal->Setupv2_P19_Size);
        ssSetSFcnParam(rts, 19, (mxArray*)SG__DMA_test_cal->Setupv2_P20_Size);
        ssSetSFcnParam(rts, 20, (mxArray*)SG__DMA_test_cal->Setupv2_P21_Size);
        ssSetSFcnParam(rts, 21, (mxArray*)SG__DMA_test_cal->Setupv2_P22_Size);
        ssSetSFcnParam(rts, 22, (mxArray*)SG__DMA_test_cal->Setupv2_P23_Size);
        ssSetSFcnParam(rts, 23, (mxArray*)SG__DMA_test_cal->Setupv2_P24_Size);
        ssSetSFcnParam(rts, 24, (mxArray*)SG__DMA_test_cal->Setupv2_P25_Size);
        ssSetSFcnParam(rts, 25, (mxArray*)SG__DMA_test_cal->Setupv2_P26_Size);
        ssSetSFcnParam(rts, 26, (mxArray*)SG__DMA_test_cal->Setupv2_P27_Size);
        ssSetSFcnParam(rts, 27, (mxArray*)SG__DMA_test_cal->Setupv2_P28_Size);
        ssSetSFcnParam(rts, 28, (mxArray*)SG__DMA_test_cal->Setupv2_P29_Size);
      }

      /* work vectors */
      ssSetRWork(rts, (real_T *) &SG__DMA_test_DW.Setupv2_RWORK[0]);
      ssSetPWork(rts, (void **) &SG__DMA_test_DW.Setupv2_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn3.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn3.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 2);

        /* RWORK */
        ssSetDWorkWidthAsInt(rts, 0, 2);
        ssSetDWorkDataType(rts, 0,SS_DOUBLE);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__DMA_test_DW.Setupv2_RWORK[0]);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 1, 5);
        ssSetDWorkDataType(rts, 1,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 1, 0);
        ssSetDWork(rts, 1, &SG__DMA_test_DW.Setupv2_PWORK[0]);
      }

      /* registration */
      sg_IO104_DMA_setup_s(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 5.0E-5);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCsAsInt(rts, 0);

      /* Update connectivity flags for each port */
      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: SG__DMA_test/<Root>/Analog input (v2)  (sg_IO104_DMA_ad_s) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[4];

      /* timing info */
      time_T *sfcnPeriod = SG__DMA_test_M->NonInlinedSFcns.Sfcn4.sfcnPeriod;
      time_T *sfcnOffset = SG__DMA_test_M->NonInlinedSFcns.Sfcn4.sfcnOffset;
      int_T *sfcnTsMap = SG__DMA_test_M->NonInlinedSFcns.Sfcn4.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__DMA_test_M->NonInlinedSFcns.blkInfo2[4]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__DMA_test_M->NonInlinedSFcns.inputOutputPortInfo2[4]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__DMA_test_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__DMA_test_M->NonInlinedSFcns.methods2[4]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__DMA_test_M->NonInlinedSFcns.methods3[4]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__DMA_test_M->NonInlinedSFcns.methods4[4]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__DMA_test_M->NonInlinedSFcns.statesInfo2[4]);
        ssSetPeriodicStatesInfo(rts,
          &SG__DMA_test_M->NonInlinedSFcns.periodicStatesInfo[4]);
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.outputPortInfo[0]);
        ssSetPortInfoForOutputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 1);
        _ssSetPortInfo2ForOutputUnits(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.outputPortUnits[0]);
        ssSetOutputPortUnit(rts, 0, 0);
        _ssSetPortInfo2ForOutputCoSimAttribute(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.outputPortCoSimAttribute[0]);
        ssSetOutputPortIsContinuousQuantity(rts, 0, 0);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidthAsInt(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((real_T *)
            &SG__DMA_test_B.Analoginputv2));
        }
      }

      /* path info */
      ssSetModelName(rts, "Analog input (v2) ");
      ssSetPath(rts, "SG__DMA_test/Analog input (v2) ");
      ssSetRTModel(rts,SG__DMA_test_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.params;
        ssSetSFcnParamsCount(rts, 14);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__DMA_test_cal->Analoginputv2_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__DMA_test_cal->Analoginputv2_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__DMA_test_cal->Analoginputv2_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__DMA_test_cal->Analoginputv2_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__DMA_test_cal->Analoginputv2_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__DMA_test_cal->Analoginputv2_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__DMA_test_cal->Analoginputv2_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__DMA_test_cal->Analoginputv2_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__DMA_test_cal->Analoginputv2_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       SG__DMA_test_cal->Analoginputv2_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       SG__DMA_test_cal->Analoginputv2_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)
                       SG__DMA_test_cal->Analoginputv2_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)
                       SG__DMA_test_cal->Analoginputv2_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)
                       SG__DMA_test_cal->Analoginputv2_P14_Size);
      }

      /* work vectors */
      ssSetRWork(rts, (real_T *) &SG__DMA_test_DW.Analoginputv2_RWORK[0]);
      ssSetIWork(rts, (int_T *) &SG__DMA_test_DW.Analoginputv2_IWORK[0]);
      ssSetPWork(rts, (void **) &SG__DMA_test_DW.Analoginputv2_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn4.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 3);

        /* RWORK */
        ssSetDWorkWidthAsInt(rts, 0, 16);
        ssSetDWorkDataType(rts, 0,SS_DOUBLE);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__DMA_test_DW.Analoginputv2_RWORK[0]);

        /* IWORK */
        ssSetDWorkWidthAsInt(rts, 1, 9);
        ssSetDWorkDataType(rts, 1,SS_INTEGER);
        ssSetDWorkComplexSignal(rts, 1, 0);
        ssSetDWork(rts, 1, &SG__DMA_test_DW.Analoginputv2_IWORK[0]);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 2, 20);
        ssSetDWorkDataType(rts, 2,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 2, 0);
        ssSetDWork(rts, 2, &SG__DMA_test_DW.Analoginputv2_PWORK[0]);
      }

      /* registration */
      sg_IO104_DMA_ad_s(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 5.0E-5);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCsAsInt(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetOutputPortConnected(rts, 0, 1);
      _ssSetOutputPortBeingMerged(rts, 0, 0);

      /* Update the BufferDstPort flags for each input port */
    }

    /* Level2 S-Function Block: SG__DMA_test/<Root>/Analog output (v2)  (sg_IO104_DMA_da_s) */
    {
      SimStruct *rts = SG__DMA_test_M->childSfunctions[5];

      /* timing info */
      time_T *sfcnPeriod = SG__DMA_test_M->NonInlinedSFcns.Sfcn5.sfcnPeriod;
      time_T *sfcnOffset = SG__DMA_test_M->NonInlinedSFcns.Sfcn5.sfcnOffset;
      int_T *sfcnTsMap = SG__DMA_test_M->NonInlinedSFcns.Sfcn5.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__DMA_test_M->NonInlinedSFcns.blkInfo2[5]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__DMA_test_M->NonInlinedSFcns.inputOutputPortInfo2[5]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__DMA_test_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__DMA_test_M->NonInlinedSFcns.methods2[5]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__DMA_test_M->NonInlinedSFcns.methods3[5]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__DMA_test_M->NonInlinedSFcns.methods4[5]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__DMA_test_M->NonInlinedSFcns.statesInfo2[5]);
        ssSetPeriodicStatesInfo(rts,
          &SG__DMA_test_M->NonInlinedSFcns.periodicStatesInfo[5]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 1);
        ssSetPortInfoForInputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.inputPortInfo[0]);
        ssSetPortInfoForInputs(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.inputPortInfo[0]);
        _ssSetPortInfo2ForInputUnits(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.inputPortUnits[0]);
        ssSetInputPortUnit(rts, 0, 0);
        _ssSetPortInfo2ForInputCoSimAttribute(rts,
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.inputPortCoSimAttribute[0]);
        ssSetInputPortIsContinuousQuantity(rts, 0, 0);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0, &SG__DMA_test_B.Gain);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidthAsInt(rts, 0, 1);
        }
      }

      /* path info */
      ssSetModelName(rts, "Analog output (v2) ");
      ssSetPath(rts, "SG__DMA_test/Analog output (v2) ");
      ssSetRTModel(rts,SG__DMA_test_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.params;
        ssSetSFcnParamsCount(rts, 15);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P14_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)
                       SG__DMA_test_cal->Analogoutputv2_P15_Size);
      }

      /* work vectors */
      ssSetRWork(rts, (real_T *) &SG__DMA_test_DW.Analogoutputv2_RWORK[0]);
      ssSetIWork(rts, (int_T *) &SG__DMA_test_DW.Analogoutputv2_IWORK[0]);
      ssSetPWork(rts, (void **) &SG__DMA_test_DW.Analogoutputv2_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__DMA_test_M->NonInlinedSFcns.Sfcn5.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 3);

        /* RWORK */
        ssSetDWorkWidthAsInt(rts, 0, 2);
        ssSetDWorkDataType(rts, 0,SS_DOUBLE);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__DMA_test_DW.Analogoutputv2_RWORK[0]);

        /* IWORK */
        ssSetDWorkWidthAsInt(rts, 1, 5);
        ssSetDWorkDataType(rts, 1,SS_INTEGER);
        ssSetDWorkComplexSignal(rts, 1, 0);
        ssSetDWork(rts, 1, &SG__DMA_test_DW.Analogoutputv2_IWORK[0]);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 2, 3);
        ssSetDWorkDataType(rts, 2,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 2, 0);
        ssSetDWork(rts, 2, &SG__DMA_test_DW.Analogoutputv2_PWORK[0]);
      }

      /* registration */
      sg_IO104_DMA_da_s(rts);
      sfcnInitializeSizes(rts);
      sfcnInitializeSampleTimes(rts);

      /* adjust sample time */
      ssSetSampleTime(rts, 0, 5.0E-5);
      ssSetOffsetTime(rts, 0, 0.0);
      sfcnTsMap[0] = 0;

      /* set compiled values of dynamic vector attributes */
      ssSetNumNonsampledZCsAsInt(rts, 0);

      /* Update connectivity flags for each port */
      _ssSetInputPortConnected(rts, 0, 1);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
    }
  }

  /* Start for S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/IO135_Setup ' */
  /* Level2 S-Function Block: '<Root>/IO135_Setup ' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[2];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO104_DMA_setup_s): '<Root>/Setup (v2) ' */
  /* Level2 S-Function Block: '<Root>/Setup (v2) ' (sg_IO104_DMA_setup_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[3];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO104_DMA_ad_s): '<Root>/Analog input (v2) ' */
  /* Level2 S-Function Block: '<Root>/Analog input (v2) ' (sg_IO104_DMA_ad_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[4];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO104_DMA_da_s): '<Root>/Analog output (v2) ' */
  /* Level2 S-Function Block: '<Root>/Analog output (v2) ' (sg_IO104_DMA_da_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[5];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for RateTransition: '<Root>/Rate Transition' */
  SG__DMA_test_B.RateTransition =
    SG__DMA_test_cal->RateTransition_InitialCondition;
  rtw_slrealtime_mutex_init(&SG__DMA_test_DW.RateTransition_d0_SEMAPHORE);
  rtw_slrealtime_mutex_init(&SG__DMA_test_M->Timing.semIdForTask1);

  /* InitializeConditions for S-Function (sdspchirp): '<Root>/Chirp' */

  /* DSP System Toolbox Chirp (sdspchirp) - '<Root>/Chirp' */
  /* Unidirectional Logarithmic  */
  if ((SG__DMA_test_cal->Chirp_f1 > SG__DMA_test_cal->Chirp_f0) &&
      (SG__DMA_test_cal->Chirp_f0 > 0.0) ) {
    SG__DMA_test_DW.Chirp_MIN_FREQ = SG__DMA_test_cal->Chirp_f1 /
      SG__DMA_test_cal->Chirp_f0;
    SG__DMA_test_DW.Chirp_BETA = SG__DMA_test_cal->Chirp_t1 / log
      (SG__DMA_test_DW.Chirp_MIN_FREQ);
  }

  SG__DMA_test_DW.Chirp_PERIOD_THETA = SG__DMA_test_DW.Chirp_BETA *
    SG__DMA_test_cal->Chirp_f0 * (pow(SG__DMA_test_DW.Chirp_MIN_FREQ ,
    SG__DMA_test_cal->Chirp_Tsweep / SG__DMA_test_cal->Chirp_t1) - 1.0);
  SG__DMA_test_DW.Chirp_SWEEP_DIRECTION = (SG__DMA_test_cal->Chirp_f1 >
    SG__DMA_test_cal->Chirp_f0) ? 0 : 1;
  SG__DMA_test_DW.Chirp_ACC_PHASE = 0.0;
  SG__DMA_test_DW.Chirp_CURRENT_STEP = 0.0;

  /* InitializeConditions for RateTransition: '<Root>/Rate Transition' */
  SG__DMA_test_DW.RateTransition_Buf[0] =
    SG__DMA_test_cal->RateTransition_InitialCondition;

  /* SystemInitialize for S-Function (slhwinterrupt): '<Root>/Interrupt Setup' incorporates:
   *  SubSystem: '<Root>/Subsystem'
   */

  /* System initialize for function-call system: '<Root>/Subsystem' */
  rtw_slrealtime_mutex_lock(SG__DMA_test_M->Timing.semIdForTask1);
  SG__DMA_test_M->Timing.clockTick1 = SG__DMA_test_M->Timing.rtmClockTickBuf1;
  SG__DMA_test_M->Timing.clockTickH1 =
    SG__DMA_test_M->Timing.rtmBufClockTickBufH1;
  rtw_slrealtime_mutex_unlock(SG__DMA_test_M->Timing.semIdForTask1);

  /* Start for S-Function (sg_IO132_IO133_da_s_v2): '<S1>/IO135_AnalogOutput ' */
  /* Level2 S-Function Block: '<S1>/IO135_AnalogOutput ' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[0];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO132_IO133_ad_s_v2): '<S1>/IO135_AnalogInput ' */
  /* Level2 S-Function Block: '<S1>/IO135_AnalogInput ' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[1];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  // Initialize the sigevent structs.  One for no wakeup and the other
  // when the board did interrupt.
  SIGEV_NONE_INIT( &Root_InterruptSetup_D.sig_none );

  // Root_InterruptSetup_D.sig_pulse is initialized each time the interrupt
  // occurs so we can send the incrementing count.

  // With a defined PCI map function, use the IRQ from QNX.
  // Need to test for error return here.  Since the hook function
  // can be in C, an error won't throw, but will return a negative number.
  // *_D.context gets a pointer to a context, which would be pci addresses
  // mapped to virtual memory for a hardware board.
  // For interrupt mode with hardware, IRQ is meaningful and .context
  // will contain mapped addresses to talk to the board.
  // For polling hardware, IRQ is not used and .context is still mapped
  // addresses to talk to the board.
  // For polling XCP or some other out-of-model condition, then IRQ
  // is also ignored and .context is a pointer to context for that other
  // condition we want to find.  If this 'software device' doesn't
  // need any context, then just specify mapper as "none".

  // We call the map function if it exists for all 4 permutations.
  // Int or polling, function or model.
  Root_InterruptSetup_D.IRQ = IO135_map_public( &Root_InterruptSetup_D.context,
    16776961 );
  if (Root_InterruptSetup_D.IRQ < 0 ) {
    sprintf( Root_InterruptSetup_errmsg,
            "Fatal error when configuring the interrupt or polling source in $<Name>\n"
            );
    rtmSetErrorStatus(SG__DMA_test_M, Root_InterruptSetup_errmsg);
  }

  // Priority is ignored in the sigevent because the connection is set up with priority
  // inheritance turned off.  But since we need to send it to codegen
  // adding it to the sigevent incurs no extra overhead.
  Root_InterruptSetup_D.pri = 254;

  // TaskID is 1 for Root_InterruptSetup_fc
  {
    // 1.  Attach the ISR to the IRQ we got from the map function
    uint32_T ret = InterruptAttach_r( Root_InterruptSetup_D.IRQ,
      Root_InterruptSetup_ISR,
      nullptr,
      0,
      0);
    if (ret >= 0 )                  // ret is the interrupt ID, needed by detach
      Root_InterruptSetup_D.intrID = ret;
    else                              // ret is the negative of the error number
    {
      sprintf( Root_InterruptSetup_errmsg,
              "Error attaching interrupt for block <Root>/Interrupt Setup: %s\n",
              strerror( -1*ret ) );
      rtmSetErrorStatus(SG__DMA_test_M, Root_InterruptSetup_errmsg);
    }

    slrealtime::SetInterruptMode( 1 );
    slrealtime::StartCallbackService::registerCB( std::bind
      ( Root_InterruptSetup_callback ), -100 );
  }

  /* End of SystemInitialize for S-Function (slhwinterrupt): '<Root>/Interrupt Setup' */
}

/* Model terminate function */
void SG__DMA_test_terminate(void)
{
  /* user code (Terminate function Header) */
  {
    // stop the board from interrupting, changing status or doing DMA transfers.
    IO135_stop_public( Root_InterruptSetup_D.context );

    // Detach the interrupt
    uint32_T ret = InterruptDetach_r( Root_InterruptSetup_D.intrID );
    if (ret != EOK ) {
      sprintf( Root_InterruptSetup_errmsg,
              "Error detaching interrupt for block <Root>/Interrupt Setup: %s\n",
              strerror( ret ) );
      rtmSetErrorStatus(SG__DMA_test_M, Root_InterruptSetup_errmsg);
    }
  }

  rtw_slrealtime_mutex_destroy(SG__DMA_test_M->Timing.semIdForTask1);

  /* Terminate for S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/IO135_Setup ' */
  /* Level2 S-Function Block: '<Root>/IO135_Setup ' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[2];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO104_DMA_setup_s): '<Root>/Setup (v2) ' */
  /* Level2 S-Function Block: '<Root>/Setup (v2) ' (sg_IO104_DMA_setup_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[3];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO104_DMA_ad_s): '<Root>/Analog input (v2) ' */
  /* Level2 S-Function Block: '<Root>/Analog input (v2) ' (sg_IO104_DMA_ad_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[4];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO104_DMA_da_s): '<Root>/Analog output (v2) ' */
  /* Level2 S-Function Block: '<Root>/Analog output (v2) ' (sg_IO104_DMA_da_s) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[5];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (slhwinterrupt): '<Root>/Interrupt Setup' incorporates:
   *  SubSystem: '<Root>/Subsystem'
   */

  /* Termination for function-call system: '<Root>/Subsystem' */

  /* Terminate for S-Function (sg_IO132_IO133_da_s_v2): '<S1>/IO135_AnalogOutput ' */
  /* Level2 S-Function Block: '<S1>/IO135_AnalogOutput ' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[0];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO132_IO133_ad_s_v2): '<S1>/IO135_AnalogInput ' */
  /* Level2 S-Function Block: '<S1>/IO135_AnalogInput ' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__DMA_test_M->childSfunctions[1];
    sfcnTerminate(rts);
  }

  /* End of Terminate for S-Function (slhwinterrupt): '<Root>/Interrupt Setup' */

  /* Terminate for RateTransition: '<Root>/Rate Transition' */
  rtw_slrealtime_mutex_destroy(SG__DMA_test_DW.RateTransition_d0_SEMAPHORE);
}
