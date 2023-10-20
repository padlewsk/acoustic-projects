#include "rte_SG__DMA_test_parameters.h"
#include "SG__DMA_test.h"
#include "SG__DMA_test_cal.h"

extern SG__DMA_test_cal_type SG__DMA_test_cal_impl;
namespace slrealtime
{
  /* Description of SEGMENTS */
  SegmentVector segmentInfo {
    { (void*)&SG__DMA_test_cal_impl, (void**)&SG__DMA_test_cal, sizeof
      (SG__DMA_test_cal_type), 2 }
  };

  SegmentVector &getSegmentVector(void)
  {
    return segmentInfo;
  }
}                                      // slrealtime
