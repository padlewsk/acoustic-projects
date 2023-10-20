#include "SG__DMA_test_cal.h"
#include "SG__DMA_test.h"

/* Storage class 'PageSwitching' */
SG__DMA_test_cal_type SG__DMA_test_cal_impl = {
  /* Mask Parameter: Chirp_Tsweep
   * Referenced by: '<Root>/Chirp'
   */
  2.0,

  /* Mask Parameter: Chirp_f0
   * Referenced by: '<Root>/Chirp'
   */
  1.0,

  /* Mask Parameter: Chirp_f1
   * Referenced by: '<Root>/Chirp'
   */
  1000.0,

  /* Mask Parameter: Chirp_phase
   * Referenced by: '<Root>/Chirp'
   */
  0.0,

  /* Mask Parameter: Chirp_t1
   * Referenced by: '<Root>/Chirp'
   */
  2.0,

  /* Expression: 1
   * Referenced by: '<S1>/Gain1'
   */
  1.0,

  /* Expression: 2
   * Referenced by: '<S1>/Gain4'
   */
  2.0,

  /* Computed Parameter: IO135_AnalogOutput_P1_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: boardType
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  135.0,

  /* Computed Parameter: IO135_AnalogOutput_P2_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  1.0,

  /* Computed Parameter: IO135_AnalogOutput_P3_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  -1.0,

  /* Computed Parameter: IO135_AnalogOutput_P4_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parSampleTime
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  -1.0,

  /* Computed Parameter: IO135_AnalogOutput_P5_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 2.0 },

  /* Expression: parDacChannels
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 2.0 },

  /* Computed Parameter: IO135_AnalogOutput_P6_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 16.0 },

  /* Expression: parDacVoltageRange
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0,
    5.0 },

  /* Computed Parameter: IO135_AnalogOutput_P7_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 2.0 },

  /* Expression: parDacInitValues
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 0.0, 0.0 },

  /* Computed Parameter: IO135_AnalogOutput_P8_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 2.0 },

  /* Expression: parDacReset
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Computed Parameter: IO135_AnalogOutput_P9_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parDacSyncOut
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  1.0,

  /* Computed Parameter: IO135_AnalogOutput_P10_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaEnable
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  1.0,

  /* Computed Parameter: IO135_AnalogOutput_P11_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 4.0 },

  /* Expression: parDacActiveDmaDevices
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: IO135_AnalogOutput_P12_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaLatency
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  2.0,

  /* Computed Parameter: IO135_AnalogOutput_P13_Size
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  { 1.0, 1.0 },

  /* Expression: parDacFrameSize
   * Referenced by: '<S1>/IO135_AnalogOutput '
   */
  1.0,

  /* Computed Parameter: IO135_AnalogInput_P1_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: boardType
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  135.0,

  /* Computed Parameter: IO135_AnalogInput_P2_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  1.0,

  /* Computed Parameter: IO135_AnalogInput_P3_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  -1.0,

  /* Computed Parameter: IO135_AnalogInput_P4_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: parSampleTime
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  -1.0,

  /* Computed Parameter: IO135_AnalogInput_P5_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 2.0 },

  /* Expression: parAdcChannels
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 2.0 },

  /* Computed Parameter: IO135_AnalogInput_P6_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 4.0 },

  /* Expression: parAdcVoltageRange
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 2.0, 2.0, 2.0, 2.0 },

  /* Computed Parameter: IO135_AnalogInput_P7_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 4.0 },

  /* Expression: parAdcOversamplRate
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: IO135_AnalogInput_P8_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcContSampling
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  0.0,

  /* Computed Parameter: IO135_AnalogInput_P9_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcDmaEnable
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  1.0,

  /* Computed Parameter: IO135_AnalogInput_P10_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 4.0 },

  /* Expression: parAdcActiveDmaDevices
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: IO135_AnalogInput_P11_Size
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcFrameSize
   * Referenced by: '<S1>/IO135_AnalogInput '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P1_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: boardType
   * Referenced by: '<Root>/IO135_Setup '
   */
  135.0,

  /* Computed Parameter: IO135_Setup_P2_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P3_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/IO135_Setup '
   */
  -1.0,

  /* Computed Parameter: IO135_Setup_P4_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parInterModuleSync
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P5_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 2.0 },

  /* Expression: parAdcChannels
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 2.0 },

  /* Computed Parameter: IO135_Setup_P6_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 4.0 },

  /* Expression: parAdcVoltageRange
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 2.0, 2.0, 2.0, 2.0 },

  /* Computed Parameter: IO135_Setup_P7_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 4.0 },

  /* Expression: parAdcOversamplRate
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: IO135_Setup_P8_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcAutoCorrection
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P9_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcContSampling
   * Referenced by: '<Root>/IO135_Setup '
   */
  0.0,

  /* Computed Parameter: IO135_Setup_P10_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcDmaEnable
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P11_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 4.0 },

  /* Expression: parAdcActiveDmaDevices
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: IO135_Setup_P12_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcFrameTriggerEnable
   * Referenced by: '<Root>/IO135_Setup '
   */
  0.0,

  /* Computed Parameter: IO135_Setup_P13_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcDmaClock
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P14_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parAdcFrameSize
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P15_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 2.0 },

  /* Expression: parDacChannels
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 2.0 },

  /* Computed Parameter: IO135_Setup_P16_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 16.0 },

  /* Expression: parDacVoltageRange
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0, 5.0,
    5.0 },

  /* Computed Parameter: IO135_Setup_P17_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacAutoCorrection
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P18_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacSyncOut
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P19_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaEnable
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P20_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 4.0 },

  /* Expression: parDacActiveDmaDevices
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0, 1.0, 1.0 },

  /* Computed Parameter: IO135_Setup_P21_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacFrameTriggerEnable
   * Referenced by: '<Root>/IO135_Setup '
   */
  0.0,

  /* Computed Parameter: IO135_Setup_P22_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaClock
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P23_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacDmaLatency
   * Referenced by: '<Root>/IO135_Setup '
   */
  2.0,

  /* Computed Parameter: IO135_Setup_P24_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDacFrameSize
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P25_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock1BaseRate
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P26_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock1Divider
   * Referenced by: '<Root>/IO135_Setup '
   */
  700.0,

  /* Computed Parameter: IO135_Setup_P27_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock2BaseRate
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P28_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parConvClock2Divider
   * Referenced by: '<Root>/IO135_Setup '
   */
  700.0,

  /* Computed Parameter: IO135_Setup_P29_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parFrameTriggerClock
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P30_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parFrameTriggerDivider
   * Referenced by: '<Root>/IO135_Setup '
   */
  10.0,

  /* Computed Parameter: IO135_Setup_P31_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDoChannels
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: IO135_Setup_P32_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDiChannels
   * Referenced by: '<Root>/IO135_Setup '
   */
  5.0,

  /* Computed Parameter: IO135_Setup_P33_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDiDebounceValue
   * Referenced by: '<Root>/IO135_Setup '
   */
  0.0,

  /* Computed Parameter: IO135_Setup_P34_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDioPullRefFront
   * Referenced by: '<Root>/IO135_Setup '
   */
  3.0,

  /* Computed Parameter: IO135_Setup_P35_Size
   * Referenced by: '<Root>/IO135_Setup '
   */
  { 1.0, 1.0 },

  /* Expression: parDioPullRefRear
   * Referenced by: '<Root>/IO135_Setup '
   */
  1.0,

  /* Computed Parameter: Setupv2_P1_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/Setup (v2) '
   */
  -1.0,

  /* Computed Parameter: Setupv2_P2_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTriggerInitiator
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P3_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTriggerRate
   * Referenced by: '<Root>/Setup (v2) '
   */
  3.499503968E-5,

  /* Computed Parameter: Setupv2_P4_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parCalibrate
   * Referenced by: '<Root>/Setup (v2) '
   */
  0.0,

  /* Computed Parameter: Setupv2_P5_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdChannels
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P6_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdRange1
   * Referenced by: '<Root>/Setup (v2) '
   */
  2.0,

  /* Computed Parameter: Setupv2_P7_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdRange2
   * Referenced by: '<Root>/Setup (v2) '
   */
  2.0,

  /* Computed Parameter: Setupv2_P8_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdCoupling
   * Referenced by: '<Root>/Setup (v2) '
   */
  2.0,

  /* Computed Parameter: Setupv2_P9_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdUseTrigger
   * Referenced by: '<Root>/Setup (v2) '
   */
  0.0,

  /* Computed Parameter: Setupv2_P10_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdFrameSize
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P11_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdClockInitiator
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P12_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdSampleTime
   * Referenced by: '<Root>/Setup (v2) '
   */
  3.499503968E-5,

  /* Computed Parameter: Setupv2_P13_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaChannels
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P14_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaChannelsSorted
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P15_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaInitValue
   * Referenced by: '<Root>/Setup (v2) '
   */
  0.0,

  /* Computed Parameter: Setupv2_P16_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaReset
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P17_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaRange
   * Referenced by: '<Root>/Setup (v2) '
   */
  2.0,

  /* Computed Parameter: Setupv2_P18_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaUseTrigger
   * Referenced by: '<Root>/Setup (v2) '
   */
  0.0,

  /* Computed Parameter: Setupv2_P19_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaFrameSize
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P20_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaClockInitiator
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P21_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaSampleTime
   * Referenced by: '<Root>/Setup (v2) '
   */
  3.499503968E-5,

  /* Computed Parameter: Setupv2_P22_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaSimultaneous
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P23_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDioByte0Dir
   * Referenced by: '<Root>/Setup (v2) '
   */
  2.0,

  /* Computed Parameter: Setupv2_P24_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDioByte1Dir
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P25_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 4.0 },

  /* Expression: parDoChannels
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 2.0, 3.0, 4.0 },

  /* Computed Parameter: Setupv2_P26_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDoInitValues
   * Referenced by: '<Root>/Setup (v2) '
   */
  0.0,

  /* Computed Parameter: Setupv2_P27_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDoReset
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Setupv2_P28_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 4.0 },

  /* Expression: parDiChannels
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 13.0, 14.0, 15.0, 16.0 },

  /* Computed Parameter: Setupv2_P29_Size
   * Referenced by: '<Root>/Setup (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/Setup (v2) '
   */
  1.0,

  /* Computed Parameter: Analoginputv2_P1_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/Analog input (v2) '
   */
  -1.0,

  /* Computed Parameter: Analoginputv2_P2_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTs
   * Referenced by: '<Root>/Analog input (v2) '
   */
  5.0E-5,

  /* Computed Parameter: Analoginputv2_P3_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTriggerInitiator
   * Referenced by: '<Root>/Analog input (v2) '
   */
  1.0,

  /* Computed Parameter: Analoginputv2_P4_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTriggerRate
   * Referenced by: '<Root>/Analog input (v2) '
   */
  -1.0,

  /* Computed Parameter: Analoginputv2_P5_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdChannels
   * Referenced by: '<Root>/Analog input (v2) '
   */
  1.0,

  /* Computed Parameter: Analoginputv2_P6_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdChannelsSorted
   * Referenced by: '<Root>/Analog input (v2) '
   */
  1.0,

  /* Computed Parameter: Analoginputv2_P7_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdRange1
   * Referenced by: '<Root>/Analog input (v2) '
   */
  2.0,

  /* Computed Parameter: Analoginputv2_P8_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdRange2
   * Referenced by: '<Root>/Analog input (v2) '
   */
  2.0,

  /* Computed Parameter: Analoginputv2_P9_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdCoupling
   * Referenced by: '<Root>/Analog input (v2) '
   */
  2.0,

  /* Computed Parameter: Analoginputv2_P10_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdUseTrigger
   * Referenced by: '<Root>/Analog input (v2) '
   */
  0.0,

  /* Computed Parameter: Analoginputv2_P11_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdFrameSize
   * Referenced by: '<Root>/Analog input (v2) '
   */
  1.0,

  /* Computed Parameter: Analoginputv2_P12_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdClockInitiator
   * Referenced by: '<Root>/Analog input (v2) '
   */
  1.0,

  /* Computed Parameter: Analoginputv2_P13_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdSampleTime
   * Referenced by: '<Root>/Analog input (v2) '
   */
  3.499503968E-5,

  /* Computed Parameter: Analoginputv2_P14_Size
   * Referenced by: '<Root>/Analog input (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/Analog input (v2) '
   */
  1.0,

  /* Expression: 0.025
   * Referenced by: '<Root>/Gain'
   */
  0.025,

  /* Computed Parameter: Analogoutputv2_P1_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parPciSlot
   * Referenced by: '<Root>/Analog output (v2) '
   */
  -1.0,

  /* Computed Parameter: Analogoutputv2_P2_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTs
   * Referenced by: '<Root>/Analog output (v2) '
   */
  5.0E-5,

  /* Computed Parameter: Analogoutputv2_P3_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTriggerInitiator
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P4_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parTriggerRate
   * Referenced by: '<Root>/Analog output (v2) '
   */
  -1.0,

  /* Computed Parameter: Analogoutputv2_P5_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaChannels
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P6_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaChannelsSorted
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P7_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaInitValue
   * Referenced by: '<Root>/Analog output (v2) '
   */
  0.0,

  /* Computed Parameter: Analogoutputv2_P8_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaReset
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P9_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaRange
   * Referenced by: '<Root>/Analog output (v2) '
   */
  2.0,

  /* Computed Parameter: Analogoutputv2_P10_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaUseTrigger
   * Referenced by: '<Root>/Analog output (v2) '
   */
  0.0,

  /* Computed Parameter: Analogoutputv2_P11_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaFrameSize
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P12_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaSampleTime
   * Referenced by: '<Root>/Analog output (v2) '
   */
  3.499503968E-5,

  /* Computed Parameter: Analogoutputv2_P13_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parAdBlockPresent
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P14_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parModuleId
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Computed Parameter: Analogoutputv2_P15_Size
   * Referenced by: '<Root>/Analog output (v2) '
   */
  { 1.0, 1.0 },

  /* Expression: parDaSimultaneous
   * Referenced by: '<Root>/Analog output (v2) '
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<Root>/Rate Transition'
   */
  0.0
};

SG__DMA_test_cal_type *SG__DMA_test_cal = &SG__DMA_test_cal_impl;
