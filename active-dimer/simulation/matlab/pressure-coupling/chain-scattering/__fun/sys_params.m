function sys_param = sys_params()
    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% PHYSICS PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sys_param.rho0 = 1.1965; %kg/m^3
    sys_param.c0 = 344.5389; % m/s
    sys_param.Zc = sys_param.rho0*sys_param.c0; % Impedance of the air (p/v)
    %nu = 18.5E-6; %Coef de viscosité dynamique du fluide
    
    %%% IDENTICAL LINER SPEAKERS
    %%% Mechanical
    sys_param.Rms = 0.261*0.2;  %% mechanical resistance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sys_param.Mms = 6.671e-04; %% moving mass
    
    %Cms = 1/((2*pi*f0)^2*Mms);
    %Cmb = sqrt(Sd)/(rho0*c0^2*Sd)
    %Cmc = Cmb*Cms/(Cmb+Cms) %% mechanical overall compliance (loudspeaker with enclosure)
    
    sys_param.Cms = 2.13e-04;%1/((2*pi*f0)^2*Mms); Acounts for the cabinet "Cmc"
    sys_param.Sd  = 12e-4; %% m effective surface area
    sys_param.Bl  = 1.4351; %% force factor
    
    %%% speaker acoustic  parameter%4.1 Electroacoustics
    sys_param.Ras = sys_param.Rms/sys_param.Sd^2;
    sys_param.Mas = sys_param.Mms/sys_param.Sd^2;
    sys_param.Cas = sys_param.Cms*sys_param.Sd^2;
    
    %Rss = Rms/Sd;%%% Specific acoustic 
    %Mss = Mms/Sd;
    %Css = Cms*Sd; 
    
    %
    %%% DUCT
    sys_param.h = 0.05; %%m  height of the duct 
    sys_param.S = sys_param.h*41e-3; %*sqrt(Sd); %m^2
    
    %%% ZONE AT S1&S2
    sys_param.L_a = 41e-3 ;%sqrt(Sd); %length of atoms --> diameter of  speaker
    sys_param.V_a = sys_param.S*sys_param.L_a; %m^3 
    sys_param.Maa = sys_param.rho0*sys_param.V_a/sys_param.S^2;    % acoustic mass at speakers
    sys_param.Caa = sys_param.V_a/(sys_param.rho0*sys_param.c0^2); % acoustic compliance at speakers
    %Msa = Maa*S;           % specific acoustic mass at speakers
    %Csa = Caa/S;           % specific acoustic compliance at speakers
    
    %%% ZONE BETWEEN S1&S2 Electroacoustics 2.3b
    sys_param.L_b =  49.65e-3; %length between atoms is __ times the speaker side !!!!!!!!!!
    sys_param.V_b = sys_param.S*sys_param.L_b; %m^3
    sys_param.Mab = sys_param.rho0*sys_param.V_b/sys_param.S^2;    % acoustic mass between speakers
    sys_param.Cab = sys_param.V_b/(sys_param.rho0*sys_param.c0^2); % acoustic compliance between speakers 
    %Msb = Mab*S;           % specific acoustic mass between speakers *S
    %Csb = Cab/S;           % specific acoustic compliance between speakers /S
    
    %%% CRYSTAL PARAM
    sys_param.a = (sys_param.L_a*2+sys_param.L_b*4); %208.6[mm]
    
    %%% SIMULATION PARAMETERS    
    %%% SYSTEM SIZE
    sys_param.N_cell = 16; %number of unit cells (= half the number of sites)
    sys_param.mat_size = sys_param.N_cell*8+1; %number of nodes in the acoustic circuit

    %%% SOURCE
    sys_param.fi = 500; %% initial frequency
    sys_param.ff = 1300; %% final frequency
    sys_param.A_src = 10; %%% incident pressure amplitude (Pa) %%% NL
    sys_param.f_src  = 645; % Hz speaker + enclosure res freq 644.5 for sin and pulse
    sys_param.src_select = 1; % 0 = SINE*SIGMOIDE at sys_param.f_src; 1  %%% PULSE CENTERED AT sys_param.f_src %%% 2 white noise (doesn't work)
    %sys_param.src_loc = [1];% 
    sys_param.src_loc =[1 sys_param.mat_size];% [round(sys_param.mat_size/2)]; %%%%%%%

    %%% SAMPLING (for post processing --> doesn't affect sim time alot)
    sys_param.f_samp = 3*(sys_param.ff-0*sys_param.fi); %must be at least over 2*niquist %%
    sys_param.t_samp = 1/sys_param.f_samp;

    %%% SIMULATION TIME (MATLAB odes use adaptive step size)
    sys_param.t_fin =  10*sys_param.N_cell*sys_param.a/sys_param.c0; %simulation time in seconds (time for sound to go from source to end of crystal)
    
    %%% COUPLING MATRIX
    kappa    = 0.8;
    kappa_nl = 0e-3; %+9e-3 with a = 10
    mat = mod(1:2*sys_param.N_cell-1,2); %interfaceless
    %mat = [mod(1:sys_param.N_cell,2) mod(sys_param.N_cell:2*sys_param.N_cell-2,2)];% interface 1 (better --> single peak)
    %mat = [mod(1:sys_param.N_cell-1,2) mod(sys_param.N_cell+1:2*sys_param.N_cell,2)];% interface 2
    sys_param.cpl = kappa*mat;
    sys_param.cpl_nl = kappa_nl*mat;
end
