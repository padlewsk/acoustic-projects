/*
 * SG__MDL_data.cpp
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL".
 *
 * Model version              : 6.522
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Wed Oct 30 18:12:17 2024
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#include "SG__MDL.h"

/* Constant parameters (default storage) */
const ConstP_SG__MDL_T SG__MDL_ConstP = {
  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Pooled Parameter (Expression: boardType)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  135.0,

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  1.0,

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  -1.0,

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 2.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 2.0 },

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 4.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Pooled Parameter (Expression: )
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by: '<Root>/setup_135'
   */
  2.0,

  /* Computed Parameter: setup_135_P9_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 32.0 },

  /* Expression: parAdcCorrectionValues
   * Referenced by: '<Root>/setup_135'
   */
  { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0, 0.0 },

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by:
   *   '<Root>/ai_135'
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  0.0,

  /* Pooled Parameter (Expression: )
   * Referenced by:
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 1.0, 16.0 },

  /* Pooled Parameter (Expression: parDacVoltageRange)
   * Referenced by:
   *   '<Root>/ao_2'
   *   '<Root>/setup_135'
   */
  { 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0,
    4.0 },

  /* Computed Parameter: setup_135_P19_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 16.0 },

  /* Expression: parDacCorrectionValues
   * Referenced by: '<Root>/setup_135'
   */
  { 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
    0.0 },

  /* Pooled Parameter (Expression: )
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Pooled Parameter (Mixed Expressions)
   * Referenced by: '<Root>/setup_135'
   */
  700.0,

  /* Computed Parameter: setup_135_P32_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parFrameTriggerDivider
   * Referenced by: '<Root>/setup_135'
   */
  10.0,

  /* Computed Parameter: setup_135_P36_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDioPullRefFront
   * Referenced by: '<Root>/setup_135'
   */
  3.0,

  /* Computed Parameter: ao_2_P7_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 2.0 },

  /* Expression: parDacInitValues
   * Referenced by: '<Root>/ao_2'
   */
  { 0.0, 0.0 },

  /* Computed Parameter: ao_2_P8_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 2.0 },

  /* Expression: parDacReset
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 }
};

/* Constant parameters with dynamic initialization (default storage) */
ConstInitP_SG__MDL_T SG__MDL_ConstInitP = {
  /* Pooled Parameter (Expression: )
   * Referenced by: '<Root>/setup_135'
   */
  { 0.0, 0.0 }
};
