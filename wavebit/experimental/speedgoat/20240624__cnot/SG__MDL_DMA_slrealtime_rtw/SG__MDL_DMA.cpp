/*
 * SG__MDL_DMA.cpp
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL_DMA".
 *
 * Model version              : 6.462
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Wed Jun 26 14:40:43 2024
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#include "SG__MDL_DMA.h"
#include "rtwtypes.h"
#include "SG__MDL_DMA_private.h"
#include "SG__MDL_DMA_types.h"
#include "SG__MDL_DMA_cal.h"
#include <cmath>
#include <cstring>

extern "C"
{

#include "rt_nonfinite.h"

}

/* Exported block parameters */
real_T src_gain = 0.05;                /* Variable: src_gain
                                        * Referenced by: '<S1>/src_gain'
                                        */

/* Block signals (default storage) */
B_SG__MDL_DMA_T SG__MDL_DMA_B;

/* Block states (default storage) */
DW_SG__MDL_DMA_T SG__MDL_DMA_DW;

/* Real-time model */
RT_MODEL_SG__MDL_DMA_T SG__MDL_DMA_M_ = RT_MODEL_SG__MDL_DMA_T();
RT_MODEL_SG__MDL_DMA_T *const SG__MDL_DMA_M = &SG__MDL_DMA_M_;

/* System initialize for atomic system: */
void SG__MDL_DMA_DCBlocker_Init(DW_DCBlocker_SG__MDL_DMA_T *localDW)
{
  b_dspcodegen_BiquadFilter_SG__T *obj;

  /* Start for MATLABSystem: '<Root>/DC Blocker' */
  localDW->obj.matlabCodegenIsDeleted = false;
  localDW->objisempty = true;
  localDW->obj.isInitialized = 1;
  localDW->obj.pNumChannels = 1;
  obj = &localDW->obj.pFilter;
  localDW->obj.pFilter.isInitialized = 0;

  /* System object Constructor function: dsp.BiquadFilter */
  obj->cSFunObject.P0_ICRTP = 0.0;
  obj->cSFunObject.P1_RTP1COEFF[0] = 3.4894396970323571E-5;
  obj->cSFunObject.P1_RTP1COEFF[1] = 3.4894396970323416E-5;
  obj->cSFunObject.P1_RTP1COEFF[2] = 0.0;
  obj->cSFunObject.P1_RTP1COEFF[3] = 1.0;
  obj->cSFunObject.P1_RTP1COEFF[4] = -1.9992694992120192;
  obj->cSFunObject.P1_RTP1COEFF[5] = 1.0;
  obj->cSFunObject.P2_RTP2COEFF[0] = -0.99693230611902517;
  obj->cSFunObject.P2_RTP2COEFF[1] = 0.0;
  obj->cSFunObject.P2_RTP2COEFF[2] = -1.9969854763157575;
  obj->cSFunObject.P2_RTP2COEFF[3] = 0.99700209491296565;
  obj->cSFunObject.P3_RTP3COEFF[0] = 1.0;
  obj->cSFunObject.P3_RTP3COEFF[1] = 0.0;
  obj->cSFunObject.P3_RTP3COEFF[2] = 0.0;
  obj->cSFunObject.P4_RTP_COEFF3_BOOL[0] = false;
  obj->cSFunObject.P4_RTP_COEFF3_BOOL[1] = false;
  obj->cSFunObject.P4_RTP_COEFF3_BOOL[2] = false;
  localDW->obj.pFilter.matlabCodegenIsDeleted = false;
  localDW->obj.isSetupComplete = true;

  /* InitializeConditions for MATLABSystem: '<Root>/DC Blocker' */
  obj = &localDW->obj.pFilter;
  if (localDW->obj.pFilter.isInitialized == 1) {
    /* System object Initialization function: dsp.BiquadFilter */
    obj->cSFunObject.W0_FILT_STATES[0] = obj->cSFunObject.P0_ICRTP;
    obj->cSFunObject.W0_FILT_STATES[1] = obj->cSFunObject.P0_ICRTP;
    obj->cSFunObject.W0_FILT_STATES[2] = obj->cSFunObject.P0_ICRTP;
    obj->cSFunObject.W0_FILT_STATES[3] = obj->cSFunObject.P0_ICRTP;
  }

  /* End of InitializeConditions for MATLABSystem: '<Root>/DC Blocker' */
}

/* Output and update for atomic system: */
void SG__MDL_DMA_DCBlocker(real_T rtu_0, B_DCBlocker_SG__MDL_DMA_T *localB,
  DW_DCBlocker_SG__MDL_DMA_T *localDW)
{
  b_dspcodegen_BiquadFilter_SG__T *obj;
  real_T numAccum;
  real_T numAccum_0;
  real_T numAccum_1;

  /* MATLABSystem: '<Root>/DC Blocker' */
  obj = &localDW->obj.pFilter;
  if (localDW->obj.pFilter.isInitialized != 1) {
    localDW->obj.pFilter.isInitialized = 1;
    localDW->obj.pFilter.isSetupComplete = true;

    /* System object Initialization function: dsp.BiquadFilter */
    obj->cSFunObject.W0_FILT_STATES[0] = obj->cSFunObject.P0_ICRTP;
    obj->cSFunObject.W0_FILT_STATES[1] = obj->cSFunObject.P0_ICRTP;
    obj->cSFunObject.W0_FILT_STATES[2] = obj->cSFunObject.P0_ICRTP;
    obj->cSFunObject.W0_FILT_STATES[3] = obj->cSFunObject.P0_ICRTP;
  }

  /* System object Outputs function: dsp.BiquadFilter */
  numAccum = localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[0];
  numAccum_0 = localDW->obj.pFilter.cSFunObject.P1_RTP1COEFF[0] * rtu_0 +
    numAccum;
  numAccum = localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[1];
  numAccum += localDW->obj.pFilter.cSFunObject.P1_RTP1COEFF[1] * rtu_0;
  numAccum -= localDW->obj.pFilter.cSFunObject.P2_RTP2COEFF[0] * numAccum_0;
  localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[0] = numAccum;
  numAccum = localDW->obj.pFilter.cSFunObject.P1_RTP1COEFF[2] * rtu_0;
  numAccum -= localDW->obj.pFilter.cSFunObject.P2_RTP2COEFF[1] * numAccum_0;
  localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[1] = numAccum;
  numAccum = localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[2];
  numAccum_1 = localDW->obj.pFilter.cSFunObject.P1_RTP1COEFF[3] * numAccum_0 +
    numAccum;
  numAccum = localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[3];
  numAccum += localDW->obj.pFilter.cSFunObject.P1_RTP1COEFF[4] * numAccum_0;
  numAccum -= localDW->obj.pFilter.cSFunObject.P2_RTP2COEFF[2] * numAccum_1;
  localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[2] = numAccum;
  numAccum = localDW->obj.pFilter.cSFunObject.P1_RTP1COEFF[5] * numAccum_0;
  numAccum -= localDW->obj.pFilter.cSFunObject.P2_RTP2COEFF[3] * numAccum_1;
  localDW->obj.pFilter.cSFunObject.W0_FILT_STATES[3] = numAccum;

  /* MATLABSystem: '<Root>/DC Blocker' */
  localB->DCBlocker = rtu_0 - numAccum_1;
}

/* Termination for atomic system: */
void SG__MDL_DMA_DCBlocker_Term(DW_DCBlocker_SG__MDL_DMA_T *localDW)
{
  /* Terminate for MATLABSystem: '<Root>/DC Blocker' */
  if (!localDW->obj.matlabCodegenIsDeleted) {
    localDW->obj.matlabCodegenIsDeleted = true;
    if ((localDW->obj.isInitialized == 1) && localDW->obj.isSetupComplete) {
      if (localDW->obj.pFilter.isInitialized == 1) {
        localDW->obj.pFilter.isInitialized = 2;
      }

      localDW->obj.pNumChannels = -1;
    }
  }

  if (!localDW->obj.pFilter.matlabCodegenIsDeleted) {
    localDW->obj.pFilter.matlabCodegenIsDeleted = true;
    if (localDW->obj.pFilter.isInitialized == 1) {
      localDW->obj.pFilter.isInitialized = 2;
    }
  }

  /* End of Terminate for MATLABSystem: '<Root>/DC Blocker' */
}

/* Model step function */
void SG__MDL_DMA_step(void)
{
  /* Reset subsysRan breadcrumbs */
  srClearBC(SG__MDL_DMA_DW.source_SubsysRanBC);

  /* S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/setup_135' */

  /* Level2 S-Function Block: '<Root>/setup_135' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[0];
    sfcnOutputs(rts,0);
  }

  /* Outputs for Enabled SubSystem: '<Root>/source' incorporates:
   *  EnablePort: '<S1>/Enable'
   */
  /* Constant: '<Root>/Constant' */
  if (SG__MDL_DMA_cal->Constant_Value > 0.0) {
    real_T lastSin_tmp;
    uint32_T rtb_FixPtSum1;
    if (!SG__MDL_DMA_DW.source_MODE) {
      /* InitializeConditions for UnitDelay: '<S2>/Output' */
      SG__MDL_DMA_DW.Output_DSTATE = SG__MDL_DMA_cal->Output_InitialCondition;

      /* Enable for Sin: '<S1>/wb1_0' */
      SG__MDL_DMA_DW.systemEnable = 1;

      /* Enable for Sin: '<S1>/wb1_1' */
      SG__MDL_DMA_DW.systemEnable_g = 1;
      SG__MDL_DMA_DW.source_MODE = true;
    }

    /* Sin: '<S1>/wb1_0' */
    if (SG__MDL_DMA_DW.systemEnable != 0) {
      lastSin_tmp = SG__MDL_DMA_cal->freq_res * 2.0 * 3.1415926535897931 *
        SG__MDL_DMA_M->Timing.t[0];
      SG__MDL_DMA_DW.lastSin = std::sin(lastSin_tmp);
      SG__MDL_DMA_DW.lastCos = std::cos(lastSin_tmp);
      SG__MDL_DMA_DW.systemEnable = 0;
    }

    /* Sin: '<S1>/wb1_1' */
    if (SG__MDL_DMA_DW.systemEnable_g != 0) {
      lastSin_tmp = SG__MDL_DMA_cal->freq_res * 2.0 * 2.0 * 3.1415926535897931 *
        SG__MDL_DMA_M->Timing.t[0];
      SG__MDL_DMA_DW.lastSin_g = std::sin(lastSin_tmp);
      SG__MDL_DMA_DW.lastCos_a = std::cos(lastSin_tmp);
      SG__MDL_DMA_DW.systemEnable_g = 0;
    }

    /* Sum: '<S3>/FixPt Sum1' incorporates:
     *  Constant: '<S3>/FixPt Constant'
     *  UnitDelay: '<S2>/Output'
     */
    rtb_FixPtSum1 = SG__MDL_DMA_DW.Output_DSTATE +
      SG__MDL_DMA_cal->FixPtConstant_Value;

    /* Gain: '<S1>/cntr_gain' incorporates:
     *  UnitDelay: '<S2>/Output'
     */
    lastSin_tmp = SG__MDL_DMA_cal->cntr_gain_Gain * static_cast<real_T>
      (SG__MDL_DMA_DW.Output_DSTATE);

    /* Saturate: '<S1>/Saturation' */
    if (lastSin_tmp > SG__MDL_DMA_cal->Saturation_UpperSat) {
      lastSin_tmp = SG__MDL_DMA_cal->Saturation_UpperSat;
    } else if (lastSin_tmp < SG__MDL_DMA_cal->Saturation_LowerSat) {
      lastSin_tmp = SG__MDL_DMA_cal->Saturation_LowerSat;
    }

    /* Gain: '<S1>/src_gain' incorporates:
     *  Product: '<S1>/Product1'
     *  Saturate: '<S1>/Saturation'
     *  Sin: '<S1>/wb1_0'
     *  Sin: '<S1>/wb1_1'
     *  Sum: '<S1>/Sum'
     */
    SG__MDL_DMA_B.src_gain_j = ((((SG__MDL_DMA_DW.lastSin *
      SG__MDL_DMA_cal->wb1_0_PCos + SG__MDL_DMA_DW.lastCos *
      SG__MDL_DMA_cal->wb1_0_PSin) * SG__MDL_DMA_cal->wb1_0_HCos +
      (SG__MDL_DMA_DW.lastCos * SG__MDL_DMA_cal->wb1_0_PCos -
       SG__MDL_DMA_DW.lastSin * SG__MDL_DMA_cal->wb1_0_PSin) *
      SG__MDL_DMA_cal->wb1_0_Hsin) * std::cos(SG__MDL_DMA_cal->wb1_theta / 2.0)
      + SG__MDL_DMA_cal->wb1_0_Bias) + (((SG__MDL_DMA_DW.lastSin_g *
      SG__MDL_DMA_cal->wb1_1_PCos + SG__MDL_DMA_DW.lastCos_a *
      SG__MDL_DMA_cal->wb1_1_PSin) * SG__MDL_DMA_cal->wb1_1_HCos +
      (SG__MDL_DMA_DW.lastCos_a * SG__MDL_DMA_cal->wb1_1_PCos -
       SG__MDL_DMA_DW.lastSin_g * SG__MDL_DMA_cal->wb1_1_PSin) *
      SG__MDL_DMA_cal->wb1_1_Hsin) * std::sin(SG__MDL_DMA_cal->wb1_theta / 2.0)
      + SG__MDL_DMA_cal->wb1_1_Bias)) * lastSin_tmp * src_gain;

    /* Update for Sin: '<S1>/wb1_0' */
    lastSin_tmp = SG__MDL_DMA_DW.lastSin;
    SG__MDL_DMA_DW.lastSin = SG__MDL_DMA_DW.lastSin *
      SG__MDL_DMA_cal->wb1_0_HCos + SG__MDL_DMA_DW.lastCos *
      SG__MDL_DMA_cal->wb1_0_Hsin;
    SG__MDL_DMA_DW.lastCos = SG__MDL_DMA_DW.lastCos *
      SG__MDL_DMA_cal->wb1_0_HCos - lastSin_tmp * SG__MDL_DMA_cal->wb1_0_Hsin;

    /* Update for Sin: '<S1>/wb1_1' */
    lastSin_tmp = SG__MDL_DMA_DW.lastSin_g;
    SG__MDL_DMA_DW.lastSin_g = SG__MDL_DMA_DW.lastSin_g *
      SG__MDL_DMA_cal->wb1_1_HCos + SG__MDL_DMA_DW.lastCos_a *
      SG__MDL_DMA_cal->wb1_1_Hsin;
    SG__MDL_DMA_DW.lastCos_a = SG__MDL_DMA_DW.lastCos_a *
      SG__MDL_DMA_cal->wb1_1_HCos - lastSin_tmp * SG__MDL_DMA_cal->wb1_1_Hsin;

    /* Switch: '<S4>/FixPt Switch' */
    if (rtb_FixPtSum1 > SG__MDL_DMA_cal->WrapToZero_Threshold) {
      /* Update for UnitDelay: '<S2>/Output' incorporates:
       *  Constant: '<S4>/Constant'
       */
      SG__MDL_DMA_DW.Output_DSTATE = SG__MDL_DMA_cal->Constant_Value_n;
    } else {
      /* Update for UnitDelay: '<S2>/Output' */
      SG__MDL_DMA_DW.Output_DSTATE = rtb_FixPtSum1;
    }

    /* End of Switch: '<S4>/FixPt Switch' */
    srUpdateBC(SG__MDL_DMA_DW.source_SubsysRanBC);
  } else if (SG__MDL_DMA_DW.source_MODE) {
    /* Disable for Gain: '<S1>/src_gain' incorporates:
     *  Outport: '<S1>/signal'
     */
    SG__MDL_DMA_B.src_gain_j = SG__MDL_DMA_cal->signal_Y0;
    SG__MDL_DMA_DW.source_MODE = false;
  }

  /* End of Constant: '<Root>/Constant' */
  /* End of Outputs for SubSystem: '<Root>/source' */
  /* S-Function (sg_IO132_IO133_da_s_v2): '<Root>/ao_2' */

  /* Level2 S-Function Block: '<Root>/ao_2' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[1];
    sfcnOutputs(rts,0);
  }

  /* S-Function (sg_IO132_IO133_ad_s_v2): '<Root>/ai_135' */

  /* Level2 S-Function Block: '<Root>/ai_135' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[2];
    sfcnOutputs(rts,0);
  }

  SG__MDL_DMA_DCBlocker(SG__MDL_DMA_B.p11, &SG__MDL_DMA_B.DCBlocker,
                        &SG__MDL_DMA_DW.DCBlocker);
  SG__MDL_DMA_DCBlocker(SG__MDL_DMA_B.ai_135_o2, &SG__MDL_DMA_B.DCBlocker1,
                        &SG__MDL_DMA_DW.DCBlocker1);

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++SG__MDL_DMA_M->Timing.clockTick0)) {
    ++SG__MDL_DMA_M->Timing.clockTickH0;
  }

  SG__MDL_DMA_M->Timing.t[0] = SG__MDL_DMA_M->Timing.clockTick0 *
    SG__MDL_DMA_M->Timing.stepSize0 + SG__MDL_DMA_M->Timing.clockTickH0 *
    SG__MDL_DMA_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void SG__MDL_DMA_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));
  rtsiSetSolverName(&SG__MDL_DMA_M->solverInfo,"FixedStepDiscrete");
  SG__MDL_DMA_M->solverInfoPtr = (&SG__MDL_DMA_M->solverInfo);

  /* Initialize timing info */
  {
    int_T *mdlTsMap = SG__MDL_DMA_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "SG__MDL_DMA_M points to
       static memory which is guaranteed to be non-NULL" */
    SG__MDL_DMA_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    SG__MDL_DMA_M->Timing.sampleTimes = (&SG__MDL_DMA_M->
      Timing.sampleTimesArray[0]);
    SG__MDL_DMA_M->Timing.offsetTimes = (&SG__MDL_DMA_M->
      Timing.offsetTimesArray[0]);

    /* task periods */
    SG__MDL_DMA_M->Timing.sampleTimes[0] = (5.0E-5);

    /* task offsets */
    SG__MDL_DMA_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(SG__MDL_DMA_M, &SG__MDL_DMA_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = SG__MDL_DMA_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    SG__MDL_DMA_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(SG__MDL_DMA_M, -1);
  SG__MDL_DMA_M->Timing.stepSize0 = 5.0E-5;
  SG__MDL_DMA_M->solverInfoPtr = (&SG__MDL_DMA_M->solverInfo);
  SG__MDL_DMA_M->Timing.stepSize = (5.0E-5);
  rtsiSetFixedStepSize(&SG__MDL_DMA_M->solverInfo, 5.0E-5);
  rtsiSetSolverMode(&SG__MDL_DMA_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  (void) std::memset((static_cast<void *>(&SG__MDL_DMA_B)), 0,
                     sizeof(B_SG__MDL_DMA_T));

  /* states (dwork) */
  (void) std::memset(static_cast<void *>(&SG__MDL_DMA_DW), 0,
                     sizeof(DW_SG__MDL_DMA_T));

  /* child S-Function registration */
  {
    RTWSfcnInfo *sfcnInfo = &SG__MDL_DMA_M->NonInlinedSFcns.sfcnInfo;
    SG__MDL_DMA_M->sfcnInfo = (sfcnInfo);
    rtssSetErrorStatusPtr(sfcnInfo, (&rtmGetErrorStatus(SG__MDL_DMA_M)));
    SG__MDL_DMA_M->Sizes.numSampTimes = (1);
    rtssSetNumRootSampTimesPtr(sfcnInfo, &SG__MDL_DMA_M->Sizes.numSampTimes);
    SG__MDL_DMA_M->NonInlinedSFcns.taskTimePtrs[0] = &(rtmGetTPtr(SG__MDL_DMA_M)
      [0]);
    rtssSetTPtrPtr(sfcnInfo,SG__MDL_DMA_M->NonInlinedSFcns.taskTimePtrs);
    rtssSetTStartPtr(sfcnInfo, &rtmGetTStart(SG__MDL_DMA_M));
    rtssSetTFinalPtr(sfcnInfo, &rtmGetTFinal(SG__MDL_DMA_M));
    rtssSetTimeOfLastOutputPtr(sfcnInfo, &rtmGetTimeOfLastOutput(SG__MDL_DMA_M));
    rtssSetStepSizePtr(sfcnInfo, &SG__MDL_DMA_M->Timing.stepSize);
    rtssSetStopRequestedPtr(sfcnInfo, &rtmGetStopRequested(SG__MDL_DMA_M));
    rtssSetDerivCacheNeedsResetPtr(sfcnInfo,
      &SG__MDL_DMA_M->derivCacheNeedsReset);
    rtssSetZCCacheNeedsResetPtr(sfcnInfo, &SG__MDL_DMA_M->zCCacheNeedsReset);
    rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo,
      &SG__MDL_DMA_M->CTOutputIncnstWithState);
    rtssSetSampleHitsPtr(sfcnInfo, &SG__MDL_DMA_M->Timing.sampleHits);
    rtssSetPerTaskSampleHitsPtr(sfcnInfo,
      &SG__MDL_DMA_M->Timing.perTaskSampleHits);
    rtssSetSimModePtr(sfcnInfo, &SG__MDL_DMA_M->simMode);
    rtssSetSolverInfoPtr(sfcnInfo, &SG__MDL_DMA_M->solverInfoPtr);
  }

  SG__MDL_DMA_M->Sizes.numSFcns = (3);

  /* register each child */
  {
    (void) std::memset(static_cast<void *>
                       (&SG__MDL_DMA_M->NonInlinedSFcns.childSFunctions[0]), 0,
                       3*sizeof(SimStruct));
    SG__MDL_DMA_M->childSfunctions =
      (&SG__MDL_DMA_M->NonInlinedSFcns.childSFunctionPtrs[0]);
    SG__MDL_DMA_M->childSfunctions[0] =
      (&SG__MDL_DMA_M->NonInlinedSFcns.childSFunctions[0]);
    SG__MDL_DMA_M->childSfunctions[1] =
      (&SG__MDL_DMA_M->NonInlinedSFcns.childSFunctions[1]);
    SG__MDL_DMA_M->childSfunctions[2] =
      (&SG__MDL_DMA_M->NonInlinedSFcns.childSFunctions[2]);

    /* Level2 S-Function Block: SG__MDL_DMA/<Root>/setup_135 (sg_IO132_IO133_setup_s_v2) */
    {
      SimStruct *rts = SG__MDL_DMA_M->childSfunctions[0];

      /* timing info */
      time_T *sfcnPeriod = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn0.sfcnPeriod;
      time_T *sfcnOffset = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn0.sfcnOffset;
      int_T *sfcnTsMap = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn0.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__MDL_DMA_M->NonInlinedSFcns.blkInfo2[0]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__MDL_DMA_M->NonInlinedSFcns.inputOutputPortInfo2[0]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__MDL_DMA_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods2[0]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods3[0]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods4[0]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__MDL_DMA_M->NonInlinedSFcns.statesInfo2[0]);
        ssSetPeriodicStatesInfo(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.periodicStatesInfo[0]);
      }

      /* path info */
      ssSetModelName(rts, "setup_135");
      ssSetPath(rts, "SG__MDL_DMA/setup_135");
      ssSetRTModel(rts,SG__MDL_DMA_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn0.params;
        ssSetSFcnParamsCount(rts, 35);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__MDL_DMA_cal->setup_135_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__MDL_DMA_cal->setup_135_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__MDL_DMA_cal->setup_135_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__MDL_DMA_cal->setup_135_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__MDL_DMA_cal->setup_135_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__MDL_DMA_cal->setup_135_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__MDL_DMA_cal->setup_135_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__MDL_DMA_cal->setup_135_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__MDL_DMA_cal->setup_135_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__MDL_DMA_cal->setup_135_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__MDL_DMA_cal->setup_135_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)SG__MDL_DMA_cal->setup_135_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)SG__MDL_DMA_cal->setup_135_P13_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)SG__MDL_DMA_cal->setup_135_P14_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)SG__MDL_DMA_cal->setup_135_P15_Size);
        ssSetSFcnParam(rts, 15, (mxArray*)SG__MDL_DMA_cal->setup_135_P16_Size);
        ssSetSFcnParam(rts, 16, (mxArray*)SG__MDL_DMA_cal->setup_135_P17_Size);
        ssSetSFcnParam(rts, 17, (mxArray*)SG__MDL_DMA_cal->setup_135_P18_Size);
        ssSetSFcnParam(rts, 18, (mxArray*)SG__MDL_DMA_cal->setup_135_P19_Size);
        ssSetSFcnParam(rts, 19, (mxArray*)SG__MDL_DMA_cal->setup_135_P20_Size);
        ssSetSFcnParam(rts, 20, (mxArray*)SG__MDL_DMA_cal->setup_135_P21_Size);
        ssSetSFcnParam(rts, 21, (mxArray*)SG__MDL_DMA_cal->setup_135_P22_Size);
        ssSetSFcnParam(rts, 22, (mxArray*)SG__MDL_DMA_cal->setup_135_P23_Size);
        ssSetSFcnParam(rts, 23, (mxArray*)SG__MDL_DMA_cal->setup_135_P24_Size);
        ssSetSFcnParam(rts, 24, (mxArray*)SG__MDL_DMA_cal->setup_135_P25_Size);
        ssSetSFcnParam(rts, 25, (mxArray*)SG__MDL_DMA_cal->setup_135_P26_Size);
        ssSetSFcnParam(rts, 26, (mxArray*)SG__MDL_DMA_cal->setup_135_P27_Size);
        ssSetSFcnParam(rts, 27, (mxArray*)SG__MDL_DMA_cal->setup_135_P28_Size);
        ssSetSFcnParam(rts, 28, (mxArray*)SG__MDL_DMA_cal->setup_135_P29_Size);
        ssSetSFcnParam(rts, 29, (mxArray*)SG__MDL_DMA_cal->setup_135_P30_Size);
        ssSetSFcnParam(rts, 30, (mxArray*)SG__MDL_DMA_cal->setup_135_P31_Size);
        ssSetSFcnParam(rts, 31, (mxArray*)SG__MDL_DMA_cal->setup_135_P32_Size);
        ssSetSFcnParam(rts, 32, (mxArray*)SG__MDL_DMA_cal->setup_135_P33_Size);
        ssSetSFcnParam(rts, 33, (mxArray*)SG__MDL_DMA_cal->setup_135_P34_Size);
        ssSetSFcnParam(rts, 34, (mxArray*)SG__MDL_DMA_cal->setup_135_P35_Size);
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

    /* Level2 S-Function Block: SG__MDL_DMA/<Root>/ao_2 (sg_IO132_IO133_da_s_v2) */
    {
      SimStruct *rts = SG__MDL_DMA_M->childSfunctions[1];

      /* timing info */
      time_T *sfcnPeriod = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.sfcnPeriod;
      time_T *sfcnOffset = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.sfcnOffset;
      int_T *sfcnTsMap = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__MDL_DMA_M->NonInlinedSFcns.blkInfo2[1]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__MDL_DMA_M->NonInlinedSFcns.inputOutputPortInfo2[1]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__MDL_DMA_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods2[1]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods3[1]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods4[1]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__MDL_DMA_M->NonInlinedSFcns.statesInfo2[1]);
        ssSetPeriodicStatesInfo(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.periodicStatesInfo[1]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 2);
        ssSetPortInfoForInputs(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.inputPortInfo[0]);
        ssSetPortInfoForInputs(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.inputPortInfo[0]);
        _ssSetPortInfo2ForInputUnits(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.inputPortUnits[0]);
        ssSetInputPortUnit(rts, 0, 0);
        ssSetInputPortUnit(rts, 1, 0);
        _ssSetPortInfo2ForInputCoSimAttribute(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.inputPortCoSimAttribute[0]);
        ssSetInputPortIsContinuousQuantity(rts, 0, 0);
        ssSetInputPortIsContinuousQuantity(rts, 1, 0);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0, &SG__MDL_DMA_B.src_gain_j);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidthAsInt(rts, 0, 1);
        }

        /* port 1 */
        {
          ssSetInputPortRequiredContiguous(rts, 1, 1);
          ssSetInputPortSignal(rts, 1, &SG__MDL_DMA_B.src_gain_j);
          _ssSetInputPortNumDimensions(rts, 1, 1);
          ssSetInputPortWidthAsInt(rts, 1, 1);
        }
      }

      /* path info */
      ssSetModelName(rts, "ao_2");
      ssSetPath(rts, "SG__MDL_DMA/ao_2");
      ssSetRTModel(rts,SG__MDL_DMA_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.params;
        ssSetSFcnParamsCount(rts, 13);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__MDL_DMA_cal->ao_2_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__MDL_DMA_cal->ao_2_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__MDL_DMA_cal->ao_2_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__MDL_DMA_cal->ao_2_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__MDL_DMA_cal->ao_2_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__MDL_DMA_cal->ao_2_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__MDL_DMA_cal->ao_2_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__MDL_DMA_cal->ao_2_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__MDL_DMA_cal->ao_2_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__MDL_DMA_cal->ao_2_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__MDL_DMA_cal->ao_2_P11_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)SG__MDL_DMA_cal->ao_2_P12_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)SG__MDL_DMA_cal->ao_2_P13_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &SG__MDL_DMA_DW.ao_2_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn1.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 1);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 0, 5);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__MDL_DMA_DW.ao_2_PWORK[0]);
      }

      /* registration */
      sg_IO132_IO133_da_s_v2(rts);
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
      _ssSetInputPortConnected(rts, 1, 1);

      /* Update the BufferDstPort flags for each input port */
      ssSetInputPortBufferDstPort(rts, 0, -1);
      ssSetInputPortBufferDstPort(rts, 1, -1);
    }

    /* Level2 S-Function Block: SG__MDL_DMA/<Root>/ai_135 (sg_IO132_IO133_ad_s_v2) */
    {
      SimStruct *rts = SG__MDL_DMA_M->childSfunctions[2];

      /* timing info */
      time_T *sfcnPeriod = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.sfcnPeriod;
      time_T *sfcnOffset = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.sfcnOffset;
      int_T *sfcnTsMap = SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__MDL_DMA_M->NonInlinedSFcns.blkInfo2[2]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__MDL_DMA_M->NonInlinedSFcns.inputOutputPortInfo2[2]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__MDL_DMA_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods2[2]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods3[2]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__MDL_DMA_M->NonInlinedSFcns.methods4[2]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__MDL_DMA_M->NonInlinedSFcns.statesInfo2[2]);
        ssSetPeriodicStatesInfo(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.periodicStatesInfo[2]);
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.outputPortInfo[0]);
        ssSetPortInfoForOutputs(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 2);
        _ssSetPortInfo2ForOutputUnits(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.outputPortUnits[0]);
        ssSetOutputPortUnit(rts, 0, 0);
        ssSetOutputPortUnit(rts, 1, 0);
        _ssSetPortInfo2ForOutputCoSimAttribute(rts,
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.outputPortCoSimAttribute[0]);
        ssSetOutputPortIsContinuousQuantity(rts, 0, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 1, 0);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidthAsInt(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((real_T *) &SG__MDL_DMA_B.p11));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidthAsInt(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((real_T *) &SG__MDL_DMA_B.ai_135_o2));
        }
      }

      /* path info */
      ssSetModelName(rts, "ai_135");
      ssSetPath(rts, "SG__MDL_DMA/ai_135");
      ssSetRTModel(rts,SG__MDL_DMA_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.params;
        ssSetSFcnParamsCount(rts, 11);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__MDL_DMA_cal->ai_135_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__MDL_DMA_cal->ai_135_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__MDL_DMA_cal->ai_135_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__MDL_DMA_cal->ai_135_P4_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__MDL_DMA_cal->ai_135_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__MDL_DMA_cal->ai_135_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__MDL_DMA_cal->ai_135_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__MDL_DMA_cal->ai_135_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__MDL_DMA_cal->ai_135_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__MDL_DMA_cal->ai_135_P10_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__MDL_DMA_cal->ai_135_P11_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &SG__MDL_DMA_DW.ai_135_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__MDL_DMA_M->NonInlinedSFcns.Sfcn2.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 1);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 0, 4);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__MDL_DMA_DW.ai_135_PWORK[0]);
      }

      /* registration */
      sg_IO132_IO133_ad_s_v2(rts);
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
      _ssSetOutputPortConnected(rts, 1, 1);
      _ssSetOutputPortBeingMerged(rts, 0, 0);
      _ssSetOutputPortBeingMerged(rts, 1, 0);

      /* Update the BufferDstPort flags for each input port */
    }
  }

  /* Start for S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/setup_135' */
  /* Level2 S-Function Block: '<Root>/setup_135' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[0];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO132_IO133_da_s_v2): '<Root>/ao_2' */
  /* Level2 S-Function Block: '<Root>/ao_2' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[1];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO132_IO133_ad_s_v2): '<Root>/ai_135' */
  /* Level2 S-Function Block: '<Root>/ai_135' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[2];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* SystemInitialize for Enabled SubSystem: '<Root>/source' */
  /* InitializeConditions for UnitDelay: '<S2>/Output' */
  SG__MDL_DMA_DW.Output_DSTATE = SG__MDL_DMA_cal->Output_InitialCondition;

  /* SystemInitialize for Gain: '<S1>/src_gain' incorporates:
   *  Outport: '<S1>/signal'
   */
  SG__MDL_DMA_B.src_gain_j = SG__MDL_DMA_cal->signal_Y0;

  /* End of SystemInitialize for SubSystem: '<Root>/source' */
  SG__MDL_DMA_DCBlocker_Init(&SG__MDL_DMA_DW.DCBlocker);
  SG__MDL_DMA_DCBlocker_Init(&SG__MDL_DMA_DW.DCBlocker1);
}

/* Model terminate function */
void SG__MDL_DMA_terminate(void)
{
  /* Terminate for S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/setup_135' */
  /* Level2 S-Function Block: '<Root>/setup_135' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[0];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO132_IO133_da_s_v2): '<Root>/ao_2' */
  /* Level2 S-Function Block: '<Root>/ao_2' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[1];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO132_IO133_ad_s_v2): '<Root>/ai_135' */
  /* Level2 S-Function Block: '<Root>/ai_135' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__MDL_DMA_M->childSfunctions[2];
    sfcnTerminate(rts);
  }

  SG__MDL_DMA_DCBlocker_Term(&SG__MDL_DMA_DW.DCBlocker);
  SG__MDL_DMA_DCBlocker_Term(&SG__MDL_DMA_DW.DCBlocker1);
}
