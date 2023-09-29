/* Model wrapper function used by example main program */

void ref_main_model_R2022b_step(int_T tid)
{
  switch (tid) {
   case 0 :
    Periodic_Model1_500us_step();
    break;

   case 1 :
    Periodic_Model2_500us_step();
    break;

   case 2 :
    Periodic_Model3_400us_step();
    break;

   case 3 :
    Periodic_Model4_400us_step();
    break;

   default :
    break;
  }
}
