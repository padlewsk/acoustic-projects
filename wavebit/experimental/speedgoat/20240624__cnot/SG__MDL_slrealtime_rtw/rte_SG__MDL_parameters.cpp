#include "rte_SG__MDL_parameters.h"
#include "SG__MDL.h"
#include "SG__MDL_cal.h"

extern SG__MDL_cal_type SG__MDL_cal_impl;
namespace slrealtime
{
  /* Description of SEGMENTS */
  SegmentVector segmentInfo {
    { (void*)&SG__MDL_cal_impl, (void**)&SG__MDL_cal, sizeof(SG__MDL_cal_type),
      2 }
  };

  SegmentVector &getSegmentVector(void)
  {
    return segmentInfo;
  }
}                                      // slrealtime
