%%% LIST OF PARAMETERS
%%% RMK: Manually update the asterixed parameters after running either
%%% setup__main
%% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c0 = 346.13;
rho0 =1.1839;
Zc = c0*rho0; % characteristic specific acoustic impedence at 25°C

t_ssh = 0.5;
%% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tg_model = 'Baseline'; %target select
MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)

%tg_model = 'Performance'; %target select
%MDL = 'SG__MDL_IO344'; % name of the slx model (performance)

%% SENSITIVITY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% CONTROL
%%% Default sensitivity/gain for each input
sens_pf = 20.1E-3;% (V/Pa) SN6979 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_pb = 26.5E-3; % (V/Pa) SN6994 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_v = 1/(10E-3);% Vibrometer sensitivity V/(m/s) 
u2i = 1/103.8; %current amplifier: Maxime: 10E-3 (A/V); Rivet: 1/103.8 (A/V) 
tf_Pb_Xi_AVG = 925E3; %Trasnferfunction between backpressure and displacement (Pa/m) *

%%% TRANSFER MATRIX
sens_p1 = 20.1E-3;% (V/Pa) SNXXXX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_p2 = 20.1E-3;% (V/Pa) SNXXXX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_p3 = 20.1E-3;% (V/Pa) SNXXXX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sens_p4 = 20.1E-3;% (V/Pa) SNXXXX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% MIC POSITIONS;
x1 = -0.15; %m
x2 = -0.10; %m
x3 = +0.10; %m
x4 = +0.15; %m

%% UNIT CELL SIZE
a = 0.280;

%% SAMPLING FREQUENCY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = 30000; %40*ff; %% sampling frequency (Hz) %% PERHAPS 40000 is too high for baseline
ts = 1/fs; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED

%% DEFAULT SOURCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmax = 15; %% sweep up measurement time (s) 

fi = 150; %% initial frequency
ff = 1200;%1500; %% final frequency

A = 0.2; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.2 (V)

%t = (0:ts:tmax-ts)'; %time vector
%N = length(0:ts:tmax)-1; %Number of samples

%%% Frequency vectors (bidirectional)
%f = fi + ((ff-fi)/tmax).*t(1:N/2); %%%linear frequency vector
%f = fi + ((ff-fi)/tmax).*t(1:N/2).^2; %%%quadratic frequency vector
%f = fi + 10.^(log10(ff-fi)/(tmax/2).*t(1:N/2)); %%%logarithmic frequency vector
%f = [f;flip(f)]; 

%k = 2*pi*f/c0; %corresponding wave vector


%source = sin(2*pi*f.*t);%+randn(size(t))/10; %noisy chirp

%}

%% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wind = []; %floor(N/20); %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window
%% MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Default Speaker Params 
Sd = 12E-4;    % Effective piston area (m^2) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Mms  = 0.5E-3;      % Moving mass (kg) **
Rms = 0.2;       % Mechanical resitance (N.s/m) **
Cms = 490E-6; % Mechanical complicance due to surround suspension and spider (m/N)
Cab = 10;       % Compliance of enclosure due to back pressure (N/m^4)
%Cmc = (1/Cms + Sd^2/Cab)^-1; %Total mechanical complicance (m/N) 
Cmc = 5.9485e-04; % (m/N) % **

%Bl = 6.9;        % Force factor (N/A) **
%Le = 0.9E-3;    % Voice coil inductance (H) NOT NECESSARY
Re = 6.8;       % DC coil resistance (Ohm) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ms_estimate:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% window = 150-400 Hz
Bl = 1.229965e+00;
Rms = 5.799910e-01;
Mms = 4.227782e-04;
Cmc = 2.188790e-04;

f0 = 1/(2*pi*sqrt(Mms*Cmc)); % Resonnance frequency (Hz)

%%% PULSE window = 150-400 Hz;
%{
Bl = 3.351;
Rms = 0.6943;
Mms = 2.9e-03;
Cmc = 2.0656e-04;
%}
 



%% TARGET IMPEDENCE WEIGHTS 
%%% muR = muM = muC = 1 -> open circuit
%%% <1 reflection ; >1 absorption
muR = 1;%(Zc/(Rms/Sd)); % Optimal absorption = Zc/Zas
muM = 1; %%%(NOT STABLE <1)!!!
muC = 1; 

fst = f0*sqrt(muC/muM); %Target resonnance frequency

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

