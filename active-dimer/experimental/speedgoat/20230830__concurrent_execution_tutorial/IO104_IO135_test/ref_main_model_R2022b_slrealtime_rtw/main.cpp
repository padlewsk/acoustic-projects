/* Main generated for Simulink Real-Time model ref_main_model_R2022b */
#include <ModelInfo.hpp>
#include <utilities.hpp>
#include "ref_main_model_R2022b.h"
#include "rte_ref_main_model_R2022b_parameters.h"

/* Task descriptors */
slrealtime::TaskInfo task_1( 0u, std::bind(Periodic_Model1_500us_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_2( 0u, std::bind(Periodic_Model2_500us_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_3( 0u, std::bind(Periodic_Model3_400us_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);
slrealtime::TaskInfo task_4( 0u, std::bind(Periodic_Model4_400us_step), slrealtime::TaskInfo::PERIODIC, 0.0001, 0, 40);

/* Executable base address for XCP */
#ifdef __linux__
extern char __executable_start;
static uintptr_t const base_address = reinterpret_cast<uintptr_t>(&__executable_start);
#else
/* Set 0 as placeholder, to be parsed later from /proc filesystem */
static uintptr_t const base_address = 0;
#endif

/* Model descriptor */
slrealtime::ModelInfo ref_main_model_R2022b_Info =
{
    "ref_main_model_R2022b",
    ref_main_model_R2022b_initialize,
    ref_main_model_R2022b_terminate,
    []()->char const*& { return ref_main_model_R2022b_M->errorStatus; },
    []()->unsigned char& { return ref_main_model_R2022b_M->Timing.stopRequestedFlag; },
    { task_1, task_2, task_3, task_4 },
    slrealtime::getSegmentVector()
};

int main(int argc, char *argv[]) {
    slrealtime::BaseAddress::set(base_address);
    return slrealtime::runModel(argc, argv, ref_main_model_R2022b_Info);
}
