#ifndef RTW_HEADER_SG__MDL_cal_h_
#define RTW_HEADER_SG__MDL_cal_h_
#include "rtwtypes.h"

/* Storage class 'PageSwitching', for system '<Root>/Subsystem' */
struct SG__MDL_Subsystem_cal_type {
  real_T SineWave2_Amp;                /* Expression: 1
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T SineWave2_Bias;               /* Expression: 0
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T SineWave2_Freq;               /* Expression: 2*pi*10
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T SineWave2_Hsin;               /* Computed Parameter: SineWave2_Hsin
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T SineWave2_HCos;               /* Computed Parameter: SineWave2_HCos
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T SineWave2_PSin;               /* Computed Parameter: SineWave2_PSin
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T SineWave2_PCos;               /* Computed Parameter: SineWave2_PCos
                                        * Referenced by: '<S1>/Sine Wave2'
                                        */
  real_T Multiply2_Gain;               /* Expression: 0.5
                                        * Referenced by: '<S1>/Multiply2'
                                        */
};

/* Storage class 'PageSwitching', for system '<Root>' */
struct SG__MDL_cal_type {
  SG__MDL_Subsystem_cal_type SG__MDL_Subsystem3_cal;/* '<Root>/Subsystem3' */
  SG__MDL_Subsystem_cal_type SG__MDL_Subsystem2_cal;/* '<Root>/Subsystem2' */
  SG__MDL_Subsystem_cal_type SG__MDL_Subsystem1_cal;/* '<Root>/Subsystem1' */
  SG__MDL_Subsystem_cal_type SG__MDL_Subsystem_cal;/* '<Root>/Subsystem' */
};

/* Storage class 'PageSwitching' */
extern SG__MDL_cal_type SG__MDL_cal_impl;
extern SG__MDL_cal_type *SG__MDL_cal;

#endif                                 /* RTW_HEADER_SG__MDL_cal_h_ */
