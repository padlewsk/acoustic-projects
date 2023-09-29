#include "rte_ref_main_model_R2022b_parameters.h"
#include "ref_submodel1.h"
#include "ref_submodel2.h"
#include "ref_submodel3.h"
#include "ref_submodel4.h"
#include "ref_main_model_R2022b.h"
#include "ref_submodel1_cal.h"
#include "ref_submodel2_cal.h"
#include "ref_submodel3_cal.h"
#include "ref_submodel4_cal.h"
#include "ref_main_model_R2022b_cal.h"

extern ref_submodel1_cal_type ref_submodel1_cal_impl;
extern ref_submodel2_cal_type ref_submodel2_cal_impl;
extern ref_submodel3_cal_type ref_submodel3_cal_impl;
extern ref_submodel4_cal_type ref_submodel4_cal_impl;
extern ref_main_model_R2022b_cal_type ref_main_model_R2022b_cal_impl;
namespace slrealtime
{
  /* Description of SEGMENTS */
  SegmentVector segmentInfo {
    { (void*)&ref_main_model_R2022b_cal_impl, (void**)&ref_main_model_R2022b_cal,
      sizeof(ref_main_model_R2022b_cal_type), 2 },

    { (void*)&ref_submodel4_cal_impl, (void**)&ref_submodel4_cal, sizeof
      (ref_submodel4_cal_type), 2 },

    { (void*)&ref_submodel3_cal_impl, (void**)&ref_submodel3_cal, sizeof
      (ref_submodel3_cal_type), 2 },

    { (void*)&ref_submodel2_cal_impl, (void**)&ref_submodel2_cal, sizeof
      (ref_submodel2_cal_type), 2 },

    { (void*)&ref_submodel1_cal_impl, (void**)&ref_submodel1_cal, sizeof
      (ref_submodel1_cal_type), 2 }
  };

  SegmentVector &getSegmentVector(void)
  {
    return segmentInfo;
  }
}                                      // slrealtime
