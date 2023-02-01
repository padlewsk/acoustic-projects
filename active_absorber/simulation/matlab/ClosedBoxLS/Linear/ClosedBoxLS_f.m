%%% CLOSED BOX LOUD SPEAKER 
%%% FREQUENCY REPRESENTATION APPROACH



close all; 
clear all; 
clc;

%% PARAMETERS

Zc = 346.13*1.1839;

%%% Speaker (Visaton AL-170)
Sd = 133E-4;    % Effective piston area [m^2]
Mms  = 13E-3;      % Moving mass [kg]
Rms = 0.6;       % Mechanical resitance [N.s/m]
Cms = 594.85E-6; % Mechanical complicance due to surround suspension and spider [m/N]
Cab = 10;       % Compliance of enclosure due to back pressure [N/m^4]
Cmc = (1/Cms + Sd^2/Cab)^-1;

f0 = 1/(2*pi*sqrt((Mms*Cms*Cab)/(Sd^2*Cms+Cab))) % Natural resonnance frequency of the speaker Hz

P0 = 101325; %atmospheric pressure [Pa]

Bl = 6.9;        % Force factor [N/A]
Le = 0.9E-3;    % Voice coil inductance [H]
Re = 5.6;       % DC coil resistance [Ohm]


% TARGET IMPEDENCE WEIGHTS
muR = 5; 
muM = 5; 
muC = 1; 

%%% TRANSFER FUNCTION COEFFICIENTS
%num:
a2 = Sd*(muM - 1)*Mms;
a1 = Sd*(muR - 1)*Rms;
a0 = Sd*(muC - 1)/Cmc ;

%den:
b2 = Bl*muM*Mms;
b1 = Bl*muR*Rms;
b0 = Bl*muC/Cmc;

%% SIMULATION

t_f = 1; %simulation time in seconds
f_i = 0.1; % Freq sweep limit
f_f = 1000; % Freq sweep limit
Dt = 0.2E-3; %Sample freq
t = 0:Dt:t_f; % time vector
f = (f_i+(f_f-f_i).*t./t_f); %Freq vector
omega = 2*pi*f;

%%% TRANSFER FUNCTION
TF = (Sd*(i*omega*(muM-1)*Mms + (muR-1)*Rms + (muC-1)./(i*omega*Cms)))./(Bl*(i*omega*(muM)*Mms + (muR)*Rms + (muC)./(i*omega*Cms))); %Transfer function: I(s) = TF(s)Pf(s)

%%% IMPEDANCES: Basic and controlled
Zas = (Mms*i*omega + Rms + 1./(Cmc*i*omega))./Sd; %Specific acoustic impedance for open circuit
Zs = Zas./(1-Bl*TF/Sd);% Effective Specific acoustic impedance of the electoacoustic absorber where the current driving the voice coil is controlled by the front pressure through the transfer function

%%% ABSORPTION
alpha_as = 1 - abs((Zas-Zc)./(Zas+Zc)).^2; %as: basic configuration: when the closed box LS is in open circuit and is not coupled to any additional resonator
alpha_s = 1 - abs((Zs-Zc)./(Zs+Zc)).^2;
 
%%%Q FACTOR ??? makes sense?
fres_as =  f(alpha_as == max(alpha_as)); % Resonant freq is defined at max absorption. ATTENTION! This differs slightly from the analitically derived res freq f0!
Deltaf_as = fwhm(f,alpha_as); % is NaN is freq start is 0
Q_as = fres_as./Deltaf_as;

fres_s =  f(alpha_s == max(alpha_s));
Deltaf_s = fwhm(f,alpha_s); % is NaN is freq start is 0
Q_s = fres_s./Deltaf_s;

%% FIGURES

figure(1)
semilogx(f,alpha_s,f,alpha_as,'--')
xlabel('Frequency (Hz)')
ylabel('Absorption Coefficient')
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
%hold off
legend(" P_f ctrl: Q = " + round(Q_s,2), " Basic: Q = " + round(Q_as,2))




figure(2)
semilogx(f,Zs,f,Zas,'--')
xlabel('Frequency (Hz)')
ylabel('Absorption Coefficient')
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
%hold off
legend(" Z_s", " Z_as")
