/*
 * SG__MDL_types.h
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

#ifndef RTW_HEADER_SG__MDL_types_h_
#define RTW_HEADER_SG__MDL_types_h_
#include "rtwtypes.h"
#ifndef struct_b_dsp_BiquadFilter_0_SG__MDL_T
#define struct_b_dsp_BiquadFilter_0_SG__MDL_T

struct b_dsp_BiquadFilter_0_SG__MDL_T
{
  int32_T S0_isInitialized;
  real_T W0_FILT_STATES[4];
  int32_T W1_PreviousNumChannels;
  real_T P0_ICRTP;
  real_T P1_RTP1COEFF[6];
  real_T P2_RTP2COEFF[4];
  real_T P3_RTP3COEFF[3];
  boolean_T P4_RTP_COEFF3_BOOL[3];
}

;

#endif                               /* struct_b_dsp_BiquadFilter_0_SG__MDL_T */

#ifndef struct_b_dspcodegen_BiquadFilter_SG__T
#define struct_b_dspcodegen_BiquadFilter_SG__T

struct b_dspcodegen_BiquadFilter_SG__T
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  b_dsp_BiquadFilter_0_SG__MDL_T cSFunObject;
};

#endif                              /* struct_b_dspcodegen_BiquadFilter_SG__T */

#ifndef struct_cell_wrap_SG__MDL_T
#define struct_cell_wrap_SG__MDL_T

struct cell_wrap_SG__MDL_T
{
  uint32_T f1[8];
};

#endif                                 /* struct_cell_wrap_SG__MDL_T */

#ifndef struct_dsp_simulink_DCBlocker_SG__MD_T
#define struct_dsp_simulink_DCBlocker_SG__MD_T

struct dsp_simulink_DCBlocker_SG__MD_T
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  cell_wrap_SG__MDL_T inputVarSize;
  b_dspcodegen_BiquadFilter_SG__T pFilter;
  int32_T pNumChannels;
};

#endif                              /* struct_dsp_simulink_DCBlocker_SG__MD_T */

/* Forward declaration for rtModel */
typedef struct tag_RTM_SG__MDL_T RT_MODEL_SG__MDL_T;

#endif                                 /* RTW_HEADER_SG__MDL_types_h_ */
