%%% SCATTERING THROUGH AN INFINITE ACOUSTIC LINER IN FREQUENCY DOMAIN %%%%%%%%%%%%%%%%%%
%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
sp = sys_params();
sp.kappa = 0.8*sp.Sd % RMK: Sd in the time domain code is found in the odecrystal part...


freq = linspace(sp.fi,sp.ff,sp.f_samp)'; % frequency vector
k = 2*pi*freq/sp.c0; % free space wavevector/ dispersionless omega = c0*k => v_g = v_p = c0

zs = (1i*k*sp.c0)*sp.Mms + sp.Rms + 1./((1i*k*sp.c0)*sp.Cms);
zr = sp.rho0*sp.c0 + sp.Sd/sp.S;


% Unitcell transfer matrix:
num = 4*zs.*(1i*sp.kappa*zr*sin((sp.a*k)/2)+zs);
den = -(sp.kappa-sp.Sd)*(sp.kappa+sp.Sd)*zr.^2*(-1+cos(sp.a*k)) - 4*1i*zr*(sp.kappa*sin((sp.a*k)/2) - sp.Sd*sin(sp.a*k)).*zs + 4*cos(sp.a*k).*zs.^2;

q_F  = asec(num./den)/sp.a;


%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc

figure()
plot(abs(real(q_F)),freq)
hold on
plot(abs(imag(q_F)),freq)
hold off