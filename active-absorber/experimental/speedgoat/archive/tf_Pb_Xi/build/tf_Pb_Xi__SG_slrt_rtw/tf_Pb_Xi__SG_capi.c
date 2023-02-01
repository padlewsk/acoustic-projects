/*
 * tf_Pb_Xi__SG_capi.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "tf_Pb_Xi__SG".
 *
 * Model version              : 1.4
 * Simulink Coder version : 9.3 (R2020a) 18-Nov-2019
 * C source code generated on : Fri Oct  8 17:00:38 2021
 *
 * Target selection: slrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Generic->32-bit x86 compatible
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "tf_Pb_Xi__SG_capi_host.h"
#define sizeof(s)                      ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el)              ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s)               (s)
#else                                  /* HOST_CAPI_BUILD */
#include "builtin_typeid_types.h"
#include "tf_Pb_Xi__SG.h"
#include "tf_Pb_Xi__SG_capi.h"
#include "tf_Pb_Xi__SG_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST
#define TARGET_STRING(s)               (NULL)
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif                                 /* HOST_CAPI_BUILD */

/* Block output signal information */
static const rtwCAPI_Signals rtBlockSignals[] = {
  /* addrMapIndex, sysNum, blockPath,
   * signalName, portNumber, dataTypeIndex, dimIndex, fxpIndex, sTimeIndex
   */
  { 0, 0, TARGET_STRING("From Workspace1"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 1, 4, TARGET_STRING("Highpass Filter"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 2, 3, TARGET_STRING("Highpass Filter1"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 3, 2, TARGET_STRING("Highpass Filter2"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 4, 1, TARGET_STRING("Highpass Filter3"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 5, 0, TARGET_STRING("IO334_IO/Constant4"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 6, 0, TARGET_STRING("IO334_IO/Constant5"),
    TARGET_STRING(""), 0, 2, 0, 0, 0 },

  { 7, 0, TARGET_STRING("IO334_IO/Data Type Conversion"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 8, 0, TARGET_STRING("IO334_IO/Data Type Conversion1"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 9, 0, TARGET_STRING("IO334_IO/Data Type Conversion2"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 10, 0, TARGET_STRING("IO334_IO/Data Type Conversion3"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 11, 0, TARGET_STRING("IO334_IO/Data Type Conversion4"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 12, 0, TARGET_STRING("IO334_IO/Data Type Conversion5"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 13, 0, TARGET_STRING("IO334_IO/Data Type Conversion6"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 14, 0, TARGET_STRING("IO334_IO/Data Type Conversion7"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 15, 0, TARGET_STRING("IO334_IO/Gain"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 16, 0, TARGET_STRING("IO334_IO/Gain1"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 17, 0, TARGET_STRING("IO334_IO/Gain2"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 18, 0, TARGET_STRING("IO334_IO/Gain3"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 19, 0, TARGET_STRING("IO334_IO/Gain4"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 20, 0, TARGET_STRING("IO334_IO/Gain5"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 21, 0, TARGET_STRING("IO334_IO/Gain6"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 22, 0, TARGET_STRING("IO334_IO/Gain7"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 23, 0, TARGET_STRING("IO334_IO/Rate Transition"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 24, 0, TARGET_STRING("IO334_IO/Rate Transition1"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 25, 0, TARGET_STRING("IO334_IO/Rate Transition2"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 26, 0, TARGET_STRING("IO334_IO/Rate Transition3"),
    TARGET_STRING(""), 0, 0, 0, 0, 0 },

  { 27, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 28, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc1"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 29, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc2"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 30, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc3"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 31, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc4"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 32, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc5"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 33, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc6"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 34, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/dtc7"),
    TARGET_STRING(""), 0, 1, 0, 1, 0 },

  { 35, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO3xx PCI Read"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 36, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO3xx PCI Read1"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 37, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO3xx PCI Read2"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  { 38, 0, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO3xx PCI Read3"),
    TARGET_STRING(""), 0, 3, 0, 0, 0 },

  {
    0, 0, (NULL), (NULL), 0, 0, 0, 0, 0
  }
};

static const rtwCAPI_BlockParameters rtBlockParameters[] = {
  /* addrMapIndex, blockPath,
   * paramName, dataTypeIndex, dimIndex, fixPtIdx
   */
  { 39, TARGET_STRING("Constant"),
    TARGET_STRING("Value"), 0, 0, 0 },

  { 40, TARGET_STRING("Constant1"),
    TARGET_STRING("Value"), 0, 0, 0 },

  { 41, TARGET_STRING("Constant2"),
    TARGET_STRING("Value"), 0, 0, 0 },

  { 42, TARGET_STRING("IO334_IO/Constant4"),
    TARGET_STRING("Value"), 1, 0, 1 },

  { 43, TARGET_STRING("IO334_IO/Constant5"),
    TARGET_STRING("Value"), 2, 0, 0 },

  { 44, TARGET_STRING("IO334_IO/Gain"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 45, TARGET_STRING("IO334_IO/Gain1"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 46, TARGET_STRING("IO334_IO/Gain2"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 47, TARGET_STRING("IO334_IO/Gain3"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 48, TARGET_STRING("IO334_IO/Gain4"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 49, TARGET_STRING("IO334_IO/Gain5"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 50, TARGET_STRING("IO334_IO/Gain6"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 51, TARGET_STRING("IO334_IO/Gain7"),
    TARGET_STRING("Gain"), 0, 0, 0 },

  { 52, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO334 A//D calibration"),
    TARGET_STRING("P1"), 0, 0, 0 },

  { 53, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO334 DAC Setup"),
    TARGET_STRING("P1"), 0, 0, 0 },

  { 54, TARGET_STRING("IO334_IO/IO334_IO_FPGA/IO334 DAC Setup"),
    TARGET_STRING("P2"), 0, 0, 0 },

  {
    0, (NULL), (NULL), 0, 0, 0
  }
};

/* Tunable variable parameters */
static const rtwCAPI_ModelParameters rtModelParameters[] = {
  /* addrMapIndex, varName, dataTypeIndex, dimIndex, fixPtIndex */
  { 0, (NULL), 0, 0, 0 }
};

#ifndef HOST_CAPI_BUILD

/* Declare Data Addresses statically */
static void* rtDataAddrMap[] = {
  &tf_Pb_Xi__SG_B.FromWorkspace1,      /* 0: Signal */
  &tf_Pb_Xi__SG_B.HighpassFilter.HighpassFilter2,/* 1: Signal */
  &tf_Pb_Xi__SG_B.HighpassFilter1.HighpassFilter2,/* 2: Signal */
  &tf_Pb_Xi__SG_B.HighpassFilter2.HighpassFilter2,/* 3: Signal */
  &tf_Pb_Xi__SG_B.HighpassFilter3,     /* 4: Signal */
  &tf_Pb_Xi__SG_B.Constant4,           /* 5: Signal */
  &tf_Pb_Xi__SG_B.Constant5,           /* 6: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion,  /* 7: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion1, /* 8: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion2, /* 9: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion3, /* 10: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion4, /* 11: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion5, /* 12: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion6, /* 13: Signal */
  &tf_Pb_Xi__SG_B.DataTypeConversion7, /* 14: Signal */
  &tf_Pb_Xi__SG_B.Gain,                /* 15: Signal */
  &tf_Pb_Xi__SG_B.Gain1,               /* 16: Signal */
  &tf_Pb_Xi__SG_B.Gain2,               /* 17: Signal */
  &tf_Pb_Xi__SG_B.Gain3,               /* 18: Signal */
  &tf_Pb_Xi__SG_B.Gain4,               /* 19: Signal */
  &tf_Pb_Xi__SG_B.Gain5,               /* 20: Signal */
  &tf_Pb_Xi__SG_B.Gain6,               /* 21: Signal */
  &tf_Pb_Xi__SG_B.Gain7,               /* 22: Signal */
  &tf_Pb_Xi__SG_B.RateTransition,      /* 23: Signal */
  &tf_Pb_Xi__SG_B.RateTransition1,     /* 24: Signal */
  &tf_Pb_Xi__SG_B.RateTransition2,     /* 25: Signal */
  &tf_Pb_Xi__SG_B.RateTransition3,     /* 26: Signal */
  &tf_Pb_Xi__SG_B.dtc,                 /* 27: Signal */
  &tf_Pb_Xi__SG_B.dtc1,                /* 28: Signal */
  &tf_Pb_Xi__SG_B.dtc2,                /* 29: Signal */
  &tf_Pb_Xi__SG_B.dtc3,                /* 30: Signal */
  &tf_Pb_Xi__SG_B.dtc4,                /* 31: Signal */
  &tf_Pb_Xi__SG_B.dtc5,                /* 32: Signal */
  &tf_Pb_Xi__SG_B.dtc6,                /* 33: Signal */
  &tf_Pb_Xi__SG_B.dtc7,                /* 34: Signal */
  &tf_Pb_Xi__SG_B.IO3xxPCIRead,        /* 35: Signal */
  &tf_Pb_Xi__SG_B.IO3xxPCIRead1,       /* 36: Signal */
  &tf_Pb_Xi__SG_B.IO3xxPCIRead2,       /* 37: Signal */
  &tf_Pb_Xi__SG_B.IO3xxPCIRead3,       /* 38: Signal */
  &tf_Pb_Xi__SG_P.Constant_Value,      /* 39: Block Parameter */
  &tf_Pb_Xi__SG_P.Constant1_Value,     /* 40: Block Parameter */
  &tf_Pb_Xi__SG_P.Constant2_Value,     /* 41: Block Parameter */
  &tf_Pb_Xi__SG_P.Constant4_Value,     /* 42: Block Parameter */
  &tf_Pb_Xi__SG_P.Constant5_Value,     /* 43: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain_Gain,           /* 44: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain1_Gain,          /* 45: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain2_Gain,          /* 46: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain3_Gain,          /* 47: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain4_Gain,          /* 48: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain5_Gain,          /* 49: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain6_Gain,          /* 50: Block Parameter */
  &tf_Pb_Xi__SG_P.Gain7_Gain,          /* 51: Block Parameter */
  &tf_Pb_Xi__SG_P.IO334ADcalibration_P1,/* 52: Block Parameter */
  &tf_Pb_Xi__SG_P.IO334DACSetup_P1,    /* 53: Block Parameter */
  &tf_Pb_Xi__SG_P.IO334DACSetup_P2,    /* 54: Block Parameter */
};

/* Declare Data Run-Time Dimension Buffer Addresses statically */
static int32_T* rtVarDimsAddrMap[] = {
  (NULL)
};

#endif

/* Data Type Map - use dataTypeMapIndex to access this structure */
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap[] = {
  /* cName, mwName, numElements, elemMapIndex, dataSize, slDataId, *
   * isComplex, isPointer, enumStorageType */
  { "double", "real_T", 0, 0, sizeof(real_T), SS_DOUBLE, 0, 0, 0 },

  { "short", "int16_T", 0, 0, sizeof(int16_T), SS_INT16, 0, 0, 0 },

  { "unsigned char", "boolean_T", 0, 0, sizeof(boolean_T), SS_BOOLEAN, 0, 0, 0 },

  { "unsigned int", "uint32_T", 0, 0, sizeof(uint32_T), SS_UINT32, 0, 0, 0 }
};

#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif

/* Structure Element Map - use elemMapIndex to access this structure */
static TARGET_CONST rtwCAPI_ElementMap rtElementMap[] = {
  /* elementName, elementOffset, dataTypeIndex, dimIndex, fxpIndex */
  { (NULL), 0, 0, 0, 0 },
};

/* Dimension Map - use dimensionMapIndex to access elements of ths structure*/
static const rtwCAPI_DimensionMap rtDimensionMap[] = {
  /* dataOrientation, dimArrayIndex, numDims, vardimsIndex */
  { rtwCAPI_SCALAR, 0, 2, 0 }
};

/* Dimension Array- use dimArrayIndex to access elements of this array */
static const uint_T rtDimensionArray[] = {
  1,                                   /* 0 */
  1                                    /* 1 */
};

/* C-API stores floating point values in an array. The elements of this  *
 * are unique. This ensures that values which are shared across the model*
 * are stored in the most efficient way. These values are referenced by  *
 *           - rtwCAPI_FixPtMap.fracSlopePtr,                            *
 *           - rtwCAPI_FixPtMap.biasPtr,                                 *
 *           - rtwCAPI_SampleTimeMap.samplePeriodPtr,                    *
 *           - rtwCAPI_SampleTimeMap.sampleOffsetPtr                     */
static const real_T rtcapiStoredFloats[] = {
  2.5E-5, 0.0, 1.0
};

/* Fixed Point Map */
static const rtwCAPI_FixPtMap rtFixPtMap[] = {
  /* fracSlopePtr, biasPtr, scaleType, wordLength, exponent, isSigned */
  { (NULL), (NULL), rtwCAPI_FIX_RESERVED, 0, 0, 0 },

  { (const void *) &rtcapiStoredFloats[2], (const void *) &rtcapiStoredFloats[1],
    rtwCAPI_FIX_UNIFORM_SCALING, 16, -8, 1 }
};

/* Sample Time Map - use sTimeIndex to access elements of ths structure */
static const rtwCAPI_SampleTimeMap rtSampleTimeMap[] = {
  /* samplePeriodPtr, sampleOffsetPtr, tid, samplingMode */
  { (const void *) &rtcapiStoredFloats[0], (const void *) &rtcapiStoredFloats[1],
    0, 0 }
};

static rtwCAPI_ModelMappingStaticInfo mmiStatic = {
  /* Signals:{signals, numSignals,
   *           rootInputs, numRootInputs,
   *           rootOutputs, numRootOutputs},
   * Params: {blockParameters, numBlockParameters,
   *          modelParameters, numModelParameters},
   * States: {states, numStates},
   * Maps:   {dataTypeMap, dimensionMap, fixPtMap,
   *          elementMap, sampleTimeMap, dimensionArray},
   * TargetType: targetType
   */
  { rtBlockSignals, 39,
    (NULL), 0,
    (NULL), 0 },

  { rtBlockParameters, 16,
    rtModelParameters, 0 },

  { (NULL), 0 },

  { rtDataTypeMap, rtDimensionMap, rtFixPtMap,
    rtElementMap, rtSampleTimeMap, rtDimensionArray },
  "float",

  { 603107226U,
    3724181030U,
    861066977U,
    4087190110U },
  (NULL), 0,
  0
};

/* Function to get C API Model Mapping Static Info */
const rtwCAPI_ModelMappingStaticInfo*
  tf_Pb_Xi__SG_GetCAPIStaticMap(void)
{
  return &mmiStatic;
}

/* Cache pointers into DataMapInfo substructure of RTModel */
#ifndef HOST_CAPI_BUILD

void tf_Pb_Xi__SG_InitializeDataMapInfo(void)
{
  /* Set C-API version */
  rtwCAPI_SetVersion(tf_Pb_Xi__SG_M->DataMapInfo.mmi, 1);

  /* Cache static C-API data into the Real-time Model Data structure */
  rtwCAPI_SetStaticMap(tf_Pb_Xi__SG_M->DataMapInfo.mmi, &mmiStatic);

  /* Cache static C-API logging data into the Real-time Model Data structure */
  rtwCAPI_SetLoggingStaticMap(tf_Pb_Xi__SG_M->DataMapInfo.mmi, (NULL));

  /* Cache C-API Data Addresses into the Real-Time Model Data structure */
  rtwCAPI_SetDataAddressMap(tf_Pb_Xi__SG_M->DataMapInfo.mmi, rtDataAddrMap);

  /* Cache C-API Data Run-Time Dimension Buffer Addresses into the Real-Time Model Data structure */
  rtwCAPI_SetVarDimsAddressMap(tf_Pb_Xi__SG_M->DataMapInfo.mmi, rtVarDimsAddrMap);

  /* Cache C-API rtp Address and size  into the Real-Time Model Data structure */
  tf_Pb_Xi__SG_M->DataMapInfo.mmi.InstanceMap.rtpAddress = rtmGetDefaultParam
    (tf_Pb_Xi__SG_M);
  tf_Pb_Xi__SG_M->DataMapInfo.mmi.staticMap->rtpSize = sizeof(P_tf_Pb_Xi__SG_T);

  /* Cache the instance C-API logging pointer */
  rtwCAPI_SetInstanceLoggingInfo(tf_Pb_Xi__SG_M->DataMapInfo.mmi, (NULL));

  /* Set reference to submodels */
  rtwCAPI_SetChildMMIArray(tf_Pb_Xi__SG_M->DataMapInfo.mmi, (NULL));
  rtwCAPI_SetChildMMIArrayLen(tf_Pb_Xi__SG_M->DataMapInfo.mmi, 0);
}

#else                                  /* HOST_CAPI_BUILD */
#ifdef __cplusplus

extern "C" {

#endif

  void tf_Pb_Xi__SG_host_InitializeDataMapInfo(tf_Pb_Xi__SG_host_DataMapInfo_T
    *dataMap, const char *path)
  {
    /* Set C-API version */
    rtwCAPI_SetVersion(dataMap->mmi, 1);

    /* Cache static C-API data into the Real-time Model Data structure */
    rtwCAPI_SetStaticMap(dataMap->mmi, &mmiStatic);

    /* host data address map is NULL */
    rtwCAPI_SetDataAddressMap(dataMap->mmi, NULL);

    /* host vardims address map is NULL */
    rtwCAPI_SetVarDimsAddressMap(dataMap->mmi, NULL);

    /* Set Instance specific path */
    rtwCAPI_SetPath(dataMap->mmi, path);
    rtwCAPI_SetFullPath(dataMap->mmi, NULL);

    /* Set reference to submodels */
    rtwCAPI_SetChildMMIArray(dataMap->mmi, (NULL));
    rtwCAPI_SetChildMMIArrayLen(dataMap->mmi, 0);
  }

#ifdef __cplusplus

}
#endif
#endif                                 /* HOST_CAPI_BUILD */

/* EOF: tf_Pb_Xi__SG_capi.c */
