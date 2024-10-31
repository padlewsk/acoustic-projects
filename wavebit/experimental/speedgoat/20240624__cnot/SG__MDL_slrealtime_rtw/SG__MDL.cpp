/*
 * SG__MDL.cpp
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

#include "SG__MDL.h"
#include "rtwtypes.h"
#include "SG__MDL_types.h"
#include <cmath>
#include "SG__MDL_private.h"
#include <cstring>

extern "C"
{

#include "rt_nonfinite.h"

}

/* Exported block parameters */
real_T dtf_a[6] = { 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 } ;/* Variable: dtf_a
                                                     * Referenced by: '<Root>/Constant6'
                                                     */

real_T dtf_b[6] = { 0.5, 0.5, 0.5, 0.5, 0.5, 0.5 } ;/* Variable: dtf_b
                                                     * Referenced by: '<Root>/Constant'
                                                     */

real_T freq_0 = 602.0;                 /* Variable: freq_0
                                        * Referenced by: '<Root>/Constant5'
                                        */
real_T harm_corr[2] = { 1.0, 1.0 } ;   /* Variable: harm_corr
                                        * Referenced by: '<Root>/Constant8'
                                        */

real_T i2u = 100.0;                    /* Variable: i2u
                                        * Referenced by: '<S6>/Gain'
                                        */
real_T phi[2] = { 0.0, 0.0 } ;         /* Variable: phi
                                        * Referenced by: '<Root>/Constant4'
                                        */

real_T rho[2] = { 1.0, 1.0 } ;         /* Variable: rho
                                        * Referenced by: '<Root>/Constant1'
                                        */

real_T rho_corr[2] = { 1.0, 1.0 } ;    /* Variable: rho_corr
                                        * Referenced by: '<Root>/Constant7'
                                        */

real_T sens_p[2] = { 0.0, 0.0 } ;      /* Variable: sens_p
                                        * Referenced by: '<Root>/sens_p'
                                        */

real_T src_gain = 0.05;                /* Variable: src_gain
                                        * Referenced by: '<S6>/src_gain'
                                        */
real_T theta[2] = { 3.1415926535897931, 0.0 } ;/* Variable: theta
                                                * Referenced by: '<Root>/Constant3'
                                                */

real_T ts_ctr = 5.0E-5;                /* Variable: ts_ctr
                                        * Referenced by: '<S6>/Constant'
                                        */
uint32_T N_trig = 32U;                 /* Variable: N_trig
                                        * Referenced by: '<Root>/Constant2'
                                        */
boolean_T enable_source = false;       /* Variable: enable_source
                                        * Referenced by: '<Root>/enable_source'
                                        */
boolean_T rec = false;                 /* Variable: rec
                                        * Referenced by: '<Root>/rec'
                                        */

/* Block signals (default storage) */
B_SG__MDL_T SG__MDL_B;

/* Block states (default storage) */
DW_SG__MDL_T SG__MDL_DW;

/* Real-time model */
RT_MODEL_SG__MDL_T SG__MDL_M_ = RT_MODEL_SG__MDL_T();
RT_MODEL_SG__MDL_T *const SG__MDL_M = &SG__MDL_M_;

/* Model step function */
void SG__MDL_step(void)
{
  /* local scratch DWork variables */
  int32_T ForEach_itr;
  int32_T ForEach_itr_j;
  b_dsp_BiquadFilter_0_SG__MDL_T *obj_0;
  b_dspcodegen_BiquadFilter_SG__T *obj;
  real_T rtb_TmpSignalConversionAtForEac[2];
  real_T DiscreteTransferFcn_tmp;
  real_T b_im;
  real_T r;
  real_T t;
  uint32_T rtb_Switch_reset;

  /* Reset subsysRan breadcrumbs */
  srClearBC(SG__MDL_DW.EnabledSubsystem_SubsysRanBC);

  /* Reset subsysRan breadcrumbs */
  srClearBC(SG__MDL_DW.Subsystem_SubsysRanBC);

  /* S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/setup_135' */

  /* Level2 S-Function Block: '<Root>/setup_135' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[0];
    sfcnOutputs(rts,0);
  }

  /* S-Function (sg_IO132_IO133_ad_s_v2): '<Root>/ai_135' */

  /* Level2 S-Function Block: '<Root>/ai_135' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[1];
    sfcnOutputs(rts,0);
  }

  /* SignalConversion generated from: '<Root>/For Each Subsystem' */
  rtb_TmpSignalConversionAtForEac[0] = SG__MDL_B.ai_135_o1;
  rtb_TmpSignalConversionAtForEac[1] = SG__MDL_B.ai_135_o2;

  /* Outputs for Iterator SubSystem: '<Root>/For Each Subsystem' incorporates:
   *  ForEach: '<S2>/For Each'
   */
  for (ForEach_itr_j = 0; ForEach_itr_j < 2; ForEach_itr_j++) {
    /* Product: '<S2>/Product' incorporates:
     *  Constant: '<Root>/sens_p'
     *  ForEachSliceSelector generated from: '<S2>/In1'
     *  ForEachSliceSelector generated from: '<S2>/sens_p'
     */
    DiscreteTransferFcn_tmp = rtb_TmpSignalConversionAtForEac[ForEach_itr_j] *
      sens_p[ForEach_itr_j];

    /* MATLABSystem: '<S2>/DC Blocker1' */
    obj = &SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter;
    if (SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isInitialized != 1) {
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isInitialized = 1;
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isSetupComplete = true;

      /* System object Initialization function: dsp.BiquadFilter */
      obj->cSFunObject.W0_FILT_STATES[0] = obj->cSFunObject.P0_ICRTP;
      obj->cSFunObject.W0_FILT_STATES[1] = obj->cSFunObject.P0_ICRTP;
      obj->cSFunObject.W0_FILT_STATES[2] = obj->cSFunObject.P0_ICRTP;
      obj->cSFunObject.W0_FILT_STATES[3] = obj->cSFunObject.P0_ICRTP;
    }

    obj_0 = &SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.cSFunObject;

    /* System object Outputs function: dsp.BiquadFilter */
    b_im = obj_0->W0_FILT_STATES[0];
    t = obj_0->P1_RTP1COEFF[0] * DiscreteTransferFcn_tmp + b_im;
    b_im = obj_0->W0_FILT_STATES[1];
    b_im += obj_0->P1_RTP1COEFF[1] * DiscreteTransferFcn_tmp;
    b_im -= obj_0->P2_RTP2COEFF[0] * t;
    obj_0->W0_FILT_STATES[0] = b_im;
    b_im = obj_0->P1_RTP1COEFF[2] * DiscreteTransferFcn_tmp;
    b_im -= obj_0->P2_RTP2COEFF[1] * t;
    obj_0->W0_FILT_STATES[1] = b_im;
    b_im = obj_0->W0_FILT_STATES[2];
    r = obj_0->P1_RTP1COEFF[3] * t + b_im;
    b_im = obj_0->W0_FILT_STATES[3];
    b_im += obj_0->P1_RTP1COEFF[4] * t;
    b_im -= obj_0->P2_RTP2COEFF[2] * r;
    obj_0->W0_FILT_STATES[2] = b_im;
    b_im = obj_0->P1_RTP1COEFF[5] * t;
    b_im -= obj_0->P2_RTP2COEFF[3] * r;
    obj_0->W0_FILT_STATES[3] = b_im;

    /* ForEachSliceAssignment generated from: '<S2>/p' incorporates:
     *  MATLABSystem: '<S2>/DC Blocker1'
     */
    SG__MDL_B.ImpAsg_InsertedFor_p_at_inport_[ForEach_itr_j] =
      DiscreteTransferFcn_tmp - r;
  }

  /* End of Outputs for SubSystem: '<Root>/For Each Subsystem' */

  /* Outputs for Atomic SubSystem: '<S13>/Unit Delay Enabled Resettable' */
  /* Delay: '<S20>/Enabled Resettable Delay' */
  SG__MDL_B.acq = SG__MDL_DW.EnabledResettableDelay_DSTATE;

  /* End of Outputs for SubSystem: '<S13>/Unit Delay Enabled Resettable' */

  /* Outputs for Enabled SubSystem: '<Root>/Enabled Subsystem' incorporates:
   *  EnablePort: '<S1>/Enable'
   */
  if (SG__MDL_B.acq) {
    /* ToAsyncQueueBlock generated from: '<S5>/In1' */
    slrtLogSignal(SG__MDL_DW.TAQSigLogging_InsertedFor_In1_a.SLRTSigHandles[0],
                  SG__MDL_M->Timing.t[0]);
    slrtLogSignal(SG__MDL_DW.TAQSigLogging_InsertedFor_In1_a.SLRTSigHandles[1],
                  SG__MDL_M->Timing.t[0]);
    srUpdateBC(SG__MDL_DW.EnabledSubsystem_SubsysRanBC);
  }

  /* End of Outputs for SubSystem: '<Root>/Enabled Subsystem' */

  /* Outputs for Enabled SubSystem: '<Root>/Subsystem' incorporates:
   *  EnablePort: '<S3>/Enable'
   */
  /* Constant: '<Root>/enable_source' */
  if (enable_source) {
    /* Outputs for Iterator SubSystem: '<S3>/For Each Subsystem1' incorporates:
     *  ForEach: '<S6>/For Each'
     */
    for (ForEach_itr = 0; ForEach_itr < 2; ForEach_itr++) {
      real_T b_b_im;
      real_T b_b_re;
      real_T rtb_ComplextoRealImag;

      /* DiscreteTransferFcn: '<S6>/Discrete Transfer Fcn' incorporates:
       *  Constant: '<Root>/Constant6'
       *  ForEachSliceAssignment generated from: '<S2>/p'
       *  ForEachSliceSelector generated from: '<S6>/dft_a'
       *  ForEachSliceSelector generated from: '<S6>/p'
       */
      DiscreteTransferFcn_tmp =
        (SG__MDL_B.ImpAsg_InsertedFor_p_at_inport_[ForEach_itr] -
         dtf_a[ForEach_itr + 2] * SG__MDL_DW.CoreSubsys_p[ForEach_itr].
         DiscreteTransferFcn_states[0]) - dtf_a[ForEach_itr + 4] *
        SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[1];

      /* Gain: '<S6>/Gain' incorporates:
       *  Constant: '<Root>/Constant'
       *  DiscreteTransferFcn: '<S6>/Discrete Transfer Fcn'
       *  ForEachSliceSelector generated from: '<S6>/dft_b'
       */
      SG__MDL_B.CoreSubsys_p[ForEach_itr].Gain = ((dtf_b[ForEach_itr + 2] *
        SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[0] +
        dtf_b[ForEach_itr] * DiscreteTransferFcn_tmp) + dtf_b[ForEach_itr + 4] *
        SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[1]) *
        i2u;

      /* MATLAB Function: '<S6>/MATLAB Function' incorporates:
       *  Constant: '<Root>/Constant4'
       *  Constant: '<Root>/Constant5'
       *  Constant: '<S6>/Constant'
       *  ForEachSliceSelector generated from: '<S6>/phi'
       *  UnitDelay: '<S8>/Output'
       */
      rtb_ComplextoRealImag = 6.2831853071795862 * freq_0;
      t = static_cast<real_T>(SG__MDL_DW.CoreSubsys_p[ForEach_itr].Output_DSTATE)
        * ts_ctr;
      b_im = t * -rtb_ComplextoRealImag;
      if (b_im == 0.0) {
        b_im = std::exp(rtb_ComplextoRealImag * 0.0 * t);
      } else {
        r = std::exp(rtb_ComplextoRealImag * 0.0 * t / 2.0);
        b_im = r * std::cos(b_im) * r;
      }

      b_b_im = phi[ForEach_itr];
      if (b_b_im == 0.0) {
        b_b_re = std::exp(phi[ForEach_itr] * 0.0);
        b_b_im = 0.0;
      } else {
        r = std::exp(phi[ForEach_itr] * 0.0 / 2.0);
        b_b_re = r * std::cos(b_b_im) * r;
        b_b_im = r * std::sin(b_b_im) * r;
      }

      r = -(2.0 * rtb_ComplextoRealImag) * t;
      if (r == 0.0) {
        t = std::exp(2.0 * rtb_ComplextoRealImag * 0.0 * t);
        r = 0.0;
      } else {
        rtb_ComplextoRealImag = std::exp(2.0 * rtb_ComplextoRealImag * 0.0 * t /
          2.0);
        t = rtb_ComplextoRealImag * std::cos(r) * rtb_ComplextoRealImag;
        r = rtb_ComplextoRealImag * std::sin(r) * rtb_ComplextoRealImag;
      }

      /* Product: '<S6>/Product1' incorporates:
       *  Gain: '<S6>/cntr_gain'
       *  UnitDelay: '<S8>/Output'
       */
      rtb_ComplextoRealImag = 0.00066666666666666664 * static_cast<real_T>
        (SG__MDL_DW.CoreSubsys_p[ForEach_itr].Output_DSTATE);

      /* Update for DiscreteTransferFcn: '<S6>/Discrete Transfer Fcn' */
      SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[1] =
        SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[0];
      SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[0] =
        DiscreteTransferFcn_tmp;

      /* Update for UnitDelay: '<S8>/Output' incorporates:
       *  Constant: '<S9>/FixPt Constant'
       *  Sum: '<S9>/FixPt Sum1'
       */
      SG__MDL_DW.CoreSubsys_p[ForEach_itr].Output_DSTATE++;

      /* Product: '<S6>/Product1' incorporates:
       *  Saturate: '<S6>/Saturation'
       */
      if (rtb_ComplextoRealImag > 1.0) {
        rtb_ComplextoRealImag = 1.0;
      }

      /* MATLAB Function: '<S6>/MATLAB Function' incorporates:
       *  Constant: '<Root>/Constant3'
       *  Constant: '<Root>/Constant8'
       *  ForEachSliceSelector generated from: '<S6>/harm_corr'
       *  ForEachSliceSelector generated from: '<S6>/theta'
       */
      DiscreteTransferFcn_tmp = std::sin(theta[ForEach_itr] / 2.0) *
        harm_corr[ForEach_itr];

      /* ForEachSliceAssignment generated from: '<S6>/signal' incorporates:
       *  Constant: '<Root>/Constant1'
       *  Constant: '<Root>/Constant3'
       *  Constant: '<Root>/Constant7'
       *  ForEachSliceSelector generated from: '<S6>/rho'
       *  ForEachSliceSelector generated from: '<S6>/rho_corr'
       *  ForEachSliceSelector generated from: '<S6>/theta'
       *  Gain: '<S6>/src_gain'
       *  MATLAB Function: '<S6>/MATLAB Function'
       *  Product: '<S6>/Product1'
       *  Saturate: '<S6>/Saturation'
       *  Sum: '<S6>/Sum1'
       */
      SG__MDL_B.ImpAsg_InsertedFor_signal_at_in[ForEach_itr] =
        ((DiscreteTransferFcn_tmp * b_b_re * t - DiscreteTransferFcn_tmp *
          b_b_im * r) + std::cos(theta[ForEach_itr] / 2.0) * b_im) *
        rho[ForEach_itr] * rho_corr[ForEach_itr] * rtb_ComplextoRealImag *
        src_gain + SG__MDL_B.CoreSubsys_p[ForEach_itr].Gain;
    }

    /* End of Outputs for SubSystem: '<S3>/For Each Subsystem1' */
    srUpdateBC(SG__MDL_DW.Subsystem_SubsysRanBC);
  }

  /* End of Constant: '<Root>/enable_source' */
  /* End of Outputs for SubSystem: '<Root>/Subsystem' */
  /* S-Function (sg_IO132_IO133_da_s_v2): '<Root>/ao_2' */

  /* Level2 S-Function Block: '<Root>/ao_2' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[2];
    sfcnOutputs(rts,0);
  }

  /* Update for Atomic SubSystem: '<S13>/Unit Delay Enabled Resettable' */
  /* Switch: '<S12>/Switch_reset' incorporates:
   *  Constant: '<Root>/Constant2'
   *  Constant: '<Root>/rec'
   *  Constant: '<S12>/Init_value'
   *  Delay: '<S20>/Enabled Resettable Delay'
   *  RelationalOperator: '<S11>/FixPt Relational Operator'
   *  RelationalOperator: '<S14>/Compare'
   *  RelationalOperator: '<S4>/Relational Operator'
   *  Switch: '<S12>/Switch_enb'
   *  UnitDelay: '<S11>/Delay Input1'
   *  UnitDelay: '<S12>/Count_reg'
   */
  if (N_trig < SG__MDL_DW.Count_reg_DSTATE) {
    rtb_Switch_reset = 1U;
    SG__MDL_DW.EnabledResettableDelay_DSTATE = false;
  } else {
    if (SG__MDL_B.acq) {
      /* Switch: '<S15>/Switch_wrap' incorporates:
       *  Constant: '<S12>/Step_value'
       *  Constant: '<S15>/Mod_value'
       *  Sum: '<S15>/Add'
       *  Sum: '<S15>/Wrap'
       *  Switch: '<S12>/Switch_dir'
       *  Switch: '<S12>/Switch_enb'
       */
      if (SG__MDL_DW.Count_reg_DSTATE + 1UL > 4294967295UL) {
        rtb_Switch_reset = static_cast<uint32_T>(SG__MDL_DW.Count_reg_DSTATE -
          4294967295L);
      } else {
        rtb_Switch_reset = static_cast<uint32_T>(SG__MDL_DW.Count_reg_DSTATE +
          1UL);
      }

      /* End of Switch: '<S15>/Switch_wrap' */
    } else {
      /* Switch: '<S12>/Switch_enb' */
      rtb_Switch_reset = SG__MDL_DW.Count_reg_DSTATE;
    }

    SG__MDL_DW.EnabledResettableDelay_DSTATE = ((static_cast<int32_T>(rec) >
      static_cast<int32_T>(SG__MDL_DW.DelayInput1_DSTATE)) ||
      SG__MDL_DW.EnabledResettableDelay_DSTATE);
  }

  /* End of Switch: '<S12>/Switch_reset' */
  /* End of Update for SubSystem: '<S13>/Unit Delay Enabled Resettable' */

  /* Update for UnitDelay: '<S12>/Count_reg' */
  SG__MDL_DW.Count_reg_DSTATE = rtb_Switch_reset;

  /* Update for UnitDelay: '<S11>/Delay Input1' incorporates:
   *  Constant: '<Root>/rec'
   *  RelationalOperator: '<S14>/Compare'
   */
  SG__MDL_DW.DelayInput1_DSTATE = rec;

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++SG__MDL_M->Timing.clockTick0)) {
    ++SG__MDL_M->Timing.clockTickH0;
  }

  SG__MDL_M->Timing.t[0] = SG__MDL_M->Timing.clockTick0 *
    SG__MDL_M->Timing.stepSize0 + SG__MDL_M->Timing.clockTickH0 *
    SG__MDL_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void SG__MDL_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));
  rtsiSetSolverName(&SG__MDL_M->solverInfo,"FixedStepDiscrete");
  SG__MDL_M->solverInfoPtr = (&SG__MDL_M->solverInfo);

  /* Initialize timing info */
  {
    int_T *mdlTsMap = SG__MDL_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "SG__MDL_M points to
       static memory which is guaranteed to be non-NULL" */
    SG__MDL_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    SG__MDL_M->Timing.sampleTimes = (&SG__MDL_M->Timing.sampleTimesArray[0]);
    SG__MDL_M->Timing.offsetTimes = (&SG__MDL_M->Timing.offsetTimesArray[0]);

    /* task periods */
    SG__MDL_M->Timing.sampleTimes[0] = (5.0E-5);

    /* task offsets */
    SG__MDL_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(SG__MDL_M, &SG__MDL_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = SG__MDL_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    SG__MDL_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(SG__MDL_M, -1);
  SG__MDL_M->Timing.stepSize0 = 5.0E-5;
  SG__MDL_M->solverInfoPtr = (&SG__MDL_M->solverInfo);
  SG__MDL_M->Timing.stepSize = (5.0E-5);
  rtsiSetFixedStepSize(&SG__MDL_M->solverInfo, 5.0E-5);
  rtsiSetSolverMode(&SG__MDL_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  (void) std::memset((static_cast<void *>(&SG__MDL_B)), 0,
                     sizeof(B_SG__MDL_T));

  /* states (dwork) */
  (void) std::memset(static_cast<void *>(&SG__MDL_DW), 0,
                     sizeof(DW_SG__MDL_T));

  /* child S-Function registration */
  {
    RTWSfcnInfo *sfcnInfo = &SG__MDL_M->NonInlinedSFcns.sfcnInfo;
    SG__MDL_M->sfcnInfo = (sfcnInfo);
    rtssSetErrorStatusPtr(sfcnInfo, (&rtmGetErrorStatus(SG__MDL_M)));
    SG__MDL_M->Sizes.numSampTimes = (1);
    rtssSetNumRootSampTimesPtr(sfcnInfo, &SG__MDL_M->Sizes.numSampTimes);
    SG__MDL_M->NonInlinedSFcns.taskTimePtrs[0] = &(rtmGetTPtr(SG__MDL_M)[0]);
    rtssSetTPtrPtr(sfcnInfo,SG__MDL_M->NonInlinedSFcns.taskTimePtrs);
    rtssSetTStartPtr(sfcnInfo, &rtmGetTStart(SG__MDL_M));
    rtssSetTFinalPtr(sfcnInfo, &rtmGetTFinal(SG__MDL_M));
    rtssSetTimeOfLastOutputPtr(sfcnInfo, &rtmGetTimeOfLastOutput(SG__MDL_M));
    rtssSetStepSizePtr(sfcnInfo, &SG__MDL_M->Timing.stepSize);
    rtssSetStopRequestedPtr(sfcnInfo, &rtmGetStopRequested(SG__MDL_M));
    rtssSetDerivCacheNeedsResetPtr(sfcnInfo, &SG__MDL_M->derivCacheNeedsReset);
    rtssSetZCCacheNeedsResetPtr(sfcnInfo, &SG__MDL_M->zCCacheNeedsReset);
    rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo,
      &SG__MDL_M->CTOutputIncnstWithState);
    rtssSetSampleHitsPtr(sfcnInfo, &SG__MDL_M->Timing.sampleHits);
    rtssSetPerTaskSampleHitsPtr(sfcnInfo, &SG__MDL_M->Timing.perTaskSampleHits);
    rtssSetSimModePtr(sfcnInfo, &SG__MDL_M->simMode);
    rtssSetSolverInfoPtr(sfcnInfo, &SG__MDL_M->solverInfoPtr);
  }

  SG__MDL_M->Sizes.numSFcns = (3);

  /* register each child */
  {
    (void) std::memset(static_cast<void *>
                       (&SG__MDL_M->NonInlinedSFcns.childSFunctions[0]), 0,
                       3*sizeof(SimStruct));
    SG__MDL_M->childSfunctions = (&SG__MDL_M->
      NonInlinedSFcns.childSFunctionPtrs[0]);
    SG__MDL_M->childSfunctions[0] = (&SG__MDL_M->
      NonInlinedSFcns.childSFunctions[0]);
    SG__MDL_M->childSfunctions[1] = (&SG__MDL_M->
      NonInlinedSFcns.childSFunctions[1]);
    SG__MDL_M->childSfunctions[2] = (&SG__MDL_M->
      NonInlinedSFcns.childSFunctions[2]);

    /* Level2 S-Function Block: SG__MDL/<Root>/setup_135 (sg_IO132_IO133_setup_s_v2) */
    {
      SimStruct *rts = SG__MDL_M->childSfunctions[0];

      /* timing info */
      time_T *sfcnPeriod = SG__MDL_M->NonInlinedSFcns.Sfcn0.sfcnPeriod;
      time_T *sfcnOffset = SG__MDL_M->NonInlinedSFcns.Sfcn0.sfcnOffset;
      int_T *sfcnTsMap = SG__MDL_M->NonInlinedSFcns.Sfcn0.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__MDL_M->NonInlinedSFcns.blkInfo2[0]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__MDL_M->NonInlinedSFcns.inputOutputPortInfo2[0]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__MDL_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__MDL_M->NonInlinedSFcns.methods2[0]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__MDL_M->NonInlinedSFcns.methods3[0]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__MDL_M->NonInlinedSFcns.methods4[0]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__MDL_M->NonInlinedSFcns.statesInfo2[0]);
        ssSetPeriodicStatesInfo(rts,
          &SG__MDL_M->NonInlinedSFcns.periodicStatesInfo[0]);
      }

      /* path info */
      ssSetModelName(rts, "setup_135");
      ssSetPath(rts, "SG__MDL/setup_135");
      ssSetRTModel(rts,SG__MDL_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__MDL_M->NonInlinedSFcns.Sfcn0.params;
        ssSetSFcnParamsCount(rts, 35);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__MDL_ConstP.setup_135_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__MDL_ConstP.setup_135_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__MDL_ConstP.setup_135_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 13, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 14, (mxArray*)SG__MDL_ConstP.setup_135_P5_Size);
        ssSetSFcnParam(rts, 15, (mxArray*)SG__MDL_ConstP.setup_135_P16_Size);
        ssSetSFcnParam(rts, 16, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 17, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 18, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 19, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 20, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 21, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 22, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 23, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 24, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 25, (mxArray*)SG__MDL_ConstP.setup_135_P26_Size);
        ssSetSFcnParam(rts, 26, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 27, (mxArray*)SG__MDL_ConstP.setup_135_P26_Size);
        ssSetSFcnParam(rts, 28, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 29, (mxArray*)SG__MDL_ConstP.setup_135_P30_Size);
        ssSetSFcnParam(rts, 30, (mxArray*)SG__MDL_ConstInitP.setup_135_P31_Size);
        ssSetSFcnParam(rts, 31, (mxArray*)SG__MDL_ConstInitP.setup_135_P31_Size);
        ssSetSFcnParam(rts, 32, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 33, (mxArray*)SG__MDL_ConstP.setup_135_P34_Size);
        ssSetSFcnParam(rts, 34, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
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

    /* Level2 S-Function Block: SG__MDL/<Root>/ai_135 (sg_IO132_IO133_ad_s_v2) */
    {
      SimStruct *rts = SG__MDL_M->childSfunctions[1];

      /* timing info */
      time_T *sfcnPeriod = SG__MDL_M->NonInlinedSFcns.Sfcn1.sfcnPeriod;
      time_T *sfcnOffset = SG__MDL_M->NonInlinedSFcns.Sfcn1.sfcnOffset;
      int_T *sfcnTsMap = SG__MDL_M->NonInlinedSFcns.Sfcn1.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__MDL_M->NonInlinedSFcns.blkInfo2[1]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__MDL_M->NonInlinedSFcns.inputOutputPortInfo2[1]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__MDL_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__MDL_M->NonInlinedSFcns.methods2[1]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__MDL_M->NonInlinedSFcns.methods3[1]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__MDL_M->NonInlinedSFcns.methods4[1]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__MDL_M->NonInlinedSFcns.statesInfo2[1]);
        ssSetPeriodicStatesInfo(rts,
          &SG__MDL_M->NonInlinedSFcns.periodicStatesInfo[1]);
      }

      /* outputs */
      {
        ssSetPortInfoForOutputs(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.outputPortInfo[0]);
        ssSetPortInfoForOutputs(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.outputPortInfo[0]);
        _ssSetNumOutputPorts(rts, 2);
        _ssSetPortInfo2ForOutputUnits(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.outputPortUnits[0]);
        ssSetOutputPortUnit(rts, 0, 0);
        ssSetOutputPortUnit(rts, 1, 0);
        _ssSetPortInfo2ForOutputCoSimAttribute(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.outputPortCoSimAttribute[0]);
        ssSetOutputPortIsContinuousQuantity(rts, 0, 0);
        ssSetOutputPortIsContinuousQuantity(rts, 1, 0);

        /* port 0 */
        {
          _ssSetOutputPortNumDimensions(rts, 0, 1);
          ssSetOutputPortWidthAsInt(rts, 0, 1);
          ssSetOutputPortSignal(rts, 0, ((real_T *) &SG__MDL_B.ai_135_o1));
        }

        /* port 1 */
        {
          _ssSetOutputPortNumDimensions(rts, 1, 1);
          ssSetOutputPortWidthAsInt(rts, 1, 1);
          ssSetOutputPortSignal(rts, 1, ((real_T *) &SG__MDL_B.ai_135_o2));
        }
      }

      /* path info */
      ssSetModelName(rts, "ai_135");
      ssSetPath(rts, "SG__MDL/ai_135");
      ssSetRTModel(rts,SG__MDL_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.params;
        ssSetSFcnParamsCount(rts, 11);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__MDL_ConstP.setup_135_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__MDL_ConstP.setup_135_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__MDL_ConstP.setup_135_P3_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__MDL_ConstP.setup_135_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &SG__MDL_DW.ai_135_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__MDL_M->NonInlinedSFcns.Sfcn1.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 1);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 0, 4);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__MDL_DW.ai_135_PWORK[0]);
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

    /* Level2 S-Function Block: SG__MDL/<Root>/ao_2 (sg_IO132_IO133_da_s_v2) */
    {
      SimStruct *rts = SG__MDL_M->childSfunctions[2];

      /* timing info */
      time_T *sfcnPeriod = SG__MDL_M->NonInlinedSFcns.Sfcn2.sfcnPeriod;
      time_T *sfcnOffset = SG__MDL_M->NonInlinedSFcns.Sfcn2.sfcnOffset;
      int_T *sfcnTsMap = SG__MDL_M->NonInlinedSFcns.Sfcn2.sfcnTsMap;
      (void) std::memset(static_cast<void*>(sfcnPeriod), 0,
                         sizeof(time_T)*1);
      (void) std::memset(static_cast<void*>(sfcnOffset), 0,
                         sizeof(time_T)*1);
      ssSetSampleTimePtr(rts, &sfcnPeriod[0]);
      ssSetOffsetTimePtr(rts, &sfcnOffset[0]);
      ssSetSampleTimeTaskIDPtr(rts, sfcnTsMap);

      {
        ssSetBlkInfo2Ptr(rts, &SG__MDL_M->NonInlinedSFcns.blkInfo2[2]);
      }

      _ssSetBlkInfo2PortInfo2Ptr(rts,
        &SG__MDL_M->NonInlinedSFcns.inputOutputPortInfo2[2]);

      /* Set up the mdlInfo pointer */
      ssSetRTWSfcnInfo(rts, SG__MDL_M->sfcnInfo);

      /* Allocate memory of model methods 2 */
      {
        ssSetModelMethods2(rts, &SG__MDL_M->NonInlinedSFcns.methods2[2]);
      }

      /* Allocate memory of model methods 3 */
      {
        ssSetModelMethods3(rts, &SG__MDL_M->NonInlinedSFcns.methods3[2]);
      }

      /* Allocate memory of model methods 4 */
      {
        ssSetModelMethods4(rts, &SG__MDL_M->NonInlinedSFcns.methods4[2]);
      }

      /* Allocate memory for states auxilliary information */
      {
        ssSetStatesInfo2(rts, &SG__MDL_M->NonInlinedSFcns.statesInfo2[2]);
        ssSetPeriodicStatesInfo(rts,
          &SG__MDL_M->NonInlinedSFcns.periodicStatesInfo[2]);
      }

      /* inputs */
      {
        _ssSetNumInputPorts(rts, 2);
        ssSetPortInfoForInputs(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.inputPortInfo[0]);
        ssSetPortInfoForInputs(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.inputPortInfo[0]);
        _ssSetPortInfo2ForInputUnits(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.inputPortUnits[0]);
        ssSetInputPortUnit(rts, 0, 0);
        ssSetInputPortUnit(rts, 1, 0);
        _ssSetPortInfo2ForInputCoSimAttribute(rts,
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.inputPortCoSimAttribute[0]);
        ssSetInputPortIsContinuousQuantity(rts, 0, 0);
        ssSetInputPortIsContinuousQuantity(rts, 1, 0);

        /* port 0 */
        {
          ssSetInputPortRequiredContiguous(rts, 0, 1);
          ssSetInputPortSignal(rts, 0,
                               &SG__MDL_B.ImpAsg_InsertedFor_signal_at_in[0]);
          _ssSetInputPortNumDimensions(rts, 0, 1);
          ssSetInputPortWidthAsInt(rts, 0, 1);
        }

        /* port 1 */
        {
          ssSetInputPortRequiredContiguous(rts, 1, 1);
          ssSetInputPortSignal(rts, 1,
                               &SG__MDL_B.ImpAsg_InsertedFor_signal_at_in[1]);
          _ssSetInputPortNumDimensions(rts, 1, 1);
          ssSetInputPortWidthAsInt(rts, 1, 1);
        }
      }

      /* path info */
      ssSetModelName(rts, "ao_2");
      ssSetPath(rts, "SG__MDL/ao_2");
      ssSetRTModel(rts,SG__MDL_M);
      ssSetParentSS(rts, (NULL));
      ssSetRootSS(rts, rts);
      ssSetVersion(rts, SIMSTRUCT_VERSION_LEVEL2);

      /* parameters */
      {
        mxArray **sfcnParams = (mxArray **)
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.params;
        ssSetSFcnParamsCount(rts, 13);
        ssSetSFcnParamsPtr(rts, &sfcnParams[0]);
        ssSetSFcnParam(rts, 0, (mxArray*)SG__MDL_ConstP.setup_135_P1_Size);
        ssSetSFcnParam(rts, 1, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 2, (mxArray*)SG__MDL_ConstP.setup_135_P3_Size);
        ssSetSFcnParam(rts, 3, (mxArray*)SG__MDL_ConstP.setup_135_P3_Size);
        ssSetSFcnParam(rts, 4, (mxArray*)SG__MDL_ConstP.setup_135_P5_Size);
        ssSetSFcnParam(rts, 5, (mxArray*)SG__MDL_ConstP.setup_135_P16_Size);
        ssSetSFcnParam(rts, 6, (mxArray*)SG__MDL_ConstP.ao_2_P7_Size);
        ssSetSFcnParam(rts, 7, (mxArray*)SG__MDL_ConstP.ao_2_P8_Size);
        ssSetSFcnParam(rts, 8, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 9, (mxArray*)SG__MDL_ConstP.setup_135_P9_Size);
        ssSetSFcnParam(rts, 10, (mxArray*)SG__MDL_ConstP.setup_135_P6_Size);
        ssSetSFcnParam(rts, 11, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
        ssSetSFcnParam(rts, 12, (mxArray*)SG__MDL_ConstP.setup_135_P2_Size);
      }

      /* work vectors */
      ssSetPWork(rts, (void **) &SG__MDL_DW.ao_2_PWORK[0]);

      {
        struct _ssDWorkRecord *dWorkRecord = (struct _ssDWorkRecord *)
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.dWork;
        struct _ssDWorkAuxRecord *dWorkAuxRecord = (struct _ssDWorkAuxRecord *)
          &SG__MDL_M->NonInlinedSFcns.Sfcn2.dWorkAux;
        ssSetSFcnDWork(rts, dWorkRecord);
        ssSetSFcnDWorkAux(rts, dWorkAuxRecord);
        ssSetNumDWorkAsInt(rts, 1);

        /* PWORK */
        ssSetDWorkWidthAsInt(rts, 0, 5);
        ssSetDWorkDataType(rts, 0,SS_POINTER);
        ssSetDWorkComplexSignal(rts, 0, 0);
        ssSetDWork(rts, 0, &SG__MDL_DW.ao_2_PWORK[0]);
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
  }

  /* Start for S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/setup_135' */
  /* Level2 S-Function Block: '<Root>/setup_135' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[0];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO132_IO133_ad_s_v2): '<Root>/ai_135' */
  /* Level2 S-Function Block: '<Root>/ai_135' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[1];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  /* Start for S-Function (sg_IO132_IO133_da_s_v2): '<Root>/ao_2' */
  /* Level2 S-Function Block: '<Root>/ao_2' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[2];
    sfcnStart(rts);
    if (ssGetErrorStatus(rts) != (NULL))
      return;
  }

  {
    /* local scratch DWork variables */
    int32_T ForEach_itr;
    int32_T ForEach_itr_j;
    b_dspcodegen_BiquadFilter_SG__T *obj;

    /* InitializeConditions for UnitDelay: '<S12>/Count_reg' */
    SG__MDL_DW.Count_reg_DSTATE = 1U;

    /* InitializeConditions for UnitDelay: '<S11>/Delay Input1' */
    SG__MDL_DW.DelayInput1_DSTATE = false;

    /* SystemInitialize for Iterator SubSystem: '<Root>/For Each Subsystem' */
    for (ForEach_itr_j = 0; ForEach_itr_j < 2; ForEach_itr_j++) {
      /* Start for MATLABSystem: '<S2>/DC Blocker1' */
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.matlabCodegenIsDeleted = false;
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].objisempty = true;
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.isInitialized = 1;
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pNumChannels = 1;
      obj = &SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter;
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isInitialized = 0;

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
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.matlabCodegenIsDeleted =
        false;
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.isSetupComplete = true;

      /* InitializeConditions for MATLABSystem: '<S2>/DC Blocker1' */
      obj = &SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter;
      if (SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isInitialized == 1) {
        /* System object Initialization function: dsp.BiquadFilter */
        obj->cSFunObject.W0_FILT_STATES[0] = obj->cSFunObject.P0_ICRTP;
        obj->cSFunObject.W0_FILT_STATES[1] = obj->cSFunObject.P0_ICRTP;
        obj->cSFunObject.W0_FILT_STATES[2] = obj->cSFunObject.P0_ICRTP;
        obj->cSFunObject.W0_FILT_STATES[3] = obj->cSFunObject.P0_ICRTP;
      }

      /* End of InitializeConditions for MATLABSystem: '<S2>/DC Blocker1' */
    }

    /* End of SystemInitialize for SubSystem: '<Root>/For Each Subsystem' */

    /* SystemInitialize for Atomic SubSystem: '<S13>/Unit Delay Enabled Resettable' */
    /* InitializeConditions for Delay: '<S20>/Enabled Resettable Delay' */
    SG__MDL_DW.EnabledResettableDelay_DSTATE = false;

    /* End of SystemInitialize for SubSystem: '<S13>/Unit Delay Enabled Resettable' */
    /* Start for ToAsyncQueueBlock generated from: '<S5>/In1' */
    SG__MDL_DW.TAQSigLogging_InsertedFor_In1_a.SLRTSigHandles[0] =
      slrtRegisterSignalToLoggingService(reinterpret_cast<uintptr_t>
      (&SG__MDL_B.ImpAsg_InsertedFor_p_at_inport_[0]));
    SG__MDL_DW.TAQSigLogging_InsertedFor_In1_a.SLRTSigHandles[1] =
      slrtRegisterSignalToLoggingService(reinterpret_cast<uintptr_t>
      (&SG__MDL_B.ImpAsg_InsertedFor_p_at_inport_[1]));

    /* SystemInitialize for Enabled SubSystem: '<Root>/Subsystem' */
    /* SystemInitialize for Iterator SubSystem: '<S3>/For Each Subsystem1' */
    for (ForEach_itr = 0; ForEach_itr < 2; ForEach_itr++) {
      /* SystemInitialize for Gain: '<S6>/Gain' */
      SG__MDL_B.CoreSubsys_p[ForEach_itr].Gain = 0.0;

      /* InitializeConditions for DiscreteTransferFcn: '<S6>/Discrete Transfer Fcn' */
      SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[0] = 0.0;
      SG__MDL_DW.CoreSubsys_p[ForEach_itr].DiscreteTransferFcn_states[1] = 0.0;

      /* InitializeConditions for UnitDelay: '<S8>/Output' */
      SG__MDL_DW.CoreSubsys_p[ForEach_itr].Output_DSTATE = 0U;
    }

    /* End of SystemInitialize for SubSystem: '<S3>/For Each Subsystem1' */

    /* SystemInitialize for ForEachSliceAssignment generated from: '<S6>/signal' incorporates:
     *  Outport: '<S3>/i_ctrl'
     */
    SG__MDL_B.ImpAsg_InsertedFor_signal_at_in[0] = 0.0;
    SG__MDL_B.ImpAsg_InsertedFor_signal_at_in[1] = 0.0;

    /* End of SystemInitialize for SubSystem: '<Root>/Subsystem' */
  }
}

/* Model terminate function */
void SG__MDL_terminate(void)
{
  /* local scratch DWork variables */
  int32_T ForEach_itr;
  int32_T ForEach_itr_j;
  b_dspcodegen_BiquadFilter_SG__T *obj;

  /* Terminate for S-Function (sg_IO132_IO133_setup_s_v2): '<Root>/setup_135' */
  /* Level2 S-Function Block: '<Root>/setup_135' (sg_IO132_IO133_setup_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[0];
    sfcnTerminate(rts);
  }

  /* Terminate for S-Function (sg_IO132_IO133_ad_s_v2): '<Root>/ai_135' */
  /* Level2 S-Function Block: '<Root>/ai_135' (sg_IO132_IO133_ad_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[1];
    sfcnTerminate(rts);
  }

  /* Terminate for Iterator SubSystem: '<Root>/For Each Subsystem' */
  for (ForEach_itr_j = 0; ForEach_itr_j < 2; ForEach_itr_j++) {
    /* Terminate for MATLABSystem: '<S2>/DC Blocker1' */
    if (!SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.matlabCodegenIsDeleted) {
      SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.matlabCodegenIsDeleted = true;
      if ((SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.isInitialized == 1) &&
          SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.isSetupComplete) {
        if (SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isInitialized == 1)
        {
          SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter.isInitialized = 2;
        }

        SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pNumChannels = -1;
      }
    }

    obj = &SG__MDL_DW.CoreSubsys[ForEach_itr_j].obj.pFilter;
    if (!obj->matlabCodegenIsDeleted) {
      obj->matlabCodegenIsDeleted = true;
      if (obj->isInitialized == 1) {
        obj->isInitialized = 2;
      }
    }

    /* End of Terminate for MATLABSystem: '<S2>/DC Blocker1' */
  }

  /* End of Terminate for SubSystem: '<Root>/For Each Subsystem' */
  /* Terminate for S-Function (sg_IO132_IO133_da_s_v2): '<Root>/ao_2' */
  /* Level2 S-Function Block: '<Root>/ao_2' (sg_IO132_IO133_da_s_v2) */
  {
    SimStruct *rts = SG__MDL_M->childSfunctions[2];
    sfcnTerminate(rts);
  }
}
