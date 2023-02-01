clear all
clc
%% Phyiscs Parameters
rho0 = 1.18; % (kg/m^3)
c0 = 346; %(m/s)

%%T/S parameters
Fs  = 250;
Qes = 3.22;
Qms	= 3.31;
Qts	= 1.63;
Vas = 1.00E-04; %(m^3)
Sd  = 1.20E-03;%(m^2)


%save('vistaton_frws_5__FS_specs.txt','Fs','Qes','Qms','Qts','Vas','Sd','-ascii')

%%Mechanical parameters

Cms = Vas/(rho0*c0^2*Sd^2) %m/N
Mms = 1/((2*pi*Fs)^2*Cms) %kg
Rms = 1/Qms*sqrt(Mms/Cms) %N.s/m