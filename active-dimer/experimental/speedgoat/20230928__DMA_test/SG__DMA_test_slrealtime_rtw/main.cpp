/* Main generated for Simulink Real-Time model SG__DMA_test */
#include <ModelInfo.hpp>
#include <utilities.hpp>
#include "SG__DMA_test.h"
#include "rte_SG__DMA_test_parameters.h"

/* Task descriptors */
slrealtime::TaskInfo task_1( 0u, std::bind(SG__DMA_test_step), slrealtime::TaskInfo::PERIODIC, 5e-05, 0, 40);
extern void Root_InterruptSetup_fc(void);
slrealtime::TaskInfo task_2( 1u, std::bind(Root_InterruptSetup_fc), slrealtime::TaskInfo::ASYNCHRONOUS, -1, -2, 254);

/* Executable base address for XCP */
#ifdef __linux__
extern char __executable_start;
static uintptr_t const base_address = reinterpret_cast<uintptr_t>(&__executable_start);
#else
/* Set 0 as placeholder, to be parsed later from /proc filesystem */
static uintptr_t const base_address = 0;
#endif

/* Model descriptor */
slrealtime::ModelInfo SG__DMA_test_Info =
{
    "SG__DMA_test",
    SG__DMA_test_initialize,
    SG__DMA_test_terminate,
    []()->char const*& { return SG__DMA_test_M->errorStatus; },
    []()->unsigned char& { return SG__DMA_test_M->Timing.stopRequestedFlag; },
    { task_1, task_2 },
    slrealtime::getSegmentVector()
};

int main(int argc, char *argv[]) {
    slrealtime::BaseAddress::set(base_address);
    return slrealtime::runModel(argc, argv, SG__DMA_test_Info);
}
