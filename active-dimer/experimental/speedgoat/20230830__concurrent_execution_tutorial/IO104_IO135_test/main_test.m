%%% 30.08.2023 %%%
%%% Mathieu Padlewski 
%%% Example of a model running 5 different tasks on the IO135 SpeedGoat
%%% machine.
clear 
close
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox\speedgoat-controller'));%SG library

MDL = 'ref_main_model_R2022b' ;
tg = slrealtime('Mobile'); % target computer interface
ts = 1e-4;
%set_param(MDL, 'ModelReferenceSymbolNameMessage', 'none')

%% BUILD APPLICATION
fprintf('Building the application...\n');
load_system(MDL);
slbuild(MDL);

%% LOAD APPLICATION
fprintf('Loading the application...\n');
tg.stop(); % make sure the target is stopped
fprintf('tg load\n')
tg.load(MDL); % loads the application in the RT target

%% RUN APPLICATION
fprintf('Running the application...\n');
Simulink.sdi.view; % view the data
tg.start
tg.stopRecording();
Simulink.sdi.clear();
tg.startRecording();

%% GET TASK EXEC. TIME FOR EACH TASK
TET = struct2table(tg.ModelStatus.TETInfo) % in cmd window
slrtTETMonitor % show live in GUI

%% STOP APPLICATION
%tg.stopRecording();
%tg.stop
