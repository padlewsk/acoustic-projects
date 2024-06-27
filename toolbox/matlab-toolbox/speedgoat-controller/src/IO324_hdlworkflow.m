%--------------------------------------------------------------------------
% HDL Workflow Script
% Generated with MATLAB 9.13 (R2022b) at 11:28:17 on 09/10/2023
% This script was generated using the following parameter values:
%     Filename  : 'C:\Users\mavolery\Desktop\control-schemes\MATLAB\speedgoat\src\IO324_hdlworkflow.m'
%     Overwrite : true
%     Comments  : true
%     Headers   : true
%     DUT       : 'IO324_src/IO324_FPGA'
% To view changes after modifying the workflow, run the following command:
% >> hWC.export('DUT','IO324_src/IO324_FPGA');
%--------------------------------------------------------------------------

%% Load the Model
load_system('IO324_src');

%% Restore the Model to default HDL parameters
%hdlrestoreparams('IO324_src/IO324_FPGA');

%% Model HDL Parameters
%% Set Model 'IO324_src' HDL parameters
hdlset_param('IO324_src', 'AdaptivePipelining', 'on');
hdlset_param('IO324_src', 'HDLSubsystem', 'IO324_src/IO324_FPGA');
hdlset_param('IO324_src', 'LUTMapToRAM', 'off');
hdlset_param('IO324_src', 'OptimizationReport', 'on');
hdlset_param('IO324_src', 'PackagePostfix', '_pac');
hdlset_param('IO324_src', 'ReferenceDesign', 'Speedgoat IO324-200k');
hdlset_param('IO324_src', 'ReferenceDesignParameter', {'PCIe_Link_Width','X4','timingSeverity','error','RearPlugin','None','HDLVerifierAXI','off','HDLVerifierFDC','JTAG'});
hdlset_param('IO324_src', 'ResetInputPort', 'reset_x');
hdlset_param('IO324_src', 'ResetType', 'Synchronous');
hdlset_param('IO324_src', 'ResourceReport', 'on');
hdlset_param('IO324_src', 'ScalarizePorts', 'DUTLevel');
hdlset_param('IO324_src', 'SynthesisTool', 'Xilinx Vivado');
hdlset_param('IO324_src', 'SynthesisToolChipFamily', 'Artix7');
hdlset_param('IO324_src', 'SynthesisToolDeviceName', 'xc7a200t');
hdlset_param('IO324_src', 'SynthesisToolPackageName', 'fbg676');
hdlset_param('IO324_src', 'SynthesisToolSpeedValue', '-2');
hdlset_param('IO324_src', 'TargetDirectory', 'C:\Speedgoat\Build\IO324_SOS\hdlsrc');
hdlset_param('IO324_src', 'TargetFrequency', 100);
hdlset_param('IO324_src', 'TargetLanguage', 'Verilog');
hdlset_param('IO324_src', 'TargetPlatform', 'Speedgoat IO324-200k');
hdlset_param('IO324_src', 'Workflow', 'Simulink Real-Time FPGA I/O');

% Set SubSystem HDL parameters
hdlset_param('IO324_src/IO324_FPGA', 'AXI4SlaveIDWidth', '14');
hdlset_param('IO324_src/IO324_FPGA', 'ProcessorFPGASynchronization', 'Free running');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai1', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai1', 'IOInterfaceMapping', 'Channel 01');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai2', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai2', 'IOInterfaceMapping', 'Channel 02');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai3', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai3', 'IOInterfaceMapping', 'Channel 03');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai4', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai4', 'IOInterfaceMapping', 'Channel 04');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai5', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai5', 'IOInterfaceMapping', 'Channel 05');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai6', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai6', 'IOInterfaceMapping', 'Channel 06');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai7', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai7', 'IOInterfaceMapping', 'Channel 07');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai8', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai8', 'IOInterfaceMapping', 'Channel 08');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai9', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai9', 'IOInterfaceMapping', 'Channel 09');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai10', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai10', 'IOInterfaceMapping', 'Channel 10');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai11', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai11', 'IOInterfaceMapping', 'Channel 11');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai12', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai12', 'IOInterfaceMapping', 'Channel 12');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai13', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai13', 'IOInterfaceMapping', 'Channel 13');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai14', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai14', 'IOInterfaceMapping', 'Channel 14');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai15', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai15', 'IOInterfaceMapping', 'Channel 15');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai16', 'IOInterface', 'IO324 AI Data Single [0:31]');
hdlset_param('IO324_src/IO324_FPGA/ai16', 'IOInterfaceMapping', 'Channel 16');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai_valid_1_8', 'IOInterface', 'IO324 AI Valid [0:3]');
hdlset_param('IO324_src/IO324_FPGA/ai_valid_1_8', 'IOInterfaceMapping', 'Channel 01 to 08');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai_valid_9_16', 'IOInterface', 'IO324 AI Valid [0:3]');
hdlset_param('IO324_src/IO324_FPGA/ai_valid_9_16', 'IOInterfaceMapping', 'Channel 09 to 16');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_adc_ticks', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_adc_ticks', 'IOInterfaceMapping', 'x"100"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_ao', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_ao', 'IOInterfaceMapping', 'x"130"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ctrl_limit', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/ctrl_limit', 'IOInterfaceMapping', 'x"104"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_sos1', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_sos1', 'IOInterfaceMapping', 'x"180"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_sos2', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_sos2', 'IOInterfaceMapping', 'x"280"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_gain', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_gain', 'IOInterfaceMapping', 'x"108"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_csr', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_csr', 'IOInterfaceMapping', 'x"114"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_channel_in', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_channel_in', 'IOInterfaceMapping', 'x"118"');

% Set Inport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_channel_out', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_channel_out', 'IOInterfaceMapping', 'x"11C"');

% Set SubSystem HDL parameters
hdlset_param('IO324_src/IO324_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial/Multiply-Add', 'PipelineDepth', '3');

% Set SubSystem HDL parameters
hdlset_param('IO324_src/IO324_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial1/Multiply-Add', 'PipelineDepth', '3');

% Set SubSystem HDL parameters
hdlset_param('IO324_src/IO324_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial2/Multiply-Add', 'PipelineDepth', '3');

% Set SubSystem HDL parameters
hdlset_param('IO324_src/IO324_FPGA/Subsystem Reference/Filter/Discrete SOS serial/Discrete SOS section DFI serial3/Multiply-Add', 'PipelineDepth', '3');

% Set Product HDL parameters
hdlset_param('IO324_src/IO324_FPGA/Subsystem Reference/Input gain/Product', 'DSPStyle', 'on');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao1', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao1', 'IOInterfaceMapping', 'Channel 01');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao2', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao2', 'IOInterfaceMapping', 'Channel 02');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao3', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao3', 'IOInterfaceMapping', 'Channel 03');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao4', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao4', 'IOInterfaceMapping', 'Channel 04');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao5', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao5', 'IOInterfaceMapping', 'Channel 05');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao6', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao6', 'IOInterfaceMapping', 'Channel 06');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao7', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao7', 'IOInterfaceMapping', 'Channel 07');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao8', 'IOInterface', 'IO324 AO Data [0:7]');
hdlset_param('IO324_src/IO324_FPGA/ao8', 'IOInterfaceMapping', 'Channel 08');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai_trigger_1_8', 'IOInterface', 'IO324 AI Trigger [0:3]');
hdlset_param('IO324_src/IO324_FPGA/ai_trigger_1_8', 'IOInterfaceMapping', 'Channel 01 to 08');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ai_trigger_9_16', 'IOInterface', 'IO324 AI Trigger [0:3]');
hdlset_param('IO324_src/IO324_FPGA/ai_trigger_9_16', 'IOInterfaceMapping', 'Channel 09 to 16');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/ao_trigger', 'IOInterface', 'IO324 AO Trigger');
hdlset_param('IO324_src/IO324_FPGA/ao_trigger', 'IOInterfaceMapping', 'Channel 01 to 08');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_ai', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_ai', 'IOInterfaceMapping', 'x"220"');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_ctrl_monitor', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_ctrl_monitor', 'IOInterfaceMapping', 'x"120"');

% Set Outport HDL parameters
hdlset_param('IO324_src/IO324_FPGA/cpu_saturated', 'IOInterface', 'PCIe Interface');
hdlset_param('IO324_src/IO324_FPGA/cpu_saturated', 'IOInterfaceMapping', 'x"124"');


%% Workflow Configuration Settings
% Construct the Workflow Configuration Object with default settings
hWC = hdlcoder.WorkflowConfig('SynthesisTool','Xilinx Vivado','TargetWorkflow','Simulink Real-Time FPGA I/O');

% Specify the top level project directory
hWC.ProjectFolder = 'C:\Speedgoat\Build\IO324_SOS';
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
hWC.MaxNumOfCoresForBuild = '';

% Validate the Workflow Configuration Object
hWC.validate;

%% Run the workflow
hdlcoder.runWorkflow('IO324_src/IO324_FPGA', hWC);
