

    

        /*
        * SG__MDL.cpp
        *
                * Academic License - for use in teaching, academic research, and meeting
* course requirements at degree granting institutions only.  Not for
* government, commercial, or other organizational use.
        *
    * Code generation for model "SG__MDL".
    *
    * Model version              : 6.23
    * Simulink Coder version : 9.8 (R2022b) 13-May-2022
        * C++ source code generated on : Thu Aug 31 15:36:09 2023
 * 
 * Target selection: slrealtime.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objective: Execution efficiency
 * Validation result: Not run
        */




    
#include "SG__MDL.h"

#include "SG__MDL_cal.h"

#include "SG__MDL_private.h"

#include <cmath>

#include "rtwtypes.h"

#include "crl_mutex.hpp"

#include <cstring>


    

    

                
                            
                            #define SG__REF_IO_MDLREF_HIDE_CHILD_

                            
                            #include "SG__REF_IO.h"

            


    

    

    

    

    

    

    

            /* Tasks */
                    RT_MODEL_SG__MDL_T task_M_[5];


                    RT_MODEL_SG__MDL_T *task_M[5];

        /* Child s-functions */
        RTWSfcnInfo sfcnInfo_[1];
        RTWSfcnInfo *sfcnInfo[1];

        /* Block signals (default storage) */
                                            B_SG__MDL_T SG__MDL_B;

            
            /* Block states (default storage) */
                                            DW_SG__MDL_T SG__MDL_DW;

            
    





        

        


                /* Real-time model */
                        
                                RT_MODEL_SG__MDL_T SG__MDL_M_ = RT_MODEL_SG__MDL_T();

                            RT_MODEL_SG__MDL_T *const SG__MDL_M = &SG__MDL_M_;



    

    

    

    

    



        /* This function updates active task counters and model execution time. */
    void AdvanceTaskCounters(void)
    {
        /* Update absolute time for base rate */
                    /* The "clockTick0" counts the number of times the code of this task has
        * been executed. The absolute time is the multiplication of "clockTick0"
        * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
        * overflow during the application lifespan selected.
            * Timer of this task consists of two 32 bit unsigned integers.
            * The two integers represent the low bits Timing.clockTick0 and the high bits
            * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
        */

        if(!(++SG__MDL_M->Timing.clockTick0)) {
 ++SG__MDL_M->Timing.clockTickH0; 
} SG__MDL_M->Timing.t[0] = SG__MDL_M->Timing.clockTick0 * SG__MDL_M->Timing.stepSize0 + SG__MDL_M->Timing.clockTickH0 * SG__MDL_M->Timing.stepSize0 * 4294967296.0;

            



    }

    

                                        
        
                            /* 
 * Enable for atomic system:
 *    '<Root>/Subsystem'
 *    '<Root>/Subsystem1'
 *    '<Root>/Subsystem2'
 *    '<Root>/Subsystem3'
 */

                    

        


          void SG__MDL_Subsystem_Enable(DW_Subsystem_SG__MDL_T *localDW)
    {
    
                
    
    




                                    




                                                
                                    /* Enable for Sin: '<S1>/Sine Wave2' */
localDW->systemEnable = 1;




    




                            }
            



            
        


                    /* 
 * Output and update for atomic system:
 *    '<Root>/Subsystem'
 *    '<Root>/Subsystem1'
 *    '<Root>/Subsystem2'
 *    '<Root>/Subsystem3'
 */

            
                            

        


          void SG__MDL_Subsystem(RT_MODEL_SG__MDL_T * const SG__MDL_M, B_Subsystem_SG__MDL_T *localB, DW_Subsystem_SG__MDL_T *localDW, SG__MDL_Subsystem_cal_type *SG__MDL_PageSwitching_arg)
    {
    
                                            
            
real_T lastSin_tmp;

            
        




                                                            
        




                                                    
                                    
/* {S!d2}Sin: '<S1>/Sine Wave2' */
if (localDW->systemEnable != 0) {
    lastSin_tmp = SG__MDL_PageSwitching_arg->SineWave2_Freq * SG__MDL_M->Timing.t[0];
    SESE_block_start_Ax3Zq9pEdy(1U);
    localDW->lastSin = std::sin(lastSin_tmp);
    SESE_blk_end_Ax3Zq9pEdy(1U);
    SESE_block_start_Ax3Zq9pEdy(2U);
    localDW->lastCos = std::cos(lastSin_tmp);
    SESE_blk_end_Ax3Zq9pEdy(2U);
    localDW->systemEnable = 0;
}
/* {S!d4}Gain: '<S1>/Multiply2' incorporates:
 *  Sin: '<S1>/Sine Wave2'
 */
localB->Multiply2 = (((localDW->lastSin * SG__MDL_PageSwitching_arg->SineWave2_PCos + localDW->lastCos * SG__MDL_PageSwitching_arg->SineWave2_PSin) * SG__MDL_PageSwitching_arg->SineWave2_HCos + (localDW->lastCos * SG__MDL_PageSwitching_arg->SineWave2_PCos - localDW->lastSin * SG__MDL_PageSwitching_arg->SineWave2_PSin) * SG__MDL_PageSwitching_arg->SineWave2_Hsin) * SG__MDL_PageSwitching_arg->SineWave2_Amp + SG__MDL_PageSwitching_arg->SineWave2_Bias) * SG__MDL_PageSwitching_arg->Multiply2_Gain;
/* {S!d6}Update for Sin: '<S1>/Sine Wave2' */
lastSin_tmp = localDW->lastSin;
localDW->lastSin = localDW->lastSin * SG__MDL_PageSwitching_arg->SineWave2_HCos + localDW->lastCos * SG__MDL_PageSwitching_arg->SineWave2_Hsin;
localDW->lastCos = localDW->lastCos * SG__MDL_PageSwitching_arg->SineWave2_HCos - lastSin_tmp * SG__MDL_PageSwitching_arg->SineWave2_Hsin;







        



                        
        
            
                    }
            



                                





        

        
        
        

    

                






                            




                        /* OutputUpdate for Task: Periodic_Task */
            void Periodic_Task_step(void) /* Sample time: [0.0001s, 0.0s] */
    {
            
        
        


                {
                                
                
real_T rtb_ImpAsg_InsertedFor_Out1_at_[4];
real_T rtb_TmpSignalConversionAtForEac[4];
real_T rtb_TmpTaskTransAtSubsystem5I_j;
real_T rtb_TmpTaskTransAtSubsystem5Inp;


                                            




                                

        
    




                
                                    
                                    

/* {S!d69}Outputs for Atomic SubSystem: '<Root>/Subsystem' */
SESE_block_start_Ax3Zq9pEdy(33U);


        SG__MDL_Subsystem(task_M[0], &SG__MDL_B.Subsystem, &SG__MDL_DW.Subsystem, &SG__MDL_cal->SG__MDL_Subsystem_cal);
SESE_blk_end_Ax3Zq9pEdy(33U);

/* {E!d69}End of Outputs for SubSystem: '<Root>/Subsystem' */

/* {S!d76}ToAsyncQueueBlock generated from: '<Root>/Subsystem' */
SESE_block_start_Ax3Zq9pEdy(34U);

SESE_blk_end_Ax3Zq9pEdy(34U);
/* {S!d78}TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(35U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_1);
SESE_blk_end_Ax3Zq9pEdy(35U);
rtb_TmpTaskTransAtSubsystem5Inp = SG__MDL_DW.TmpTaskTransAtSubsystem1Outport;
/* {S!d80}TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(36U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_2);
SESE_blk_end_Ax3Zq9pEdy(36U);
rtb_TmpTaskTransAtSubsystem5I_j = SG__MDL_DW.TmpTaskTransAtSubsystem2Outport;
/* {S!d82}TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(37U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_3);
SESE_blk_end_Ax3Zq9pEdy(37U);
/* {S!d71}Outputs for Atomic SubSystem: '<Root>/Subsystem5' */
/* {S!d84}SignalConversion generated from: '<S5>/For Each Subsystem' incorporates:
 *  TaskTransBlk generated from: '<Root>/Subsystem5'
 */
rtb_TmpSignalConversionAtForEac[0] = SG__MDL_B.Subsystem.Multiply2;
rtb_TmpSignalConversionAtForEac[1] = rtb_TmpTaskTransAtSubsystem5Inp;
rtb_TmpSignalConversionAtForEac[2] = rtb_TmpTaskTransAtSubsystem5I_j;
rtb_TmpSignalConversionAtForEac[3] = SG__MDL_DW.TmpTaskTransAtSubsystem3Outport;
/* {S!d72}Outputs for Iterator SubSystem: '<S5>/For Each Subsystem' incorporates:
 *  ForEach: '<S6>/For Each'
 */
for (ForEach_itr = 0; ForEach_itr < 4; ForEach_itr++) {
    /* {S!d86}ForEachSliceAssignment generated from: '<S6>/Out1' incorporates:
 *  ForEachSliceSelector generated from: '<S6>/In1'
 */
    rtb_ImpAsg_InsertedFor_Out1_at_[ForEach_itr] = rtb_TmpSignalConversionAtForEac[ForEach_itr];
}
/* {E!d72}End of Outputs for SubSystem: '<S5>/For Each Subsystem' */
/* {E!d71}End of Outputs for SubSystem: '<Root>/Subsystem5' */

/* {S!d88}TaskTransBlk generated from: '<Root>/Subsystem5' */
SG__MDL_DW.TmpTaskTransAtSubsystem5Outport = rtb_ImpAsg_InsertedFor_Out1_at_[0];
SESE_block_start_Ax3Zq9pEdy(38U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_4);
SESE_blk_end_Ax3Zq9pEdy(38U);
/* {S!d90}TaskTransBlk generated from: '<Root>/Subsystem5' */
SG__MDL_DW.TmpTaskTransAtSubsystem5Outpo_o = rtb_ImpAsg_InsertedFor_Out1_at_[1];
SESE_block_start_Ax3Zq9pEdy(39U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_5);
SESE_blk_end_Ax3Zq9pEdy(39U);
/* {S!d92}TaskTransBlk generated from: '<Root>/Subsystem5' */
SG__MDL_DW.TmpTaskTransAtSubsystem5Outpo_a = rtb_ImpAsg_InsertedFor_Out1_at_[2];
SESE_block_start_Ax3Zq9pEdy(40U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_6);
SESE_blk_end_Ax3Zq9pEdy(40U);
/* {S!d94}TaskTransBlk generated from: '<Root>/Subsystem5' */
SG__MDL_DW.TmpTaskTransAtSubsystem5Outpo_i = rtb_ImpAsg_InsertedFor_Out1_at_[3];
SESE_block_start_Ax3Zq9pEdy(41U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_7);
SESE_blk_end_Ax3Zq9pEdy(41U);





    



                    

        


            }



        
        



                        /* Update absolute time for base rate */
                    /* The "clockTick0" counts the number of times the code of this task has
        * been executed. The absolute time is the multiplication of "clockTick0"
        * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
        * overflow during the application lifespan selected.
            * Timer of this task consists of two 32 bit unsigned integers.
            * The two integers represent the low bits Timing.clockTick0 and the high bits
            * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
        */

        if(!(++task_M[0]->Timing.clockTick0)) {
 ++task_M[0]->Timing.clockTickH0; 
} task_M[0]->Timing.t[0] = task_M[0]->Timing.clockTick0 * task_M[0]->Timing.stepSize0 + task_M[0]->Timing.clockTickH0 * task_M[0]->Timing.stepSize0 * 4294967296.0;









    }

        








                            




                        /* OutputUpdate for Task: Periodic_Task1 */
            void Periodic_Task1_step(void) /* Sample time: [0.0001s, 0.0s] */
    {
            
        
        


                                            




                                

        
    




                
                                    
                                    



/* Outputs for Atomic SubSystem: '<Root>/Subsystem1' */

SESE_block_start_Ax3Zq9pEdy(30U);


        SG__MDL_Subsystem(task_M[1], &SG__MDL_B.Subsystem1, &SG__MDL_DW.Subsystem1, &SG__MDL_cal->SG__MDL_Subsystem1_cal);
SESE_blk_end_Ax3Zq9pEdy(30U);


/* End of Outputs for SubSystem: '<Root>/Subsystem1' */



/* ToAsyncQueueBlock generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(31U);

SESE_blk_end_Ax3Zq9pEdy(31U);
/* TaskTransBlk generated from: '<Root>/Subsystem1' */
SG__MDL_DW.TmpTaskTransAtSubsystem1Outport = SG__MDL_B.Subsystem1.Multiply2;
SESE_block_start_Ax3Zq9pEdy(32U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_1);
SESE_blk_end_Ax3Zq9pEdy(32U);





    



                    

        





        
        



                        /* Update absolute time for base rate */
                    /* The "clockTick0" counts the number of times the code of this task has
        * been executed. The absolute time is the multiplication of "clockTick0"
        * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
        * overflow during the application lifespan selected.
            * Timer of this task consists of two 32 bit unsigned integers.
            * The two integers represent the low bits Timing.clockTick0 and the high bits
            * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
        */

        if(!(++task_M[1]->Timing.clockTick0)) {
 ++task_M[1]->Timing.clockTickH0; 
} task_M[1]->Timing.t[0] = task_M[1]->Timing.clockTick0 * task_M[1]->Timing.stepSize0 + task_M[1]->Timing.clockTickH0 * task_M[1]->Timing.stepSize0 * 4294967296.0;









    }

        








                            




                        /* OutputUpdate for Task: Periodic_Task2 */
            void Periodic_Task2_step(void) /* Sample time: [0.0001s, 0.0s] */
    {
            
        
        


                                            




                                

        
    




                
                                    
                                    



/* Outputs for Atomic SubSystem: '<Root>/Subsystem2' */

SESE_block_start_Ax3Zq9pEdy(27U);


        SG__MDL_Subsystem(task_M[2], &SG__MDL_B.Subsystem2, &SG__MDL_DW.Subsystem2, &SG__MDL_cal->SG__MDL_Subsystem2_cal);
SESE_blk_end_Ax3Zq9pEdy(27U);


/* End of Outputs for SubSystem: '<Root>/Subsystem2' */



/* ToAsyncQueueBlock generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(28U);

SESE_blk_end_Ax3Zq9pEdy(28U);
/* TaskTransBlk generated from: '<Root>/Subsystem2' */
SG__MDL_DW.TmpTaskTransAtSubsystem2Outport = SG__MDL_B.Subsystem2.Multiply2;
SESE_block_start_Ax3Zq9pEdy(29U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_2);
SESE_blk_end_Ax3Zq9pEdy(29U);





    



                    

        





        
        



                        /* Update absolute time for base rate */
                    /* The "clockTick0" counts the number of times the code of this task has
        * been executed. The absolute time is the multiplication of "clockTick0"
        * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
        * overflow during the application lifespan selected.
            * Timer of this task consists of two 32 bit unsigned integers.
            * The two integers represent the low bits Timing.clockTick0 and the high bits
            * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
        */

        if(!(++task_M[2]->Timing.clockTick0)) {
 ++task_M[2]->Timing.clockTickH0; 
} task_M[2]->Timing.t[0] = task_M[2]->Timing.clockTick0 * task_M[2]->Timing.stepSize0 + task_M[2]->Timing.clockTickH0 * task_M[2]->Timing.stepSize0 * 4294967296.0;









    }

        








                            




                        /* OutputUpdate for Task: Periodic_Task3 */
            void Periodic_Task3_step(void) /* Sample time: [0.0001s, 0.0s] */
    {
            
        
        


                                            




                                

        
    




                
                                    
                                    



/* Outputs for Atomic SubSystem: '<Root>/Subsystem3' */

SESE_block_start_Ax3Zq9pEdy(24U);


        SG__MDL_Subsystem(task_M[3], &SG__MDL_B.Subsystem3, &SG__MDL_DW.Subsystem3, &SG__MDL_cal->SG__MDL_Subsystem3_cal);
SESE_blk_end_Ax3Zq9pEdy(24U);


/* End of Outputs for SubSystem: '<Root>/Subsystem3' */



/* ToAsyncQueueBlock generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(25U);

SESE_blk_end_Ax3Zq9pEdy(25U);
/* TaskTransBlk generated from: '<Root>/Subsystem3' */
SG__MDL_DW.TmpTaskTransAtSubsystem3Outport = SG__MDL_B.Subsystem3.Multiply2;
SESE_block_start_Ax3Zq9pEdy(26U);
rtw_slrealtime_sem_post(SG__MDL_DW.sw_buf_3);
SESE_blk_end_Ax3Zq9pEdy(26U);





    



                    

        





        
        



                        /* Update absolute time for base rate */
                    /* The "clockTick0" counts the number of times the code of this task has
        * been executed. The absolute time is the multiplication of "clockTick0"
        * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
        * overflow during the application lifespan selected.
            * Timer of this task consists of two 32 bit unsigned integers.
            * The two integers represent the low bits Timing.clockTick0 and the high bits
            * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
        */

        if(!(++task_M[3]->Timing.clockTick0)) {
 ++task_M[3]->Timing.clockTickH0; 
} task_M[3]->Timing.t[0] = task_M[3]->Timing.clockTick0 * task_M[3]->Timing.stepSize0 + task_M[3]->Timing.clockTickH0 * task_M[3]->Timing.stepSize0 * 4294967296.0;









    }

        








                            




                        /* OutputUpdate for Task: Periodic_Task4 */
            void Periodic_Task4_step(void) /* Sample time: [0.0001s, 0.0s] */
    {
            
        /* local block i/o variables */


                                real_T rtb_Subsystem4_o1;


                                real_T rtb_Subsystem4_o2;


                                real_T rtb_Subsystem4_o3;


                                real_T rtb_Subsystem4_o4;


        


                {
                                
                
real_T rtb_TmpTaskTransAtSubsystem4I_l;
real_T rtb_TmpTaskTransAtSubsystem4Inp;
real_T rtb_TmpTaskTransAtSubsystem4_k2;


                                            




                                

        
    




                
                                    
                                    
/* TaskTransBlk generated from: '<Root>/Subsystem4' */
SESE_block_start_Ax3Zq9pEdy(19U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_4);
SESE_blk_end_Ax3Zq9pEdy(19U);
rtb_TmpTaskTransAtSubsystem4Inp = SG__MDL_DW.TmpTaskTransAtSubsystem5Outport;
/* TaskTransBlk generated from: '<Root>/Subsystem4' */
SESE_block_start_Ax3Zq9pEdy(20U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_5);
SESE_blk_end_Ax3Zq9pEdy(20U);
rtb_TmpTaskTransAtSubsystem4I_l = SG__MDL_DW.TmpTaskTransAtSubsystem5Outpo_o;
/* TaskTransBlk generated from: '<Root>/Subsystem4' */
SESE_block_start_Ax3Zq9pEdy(21U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_6);
SESE_blk_end_Ax3Zq9pEdy(21U);
rtb_TmpTaskTransAtSubsystem4_k2 = SG__MDL_DW.TmpTaskTransAtSubsystem5Outpo_a;
/* TaskTransBlk generated from: '<Root>/Subsystem4' */
SESE_block_start_Ax3Zq9pEdy(22U);
rtw_slrealtime_sem_wait(SG__MDL_DW.sw_buf_7);
SESE_blk_end_Ax3Zq9pEdy(22U);
/* ModelReference: '<Root>/Subsystem4' incorporates:
 *  TaskTransBlk generated from: '<Root>/Subsystem4'
 */
SESE_block_start_Ax3Zq9pEdy(23U);
                
            
            
            





            SG__REF_IO(&rtb_TmpTaskTransAtSubsystem4Inp, &rtb_TmpTaskTransAtSubsystem4I_l, &rtb_TmpTaskTransAtSubsystem4_k2, &SG__MDL_DW.TmpTaskTransAtSubsystem5Outpo_i, &rtb_Subsystem4_o1, &rtb_Subsystem4_o2, &rtb_Subsystem4_o3, &rtb_Subsystem4_o4);



            
 

SESE_blk_end_Ax3Zq9pEdy(23U);






    



                    

        


            }



        
        



                        /* Update absolute time for base rate */
                    /* The "clockTick0" counts the number of times the code of this task has
        * been executed. The absolute time is the multiplication of "clockTick0"
        * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
        * overflow during the application lifespan selected.
            * Timer of this task consists of two 32 bit unsigned integers.
            * The two integers represent the low bits Timing.clockTick0 and the high bits
            * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
        */

        if(!(++task_M[4]->Timing.clockTick0)) {
 ++task_M[4]->Timing.clockTickH0; 
} task_M[4]->Timing.t[0] = task_M[4]->Timing.clockTick0 * task_M[4]->Timing.stepSize0 + task_M[4]->Timing.clockTickH0 * task_M[4]->Timing.stepSize0 * 4294967296.0;









    }

        




            










    





    /* Model initialize function */
    
            void SG__MDL_initialize(void)
    {
            


    




    
        

        



            /* Registration code */
                
    
        


                /* Set task counter limit used by the static main program */
                    (SG__MDL_M)->Timing.TaskCounters.cLimit[0] = 1;






            /* Initialize timing info */
                {
                    int_T  *mdlTsMap      = SG__MDL_M->Timing.sampleTimeTaskIDArray;
                            mdlTsMap[0] = 0;
                    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "SG__MDL_M points to
                    static memory which is guaranteed to be non-NULL" */
                    SG__MDL_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
                    SG__MDL_M->Timing.sampleTimes = (&SG__MDL_M->Timing.sampleTimesArray[0]);
                    SG__MDL_M->Timing.offsetTimes = (&SG__MDL_M->Timing.offsetTimesArray[0]);
                            /* task periods */
            SG__MDL_M->Timing.sampleTimes[0] = (0.0001);

        /* task offsets */
            SG__MDL_M->Timing.offsetTimes[0] = (0.0);
                }

                rtmSetTPtr(SG__MDL_M, &SG__MDL_M->Timing.tArray[0]);

                {
                    int_T  *mdlSampleHits = SG__MDL_M->Timing.sampleHitArray;
                        int_T *mdlPerTaskSampleHits = SG__MDL_M->Timing.perTaskSampleHitsArray;

                        SG__MDL_M->Timing.perTaskSampleHits = (&mdlPerTaskSampleHits[0]);
                        mdlSampleHits[0] = 1;
                    SG__MDL_M->Timing.sampleHits = (&mdlSampleHits[0]);
                }







                                SG__MDL_M->Timing.stepSize0  = 0.0001;


                    










            SG__MDL_M->solverInfoPtr = (&SG__MDL_M->solverInfo);
            SG__MDL_M->Timing.stepSize = (0.0001);
            rtsiSetFixedStepSize(&SG__MDL_M->solverInfo, 0.0001);
                rtsiSetSolverMode(&SG__MDL_M->solverInfo, SOLVER_MODE_MULTITASKING);


        




        /* block I/O */
        
        


                
                (void) std::memset((static_cast<void *>(&SG__MDL_B)), 0,
sizeof(B_SG__MDL_T));
                

                






                    

        














        









        /* states (dwork) */
        
        



                                        (void) std::memset(static_cast<void *>(&SG__MDL_DW),  0,
 sizeof(DW_SG__MDL_T));
                    






        
    


        
        
        


        




        







        

    
        {
    
            /* user code (registration function declaration) */
                int_T tIdx;


    for(tIdx = 0; tIdx < 5; tIdx++) {
            task_M[tIdx] = &task_M_[tIdx];
            /* initialize real-time model */
            (void) std::memset(static_cast<void *>(task_M[tIdx]), 0,
sizeof(RT_MODEL_SG__MDL_T));

                    task_M[tIdx]->Timing.TaskCounters.cLimit[0] = 1;
    }
        for (tIdx = 0; tIdx < 5; tIdx++) {
                        /* Initialize timing info */
            {
                int_T  *mdlTsMap      = task_M[tIdx]->Timing.sampleTimeTaskIDArray;
                        mdlTsMap[0] = 0;
                task_M[tIdx]->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
                task_M[tIdx]->Timing.sampleTimes = (&task_M[tIdx]->Timing.sampleTimesArray[0]);
                task_M[tIdx]->Timing.offsetTimes = (&task_M[tIdx]->Timing.offsetTimesArray[0]);
                    /* task periods */
        task_M[tIdx]->Timing.sampleTimes[0] = (0.0001);

    /* task offsets */
        task_M[tIdx]->Timing.offsetTimes[0] = (0.0);
            }

            rtmSetTPtr(task_M[tIdx], &task_M[tIdx]->Timing.tArray[0]);

            {
                int_T  *mdlSampleHits = task_M[tIdx]->Timing.sampleHitArray;
                    int_T *mdlPerTaskSampleHits = task_M[tIdx]->Timing.perTaskSampleHitsArray;

                    task_M[tIdx]->Timing.perTaskSampleHits = (&mdlPerTaskSampleHits[0]);
                    mdlSampleHits[0] = 1;
                task_M[tIdx]->Timing.sampleHits = (&mdlSampleHits[0]);
            }


                            task_M[tIdx]->Timing.stepSize0  = 0.0001;


            task_M[tIdx]->solverInfoPtr = (&task_M[tIdx]->solverInfo);
            task_M[tIdx]->Timing.stepSize = (0.0001);
            rtsiSetFixedStepSize(&task_M[tIdx]->solverInfo, 0.0001);
            rtsiSetSolverMode(&task_M[tIdx]->solverInfo, SOLVER_MODE_MULTITASKING);



        }
                        ;


                ;


                ;


                ;


                ;





            { /* child S-Function registration */
            static time_T *taskTimePtrs[1];
            static int_T *perTaskSampleHitsPtrs[(1 * 1)];
            sfcnInfo[0]= &sfcnInfo_[0];
            rtssSetErrorStatusPtr(sfcnInfo[0], (&rtmGetErrorStatus(SG__MDL_M)));
            rtssSetNumRootSampTimesPtr(sfcnInfo[0], &SG__MDL_M->Sizes.numSampTimes);
            rtssSetTStartPtr(sfcnInfo[0],           &rtmGetTStart(SG__MDL_M));
            rtssSetTimeOfLastOutputPtr(sfcnInfo[0], &rtmGetTimeOfLastOutput(SG__MDL_M));
            rtssSetStepSizePtr(sfcnInfo[0],         &SG__MDL_M->Timing.stepSize);
            rtssSetStopRequestedPtr(sfcnInfo[0],    &rtmGetStopRequested(SG__MDL_M));
            rtssSetSimModePtr(sfcnInfo[0],          &SG__MDL_M->simMode);

                rtssSetDerivCacheNeedsResetPtr(sfcnInfo[0], &task_M[4]->derivCacheNeedsReset);
                rtssSetZCCacheNeedsResetPtr(sfcnInfo[0], &task_M[4]->zCCacheNeedsReset);
                rtssSetContTimeOutputInconsistentWithStateAtMajorStepPtr(sfcnInfo[0], &task_M[4]->CTOutputIncnstWithState);
                rtssSetSolverInfoPtr(sfcnInfo[0], &task_M[4]->solverInfoPtr);
                            taskTimePtrs[0] = &(task_M[4]->Timing.t[0]);
            rtssSetTPtrPtr(sfcnInfo[0], taskTimePtrs);
            rtssSetPerTaskSampleHitsPtr(sfcnInfo[0], perTaskSampleHitsPtrs);

            rtssSetSampleHitsPtr(sfcnInfo[0], &SG__MDL_M->Timing.sampleHits);
        }

    }

    
        


        

            

            





                    /* Model Initialize function for ModelReference Block: '<Root>/Subsystem4' */
                    
                    
                        SG__REF_IO_initialize(rtmGetErrorStatusPointer(SG__MDL_M), rtmGetStopRequestedPtr(SG__MDL_M), &(task_M[4]->solverInfo), (RTWSfcnInfo *)(sfcnInfo[0]), 0);

                    


                



        




        











            
        




                        




                
                                    
                                    /* SetupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(3U);
SESE_blk_end_Ax3Zq9pEdy(3U);
/* SetupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(4U);
SESE_blk_end_Ax3Zq9pEdy(4U);
/* SetupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(5U);
SESE_blk_end_Ax3Zq9pEdy(5U);
/* SetupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem' */
SESE_block_start_Ax3Zq9pEdy(6U);
SESE_blk_end_Ax3Zq9pEdy(6U);
/* Start for ToAsyncQueueBlock generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(7U);
SESE_blk_end_Ax3Zq9pEdy(7U);
/* Start for ToAsyncQueueBlock generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(8U);
SESE_blk_end_Ax3Zq9pEdy(8U);
/* Start for ToAsyncQueueBlock generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(9U);
SESE_blk_end_Ax3Zq9pEdy(9U);
/* Start for ToAsyncQueueBlock generated from: '<Root>/Subsystem' */
SESE_block_start_Ax3Zq9pEdy(10U);
SESE_blk_end_Ax3Zq9pEdy(10U);




        




                



        




                




                                                
                                    

/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(11U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_1, 0);
SESE_blk_end_Ax3Zq9pEdy(11U);
/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(12U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_2, 0);
SESE_blk_end_Ax3Zq9pEdy(12U);
/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(13U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_3, 0);
SESE_blk_end_Ax3Zq9pEdy(13U);
/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(14U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_4, 0);
SESE_blk_end_Ax3Zq9pEdy(14U);
/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(15U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_5, 0);
SESE_blk_end_Ax3Zq9pEdy(15U);
/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(16U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_6, 0);
SESE_blk_end_Ax3Zq9pEdy(16U);
/* InitializeConditions for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(17U);
rtw_slrealtime_sem_init(&SG__MDL_DW.sw_buf_7, 0);
SESE_blk_end_Ax3Zq9pEdy(17U);
/* SystemInitialize for ModelReference: '<Root>/Subsystem4' */
SESE_block_start_Ax3Zq9pEdy(18U);
                    
                SG__REF_IO_Init();

 SESE_blk_end_Ax3Zq9pEdy(18U);












                    
        




                




                                                
                                    



/* Enable for Atomic SubSystem: '<Root>/Subsystem1' */

SESE_block_start_Ax3Zq9pEdy(42U);

        SG__MDL_Subsystem_Enable(&SG__MDL_DW.Subsystem1);
SESE_blk_end_Ax3Zq9pEdy(42U);


/* End of Enable for SubSystem: '<Root>/Subsystem1' */






/* Enable for Atomic SubSystem: '<Root>/Subsystem2' */

SESE_block_start_Ax3Zq9pEdy(43U);

        SG__MDL_Subsystem_Enable(&SG__MDL_DW.Subsystem2);
SESE_blk_end_Ax3Zq9pEdy(43U);


/* End of Enable for SubSystem: '<Root>/Subsystem2' */






/* Enable for Atomic SubSystem: '<Root>/Subsystem3' */

SESE_block_start_Ax3Zq9pEdy(44U);

        SG__MDL_Subsystem_Enable(&SG__MDL_DW.Subsystem3);
SESE_blk_end_Ax3Zq9pEdy(44U);


/* End of Enable for SubSystem: '<Root>/Subsystem3' */






/* Enable for Atomic SubSystem: '<Root>/Subsystem' */

SESE_block_start_Ax3Zq9pEdy(45U);

        SG__MDL_Subsystem_Enable(&SG__MDL_DW.Subsystem);
SESE_blk_end_Ax3Zq9pEdy(45U);


/* End of Enable for SubSystem: '<Root>/Subsystem' */











                
    





        



    }        






        




        
        /* Model terminate function */
                    void SG__MDL_terminate(void)

        {
            


                                                            




                        




                                                    

                        
                                    /* Terminate for ToAsyncQueueBlock generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(46U);
SESE_blk_end_Ax3Zq9pEdy(46U);
/* Terminate for ToAsyncQueueBlock generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(47U);
SESE_blk_end_Ax3Zq9pEdy(47U);
/* Terminate for ToAsyncQueueBlock generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(48U);
SESE_blk_end_Ax3Zq9pEdy(48U);
/* Terminate for ToAsyncQueueBlock generated from: '<Root>/Subsystem' */
SESE_block_start_Ax3Zq9pEdy(49U);
SESE_blk_end_Ax3Zq9pEdy(49U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(50U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_1);
SESE_blk_end_Ax3Zq9pEdy(50U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(51U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_2);
SESE_blk_end_Ax3Zq9pEdy(51U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(52U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_3);
SESE_blk_end_Ax3Zq9pEdy(52U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(53U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_4);
SESE_blk_end_Ax3Zq9pEdy(53U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(54U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_5);
SESE_blk_end_Ax3Zq9pEdy(54U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(55U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_6);
SESE_blk_end_Ax3Zq9pEdy(55U);
/* Terminate for TaskTransBlk generated from: '<Root>/Subsystem5' */
SESE_block_start_Ax3Zq9pEdy(56U);
rtw_slrealtime_sem_destroy(SG__MDL_DW.sw_buf_7);
SESE_blk_end_Ax3Zq9pEdy(56U);
/* Terminate for ModelReference: '<Root>/Subsystem4' */
SESE_block_start_Ax3Zq9pEdy(57U);
                    
                SG__REF_IO_Term();

 SESE_blk_end_Ax3Zq9pEdy(57U);
/* CleanupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem1' */
SESE_block_start_Ax3Zq9pEdy(58U);
SESE_blk_end_Ax3Zq9pEdy(58U);
/* CleanupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem2' */
SESE_block_start_Ax3Zq9pEdy(59U);
SESE_blk_end_Ax3Zq9pEdy(59U);
/* CleanupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem3' */
SESE_block_start_Ax3Zq9pEdy(60U);
SESE_blk_end_Ax3Zq9pEdy(60U);
/* CleanupRuntimeResources for ToAsyncQueueBlock generated from: '<Root>/Subsystem' */
SESE_block_start_Ax3Zq9pEdy(61U);
SESE_blk_end_Ax3Zq9pEdy(61U);





                


                    




                




                


        }
            





    




    

    

    

    
