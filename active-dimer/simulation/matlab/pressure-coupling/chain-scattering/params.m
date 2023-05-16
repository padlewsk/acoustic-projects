%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rho0 = 1.1965; %kg/m^3
c0 = 344.5389; % m/s
Zc = rho0*c0; % Impedance of the air
%nu = 18.5E-6; %Coef de viscosité dynamique du fluide
f0  = 500; % Hz speaker + enclosure res freq

%%% FREQ SWEEP
fi = 100; %% initial frequency
ff = 1000; %% final frequency
A_pinc = 1; %%% incident pressure amplitude (Pa)

%%% IDENTICAL LINER SPEAKERS
%%% Mechanical
Rms = 0.3529;    %% mechanical resistance
Mms = 0.5936e-3; %% moving mass

%Cms = 1/((2*pi*f0)^2*Mms);
%Cmb = sqrt(Sd)/(rho0*c0^2*Sd)
%Cmc = Cmb*Cms/(Cmb+Cms) %% mechanical overall compliance (loudspeaker with enclosure)

Cmc = 1/((2*pi*f0)^2*Mms); 
Sd  = 12e-4; %% m effective surface area
Bl  = 1.4351; %% force factor

%%% Acoustic
Ras = Rms/Sd;
Mas = Mms/Sd;
Cac = Cmc*Sd;

%%% DUCT
h = 0.01; %%m  height of the duct 
S = h*sqrt(Sd); %m^2

%%% ZONE AT S1&S2
Vaa =S*sqrt(Sd); %m^3 ?????????
Maa = rho0*Vaa/S; %acoustic mass at speakers
Caa = (Vaa/(rho0*c0^2))/S;%acoustic compliance at speakers

%%% ZONE BETWEEN S1&S2
DeltaX_b = sqrt(Sd); %space between atoms is __ times the speaker side !!!!!!!!!!
Vab = S*DeltaX_b; %m^3
Mab = rho0*Vab/S; %acoustic mass between speakers
Cab = (Vab/(rho0*c0^2))/S; %acoustic compliance between speakers


