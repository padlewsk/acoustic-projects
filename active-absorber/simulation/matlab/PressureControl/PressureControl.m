close all; clear all; clc;

%% Parameters 

% Speaker (Visaton AL-170)
S_d = 133E-4;% Effective piston area [m^2]
M_ms  = 13E-3;% Moving mass [kg]
R_ms = 0.6;% Mechanical resitance [N.s/m]
C_ms = 594.85E-6;% Mechanical complicance due to surround suspension and spider [m/N]
C_ab = 10;% Compliance of enclosure due to back pressure [N/m^4]
Bl = 6.9;% Force factor [N/A]
rho = 1.2;%kg/m^3
c = 343.86;%m/s
mu = 0.15;


t = 0:0.01:50;
p = sin(2*pi*t*2); % sin pressure source

figure;
plot(t,p)