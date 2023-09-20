#include "SG__MDL_cal.h"
#include "SG__MDL.h"

/* Storage class 'PageSwitching' */
SG__MDL_cal_type SG__MDL_cal_impl = {
  /* Start of '<Root>/Subsystem3' */
  {
    /* Expression: 1
     * Referenced by: '<S4>/Sine Wave2'
     */
    1.0,

    /* Expression: 0
     * Referenced by: '<S4>/Sine Wave2'
     */
    0.0,

    /* Expression: 2*pi*10
     * Referenced by: '<S4>/Sine Wave2'
     */
    62.831853071795862,

    /* Computed Parameter: SineWave2_Hsin
     * Referenced by: '<S4>/Sine Wave2'
     */
    0.0062831439655589511,

    /* Computed Parameter: SineWave2_HCos
     * Referenced by: '<S4>/Sine Wave2'
     */
    0.99998026085613712,

    /* Computed Parameter: SineWave2_PSin
     * Referenced by: '<S4>/Sine Wave2'
     */
    -0.0062831439655589511,

    /* Computed Parameter: SineWave2_PCos
     * Referenced by: '<S4>/Sine Wave2'
     */
    0.99998026085613712,

    /* Expression: 2
     * Referenced by: '<S4>/Multiply2'
     */
    2.0
  }
  ,

  /* End of '<Root>/Subsystem3' */

  /* Start of '<Root>/Subsystem2' */
  {
    /* Expression: 1
     * Referenced by: '<S3>/Sine Wave2'
     */
    1.0,

    /* Expression: 0
     * Referenced by: '<S3>/Sine Wave2'
     */
    0.0,

    /* Expression: 2*pi*10
     * Referenced by: '<S3>/Sine Wave2'
     */
    62.831853071795862,

    /* Computed Parameter: SineWave2_Hsin
     * Referenced by: '<S3>/Sine Wave2'
     */
    0.0062831439655589511,

    /* Computed Parameter: SineWave2_HCos
     * Referenced by: '<S3>/Sine Wave2'
     */
    0.99998026085613712,

    /* Computed Parameter: SineWave2_PSin
     * Referenced by: '<S3>/Sine Wave2'
     */
    -0.0062831439655589511,

    /* Computed Parameter: SineWave2_PCos
     * Referenced by: '<S3>/Sine Wave2'
     */
    0.99998026085613712,

    /* Expression: 1.5
     * Referenced by: '<S3>/Multiply2'
     */
    1.5
  }
  ,

  /* End of '<Root>/Subsystem2' */

  /* Start of '<Root>/Subsystem1' */
  {
    /* Expression: 1
     * Referenced by: '<S2>/Sine Wave2'
     */
    1.0,

    /* Expression: 0
     * Referenced by: '<S2>/Sine Wave2'
     */
    0.0,

    /* Expression: 2*pi*10
     * Referenced by: '<S2>/Sine Wave2'
     */
    62.831853071795862,

    /* Computed Parameter: SineWave2_Hsin
     * Referenced by: '<S2>/Sine Wave2'
     */
    0.0062831439655589511,

    /* Computed Parameter: SineWave2_HCos
     * Referenced by: '<S2>/Sine Wave2'
     */
    0.99998026085613712,

    /* Computed Parameter: SineWave2_PSin
     * Referenced by: '<S2>/Sine Wave2'
     */
    -0.0062831439655589511,

    /* Computed Parameter: SineWave2_PCos
     * Referenced by: '<S2>/Sine Wave2'
     */
    0.99998026085613712,

    /* Expression: 1
     * Referenced by: '<S2>/Multiply2'
     */
    1.0
  }
  ,

  /* End of '<Root>/Subsystem1' */

  /* Start of '<Root>/Subsystem' */
  {
    /* Expression: 1
     * Referenced by: '<S1>/Sine Wave2'
     */
    1.0,

    /* Expression: 0
     * Referenced by: '<S1>/Sine Wave2'
     */
    0.0,

    /* Expression: 2*pi*10
     * Referenced by: '<S1>/Sine Wave2'
     */
    62.831853071795862,

    /* Computed Parameter: SineWave2_Hsin
     * Referenced by: '<S1>/Sine Wave2'
     */
    0.0062831439655589511,

    /* Computed Parameter: SineWave2_HCos
     * Referenced by: '<S1>/Sine Wave2'
     */
    0.99998026085613712,

    /* Computed Parameter: SineWave2_PSin
     * Referenced by: '<S1>/Sine Wave2'
     */
    -0.0062831439655589511,

    /* Computed Parameter: SineWave2_PCos
     * Referenced by: '<S1>/Sine Wave2'
     */
    0.99998026085613712,

    /* Expression: 0.5
     * Referenced by: '<S1>/Multiply2'
     */
    0.5
  }
  /* End of '<Root>/Subsystem' */
};

SG__MDL_cal_type *SG__MDL_cal = &SG__MDL_cal_impl;
