/*
 * SG__MDL_IO104_IO135.cpp
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "SG__MDL_IO104_IO135".
 *
 * Model version              : 6.305
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Wed Sep 20 07:28:58 2023
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
 */

#include "SG__MDL_IO104_IO135.h"
#include "crl_mutex.hpp"
#include "rtwtypes.h"
#include "SG__MDL_IO104_IO135_cal.h"
#include "SG__MDL_IO104_IO135_private.h"
#include <cstring>
#define SG__REF_IO_MDLREF_HIDE_CHILD_
#include "SG__REF_IO.h"

/* Tasks */
RT_MODEL_SG__MDL_IO104_IO135_T task_M_[2];
RT_MODEL_SG__MDL_IO104_IO135_T *task_M[2];

/* Child s-functions */
RTWSfcnInfo sfcnInfo_[1];
RTWSfcnInfo *sfcnInfo[1];

/* Block states (default storage) */
DW_SG__MDL_IO104_IO135_T SG__MDL_IO104_IO135_DW;

/* Real-time model */
RT_MODEL_SG__MDL_IO104_IO135_T SG__MDL_IO104_IO135_M_ =
  RT_MODEL_SG__MDL_IO104_IO135_T();
RT_MODEL_SG__MDL_IO104_IO135_T *const SG__MDL_IO104_IO135_M =
  &SG__MDL_IO104_IO135_M_;

/* This function updates active task counters and model execution time. */
void AdvanceTaskCounters(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++SG__MDL_IO104_IO135_M->Timing.clockTick0)) {
    ++SG__MDL_IO104_IO135_M->Timing.clockTickH0;
  }

  SG__MDL_IO104_IO135_M->Timing.t[0] = SG__MDL_IO104_IO135_M->Timing.clockTick0 *
    SG__MDL_IO104_IO135_M->Timing.stepSize0 +
    SG__MDL_IO104_IO135_M->Timing.clockTickH0 *
    SG__MDL_IO104_IO135_M->Timing.stepSize0 * 4294967296.0;
}

/* OutputUpdate for Task: Periodic_IO */
void Periodic_IO_step(void)            /* Sample time: [0.0001s, 0.0s] */
{
  /* local block i/o variables */
  real_T rtb_Model[32];

  /* TaskTransBlk generated from: '<Root>/Model' */
  rtw_slrealtime_sem_wait(SG__MDL_IO104_IO135_DW.sw_buf_1);

  /* ModelReference: '<Root>/Model' incorporates:
   *  TaskTransBlk generated from: '<Root>/Model'
   */
  SG__REF_IO(&SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[0],
             &rtb_Model[0]);

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++task_M[0]->Timing.clockTick0)) {
    ++task_M[0]->Timing.clockTickH0;
  }

  task_M[0]->Timing.t[0] = task_M[0]->Timing.clockTick0 * task_M[0]
    ->Timing.stepSize0 + task_M[0]->Timing.clockTickH0 * task_M[0]
    ->Timing.stepSize0 * 4294967296.0;
}

/* OutputUpdate for Task: Periodic_task3 */
void Periodic_task3_step(void)         /* Sample time: [0.0001s, 0.0s] */
{
  /* TaskTransBlk generated from: '<Root>/Subsystem' incorporates:
   *  Constant: '<S1>/Constant'
   */
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[0] =
    SG__MDL_IO104_IO135_cal->Constant_Value[0];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[1] =
    SG__MDL_IO104_IO135_cal->Constant_Value[1];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[2] =
    SG__MDL_IO104_IO135_cal->Constant_Value[2];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[3] =
    SG__MDL_IO104_IO135_cal->Constant_Value[3];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[4] =
    SG__MDL_IO104_IO135_cal->Constant_Value[4];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[5] =
    SG__MDL_IO104_IO135_cal->Constant_Value[5];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[6] =
    SG__MDL_IO104_IO135_cal->Constant_Value[6];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[7] =
    SG__MDL_IO104_IO135_cal->Constant_Value[7];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[8] =
    SG__MDL_IO104_IO135_cal->Constant_Value[8];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[9] =
    SG__MDL_IO104_IO135_cal->Constant_Value[9];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[10] =
    SG__MDL_IO104_IO135_cal->Constant_Value[10];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[11] =
    SG__MDL_IO104_IO135_cal->Constant_Value[11];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[12] =
    SG__MDL_IO104_IO135_cal->Constant_Value[12];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[13] =
    SG__MDL_IO104_IO135_cal->Constant_Value[13];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[14] =
    SG__MDL_IO104_IO135_cal->Constant_Value[14];
  SG__MDL_IO104_IO135_DW.TmpTaskTransAtSubsystemOutport1[15] =
    SG__MDL_IO104_IO135_cal->Constant_Value[15];
  rtw_slrealtime_sem_post(SG__MDL_IO104_IO135_DW.sw_buf_1);

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++task_M[1]->Timing.clockTick0)) {
    ++task_M[1]->Timing.clockTickH0;
  }

  task_M[1]->Timing.t[0] = task_M[1]->Timing.clockTick0 * task_M[1]
    ->Timing.stepSize0 + task_M[1]->Timing.clockTickH0 * task_M[1]
    ->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void SG__MDL_IO104_IO135_initialize(void)
{
  /* Registration code */

  /* Set task counter limit used by the static main program */
  (SG__MDL_IO104_IO135_M)->Timing.TaskCounters.cLimit[0] = 1;

  /* Initialize timing info */
  {
    int_T *mdlTsMap = SG__MDL_IO104_IO135_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "SG__MDL_IO104_IO135_M points to
       static memory which is guaranteed to be non-NULL" */
    SG__MDL_IO104_IO135_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    SG__MDL_IO104_IO135_M->Timing.sampleTimes =
      (&SG__MDL_IO104_IO135_M->Timing.sampleTimesArray[0]);
    SG__MDL_IO104_IO135_M->Timing.offsetTimes =
      (&SG__MDL_IO104_IO135_M->Timing.offsetTimesArray[0]);

    /* task periods */
    SG__MDL_IO104_IO135_M->Timing.sampleTimes[0] = (0.0001);

    /* task offsets */
    SG__MDL_IO104_IO135_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(SG__MDL_IO104_IO135_M, &SG__MDL_IO104_IO135_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = SG__MDL_IO104_IO135_M->Timing.sampleHitArray;
    int_T *mdlPerTaskSampleHits =
      SG__MDL_IO104_IO135_M->Timing.perTaskSampleHitsArray;
    SG__MDL_IO104_IO135_M->Timing.perTaskSampleHits = (&mdlPerTaskSampleHits[0]);
    mdlSampleHits[0] = 1;
    SG__MDL_IO104_IO135_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  SG__MDL_IO104_IO135_M->Timing.stepSize0 = 0.0001;
  SG__MDL_IO104_IO135_M->solverInfoPtr = (&SG__MDL_IO104_IO135_M->solverInfo);
  SG__MDL_IO104_IO135_M->Timing.stepSize = (0.0001);
  rtsiSetFixedStepSize(&SG__MDL_IO104_IO135_M->solverInfo, 0.0001);
  rtsiSetSolverMode(&SG__MDL_IO104_IO135_M->solverInfo, SOLVER_MODE_MULTITASKING);

  /* states (dwork) */
  (void) std::memset(static_cast<void *>(&SG__MDL_IO104_IO135_DW), 0,
                     sizeof(DW_SG__MDL_IO104_IO135_T));

  {
    /* user code (registration function declaration) */
    int_T tIdx;
    for (tIdx = 0; tIdx < 2; tIdx++) {
      task_M[tIdx] = &task_M_[tIdx];

      /* initialize real-time model */
      (void) std::memset(static_cast<void *>(task_M[tIdx]), 0,
                         sizeof(RT_MODEL_SG__MDL_IO104_IO135_T));
      task_M[tIdx]->Timing.TaskCounters.cLimit[0] = 1;
    }

    for (tIdx = 0; tIdx < 2; tIdx++) {
      /* Initialize timing info */
      {
        int_T *mdlTsMap = task_M[tIdx]->Timing.sampleTimeTaskIDArray;
        mdlTsMap[0] = 0;
        task_M[tIdx]->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
        task_M[tIdx]->Timing.sampleTimes = (&task_M[tIdx]
          ->Timing.sampleTimesArray[0]);
        task_M[tIdx]->Timing.offsetTimes = (&task_M[tIdx]
          ->Timing.offsetTimesArray[0]);

        /* task periods */
        task_M[tIdx]->Timing.sampleTimes[0] = (0.0001);

        /* task offsets */
        task_M[tIdx]->Timing.offsetTimes[0] = (0.0);
      }

      rtmSetTPtr(task_M[tIdx], &task_M[tIdx]->Timing.tArray[0]);

      {
        int_T *mdlSampleHits = task_M[tIdx]->Timing.sampleHitArray;
        int_T *mdlPerTaskSampleHits = task_M[tIdx]
          ->Timing.perTaskSampleHitsArray;
        task_M[tIdx]->Timing.perTaskSampleHits = (&mdlPerTaskSampleHits[0]);
        mdlSampleHits[0] = 1;
        task_M[tIdx]->Timing.sampleHits = (&mdlSampleHits[0]);
      }

      task_M[tIdx]->Timing.stepSize0 = 0.0001;
      task_M[tIdx]->solverInfoPtr = (&task_M[tIdx]->solverInfo);
      task_M[tIdx]->Timing.stepSize = (0.0001);
      rtsiSetFixedStepSize(&task_M[tIdx]->solverInfo, 0.0001);
      rtsiSetSolverMode(&task_M[tIdx]->solverInfo, SOLVER_MODE_MULTITASKING);
    }

    ;
    ;

    {                                  /* child S-Function registration */
      static time_T *taskTimePtrs[1];
      static int_T *perTaskSampleHitsPtrs[(1 * 1)];
      sfcnInfo[0]= &sfcnInfo_[0];
      rtssSetErrorStatusPtr(sfcnInfo[0], (&rtmGetErrorStatus
        (SG__MDL_IO104_IO135_M)));
      rtssSetNumRootSampTimesPtr(sfcnInfo[0],
        &SG__MDL_IO104_IO135_M->Sizes.numSampTimes);
      rtssSetTStartPtr(sfcnInfo[0], &rtmGetTStart(SG__MDL_IO104_IO135_M));
      rtssSetTimeOfLastOutputPtr(sfcnInfo[0], &rtmGetTimeOfLastOutput
        (SG__MDL_IO104_IO135_M));
      rtssSetStepSizePtr(sfcnInfo[0], &SG__MDL_IO104_IO135_M->Timing.stepSize);
      rtssSetStopRequestedPtr(sfcnInfo[0], &rtmGetStopRequested
        (SG__MDL_IO104_IO135_M));
      rtssSetSimModePtr(sfcnInfo[0], &SG__MDL_IO104_IO135_M->simMode);
      rtssSetDerivCacheNeedsResetPtr(sfcnInfo[0], &task_M[0]
        ->derivCacheNeedsReset);
      rtssSetZCCacheNeedsResetPtr(sfcnInfo[0], &task_M[0]->zCCacheNeedsReset);
      rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo[0],
        &task_M[0]->CTOutputIncnstWithState);
      rtssSetSolverInfoPtr(sfcnInfo[0], &task_M[0]->solverInfoPtr);
      taskTimePtrs[0] = &(task_M[0]->Timing.t[0]);
      rtssSetTPtrPtr(sfcnInfo[0], taskTimePtrs);
      rtssSetPerTaskSampleHitsPtr(sfcnInfo[0], perTaskSampleHitsPtrs);
      rtssSetSampleHitsPtr(sfcnInfo[0],
                           &SG__MDL_IO104_IO135_M->Timing.sampleHits);
    }
  }

  /* Model Initialize function for ModelReference Block: '<Root>/Model' */
  SG__REF_IO_initialize(rtmGetErrorStatusPointer(SG__MDL_IO104_IO135_M),
                        rtmGetStopRequestedPtr(SG__MDL_IO104_IO135_M), &(task_M
    [0]->solverInfo), (RTWSfcnInfo *)(sfcnInfo[0]), 0);

  /* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem' */
  rtw_slrealtime_sem_init(&SG__MDL_IO104_IO135_DW.sw_buf_1, 0);

  /* SystemInitialize for ModelReference: '<Root>/Model' */
  SG__REF_IO_Init();
}

/* Model terminate function */
void SG__MDL_IO104_IO135_terminate(void)
{
  /* Terminate for TaskTransBlk generated from: '<Root>/Subsystem' */
  rtw_slrealtime_sem_destroy(SG__MDL_IO104_IO135_DW.sw_buf_1);

  /* Terminate for ModelReference: '<Root>/Model' */
  SG__REF_IO_Term();
}
