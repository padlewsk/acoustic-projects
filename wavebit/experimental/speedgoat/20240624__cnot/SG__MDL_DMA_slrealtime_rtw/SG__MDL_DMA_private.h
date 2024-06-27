/*
 * SG__MDL_DMA_private.h
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

#ifndef RTW_HEADER_SG__MDL_DMA_private_h_
#define RTW_HEADER_SG__MDL_DMA_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#include "SG__MDL_DMA.h"
#include "SG__MDL_DMA_types.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmSetTFinal
#define rtmSetTFinal(rtm, val)         ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmSetTPtr
#define rtmSetTPtr(rtm, val)           ((rtm)->Timing.t = (val))
#endif

extern void* slrtRegisterSignalToLoggingService(uintptr_t sigAddr);
extern "C" void sg_IO132_IO133_setup_s_v2(SimStruct *rts);
extern "C" void sg_IO132_IO133_da_s_v2(SimStruct *rts);
extern "C" void sg_IO132_IO133_ad_s_v2(SimStruct *rts);
extern void SG__MDL_DMA_DCBlocker_Init(DW_DCBlocker_SG__MDL_DMA_T *localDW);
extern void SG__MDL_DMA_DCBlocker(real_T rtu_0, B_DCBlocker_SG__MDL_DMA_T
  *localB, DW_DCBlocker_SG__MDL_DMA_T *localDW);
extern void SG__MDL_DMA_DCBlocker_Term(DW_DCBlocker_SG__MDL_DMA_T *localDW);

#endif                                 /* RTW_HEADER_SG__MDL_DMA_private_h_ */
