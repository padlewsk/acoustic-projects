%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.13 (R2022b) at 11:34:19 on 09/10/2023
% This script was generated using the following parameter values:
%     Filename  : 'C:\Users\mavolery\Desktop\control-schemes\MATLAB\speedgoat\src\IO397_hdlworkflow.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'IO397_src/IO397_FPGA'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','IO397_src/IO397_FPGA');
%--------------------------------------------------------------------------

%% Load the Model
load_system('IO397_src');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('IO397_src/IO397_FPGA');

%% Model HDL Parameters
%% Set Model 'IO397_src' HDL parameters
hdlset_param('IO397_src', 'AdaptivePipelining', 'on');
hdlset_param('IO397_src', 'HDLSubsystem', 'IO397_src/IO397_FPGA');
hdlset_param('IO397_src', 'LUTMapToRAM', 'off');
hdlset_param('IO397_src', 'OptimizationReport', 'on');
hdlset_param('IO397_src', 'PackagePostfix', '_pac');
hdlset_param('IO397_src', 'ReferenceDesign', 'Speedgoat IO397-50k');
hdlset_param('IO397_src', 'ResetInputPort', 'reset_x');
hdlset_param('IO397_src', 'ResetType', 'Synchronous');
hdlset_param('IO397_src', 'ResourceReport', 'on');
hdlset_param('IO397_src', 'ScalarizePorts', 'DUTLevel');
hdlset_param('IO397_src', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('IO397_src', 'SynthesisToolChipFamily', 'Artix7');
hdlset_param('IO397_src', 'SynthesisToolDeviceName', 'xc7a50t');
hdlset_param('IO397_src', 'SynthesisToolPackageName', 'csg325');
hdlset_param('IO397_src', 'SynthesisToolSpeedValue', '-2');
hdlset_param('IO397_src', 'TargetDirectory', 'C:\Speedgoat\Build\IO397_SOS\hdlsrc');
hdlset_param('IO397_src', 'TargetFrequency', 100);
hdlset_param('IO397_src', 'TargetLanguage', 'Verilog');
hdlset_param('IO397_src', 'TargetPlatform', 'Speedgoat IO397-50k');
hdlset_param('IO397_src', 'Workflow', 'Simulink Real-Time FPGA I/O');

% Set SubSystem HDL parameters
hdlset_param('IO397_src/IO397_FPGA', 'AXI4SlaveIDWidth', '12');
hdlset_param('IO397_src/IO397_FPGA', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ai1', 'IOInterface', 'IO397 AI Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ai1', 'IOInterfaceMapping', 'Channel 01');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ai2', 'IOInterface', 'IO397 AI Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ai2', 'IOInterfaceMapping', 'Channel 02');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ai3', 'IOInterface', 'IO397 AI Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ai3', 'IOInterfaceMapping', 'Channel 03');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ai4', 'IOInterface', 'IO397 AI Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ai4', 'IOInterfaceMapping', 'Channel 04');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ai_valid', 'IOInterface', 'IO397 AI Valid');
hdlset_param('IO397_src/IO397_FPGA/ai_valid', 'IOInterfaceMapping', 'Channel 01 to 04');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_adc_ticks', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_adc_ticks', 'IOInterfaceMapping', 'x"100"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_ao', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_ao', 'IOInterfaceMapping', 'x"130"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ctrl_limit', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/ctrl_limit', 'IOInterfaceMapping', 'x"104"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_sos1', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_sos1', 'IOInterfaceMapping', 'x"180"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_sos2', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_sos2', 'IOInterfaceMapping', 'x"280"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_gain', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_gain', 'IOInterfaceMapping', 'x"108"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_csr', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_csr', 'IOInterfaceMapping', 'x"114"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_channel_in', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_channel_in', 'IOInterfaceMapping', 'x"118"');

% Set Inport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_channel_out', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_channel_out', 'IOInterfaceMapping', 'x"11C"');

% Set SubSystem HDL parameters
hdlset_param('IO397_src/IO397_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial/Multiply-Add', 'PipelineDepth', '3');

% Set SubSystem HDL parameters
hdlset_param('IO397_src/IO397_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial1/Multiply-Add', 'PipelineDepth', '3');

% Set SubSystem HDL parameters
hdlset_param('IO397_src/IO397_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial2/Multiply-Add', 'PipelineDepth', '3');

% Set SubSystem HDL parameters
hdlset_param('IO397_src/IO397_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial3/Multiply-Add', 'PipelineDepth', '3');

% Set Product HDL parameters
hdlset_param('IO397_src/IO397_FPGA/Subsystem Reference/Input gain/Product', 'DSPStyle', 'on');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ao1', 'IOInterface', 'IO397 AO Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ao1', 'IOInterfaceMapping', 'Channel 01');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ao2', 'IOInterface', 'IO397 AO Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ao2', 'IOInterfaceMapping', 'Channel 02');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ao3', 'IOInterface', 'IO397 AO Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ao3', 'IOInterfaceMapping', 'Channel 03');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ao4', 'IOInterface', 'IO397 AO Data [0:3]');
hdlset_param('IO397_src/IO397_FPGA/ao4', 'IOInterfaceMapping', 'Channel 04');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ai_trigger', 'IOInterface', 'IO397 AI Trigger');
hdlset_param('IO397_src/IO397_FPGA/ai_trigger', 'IOInterfaceMapping', 'Channel 01 to 04');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/ao_trigger', 'IOInterface', 'IO397 AO Trigger');
hdlset_param('IO397_src/IO397_FPGA/ao_trigger', 'IOInterfaceMapping', 'Channel 01 to 04');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_ctrl_monitor', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_ctrl_monitor', 'IOInterfaceMapping', 'x"13C"');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_ai', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_ai', 'IOInterfaceMapping', 'x"120"');

% Set Outport HDL parameters
hdlset_param('IO397_src/IO397_FPGA/cpu_saturated', 'IOInterface', 'PCIe Interface');
hdlset_param('IO397_src/IO397_FPGA/cpu_saturated', 'IOInterfaceMapping', 'x"12C"');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','Simulink Real-Time FPGA I/O');

% Specify the top level project directory
hWC.ProjectFolder = 'C:\Speedgoat\Build\IO397_SOS';
hWC.ReferenceDesignToolVersion = '2020.2';
hWC.IgnoreToolVersionMismatch = false;

% Set Workflow tasks to run
hWC.RunTaskGenerateRTLCodeAndIPCore = true;
hWC.RunTaskCreateProject = true;
hWC.RunTaskBuildFPGABitstream = true;
hWC.RunTaskGenerateSimulinkRealTimeInterface = true;

% Set properties related to 'RunTaskGenerateRTLCodeAndIPCore' Task
hWC.IPCoreRepository = '';
hWC.GenerateIPCoreReport = true;

% Set properties related to 'RunTaskCreateProject' Task
hWC.Objective = hdlcoder.Objective.None;
hWC.AdditionalProjectCreationTclFiles = '';
hWC.EnableIPCaching = true;

% Set properties related to 'RunTaskBuildFPGABitstream' Task
hWC.RunExternalBuild = false;
hWC.EnableDesignCheckpoint = false;
hWC.TclFileForSynthesisBuild = hdlcoder.BuildOption.Default;
hWC.CustomBuildTclFile = '';
hWC.DefaultCheckpointFile = 'Default';
hWC.RoutedDesignCheckpointFilePath = '';
hWC.MaxNumOfCoresForBuild = 'synthesis tool default';

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('IO397_src/IO397_FPGA', hWC);
