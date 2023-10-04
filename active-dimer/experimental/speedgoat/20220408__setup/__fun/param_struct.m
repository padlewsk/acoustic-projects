function params = param_struct()

    params = struct;
    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% RMK: Manually update the asterixed parameters after running either

    %% SPEAKER PARAM
    params.spkrName = "atm_82";
    params.Re = 7.39; %Ohm
    params.Sd = 12e-4; % Same diaphragm area for both

    %% INPUTS
    params.pf_channel = 1;
    params.pb_channel = 2;
    params.v_channel  = 3;
   
    %% SENSITIVITY
    params.sens_pf = 1/(-35.624327e-3); %(m/s)/V 
    params.sens_pb = 1/(-37.700286e-3); %(m/s)/V 
    
    %unchanged
    params.sens_v = 0.01; %(m/s)/V 
    params.u2i = 10e-3; %current amplifier: Maxime: 10(mA/V); Rivet: 1/103.8 (A/V) 
    
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
    params.A = 0.04; %% source amplitude (V) Tannoy: 0.02 (V)%Duct speaker: 0.15 (V)
    params.tmax = 15; %%20 sweep up measurement time (s) 
    params.fi = 150; %% initial frequency
    params.ff = 1200;%1500; %% final frequency
    
    %%% Frequency vector %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Used to estimate the transfer functions
    params.N = 2^12; % what is chosen
    t = linspace(0,params.tmax,params.N)';
    params.freq = params.fi + ((params.ff - params.fi)/(params.tmax))*t; %%%linear frequency vector;


end

