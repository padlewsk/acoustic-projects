/*
 * SG__DMA_test_private.h
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

#ifndef RTW_HEADER_SG__DMA_test_private_h_
#define RTW_HEADER_SG__DMA_test_private_h_
#include "rtwtypes.h"
#include "multiword_types.h"
#include "SG__DMA_test_types.h"
#include "SG__DMA_test.h"

/* Private macros used by the generated code to access rtModel */
#ifndef rtmSetTFinal
#define rtmSetTFinal(rtm, val)         ((rtm)->Timing.tFinal = (val))
#endif

#ifndef rtmSetTPtr
#define rtmSetTPtr(rtm, val)           ((rtm)->Timing.t = (val))
#endif

#include "dsp_rt.h"  /* DSP System Toolbox general run time support functions */

struct {
  void *context;
  uint32_T IRQ;
  struct sigevent sig_none;
  struct sigevent sig_pulse;
  uint32_T coid;
  uint32_T pri;
  uint32_T count;
  uint32_T intrID;
} Root_InterruptSetup_D;

// Define a static error message buffer for this instance
static char Root_InterruptSetup_errmsg[256];

//
extern "C"
{
  void IO135_start_public( void *, bool );
  void IO135_stop_public( void * );
  bool IO135_isr_public( void * );
  int32_T IO135_map_public( void **, uint32_T );
}

//
const struct sigevent *Root_InterruptSetup_ISR(void *data, int id);
extern void* slrtRegisterSignalToLoggingService(uintptr_t sigAddr);
extern "C" void sg_IO132_IO133_da_s_v2(SimStruct *rts);
extern "C" void sg_IO132_IO133_ad_s_v2(SimStruct *rts);
extern "C" void sg_IO132_IO133_setup_s_v2(SimStruct *rts);
extern "C" void sg_IO104_DMA_setup_s(SimStruct *rts);
extern "C" void sg_IO104_DMA_ad_s(SimStruct *rts);
extern "C" void sg_IO104_DMA_da_s(SimStruct *rts);

#endif                                 /* RTW_HEADER_SG__DMA_test_private_h_ */
