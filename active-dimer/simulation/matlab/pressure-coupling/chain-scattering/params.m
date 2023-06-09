%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rho0 = 1.1965; %kg/m^3
c0 = 344.5389; % m/s
Zc = rho0*c0; % Impedance of the air (p/v)
%nu = 18.5E-6; %Coef de viscosité dynamique du fluide
f_src  = 644.50; % Hz speaker + enclosure res freq 644.5

%%% FREQ SWEEP
fi = 100; %% initial frequency
ff = 1000; %% final frequency
A_src = 2; %%% incident pressure amplitude (Pa)

%%% IDENTICAL LINER SPEAKERS
%%% Mechanical
Rms = 0.261*0.2;  %% mechanical resistance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mms = 6.671e-04; %% moving mass

%Cms = 1/((2*pi*f0)^2*Mms);
%Cmb = sqrt(Sd)/(rho0*c0^2*Sd)
%Cmc = Cmb*Cms/(Cmb+Cms) %% mechanical overall compliance (loudspeaker with enclosure)

Cms = 2.13e-04;%1/((2*pi*f0)^2*Mms); Acounts for the cabinet "Cmc"
Sd  = 12e-4; %% m effective surface area
Bl  = 1.4351; %% force factor

%%% speaker acoustic  parameter%4.1 Electroacoustics
Ras = Rms/Sd^2;
Mas = Mms/Sd^2;
Cas = Cms*Sd^2;


%Rss = Rms/Sd;%%% Specific acoustic 
%Mss = Mms/Sd;
%Css = Cms*Sd; 


%
%%% DUCT
h = 0.05; %%m  height of the duct 
S = h*41e-3; %*sqrt(Sd); %m^2

%%% ZONE AT S1&S2
L_a = 41e-3 ;%sqrt(Sd); %length of atoms --> diameter of  speaker
V_a = S*L_a; %m^3 
Maa = rho0*V_a/S^2;    % acoustic mass at speakers
Caa = V_a/(rho0*c0^2); % acoustic compliance at speakers
%Msa = Maa*S;           % specific acoustic mass at speakers
%Csa = Caa/S;           % specific acoustic compliance at speakers

%%% ZONE BETWEEN S1&S2 Electroacoustics 2.3b
L_b =  49.65e-3; %length between atoms is __ times the speaker side !!!!!!!!!!
V_b = S*L_b; %m^3
Mab = rho0*V_b/S^2;    % acoustic mass between speakers
Cab = V_b/(rho0*c0^2); % acoustic compliance between speakers 
%Msb = Mab*S;           % specific acoustic mass between speakers *S
%Csb = Cab/S;           % specific acoustic compliance between speakers /S

%%% CRYSTAL PARAM
a = (L_a*2+L_b*4); %208.6[mm]


