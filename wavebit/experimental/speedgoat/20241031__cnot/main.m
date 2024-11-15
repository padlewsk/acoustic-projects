%%% UPDATED: 08.11.2024
%%% DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));%
addpath('./__fun');

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct();


p.A = 0.008;% source gain (Pa)

% after a Hadamard gate
p.alpha_mat = 4.5*[sqrt(1/2) 0 0; sqrt(1/2) 0 0]; % corrections
p.beta_mat  = [sqrt(1/2) 0 0; sqrt(1/2) 0 0];

%p.theta = [0;0]; %[0 pi]  = [omega_0 omega_1]
%p.phi = [0;0]; %dephase of omega_1 w/r to omega_0

%correct wavebit amplitude difference and hamonics
%p.rho_corr = [1.28;0.9]; % FIX THIS
%p.harm_corr = [5;13];

omega_0 = 2*pi*p.freq_0;
omega_1 = 2*omega_0;
%% MEASURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_raw = SG__measure(p); %with updated parameters

%% GET DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raw_time = seconds(signal_raw.Time); %raw_time = raw_time -raw_time(1);
raw_data = signal_raw.Variables; %Pa
%%  PROCESS AND GRAPHICS 
close all

t = raw_time - raw_time(1) + 10/(2*pi*p.freq_0); % + 10/(2*pi*p.freq_0) for the pause before measurement start 

alpha_1_t = raw_data(:,1)./real(exp(-1i*omega_0*t));%% NO!
 beta_1_t = raw_data(:,2)./real(exp(-1i*omega_1*t));
alpha_2_t = raw_data(:,3)./real(exp(-1i*omega_0*t));
 beta_2_t = raw_data(:,4)./real(exp(-1i*omega_1*t));

%
figure(1)
hold on
%plot(t,raw_data(:,1))
%plot(t,raw_data(:,2))
%plot(t,raw_data(:,3))
plot(t,raw_data(:,4))
hold off

figure(2)
hold on
plot(t,alpha_1_t)
plot(t, beta_1_t)
plot(t,alpha_2_t)
plot(t, beta_2_t)
hold off
%}

%%% SPECTRUM ANALYSIS
[F,P1] = onesideft(raw_data(:,1),p.fs_ctr,1);
[F,P2] = onesideft(raw_data(:,4),p.fs_ctr,1);


figure(3)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
ylim([-100 0])
ax2=subplot(2,1,2);
plot(F,20*log10(abs(P2)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([200 8000])
ylim([-100 0])


%%% bode plot
%{
tol = 0.1;
P1_temp = P1;
P1_temp(abs(P1_temp) < tol) = 0;
theta1 = angle(P1_temp);

figure(2)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
%plot(F,movmean(angle(P1),50)/pi);
stem(F,theta1/pi,'filled')
ylim([-1 1])
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])
%}








