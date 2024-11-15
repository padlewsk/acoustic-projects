function params = param_struct();
   % if nargin < 1
   %     params_ext = params;
   % end
    params = struct;

    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% RMK: Manually update the asterixed parameters after running either
    %% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.c0 = 347.13; % 300KN_lines
    %params.rho0 = 1.1839;
    %params.Zc = params.c0*params.rho0; % characteristic specific acoustic impedence at 300K
    
    %% DEFAULT WAVEBIT STATE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.A = 0.008;% source gain (Pa)
    params.freq_0 = 323;%318.51; % make sure that params.freq_0/params.ts is a whole number
    params.omega_0_vec = 2*pi*[params.freq_0, params.freq_0]; 
    %params.omega_1 = 2*params.omega_0; % make sure that params.freq_0/params.ts is a whole number
    %params.rho = [1;1];
    %params.theta = [0;0];
    %params.phi = [0;0];  
    
    %correct wavebit amplitude difference and hamonics
    %params.rho_corr = [1;1];
    %params.harm_corr = [1;1];

    %%% Default val: 
    params.alpha_mat = [1 0 0; 0 0 0]; 
    params.beta_mat  = [0 0 0; 1 0 0]; 
    
    %% SWEEP CALIBRATORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %constant
     %635 %cf 20231129
    %sweep
    params.freq_ini = 150;%150; %% initial frequency
    params.freq_fin = 1200;%1200;%1500; %% final frequency
    

    %% STATE MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %params.avg_num_wind = 1; %The number of windows with 0% overlap (x2-1 for 50% overlap).RMK: 15 FOR CAL
    %freq_max = params.freq_fin - 0*params.freq_ini;
    %N_lines = 6400; %50, 100, 200, 400, 800, 1600, 3200 or 6400 lines to use for calculating the FFT spectrum for a time record.  
    %params.freq_res = 0.5; %freq_max/N_lines; %frequency resolution Hz (0.5 for s-matrix and 5 for stplot)
    
    nT = 10000/(2*pi*params.freq_0); % n times base cycle;
    params.tmax = nT;
    
    %nyquist_rate = 4*(2*params.freq_fin); % over 4x to be safe... 
    %% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Machine type
    %tg_model = 'Baseline'; %target select
    %MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)
    params.tg_model = 'Mobile'; %target select
    params.MDL = 'SG__MDL'; % name of the slx model (performance)
    
    %%% Speedgoat sample time: CANNOT CHANGE ONCE BUILT AND UPLOADED !
   % params.ts_ctr = 50e-06; 
    %params.fs_ctr = (1/params.ts_ctr);
    %params.log_dec = floor(params.fs_ctr/nyquist_rate); %file log decimation -> reduces log file size by factor of log_dec
    %params.ts_log = params.ts_ctr*params.log_dec; % must be <= 1/(2*freq_span) (a bit over the nyquist-shannon limit)
    %params.fs_log = round(1/params.ts_log); %c.f.20231018__

    %%% not in DMA mode
    %
    params.ts_ctr = 50e-06; %%% control sampling time - this defines the new sampling when computing the tf and saved on the HD
    params.fs_ctr = 1/params.ts_ctr; 
    %}
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %params.wind = params.fs_log/params.freq_res; % The window size is in number of samples. Window of 1s yields a resolution of 1Hz, 2s --> 0.5 Hz etc... The window size is in number of samples

    %% CONTROL SENSITIVITY 
    %%% MIC  p(unitcell,atom)
    params.sens_p(1) =  -1/37.5E-3;% 1/(V/Pa) SN65603 
    params.sens_p(2) =  -1/36.4E-3;% 1/(V/Pa) SN65602
    params.sens_p(3) =  -1/38.7E-3;% 1/(V/Pa) SN65604 
    params.sens_p(4) =  -1/36.4E-3;% 1/(V/Pa) SN65640

    %%%  CURRENT TO VOLTAGE
    params.i2u = 100; %current amplifier: Maxime: 100(V/A); Rivet: 103.8 (V/A)   

    %% CONTROL SPEAKER PARAMETERS
    %Sd: Effective piston area (m^2) 
    %Mms: Moving mass (kg) **
    %Rms: Mechanical resitance (N.s/m) **
    %Cms: Mechanical complicance due to surround suspension and spider (m/N)
    %Cab: Compliance of enclosure due to back pressure (N/m^4)
    %Cmc: Total mechanical complicance (m/N) 
    %Bl: Force factor (N/A) **
    %Re: DC coil resistance (Ohm) 
    % *  measured with ms_estimate.m 
    % ** measured with tf_Pb_Xi.m 
    params.N_wb = 2;
    params.Sd = 32e-4; % Same diaphragm area for all
    
    %%% ms_estimate:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 1: R = 3.3 (bc thicker contact wires)
    params.Bl(1)  =   1.729359e+00;
    params.Rms(1) =   8.326843e-01;
    params.Mms(1) =   1.676057e-03; 
    params.Cmc(1) =   8.949133e-05; 
    params.Csb(1) =   8.949133e-05; 
    % 2: R = 7.1
    params.Bl(2)  =  2.409590e+00;
    params.Rms(2) =  8.168637e-01;
    params.Mms(2) =  1.770252e-03;
    params.Cmc(2) =  7.864552e-05; 
    params.Csb(1) =   8.949133e-05; 
    % Resonnance frequency (Hz)
    for ii = 1:2
        params.f0(ii) = 1/(2*pi*sqrt(params.Mms(ii)*params.Cmc(ii))); 
    end
    
    %% CONTROL TARGET IMPEDENCE PARAMETERS 
    %%%  
    %RMKS: No synthisis: muR = muM = muC = 1; All the same for now
    muM_tgt = 1; 
    muR_tgt = 0.9995; %0.25 
    muC_tgt = 1;%0.85

    % Synthesize all to a same average:
    Bl_avg =  mean(params.Bl(:),"all");
    Mms_avg = mean(params.Mms(:),"all");
    Rms_avg = mean(params.Rms(:),"all");
    Cmc_avg = mean(params.Cmc(:),"all");

    %Target resonnance frequency
    for ii = 1:2
        muM(ii) = muM_tgt*Mms_avg/params.Mms(ii);
        muR(ii) = muR_tgt*Rms_avg/params.Rms(ii);
        muC(ii) = (muC_tgt*params.Cmc(ii))/Cmc_avg; 
        fst(ii) = params.f0(ii)*sqrt(muC(ii)/muM(ii)); %Target resonance frequency
        
        %%% Transfer function Coefs
        %num:
        a2(ii) = params.Sd*(muM(ii) - 1)*params.Mms(ii);
        a1(ii) = params.Sd*(muR(ii) - 1)*params.Rms(ii);
        a0(ii) = params.Sd*(muC(ii) - 1)/params.Cmc(ii);
        %den:   
        b2(ii) = params.Bl(ii)*muM(ii)*params.Mms(ii);
        b1(ii) = params.Bl(ii)*muR(ii)*params.Rms(ii);
        b0(ii) = params.Bl(ii)*muC(ii)/params.Cmc(ii);
        %Transfer functionp. model:
        Phi_c(ii) = tf([a2(ii),a1(ii),a0(ii)],[b2(ii),b1(ii),b0(ii)]);%/(sens_p_p/i2u);
        params.Phi_d(ii) = c2d(Phi_c(ii),params.ts_ctr,'tustin'); %discretized (necessary for SG model
        params.Phi_d(ii) = minreal(params.Phi_d(ii));
    end
    params.fst = params.f0(1,1)*sqrt(muC(1,1)/muM(1,1));%same value for all atms
    

    %%% Frequency vector
    %%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% NECESSARY? YES.
    % --> Used to estimate the transfer functions
    %params.N = 2^(nextpow2((2*params.tmax)*params.fs_log)+1); % longer than the recorded data - for zero padding
    %t = linspace(0,2*params.tmax,params.N)'; % x2 because sweep up and sweep down

    %params.freq = params.freq_ini + ((params.freq_fin - params.freq_ini)/(2*params.tmax))*t; %%%linear frequency vector;
  
end

