%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rho0 = 1.1965; %kg/m^3
c0 = 344.5389; % m/s
Zc = rho0*c0; % Impedance of the air (p/v)
%nu = 18.5E-6; %Coef de viscosité dynamique du fluide
f0  = 422; % Hz speaker + enclosure res freq

%%% FREQ SWEEP
fi = 100; %% initial frequency
ff = 1000; %% final frequency
A_pinc = 1; %%% incident pressure amplitude (Pa)

%%% IDENTICAL LINER SPEAKERS
%%% Mechanical
Rms = 0.261;  %% mechanical resistance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Mms = 6.671e-04; %% moving mass

%Cms = 1/((2*pi*f0)^2*Mms);
%Cmb = sqrt(Sd)/(rho0*c0^2*Sd)
%Cmc = Cmb*Cms/(Cmb+Cms) %% mechanical overall compliance (loudspeaker with enclosure)

Cmc = 2.128414e-04;%1/((2*pi*f0)^2*Mms); 
Sd  = 12e-4; %% m effective surface area
Bl  = 1.4351; %% force factor

%%% Acoustic %4.1 Electroacoustics
Ras = Rms/Sd^2;
Mas = Mms/Sd^2;
Cac = Cmc*Sd^2;

%%% DUCT
h = 0.05; %%m  height of the duct 
S = h*sqrt(Sd); %m^2

%%% ZONE AT S1&S2
L_a = sqrt(Sd); %length of atoms
Vaa = S*L_a; %m^3 
Maa = rho0*L_a/S; %acoustic mass at speakers
Caa = (Vaa/(rho0*c0^2));%acoustic compliance at speakers

%%% ZONE BETWEEN S1&S2 Electroacoustics 2.3b
L_b = sqrt(Sd); %length between atoms is __ times the speaker side !!!!!!!!!!
Vab = S*L_b; %m^3
Mab = rho0*L_b/S; %acoustic mass between speakers
Cab = (Vab/(rho0*c0^2)); %acoustic compliance between speakers /S

%%% CRYSTAL PARAM
a = 0.28; %[m]


