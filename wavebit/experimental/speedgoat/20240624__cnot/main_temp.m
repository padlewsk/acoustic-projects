%%% UPDATED: 08.11.2023
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
p.A = 0.01;% source gain (Pa)
p.rho = [1.4;1];
p.theta = [pi/2;pi/2];
p.phi = [0;0]; %only affects omega_1

%correct wavebit amplitude difference and hamonics
p.rho_corr = [1.25;1];
p.harm_corr = [5;13];
%% MEASURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_raw = SG__measure(p);

raw_time = signal_raw.Time;
raw_data = signal_raw.Variables;
%%  PROCESS 
[F,P1] = onesideft(raw_data(:,1),p.fs_ctr,2);
[F,P2] = onesideft(raw_data(:,2),p.fs_ctr,2);

%% GRAPHICS 
%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf, p 69
close all
figure(1)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
plot(F,20*log10(abs(P2)));
%plot(F,abs(P2));
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])

%{
figure(2)
plot(F,angle(P1)/pi);
grid on
xlim([400 1400])

figure(3)
plot(F,angle(P2)/pi);
grid on
xlim([400 1600])
%}




