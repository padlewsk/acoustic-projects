%%% Generates model


%%% SG lib path
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox\SpeedGoat');

MDL = 'tf_Pb_Xi__SG'; % name of the slx model

set_param(0, 'CodegenFolder', './build/');
set_param(0, 'CacheFolder', './build/');

%%%%%%%%%%%%%%%%%%%%%%%% set the parameter values to Simulink model %%%%%%%
%%%%% for running time
set_param([MDL], 'StopTime',num2str(tmax+1)) % add extra run time

%%%%%% for high pass filters
set_param([MDL, '/Highpass Filter'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter1'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter2'], 'SampleRate', num2str(fs));
set_param([MDL, '/Highpass Filter3'], 'SampleRate', num2str(fs));

%%%%%%% For the host scope and the target scope
set_param([MDL, '/Scope '], 'nosamples', num2str(N));
set_param([MDL, '/Scope '], 'interleave', num2str(1));

set_param([MDL, '/Scope 2'], 'nosamples', num2str(N));
set_param([MDL, '/Scope 2'], 'interleave', num2str(1));
set_param([MDL, '/Scope 2'], 'triggerlevel', num2str(A - A/10));

%%%%%% for control
%{
set_param([MDL, '/control system/Phi'], 'Denominator', ['[', num2str(tf_d.den), ']']);
set_param([MDL, '/control system/Phi'], 'Numerator',  ['[', num2str(tf_d.num), ']']);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% MODEL BUILD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_system(MDL);
rtwbuild(MDL); %%% build the code of the model

tg = slrt('Performance'); %%% create objects to manipulate the target
% tg = slrt('Baseline');
fprintf('Starting target...\n');
load(tg, fullfile(get_param(0, 'CodegenFolder'), MDL));

fprintf('Target start...\n');
tg.start;

%scope rec
sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope whose id is 2
sc.start;

while strcmp(sc.Status, 'Finished')==0 
pause(0.01);   
end
fprintf('DONE\n');



