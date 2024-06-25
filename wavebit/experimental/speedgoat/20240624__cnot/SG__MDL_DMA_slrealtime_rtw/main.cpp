/* Main generated for Simulink Real-Time model SG__MDL_DMA */
#include <ModelInfo.hpp>
#include <utilities.hpp>
#include "SG__MDL_DMA.h"
#include "rte_SG__MDL_DMA_parameters.h"

/* Task descriptors */
slrealtime::TaskInfo task_1( 0u, std::bind(SG__MDL_DMA_step), slrealtime::TaskInfo::PERIODIC, 5e-05, 0, 40);

/* Executable base address for XCP */
#ifdef __linux__
extern char __executable_start;
static uintptr_t const base_address = reinterpret_cast<uintptr_t>(&__executable_start);
#else
/* Set 0 as placeholder, to be parsed later from /proc filesystem */
static uintptr_t const base_address = 0;
#endif

/* Model descriptor */
slrealtime::ModelInfo SG__MDL_DMA_Info =
{
    "SG__MDL_DMA",
    SG__MDL_DMA_initialize,
    SG__MDL_DMA_terminate,
    []()->char const*& { return SG__MDL_DMA_M->errorStatus; },
    []()->unsigned char& { return SG__MDL_DMA_M->Timing.stopRequestedFlag; },
    { task_1 },
    slrealtime::getSegmentVector()
};

int main(int argc, char *argv[]) {
    slrealtime::BaseAddress::set(base_address);
    return slrealtime::runModel(argc, argv, SG__MDL_DMA_Info);
}
