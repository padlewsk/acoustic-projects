function params = param_struct();

    params = struct;

    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% RMK: Manually update the asterixed parameters after running either
    
    %% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.c0 = 347.13; % 300K
    params.rho0 = 1.1839;
    params.Zc = params.c0*params.rho0; % characteristic specific acoustic impedence at 300K
    
    
    %% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Machine type
    %tg_model = 'Baseline'; %target select
    %MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)
    params.tg_model = 'Mobile'; %target select
    params.MDL = 'SG__MDL_IO104_IO135_NL'; % name of the slx model (performance)
    %%% Sample time
    %ts = 35e-06; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
    % fs = 2^16;  %% fs = 2^15; sampling frequency (Hz) %% performance: max 100000 Hz; Baseline: 50000 Kz % must be integer multiple of max freq val
    % ts = 1/fs; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
    
    params.ts_ctrl = 50e-06; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
    params.fs_ctrl = 1/params.ts_ctrl ; 

    params.ts_acq = 50e-06; %% % sampling time (s) %%% CANNOT CHANGE ONCE FLASHED
    params.fs_acq = 1/params.ts_acq; 
     
    
    
    %% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.A = 1; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.15 (V)
    params.tmax = 10; %% sweep up measurement time (s) Full measurement time is 2*tmax
    params.fi = 150;%150; %% initial frequency
    params.ff = 1200;%1200;%1500; %% final frequency
    
    params.use_cst = true;%false;  %use constant sine source 
    params.cst_freq = 1000; %use this for default constant sign generatrion


    %% CALIBRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Mic Positions (wtr centre)
    
    % x1 = -0.15; %m
    % x2 = -0.10; %m
    % x3 = +0.10; %m
    % x4 = +0.15; %m
    
    params.x1 = -0.34; %m
    params.x2 = -0.29; %m
    params.x3 = +0.29; %m
    params.x4 = +0.34; %m
    
    %%% Unit Cell 
    params.a = 0.2806; %m 0.12;
    
    params.offset = -params.a/2; %m %shift of centre of unit cell wrt centre ( it doesn't matter...)
    %a = 0.055; %m
    
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % If you specify window as empty, then tfestimate uses a Hamming window
    % such that x and y are divided into eight segments with noverlap overlapping samples.
    params.wind = [];
    %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window
    
    %% CONTROL SENSITIVITY
    %%% MIC
    params.sens_p_m =  -1/41.2E-3;% 1/(V/Pa) SN65606
    params.sens_p_c =  -1/20.00E-3;% 1/(V/Pa) SN6969 NOT IN USE
    params.sens_p_p =  -1/43.6E-3;% 1/(V/Pa) SN65608
 

    
    %sens_v= 1/(10E-3);% Vibrometer sensitivity V/(m/s) 
    %%%  CURRENT TO VOLTAGE
    params.u2i = 10e-3; %current amplifier: Maxime: 10(mA/V); Rivet: 1/103.8 (A/V) 
    %%% PRESSURE TO DISPLACEMENT
  
    params.pb2disp_m = 1.21e-05; %1.105654e-05; %Trasnferfunction between backpressure and displacement (m/V) *SN 65607
    params.pb2disp_p = 1.32e-05; %2.289393e-05; %Trasnferfunction between backpressure and displacement (m/V) *SN 65609
        
    %%IMPLEMENT FILTER
    %% CONTROL SPEAKER PARAMETERS
    %Sd: Effective piston area (m^2) 
    %Mms: Moving mass (kg) **
    %Rms: Mechanical resitance (N.s/m) **
    %Cms: Mechanical complicance due to surround suspension and spider (m/N)
    %Cab: Compliance of enclosure due to back pressure (N/m^4)
    %Cmc: Total mechanical complicance (m/N) 
    %Bl: Force factor (N/A) **
    %Re: DC coil resistance (Ohm) 
    
    params.Sd = 12e-4; % Same diaphragm area for both
    %%% ms_estimate:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% speaker 1: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % %Re_m = 7;
    params.Bl_m  = 1.362;%1.0837;
    params.Rms_m = 2.777e-01;%0.3708;
    params.Mms_m = 5.311e-04;%5.4332e-04;
    params.Cmc_m = 1.816e-04;%1.735e-04;%1.7502e-04;%
    
    params.f0_m = 1/(2*pi*sqrt(params.Mms_m*params.Cmc_m)); % Resonnance frequency (Hz)
    %%% speaker 2: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % Re_p = 7.32;
    params.Bl_p  = 1.414;%1.3803;
    params.Rms_p = 2.623e-01;% 0.3005;
    params.Mms_p = 5.504e-04;
    params.Cmc_p = 2.056e-04;%1.705e-04;%1.7219e-04;%
    
    params.f0_p = 1/(2*pi*sqrt(params.Mms_p*params.Cmc_p)); % Resonnance frequency (Hz)
    % *  measured with ms_estimate.m 
    % ** measured with tf_Pb_Xi.m 
    
    %% CONTROL TARGET IMPEDENCE PARAMETERS FOR
    %%% Target Impedance Weights%%% 
    
    %%% speaker 1: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %RMKS: muR = muM = muC = 1
    %open ciWcuit; <1 reflection ; >1 absorption
    params.muM_m = 1;
    params.muR_m = 0.2;
    params.muC_m = 1;
    params.fst_m = params.f0_m*sqrt(params.muC_m/params.muM_m); %Target resonnance frequency
    
    
    %%% Transfer function Coefs
    %num:
    params.a2_m = params.Sd*(params.muM_m - 1)*params.Mms_m;
    params.a1_m = params.Sd*(params.muR_m - 1)*params.Rms_m;
    params.a0_m = params.Sd*(params.muC_m - 1)/params.Cmc_m;
    %den:   
    params.b2_m = params.Bl_m*params.muM_m*params.Mms_m;
    params.b1_m = params.Bl_m*params.muR_m*params.Rms_m;
    params.b0_m = params.Bl_m*params.muC_m/params.Cmc_m;
    %Transfer function model:
    params.Phi_c_m = tf([params.a2_m,params.a1_m,params.a0_m],[params.b2_m,params.b1_m,params.b0_m]);%/(sens_p_m*u2i);
    params.Phi_d_m =  c2d(params.Phi_c_m,params.ts_ctrl,'tustin'); %discretized (necessary for SG model)
    params.Phi_d_m = minreal(params.Phi_d_m);
        
    %%%  speaker 2: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %RMKS: muR = muM = muC = 1
    %open ciWcuit; <1 reflection ; >1 absorption
    params.muM_p = params.muM_m*params.Mms_m/params.Mms_p;
    params.muR_p = params.muR_m*params.Rms_m/params.Rms_p;
    params.muC_p = (params.muC_m*params.Cmc_p)/params.Cmc_m;

    params.fst_p = params.f0_p*sqrt(params.muC_p/params.muM_p); %Target resonnance frequency
    
    %%% Transfer function Coefs
    %num:
    params.a2_p = params.Sd*(params.muM_p - 1)*params.Mms_p;
    params.a1_p = params.Sd*(params.muR_p - 1)*params.Rms_p;
    params.a0_p = params.Sd*(params.muC_p - 1)/params.Cmc_p;
    %den:   
    params.b2_p = params.Bl_p*params.muM_p*params.Mms_p;
    params.b1_p = params.Bl_p*params.muR_p*params.Rms_p;
    params.b0_p = params.Bl_p*params.muC_p/params.Cmc_p;
    %Transfer functionp. model:
    params.Phi_c_p = tf([params.a2_p,params.a1_p,params.a0_p],[params.b2_p,params.b1_p,params.b0_p]);%/(sens_p_p*u2i);
    params.Phi_d_p = c2d(params.Phi_c_p,params.ts_ctrl,'tustin'); %discretized (necessary for SG model
    params.Phi_d_p = minreal(params.Phi_d_p);


    %%% Time vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % used for data interpolation
    %params.t = linspace(0,params.tmax,(2*params.tmax*params.fs_acq)/2)';
    %%% Frequency vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Used to estimate the transfer functions
    params.N = 2^nextpow2(2*params.tmax*params.fs_acq); % number of samples recorded
    params.freq = params.fi + ((params.ff - params.fi)/(params.tmax))*linspace(0,params.tmax,params.N)'; %%%linear frequency vector;

    %% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %params.t_ssh = 0; % SSH hopping parameter -1<0<1
    params.K = 0*(params.muC_m/params.Cmc_m); %1.8 %% 20221103 update - the control was inverted... 
    params.beta = 10;
end

