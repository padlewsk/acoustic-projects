%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rho0 = 1.18; %kg/m^3
c0 = 346; % m/s
Zc = rho0*c0; % Impedance of the air
%nu = 18.5E-6; %Coef de viscosité dynamique du fluide
f0  = 250; % Hz speaker + enclosure res freq

%%% FREQ SWEEP
fi = 100; %% initial frequency
ff = 500; %% final frequency
A_pinc = 0.2; %%% incident pressure amplitude (Pa)

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
Ras = Rms/Sd^2;
Mas = Mms/Sd^2;
Cac = Cmc*Sd^2;

%%% DUCT
h = 0.005; %%m  height of the duct 
S = h*sqrt(Sd); %m^2

%%% ZONE BELOW S1&S2
V =S*sqrt(Sd); %m^3
Ma = rho0*V/S;
Ca = (V/(rho0*c0^2))/S;

%%% ZONE BETWEEN S1&S2
DeltaX_btwn = sqrt(Sd); %space between atoms is __ times the speaker side
V_btwn = S*DeltaX_btwn; %m^3
Ma_btwn = rho0*V_btwn/S;
Ca_btwn = (V_btwn/(rho0*c0^2))/S;


