/*
 * ref_main_model_R2022b.cpp
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "ref_main_model_R2022b".
 *
 * Model version              : 11.10
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C++ source code generated on : Fri Sep 22 15:37:23 2023
 *
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ref_main_model_R2022b.h"
#include "crl_mutex.hpp"
#include "ref_main_model_R2022b_cal.h"
#include "rtwtypes.h"
#include "ref_main_model_R2022b_private.h"
#include <cstring>
#define ref_submodel1_MDLREF_HIDE_CHILD_
#include "ref_submodel1.h"
#define ref_submodel2_MDLREF_HIDE_CHILD_
#include "ref_submodel2.h"
#define ref_submodel3_MDLREF_HIDE_CHILD_
#include "ref_submodel3.h"
#define ref_submodel4_MDLREF_HIDE_CHILD_
#include "ref_submodel4.h"

/* Tasks */
RT_MODEL_ref_main_model_R2022_T task_M_[4];
RT_MODEL_ref_main_model_R2022_T *task_M[4];

/* Child s-functions */
RTWSfcnInfo sfcnInfo_[4];
RTWSfcnInfo *sfcnInfo[4];

/* Timing bridge */
rtTimingBridge timingBridge[1];

/* Block signals (default storage) */
B_ref_main_model_R2022b_T ref_main_model_R2022b_B;

/* Block states (default storage) */
DW_ref_main_model_R2022b_T ref_main_model_R2022b_DW;

/* Real-time model */
RT_MODEL_ref_main_model_R2022_T ref_main_model_R2022b_M_ =
  RT_MODEL_ref_main_model_R2022_T();
RT_MODEL_ref_main_model_R2022_T *const ref_main_model_R2022b_M =
  &ref_main_model_R2022b_M_;

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
  if (!(++ref_main_model_R2022b_M->Timing.clockTick0)) {
    ++ref_main_model_R2022b_M->Timing.clockTickH0;
  }

  ref_main_model_R2022b_M->Timing.t[0] =
    ref_main_model_R2022b_M->Timing.clockTick0 *
    ref_main_model_R2022b_M->Timing.stepSize0 +
    ref_main_model_R2022b_M->Timing.clockTickH0 *
    ref_main_model_R2022b_M->Timing.stepSize0 * 4294967296.0;
}

/* OutputUpdate for Task: Periodic_Model1_500us */
void Periodic_Model1_500us_step(void)  /* Sample time: [0.0001s, 0.0s] */
{
  {
    int_T wrBufIdx;

    /* TaskTransBlk generated from: '<Root>/Model 1' */
    rtw_slrealtime_mutex_lock(ref_main_model_R2022b_DW.mw_buf_1);
    wrBufIdx = 1 - ref_main_model_R2022b_DW.fw_buf_1;
    rtw_slrealtime_mutex_unlock(ref_main_model_R2022b_DW.mw_buf_1);

    /* TaskTransBlk generated from: '<Root>/Model 1' */
    ref_main_model_R2022b_B.TmpTaskTransAtModel1Inport1 =
      ref_main_model_R2022b_DW.TmpTaskTransAtModel2Outport1_bu[wrBufIdx];

    /* ModelReference: '<Root>/Model 1' */
    ref_submodel1(&ref_main_model_R2022b_B.TmpTaskTransAtModel1Inport1);
  }

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

/* OutputUpdate for Task: Periodic_Model2_500us */
void Periodic_Model2_500us_step(void)  /* Sample time: [0.0001s, 0.0s] */
{
  /* ModelReference: '<Root>/Model 2' */
  ref_submodel2(&ref_main_model_R2022b_B.IO135_AI_CH1);

  /* TaskTransBlk generated from: '<Root>/Model 2' */
  ref_main_model_R2022b_DW.TmpTaskTransAtModel2Outport1_bu[ref_main_model_R2022b_DW.fw_buf_1]
    = ref_main_model_R2022b_B.IO135_AI_CH1;

  /* TaskTransBlk generated from: '<Root>/Model 2' */
  ref_main_model_R2022b_B.TmpTaskTransAtModel2Outport1 =
    ref_main_model_R2022b_DW.TmpTaskTransAtModel2Outport1_bu[ref_main_model_R2022b_DW.fw_buf_1];

  /* TaskTransBlk generated from: '<Root>/Model 2' */
  rtw_slrealtime_mutex_lock(ref_main_model_R2022b_DW.mw_buf_1);
  ref_main_model_R2022b_DW.fw_buf_1 = 1 - ref_main_model_R2022b_DW.fw_buf_1;
  rtw_slrealtime_mutex_unlock(ref_main_model_R2022b_DW.mw_buf_1);

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

/* OutputUpdate for Task: Periodic_Model3_400us */
void Periodic_Model3_400us_step(void)  /* Sample time: [0.0001s, 0.0s] */
{
  {
    int_T wrBufIdx;

    /* TaskTransBlk generated from: '<Root>/Model 3' */
    rtw_slrealtime_mutex_lock(ref_main_model_R2022b_DW.mw_buf_2);
    wrBufIdx = 1 - ref_main_model_R2022b_DW.fw_buf_2;
    rtw_slrealtime_mutex_unlock(ref_main_model_R2022b_DW.mw_buf_2);

    /* TaskTransBlk generated from: '<Root>/Model 3' */
    ref_main_model_R2022b_B.TmpTaskTransAtModel3Inport1 =
      ref_main_model_R2022b_DW.TmpTaskTransAtModel4Outport1_bu[wrBufIdx];

    /* ModelReference: '<Root>/Model 3' */
    ref_submodel3(&ref_main_model_R2022b_B.TmpTaskTransAtModel3Inport1);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++task_M[2]->Timing.clockTick0)) {
    ++task_M[2]->Timing.clockTickH0;
  }

  task_M[2]->Timing.t[0] = task_M[2]->Timing.clockTick0 * task_M[2]
    ->Timing.stepSize0 + task_M[2]->Timing.clockTickH0 * task_M[2]
    ->Timing.stepSize0 * 4294967296.0;
}

/* OutputUpdate for Task: Periodic_Model4_400us */
void Periodic_Model4_400us_step(void)  /* Sample time: [0.0001s, 0.0s] */
{
  /* ModelReference: '<Root>/Model 4' */
  ref_submodel4(&ref_main_model_R2022b_B.IO135_AI_CH1_a);

  /* TaskTransBlk generated from: '<Root>/Model 4' */
  ref_main_model_R2022b_DW.TmpTaskTransAtModel4Outport1_bu[ref_main_model_R2022b_DW.fw_buf_2]
    = ref_main_model_R2022b_B.IO135_AI_CH1_a;

  /* TaskTransBlk generated from: '<Root>/Model 4' */
  ref_main_model_R2022b_B.TmpTaskTransAtModel4Outport1 =
    ref_main_model_R2022b_DW.TmpTaskTransAtModel4Outport1_bu[ref_main_model_R2022b_DW.fw_buf_2];

  /* TaskTransBlk generated from: '<Root>/Model 4' */
  rtw_slrealtime_mutex_lock(ref_main_model_R2022b_DW.mw_buf_2);
  ref_main_model_R2022b_DW.fw_buf_2 = 1 - ref_main_model_R2022b_DW.fw_buf_2;
  rtw_slrealtime_mutex_unlock(ref_main_model_R2022b_DW.mw_buf_2);

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++task_M[3]->Timing.clockTick0)) {
    ++task_M[3]->Timing.clockTickH0;
  }

  task_M[3]->Timing.t[0] = task_M[3]->Timing.clockTick0 * task_M[3]
    ->Timing.stepSize0 + task_M[3]->Timing.clockTickH0 * task_M[3]
    ->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void ref_main_model_R2022b_initialize(void)
{
  /* Registration code */

  /* Set task counter limit used by the static main program */
  (ref_main_model_R2022b_M)->Timing.TaskCounters.cLimit[0] = 1;

  /* Initialize timing info */
  {
    int_T *mdlTsMap = ref_main_model_R2022b_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "ref_main_model_R2022b_M points to
       static memory which is guaranteed to be non-NULL" */
    ref_main_model_R2022b_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    ref_main_model_R2022b_M->Timing.sampleTimes =
      (&ref_main_model_R2022b_M->Timing.sampleTimesArray[0]);
    ref_main_model_R2022b_M->Timing.offsetTimes =
      (&ref_main_model_R2022b_M->Timing.offsetTimesArray[0]);

    /* task periods */
    ref_main_model_R2022b_M->Timing.sampleTimes[0] = (0.0001);

    /* task offsets */
    ref_main_model_R2022b_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(ref_main_model_R2022b_M, &ref_main_model_R2022b_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = ref_main_model_R2022b_M->Timing.sampleHitArray;
    int_T *mdlPerTaskSampleHits =
      ref_main_model_R2022b_M->Timing.perTaskSampleHitsArray;
    ref_main_model_R2022b_M->Timing.perTaskSampleHits = (&mdlPerTaskSampleHits[0]);
    mdlSampleHits[0] = 1;
    ref_main_model_R2022b_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  ref_main_model_R2022b_M->Timing.stepSize0 = 0.0001;
  ref_main_model_R2022b_M->solverInfoPtr = (&ref_main_model_R2022b_M->solverInfo);
  ref_main_model_R2022b_M->Timing.stepSize = (0.0001);
  rtsiSetFixedStepSize(&ref_main_model_R2022b_M->solverInfo, 0.0001);
  rtsiSetSolverMode(&ref_main_model_R2022b_M->solverInfo,
                    SOLVER_MODE_MULTITASKING);

  /* block I/O */
  (void) std::memset((static_cast<void *>(&ref_main_model_R2022b_B)), 0,
                     sizeof(B_ref_main_model_R2022b_T));

  /* states (dwork) */
  (void) std::memset(static_cast<void *>(&ref_main_model_R2022b_DW), 0,
                     sizeof(DW_ref_main_model_R2022b_T));

  {
    /* user code (registration function declaration) */
    int_T tIdx;
    for (tIdx = 0; tIdx < 4; tIdx++) {
      task_M[tIdx] = &task_M_[tIdx];

      /* initialize real-time model */
      (void) std::memset(static_cast<void *>(task_M[tIdx]), 0,
                         sizeof(RT_MODEL_ref_main_model_R2022_T));
      task_M[tIdx]->Timing.TaskCounters.cLimit[0] = 1;
    }

    for (tIdx = 0; tIdx < 4; tIdx++) {
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
    ;
    ;

    {                                  /* child S-Function registration */
      static time_T *taskTimePtrs[1];
      static int_T *perTaskSampleHitsPtrs[(1 * 1)];
      sfcnInfo[0]= &sfcnInfo_[0];
      rtssSetErrorStatusPtr(sfcnInfo[0], (&rtmGetErrorStatus
        (ref_main_model_R2022b_M)));
      rtssSetNumRootSampTimesPtr(sfcnInfo[0],
        &ref_main_model_R2022b_M->Sizes.numSampTimes);
      rtssSetTStartPtr(sfcnInfo[0], &rtmGetTStart(ref_main_model_R2022b_M));
      rtssSetTimeOfLastOutputPtr(sfcnInfo[0], &rtmGetTimeOfLastOutput
        (ref_main_model_R2022b_M));
      rtssSetStepSizePtr(sfcnInfo[0], &ref_main_model_R2022b_M->Timing.stepSize);
      rtssSetStopRequestedPtr(sfcnInfo[0], &rtmGetStopRequested
        (ref_main_model_R2022b_M));
      rtssSetSimModePtr(sfcnInfo[0], &ref_main_model_R2022b_M->simMode);
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
                           &ref_main_model_R2022b_M->Timing.sampleHits);
    }

    {                                  /* child S-Function registration */
      static time_T *taskTimePtrs[1];
      static int_T *perTaskSampleHitsPtrs[(1 * 1)];
      sfcnInfo[1]= &sfcnInfo_[1];
      rtssSetErrorStatusPtr(sfcnInfo[1], (&rtmGetErrorStatus
        (ref_main_model_R2022b_M)));
      rtssSetNumRootSampTimesPtr(sfcnInfo[1],
        &ref_main_model_R2022b_M->Sizes.numSampTimes);
      rtssSetTStartPtr(sfcnInfo[1], &rtmGetTStart(ref_main_model_R2022b_M));
      rtssSetTimeOfLastOutputPtr(sfcnInfo[1], &rtmGetTimeOfLastOutput
        (ref_main_model_R2022b_M));
      rtssSetStepSizePtr(sfcnInfo[1], &ref_main_model_R2022b_M->Timing.stepSize);
      rtssSetStopRequestedPtr(sfcnInfo[1], &rtmGetStopRequested
        (ref_main_model_R2022b_M));
      rtssSetSimModePtr(sfcnInfo[1], &ref_main_model_R2022b_M->simMode);
      rtssSetDerivCacheNeedsResetPtr(sfcnInfo[1], &task_M[1]
        ->derivCacheNeedsReset);
      rtssSetZCCacheNeedsResetPtr(sfcnInfo[1], &task_M[1]->zCCacheNeedsReset);
      rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo[1],
        &task_M[1]->CTOutputIncnstWithState);
      rtssSetSolverInfoPtr(sfcnInfo[1], &task_M[1]->solverInfoPtr);
      taskTimePtrs[0] = &(task_M[1]->Timing.t[0]);
      rtssSetTPtrPtr(sfcnInfo[1], taskTimePtrs);
      rtssSetPerTaskSampleHitsPtr(sfcnInfo[1], perTaskSampleHitsPtrs);
      rtssSetSampleHitsPtr(sfcnInfo[1],
                           &ref_main_model_R2022b_M->Timing.sampleHits);
    }

    {                                  /* child S-Function registration */
      static time_T *taskTimePtrs[1];
      static int_T *perTaskSampleHitsPtrs[(1 * 1)];
      sfcnInfo[2]= &sfcnInfo_[2];
      rtssSetErrorStatusPtr(sfcnInfo[2], (&rtmGetErrorStatus
        (ref_main_model_R2022b_M)));
      rtssSetNumRootSampTimesPtr(sfcnInfo[2],
        &ref_main_model_R2022b_M->Sizes.numSampTimes);
      rtssSetTStartPtr(sfcnInfo[2], &rtmGetTStart(ref_main_model_R2022b_M));
      rtssSetTimeOfLastOutputPtr(sfcnInfo[2], &rtmGetTimeOfLastOutput
        (ref_main_model_R2022b_M));
      rtssSetStepSizePtr(sfcnInfo[2], &ref_main_model_R2022b_M->Timing.stepSize);
      rtssSetStopRequestedPtr(sfcnInfo[2], &rtmGetStopRequested
        (ref_main_model_R2022b_M));
      rtssSetSimModePtr(sfcnInfo[2], &ref_main_model_R2022b_M->simMode);
      rtssSetDerivCacheNeedsResetPtr(sfcnInfo[2], &task_M[2]
        ->derivCacheNeedsReset);
      rtssSetZCCacheNeedsResetPtr(sfcnInfo[2], &task_M[2]->zCCacheNeedsReset);
      rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo[2],
        &task_M[2]->CTOutputIncnstWithState);
      rtssSetSolverInfoPtr(sfcnInfo[2], &task_M[2]->solverInfoPtr);
      taskTimePtrs[0] = &(task_M[2]->Timing.t[0]);
      rtssSetTPtrPtr(sfcnInfo[2], taskTimePtrs);
      rtssSetPerTaskSampleHitsPtr(sfcnInfo[2], perTaskSampleHitsPtrs);
      rtssSetSampleHitsPtr(sfcnInfo[2],
                           &ref_main_model_R2022b_M->Timing.sampleHits);
    }

    {                                  /* child S-Function registration */
      static time_T *taskTimePtrs[1];
      static int_T *perTaskSampleHitsPtrs[(1 * 1)];
      sfcnInfo[3]= &sfcnInfo_[3];
      rtssSetErrorStatusPtr(sfcnInfo[3], (&rtmGetErrorStatus
        (ref_main_model_R2022b_M)));
      rtssSetNumRootSampTimesPtr(sfcnInfo[3],
        &ref_main_model_R2022b_M->Sizes.numSampTimes);
      rtssSetTStartPtr(sfcnInfo[3], &rtmGetTStart(ref_main_model_R2022b_M));
      rtssSetTimeOfLastOutputPtr(sfcnInfo[3], &rtmGetTimeOfLastOutput
        (ref_main_model_R2022b_M));
      rtssSetStepSizePtr(sfcnInfo[3], &ref_main_model_R2022b_M->Timing.stepSize);
      rtssSetStopRequestedPtr(sfcnInfo[3], &rtmGetStopRequested
        (ref_main_model_R2022b_M));
      rtssSetSimModePtr(sfcnInfo[3], &ref_main_model_R2022b_M->simMode);
      rtssSetDerivCacheNeedsResetPtr(sfcnInfo[3], &task_M[3]
        ->derivCacheNeedsReset);
      rtssSetZCCacheNeedsResetPtr(sfcnInfo[3], &task_M[3]->zCCacheNeedsReset);
      rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo[3],
        &task_M[3]->CTOutputIncnstWithState);
      rtssSetSolverInfoPtr(sfcnInfo[3], &task_M[3]->solverInfoPtr);
      taskTimePtrs[0] = &(task_M[3]->Timing.t[0]);
      rtssSetTPtrPtr(sfcnInfo[3], taskTimePtrs);
      rtssSetPerTaskSampleHitsPtr(sfcnInfo[3], perTaskSampleHitsPtrs);
      rtssSetSampleHitsPtr(sfcnInfo[3],
                           &ref_main_model_R2022b_M->Timing.sampleHits);
    }
  }

  {
    static uint32_T *clockTickPtrs[1];
    static uint32_T *clockTickHPtrs[1];
    static real_T *taskTimePtrs[1];
    timingBridge[0].nTasks = 1;
    clockTickPtrs[0] = &(task_M[1]->Timing.clockTick0);
    clockTickHPtrs[0] = &(task_M[1]->Timing.clockTickH0);
    timingBridge[0].clockTick = clockTickPtrs;
    timingBridge[0].clockTickH = clockTickHPtrs;
    taskTimePtrs[0] = &(rtmGetT(task_M[1]));
    timingBridge[0].taskTime = taskTimePtrs;
  }

  /* Model Initialize function for ModelReference Block: '<Root>/Model 1' */
  ref_submodel1_initialize(rtmGetErrorStatusPointer(ref_main_model_R2022b_M),
    rtmGetStopRequestedPtr(ref_main_model_R2022b_M), &(task_M[0]->solverInfo),
    (RTWSfcnInfo *)(sfcnInfo[0]), 0);

  /* Model Initialize function for ModelReference Block: '<Root>/Model 2' */
  ref_submodel2_initialize(rtmGetErrorStatusPointer(ref_main_model_R2022b_M),
    rtmGetStopRequestedPtr(ref_main_model_R2022b_M), &(task_M[1]->solverInfo),
    (RTWSfcnInfo *)(sfcnInfo[1]), &timingBridge[0], 0);

  /* Model Initialize function for ModelReference Block: '<Root>/Model 3' */
  ref_submodel3_initialize(rtmGetErrorStatusPointer(ref_main_model_R2022b_M),
    rtmGetStopRequestedPtr(ref_main_model_R2022b_M), &(task_M[2]->solverInfo),
    (RTWSfcnInfo *)(sfcnInfo[2]), 0);

  /* Model Initialize function for ModelReference Block: '<Root>/Model 4' */
  ref_submodel4_initialize(rtmGetErrorStatusPointer(ref_main_model_R2022b_M),
    rtmGetStopRequestedPtr(ref_main_model_R2022b_M), &(task_M[3]->solverInfo),
    (RTWSfcnInfo *)(sfcnInfo[3]), 0);

  /* InitializeConditions for TaskTransBlk generated from: '<Root>/Model 2' */
  ref_main_model_R2022b_DW.fw_buf_1 = 0;
  rtw_slrealtime_mutex_init(&ref_main_model_R2022b_DW.mw_buf_1);

  /* InitializeConditions for TaskTransBlk generated from: '<Root>/Model 1' */
  ref_main_model_R2022b_DW.TmpTaskTransAtModel2Outport1_bu[1] =
    ref_main_model_R2022b_cal->TmpTaskTransAtModel1Inport1_IC;

  /* InitializeConditions for TaskTransBlk generated from: '<Root>/Model 4' */
  ref_main_model_R2022b_DW.fw_buf_2 = 0;
  rtw_slrealtime_mutex_init(&ref_main_model_R2022b_DW.mw_buf_2);

  /* InitializeConditions for TaskTransBlk generated from: '<Root>/Model 3' */
  ref_main_model_R2022b_DW.TmpTaskTransAtModel4Outport1_bu[1] =
    ref_main_model_R2022b_cal->TmpTaskTransAtModel3Inport1_IC;

  /* SystemInitialize for ModelReference: '<Root>/Model 1' */
  ref_submodel1_Init();

  /* SystemInitialize for ModelReference: '<Root>/Model 2' */
  ref_submodel2_Init();

  /* SystemInitialize for ModelReference: '<Root>/Model 3' */
  ref_submodel3_Init();

  /* SystemInitialize for ModelReference: '<Root>/Model 4' */
  ref_submodel4_Init();
}

/* Model terminate function */
void ref_main_model_R2022b_terminate(void)
{
  /* Terminate for ModelReference: '<Root>/Model 2' */
  ref_submodel2_Term();

  /* Terminate for TaskTransBlk generated from: '<Root>/Model 2' */
  rtw_slrealtime_mutex_destroy(ref_main_model_R2022b_DW.mw_buf_1);

  /* Terminate for ModelReference: '<Root>/Model 1' */
  ref_submodel1_Term();

  /* Terminate for ModelReference: '<Root>/Model 4' */
  ref_submodel4_Term();

  /* Terminate for TaskTransBlk generated from: '<Root>/Model 4' */
  rtw_slrealtime_mutex_destroy(ref_main_model_R2022b_DW.mw_buf_2);

  /* Terminate for ModelReference: '<Root>/Model 3' */
  ref_submodel3_Term();
}
