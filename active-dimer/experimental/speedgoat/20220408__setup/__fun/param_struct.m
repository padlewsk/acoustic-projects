function params = param_struct()

    params = struct;

    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% RMK: Manually update the asterixed parameters after running either
    
    %% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.c0 = 347.13; % 300K
    params.rho0 = 1.1839;
    params.Zc = params.c0*params.rho0; % characteristic specific acoustic impedence at 300K
    
    %% SPEEDGOAT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% Machine type
    params.tg_model = 'Mobile'; %target select
    params.MDL = 'SG__MDL_IO104_setup'; % name of the slx model (performance)

    %%% Sample timeCANNOT CHANGE ONCE FLASH
    params.ts_acq = 100e-06; %% % sampling time (s) ED
    params.fs_acq = 1/params.ts_acq;
    
    %% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.A = 0.02; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.15 (V)
    params.tmax = 15; %%20 sweep up measurement time (s) 
    params.fi = 150; %% initial frequency
    params.ff = 1200;%1500; %% final frequency
    
    %% TRANSFER FUNCTION PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %params.wind = []; %floor(N/20); %https://ch.mathworks.com/help/signal/ref/tfestimate.html#bvi01si-window
    
    %% CONTROL SENSITIVITY
    %%% MIC
    %params.sens_p_f =  -1/20.00E-3;% 1/(V/Pa) SN6969 
    %params.sens_p_f =  -1/22.39E-3;% 1/(V/Pa) SN6993
    %params.sens_p_f =  -1/29.86E-3;% 1/(V/Pa) SN5673 
    %params.sens_pf =  -1/51.659363E-3;% 1/(V/Pa) SN29799
    params.sens_pf =  -1/39.6E-3;% 1/(V/Pa) SN65602


    params.sens_v = 0.01; %(m/s)/V 

    %%%  CURRENT TO VOLTAGE
    params.u2i = 10e-3; %current amplifier: Maxime: 10(mA/V); Rivet: 1/103.8 (A/V) 

    %%% PRESSURE TO DISPLACEMENT
    params.pb2disp_m = 925E3*(-20.00E-3); %Trasnferfunction between backpressure and displacement (Pa/m)*(V/Pa) = (V/m)
    params.pb2disp_p = 925E3*(-20.00E-3); %Trasnferfunction between backpressure and displacement (Pa/m)*(V/Pa) = (V/m)
    
    %%% speaker: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.Re = 7.32; %%% !!!!!!!!!!!!!!!!!!!!!! CHANGE FOR EACH SPEAKER
    params.Sd = 12e-4; % Same diaphragm area for both

    %%% Frequency vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Used to estimate the transfer functions
    params.N = 2^12; % what is chosen
    t = linspace(0,params.tmax,params.N)';
    params.freq = params.fi + ((params.ff - params.fi)/(params.tmax))*t; %%%linear frequency vector;


end

