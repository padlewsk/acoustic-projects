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
    params.MDL = 'SG__MDL_IO104_IO135'; % name of the slx model (performance)
   
    %%% Sample time: CANNOT CHANGE ONCE FLASHED  
    params.ts_rec = 50e-06;   %%% recording sampling time (s) 
    params.fs_rec = 1/params.ts_rec ; 

    params.ts_acq = 100e-06; %%% acquisition sampling time - this defines the new sampling when computing the tf and saved on the HD
    params.fs_acq = 1/params.ts_acq; 
  
    %% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.src_select = 1; %source A or B
    
    params.A = 0.2; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.15 (V)
    params.tmax = 10; %%20 sweep up measurement time (s) 
    params.fi = 150;%150; %% initial frequency
    params.ff = 1200;%1200;%1500; %% final frequency
    %% CALIBRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Mic Positions (wtr centre)
    
    params.x1 = -0.34; %m
    params.x2 = -0.29; %m
    params.x3 = +0.29; %m
    params.x4 = +0.34; %m
    
    %%% Unit Cell 
    params.a = 0.2806; %m 0.12;
    
    params.offset = -params.a/2; %m %shift of centre of unit cell wrt centre ( it doesn't matter...)
    %a = 0.055; %m
    
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.wind = []; %floor(N/20); %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window
    
    %% CONTROL SENSITIVITY
    %%% MIC    (SWAPPED!!!)
    params.sens_p_m =  -1/43.6E-3;% 1/(V/Pa) SN65608
    params.sens_p_c =  -1/20.00E-3;% 1/(V/Pa) SN6969 NOT IN USE!
    params.sens_p_p =  -1/41.2E-3;% 1/(V/Pa) SN65606
 
    %sens_v= 1/(10E-3);% Vibrometer sensitivity V/(m/s) 
    %%%  CURRENT TO VOLTAGE
    params.u2i = 1e-2; %current amplifier: Maxime: 10e-3(A/V); Rivet: 1/103.8 (A/V) 
    %%% PRESSURE TO DISPLACEMENT
  
  
    params.pb2disp_m = 2.14133e-05 ;% -1/39.7E-3; %Trasnferfunction between backpressure and displacement (m/V) *SN 65607
    params.pb2disp_p = 1.91082e-05;  %-1/43.0E-3; %Trasnferfunction between backpressure and displacement (m/V) *SN 65609
        
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
    % %Re_m = 7.43;
    params.Bl_m  =  1.5017;
    params.Rms_m =  2.606526e-01;
    params.Mms_m =  6.670769e-04;
    params.Cmc_m =  2.128414e-04;%
    
    params.f0_m = 1/(2*pi*sqrt(params.Mms_m*params.Cmc_m)); % Resonnance frequency (Hz)
    
    %%% speaker 2: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % % Re_p =  3.57;
    params.Bl_p  =  1.1064;%1.3803;
    params.Rms_p =  2.791510e-01;% 0.3005;
    params.Mms_p =  5.691003e-04;%6.1805e-04;
    params.Cmc_p =  2.511373e-04;%1.705e-04;%1.7219e-04;%
    
    params.f0_p = 1/(2*pi*sqrt(params.Mms_p*params.Cmc_p)); % Resonnance frequency (Hz)
    % *  measured with ms_estimate.m 
    % ** measured with tf_Pb_Xi.m 
    
    %% CONTROL TARGET IMPEDENCE PARAMETERS FOR
    %%% Target Impedance Weights%%% 
    
    %%% speaker 1: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %RMKS: muR = muM = muC = 1
    %open ciWcuit; <1 reflection ; >1 absorption
    params.muM_m = 1;
    params.muR_m = 0.2;%0.2;
    params.muC_m = 1;%1;%0.6;
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
    params.Phi_d_m =  c2d(params.Phi_c_m,params.ts_rec,'tustin'); %discretized (necessary for SG model)
    params.Phi_d_m = minreal(params.Phi_d_m);
        
    %%%  speaker 2: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %RMKS: No synthisis: muR = muM = muC = 1
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
    params.Phi_d_p = c2d(params.Phi_c_p,params.ts_rec,'tustin'); %discretized (necessary for SG model
    params.Phi_d_p = minreal(params.Phi_d_p);

    %%% Frequency vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % --> Used to estimate the transfer functions
    params.N = 2^nextpow2((2*params.tmax)*params.fs_acq); 
    t = linspace(0,params.tmax,params.N)';
    params.freq = params.fi + ((params.ff - params.fi)/(params.tmax))*t; %%%linear frequency vector;

    %% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %params.t_ssh = 0; % SSH hopping parameter -1<0<1
    params.kappa    = 1*(-params.Sd); % coupling (front pressure) MAX 1
    params.kappa_nl = 0e-2*(-params.Sd); % NL coupling (front pressure) MAX 1.5e-2*(-params.Sd)
    params.kerr_nl  = 0e12; % local non-linearity (backpressure) MAX 5e12;
end

