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
    params.ts_rec = 90e-06;   %%% recording sampling time (s) 
    params.fs_rec = 1/params.ts_rec ; 

    params.ts_acq = 90e-06; %%% acquisition sampling time - this defines the new sampling when computing the tf and saved on the HD
    params.fs_acq = 1/params.ts_acq; 
  
    %% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.src_select = 1; %source A or B
    
    params.A = 0.2; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.15 (V)
    params.tmax = 5; %% sweep up measurement time (s) 10
    params.fi = 150;%150; %% initial frequency
    params.ff = 1200;%1200;%1500; %% final frequency
    %% CALIBRATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Mic Positions (wtr centre)
    params.x1 = -0.38; %m
    params.x2 = -0.33; %m
    params.x3 = +0.33; %m
    params.x4 = +0.38; %m
    
    %%% Unit Cell 
    params.a = 0.280; %m 0.12;
    
    params.offset = -params.a/2; %m %shift of centre of unit cell wrt centre ( it doesn't matter...)
    %a = 0.055; %m
    
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.wind = []; %floor(N/20); %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window
    
    %% CONTROL SENSITIVITY 
    %%% MIC  (p_unitcell_atom)
    params.sens_p(1,1) =  -1/37.6E-3;% 1/(V/Pa) SN65606 %%%%%%%%%%%%%%%%%%%%%
    params.sens_p(1,2) =  -1/38.9E-3;% 1/(V/Pa) SN65608

    params.sens_p(2,1) =  -1/37.6E-3;% 1/(V/Pa) 
    params.sens_p(2,2) =  -1/38.9E-3;% 1/(V/Pa) 

    params.sens_p(3,1) =  -1/37.6E-3;% 1/(V/Pa) 
    params.sens_p(3,2) =  -1/38.9E-3;% 1/(V/Pa)

    params.sens_p(4,1) =  -1/37.6E-3;% 1/(V/Pa) 
    params.sens_p(4,2) =  -1/38.9E-3;% 1/(V/Pa)

    params.sens_p(5,1) =  -1/37.6E-3;% 1/(V/Pa) 
    params.sens_p(5,2) =  -1/38.9E-3;% 1/(V/Pa)

    params.sens_p(6,1) =  -1/37.6E-3;% 1/(V/Pa) 
    params.sens_p(6,2) =  -1/38.9E-3;% 1/(V/Pa) 

    params.sens_p(7,1) =  -1/37.6E-3;% 1/(V/Pa) 
    params.sens_p(7,2) =  -1/38.9E-3;% 1/(V/Pa) 

    params.sens_p(8,1) =  -1/37.6E-3;% 1/(V/Pa)
    params.sens_p(8,2) =  -1/38.9E-3;% 1/(V/Pa)

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
    % 11: R = 7.43
    params.Bl(1,1)  =  1.59e+00;
    params.Rms(1,1) =  3.55e-01;
    params.Mms(1,1) =  7.23e-04; 
    params.Cmc(1,1) =  2.15e-04; 
    % 12: R = 7.43
    params.Bl(1,2)  =  1.51e+00;
    params.Rms(1,2) =  2.81e-01;
    params.Mms(1,2) =  6.63e-04; 
    params.Cmc(1,2) =  2.30e-04; 
    
    % 21: R = 7.43
    params.Bl(2,1)  =  1.59e+00;
    params.Rms(2,1) =  3.55e-01;
    params.Mms(2,1) =  7.23e-04; 
    params.Cmc(2,1) =  2.15e-04; 
    % 22: R = 7.43
    params.Bl(2,2)  =  1.51e+00;
    params.Rms(2,2) =  2.81e-01;
    params.Mms(2,2) =  6.63e-04; 
    params.Cmc(2,2) =  2.30e-04; 
    
    % 31: R = 7.43
    params.Bl(3,1)  =  1.59e+00;
    params.Rms(3,1) =  3.55e-01;
    params.Mms(3,1) =  7.23e-04; 
    params.Cmc(3,1) =  2.15e-04; 
    % 32: R = 7.43
    params.Bl(3,2)  =  1.51e+00;
    params.Rms(3,2) =  2.81e-01;
    params.Mms(3,2) =  6.63e-04; 
    params.Cmc(3,2) =  2.30e-04; 

    % 41: R = 7.43
    params.Bl(4,1)  =  1.59e+00;
    params.Rms(4,1) =  3.55e-01;
    params.Mms(4,1) =  7.23e-04; 
    params.Cmc(4,1) =  2.15e-04; 
    % 42: R = 7.43
    params.Bl(4,2)  =  1.51e+00;
    params.Rms(4,2) =  2.81e-01;
    params.Mms(4,2) =  6.63e-04; 
    params.Cmc(4,2) =  2.30e-04; 

    % 51: R = 7.43
    params.Bl(5,1)  =  1.59e+00;
    params.Rms(5,1) =  3.55e-01;
    params.Mms(5,1) =  7.23e-04; 
    params.Cmc(5,1) =  2.15e-04; 
    % 52: R = 7.43
    params.Bl(5,2)  =  1.51e+00;
    params.Rms(5,2) =  2.81e-01;
    params.Mms(5,2) =  6.63e-04; 
    params.Cmc(5,2) =  2.30e-04; 

    % 61: R = 7.43
    params.Bl(6,1)  =  1.59e+00;
    params.Rms(6,1) =  3.55e-01;
    params.Mms(6,1) =  7.23e-04; 
    params.Cmc(6,1) =  2.15e-04; 
    % 62: R = 7.43
    params.Bl(6,2)  =  1.51e+00;
    params.Rms(6,2) =  2.81e-01;
    params.Mms(6,2) =  6.63e-04; 
    params.Cmc(6,2) =  2.30e-04; 

    % 71: R = 7.43
    params.Bl(7,1)  =  1.59e+00;
    params.Rms(7,1) =  3.55e-01;
    params.Mms(7,1) =  7.23e-04; 
    params.Cmc(7,1) =  2.15e-04; 
    % 72: R = 7.43
    params.Bl(7,2)  =  1.51e+00;
    params.Rms(7,2) =  2.81e-01;
    params.Mms(7,2) =  6.63e-04; 
    params.Cmc(7,2) =  2.30e-04; 

    % 81: R = 7.43
    params.Bl(8,1)  =  1.59e+00;
    params.Rms(8,1) =  3.55e-01;
    params.Mms(8,1) =  7.23e-04; 
    params.Cmc(8,1) =  2.15e-04; 
    % 82: R = 7.43
    params.Bl(8,2)  =  1.51e+00;
    params.Rms(8,2) =  2.81e-01;
    params.Mms(8,2) =  6.63e-04; 
    params.Cmc(8,2) =  2.30e-04; 
    
    % Resonnance frequency (Hz)
    for ii = 1:8
        for jj = 1:2
        params.f0(ii,jj) = 1/(2*pi*sqrt(params.Mms(ii,jj)*params.Cmc(ii,jj))); 
        end
    end
    
    %% CONTROL TARGET IMPEDENCE PARAMETERS 
    %%%  
    %RMKS: No synthisis: muR = muM = muC = 1; All the same for now
    params.muM_tgt = 1; %target
    params.muR_tgt = 0.2;
    params.muC_tgt = 1;

    % Synthesize all to a same average:
    params.Bl_avg =  mean(params.Bl(:,:),"all");
    params.Mms_avg = mean(params.Mms(:,:),"all");
    params.Rms_avg = mean(params.Rms(:,:),"all");
    params.Cmc_avg = mean(params.Cmc(:,:),"all");

    %Target resonnance frequency
    %params.fst_A = 1/(2*pi*sqrt(params.Mms_avg*params.Cmc_avg))*sqrt(params.muC/params.muM); 

    for ii = 1:8
        for jj = 1:2
        params.muM(ii,jj) = params.muM_tgt*params.Mms_avg/params.Mms(ii,jj);
        params.muR(ii,jj) = params.muR_tgt*params.Rms_avg/params.Rms(ii,jj);
        params.muC(ii,jj) = (params.muC_tgt*params.Cmc_avg)/params.Cmc(ii,jj); 
        params.fst(ii,jj) = params.f0(ii,jj)*sqrt(params.muC_tgt/params.muM_tgt); %Target resonnance frequency
        
        %%% Transfer function Coefs
        %num:
        params.a2(ii,jj) = params.Sd*(params.muM(ii,jj) - 1)*params.Mms(ii,jj);
        params.a1(ii,jj) = params.Sd*(params.muR(ii,jj) - 1)*params.Rms(ii,jj);
        params.a0(ii,jj) = params.Sd*(params.muC(ii,jj) - 1)/params.Cmc(ii,jj);
        %den:   
        params.b2(ii,jj) = params.Bl(ii,jj)*params.muM(ii,jj)*params.Mms(ii,jj);
        params.b1(ii,jj) = params.Bl(ii,jj)*params.muR(ii,jj)*params.Rms(ii,jj);
        params.b0(ii,jj) = params.Bl(ii,jj)*params.muC(ii,jj)/params.Cmc(ii,jj);
        %Transfer functionp. model:
        params.Phi_c(ii,jj) = tf([params.a2(ii,jj),params.a1(ii,jj),params.a0(ii,jj)],[params.b2(ii,jj),params.b1(ii,jj),params.b0(ii,jj)]);%/(sens_p_p*u2i);
        params.Phi_d(ii,jj) = c2d(params.Phi_c(ii,jj),params.ts_rec,'tustin'); %discretized (necessary for SG model
        params.Phi_d(ii,jj) = minreal(params.Phi_d(ii,jj));
        end
    end

    %%% Frequency vector
    %%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% NECESSARY?
    % --> Used to estimate the transfer functions
    params.N = 2^nextpow2((2*params.tmax)*params.fs_acq); 
    t = linspace(0,params.tmax,params.N)';
    params.freq = params.fi + ((params.ff - params.fi)/(params.tmax))*t; %%%linear frequency vector;

    %% CONTROL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% DOMAIN A
    params.kappa_A    = 1*(-params.Sd); % coupling (front pressure) MAX 1
    params.kappa_nl_A = 0e-2*(-params.Sd); % NL coupling (front pressure) MAX 1.5e-2*(-params.Sd)
    params.kerr_nl_A  = 0e12; % local non-linearity (backpressure) MAX 5e12;

    %%% DOMAIN A
    params.kappa_B    = 1*(-params.Sd); % coupling (front pressure) MAX 1
    params.kappa_nl_B = 0e-2*(-params.Sd); % NL coupling (front pressure) MAX 1.5e-2*(-params.Sd)
    params.kerr_nl_B  = 0e12; % local non-linearity (backpressure) MAX 5e12;
end
