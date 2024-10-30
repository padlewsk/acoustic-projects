function [tau_out,x_tau_out,y_tau_out] = cnot(params,t,x_t_in,y_t_in)
p = params;

t_delay = 0.25*(2*pi/p.omega_0); %quarter delay in seconds
N_delay = round(t_delay/p.ts_ctr); %quarter delay in samples

tau_out = t; 
tt  = t + t_delay;%  tt is advances a quarter period w/r to t

%%% DUAL INTEGRAL cf https://ch.mathworks.com/help/matlab/ref/trapz.html
[T,TT] = meshgrid(t,tt);
DeltaT = t(end)- t(1);


[x_t,y_tt] = meshgrid(conj(hilbert(x_t_in)),conj(circshift(hilbert(y_t_in),N_delay))); % requires phase shift ?

%x_t = exp(-1i*p.omega_1*T); % TEST STATE
%y_tt = exp(-1i*p.omega_1*TT);%TEST STATE

%cf eq.4
F00 = x_t.*exp(1i*p.omega_0*T).*exp(1i*p.omega_0*TT).*y_tt;
F01 = x_t.*exp(1i*p.omega_0*T).*exp(1i*p.omega_1*TT).*y_tt;
F11 = x_t.*exp(1i*p.omega_1*T).*exp(1i*p.omega_1*TT).*y_tt;
F10 = x_t.*exp(1i*p.omega_1*T).*exp(1i*p.omega_0*TT).*y_tt;

H00 = 1/(DeltaT^2)*trapz(t,trapz(tt,F00,2)).*exp(1i*p.omega_0*tau_out).*exp(1i*p.omega_0*tau_out);
H01 = 1/(DeltaT^2)*trapz(t,trapz(tt,F01,2)).*exp(1i*p.omega_0*tau_out).*exp(1i*p.omega_1*tau_out);
H11 = 1/(DeltaT^2)*trapz(t,trapz(tt,F11,2)).*exp(1i*p.omega_1*tau_out).*exp(1i*p.omega_0*tau_out);
H10 = 1/(DeltaT^2)*trapz(t,trapz(tt,F10,2)).*exp(1i*p.omega_1*tau_out).*exp(1i*p.omega_1*tau_out);

H = H00 + H01 + H11 + H10;

x_tau_out = real(x_t(1,:)');
y_tau_out = real(conj(x_t(1,:)').*H);

end
