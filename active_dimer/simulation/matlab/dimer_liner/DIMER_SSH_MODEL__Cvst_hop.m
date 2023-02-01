clear all
close all
clc

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');

t = 0.3;
Sduc = 2.5E-3; %%% m^2 duct cross sectional area
Seff = @(t) 0.5*Sduc*(1./t - 2); %%% effective cavity cross sectional area emulated by speaker
Sd = 13E-4;

L = 0.041;%m
a = 2*L; %unit cell length
fmax = c0/a; % = c/(2*l)


%%%MONACOR  SPX-21M
Rms = 0.3;
Mms = 1.45e-3
Cms = @(x) (x/2)*(L/2)/(rho0*c0^2*Sd^2); % x = Seff
f = linspace(50,fmax,1000);

s = (1i*2*pi*f);


Cms_nom = 600E-6% %m/N Nominal speaker compliance


%%% Mechanical Impedance
Z = Mms.*s + Rms + 1./(s.*Cms(Seff(t)));
f0 = 1/(2*pi*sqrt(Mms*Cms(Seff(t))));

%% PLOTS
clf
%%% Z bode plot
figure(1)
set(gca,'FontSize',25)
subplot(211), semilogx(f,20*log10(abs(Z)),'LineWidth', 2)    
xline(f0,'r--',string('f_0 = ' + string(round(f0))+ ' Hz'));
grid                                                               
ylabel('Mechanical Impedance (dB)')                                           
subplot(212), semilogx(f,180/pi*unwrap(angle(Z)),'LineWidth', 2)                  
ylabel('Phase (deg)')                                          
xlabel('Frequency (Hz)')                                           
grid  





t = linspace(0,1,100);

%
figure(2)
set(gca,'FontSize',14)
hold on
yline(0,'--k','LineWidth', 2)
xline(0.5,'--k','LineWidth', 2)
yline(Cms_nom,'r','Nominal C_{ms}','LineWidth', 2)
plot(t,Cms(Seff(t)),'LineWidth', 3)
ylim([-1E-4 7E-4])
hold off
xlabel("Coupling parameter t")
ylabel("C_{ms} (m/N)") % (s^2/kg)
grid on;
box on;
%}

