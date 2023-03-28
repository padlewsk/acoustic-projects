

Sd = 12e-4;
omega_src = 2*pi*2;
T_src = 2*pi/omega_src;
t = linspace(0,10,1000);
% pulse parameters
t0 = 4*T_src;% delay
tau =1*T_src;% width


src = exp(1i*(omega_src.*t)).*exp(-(t-t0).^2/tau^2); %% physicist time convention!!!

figure(1)
plot(t,real(src))