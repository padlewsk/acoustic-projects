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


freq = linspace(sp.fi,sp.ff,sp.f_samp)'; % frequency vector
k = 2*pi*freq/sp.c0; % free wavevector/ dispersionless omega = c0*k => v_g = v_p = c0

zs = (1i*k*sp.c0)*sp.Mms + sp.Rms + 1./((1i*k*sp.c0)*sp.Cms);
zr = sp.rho0*sp.c0 + sp.Sd/sp.S;


% Unitcell transfer matrix:
den = 2.*zs.*((-1+exp((1i*sp.a.*k))).*sp.kappa*zr + 2.*exp(1i*sp.a.*k/2).*zs);

a1 = (-1 + exp(1i*sp.a.*k)).*(sp.kappa^2 - sp.Sd^2)+zr^2;
a2 = 2*(-2*exp((1i*sp.a*k)/2)*sp.kappa + sp.Sd + exp(1i*sp.a*k)*sp.Sd).*zs*zr;
a3= 4*((exp((1i*sp.a*k)/2)*sp.kappa - sp.Sd)*zr.*zs + zs.^2);
a4 = 2*(-2*exp((1i*sp.a*k)/2)*sp.kappa + sp.Sd + exp(1i*sp.a*k)*sp.Sd).*zs*zr;
a5= exp(1i*sp.a*k)*4.*((exp((-1i*sp.a*k)/2)*sp.kappa - sp.Sd)*zr.*zs + zs.^2);

M_11 = (1./a1).*(a2 + a3);
M_12 = (1./a1).*(a2 - a4);
M_21 = (1./a1).*(-(a2 - a4));
M_22 = (1./a1).*(-a2 + a5);

