close all
clear all
clc

N = 2; %2 qubits
%system freq
freq = 500; %Hz
omega_0 = 2 * pi * freq; % osc res freq
omega_1 = 2 * omega_0; %osc harmonic

%quantum freq
omega_0_q = sqrt(3)*10*omega_0; %quantum res freq
omega_1_q = 2 * omega_0_q; %first quantum harmonic

%time span
tspan = [0 5*(2*pi)/omega_0]; %[ti tf]

%time scale <-------------------------------------------------------
delta_t = 0.03*(2*pi)/omega_1_q; %avoid integer multiples --> non separable solutions?
%delta_t_list = linspace(0.1,5,1000)*(2*pi)/omega_1_q;

t = tspan(1):delta_t:tspan(2); %ts must be smaller or equal to (2*pi)/omega_1_q (quantum time step) in order to observe mixed state

%%% NONSEPARABLE STATE: modulate the coefficients such as to obtain a bell state
%
NN = 2^(-1/(2*N));
gamma = 0; % global relative phase --> affects a_ij but not their norm
psi_1_t = NN*(exp(+1i*omega_0_q*t).*exp(-1i*omega_0*t) + exp(+1i*omega_1_q*t).*exp(-1i*omega_1*t));
psi_2_t = exp(+1i*gamma)*NN*(exp(-1i*omega_0_q*t).*exp(-1i*omega_0*t) + exp(-1i*omega_1_q*t).*exp(-1i*omega_1*t));
%}
%  with real oscilation
%
NN = 2^(-1/(2*N));
psi_1_t = NN*(cos(+omega_0_q*t).*cos(omega_0*t) + cos(+omega_1_q*t).*cos(omega_1*t));
psi_2_t = NN*(cos(-omega_0_q*t).*cos(omega_0*t) + cos(-omega_1_q*t).*cos(omega_1*t));
%}

%%% SEPARABLE STATE
%
psi_1_t =  1/sqrt(2).*(exp(-1i*omega_0*t) + exp(-1i*omega_1*t));
psi_2_t =  exp(-1i*omega_0*t) ;
%}

% ESTIMATE the coefs a(t),b(t), alpha, from the measured data psi: (lockin)
a_1_t_est = cos(omega_0*t).*psi_1_t; %OT GOOD ESIMATOR !?!
b_1_t_est = cos(omega_1*t).*psi_1_t;
a_2_t_est = cos(omega_0*t).*psi_2_t;
b_2_t_est = cos(omega_1*t).*psi_2_t;
%}

%%% TRUE VALUES OF a(t) and b(t) WORKS
%{
a_1_t_est = NN*exp(+1i*omega_0_q*t);%ones(numel(t),1)*1/sqrt(2); 
b_1_t_est = NN*exp(+1i*omega_1_q*t);%ones(numel(t),1)*1/sqrt(2);
a_2_t_est = NN*exp(-1i*omega_0_q*t);%ones(numel(t),1)*1;
b_2_t_est = NN*exp(-1i*omega_1_q*t);%ones(numel(t),1)*0;%????
%}
%{
a_1_t_est = ones(1,numel(t))*1/sqrt(2) + exp(+1i*omega_0_q*t); % can add any oscillatory term
b_1_t_est = ones(1,numel(t))*1/sqrt(2) + exp(+1i*omega_0_q*t);
a_2_t_est = ones(1,numel(t))*1         + exp(+1i*omega_0_q*t);
b_2_t_est = ones(1,numel(t))*0         + exp(+1i*omega_0_q*t);
%}  


%estimated individual state:
%
a_1_est = 1/tspan(end)*trapz(t, (a_1_t_est)) %wb1_state0
b_1_est = 1/tspan(end)*trapz(t, (b_1_t_est)) %wb1_state1
a_2_est = 1/tspan(end)*trapz(t, (a_2_t_est)) %wb2_state0
b_2_est = 1/tspan(end)*trapz(t, (b_2_t_est)) %wb2_state1
%}

%estimated composite state ????
%
a_00_est = 1/tspan(end)*trapz(t,a_1_t_est.*a_2_t_est) 
a_01_est = 1/tspan(end)*trapz(t,a_1_t_est.*b_2_t_est) 
a_10_est = 1/tspan(end)*trapz(t,b_1_t_est.*a_2_t_est) 
a_11_est = 1/tspan(end)*trapz(t,b_1_t_est.*b_2_t_est) 
%}


%psi_1_est =  1/tspan(end)*trapz(t,psi_1_t.*conj(psi_1_t))% NORMALIZED
%psi_2_est =  1/tspan(end)*trapz(t,psi_2_t.*conj(psi_2_t))% NORMALIZED



%%
close all
% Plot the results
figure(1)
tiledlayout(2,1)
nexttile 
hold on
plot(t*(freq), real(psi_1_t),'--')
plot(t*(freq), imag(psi_1_t),'--')
plot(t*(freq), abs(psi_1_t),'-')
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('\psi_1');
ylim([-2 2])
grid on
box on
title('Qubit 1');

% Plot the results
nexttile
hold on
plot(t*(freq), real(psi_2_t),'--')
plot(t*(freq), imag(psi_2_t),'--')
plot(t*(freq), abs(psi_2_t),'-')
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('\psi_2');
ylim([-2 2])
grid on
box on
title('Qubit 2');

figure(2)
hold on
plot(t,  abs(a_1_t_est)) %mean(abs(a_2_t_est).^2)/2
plot(t,  abs(b_2_t_est))
plot(t,  abs(a_2_t_est))% cte
plot(t,  abs(b_2_t_est))% cte
hold off

figure(3)
hold on
plot(t,  imag(a_1_t_est.*a_2_t_est))
plot(t,  imag(a_1_t_est.*b_2_t_est))
plot(t,  imag(b_1_t_est.*a_2_t_est))% cte
plot(t,  imag(b_1_t_est.*b_2_t_est))% cte
hold off
