close all
clear all
clc
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));%
addpath('./__fun');
%%

omega_0 = 2*pi*50;
omega_1 = 2*omega_0;
fs = 100*omega_0/(2*pi); %sampling freq
ts = 1/fs;
tspan = [0 5*2*pi/omega_0]; % time range s

theta0= [pi/2;pi/2];
phi0= [0;0];

x0 = [1; 1; 0; 0]; % initial conditions [a1, b1, a2, b2]
%simulation
[t_out, x_out] = ode89(@coupled_oscillator, tspan, x0);

%interpolation
t_interp = [tspan(1):ts:tspan(2)]';
x_interp = interp1(t_out,x_out,t_interp);

figure(1);
plot(t_interp, real(x_interp(:,3)), 'r', t_interp, real(x_interp(:,4)), 'b');
%plot(t_interp, real(x_interp(:,1)+x_interp(:,2)));

xlabel('Time');
ylabel('Prob amplitude');
legend('x1', 'x2');
title('Entangled state');

T = (2*pi/omega_0); % integrate over N moments

t_integral = t_interp(t_interp > t_interp(end)-T);
x_integral = x_interp(t_interp > t_interp(end)-T,:); %last N moments of data

x_norm_1 = 1/T*trapz(conj(x_integral(:,1)).*x_integral(:,1));
x_norm_2 = 1/T*trapz(conj(x_integral(:,2)).*x_integral(:,2));
x_norm_tot = x_norm_1 + x_norm_2;

%expectation_value_1 = 1/T*trapz(conj(x_integral(:,1)).*x_integral(:,1))/x_norm
%expectation_value_2 = 1/T*trapz(conj(x_integral(:,2)).*x_integral(:,2))/x_norm


proj_on_0_1 = abs(1/T*trapz(exp(+1i*omega_0*t_integral).*x_integral(:,1))/x_norm_1);
proj_on_1_1 = abs(1/T*trapz(exp(+1i*omega_1*t_integral).*x_integral(:,1))/x_norm_1);

proj_on_0_2 = abs(1/T*trapz(exp(+1i*omega_0*t_integral).*x_integral(:,2))/x_norm_2);
proj_on_1_2 = abs(1/T*trapz(exp(+1i*omega_1*t_integral).*x_integral(:,2))/x_norm_2);
%{
%%% SPECTRUM ANALYSIS
[F,P1] = onesideft(x_interp(:,1),fs,2);

% Plot the single-sided amplitude spectrum
figure(3);
plot(F*pi,abs(P1)) 
xlim([0 10*omega_0/(2*pi)])
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
%}