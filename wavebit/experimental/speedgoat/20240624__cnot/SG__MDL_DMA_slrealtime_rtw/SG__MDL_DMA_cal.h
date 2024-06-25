#ifndef RTW_HEADER_SG__MDL_DMA_cal_h_
#define RTW_HEADER_SG__MDL_DMA_cal_h_
#include "rtwtypes.h"

/* Storage class 'PageSwitching', for system '<Root>' */
struct SG__MDL_DMA_cal_type {
  real_T freq_res;                     /* Variable: freq_res
                                        * Referenced by:
                                        *   '<S1>/wb1_0'
                                        *   '<S1>/wb1_1'
                                        */
  real_T wb1_theta;                    /* Variable: wb1_theta
                                        * Referenced by:
                                        *   '<S1>/wb1_0'
                                        *   '<S1>/wb1_1'
                                        */
  uint32_T WrapToZero_Threshold;       /* Mask Parameter: WrapToZero_Threshold
                                        * Referenced by: '<S4>/FixPt Switch'
                                        */
  real_T signal_Y0;                    /* Expression: 0
                                        * Referenced by: '<S1>/signal'
                                        */
  real_T wb1_0_Bias;                   /* Expression: 0
                                        * Referenced by: '<S1>/wb1_0'
                                        */
  real_T wb1_0_Hsin;                   /* Computed Parameter: wb1_0_Hsin
                                        * Referenced by: '<S1>/wb1_0'
                                        */
  real_T wb1_0_HCos;                   /* Computed Parameter: wb1_0_HCos
                                        * Referenced by: '<S1>/wb1_0'
                                        */
  real_T wb1_0_PSin;                   /* Computed Parameter: wb1_0_PSin
                                        * Referenced by: '<S1>/wb1_0'
                                        */
  real_T wb1_0_PCos;                   /* Computed Parameter: wb1_0_PCos
                                        * Referenced by: '<S1>/wb1_0'
                                        */
  real_T wb1_1_Bias;                   /* Expression: 0
                                        * Referenced by: '<S1>/wb1_1'
                                        */
  real_T wb1_1_Hsin;                   /* Computed Parameter: wb1_1_Hsin
                                        * Referenced by: '<S1>/wb1_1'
                                        */
  real_T wb1_1_HCos;                   /* Computed Parameter: wb1_1_HCos
                                        * Referenced by: '<S1>/wb1_1'
                                        */
  real_T wb1_1_PSin;                   /* Computed Parameter: wb1_1_PSin
                                        * Referenced by: '<S1>/wb1_1'
                                        */
  real_T wb1_1_PCos;                   /* Computed Parameter: wb1_1_PCos
                                        * Referenced by: '<S1>/wb1_1'
                                        */
  real_T cntr_gain_Gain;               /* Expression: 1/1500
                                        * Referenced by: '<S1>/cntr_gain'
                                        */
  real_T Saturation_UpperSat;          /* Expression: 1
                                        * Referenced by: '<S1>/Saturation'
                                        */
  real_T Saturation_LowerSat;          /* Expression: 0
                                        * Referenced by: '<S1>/Saturation'
                                        */
  real_T setup_135_P1_Size[2];         /* Computed Parameter: setup_135_P1_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P1;                 /* Expression: boardType
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P2_Size[2];         /* Computed Parameter: setup_135_P2_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P2;                 /* Expression: parModuleId
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P3_Size[2];         /* Computed Parameter: setup_135_P3_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P3;                 /* Expression: parPciSlot
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P4_Size[2];         /* Computed Parameter: setup_135_P4_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P4;                 /* Expression: parInterModuleSync
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P5_Size[2];         /* Computed Parameter: setup_135_P5_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P5[2];              /* Expression: parAdcChannels
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P6_Size[2];         /* Computed Parameter: setup_135_P6_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P6[4];              /* Expression: parAdcVoltageRange
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P7_Size[2];         /* Computed Parameter: setup_135_P7_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P7[4];              /* Expression: parAdcOversamplRate
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P8_Size[2];         /* Computed Parameter: setup_135_P8_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P8;                 /* Expression: parAdcAutoCorrection
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P9_Size[2];         /* Computed Parameter: setup_135_P9_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P9;                 /* Expression: parAdcContSampling
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P10_Size[2];        /* Computed Parameter: setup_135_P10_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P10;                /* Expression: parAdcDmaEnable
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P11_Size[2];        /* Computed Parameter: setup_135_P11_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P11[4];             /* Expression: parAdcActiveDmaDevices
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P12_Size[2];        /* Computed Parameter: setup_135_P12_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P12;                /* Expression: parAdcFrameTriggerEnable
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P13_Size[2];        /* Computed Parameter: setup_135_P13_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P13;                /* Expression: parAdcDmaClock
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P14_Size[2];        /* Computed Parameter: setup_135_P14_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P14;                /* Expression: parAdcFrameSize
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P15_Size[2];        /* Computed Parameter: setup_135_P15_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P15[2];             /* Expression: parDacChannels
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P16_Size[2];        /* Computed Parameter: setup_135_P16_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P16[16];            /* Expression: parDacVoltageRange
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P17_Size[2];        /* Computed Parameter: setup_135_P17_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P17;                /* Expression: parDacAutoCorrection
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P18_Size[2];        /* Computed Parameter: setup_135_P18_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P18;                /* Expression: parDacSyncOut
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P19_Size[2];        /* Computed Parameter: setup_135_P19_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P19;                /* Expression: parDacDmaEnable
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P20_Size[2];        /* Computed Parameter: setup_135_P20_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P20[4];             /* Expression: parDacActiveDmaDevices
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P21_Size[2];        /* Computed Parameter: setup_135_P21_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P21;                /* Expression: parDacFrameTriggerEnable
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P22_Size[2];        /* Computed Parameter: setup_135_P22_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P22;                /* Expression: parDacDmaClock
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P23_Size[2];        /* Computed Parameter: setup_135_P23_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P23;                /* Expression: parDacDmaLatency
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P24_Size[2];        /* Computed Parameter: setup_135_P24_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P24;                /* Expression: parDacFrameSize
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P25_Size[2];        /* Computed Parameter: setup_135_P25_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P25;                /* Expression: parConvClock1BaseRate
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P26_Size[2];        /* Computed Parameter: setup_135_P26_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P26;                /* Expression: parConvClock1Divider
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P27_Size[2];        /* Computed Parameter: setup_135_P27_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P27;                /* Expression: parConvClock2BaseRate
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P28_Size[2];        /* Computed Parameter: setup_135_P28_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P28;                /* Expression: parConvClock2Divider
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P29_Size[2];        /* Computed Parameter: setup_135_P29_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P29;                /* Expression: parFrameTriggerClock
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P30_Size[2];        /* Computed Parameter: setup_135_P30_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P30;                /* Expression: parFrameTriggerDivider
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P31_Size[2];        /* Computed Parameter: setup_135_P31_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P32_Size[2];        /* Computed Parameter: setup_135_P32_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P33_Size[2];        /* Computed Parameter: setup_135_P33_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P33;                /* Expression: parDiDebounceValue
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P34_Size[2];        /* Computed Parameter: setup_135_P34_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P34;                /* Expression: parDioPullRefFront
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P35_Size[2];        /* Computed Parameter: setup_135_P35_Size
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T setup_135_P35;                /* Expression: parDioPullRefRear
                                        * Referenced by: '<Root>/setup_135'
                                        */
  real_T Constant_Value;               /* Expression: 1
                                        * Referenced by: '<Root>/Constant'
                                        */
  real_T ao_2_P1_Size[2];              /* Computed Parameter: ao_2_P1_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P1;                      /* Expression: boardType
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P2_Size[2];              /* Computed Parameter: ao_2_P2_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P2;                      /* Expression: parModuleId
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P3_Size[2];              /* Computed Parameter: ao_2_P3_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P3;                      /* Expression: parPciSlot
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P4_Size[2];              /* Computed Parameter: ao_2_P4_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P4;                      /* Expression: parSampleTime
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P5_Size[2];              /* Computed Parameter: ao_2_P5_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P5[2];                   /* Expression: parDacChannels
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P6_Size[2];              /* Computed Parameter: ao_2_P6_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P6[16];                  /* Expression: parDacVoltageRange
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P7_Size[2];              /* Computed Parameter: ao_2_P7_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P7[2];                   /* Expression: parDacInitValues
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P8_Size[2];              /* Computed Parameter: ao_2_P8_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P8[2];                   /* Expression: parDacReset
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P9_Size[2];              /* Computed Parameter: ao_2_P9_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P9;                      /* Expression: parDacSyncOut
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P10_Size[2];             /* Computed Parameter: ao_2_P10_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P10;                     /* Expression: parDacDmaEnable
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P11_Size[2];             /* Computed Parameter: ao_2_P11_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P11[4];                  /* Expression: parDacActiveDmaDevices
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P12_Size[2];             /* Computed Parameter: ao_2_P12_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P12;                     /* Expression: parDacDmaLatency
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P13_Size[2];             /* Computed Parameter: ao_2_P13_Size
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ao_2_P13;                     /* Expression: parDacFrameSize
                                        * Referenced by: '<Root>/ao_2'
                                        */
  real_T ai_135_P1_Size[2];            /* Computed Parameter: ai_135_P1_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P1;                    /* Expression: boardType
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P2_Size[2];            /* Computed Parameter: ai_135_P2_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P2;                    /* Expression: parModuleId
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P3_Size[2];            /* Computed Parameter: ai_135_P3_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P3;                    /* Expression: parPciSlot
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P4_Size[2];            /* Computed Parameter: ai_135_P4_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P4;                    /* Expression: parSampleTime
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P5_Size[2];            /* Computed Parameter: ai_135_P5_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P5[2];                 /* Expression: parAdcChannels
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P6_Size[2];            /* Computed Parameter: ai_135_P6_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P6[4];                 /* Expression: parAdcVoltageRange
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P7_Size[2];            /* Computed Parameter: ai_135_P7_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P7[4];                 /* Expression: parAdcOversamplRate
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P8_Size[2];            /* Computed Parameter: ai_135_P8_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P8;                    /* Expression: parAdcContSampling
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P9_Size[2];            /* Computed Parameter: ai_135_P9_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P9;                    /* Expression: parAdcDmaEnable
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P10_Size[2];           /* Computed Parameter: ai_135_P10_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P10[4];                /* Expression: parAdcActiveDmaDevices
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P11_Size[2];           /* Computed Parameter: ai_135_P11_Size
                                        * Referenced by: '<Root>/ai_135'
                                        */
  real_T ai_135_P11;                   /* Expression: parAdcFrameSize
                                        * Referenced by: '<Root>/ai_135'
                                        */
  uint32_T Constant_Value_n;           /* Computed Parameter: Constant_Value_n
                                        * Referenced by: '<S4>/Constant'
                                        */
  uint32_T Output_InitialCondition;
                                  /* Computed Parameter: Output_InitialCondition
                                   * Referenced by: '<S2>/Output'
                                   */
  uint32_T FixPtConstant_Value;       /* Computed Parameter: FixPtConstant_Value
                                       * Referenced by: '<S3>/FixPt Constant'
                                       */
};

/* Storage class 'PageSwitching' */
extern SG__MDL_DMA_cal_type SG__MDL_DMA_cal_impl;
extern SG__MDL_DMA_cal_type *SG__MDL_DMA_cal;

#endif                                 /* RTW_HEADER_SG__MDL_DMA_cal_h_ */
