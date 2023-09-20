/* Model wrapper function used by example main program */

void SG__MDL_IO104_IO135_step(int_T tid)
{
  switch (tid) {
   case 0 :
    Periodic_IO_step();
    break;

   case 1 :
    Periodic_task3_step();
    break;

   default :
    break;
  }
}
