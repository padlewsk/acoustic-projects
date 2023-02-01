%%% 2022.04.19 Passive unit cell dispersion measurement.
close all
clear all
clc

%% START TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% REMEMBER TO FLASH
tg = slrt('Baseline');
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
%{
tg.setparam('sens_pf', 'Gain', 1/sens_pf);%
tg.setparam('i2u', 'Gain', 1/u2i);%converts current to voltage (will be converted back with u2i)
tg.setparam('control', 'Numerator', Phi_d.num{1});
tg.setparam('control', 'Denominator',Phi_d.den{1});
%}

%%% SCOPE RECORD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope 2 record
sc.NumSamples = tmax/ts;
sc.start;
tg.start; % starts target

%%% WAIT FOR INPUT SIGNAL AND MEASURE FOR tmax
while strcmpi(sc.Status, 'Ready for being Triggered') || strcmpi(sc.Status, 'Acquiring')
    pause(0.01);   
end

tg.Status;
tg.stop; % stops target
fprintf('### Measurement Complete.\n\n')


%%%
%%% RESET CONTROL BACK TO ZERO
%{
tg.setparam('control', 'Numerator', [0 0 0]);%]
tg.setparam('control', 'Denominator', [1 1 1]);
%}

%%% Estimates mechanical parameters from the measured specific acoustic
%%% impedances for the Open Circuit and Close Circuit case

%% %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('### Processing data...\n')

t = ((0:size(sc.Data, 1)-1)*ts)';
Data = sc.Data;
N = length(t);

%inputs
p1 = Data(:,1)/sens_p1;
p2 = Data(:,2)/sens_p2; %velometer
p3 = Data(:,3)/sens_p3;
p4 = Data(:,3)/sens_p4;

%%% Frequency vector
f = fi+(ff-fi)*t/tmax; %frequency vector
k = 2*pi*f/c0; %corresponding wave vector

%% Diaphragm velocity estimated from backpressure
%{
v = diff(pb/tf_Pb_Xi_AVG,N)/ts% Relation between the back pressure and the velocity (consistant for low frequency range!!!)
v(end) = nan; %adds a nan because the velocity is not defined for the last time slot
%}
%%
%[Zs,F] = tfestimate(v,pf,hamming(N/8),'',f,fs); %returns the transfer function estimate at the frequencies specified in f.OPTIMIZE

%% PRESSURE COEFFICIENTS, S-MATRIX, T-MATRIX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p_a =  1i*(p1.*exp(1i*k*x2) - p2.*exp(1i*k*x1))./(2*sin(k*abs(x1-x2)));
p_b =  - 1i*(p1.*exp(-1i*k*x2) - p2.*exp(-1i*k*x1))./(2*sin(k*abs(x1-x2)));
p_c =  1i*(p3.*exp(1i*k*x4) - p4.*exp(1i*k*x3))./(2*sin(k*abs(x3-x4)));
p_d =  - 1i*(p3.*exp(-1i*k*x4) - p4.*exp(-1i*k*x3))./(2*sin(k*abs(x3-x4)));


S11 = (p_a.*p_b-p_c.*p_d)./(p_a.^2 - p_d.^2);
S22 = S11;
S12 = (p_a.*p_c-p_b.*p_d)./(p_a.^2 - p_d.^2);
S21 = S12;

T11 = S21-(S22.*S11./S12);
T12 = S22./S12;
T21 = -S11./S12;
T22 = 1./S12;


q_real = real(acos((T11+T22)/2)/a)*a/pi;
q_imag = imag(acos((T11+T22)/2)/a)*a/pi;


%% GRAPHICS
 %%% alpha vs freq %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);

plot(q_real,f,'-r','LineWidth',3)
plot(q_imag,f,'--k','LineWidth',3)

hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
yline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
yline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([0 1]);
ylim([0 ff]);

ylabel("Frequency (Hz)")
xlabel("qa/pi")
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
%legend("\tau = " + string(tau_list*1000) + " ms",'Location','northwest')




