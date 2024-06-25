#include "SG__MDL_DMA_cal.h"
#include "SG__MDL_DMA.h"

/* Storage class 'PageSwitching' */
SG__MDL_DMA_cal_type SG__MDL_DMA_cal_impl = {
  /* Variable: freq_res
   * Referenced by:
   *   '<S1>/wb1_0'
   *   '<S1>/wb1_1'
   */
  602.0,

  /* Variable: wb1_theta
   * Referenced by:
   *   '<S1>/wb1_0'
   *   '<S1>/wb1_1'
   */
  0.0,

  /* Mask Parameter: WrapToZero_Threshold
   * Referenced by: '<S4>/FixPt Switch'
   */
  4294967295U,

  /* Expression: 0
   * Referenced by: '<S1>/signal'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<S1>/wb1_0'
   */
  0.0,

  /* Computed Parameter: wb1_0_Hsin
   * Referenced by: '<S1>/wb1_0'
   */
  0.18799846683964833,

  /* Computed Parameter: wb1_0_HCos
   * Referenced by: '<S1>/wb1_0'
   */
  0.98216932168844573,

  /* Computed Parameter: wb1_0_PSin
   * Referenced by: '<S1>/wb1_0'
   */
  -0.18799846683964833,

  /* Computed Parameter: wb1_0_PCos
   * Referenced by: '<S1>/wb1_0'
   */
  0.98216932168844573,

  /* Expression: 0
   * Referenced by: '<S1>/wb1_1'
   */
  0.0,

  /* Computed Parameter: wb1_1_Hsin
   * Referenced by: '<S1>/wb1_1'
   */
  0.36929265330873029,

  /* Computed Parameter: wb1_1_HCos
   * Referenced by: '<S1>/wb1_1'
   */
  0.92931315293188332,

  /* Computed Parameter: wb1_1_PSin
   * Referenced by: '<S1>/wb1_1'
   */
  0.36929265330873035,

  /* Computed Parameter: wb1_1_PCos
   * Referenced by: '<S1>/wb1_1'
   */
  -0.92931315293188332,

  /* Expression: 1/1500
   * Referenced by: '<S1>/cntr_gain'
   */
  0.00066666666666666664,

  /* Expression: 1
   * Referenced by: '<S1>/Saturation'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<S1>/Saturation'
   */
  0.0,

  /* Computed Parameter: setup_135_P1_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: boardType
   * Referenced by: '<Root>/setup_135'
   */
  135.0,

  /* Computed Parameter: setup_135_P2_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P3_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/setup_135'
   */
  -1.0,

  /* Computed Parameter: setup_135_P4_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parInterModuleSync
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P5_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 2.0 },

  /* Expression: parAdcChannels
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 2.0 },

  /* Computed Parameter: setup_135_P6_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 4.0 },

  /* Expression: parAdcVoltageRange
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: setup_135_P7_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 4.0 },

  /* Expression: parAdcOversamplRate
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: setup_135_P8_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcAutoCorrection
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P9_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcContSampling
   * Referenced by: '<Root>/setup_135'
   */
  0.0,

  /* Computed Parameter: setup_135_P10_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcDmaEnable
   * Referenced by: '<Root>/setup_135'
   */
  0.0,

  /* Computed Parameter: setup_135_P11_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 4.0 },

  /* Expression: parAdcActiveDmaDevices
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: setup_135_P12_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcFrameTriggerEnable
   * Referenced by: '<Root>/setup_135'
   */
  0.0,

  /* Computed Parameter: setup_135_P13_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcDmaClock
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P14_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcFrameSize
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P15_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 2.0 },

  /* Expression: parDacChannels
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 2.0 },

  /* Computed Parameter: setup_135_P16_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 16.0 },

  /* Expression: parDacVoltageRange
   * Referenced by: '<Root>/setup_135'
   */
  { 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0,
    4.0 },

  /* Computed Parameter: setup_135_P17_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacAutoCorrection
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P18_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacSyncOut
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P19_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaEnable
   * Referenced by: '<Root>/setup_135'
   */
  0.0,

  /* Computed Parameter: setup_135_P20_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 4.0 },

  /* Expression: parDacActiveDmaDevices
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: setup_135_P21_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacFrameTriggerEnable
   * Referenced by: '<Root>/setup_135'
   */
  0.0,

  /* Computed Parameter: setup_135_P22_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaClock
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P23_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaLatency
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P24_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDacFrameSize
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P25_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock1BaseRate
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P26_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock1Divider
   * Referenced by: '<Root>/setup_135'
   */
  700.0,

  /* Computed Parameter: setup_135_P27_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock2BaseRate
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P28_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock2Divider
   * Referenced by: '<Root>/setup_135'
   */
  700.0,

  /* Computed Parameter: setup_135_P29_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parFrameTriggerClock
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Computed Parameter: setup_135_P30_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parFrameTriggerDivider
   * Referenced by: '<Root>/setup_135'
   */
  10.0,

  /* Computed Parameter: setup_135_P31_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 0.0, 0.0 },

  /* Computed Parameter: setup_135_P32_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 0.0, 0.0 },

  /* Computed Parameter: setup_135_P33_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDiDebounceValue
   * Referenced by: '<Root>/setup_135'
   */
  0.0,

  /* Computed Parameter: setup_135_P34_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDioPullRefFront
   * Referenced by: '<Root>/setup_135'
   */
  3.0,

  /* Computed Parameter: setup_135_P35_Size
   * Referenced by: '<Root>/setup_135'
   */
  { 1.0, 1.0 },

  /* Expression: parDioPullRefRear
   * Referenced by: '<Root>/setup_135'
   */
  1.0,

  /* Expression: 1
   * Referenced by: '<Root>/Constant'
   */
  1.0,

  /* Computed Parameter: ao_2_P1_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: boardType
   * Referenced by: '<Root>/ao_2'
   */
  135.0,

  /* Computed Parameter: ao_2_P2_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/ao_2'
   */
  1.0,

  /* Computed Parameter: ao_2_P3_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/ao_2'
   */
  -1.0,

  /* Computed Parameter: ao_2_P4_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parSampleTime
   * Referenced by: '<Root>/ao_2'
   */
  -1.0,

  /* Computed Parameter: ao_2_P5_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 2.0 },

  /* Expression: parDacChannels
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 2.0 },

  /* Computed Parameter: ao_2_P6_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 16.0 },

  /* Expression: parDacVoltageRange
   * Referenced by: '<Root>/ao_2'
   */
  { 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0, 4.0,
    4.0 },

  /* Computed Parameter: ao_2_P7_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 2.0 },

  /* Expression: parDacInitValues
   * Referenced by: '<Root>/ao_2'
   */
  { 0.0, 0.0 },

  /* Computed Parameter: ao_2_P8_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 2.0 },

  /* Expression: parDacReset
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Computed Parameter: ao_2_P9_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parDacSyncOut
   * Referenced by: '<Root>/ao_2'
   */
  1.0,

  /* Computed Parameter: ao_2_P10_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaEnable
   * Referenced by: '<Root>/ao_2'
   */
  0.0,

  /* Computed Parameter: ao_2_P11_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 4.0 },

  /* Expression: parDacActiveDmaDevices
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: ao_2_P12_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaLatency
   * Referenced by: '<Root>/ao_2'
   */
  1.0,

  /* Computed Parameter: ao_2_P13_Size
   * Referenced by: '<Root>/ao_2'
   */
  { 1.0, 1.0 },

  /* Expression: parDacFrameSize
   * Referenced by: '<Root>/ao_2'
   */
  1.0,

  /* Computed Parameter: ai_135_P1_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: boardType
   * Referenced by: '<Root>/ai_135'
   */
  135.0,

  /* Computed Parameter: ai_135_P2_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/ai_135'
   */
  1.0,

  /* Computed Parameter: ai_135_P3_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/ai_135'
   */
  -1.0,

  /* Computed Parameter: ai_135_P4_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: parSampleTime
   * Referenced by: '<Root>/ai_135'
   */
  -1.0,

  /* Computed Parameter: ai_135_P5_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 2.0 },

  /* Expression: parAdcChannels
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 2.0 },

  /* Computed Parameter: ai_135_P6_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 4.0 },

  /* Expression: parAdcVoltageRange
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: ai_135_P7_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 4.0 },

  /* Expression: parAdcOversamplRate
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: ai_135_P8_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcContSampling
   * Referenced by: '<Root>/ai_135'
   */
  0.0,

  /* Computed Parameter: ai_135_P9_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcDmaEnable
   * Referenced by: '<Root>/ai_135'
   */
  0.0,

  /* Computed Parameter: ai_135_P10_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 4.0 },

  /* Expression: parAdcActiveDmaDevices
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: ai_135_P11_Size
   * Referenced by: '<Root>/ai_135'
   */
  { 1.0, 1.0 },

  /* Expression: parAdcFrameSize
   * Referenced by: '<Root>/ai_135'
   */
  1.0,

  /* Computed Parameter: Constant_Value_n
   * Referenced by: '<S4>/Constant'
   */
  0U,

  /* Computed Parameter: Output_InitialCondition
   * Referenced by: '<S2>/Output'
   */
  0U,

  /* Computed Parameter: FixPtConstant_Value
   * Referenced by: '<S3>/FixPt Constant'
   */
  1U
};

SG__MDL_DMA_cal_type *SG__MDL_DMA_cal = &SG__MDL_DMA_cal_impl;
