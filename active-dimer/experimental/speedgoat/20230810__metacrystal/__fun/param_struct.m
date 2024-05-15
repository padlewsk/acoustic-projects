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
    
    %% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %params.use_random = true; % white noise
    params.src_select_type = 1; %1 = white; 2 = pulse centereds at freq_sine; 3 = constante sine
    params.src_select_ab = 1; % 1 = src A,  2 = src B and 3 = src A + src B (default is 1)
    params.A = 1; %Duct speaker:MAX 5V cf 20231129 5V for pulse
    %constant
    params.freq_sine = 500; %635 %cf 20231129
    %sweep
    params.freq_ini = 150;%150; %% initial frequency
    params.freq_fin = 1200;%1200;%1500; %% final frequency
    
    params.avg_num_wind = 1; %The number of windows with 0% overlap (x2-1 for 50% overlap).RMK: 15 FOR CAL
    %freq_max = params.freq_fin - 0*params.freq_ini;
    %N_lines = 6400; %50, 100, 200, 400, 800, 1600, 3200 or 6400 lines to use for calculating the FFT spectrum for a time record.  
    params.freq_res = 0.5; %freq_max/N_lines; %frequency resolution Hz (0.5 for s-matrix and 5 for stplot)
    params.tmax = 0.6; %params.avg_num_wind/params.freq_res; %0.6 for pulse ( back to default otherwise) % sweep up time (s) measurement time = 2 x tmax
    
    nyquist_rate = 4*(2*params.freq_fin); % over 4x to be safe... 
    %% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Machine type
    %tg_model = 'Baseline'; %target select
    %MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)
    params.tg_model = 'Mobile'; %target select
    params.MDL = 'SG__MDL_DMA'; % name of the slx model (performance)
    
    %%% Speedgoat sample time: CANNOT CHANGE ONCE BUILT AND UPLOADED !
    params.ts_ctr = 35e-06; 
    params.fs_ctr = (1/params.ts_ctr);
    params.log_dec = floor(params.fs_ctr/nyquist_rate); %file log decimation -> reduces log file size by factor of log_dec
    params.ts_log = params.ts_ctr*params.log_dec; % must be <= 1/(2*freq_span) (a bit over the nyquist-shannon limit)
    params.fs_log = round(1/params.ts_log); %c.f.20231018__

    %%% not in DMA mode
    %{
    params.ts_acq = 50e-06; %%% control sampling time - this defines the new sampling when computing the tf and saved on the HD
    params.fs_acq = 1/params.ts_acq; 
    %}
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.wind = params.fs_log/params.freq_res; % The window size is in number of samples. Window of 1s yields a resolution of 1Hz, 2s --> 0.5 Hz etc... The window size is in number of samples

    %% CALIBRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Mic Positions (wtr centre)
    params.x1 = -(4*0.28 + 0.24); %m
    params.x2 = -(4*0.28 + 0.19); %m
    params.x3 = +(4*0.28 + 0.19); %m
    params.x4 = +(4*0.28 + 0.24); %m
    
    %%% Unit Cell 
    params.a = 0.28; %m
    
    params.offset = -params.a/2; %m %shift of centre of unit cell wrt centre ( it doesn't matter...)
    %a = 0.055; %m
    %% CONTROL SENSITIVITY 
    %%% MIC  p(unitcell,atom)
    params.sens_p(1,1) =  -1/37.5E-3;% 1/(V/Pa) SN65603 
    params.sens_p(1,2) =  -1/36.4E-3;% 1/(V/Pa) SN65602 36.4E-3 %20240314 adjustment 42
    params.sens_p(2,1) =  -1/38.7E-3;% 1/(V/Pa) SN65604
    params.sens_p(2,2) =  -1/36.4E-3;% 1/(V/Pa) SN65640 36.4E-3 %20240314 adjustment 40
    params.sens_p(3,1) =  -1/39.1E-3;% 1/(V/Pa) SN65606
    params.sens_p(3,2) =  -1/37.6E-3;% 1/(V/Pa) SN65607 37.6 %20240314 adjustment 39
    params.sens_p(4,1) =  -1/40.2E-3;% 1/(V/Pa) SN65608
    params.sens_p(4,2) =  -1/40.5E-3;% 1/(V/Pa) SN65609
    params.sens_p(5,1) =  -1/34.7E-3;% 1/(V/Pa) SN68202 
    params.sens_p(5,2) =  -1/32.5E-3;% 1/(V/Pa) SN68203 
    params.sens_p(6,1) =  -1/32.3E-3;% 1/(V/Pa) SN68204 
    params.sens_p(6,2) =  -1/35.7E-3;% 1/(V/Pa) SN68205  
    params.sens_p(7,1) =  -1/35.1E-3;% 1/(V/Pa) SN68246 
    params.sens_p(7,2) =  -1/35.3E-3;% 1/(V/Pa) SN68247 
    params.sens_p(8,1) =  -1/35.1E-3;% 1/(V/Pa) SN68248 
    params.sens_p(8,2) =  -1/34.3E-3;% 1/(V/Pa) SN68249 

    %%% PRESSURE TO DISPLACEMENT
    params.pb2disp(1,1) = 2.14133e-05;% -1/39.7E-3; %Trasnferfunction between backpressure and displacement (m/V) *SN 65607
    params.pb2disp(1,2) = 1.91082e-05;  %-1/43.0E-3; %Trasnferfunction between backpressure and displacement (m/V) *SN 65609
   
    params.pb2disp(2,1) = 2.14133e-05;
    params.pb2disp(2,2) = 1.91082e-05;
    
    params.pb2disp(3,1) = 2.14133e-05;
    params.pb2disp(3,2) = 1.91082e-05;
    
    params.pb2disp(4,1) = 2.14133e-05;
    params.pb2disp(4,2) = 1.91082e-05;
    
    params.pb2disp(5,1) = 2.14133e-05;
    params.pb2disp(5,2) = 1.91082e-05;
    
    params.pb2disp(6,1) = 2.14133e-05;
    params.pb2disp(6,2) = 1.91082e-05;
    
    params.pb2disp(7,1) = 2.14133e-05;
    params.pb2disp(7,2) = 1.91082e-05;

    params.pb2disp(8,1) = 2.14133e-05;
    params.pb2disp(8,2) = 1.91082e-05;

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
    params.N_cell = 8;
    params.Sd = 12e-4; % Same diaphragm area for all
    
    %%% ms_estimate:  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 11: R = 7.24
    params.Bl(1,1)  =  1.439463e+00;
    params.Rms(1,1) =  2.104750e-01;
    params.Mms(1,1) =  6.692401e-04; 
    params.Cmc(1,1) =  2.260928e-04; 
    % 12: R = 7.30
    params.Bl(1,2)  =  1.436338e+00;
    params.Rms(1,2) =  1.887322e-01;
    params.Mms(1,2) =  6.665242e-04;
    params.Cmc(1,2) =  2.125228e-04; 
    
    % 21: R = 7.25
    params.Bl(2,1)  =  1.492380e+00;
    params.Rms(2,1) =  2.274173e-01;
    params.Mms(2,1) =  6.907285e-04; 
    params.Cmc(2,1) =  1.844899e-04; 
    % 22: R = 7.59
    params.Bl(2,2)  =  1.503181e+00;
    params.Rms(2,2) =  1.732927e-01;
    params.Mms(2,2) =  7.168219e-04; 
    params.Cmc(2,2) =  2.102037e-04; 
    
    % 31: R = 7.54
    params.Bl(3,1)  =  1.473817e+00;
    params.Rms(3,1) =  2.173800e-01;
    params.Mms(3,1) =  7.534913e-04; 
    params.Cmc(3,1) =  1.653909e-04; 
    % 32: R = 7.29
    params.Bl(3,2)  =  1.489841e+00;
    params.Rms(3,2) =  1.394455e-01;
    params.Mms(3,2) =  7.110030e-04; 
    params.Cmc(3,2) =  2.158767e-04; 

    % 41: R = 7.23
    params.Bl(4,1)  =  1.457938e+00;
    params.Rms(4,1) =  1.977614e-01;
    params.Mms(4,1) =  6.814108e-04; 
    params.Cmc(4,1) =  1.895497e-04; 
    % 42: R = 7.34
    params.Bl(4,2)  =  1.518334e+00;
    params.Rms(4,2) =  1.872651e-01;
    params.Mms(4,2) =  7.086857e-04; 
    params.Cmc(4,2) =  1.938161e-04; 

    % 51: R = 7.43
    params.Bl(5,1)  =  1.492331e+00;
    params.Rms(5,1) =  2.220907e-01;
    params.Mms(5,1) =  6.935072e-04; 
    params.Cmc(5,1) =  1.904666e-04; 
    % 52: R = 7.43
    params.Bl(5,2)  =  1.488830e+00;
    params.Rms(5,2) =  1.844278e-01;
    params.Mms(5,2) =  6.932563e-04; 
    params.Cmc(5,2) =  2.041370e-04; 

    % 61: R = 7.43
    params.Bl(6,1)  =  1.444718e+00;
    params.Rms(6,1) =  1.662037e-01;
    params.Mms(6,1) =  6.995107e-04; 
    params.Cmc(6,1) =  2.039369e-04; 
    % 62: R = 7.43
    params.Bl(6,2)  =  1.462797e+00;
    params.Rms(6,2) =  1.745243e-01;
    params.Mms(6,2) =  6.756669e-04; 
    params.Cmc(6,2) =  2.061695e-04; 

    % 71: R = 7.43
    params.Bl(7,1)  =  1.487905e+00;
    params.Rms(7,1) =  2.137628e-01;
    params.Mms(7,1) =  6.526790e-04; 
    params.Cmc(7,1) =  2.078265e-04; 
    % 72: R = 7.43
    params.Bl(7,2)  =  1.485184e+00;
    params.Rms(7,2) =  2.463107e-01;
    params.Mms(7,2) =  6.530957e-04; 
    params.Cmc(7,2) =  2.243297e-04; 

    % 81: R = 7.43
    params.Bl(8,1)  =  1.497458e+00;
    params.Rms(8,1) =  2.075385e-01;
    params.Mms(8,1) =  6.839664e-04; 
    params.Cmc(8,1) =  1.883416e-04; 
    % 82: R = 7.43
    params.Bl(8,2)  =  1.504838e+00;
    params.Rms(8,2) =  1.785134e-01;
    params.Mms(8,2) =  6.790660e-04; 
    params.Cmc(8,2) =  2.177386e-04; 
    
    % Resonnance frequency (Hz)
    for ii = 1:8
        for jj = 1:2
        params.f0(ii,jj) = 1/(2*pi*sqrt(params.Mms(ii,jj)*params.Cmc(ii,jj))); 
        end
    end
    
    %% CONTROL TARGET IMPEDENCE PARAMETERS 
    %%%  
    %RMKS: No synthisis: muR = muM = muC = 1; All the same for now
    muM_tgt = 1; 
    muR_tgt = 0.25; %0.25 
    muC_tgt = 1;%0.85

    % Synthesize all to a same average:
    Bl_avg =  mean(params.Bl(:,:),"all");
    Mms_avg = mean(params.Mms(:,:),"all");
    Rms_avg = mean(params.Rms(:,:),"all");
    Cmc_avg = mean(params.Cmc(:,:),"all");

    %Target resonnance frequency
    for ii = 1:8
        for jj = 1:2
        muM(ii,jj) = muM_tgt*Mms_avg/params.Mms(ii,jj);
        muR(ii,jj) = muR_tgt*Rms_avg/params.Rms(ii,jj);
        muC(ii,jj) = (muC_tgt*params.Cmc(ii,jj))/Cmc_avg; 
        fst(ii,jj) = params.f0(ii,jj)*sqrt(muC(ii,jj)/muM(ii,jj)); %Target resonance frequency
        
        %%% Transfer function Coefs
        %num:
        a2(ii,jj) = params.Sd*(muM(ii,jj) - 1)*params.Mms(ii,jj);
        a1(ii,jj) = params.Sd*(muR(ii,jj) - 1)*params.Rms(ii,jj);
        a0(ii,jj) = params.Sd*(muC(ii,jj) - 1)/params.Cmc(ii,jj);
        %den:   
        b2(ii,jj) = params.Bl(ii,jj)*muM(ii,jj)*params.Mms(ii,jj);
        b1(ii,jj) = params.Bl(ii,jj)*muR(ii,jj)*params.Rms(ii,jj);
        b0(ii,jj) = params.Bl(ii,jj)*muC(ii,jj)/params.Cmc(ii,jj);
        %Transfer functionp. model:
        Phi_c(ii,jj) = tf([a2(ii,jj),a1(ii,jj),a0(ii,jj)],[b2(ii,jj),b1(ii,jj),b0(ii,jj)]);%/(sens_p_p/i2u);
        params.Phi_d(ii,jj) = c2d(Phi_c(ii,jj),params.ts_ctr,'tustin'); %discretized (necessary for SG model
        params.Phi_d(ii,jj) = minreal(params.Phi_d(ii,jj));
        end
    end
    params.fst = params.f0(1,1)*sqrt(muC(1,1)/muM(1,1));%same value for all atms
    

    %%% Frequency vector
    %%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% NECESSARY? YES.
    % --> Used to estimate the transfer functions
    %params.N = 2^(nextpow2((2*params.tmax)*params.fs_log)+1); % longer than the recorded data - for zero padding
    %t = linspace(0,2*params.tmax,params.N)'; % x2 because sweep up and sweep down

    %params.freq = params.freq_ini + ((params.freq_fin - params.freq_ini)/(2*params.tmax))*t; %%%linear frequency vector;
   
    %% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% 20240314 RMK: THE COUPLING OF CELLS 1 & 2 are strange...
    %params.i2u = 0; % comment out to bypass impedance synthesis
    
    %%% COUPLING MATRIX ( in terms of Sd)
    % coupling kappa>0 => v>w; kappa <0 => v>w; 
    params.kappa_A    = +0; % ADDED coupling (front pressure) kappa>0 => v>w; kappa <0 v<w; 
    params.kappa_B    = -0; 
    params.kappa_nl_A = +0*(0.9e-2); % NL coupling (front pressure) MAX 0.8e-2 @ A = 8
    params.kappa_nl_B = -0*(0.9e-2);
    %kerr_nl  = 0e12; % local non-linearity (backpressure) MAX 5e12; %TO IMPLEMENT

    %constant disorder variance (time-independant)
    params.sigma_cpl = 0; % from 0 to 1
    params.sigma_loc = 0; % from 0 to 1

    %temperature disorder variance (time-dependant)
    params.sigma_T = 0; % from 0 to 1 %%% MUST REBUILD FOR NOW
    
    % phase disorder (coupling delay between sites in samples )
    %params.sigma_delay = 0*(params.a/params.c0/2);%0.05*(params.a/params.c0/2); % (a/c0)/2 is the time between two adjacent sites 

    %non-reciprocal disorder switch:
    params.isnonreciprocal = 0; %%% MUST REBUILD FOR NOW
   
    %normrnd seed in disorder function:
    idx_rng = 1;
    
    %LINEAR ASYMMETRIC COUPLING --> Coupling to left if >0 
    gamma_v_A = +0; % v asymmetry 
    gamma_w_A = +0;  % w asymmetry
    gamma_v_B = -0; % v asymmetry  
    gamma_w_B = -0; % w asymmetry 

    cpl_vec = zeros(1, 2*params.N_cell-1); % initialize
    params.cpl_L    = cpl_vec;   % initialize
    params.cpl_R    = cpl_vec;   % initialize
    % A crystal
    params.cpl_L(1:2:params.N_cell-2)     = abs(params.kappa_A + gamma_v_A)*heavisidefun(+(params.kappa_A + gamma_v_A)); % v
    params.cpl_L(2:2:params.N_cell-2)     = abs(params.kappa_A - gamma_w_A)*heavisidefun(-(params.kappa_A - gamma_w_A)); % w
    params.cpl_R(1:2:params.N_cell-2)     = abs(params.kappa_A - gamma_v_A)*heavisidefun(+(params.kappa_A - gamma_v_A)); % v
    params.cpl_R(2:2:params.N_cell-2)     = abs(params.kappa_A + gamma_w_A)*heavisidefun(-(params.kappa_A + gamma_w_A)); % w
    % B crystal
    params.cpl_L(params.N_cell-1:2:end) = abs(params.kappa_B + gamma_v_B)*heavisidefun(+(params.kappa_B + gamma_v_B)); % v
    params.cpl_L(params.N_cell:2:end) = abs(params.kappa_B - gamma_w_B)*heavisidefun(-(params.kappa_B - gamma_w_B)); % w
    params.cpl_R(params.N_cell-1:2:end) = abs(params.kappa_B - gamma_v_B)*heavisidefun(+(params.kappa_B - gamma_v_B)); % v
    params.cpl_R(params.N_cell:2:end) = abs(params.kappa_B + gamma_w_B)*heavisidefun(-(params.kappa_B + gamma_w_B)); % w
    
     %NON LINEAR ASYMMETRIC COUPLING --> Coupling to left if > 0
    gamma_nl_v_A = 0*(0.9e-2); % v asymmetry 
    gamma_nl_w_A = 0*(0.9e-2);  % w asymmetry
    gamma_nl_v_B = 0*(0.9e-2); % v asymmetry  
    gamma_nl_w_B = 0*(0.9e-2); % w asymmetry 
    
    %LINEAR
    cpl_vec = zeros(1, 2*params.N_cell-1); % initialize
    params.cpl_nl_L    = cpl_vec;   % initialize
    params.cpl_nl_R    = cpl_vec;   % initialize
    % A crystal
    params.cpl_nl_L(1:2:params.N_cell-2)     = abs(params.kappa_nl_A + gamma_nl_v_A)*heavisidefun(+(params.kappa_nl_A + gamma_nl_v_A)); % v
    params.cpl_nl_L(2:2:params.N_cell-2)     = abs(params.kappa_nl_A - gamma_nl_w_A)*heavisidefun(-(params.kappa_nl_A - gamma_nl_w_A)); % w
    params.cpl_nl_R(1:2:params.N_cell-2)     = abs(params.kappa_nl_A - gamma_nl_v_A)*heavisidefun(+(params.kappa_nl_A - gamma_nl_v_A)); % v
    params.cpl_nl_R(2:2:params.N_cell-2)     = abs(params.kappa_nl_A + gamma_nl_w_A)*heavisidefun(-(params.kappa_nl_A + gamma_nl_w_A)); % w
    % B crystal
    params.cpl_nl_L(params.N_cell-1:2:end) = abs(params.kappa_nl_B + gamma_nl_v_B)*heavisidefun(+(params.kappa_nl_B + gamma_nl_v_B)); % v
    params.cpl_nl_L(params.N_cell:2:end) = abs(params.kappa_nl_B - gamma_nl_w_B)*heavisidefun(-(params.kappa_nl_B - gamma_nl_w_B)); % w
    params.cpl_nl_R(params.N_cell-1:2:end) = abs(params.kappa_nl_B - gamma_nl_v_B)*heavisidefun(+(params.kappa_nl_B - gamma_nl_v_B)); % v
    params.cpl_nl_R(params.N_cell:2:end) = abs(params.kappa_nl_B + gamma_nl_w_B)*heavisidefun(-(params.kappa_nl_B + gamma_nl_w_B)); % w
    

    % MANUAL OVERRIDE: TO HAVE SAME MEASUREMNTS PRIOR TO UPDATE %%%%%%%%%%%%%%%%
    %{
    params.cpl_L = 0*[1 0 1 0 1 0 0 1 0 1 0 1 0 1 0]; %flip(params.cpl_L);%%%%
    params.cpl_R = 0*[1 0 1 0 1 0 0 1 0 1 0 1 0 1 0];%flip(params.cpl_R);%%%%

    params.cpl_nl_L = 0.8*(0.9e-2)*[1 0 1 0 1 0 0 1 0 1 0 1 0 1 0];%flip(params.cpl_nl_L);%%%%
    params.cpl_nl_R = 0.8*(0.9e-2)*[1 0 1 0 1 0 0 1 0 1 0 1 0 1 0];%flip(params.cpl_nl_R);%%%%
    %}
    
    %OVERRIDE NON HERMITIAN
    params.cpl_L = 1.5*[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
    params.cpl_R = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

    %params.cpl_nl_L = 4.5*(1e-2)*[0 1 1 1 1 1 1 1 1 1 1 1 1 1 0]; %1.2, max 5 for pulse
    %params.cpl_nl_R = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
    
    %%% UPDATE DISORDERED PARAMS
    %params = disorder(params,idx_rng);  %%%%%%%%%%%%%%%%% !!!! careful
    %with this
    %%% FUNCTIONS
    function y= heavisidefun(x)
    if x<= 0
        y=0;
    else
        y=1;
    end
end
    %{
    rng(1); %sets the seed such that the random functions are the same for both A and B runs!!
    % MAKE KERR CPL

    %}
end

