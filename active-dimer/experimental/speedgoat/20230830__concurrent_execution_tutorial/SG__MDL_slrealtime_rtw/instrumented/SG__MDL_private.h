/*
 * SG__MDL_private.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL".
 *
 * Model version              : 6.23
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Thu Aug 31 11:00:20 2023
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#ifndef RTW_HEADER_SG__MDL_private_h_
#define RTW_HEADER_SG__MDL_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#include "SG__MDL.h"
#include "SG__MDL_cal.h"
#include "SG__MDL_types.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmSetTPtr
#define rtmSetTPtr(rtm, val)           ((rtm)->Timing.t = (val))
#endif

extern void* slrtRegisterSignalToLoggingService(uintptr_t sigAddr);
extern void SG__MDL_Subsystem_Enable(DW_Subsystem_SG__MDL_T *localDW);
extern void SG__MDL_Subsystem(RT_MODEL_SG__MDL_T * const SG__MDL_M,
  B_Subsystem_SG__MDL_T *localB, DW_Subsystem_SG__MDL_T *localDW,
  SG__MDL_Subsystem_cal_type *SG__MDL_PageSwitching_arg);

#endif                                 /* RTW_HEADER_SG__MDL_private_h_ */
