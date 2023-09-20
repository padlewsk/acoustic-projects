%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RMK: Manually update the asterixed parameters after running either

%% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Machine type
%tg_model = 'Baseline'; %target select
%MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)
tg_model = 'Performance'; %target select
MDL = 'SG__MDL_IO344'; % name of the slx model (performance)
%%% Sample time
ts = 35e-06; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
fs = 1/ts;  %% sampling frequency (Hz) %% performance: max 100000 Hz; Baseline: 50000 Kz % must be integer multiple of max freq val

%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = 0.15; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.2 (V)
tmax = 20; %% sweep up measurement time (s) 
fi = 150; %% initial frequency
ff = 1200;%1500; %% final frequency

%% CALIBRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Mic Positions
x1 = -0.15; %m
x2 = -0.10; %m
x3 = +0.10; %m
x4 = +0.15; %m
%%% Unit Cell Size
a = 0.280; %m

%% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wind = []; %floor(N/20); %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window

%% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_ssh = 0; % SSH hopping parameter -1<0<1
%% CONTROL SENSITIVITY
%%% MIC
sens_p_m =  -20.97E-3;% (V/Pa) SN6969 
sens_p_c =  -29.06E-3;% (V/Pa) SN5673 
sens_p_p =  -22.6E-3; % (V/Pa) SN6993
%sens_v= 1/(10E-3);% Vibrometer sensitivity V/(m/s) 
%%%  CURRENT TO VOLTAGE
u2i = 10e-3; %current amplifier: Maxime: 10(mA/V); Rivet: 1/103.8 (A/V) 
%%% PRESSURE TO DISPLACEMENT
tf_Pb_Xi_AVG = 925E3; %Trasnferfunction between backpressure and displacement (Pa/m) *

%% CONTROL SPEAKER PARAMETERS
%Sd: Effective piston area (m^2) 
%Mms: Moving mass (kg) **
%Rms: Mechanical resitance (N.s/m) **
%Cms: Mechanical complicance due to surround suspension and spider (m/N)
%Cab: Compliance of enclosure due to back pressure (N/m^4)
%Cmc: Total mechanical complicance (m/N) 
%Bl: Force factor (N/A) **
%Re: DC coil resistance (Ohm) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sd = 12e-4; % Same diaphragm area for both
%%% ms_estimate:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  speaker 1:
% Re_m = 7;
Bl_m = 1.297377e+00;
Rms_m = 2.969064e-01;
Mms_m = 5.289549e-04;
Cmc_m = 1.742241e-04;

%%% speaker 2:
% Re_p = 7.32;
Bl_p = 1.386104e+00;
Rms_p = 2.634393e-01;
Mms_p = 5.766732e-04;
Cmc_p = 1.799984e-04;


f0 = 1/(2*pi*sqrt(Mms_m*Cmc_m)); % Resonnance frequency (Hz)
% *  measured with ms_estimate.m 
% ** measured with tf_Pb_Xi.m 

%% CONTROL TARGET IMPEDENCE PARAMETERS FOR
%%% Target Impedance Weights
%RMKS: muR = muM = muC = 1 -> open ciWcuit; <1 reflection ; >1 absorption
muM_m = 1;%0.4 %%%(NOT STABLE <1)!!!
muR_m = 1;%0.5;
muC_m = 1;%0.4;
fst_m = f0*sqrt(muC_m/muM_m); %Target resonnance frequency


%%%  speaker 1:
%%% Transfer function Coefs
%num:
a2_m = Sd*(muM_m - 1)*Mms_m;
a1_m = Sd*(muR_m - 1)*Rms_m;
a0_m = Sd*(muC_m - 1)/Cmc_m;
%den:   
b2_m = Bl_m*muM_m*Mms_m;
b1_m = Bl_m*muR_m*Rms_m;
b0_m = Bl_m*muC_m/Cmc_m;
%Transfer function model:
%Phi_c_ = tf([a2_m,a1_m,a0_m],[b2_m,b1_m,b0]);
Phi_d_m =  c2d(tf([a2_m,a1_m,a0_m],[b2_m,b1_m,b0_m]),ts,'tustin'); %discretized (necessary for SG model)
Phi_d_m = minreal(Phi_d_m);

%%%  speaker 2:
%%% Transfer function Coefs
muM_p = 1;%muM_m*Mms_m/Mms_p;
muR_p = 1;%muR_m*Rms_m/Rms_p;
muC_p = 1;%Cmc_p/(muC_m*Cmc_m);
fst_p = f0*sqrt(muC_p/muM_p); %Target resonnance frequency

%num:
a2_p = Sd*(muM_p - 1)*Mms_p;
a1_p = Sd*(muR_p - 1)*Rms_p;
a0_p = Sd*(muC_p - 1)/Cmc_p;
%den:   
b2_p = Bl_p*muM_p*Mms_p;
b1_p = Bl_p*muR_p*Rms_p;
b0_p = Bl_p*muC_p/Cmc_p;
%Transfer function model:
%Phi_c_ = tf([a2_m,a1_m,a0_m],[b2_m,b1_m,b0]);
Phi_d_p =  c2d(tf([a2_p,a1_p,a0_p],[b2_p,b1_p,b0_p]),ts,'tustin'); %discretized (necessary for SG model
Phi_d_p = minreal(Phi_d_p);


%% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c0 = 346.13;
rho0 = 1.1839;
Zc = c0*rho0; % characteristic specific acoustic impedence at 25°C
