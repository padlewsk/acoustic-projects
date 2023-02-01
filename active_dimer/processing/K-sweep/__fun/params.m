%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RMK: Manually update the asterixed parameters after running either

%% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c0 = 347.13; % 300K
rho0 = 1.1839;
Zc = c0*rho0; % characteristic specific acoustic impedence at 300K


%% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Machine type
%tg_model = 'Baseline'; %target select
%MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)
tg_model = 'Performance'; %target select
MDL = 'SG__MDL_IO344'; % name of the slx model (performance)
%%% Sample time
%ts = 35e-06; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
fs = 2^16;  %% fs = 2^15; sampling frequency (Hz) %% performance: max 100000 Hz; Baseline: 50000 Kz % must be integer multiple of max freq val
ts = 1/fs; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED

% ts = 25e-06; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
% fs = 1/ts; 
% 


%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = 0.06; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.0.15 (V)
tmax = 10; %%20 sweep up measurement time (s) 
fi = 150; %% initial frequency
ff = 1200;%1500; %% final frequency
%% CALIBRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Mic Positions (wtr centre)

% x1 = -0.15; %m
% x2 = -0.10; %m
% x3 = +0.10; %m
% x4 = +0.15; %m

x1 = -0.34; %m
x2 = -0.29; %m
x3 = +0.29; %m
x4 = +0.34; %m

%%% Unit Cell 
a = 0.2806; %m 

offset = -a/2; %m %shift of centre of unit cell wrt centre ( it doesn't matter...)
%a = 0.055; %m

%% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wind = []; %floor(N/20); %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window

%% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_ssh = 0; % SSH hopping parameter -1<0<1

%% CONTROL SENSITIVITY
%%% MIC
sens_p_c =  -20.00E-3;% (V/Pa) SN6969 
sens_p_p =  -22.39E-3;% (V/Pa) SN6993
sens_p_m =  -29.86E-3;% (V/Pa) SN5673 

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
%Re: DC coil resistance (Ohm) 

Sd = 12e-4; % Same diaphragm area for both
%%% ms_estimate:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% speaker 1: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %Re_m = 7;
Bl_m  = 1.0837;
Rms_m = 0.3708;
Mms_m = 5.4332e-04;
Cmc_m = 1.735e-04;%1.7502e-04;%

f0_m = 1/(2*pi*sqrt(Mms_m*Cmc_m)); % Resonnance frequency (Hz)

%%% speaker 2: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Re_p = 7.32;
Bl_p  = 1.3803;
Rms_p = 0.3005;
Mms_p = 6.1805e-04;
Cmc_p = 1.705e-04;%1.7219e-04;%

f0_p = 1/(2*pi*sqrt(Mms_p*Cmc_p)); % Resonnance frequency (Hz)
% *  measured with ms_estimate.m 
% ** measured with tf_Pb_Xi.m 

%% CONTROL TARGET IMPEDENCE PARAMETERS FOR
%%% Target Impedance Weights%%% 

%%% speaker 1: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RMKS: muR = muM = muC = 1 -> open ciWcuit; <1 reflection ; >1 absorption
muM_m = 0.5;%muM_p*Mms_p/Mms_m;;%0.4;
muR_m = 0.09;%muR_p*Rms_p/Rms_m;%0.5;
muC_m = 0.42;% (muC_p*Cmc_m)/Cmc_p;% 0.3125;
fst_m = f0_m*sqrt(muC_m/muM_m); %Target resonnance frequency


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
Phi_c_m = tf([a2_m,a1_m,a0_m],[b2_m,b1_m,b0_m]);%/(sens_p_m*u2i);
Phi_d_m =  c2d(Phi_c_m,ts,'tustin'); %discretized (necessary for SG model)
Phi_d_m = minreal(Phi_d_m);
    
%%%  speaker 2: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Transfer function Coefs 
muM_p = muM_m*Mms_m/Mms_p;
muR_p = muR_m*Rms_m/Rms_p;
muC_p = (muC_m*Cmc_p)/Cmc_m;
fst_p = f0_p*sqrt(muC_p/muM_p); %Target resonnance frequency

%%% Transfer function Coefs
%num:
a2_p = Sd*(muM_p - 1)*Mms_p;
a1_p = Sd*(muR_p - 1)*Rms_p;
a0_p = Sd*(muC_p - 1)/Cmc_p;
%den:   
b2_p = Bl_p*muM_p*Mms_p;
b1_p = Bl_p*muR_p*Rms_p;
b0_p = Bl_p*muC_p/Cmc_p;
%Transfer function model:
Phi_c_p = tf([a2_p,a1_p,a0_p],[b2_p,b1_p,b0_p]);%/(sens_p_p*u2i);
Phi_d_p =  c2d(Phi_c_p,ts,'tustin'); %discretized (necessary for SG model
Phi_d_p = minreal(Phi_d_p);
