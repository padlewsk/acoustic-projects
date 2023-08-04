function param = sys_params()
    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    param.rho0 = 1.1965; %kg/m^3
    param.c0 = 344.5389; % m/s
    param.Zc = param.rho0*param.c0; % Impedance of the air (p/v)
    %nu = 18.5E-6; %Coef de viscosité dynamique du fluide
    param.f_src  = 650; % Hz speaker + enclosure res freq 644.5 for sin and pulse
    
    %%% FREQ SWEEP
    param.fi = 100; %% initial frequency
    param.ff = 1300; %% final frequency
    param.A_src = 5; %%% incident pressure amplitude (Pa) %%% H 17.2
    
    %%% IDENTICAL LINER SPEAKERS
    %%% Mechanical
    param.Rms = 0.261*0.2;  %% mechanical resistance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    param.Mms = 6.671e-04; %% moving mass
    
    %Cms = 1/((2*pi*f0)^2*Mms);
    %Cmb = sqrt(Sd)/(rho0*c0^2*Sd)
    %Cmc = Cmb*Cms/(Cmb+Cms) %% mechanical overall compliance (loudspeaker with enclosure)
    
    param.Cms = 2.13e-04;%1/((2*pi*f0)^2*Mms); Acounts for the cabinet "Cmc"
    param.Sd  = 12e-4; %% m effective surface area
    param.Bl  = 1.4351; %% force factor
    
    %%% speaker acoustic  parameter%4.1 Electroacoustics
    param.Ras = param.Rms/param.Sd^2;
    param.Mas = param.Mms/param.Sd^2;
    param.Cas = param.Cms*param.Sd^2;
    
    %Rss = Rms/Sd;%%% Specific acoustic 
    %Mss = Mms/Sd;
    %Css = Cms*Sd; 
    
    %
    %%% DUCT
    param.h = 0.05; %%m  height of the duct 
    param.S = param.h*41e-3; %*sqrt(Sd); %m^2
    
    %%% ZONE AT S1&S2
    param.L_a = 41e-3 ;%sqrt(Sd); %length of atoms --> diameter of  speaker
    param.V_a = param.S*param.L_a; %m^3 
    param.Maa = param.rho0*param.V_a/param.S^2;    % acoustic mass at speakers
    param.Caa = param.V_a/(param.rho0*param.c0^2); % acoustic compliance at speakers
    %Msa = Maa*S;           % specific acoustic mass at speakers
    %Csa = Caa/S;           % specific acoustic compliance at speakers
    
    %%% ZONE BETWEEN S1&S2 Electroacoustics 2.3b
    param.L_b =  49.65e-3; %length between atoms is __ times the speaker side !!!!!!!!!!
    param.V_b = param.S*param.L_b; %m^3
    param.Mab = param.rho0*param.V_b/param.S^2;    % acoustic mass between speakers
    param.Cab = param.V_b/(param.rho0*param.c0^2); % acoustic compliance between speakers 
    %Msb = Mab*S;           % specific acoustic mass between speakers *S
    %Csb = Cab/S;           % specific acoustic compliance between speakers /S
    
    %%% CRYSTAL PARAM
    param.a = (param.L_a*2+param.L_b*4); %208.6[mm]
end
