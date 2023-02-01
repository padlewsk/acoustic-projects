%% SENSITIVITY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Default sensitivity/gain for each input
sens_pf = 0.04; %Pa/V
sens_pb = 0.04; % Pa/V
sens_v = 10E-3;% Vibrometer range(m/s)/V 

%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmax = 20; %% total mesaurement time (s)

fi = 50; %% initial frequency
ff = 1000; %% final frequency

fs = 40000; %40*ff; %% sampling frequency (Hz)
ts = 1/fs; %% % sampling period (s)

t = (0:ts:tmax)'; %time vector
f = fi+(ff-fi)*t/tmax; %frequency vector

N = length(t); %Number of samples

A = 0.04; %% source amplitude (V)

%% MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Zc = 346.13*1.1839; % characteristic specific acoustic impedence at 25°C

%%% Default Speaker Params (Visaton AL-170)
Sd = 133E-4;    % Effective piston area [m^2]
Mms  = 13E-3;      % Moving mass [kg] **
Rms = 0.6;       % Mechanical resitance [N.s/m] **
Cms = 594.85E-6; % Mechanical complicance due to surround suspension and spider [m/N]
Cab = 10;       % Compliance of enclosure due to back pressure [N/m^4]
%Cmc = (1/Cms + Sd^2/Cab)^-1; % **
Cmc = 5.9485e-04 % [m/N] % **

f0 = 1/(2*pi*sqrt((Mms*Cms*Cab)/(Sd^2*Cms+Cab))); % Resonnance frequency Hz

Bl = 6.9;        % Force factor [N/A] **
Le = 0.9E-3;    % Voice coil inductance [H] NOT NECESSARY
Re = 5.6;       % DC coil resistance [Ohm] 

% ** are measured with ms_estimate.m 

%%% TARGET IMPEDENCE WEIGHTS 
%%% muR = muM = muC = 1 -> open circuit
%%% <1 reflection ; >1 absorption
muR = (Zc/(Rms/Sd)); % Optimal absorption = Zc/Zas
muM = 1; 
muC = 1; 
fst = f0*sqrt(muC/muM); %Target resonnance frequency

%%% TRANSFER FUNCTION COEFFICIENTS
%num:
a2 = Sd*(muM - 1)*Mms;
a1 = Sd*(muR - 1)*Rms;
a0 = Sd*(muC - 1)/Cmc ;

%den:
b2 = Bl*muM*Mms;
b1 = Bl*muR*Rms;
b0 = Bl*muC/Cmc;