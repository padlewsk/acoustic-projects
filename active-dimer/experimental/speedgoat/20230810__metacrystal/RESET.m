
addpath('__fun');
    %%% UPLOAD PARAMETERS 
p = param_struct(); % in case some parameters are overwritten
tg = slrealtime(p.tg_model);
tg.stop
tg.update
tg.status
%run SG__build