function [theta,phi] = state_read(params, t,U_raw)

p = params;
T = t(end)- t(1); 

X_omega_0 = (1/T)*trapz(t,real(exp(-1i*p.omega_0*t)).*U_raw);
Y_omega_0 = (1/T)*trapz(t,real(exp(-1i*(p.omega_0*t + pi/2))).*U_raw);
R_omega_0 = 2*sqrt(X_omega_0^2 + Y_omega_0^2); %%%!!! 2X?
phi_omega_0 = atan2(Y_omega_0,X_omega_0); %rad

%
X_omega_1 = (1/T)*trapz(t,real(exp(-1i*(p.omega_1*t))).*U_raw);
Y_omega_1 = (1/T)*trapz(t,real(exp(-1i*(p.omega_1*t + pi/2))).*U_raw);
R_omega_1 = 2*sqrt(X_omega_1^2 + Y_omega_1^2);%%%!!! 2X?
phi_omega_1 = atan2(Y_omega_1,X_omega_1); %rad
%}


%  relative phase in degrees cf: 20240702
theta = rad2deg(2*atan2(R_omega_0,R_omega_1))-180;
%phi  = mod(rad2deg(angle(exp(1i*(-(phi_omega_1 - params.omega_1/params.omega_0*phi_omega_0))))) - 90,360);%%  relative phase why 90??
phi  = mod(rad2deg(-(phi_omega_1 - p.omega_1/p.omega_0*phi_omega_0))- 90,360);

figure()
hold on
plot(t,U_raw,'-','LineWidth',2)
plot(t,R_omega_0*real(exp(-1i*(p.omega_0*t + phi_omega_0))),'--','LineWidth',1)
plot(t,R_omega_1*real(exp(-1i*(p.omega_1*t + phi_omega_1))),'--','LineWidth',1)
plot(t,real(R_omega_0*exp(-1i*(p.omega_0*t + phi_omega_0)) + R_omega_1*exp(-1i*(p.omega_1*t + phi_omega_1))),'-','LineWidth',1)
%plot(t,real(exp(-1i*phi_omega_0)*(R_omega_0*exp(-1i*(p.omega_0*t)) + exp(1i*(phi_omega_0 - phi_omega_1))*R_omega_1*exp(-1i*(p.omega_1*t)))),'-','LineWidth',1)
hold off
box on
xlim([0 5/p.freq_0])
legend("raw","\psi_0","\psi_1","\psi")
title("")
end
