/*
 * File: slrealtime_code_profiling_utility_functions.cpp
 *
 * Code generated for instrumentation.
 *
 */

#include "slrealtime_code_profiling_utility_functions.h"

/* Code instrumentation offset(s) for model  */
#define taskTimeStart__offset          0
#define taskTimeEnd__offset            0

/* Code instrumentation offset(s) for model SG__REF_IO */

/* Code instrumentation offset(s) for model SG__MDL */
#define profileStart_SG_MDL_offset     132
#define profileEnd_SG_MDL_offset       132

/* A function parameter may be intentionally unused */
#ifndef UNUSED_PARAMETER
# if defined(__LCC__)
#   define UNUSED_PARAMETER(x)
# else
#   define UNUSED_PARAMETER(x)         (void) (x)
# endif
#endif

void xilUploadProfilingData(uint32_T sectionId)
{
  slrealtimeAddEvent(sectionId);
}

/* For real-time, multitasking case this function is stubbed out. */
void xilProfilingTimerFreezeInternal(void)
{
}

void xilProfilingTimerFreeze(void)
{
}

/* For real-time, multitasking case this function is stubbed out. */
void xilProfilingTimerUnFreezeInternal(void)
{
}

void xilProfilingTimerUnFreeze(void)
{
}

void taskTimeStart(uint32_T sectionId)
{
  /* Send execution profiling data to host */
  xilUploadProfilingData(sectionId);
  xilProfilingTimerUnFreezeInternal();
}

void taskTimeEnd(uint32_T sectionId)
{
  uint32_T sectionIdNeg = ~sectionId;
  xilProfilingTimerFreezeInternal();

  /* Send execution profiling data to host */
  xilUploadProfilingData(sectionIdNeg);
}

void profileStart(uint32_T sectionId)
{
  xilProfilingTimerFreezeInternal();

  /* Send execution profiling data to host */
  xilUploadProfilingData(sectionId);
  xilProfilingTimerUnFreezeInternal();
}

void profileEnd(uint32_T sectionId)
{
  uint32_T sectionIdNeg = ~sectionId;
  xilProfilingTimerFreezeInternal();

  /* Send execution profiling data to host */
  xilUploadProfilingData(sectionIdNeg);
  xilProfilingTimerUnFreezeInternal();
}

/* Code instrumentation method(s) for model  */
void taskTimeStart_(uint32_T sectionId)
{
  taskTimeStart(taskTimeStart__offset + sectionId);
}

void taskTimeEnd_(uint32_T sectionId)
{
  taskTimeEnd(taskTimeEnd__offset + sectionId);
}

/* Code instrumentation method(s) for model SG__REF_IO */

/* Code instrumentation method(s) for model SG__MDL */
void profileStart_SG_MDL(uint32_T sectionId)
{
  profileStart(profileStart_SG_MDL_offset + sectionId);
}

void profileEnd_SG_MDL(uint32_T sectionId)
{
  profileEnd(profileEnd_SG_MDL_offset + sectionId);
}
