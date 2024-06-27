#include "SG__MDL_cal.h"
#include "SG__MDL.h"

/* Storage class 'PageSwitching' */
SG__MDL_cal_type SG__MDL_cal_impl = {
  /* Variable: N_trig
   * Referenced by: '<Root>/Constant2'
   */
  32.0,

  /* Variable: freq_0
   * Referenced by: '<Root>/Constant5'
   */
  602.0,

  /* Variable: phi
   * Referenced by: '<Root>/Constant4'
   */
  { 0.0, 0.0 },

  /* Variable: rho
   * Referenced by: '<Root>/Constant1'
   */
  { 1.0, 1.0 },

  /* Variable: t_s
   * Referenced by: '<S3>/Constant'
   */
  5.0E-5,

  /* Variable: theta
   * Referenced by: '<Root>/Constant3'
   */
  { 3.1415926535897931, 0.0 },

  /* Variable: rec
   * Referenced by: '<Root>/rec'
   */
  false,

  /* Mask Parameter: HDLCounter_CountStep
   * Referenced by: '<S15>/Pos_step'
   */
  1.0,

  /* Mask Parameter: UnitDelayEnabledResettableSynch
   * Referenced by: '<S19>/Enabled Resettable Delay'
   */
  false,

  /* Mask Parameter: DetectRisePositive_vinit
   * Referenced by: '<S10>/Delay Input1'
   */
  false,

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

  /* Computed Parameter: Switch_wrap_Threshold
   * Referenced by: '<S16>/Switch_wrap'
   */
  (0L),

  /* Computed Parameter: Mod_value_Value
   * Referenced by: '<S16>/Mod_value'
   */
  (4294967296UL),

  /* Computed Parameter: Mod_value_Value_a
   * Referenced by: '<S14>/Mod_value'
   */
  (4294967296UL),

  /* Computed Parameter: Switch_wrap_Threshold_d
   * Referenced by: '<S14>/Switch_wrap'
   */
  (4294967295UL),

  /* Computed Parameter: Init_value_Value
   * Referenced by: '<S11>/Init_value'
   */
  1U,

  /* Computed Parameter: const_load_val_Value
   * Referenced by: '<S11>/const_load_val'
   */
  0U,

  /* Computed Parameter: From_value_Value
   * Referenced by: '<S11>/From_value'
   */
  1U,

  /* Computed Parameter: Constant_Value
   * Referenced by: '<S11>/Constant'
   */
  4294967295U,

  /* Computed Parameter: Count_reg_InitialCondition
   * Referenced by: '<S11>/Count_reg'
   */
  1U,

  /* Computed Parameter: Step_value_Value
   * Referenced by: '<S11>/Step_value'
   */
  1U,

  /* Expression:  freerun || modulo
   * Referenced by: '<S11>/Free_running_or_modulo'
   */
  true,

  /* Computed Parameter: const_load_Value
   * Referenced by: '<S11>/const_load'
   */
  false,

  /* Computed Parameter: Constant_Value_n
   * Referenced by: '<S13>/Constant'
   */
  false,

  /* Computed Parameter: const_dir_Value
   * Referenced by: '<S11>/const_dir'
   */
  true,

  /* Start of '<S3>/CoreSubsys' */
  {
    /* Expression: 1/1500
     * Referenced by: '<S3>/cntr_gain'
     */
    0.00066666666666666664,

    /* Expression: 1
     * Referenced by: '<S3>/Saturation'
     */
    1.0,

    /* Expression: 0
     * Referenced by: '<S3>/Saturation'
     */
    0.0,

    /* Mask Parameter: WrapToZero_Threshold
     * Referenced by: '<S9>/FixPt Switch'
     */
    4294967295U,

    /* Computed Parameter: Constant_Value
     * Referenced by: '<S9>/Constant'
     */
    0U,

    /* Computed Parameter: Output_InitialCondition
     * Referenced by: '<S7>/Output'
     */
    0U,

    /* Computed Parameter: FixPtConstant_Value
     * Referenced by: '<S8>/FixPt Constant'
     */
    1U
  }
  /* End of '<S3>/CoreSubsys' */
};

SG__MDL_cal_type *SG__MDL_cal = &SG__MDL_cal_impl;
