function params = param_struct();

    params = struct;

    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% RMK: Manually update the asterixed parameters after running either
    
    %% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.c0 = 347.13; % 300KN_lines
    %params.rho0 = 1.1839;
    %params.Zc = params.c0*params.rho0; % characteristic specific acoustic impedence at 300K
    
    %% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.use_random = true; % white noise
    params.src_select = 1; % 1 = src A,  2 = src B and 3 = src A + src B
    params.A = 1; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.15 (V)
    %constant
    params.freq_sine = 638; %default
    %sweep
    params.freq_ini = 150;%150; %% initial frequency
    params.freq_fin = 1200;%1200;%1500; %% final frequency

    freq_span = params.freq_fin - params.freq_ini;
    N_lines = 2000; %50, 100, 200, 400, 800, 1600, 3200 or 6400 lines to use for calculating the FFT spectrum for a time record.  
    freq_res = freq_span/N_lines; %frequency resolution Hz
    params.tmax = 0.3;% 1/freq_res; % sweep up time (s) measurement time = 2 x tmax

    %% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Machine type
    %tg_model = 'Baseline'; %target select
    %MDL = 'SG__MDL_IO397'; % name of the slx model (baseline)
    params.tg_model = 'Mobile'; %target select
    params.MDL = 'SG__MDL_DMA'; % name of the slx model (performance)
    
    %%% Sample time: CANNOT CHANGE ONCE BUILT AND UPLOADED !
    params.ts_ctr = 35e-06;
    params.fs_ctr = (1/params.ts_ctr);
    params.log_dec = 1; %file log decimation -> reduces log file size by factor of log_dec
    params.ts_log = params.ts_ctr*params.log_dec; % must be <= 1/(2*freq_span) (a bit over the nyquist-shannon limit)
    params.fs_log = round(1/params.ts_log); %c.f.20231018__

    %%% not in DMA mode
    %{
    params.ts_acq = 50e-06; %%% control sampling time - this defines the new sampling when computing the tf and saved on the HD
    params.fs_acq = 1/params.ts_acq; 
    %}
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.wind = params.fs_log; % number of samples for a window of 1s e.g. resolve up to 2 Hz --> window must be 1/2 s

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
    params.sens_p(1,1) =  -1/38.6E-3;% 1/(V/Pa) SN65603 wtf ??????%%%%%%%%%%%%%%%
    params.sens_p(1,2) =  -1/37.6E-3;% 1/(V/Pa) SN65602 

    params.sens_p(2,1) =  -1/40.0E-3;% 1/(V/Pa) SN65604
    params.sens_p(2,2) =  -1/37.9E-3;% 1/(V/Pa) SN65640

    params.sens_p(3,1) =  -1/40.7E-3;% 1/(V/Pa) SN65606
    params.sens_p(3,2) =  -1/39.3E-3;% 1/(V/Pa) SN65607

    params.sens_p(4,1) =  -1/41.8E-3;% 1/(V/Pa) SN65608
    params.sens_p(4,2) =  -1/42.0E-3;% 1/(V/Pa) SN65609

    params.sens_p(5,1) =  -1/37.2E-3;% 1/(V/Pa) SN68202 
    params.sens_p(5,2) =  -1/35.0E-3;% 1/(V/Pa) SN68203 
 
    params.sens_p(6,1) =  -1/35.1E-3;% 1/(V/Pa) SN68204 
    params.sens_p(6,2) =  -1/36.2E-3;% 1/(V/Pa) SN68205  

    params.sens_p(7,1) =  -1/37.6E-3;% 1/(V/Pa) SN68246 
    params.sens_p(7,2) =  -1/38.1E-3;% 1/(V/Pa) SN68247 
 
    params.sens_p(8,1) =  -1/37.4E-3;% 1/(V/Pa) SN68248 
    params.sens_p(8,2) =  -1/37.0E-3;% 1/(V/Pa) SN68249 

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
    params.u2i = 1e-2; %current amplifier: Maxime: 10e-3(A/V); Rivet: 1/103.8 (A/V)   

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
    params.Bl(8,2)  = 1.504838e+00;
    params.Rms(8,2) = 1.785134e-01;
    params.Mms(8,2) = 6.790660e-04; 
    params.Cmc(8,2) = 2.177386e-04; 
    
    % Resonnance frequency (Hz)
    for ii = 1:8
        for jj = 1:2
        params.f0(ii,jj) = 1/(2*pi*sqrt(params.Mms(ii,jj)*params.Cmc(ii,jj))); 
        end
    end
    
    %% CONTROL TARGET IMPEDENCE PARAMETERS 
    %%%  
    %RMKS: No synthisis: muR = muM = muC = 1; All the same for now
    muM_tgt = 1; %target
    muR_tgt = 0.2;
    muC_tgt = 1;

    % Synthesize all to a same average:
    Bl_avg =  mean(params.Bl(:,:),"all");
    Mms_avg = mean(params.Mms(:,:),"all");
    Rms_avg = mean(params.Rms(:,:),"all");
    Cmc_avg = mean(params.Cmc(:,:),"all");

    %Target resonnance frequency
    %fst_A = 1/(2*pi*sqrt(Mms_avg*Cmc_avg))*sqrt(muC/muM); 

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
        Phi_c(ii,jj) = tf([a2(ii,jj),a1(ii,jj),a0(ii,jj)],[b2(ii,jj),b1(ii,jj),b0(ii,jj)]);%/(sens_p_p*u2i);
        params.Phi_d(ii,jj) = c2d(Phi_c(ii,jj),params.ts_ctr,'tustin'); %discretized (necessary for SG model
        params.Phi_d(ii,jj) = minreal(params.Phi_d(ii,jj));
        end
    end

    %%% Frequency vector
    %%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% NECESSARY? YES.
    % --> Used to estimate the transfer functions
    params.N = 2^(nextpow2((2*params.tmax)*params.fs_log) + 1); % longer than the recorded data - for zero padding
    t = linspace(0,2*params.tmax,params.N)'; 

    params.freq = params.freq_ini + ((params.freq_fin - params.freq_ini)/(2*params.tmax))*t; %%%linear frequency vector;
    %params.freq = params.freq_ini + ((params.freq_fin - params.freq_ini)/(params.tmax))*t; % use with homemade sweep
    %% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    kappa    = 0.8 *(params.Sd); % coupling (front pressure) MAX 1;  x(-params.Sd)???
    kappa_nl = 0e-2*(params.Sd); % NL coupling (front pressure) MAX 3e-2*x(-params.Sd)???
    kerr_nl  = 0e12; % local non-linearity (backpressure   ) MAX 5e12;
    
    params.cpl    = [kappa,0,kappa,0,kappa,0,kappa,0,kappa,0,kappa,0,kappa,0,kappa]; % interfaceless
    %params.cpl    = [kappa,0,kappa,0,kappa,0,kappa,0,0, kappa,0,kappa,0,kappa,0];% interface 1 
    %params.cpl    = [0,kappa,0,kappa,0,kappa,0, 0, kappa,0,kappa,0,kappa,0, kappa];% interface 2
    params.cpl_nl = [kappa_nl,0,kappa_nl,0,kappa_nl,0,kappa_nl,0, 0, kappa_nl,0,kappa_nl,0,kappa_nl,0];% interface 1 

    % 4 unit cells
    %{
    %params.cpl    = [kappa,0,kappa,0,kappa,0,kappa,0,kappa,0,kappa,0,kappa,0,kappa]; % interfaceless
    %params.cpl    = [kappa,0,kappa,0,0,kappa,0,0,kappa,0,kappa,0,kappa,0,kappa];% interface 1 
    %params.cpl    = [kappa,0,kappa,kappa,0,kappa,0,0,kappa,0,kappa,0,kappa,0,kappa];% interface 2
    %params.cpl_nl = [kappa_nl,0,kappa_nl,0,kappa_nl,0,kappa_nl,0,kappa_nl,0,kappa_nl,0,kappa_nl,0,kappa_nl];
    %}
    % MAKE KERR CPL
end

