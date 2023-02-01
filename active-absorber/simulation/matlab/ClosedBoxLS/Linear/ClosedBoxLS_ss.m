%%% State Space representation of the Closed Box Loud Speaker 
%%% Romain thesis p36 --> sign pb??

%% PARAMETERS 
p0 = 101325; %atmospheric pressure (Pa)
Zc = 346.13*1.1839; % characteristic specific acoustic impedence at 25°C

% Speaker (Visaton AL-170)
Sd = 133E-4;    % Effective piston area [m^2]
Mms  = 13E-3;      % Moving mass [kg]
Rms = 0.6;       % Mechanical resitance [N.s/m]
Cms = 594.85E-6; % Mechanical complicance due to surround suspension and spider [m/N]
Cab = 10;       % Compliance of enclosure due to back pressure [N/m^4]
Cmc = (1/Cms + Sd^2/Cab)^-1;

f0 = 1/(2*pi*sqrt((Mms*Cms*Cab)/(Sd^2*Cms+Cab)))% % Resonnance frequency Hz

Bl = 6.9;        % Force factor [N/A]
Le = 0.9E-3;    % Voice coil inductance [H]
Re = 5.6;       % DC coil resistance [Ohm]


%%% State matrices

A = [0 1 0;
    -1/(Cmc*Mms) -Rms/Mms Bl/Mms; 
    0 -Bl/Le -Re/Le];

B = [0 0;
    Sd/Mms 0;
    0 1/Le];

C = [0 1 0];

D = 0;


sys = ss(A,B,C,D) % creates a continuous-time state-space model object of the following form
