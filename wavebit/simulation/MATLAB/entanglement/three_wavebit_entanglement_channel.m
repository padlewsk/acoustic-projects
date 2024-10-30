close all
clear all
clc
addpath('./__fun')  


N = 2; %2 qubits
%system freq
freq = 500; %Hz
omega_0 = 2 * pi * freq; % osc res freq
omega_1 = 2 * omega_0; %osc harmonic

%quantum freq
omega_0_q = sqrt(2)*10*omega_0; %quantum res freq
omega_1_q = 2 * omega_0_q; %first quantum harmonic
omega_2_q = 3 * omega_0_q; %first quantum harmonic

%time span
tspan = [0 10*(2*pi)/omega_1]; %[ti tf]

%time scale <-------------------------------------------------------
t_s = 0.001*(2*pi)/omega_1_q; %avoid integer multiples --> non separable solutions? 
f_s = 1/t_s;
t = tspan(1):t_s:tspan(2); %ts must be smaller or equal to (2*pi)/omega_1_q (quantum time step) in order to observe mixed state

%%% ENTANGLEMENT CHANNELS (carrier)
ch_0 = 1; %DC "local entanglement" ??????????????????
ch_1 = exp(-1i*omega_0_q*t); 
ch_2 = exp(-1i*omega_1_q*t);
ch_3 = exp(-1i*omega_2_q*t);

%%% TEMPORAL STATE REPRESENTAION (signal to transmit)
st_0 = exp(-1i*omega_0*t);
st_1 = exp(-1i*omega_1*t);

%%% COMPOSITE STATE NORMALIZATION
nrm = (1/sqrt(3))^(1/3);
%%% NONSEPARABLE STATE: modulate the coefficients such as to obtain a bell state
%NO
%{
psi_1_t = ((nrm*st_0).*(0*ch_0 +      ch_1  +      0*ch_2)  + (nrm*st_1).*(0*ch_0 + 0*ch_1       +        ch_2));% W STATE
psi_2_t = ((nrm*st_0).*(0*ch_0 + conj(ch_1) + 0*conj(ch_2)) + (nrm*st_1).*(1*ch_0 + 0*conj(ch_1) + 0*conj(ch_2)));
psi_3_t = ((nrm*st_0).*(0*ch_0 + conj(ch_1) + 0*conj(ch_2)) + (nrm*st_1).*(1*ch_0 + 0*conj(ch_1) + 0*conj(ch_2)));
%}

%
%random phase (there are singularities)
psi_1_t =     exp(+1i*(rand-0.5)*2*pi)*((nrm*st_0).*(ch_2)  + (nrm*st_1).*conj(ch_2));% GHZ STATE
psi_2_t = exp(+1i*(rand-0.5)*2*pi)*((nrm*st_0).*conj(ch_1)  +      (nrm*st_1).*ch_1);
psi_3_t = exp(+1i*(rand-0.5)*2*pi)*((nrm*st_0).*conj(ch_1)  +      (nrm*st_1).*ch_1);
%}

% SEPARABLE STATE:
%{
psi_1_t = 1/sqrt(2)*(st_0 + st_1);
psi_2_t = (st_0 );
psi_3_t = (st_1);
%}





a1_t = conj(st_0).*psi_1_t; % Good ESTIMATORS?
b1_t = conj(st_1).*psi_1_t;
a2_t = conj(st_0).*psi_2_t;
b2_t = conj(st_1).*psi_2_t;
a3_t = conj(st_0).*psi_3_t;
b3_t = conj(st_1).*psi_3_t;

%individual state measurement |alpha|^2:
a_1 = 1/tspan(end)*trapz(t,a1_t.*conj(a1_t)) %wb1_state0
b_1 = 1/tspan(end)*trapz(t,b1_t.*conj(b1_t)) %wb1_state1
a_2 = 1/tspan(end)*trapz(t,a2_t.*conj(a2_t)) %wb2_state0
b_2 = 1/tspan(end)*trapz(t,b2_t.*conj(b2_t)) %wb2_state1
a_3 = 1/tspan(end)*trapz(t,a3_t.*conj(a3_t)) %wb3_state0
b_3 = 1/tspan(end)*trapz(t,b3_t.*conj(b3_t)) %wb3_state1

%composite state measurement:
a_000 = 1/tspan(end)*trapz(t,a1_t.*a2_t.*a3_t) 
a_111 = 1/tspan(end)*trapz(t,b1_t.*b2_t.*b3_t) 
a_100 = 1/tspan(end)*trapz(t,b1_t.*a2_t.*a3_t) 
a_010 = 1/tspan(end)*trapz(t,a1_t.*b2_t.*a3_t) 
a_001 = 1/tspan(end)*trapz(t,a1_t.*a2_t.*b3_t) 
a_110 = 1/tspan(end)*trapz(t,b1_t.*b2_t.*a3_t) 
a_101 = 1/tspan(end)*trapz(t,b1_t.*a2_t.*b3_t) 
a_011 = 1/tspan(end)*trapz(t,a1_t.*b2_t.*b3_t) 


norm_psi_1 =  1/tspan(end)*trapz(t,psi_1_t.*conj(psi_1_t))/nrm^2% NOT NORMALIZED 
norm_psi_2 =  1/tspan(end)*trapz(t,psi_2_t.*conj(psi_2_t))/nrm^2% NOT NORMALIZED 
norm_psi_3 =  1/tspan(end)*trapz(t,psi_3_t.*conj(psi_3_t))/nrm^2% NOT NORMALIZED 

%% PLOT
% Plot the results
figure;
tiledlayout(3,1)
nexttile 
hold on
plot(t*(freq), real(psi_1_t),'--')
plot(t*(freq), imag(psi_1_t),'--')
plot(t*(freq), abs(psi_1_t),'-')
%plot(t*(freq), abs(gamma^2.*(1 + exp(1i*omega_0*t).*exp(-1i*omega_1*t))))
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('\psi_1');
%legend('cos(\theta/2)〈t|0〉', 'e^{i \phi}sin(\theta/2)〈t|1〉','〈t|\psi_1〉');
legend('Re(\psi)', 'Im(\psi)', '|\psi|');
%ylim([0 1])
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
%legend('cos(\theta/2)〈t|0〉', 'e^{i \phi}sin(\theta/2)〈t|1〉','〈t|\psi_2〉');
%legend('Re(\psi)', 'Im(\psi)', '|\psi|');
%ylim([0 1])
grid on
box on
title('Qubit 2');

% Plot the results
nexttile
hold on
plot(t*(freq), real(psi_3_t),'--')
plot(t*(freq), imag(psi_3_t),'--')
plot(t*(freq), abs(psi_3_t),'-')
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('\psi_3');
%legend('Re(\psi)', 'Im(\psi)', '|\psi|');
%ylim([0 1])
grid on
box on
title('Qubit 3');
%{
nexttile
hold on
plot(t*(freq), (1/2)*abs((y(:, 1)+y(:, 3)).*(y(:, 5)+y(:, 7))));
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('Probability amplitude');
legend('|00〉', '|01〉', '|10〉', '|11〉');
ylim([0 1])
grid on
title('Composite state');
%}

[F, Psi_1_t] = onesideft(real(psi_1_t),f_s,2);
[F, Psi_2_t] = onesideft(real(psi_2_t),f_s,2);
[F, Psi_3_t] = onesideft(real(psi_3_t),f_s,2);
figure(3)
hold on
plot(F, abs(Psi_1_t)) 
plot(F, abs(Psi_2_t)) 
plot(F, abs(Psi_3_t))
hold off
xlim([0 1.2*omega_2_q/(2*pi)])
ylim([0 1])
legend('psi_1', 'psi_2', 'psi_3')
box on
grid on
