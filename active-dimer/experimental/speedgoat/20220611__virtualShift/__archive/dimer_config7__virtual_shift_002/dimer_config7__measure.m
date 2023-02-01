%%% 2022.04.19 Passive unit cell dispersion measurement.
close
%clear  %%% app does not work if uncommented
clc

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n### Measurement started...\n\n');

%%% UPLOAD SOURCE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m'); %selects target
tg = slrt(tg_model);
pause(0.1);
slrtpingtarget(tg,'reset');

pause(0.1)

tg.StopTime = Inf; 

%%% UPLOAD SOURCE PARAMETERS
tg.setparam('enable_source', 'Value', true); %turn source on
tg.setparam('source/sweep_gain', 'Gain', A);%
tg.setparam('source/tmax', 'Value', tmax);%
tg.setparam('source/fi', 'Value', fi);%
tg.setparam('source/ff', 'Value', ff);%
%{
tg.setparam('source/use_random', 'Value', false); %use chirp
tg.setparam('source/sweep', 'f0', fi)
tg.setparam('source/sweep', 'f1', ff) %% double to use bidirectional sweep
tg.setparam('source/sweep', 't1', tmax/2)
tg.setparam('source/sweep', 'Tsweep', tmax/2) %% half to use bidirectional sweep
%}


%
%%% UPLOAD CONTROL PARAMETERS



pause(0.1)

%%% UPLOAD PARAMETERS TO CONTROL (defaut is 0 control)
%turn control on
tg.setparam('enable_control', 'Value', true);

%ssh hopping parameter t_ssh
tg.setparam('control/t_ssh', 'Value', t_ssh);

tg.setparam('control/a', 'Value', a);
tg.setparam('control/c0', 'Value', c0);

tg.setparam('control/gain_m', 'Gain', Sd/Bl_m);%
tg.setparam('control/gain_p', 'Gain', Sd/Bl_p);%

%%%mic sensitivity
tg.setparam('control/sens_p_m', 'Gain', 1/sens_p_m);%
tg.setparam('control/sens_p_c', 'Gain', 1/sens_p_c);%
tg.setparam('control/sens_p_p', 'Gain', 1/sens_p_p);%

%transfer functions 
%
n = Phi_d_m.num{1};
d = Phi_d_m.den{1};
n = [n, zeros(1, 3-numel(n))]; 
d = [d, zeros(1, 3-numel(d))];
tg.setparam('control/tf_m', 'Numerator', n); %Block tf
tg.setparam('control/tf_m', 'Denominator', d); %Block tf

n = Phi_d_p.num{1};
d = Phi_d_p.den{1};
n = [n, zeros(1, 3-numel(n))];
d = [d, zeros(1, 3-numel(d))];
tg.setparam('control/tf_p', 'Numerator', n); %Block tf
tg.setparam('control/tf_p', 'Denominator', d); %Block tf

%current to voltage
tg.setparam('control/i2u_m', 'Gain', 1/u2i);%converts current to voltage (will be converted back with u2i)
tg.setparam('control/i2u_p', 'Gain', 1/u2i);%converts current to voltage (will be converted back with u2i)



%}

%%% SCOPE RECORD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope 2 record
sc.NumSamples = int32((2*tmax)/ts); %% double bc of bidirectional sweep
sc.start;
tg.start; % starts target
% 
%% WAIT FOR INPUT SIGNAL AND MEASURE FOR tmax
while strcmpi(sc.Status, 'Ready for being Triggered') || strcmpi(sc.Status, 'Acquiring')
    pause(0.0001);   
end

sc.stop; % stops scope (necessary?)
tg.stop; % stops target
fprintf('### Measurement Complete.\n\n')
pause(0.1);

%%%
%%% RESET CONTROL BACK TO ZERO
%{
tg.setparam('control', 'Numerator', [0 0 0]);%]
tg.setparam('control', 'Denominator', [1 1 1]);
%}

%%% Estimates mechanical parameters from the measured specific acoustic
%%% impedances for the Open Circuit and Close Circuit case

%% %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fprintf('### Processing data...\n')

Data = sc.Data; 


%run('suuu.m');

%t = ((0:size(Data, 1)-1)*ts)';
%N = length(t);

%%% Frequency vector
%f = fi+(ff-fi)*t/tmax; %frequency vector tmax is the time when the frequency reaches ff
