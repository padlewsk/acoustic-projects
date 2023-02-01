% exp(-iwt) time convention whereas in COMSOL it's the opposite.
% --> Im(q)<0 dissipatif
clear all
close all



%{
Mms =  4.3512E-5*5; %kg
Cms =  9.4027E-4*5; %s^2/kg

cte = Mms*Cms;

Cms = cte/(Mms+0.1E-3);
Mms = Mms + 0.1E-3;
%}


%VISATON  FRS 5
Cms = 783E-6*1.5;
Mms = 0.5E-3*0.5;
Rms = 0.3*0.1;
Sd = 12E-4; %m^2 diaphragm surface

%{
%VISATON  FRS5X
Cms = 1038E-6;
Mms = 0.7E-3;
Rms = 0.2;
Sd = 13E-4; %m^2 diaphragm surface

%MONACOR  SPX-21M
Cms = 600E-6;
Mms = 1.45E-3;
Rms = 0.3;
Sd = 13E-4; %m^2 diaphragm surface
%}






a = 0.3; % m cell size
S = 0.05*0.05; % m^2 duct cross section


t = 0.5; % controls distance between resonant cells

omega0 = 1/sqrt(Mms*Cms);


rho0 = 1.184 ; %[kg/m^3]
c0	= 346;%  [m/s]


freq = 10:1:1500;
k = 2*pi*freq/c0;


w =  (c0*rho0/(2*(Mms/Sd^2)*S))*i*2*pi*freq./(1/(Mms*Cms)-(2*pi*freq).^2);

q = acos((1+w.^2).*cos(k*a) + 2*i*w.*sin(k*a) - w.^2.*cos(2*k*a*0.5*t))/a;


%%
clf
figure(1)
set(gca,'FontSize',18)
set(gcf, 'Position',  [1000, 500, 1000, 800])
hold on
plot(real(q*a/pi),freq,'-r','linewidth',2)
plot(imag(q*a/pi),freq,'--k','linewidth',2)
hold off
xlim([-1 1])
xlabel("q\pi/a")
ylabel("f (Hz)")

legend("Dispersion (real part)", "Dispersion (imaginary part)")

box on
grid on


%{
L0 = 0.03;
S0 = (100*pi)*10^(-6);
S = (225*pi)*10^(-6);
V0 = 8E-5;

Mms = rho0*L0/S0*Sd^2;
Cms = V0/(rho0*c0^2)/Sd^2;



omega0 = c0*sqrt(S0/(V0*L0))

w = c0*S0/(2*L0*S)*i*2*pi*freq./(omega0^2-(2*pi*freq).^2);

q = acos((1+w.^2).*cos(k*a) + 2*i*w.*sin(k*a) - w.^2.*cos(2*k*delta))/a;

figure(1)
hold on
plot(real(q*a/pi),freq)
plot(imag(q*a/pi),freq)
legend
hold off
%}
%%




