close all; clear all; clc;


%%Parameters
% Speaker (Visaton AL-170)
Sd = 133E-4;    % Effective piston area [m^2]
Mms  = 13E-3;      % Moving mass [kg]
Rms = 0.6;       % Mechanical resitance [N.s/m]
Cms = 594.85E-6; % Mechanical complicance due to surround suspension and spider [m/N]
Cab = 10;       % Compliance of enclosure due to back pressure [N/m^4]
Bl = 6.9;        % Force factor [N/A]
Le = 0.9E-3;    % Voice coil inductance [H]
Re = 5.6;       % DC coil resistance [Ohm]

% Electrical resonator Shunt network
Ll = 3.46E-3;   % [H] 
Rl = -1.84;     % [Ohm] negative?????
Cl = 706.74E-6; % Resonatore capacitance 

%% input voltage u
freq = 5; %Hz
t = 0:0.001:1;
u = square(2*pi*t*freq)+randn(size(t))/10;%

%figure;
%plot(t,u)%