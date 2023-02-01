%%% COMPILES AND UPLOADS SIMULINK MODEL TO SPEEDGOAT
%%% Tricks to find the parameter name
%%% https://www.mathworks.com/help/simulink/slref/block-specific-parameters.html
%%% get_param([MDL, '/source/sweep'], 'ObjectParameters')
%%% View block mask
%%% VIEW TARGET SCREEN 
%%% BE SURE TO ESTABLISH CONNECTION TO SG BEFORE FLASHING (slrtexplr) (duh...)

%%% ADD SG LIB PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox\SpeedGoat');

%%% UPLOAD MODEL TO WORKSPACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MDL = 'SG__MDL_IO344'; % name of the slx model
tg = slrt('Performance'); %%% create objects to manipulate the target
%tg = slrt('Baseline');
load_system(MDL); % loads slx model

%%% MAKE BUILD FILE TO LOCAL DIRECTORY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
create_build_dir() % creates build file on local PC (runs faster) 

%%% SET THE DEFAULT SIMULINK PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%% UPLOAD PARAMETERS TO WORKSPACE
run('params.m'); % in case some parameters are overwritten

%%% for running time
set_param([MDL], 'StopTime',num2str(Inf)) %1 more second to get all the data

%%% Set sample times to sources
set_param([MDL, '/source/sweep'], 'Ts', num2str(ts));
set_param([MDL, '/source/random'], 'SampleTime', num2str(ts));

%%% for high pass filters
%
set_param([MDL, '/Highpass Filter'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter1'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter2'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter3'], 'SampleRate', num2str(fs));
%}

%%% For the host scope and the target scope
set_param([MDL, '/Scope '], 'nosamples', num2str(800000));
set_param([MDL, '/Scope '], 'interleave', num2str(1));

set_param([MDL, '/Scope 2'], 'nosamples', num2str(800000));
set_param([MDL, '/Scope 2'], 'interleave', num2str(1));

%%% for control (OFF BY DEFAULT)
set_param([MDL, '/control'], 'Numerator',  ['[', num2str([0 0 0]), ']']);
set_param([MDL, '/control'], 'Denominator',['[', num2str([1 1 1]), ']']);

%%% BUILD MODEL FOR SG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rtwbuild(MDL); %%% build the code of the model (only does this once)

%% LOAD TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('### Uploading target...\n');
load(tg, fullfile(get_param(0, 'CodegenFolder'),MDL));
fprintf('### Target uploaded and ready.\n');
tg.StopTime = Inf; % No stop time by defa
