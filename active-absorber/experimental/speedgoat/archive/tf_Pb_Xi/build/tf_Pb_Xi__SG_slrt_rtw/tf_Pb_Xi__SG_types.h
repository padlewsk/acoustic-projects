/*
 * tf_Pb_Xi__SG_types.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "tf_Pb_Xi__SG".
 *
 * Model version              : 1.4
 * Simulink Coder version : 9.3 (R2020a) 18-Nov-2019
 * C source code generated on : Fri Oct  8 17:00:38 2021
 *
 * Target selection: slrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->32-bit x86 compatible
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_tf_Pb_Xi__SG_types_h_
#define RTW_HEADER_tf_Pb_Xi__SG_types_h_
#include "rtwtypes.h"
#include "builtin_typeid_types.h"
#include "multiword_types.h"
#include "zero_crossing_types.h"

/* Model Code Variants */
#ifndef struct_tag_eIbOOynHhUTHbVH0Wuu8zC
#define struct_tag_eIbOOynHhUTHbVH0Wuu8zC

struct tag_eIbOOynHhUTHbVH0Wuu8zC
{
  int32_T S0_isInitialized;
  real_T W0_ZERO_STATES[4];
  real_T W1_POLE_STATES[4];
  int32_T W2_PreviousNumChannels;
  real_T P0_ICRTP;
  real_T P1_RTP1COEFF[6];
  real_T P2_RTP2COEFF[4];
  real_T P3_RTP3COEFF[3];
  boolean_T P4_RTP_COEFF3_BOOL[3];
  real_T P5_IC2RTP;
};

#endif                                 /*struct_tag_eIbOOynHhUTHbVH0Wuu8zC*/

#ifndef typedef_b_dsp_BiquadFilter_0_tf_Pb_Xi_T
#define typedef_b_dsp_BiquadFilter_0_tf_Pb_Xi_T

typedef struct tag_eIbOOynHhUTHbVH0Wuu8zC b_dsp_BiquadFilter_0_tf_Pb_Xi_T;

#endif                               /*typedef_b_dsp_BiquadFilter_0_tf_Pb_Xi_T*/

#ifndef struct_tag_ZwrULdH0XZ9Gnkxj8kDjtG
#define struct_tag_ZwrULdH0XZ9Gnkxj8kDjtG

struct tag_ZwrULdH0XZ9Gnkxj8kDjtG
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  b_dsp_BiquadFilter_0_tf_Pb_Xi_T cSFunObject;
};

#endif                                 /*struct_tag_ZwrULdH0XZ9Gnkxj8kDjtG*/

#ifndef typedef_b_dspcodegen_BiquadFilter_tf__T
#define typedef_b_dspcodegen_BiquadFilter_tf__T

typedef struct tag_ZwrULdH0XZ9Gnkxj8kDjtG b_dspcodegen_BiquadFilter_tf__T;

#endif                               /*typedef_b_dspcodegen_BiquadFilter_tf__T*/

#ifndef struct_tag_PMfBDzoakfdM9QAdfx2o6D
#define struct_tag_PMfBDzoakfdM9QAdfx2o6D

struct tag_PMfBDzoakfdM9QAdfx2o6D
{
  uint32_T f1[8];
};

#endif                                 /*struct_tag_PMfBDzoakfdM9QAdfx2o6D*/

#ifndef typedef_cell_wrap_tf_Pb_Xi__SG_T
#define typedef_cell_wrap_tf_Pb_Xi__SG_T

typedef struct tag_PMfBDzoakfdM9QAdfx2o6D cell_wrap_tf_Pb_Xi__SG_T;

#endif                                 /*typedef_cell_wrap_tf_Pb_Xi__SG_T*/

#ifndef struct_tag_x2C50uUMryjhTStzgE1MzC
#define struct_tag_x2C50uUMryjhTStzgE1MzC

struct tag_x2C50uUMryjhTStzgE1MzC
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  cell_wrap_tf_Pb_Xi__SG_T inputVarSize;
  int32_T NumChannels;
  b_dspcodegen_BiquadFilter_tf__T *FilterObj;
};

#endif                                 /*struct_tag_x2C50uUMryjhTStzgE1MzC*/

#ifndef typedef_dsp_HighpassFilter_tf_Pb_Xi___T
#define typedef_dsp_HighpassFilter_tf_Pb_Xi___T

typedef struct tag_x2C50uUMryjhTStzgE1MzC dsp_HighpassFilter_tf_Pb_Xi___T;

#endif                               /*typedef_dsp_HighpassFilter_tf_Pb_Xi___T*/

#ifndef struct_tag_cpiFwYyFqHVNWpuN3XOeE
#define struct_tag_cpiFwYyFqHVNWpuN3XOeE

struct tag_cpiFwYyFqHVNWpuN3XOeE
{
  int32_T S0_isInitialized;
  real_T W0_ZERO_STATES[10];
  real_T W1_POLE_STATES[10];
  int32_T W2_PreviousNumChannels;
  real_T P0_ICRTP;
  real_T P1_RTP1COEFF[15];
  real_T P2_RTP2COEFF[10];
  real_T P3_RTP3COEFF[6];
  boolean_T P4_RTP_COEFF3_BOOL[6];
  real_T P5_IC2RTP;
};

#endif                                 /*struct_tag_cpiFwYyFqHVNWpuN3XOeE*/

#ifndef typedef_b_dsp_BiquadFilter_0_tf_Pb__n_T
#define typedef_b_dsp_BiquadFilter_0_tf_Pb__n_T

typedef struct tag_cpiFwYyFqHVNWpuN3XOeE b_dsp_BiquadFilter_0_tf_Pb__n_T;

#endif                               /*typedef_b_dsp_BiquadFilter_0_tf_Pb__n_T*/

#ifndef struct_tag_ybnhXIavtOt5ZJA5GrHLXC
#define struct_tag_ybnhXIavtOt5ZJA5GrHLXC

struct tag_ybnhXIavtOt5ZJA5GrHLXC
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  b_dsp_BiquadFilter_0_tf_Pb__n_T cSFunObject;
};

#endif                                 /*struct_tag_ybnhXIavtOt5ZJA5GrHLXC*/

#ifndef typedef_b_dspcodegen_BiquadFilter_t_n_T
#define typedef_b_dspcodegen_BiquadFilter_t_n_T

typedef struct tag_ybnhXIavtOt5ZJA5GrHLXC b_dspcodegen_BiquadFilter_t_n_T;

#endif                               /*typedef_b_dspcodegen_BiquadFilter_t_n_T*/

#ifndef struct_tag_8tbyVMIY3ZVCZCUEE6zaf
#define struct_tag_8tbyVMIY3ZVCZCUEE6zaf

struct tag_8tbyVMIY3ZVCZCUEE6zaf
{
  boolean_T matlabCodegenIsDeleted;
  int32_T isInitialized;
  boolean_T isSetupComplete;
  cell_wrap_tf_Pb_Xi__SG_T inputVarSize;
  int32_T NumChannels;
  b_dspcodegen_BiquadFilter_t_n_T *FilterObj;
};

#endif                                 /*struct_tag_8tbyVMIY3ZVCZCUEE6zaf*/

#ifndef typedef_dsp_HighpassFilter_tf_Pb_Xi_n_T
#define typedef_dsp_HighpassFilter_tf_Pb_Xi_n_T

typedef struct tag_8tbyVMIY3ZVCZCUEE6zaf dsp_HighpassFilter_tf_Pb_Xi_n_T;

#endif                               /*typedef_dsp_HighpassFilter_tf_Pb_Xi_n_T*/

/* Parameters (default storage) */
typedef struct P_tf_Pb_Xi__SG_T_ P_tf_Pb_Xi__SG_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_tf_Pb_Xi__SG_T RT_MODEL_tf_Pb_Xi__SG_T;

#endif                                 /* RTW_HEADER_tf_Pb_Xi__SG_types_h_ */
