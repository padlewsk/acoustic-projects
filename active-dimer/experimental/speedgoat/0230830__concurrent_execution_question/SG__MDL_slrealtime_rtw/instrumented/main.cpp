/* Main generated for Simulink Real-Time model SG__MDL */
#include <ModelInfo.hpp>
#include <utilities.hpp>
#include "SG__MDL.h"
#include "rte_SG__MDL_parameters.h"

/* Task descriptors */
slrealtime::TaskInfo task_1( 0u, std::bind(Periodic_Task_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_2( 0u, std::bind(Periodic_Task1_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_3( 0u, std::bind(Periodic_Task2_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_4( 0u, std::bind(Periodic_Task3_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_5( 0u, std::bind(Periodic_Task4_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_6( 0u, std::bind(Periodic_Task5_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);

/* Executable base address for XCP */
#ifdef __linux__
extern char __executable_start;
static uintptr_t const base_address = reinterpret_cast<uintptr_t>(&__executable_start);
#else
/* Set 0 as placeholder, to be parsed later from /proc filesystem */
static uintptr_t const base_address = 0;
#endif

/* Model descriptor */
slrealtime::ModelInfo SG__MDL_Info =
{
    "SG__MDL",
    SG__MDL_initialize,
    SG__MDL_terminate,
    []()->char const*& { return SG__MDL_M->errorStatus; },
    []()->unsigned char& { return SG__MDL_M->Timing.stopRequestedFlag; },
    { task_1, task_2, task_3, task_4, task_5, task_6 },
    slrealtime::getSegmentVector()
};

int main(int argc, char *argv[]) {
    slrealtime::BaseAddress::set(base_address);
    return slrealtime::runModel(argc, argv, SG__MDL_Info);
}
