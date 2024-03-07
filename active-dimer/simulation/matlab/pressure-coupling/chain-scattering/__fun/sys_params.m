function sys_param = sys_params()
    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% PHYSICS PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sys_param.rho0 = 1.1965; %kg/m^3
    sys_param.c0 = 344.5389; % m/s
    sys_param.Zc = sys_param.rho0*sys_param.c0; % Impedance of the air (p/v)
    %nu = 18.5E-6; %Coef de viscosité dynamique du fluide
    
    %% PHYSICAL PARAMETERS
    %%% Mechanical
    sys_param.Rms = 0.261*0.25;  %% mechanical resistance 0.25 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 0.05
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
    
    sys_param.f_res = 1/(2*pi*sqrt(sys_param.Mas*sys_param.Cas));
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
    sys_param.N_cell = 32; %number of unit cells (= half the number of sites)
    sys_param.mat_size = sys_param.N_cell*8+1; %number of nodes in the acoustic circuit

    %% TRANSFER MATRIX UNIT CELL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% BETWEEN RESONATORS
    M_b = [% specific acoustic mass term
       -sys_param.Mab/2,    0  ;  % RMK: opposite sign to aid with building the cell matrix (first line only)c.f.__20230515__theory
         0  , -sys_param.Mab/2;
        ];
    R_b = [% resistance term
         0 , 0;% RMK:
         0 , 0;
        ];
    K_b = [% specific acoustic  complicance term
         -1/sys_param.Cab,  1/sys_param.Cab ;
         1/sys_param.Cab,  -1/sys_param.Cab;
        ];

    %%% AT RESONATORS 
    M_a = [% specific acoustic  mass term
       -sys_param.Maa/2, 0,    0  ;
         0 ,  sys_param.Mas,    0  ;
         0 ,   0 , -sys_param.Maa/2;
        ];
    R_a = [%  specific acoustic resistance term
        0,  0, 0;% RMK:
        0, sys_param.Ras, 0;
        0,  0  ,0;
         ];
    K_a = [%  specific acoustic complicance term
         -1/sys_param.Caa,     1/sys_param.Caa   , +1/sys_param.Caa  ;% RMK:
         -1/sys_param.Caa,  1/sys_param.Cas+1/sys_param.Caa,  1/sys_param.Caa;
          1/sys_param.Caa,    -1/sys_param.Caa   , -1/sys_param.Caa;
         ];
  
    %%% BUILD UNITCELL 9x9 matrix (--> [_b_a_b_b_a_b_] 2+3+2+2+3+2 - (6-1) = 9)
    M_cell = zeros(9,9); % Cell mass matrix
    R_cell = M_cell;     % Cell resistance matrix
    K_cell = M_cell;     % Cell complicance matrix
    
    M_cell(1:2,1:2) = M_cell(1:2,1:2) + M_b; %between speaker
    M_cell(2:4,2:4) = M_cell(2:4,2:4) + M_a; %at speaker
    M_cell(4:5,4:5) = M_cell(4:5,4:5) + M_b;
    M_cell(5:6,5:6) = M_cell(5:6,5:6) + M_b;
    M_cell(6:8,6:8) = M_cell(6:8,6:8) + M_a;
    M_cell(8:9,8:9) = M_cell(8:9,8:9) + M_b;

    R_cell(1:2,1:2) = R_cell(1:2,1:2) + R_b; %between speaker
    R_cell(2:4,2:4) = R_cell(2:4,2:4) + R_a; %at speaker
    R_cell(4:5,4:5) = R_cell(4:5,4:5) + R_b;
    R_cell(5:6,5:6) = R_cell(5:6,5:6) + R_b;
    R_cell(6:8,6:8) = R_cell(6:8,6:8) + R_a;
    R_cell(8:9,8:9) = R_cell(8:9,8:9) + R_b;

    K_cell(1:2,1:2) = K_cell(1:2,1:2) + K_b; %between speaker
    K_cell(2:4,2:4) = K_cell(2:4,2:4) + K_a; %at speaker
    K_cell(4:5,4:5) = K_cell(4:5,4:5) + K_b;
    K_cell(5:6,5:6) = K_cell(5:6,5:6) + K_b;
    K_cell(6:8,6:8) = K_cell(6:8,6:8) + K_a;
    K_cell(8:9,8:9) = K_cell(8:9,8:9) + K_b;
    
    %%% BUILD CRYSTAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    sys_param.M = zeros(sys_param.mat_size,sys_param.mat_size);
    sys_param.R = sys_param.M;
    sys_param.K = sys_param.M;

    for nn = [1:sys_param.N_cell]  %RMK M(1:9,1:9) =  M_cell(:,:)% first block
        nn = nn-1;
        mat_seg = [1+nn*8:9+nn*8];   
        sys_param.M(mat_seg, mat_seg) = sys_param.M(mat_seg, mat_seg) +  M_cell(:,:); % where disorder should be put!
        sys_param.R(mat_seg, mat_seg) = sys_param.R(mat_seg, mat_seg) +  R_cell(:,:);
        sys_param.K(mat_seg, mat_seg) = sys_param.K(mat_seg, mat_seg) +  K_cell(:,:);
    end

    
    %%% SOURCE
    sys_param.fi = 630; %% initial frequency 300
    sys_param.ff = 660; %% final frequency 1300
    sys_param.A_src = 8; %%% incident pressure amplitude (Pa) %%% NL
    sys_param.f_src  = 644.5;%644.5; % Hz speaker + enclosure res freq 644.5 for sin and pulse 
    sys_param.src_select = 1; % 0 = SINE*SIGMOIDE at sys_param.f_src; 1 = PULSE CENTERED AT sys_param.f_src %%% 2 sweep 
    sys_param.src_loc = [1];%source location (at each circuit node)
    %sys_param.src_loc = [1 sys_param.mat_size];% [round(sys_param.mat_size/2)]; %%%%%%%
    %sys_param.src_loc = [1:sys_param.mat_size]; % All nodes are sources

    %%% SAMPLING (for post processing --> doesn't affect sim time alot)
    sys_param.f_samp = 3*(sys_param.ff); %must be at least over 2*niquist %% even higher
    sys_param.t_samp = 1/sys_param.f_samp;

    %%% SIMULATION TIME (MATLAB odes use adaptive step size)2*0.3;%
    sys_param.t_fin =  5*sys_param.N_cell*sys_param.a/sys_param.c0; % 5 for pulse dynamics, 30 for cte %simulation time in seconds (time for sound to go from source to end of crystal)
    
    %%% COUPLING MATRIX
  % coupling
    sys_param.kappa    = 0.8; % ADDED coupling (front pressure) use 0.8 MAX 1;
    sys_param.kappa_nl = 0*(0.9e-2); % NL coupling (front pressure) MAX 0.8e-2 @ A = 8
    %kerr_nl  = 0e12; % local non-linearity (backpressure) MAX 5e12; %TO IMPLEMENT

    %constant disorder variance (time-independant)
    sys_param.sigma_cpl = 0; % from 0 to 1
    sys_param.sigma_loc = 0; % from 0 to 1

    %temperature disorder variance (time-dependant)
    sys_param.sigma_T = 0; % from 0 to 1 %%% MUST REBUILD FOR NOW
    
    %non-reciprocal disorder switch:
    sys_param.isnonreciprocal = 0; %%% MUST REBUILD FOR NOW
   
    %normrnd seed in disorder function:
    idx_rng = 1;

    % INTERFACE TYPE SELECTOR %20240201 CORRECTION
    sys_param.cpl = mod(0:2*sys_param.N_cell-2,2); %interfaceless trivial
    %sys_param.cpl = mod(1:2*sys_param.N_cell-1,2); %interfaceless topological
    %sys_param.cpl = [mod(0:sys_param.N_cell,2) mod(sys_param.N_cell:2*sys_param.N_cell-3,2)];% interface 1 
    %sys_param.cpl = [mod(0:sys_param.N_cell-2,2) mod(sys_param.N_cell:2*sys_param.N_cell-1,2)];% interface 2 best



    sys_param.cpl_L    = sys_param.kappa*sys_param.cpl;   % Linear coupling
    sys_param.cpl_R    = sys_param.kappa*sys_param.cpl;   % Linear coupling

    sys_param.cpl_nl_L = sys_param.kappa_nl*sys_param.cpl;% Nonlinear coupling
    sys_param.cpl_nl_R = sys_param.kappa_nl*sys_param.cpl;% Nonlinear coupling

    lambda = 1; %from 0 to 1
    sys_param.cpl_L    = sys_param.kappa*[lambda*sys_param.cpl(1:end/2) -lambda*sys_param.cpl((end/2):end)]
    sys_param.cpl_R    = sys_param.kappa*[lambda*sys_param.cpl(1:end/2) -lambda*sys_param.cpl((end/2):end)]
    sys_param.cpl_nl_L = sys_param.kappa_nl*[lambda*sys_param.cpl(1:end/2) -lambda*sys_param.cpl((end/2):end)]
    sys_param.cpl_nl_R = sys_param.kappa_nl*[lambda*sys_param.cpl(1:end/2) -lambda*sys_param.cpl((end/2):end)]
    % UPDATE DISORDERED PARAMS
    %sys_param = disorder(sys_param,idx_rng); %%%%%%% TEMP

    %{
    sys_param.kappa    = 0  ;%0.8
    sys_param.kappa_nl = 0*5e-3; %7e-3 with A = 10 and interface 2 for 8 cells (5e-3 for 32 cells)
    %mat = mod(1:2*sys_param.N_cell-1,2); %interfaceless
    %mat = [mod(1:sys_param.N_cell,2) mod(sys_param.N_cell:2*sys_param.N_cell-2,2)];% interface 1 
    mat = [mod(1:sys_param.N_cell-2,2) mod(sys_param.N_cell:2*sys_param.N_cell,2)];% interface 2 
    %mat = [mod(1:sys_param.N_cell-1,2) mod(sys_param.N_cell+1:2*sys_param.N_cell,2)];% interface  with double link 
    %
    sys_param.cpl = sys_param.kappa*mat;
    sys_param.cpl_nl = sys_param.kappa_nl*mat;
    %}
end
