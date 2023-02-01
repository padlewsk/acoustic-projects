%%% ACOUSTIC SSH MODEL %%%%%%%%%%%%%%%%%%

%%% https://www.animations.physics.unsw.edu.au/jw/compliance-inertance-impedance.htm
clear all
close all
clc

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');
L = sqrt(Sd);
f = 1:10:1000;
omega = 2*pi*f;
k = omega./c0;

Z0 = Zc;% characteristic acoustic impedance


Zs = (Mms*(1i*omega) + Rms + 1./(1i*omega*Cmc))/Sd; %specific acoustic impedance of the liner
%% SIMULATION
Zeff_s = (4*Z0*Zs./((Z0+Zs).^2)).*exp(-1i*k*2*L);

p_inc = 1;

p_tra = Zeff_s.*p_inc.*exp(-1i*k*L);

p_ref = (Z0-Zs)./(Z0+Zs).*p_inc;

T = p_tra./p_inc;
R = p_ref./p_inc;

S12 = Zeff_s.^2.*exp(1i*k.*2*L); % = S12
S21 = Zeff_s.^2.*exp(-1i*k*2*L); % = S21

T = abs(S12).^2;
R = abs(S12).^2;;

%alpha = 1- abs(R).^2-abs(T).^2;



figure(1)
hold on
%plot(f,alpha)
plot(f,abs(R))
plot(f,abs(T))
hold off
%ylim([0,1]);
xlabel("Frequency (Hz)")

box on
grid on
str = {'\alpha','R','T'};
legend(str, 'Location','NW')