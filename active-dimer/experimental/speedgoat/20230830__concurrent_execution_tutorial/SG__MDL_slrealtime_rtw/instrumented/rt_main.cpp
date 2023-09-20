/* Model wrapper function used by example main program */

void SG__MDL_step(int_T tid)
{
  switch (tid) {
   case 0 :
    Periodic_Task_step();
    break;

   case 1 :
    Periodic_Task1_step();
    break;

   case 2 :
    Periodic_Task2_step();
    break;

   case 3 :
    Periodic_Task3_step();
    break;

   case 4 :
    Periodic_Task4_step();
    break;

   default :
    break;
  }
}
