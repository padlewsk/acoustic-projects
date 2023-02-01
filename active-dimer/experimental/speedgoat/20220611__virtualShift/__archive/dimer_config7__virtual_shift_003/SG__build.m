%%% COMPILES AND UPLOADS SIMULINK MODEL TO SPEEDGOAT
%%% Tricks to find the parameter name
%%% https://www.mathworks.com/help/simulink/slref/block-specific-parameters.html
%%% get_param([MDL, '/source/sweep'], 'ObjectParameters')
%%% View block mask
%%% VIEW TARGET SCREEN 
%%% BE SURE TO ESTABLISH CONNECTION TO SG BEFORE FLASHING (slrtexplr) (duh...)
%%%% NEVER CLEAR --> CLEARING MESSES UP THE APP!
close all


%% ADD SG LIB PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('\\files7\data\padlewsk\My Documents\MATLAB\control-schemes\MATLAB\Speedgoat');
addpath('__fun');
%%% UPLOAD PARAMETERS 
p = param_struct(); % in case some parameters are overwritten

%% UPLOAD MODEL TO WORKSPACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load_system(p.MDL); % loads slx model defined in params.m


%% MAKE BUILD FILE TO LOCAL DIRECTORY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulink will produce multiple intermediate build files. We do not wish
% that these files pollute our working directory. Let's put them in
% ``BUILD_DIR``.
create_build_dir() ;% creates build file on local PC (runs faster) 

%% SET THE DEFAULT SIMULINK PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Setting non-tuneable parameters...\n');

%%% for running time
set_param(p.MDL, 'StopTime',num2str(Inf)) %1 more second to get all the data

%%% Set sample times to sources and SG
%
set_param([p.MDL, '/source/cnt'], 'tsamp', num2str(p.ts)); %for the digital clock



%%% Set time delay to freqeuncy at speakers due to spatial separation  (0.68m / 346m/s)
set_param([p.MDL, '/control/freq_delay_m'], 'DelayLength', num2str(round((0.61/346)/p.ts))); % NECESSARY? apparently not...
set_param([p.MDL, '/control/freq_delay_p'], 'DelayLength', num2str(round((0.75/346)/p.ts)));
%}

%%% FOR CHIRP remove?
%{
set_param([MDL, '/source/sweep'], 'Ts', num2str(ts));
set_param([MDL, '/source/random'], 'SampleTime', num2str(ts));
%}

%%% UPLOAD PARAMETERS TO SL WORKSPACE
mdlWks = get_param(p.MDL,'ModelWorkspace'); % workspace of the model



%%% For the host scope and the target scope
% set_param([MDL, '/Scope '], 'nosamples', num2str(1e6)); %same sample freq as SG
% set_param([MDL, '/Scope '], 'interleave', num2str(1));

% set_param([MDL, '/Scope 2'], 'nosamples', num2str(1e6));
% set_param([MDL, '/Scope 2'], 'interleave', num2str(1));

%%% for control (OFF BY DEFAULT)
%set_param([MDL, '/control/gain_m'], 'Gain',  num2str(Sd/Bl_m)); %% By default is 1
%set_param([MDL, '/control/gain_p'], 'Gain',  num2str(Sd/Bl_p)); %% By default is 1
%}


%%% IMPORTANT: INITIALISATION WITH NON-ZERO VALUES IS ESSENTIAL!!!
set_param([p.MDL, '/control/tf_m'], 'Numerator',  ['[', num2str([0.5 0.5 0.5]), ']']);
set_param([p.MDL, '/control/tf_m'], 'Denominator',['[', num2str([1 1 1]), ']']);

set_param([p.MDL, '/control/tf_p'], 'Numerator',  ['[', num2str([0.5 0.5 0.5]), ']']);
set_param([p.MDL, '/control/tf_p'], 'Denominator',['[', num2str([1 1 1]), ']']);


%% BUILD APPLICATION FOR SG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Building the application...\n');

slbuild(p.MDL); %%% build the code of the model (only does this once)

if strcmpi(get_param(p.MDL, 'shown'), 'off')
    % if simulink GUI of the model is not shown, close the model. It is no
    % longer needed in memory. Close it without saving it.
    close_system(p.MDL, 0);
end

fprintf('\t[DONE]\n');

app = slrealtime.Application(p.MDL); % reference to the built application

% Find the signal 'acq' in the application which will later be polled.
sigInfo = app.getSignals; % list of all the signals in the application
sigInfo = sigInfo(strcmp({sigInfo.SignalLabel}, 'acq')); % keep only one

%% LOAD TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Multiple applications can be uploaded on a single target. Each time the
% target is stopped, the correct application must first be loaded then
% started. The ``tg.load`` function will upload the *.mldatx file if not up
% to date on the target and load it.
fprintf('Loading the application...\n');

%%% UPLOAD PARAMETERS TO WORKSPACE
%params % in case some parameters are overwritten
% MDL and tg are defined there.

tg = slrealtime(p.tg_model); % target computer interface
tg.stop(); % make sure the target is stopped
tg.load(p.MDL); % loads the application in the RT target

fprintf('\t[DONE]\n');


