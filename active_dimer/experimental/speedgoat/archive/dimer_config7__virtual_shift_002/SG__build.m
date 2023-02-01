%%% COMPILES AND UPLOADS SIMULINK MODEL TO SPEEDGOAT
%%% Tricks to find the parameter name
%%% https://www.mathworks.com/help/simulink/slref/block-specific-parameters.html
%%% get_param([MDL, '/source/sweep'], 'ObjectParameters')
%%% View block mask
%%% VIEW TARGET SCREEN 
%%% BE SURE TO ESTABLISH CONNECTION TO SG BEFORE FLASHING (slrtexplr) (duh...)
%%%% NEVER CLEAR --> CLEARING MESSES UP THE APP!
close all


%%% ADD SG LIB PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('\\files7\data\padlewsk\My Documents\MATLAB\control-schemes\MATLAB\Speedgoat');
%%% UPLOAD PARAMETERS TO WORKSPACE
run('params.m'); % in case some parameters are overwritten

%%% UPLOAD MODEL TO WORKSPACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load_system(MDL); % loads slx model defined in params.m

%%% MAKE BUILD FILE TO LOCAL DIRECTORY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
create_build_dir() % creates build file on local PC (runs faster) 

%%% SET THE DEFAULT SIMULINK PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 


%%% for running time
set_param([MDL], 'StopTime',num2str(Inf)) %1 more second to get all the data

%%% Set sample times to sources and SG
%
set_param([MDL, '/source/cnt'], 'tsamp', num2str(ts)); %for the digital clock
set_param([MDL, '/IO334_IO'], 'ts', num2str(ts));%%% Because it does not accept -1 as value...


%%% Set time delay to freqeuncy at speakers due to spatial separation  (0.68m / 346m/s)
set_param([MDL, '/control/freq_delay_m'], 'DelayLength', num2str(round((0.61/346)/ts))); % NECESSARY? apparently not...
set_param([MDL, '/control/freq_delay_p'], 'DelayLength', num2str(round((0.75/346)/ts)));
%}

%%% FOR CHIRP remove?
%{
set_param([MDL, '/source/sweep'], 'Ts', num2str(ts));
set_param([MDL, '/source/random'], 'SampleTime', num2str(ts));
%}

%%% UPLOAD PARAMETERS TO SL WORKSPACE
mdlWks = get_param(MDL,'ModelWorkspace'); % workspace of the model

%%% for high pass filters
%
set_param([MDL, '/Highpass Filter'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter1'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter2'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter3'], 'SampleRate', num2str(fs));
%}

%%% For the host scope and the target scope
% set_param([MDL, '/Scope '], 'nosamples', num2str(1e6)); %same sample freq as SG
% set_param([MDL, '/Scope '], 'interleave', num2str(1));

% set_param([MDL, '/Scope 2'], 'nosamples', num2str(1e6));
% set_param([MDL, '/Scope 2'], 'interleave', num2str(1));

%%% for control (OFF BY DEFAULT)
%set_param([MDL, '/control/gain_m'], 'Gain',  num2str(Sd/Bl_m)); %% By default is 1
%set_param([MDL, '/control/gain_p'], 'Gain',  num2str(Sd/Bl_p)); %% By default is 1
%}

%% IMPORTANT: INITIALISATION WITH NON-ZERO VALUES IS ESSENTIAL!!!
set_param([MDL, '/control/tf_m'], 'Numerator',  ['[', num2str([0.5 0.5 0.5]), ']']);
set_param([MDL, '/control/tf_m'], 'Denominator',['[', num2str([1 1 1]), ']']);

set_param([MDL, '/control/tf_p'], 'Numerator',  ['[', num2str([0.5 0.5 0.5]), ']']);
set_param([MDL, '/control/tf_p'], 'Denominator',['[', num2str([1 1 1]), ']']);


%%% BUILD MODEL FOR SG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rtwbuild(MDL); %%% build the code of the model (only does this once)

%% LOAD TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%run('SG__load')

%%% UPLOAD PARAMETERS TO WORKSPACE
run('params.m') % in case some parameters are overwritten
% MDL and tg are defined there.

%% LOAD TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('### Uploading target...\n');
tg = slrt(tg_model);

load(tg, fullfile(get_param(0, 'CodegenFolder'),MDL));
fprintf('### Target uploaded and ready.\n');
tg.StopTime = Inf; % No stop time by defa
tg.set('CommunicationTimeOut', 50); %%%tg.stop >> Performance: TCP/IP timeout while receiving data 


