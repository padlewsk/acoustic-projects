%%% 30.08.2023 %%%
%%% Mathieu Padlewski 
%%% Example of a model running multiple tasks on the IO135 & I0104 SpeedGoat
%%% machine.
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));%
addpath('./__fun');
addpath('./__ref');%referenced modules

MDL = 'SG__MDL_DMA' ;

tg = slrealtime('Mobile'); % target computer interface
ts = 30e-6;   
set_param(MDL, 'ModelReferenceSymbolNameMessage', 'none');

%% BUILD APPLICATION
fprintf('Building the application...\n');
load_system(MDL);
create_build_dir();% creates build file on local PC (runs faster)
slbuild(MDL);

%% LOAD APPLICATION
fprintf('Loading the application...\n');
tg.stop(); % make sure the target is stopped
fprintf('tg load\n')
tg.load(MDL); % loads the application in the RT target
%% RUN APPLICATION
fprintf('Running the application...\n');
Simulink.sdi.view; % view the data
%tg.stopRecording();
tg.start
%pause(6);
tg.stopRecording();
%Simulink.sdi.clear();
tg.startRecording();

%% GET TASK EXEC. TIME FOR EACH TASK
TET = struct2table(tg.ModelStatus.TETInfo) % in cmd window
%slrtTETMonitor % show live in GUI


%% STOP APPLICATION
%tg.stopRecording();
%tg.stop
