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

p.theta = [pi/2;0]; %[0;pi]
p.phi = [0;0]; %only affects omega_1

%correct wavebit amplitude difference and hamonics
p.rho_corr = [1.25;1];
p.harm_corr = [5;13];
%% MEASURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_raw = SG__measure(p); %with updated parameters

%% GET DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raw_time = seconds(signal_raw.Time); raw_time = raw_time -raw_time(1);
raw_data = signal_raw.Variables;
%%  PROCESS 
%%% TWO PHASE LOCKIN TECHNIQUE 
t = raw_time - raw_time(1);
U_raw = raw_data(:,1);% hann(numel(t)).*

T = raw_time(end)- raw_time(1);

U_omega0_00 = (1/T)*trapz(t,real(exp(-1i*2*pi*p.freq_0*t)).*U_raw);
U_omega0_90 = (1/T)*trapz(t,real(exp(-1i*(2*pi*p.freq_0*t + pi/2))).*U_raw);
phi_omega0 = atan2(U_omega0_90,U_omega0_00); %rad

U_omega1_00 = (1/T)*trapz(t,real(exp(-1i*(2*2*pi*p.freq_0*t + phi_omega0))).*U_raw);
U_omega1_90 = (1/T)*trapz(t,real(exp(-1i*(2*2*pi*p.freq_0*t + phi_omega0 + pi/2))).*U_raw);
phi = rad2deg(atan2(U_omega1_90,U_omega1_00)) + 165 %deg


%phi = phi_omega1 - phi_omega0







%{
U_raw = raw_data(:,1);
U_00 = interp1(t_00*2, U_raw, t_00); %time stretched
U_90 = interp1(t_00*2 + (1/p.freq_0)/4, U_raw, t_00); %time stretched + phase shifted by 90°
U_90(isnan(U_90))=0;    

T = raw_time(end)-raw_time(1);

figure()
hold on
plot(t_00,U_raw)
plot(t_00,U_00)
plot(t_00,U_90)
hold off

X = (1/T)*trapz(t_00,U_00.*U_raw);
Y = (1/T)*trapz(t_00,U_90.*U_raw);

R = sqrt(X^2 + Y^2)
phi = atand(Y./X) + 45
%}

%%
[F,P1] = onesideft(raw_data(:,1),p.fs_ctr,1);
[F,P2] = onesideft(raw_data(:,2),p.fs_ctr,1);

%% GRAPHICS 
%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf, p 69
close all

%
figure(3)
hold on
plot(t,U_raw)
plot(t, real(cos(p.theta(1)/2)*exp(-1i*2*pi*p.freq_0*t) + sin(p.theta(1)/2)*exp(1i*p.phi(1))*exp(-1i*2*2*pi*p.freq_0*t)))
hold off
%}

figure(1)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
plot(F,movmean(angle(P1),200)/pi);
ylim([-1 1])
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])

figure(2)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
plot(F,movmean(angle(P2),200)/pi);
ylim([-1 1])
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])






