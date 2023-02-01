%%% 2022.09.06 Passive unit cell dispersion measurement.
close
%clear  %%% app does not work if uncommented
%clc
%clear run

addpath('__fun');
%%% UPLOAD PARAMETERS 
p = param_struct(); % in case some parameters are overwritten

%% START APPLICATION
% The ``tg.start`` function starts the target. The option
% ``AutoImportFileLog`` is passed to the ``tg.start`` function to specify
% if the file log should automatically be imported when the application
% stops. In this example, we explicitly control when the file logging is
% active and will manually import it.
fprintf('Loading the application...\n');
tg = slrealtime(p.tg_model); % target computer interface
tg.stop(); % make sure the target is stopped

tg.load(p.MDL); % loads the application in the RT target

fprintf('\t[DONE]\n');

%% SET PARAMETERS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% UPLOAD SOURCE PARAMETERS 

tg.setparam([p.MDL, '/enable_source'], 'Value', true); %turn source on
tg.setparam([p.MDL, '/source/sweep_gain'], 'Gain', p.A);%
tg.setparam([p.MDL, '/source/tmax'], 'Value', p.tmax);%
tg.setparam([p.MDL, '/source/fi'], 'Value', p.fi);%
tg.setparam([p.MDL, '/source/ff'], 'Value', p.ff);%


% SET ACQUISITION TIME 
tg.setparam([p.MDL, '/Triggered Pulse'], 'N', uint32((2*p.tmax)/p.ts) + 1);

% UPLOAD CONTROL PARAMETERS 
% (defaut is 0 control)

%turn control on
tg.setparam([p.MDL, '/enable_control'], 'Value', true);

%ssh hopping parameter t_ssh
tg.setparam([p.MDL, '/control/t_ssh'], 'Value', p.t_ssh);

tg.setparam([p.MDL, '/control/a'], 'Value', p.a);
tg.setparam([p.MDL, '/control/c0'], 'Value',p.c0);

tg.setparam([p.MDL, '/control/gain_m'], 'Gain', p.Sd/p.Bl_m);%
tg.setparam([p.MDL, '/control/gain_p'], 'Gain', p.Sd/p.Bl_p);%

% mic sensitivity
tg.setparam([p.MDL, '/control/sens_p_m'], 'Gain', 1/p.sens_p_m);%
tg.setparam([p.MDL, '/control/sens_p_c'], 'Gain', 1/p.sens_p_c);%
tg.setparam([p.MDL, '/control/sens_p_p'], 'Gain', 1/p.sens_p_p);%

% transfer functions 
%
n = p.Phi_d_m.num{1};
d = p.Phi_d_m.den{1};
n = [n, zeros(1, 3-numel(n))]; 
d = [d, zeros(1, 3-numel(d))];
tg.setparam([p.MDL, '/control/tf_m'], 'Numerator', n); %Block tf
tg.setparam([p.MDL, '/control/tf_m'], 'Denominator', d); %Block tf

n = Phi_d_p.num{1};
d = Phi_d_p.den{1};
n = [n, zeros(1, 3-numel(n))];
d = [d, zeros(1, 3-numel(d))];
tg.setparam([MDL, '/control/tf_p'], 'Numerator', n); %Block tf
tg.setparam([MDL, '/control/tf_p'], 'Denominator', d); %Block tf

% current to voltage
tg.setparam([MDL, '/control/i2u_m'], 'Gain', 1/u2i);%converts current to voltage (will be converted back with u2i)
tg.setparam([MDL, '/control/i2u_p'], 'Gain', 1/u2i);%converts current to voltage (will be converted back with u2i)

% record data from start
% make a short pulse of the Constant block 'rec'
tg.setparam([MDL, '/rec'], 'Value', true);

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Measuring...\n');
tg.start('AutoImportFileLog', false);
tg.setparam([MDL, '/rec'], 'Value', false);
% wait until the signal 'acq' is false, meaning the acquisition is over
while tg.getsignal(sigInfo.BlockPath, sigInfo.PortIndex)
    pause(0.1);
end

%fprintf('\t[DONE]\n');

%% TARGET STOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% When the target is stopped, it cannot be started using ``tg.start()``.
% You must first load the application again.

tg.stop; % stops target
fprintf('\t[DONE]\n');
pause(0.1);

%% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Fetching data from target...\n');

tg.FileLog.import(p.MDL); % import the file log in the SDI
sigData = get_last_acquisition(tg, {'data.p1', 'data.p2', 'data.p3', 'data.p4'}); % c.f. function
%sigData = get_last_acquisition({'data.ao', 'data.ai'});

fprintf('\t[DONE]\n');

%% Display the signals
%{
fprintf('Displaying the signals...\n');
figure();
for i = 1:size(sigData, 2)
plot(sigData.Time, sigData(:, i).Variables, ...
    'DisplayName', sigData.Properties.VariableNames{i});
hold on;
end
legend show;
xlabel('Time [s]');
pause(0); % force rendering of the figure before next loop

fprintf('\t[DONE]\n');
%}

Data = sigData.Variables; % store data in data array


%run('suuu.m');

%t = ((0:size(Data, 1)-1)*ts)';
%N = length(t);

%%% Frequency vector
%f = fi+(ff-fi)*t/tmax; %frequency vector tmax is the time when the frequency reaches ff
