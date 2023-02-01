%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n### Measurement started...\n\n');

%%% UPLOAD SOURCE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');
tg.StopTime = Inf; 
tg.setparam('enable_source', 'Value', true); %turn source on
tg.setparam('source/use_random', 'Value', false); %use sweep

%%% UPLOAD PARAMETERS TO SWEEP

tg.setparam('source/sweep_gain', 'Gain', A)
tg.setparam('source/sweep', 'f0', fi)
tg.setparam('source/sweep', 'f1', ff)
tg.setparam('source/sweep', 't1', tmax)
tg.setparam('source/sweep', 'Tsweep', tmax)


%%% UPLOAD PARAMETERS TO CONTROL
tg.setparam('sens_pf', 'Gain', 1/sens_pf);%
tg.setparam('i2u', 'Gain', 1/u2i);%converts current to voltage (will be converted back with u2i)
tg.setparam('control', 'Numerator', Phi_d.num{1});
tg.setparam('control', 'Denominator',Phi_d.den{1});


%%% SCOPE RECORD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope 2 record
sc.NumSamples = tmax/ts;
sc.start;
tg.start; % starts target

