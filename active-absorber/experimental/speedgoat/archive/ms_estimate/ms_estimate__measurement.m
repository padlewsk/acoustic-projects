%%% Generates model


%%% SG lib  path
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox\SpeedGoat');

MDL = 'ms_estimate__SG'; % name of the slx model

set_param(0, 'CodegenFolder', './build/');
set_param(0, 'CacheFolder', './build/');


%%% MODEL BUILD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load_system(MDL);
rtwbuild(MDL); %%% build the code of the model

tg = slrt('Performance'); %%% create objects to manipulate the target
% tg = slrt('Baseline');

load(tg, fullfile(get_param(0, 'CodegenFolder'), MDL));


tg.start;

%scope rec
sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope whose id is 2
sc.start;

while strcmp(sc.Status, 'Finished')==0 
pause(0.01);   
end


%%
%%% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = sc.Time; 
Data = sc.Data;

pf = Data(:,1);
v = Data(:,2); %velometer

