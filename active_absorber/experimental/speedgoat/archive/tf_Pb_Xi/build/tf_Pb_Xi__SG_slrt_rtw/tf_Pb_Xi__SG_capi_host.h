#ifndef RTW_HEADER_tf_Pb_Xi__SG_cap_host_h_
#define RTW_HEADER_tf_Pb_Xi__SG_cap_host_h_
#ifdef HOST_CAPI_BUILD
#include "rtw_capi.h"
#include "rtw_modelmap.h"

typedef struct {
  rtwCAPI_ModelMappingInfo mmi;
} tf_Pb_Xi__SG_host_DataMapInfo_T;

#ifdef __cplusplus

extern "C" {

#endif

  void tf_Pb_Xi__SG_host_InitializeDataMapInfo(tf_Pb_Xi__SG_host_DataMapInfo_T
    *dataMap, const char *path);

#ifdef __cplusplus

}
#endif
#endif                                 /* HOST_CAPI_BUILD */
#endif                                 /* RTW_HEADER_tf_Pb_Xi__SG_cap_host_h_ */

/* EOF: tf_Pb_Xi__SG_capi_host.h */
