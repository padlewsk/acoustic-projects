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

p.theta = [pi/2; 0]; %[0;pi]  = [omega_0, omega_1]
p.phi = [3*pi/2;0]; %dephase of omega_1 w/r to omega_0

%correct wavebit amplitude difference and hamonics
p.rho_corr = [1.25;1];
p.harm_corr = [5;13];
%% MEASURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_raw = SG__measure(p); %with updated parameters

%% GET DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raw_time = seconds(signal_raw.Time); %raw_time = raw_time -raw_time(1);
raw_data = signal_raw.Variables; %Pa
%%  PROCESS 
%%% TWO PHASE LOCKIN TECHNIQUE 
t = raw_time - raw_time(1);%!!!!
U_raw = raw_data(:,1);% hann(numel(t)).*

T = t(end)- t(1); 

X_omega_0 = (1/T)*trapz(t,real(exp(-1i*p.omega_0*t)).*U_raw);
Y_omega_0 = (1/T)*trapz(t,real(exp(-1i*(p.omega_0*t + pi/2))).*U_raw);
R_omega_0 = 2*sqrt(X_omega_0^2 + Y_omega_0^2); %%%!!! 2X?
phi_omega_0 = atan2(Y_omega_0,X_omega_0); %rad

%
X_omega_1 = (1/T)*trapz(t,real(exp(-1i*(p.omega_1*t))).*U_raw);
Y_omega_1 = (1/T)*trapz(t,real(exp(-1i*(p.omega_1*t + pi/2))).*U_raw);
R_omega_1 = 2*sqrt(X_omega_1^2 + Y_omega_1^2);%%%!!! 2X?
phi_omega_1 = atan2(Y_omega_1,X_omega_1); %rad
%}

%{
figure()
hold on
plot(t,U_raw,'r-','LineWidth',2)
plot(t,R_omega_0*real(exp(-1i*(p.omega_0*t+phi_omega_0))),'k--','LineWidth',1)
plot(t,R_omega_1*real(exp(-1i*(p.omega_1*t + phi_omega_1))),'k--','LineWidth',1)
plot(t,real(R_omega_0*exp(-1i*(2*pi*p.freq_0*t + phi_omega_0)) + R_omega_1*exp(-1i*(p.omega_1*t + phi_omega_1))),'k-','LineWidth',1)
hold off
xlim([0 5/p.freq_0])
legend("raw","\omega_0","\omega_1","\omega_0  + \omega_1")
title("")
%}


%  relative phase in degrees cf: 20240702
phi  = mod(rad2deg(angle(exp(1i*(-(phi_omega_1 - p.omega_1/p.omega_0*phi_omega_0))))) - 90,360) %%  relative phase why 90??
%rad2deg(p.phi(1))

%{
X_omega_2 = (1/T)*trapz(t,real(R_omega_0*exp(-1i*(p.omega_0*t + phi_omega_0)) + R_omega_1*exp(-1i*(p.omega_1*t + phi_omega_1))).*U_raw);
Y_omega_2 = (1/T)*trapz(t,real(R_omega_0*exp(-1i*(p.omega_0*t + phi_omega_0 + pi/2)) + R_omega_1*exp(-1i*(p.omega_1*t + phi_omega_1 + pi/2))).*U_raw);
%R_omega_2 = 2*sqrt(X_omega_1^2 + Y_omega_1^2);%%%!!! 2X?
phi_omega_2 = atan2(Y_omega_2,X_omega_2); %rad
rad2deg( phi_omega_2)
%}
%%
[F,P1] = onesideft(raw_data(:,1),p.fs_ctr,1);
[F,P2] = onesideft(raw_data(:,2),p.fs_ctr,1);

%% GRAPHICS 
%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf, p 69
close all

%
figure(1)
hold on
plot(t,U_raw)
plot(t, real(cos(p.theta(1)/2)*exp(-1i*p.omega_0*t) + sin(p.theta(1)/2)*exp(1i*p.phi(1))*exp(-1i*p.omega_1*t)))
hold off
%}

figure(2)
hold on
plot(t,U_raw,'-','LineWidth',2)
plot(t,R_omega_0*real(exp(-1i*(p.omega_0*t + phi_omega_0))),'--','LineWidth',1)
plot(t,R_omega_1*real(exp(-1i*(p.omega_1*t + phi_omega_1))),'--','LineWidth',1)
plot(t,real(R_omega_0*exp(-1i*(p.omega_0*t + phi_omega_0)) + R_omega_1*exp(-1i*(p.omega_1*t + phi_omega_1))),'-','LineWidth',1)
%plot(t,real(exp(-1i*phi_omega_0)*(R_omega_0*exp(-1i*(p.omega_0*t)) + exp(1i*(phi_omega_0 - phi_omega_1))*R_omega_1*exp(-1i*(p.omega_1*t)))),'-','LineWidth',1)
hold off
box on
xlim([0 5/p.freq_0])
legend("raw","\psi_0","\psi_1","\psi")
title("")




%%% bode plots
%%% wb 1
tol = 0.1;
P1_temp = P1;
P1_temp(abs(P1_temp) < tol) = 0;
theta1 = angle(P1_temp);

figure(3)
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

%%% wb 2
%{
tol = 0.01;
P2_temp = P2;
P2_temp(abs(P2_temp) < tol) = 0;
theta2 = angle(P2_temp);

figure(4)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
%plot(F,movmean(angle(P2),50)/pi);
stem(F,theta2/pi,'filled')
ylim([-1 1])
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])
%}


autoArrangeFigures




