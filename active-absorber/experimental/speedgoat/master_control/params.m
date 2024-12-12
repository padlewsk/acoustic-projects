%%% LIST OF PARAMETERS
%%% RMK: Manually update the asterixed parameters after running either
%%% setup__main

%% SENSITIVITY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Default sensitivity/gain for each input
sens_pf = -34e-3;%20.1E-3;% (V/Pa) SN6969 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_pb = 26.5E-3; % (V/Pa) SN6994 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_v = 1/(10E-3);% Vibrometer sensitivity V/(m/s) 
u2i = 1/103.8; %current amplifier: Maxime: 10E-3 (A/V); Rivet: 1/103.8 (A/V) 
tf_Pb_Xi_AVG = 925E3; %Trasnferfunction between backpressure and displacement (Pa/m) *

%% SAMPLING FREQUENCY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ts =  2.5e-5; %sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
fs = 1/ts; %*ff; %% sampling frequency (Hz)
%% DEFAULT SOURCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmax = 40; %% default mesaurement time (s) 

fi = 80; %% initial frequency 250
ff = 1000; %% final frequency 1500
A = 0.02; %% source amplitude (V) Tannoy: 0.02 (V)

%{
%t = (0:ts:tmax)'; %time vector
%f = fi+(ff-fi)*t/tmax; %frequency vector

%N = length(0:ts:tmax); %Number of samples
%}
%% MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Zc = 346.13*1.1839; % characteristic specific acoustic impedence at 25°C

%%% Default Speaker Params 
%Sd:Effective piston area (m^2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mms: Moving mass (kg) **
%Rms: Mechanical resitance (N.s/m) **
%Cms: Mechanical complicance due to surround suspension and spider (m/N)
%Cab: Compliance of enclosure due to back pressure (N/m^4)
%Cmc: Total mechanical complicance (m/N) 
%Bl: Force factor (N/A) **
%Le: Voice coil inductance (H) NOT NECESSARY
%Re: DC coil resistance (Ohm) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% VISATON FRWS 5 - 8 Ohm
%
Sd = 12E-4;
Bl =  1.380386307533469;
Rms =  0.300559234875887;
Mms =  6.180521751573591e-04;
Cmc = 1.721909686896559e-04;
%}

%%% VISATON SPX-30M
%{
Sd =  32e-4;
Bl = 3.351;
Rms = 0.6943;
Mms = 2.9e-03;
Cmc = 2.0656e-04;
%}
 
f0 = 1/(2*pi*sqrt(Mms*Cmc)) % Resonnance frequency (Hz)


%% TARGET IMPEDENCE WEIGHTS 
%%% muR = muM = muC = 1 -> open circuit
%%% <1 reflection ; >1 absorption
muM = 1; %%%(NOT STABLE <1)!!!
muR = 0.05; % Optimal absorption = Zc/Zas = 1.9055
muC = 1; %0.5

fst = f0*sqrt(muC/muM) %Target resonnance frequency

%% TRANSFER FUNCTION COEFFICIENTS
%num:
a2 = Sd*(muM - 1)*Mms;
a1 = Sd*(muR - 1)*Rms;
a0 = Sd*(muC - 1)/Cmc;

%den:
b2 = Bl*muM*Mms;
b1 = Bl*muR*Rms;
b0 = Bl*muC/Cmc;

% Transfer function model
Phi_c = tf([a2,a1,a0],[b2,b1,b0]);
Phi_d =  c2d(Phi_c,ts,'tustin'); %discretized (necessary for SG model)

% *  measured with ms_estimate.m 
% ** measured with tf_Pb_Xi.m 
