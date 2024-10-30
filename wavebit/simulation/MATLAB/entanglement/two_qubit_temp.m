close all
clear all

%system freq
freq = 500; %Hz
omega_0 = 2 * pi * freq; % osc res freq
omega_1 = 2 * omega_0; %osc harmonic

%quantum freq
omega_0_q = sqrt(2)*200* omega_0; %quantum res freq
omega_1_q = 2 * omega_0_q; %first quantum harmonic

% Time span
tspan = [0 50*(2*pi)/omega_0];% why is it twice the frequency????? because (psi)^2

%system time
%t = tspan(1):4*(2*pi)/omega_1:tspan(2);

%quantum time 0.5 or 2
t = tspan(1):2*(2*pi)/omega_1_q:tspan(2); %ts must be smaller or equal to (2*pi)/omega_1_q (quantum time step) in order to obtain mixed state

% noisy bell test
%{
noise(1,:) = 0*(rand(1,numel(t))-0.5);
noise(2,:) = 0*(rand(1,numel(t))-0.5);
noise(3,:) = 0*(rand(1,numel(t))-0.5);
noise(4,:) = 0*(rand(1,numel(t))-0.5);
norm = 2^(-1/4);
psi_1_t = norm*(noise(1,:)  + exp(+1i*omega_0_q*t)).*exp(-1i*omega_0*t) + norm*(noise(2,:) + exp(+1i*omega_1_q*t)).*exp(-1i*omega_1*t);
psi_2_t = norm*(noise(3,:)  + exp(-1i*omega_0_q*t)).*exp(-1i*omega_0*t) + norm*(noise(4,:) + exp(-1i*omega_1_q*t)).*exp(-1i*omega_1*t);
%}

%bell test
norm = 2^(-1/4);
psi_1_t = norm*exp(+1i*omega_0_q*t).*exp(-1i*omega_0*t) + norm*exp(+1i*omega_1_q*t).*exp(-1i*omega_1*t);
psi_2_t = norm*exp(-1i*omega_0_q*t).*exp(-1i*omega_0*t) + norm*exp(-1i*omega_1_q*t).*exp(-1i*omega_1*t);
%}
%separable test
%{
psi_1_t = 1/sqrt(2)*(exp(-1i*omega_0*t) + exp(-1i*omega_1*t));
psi_2_t = exp(-1i*omega_0*t) ;
%}

%number of qubits times hermitian product --> probability:
gamma = pi; %(global phase)

%a,b estimate
%
a1_t = exp(+1i*omega_0*t).*psi_1_t;
b1_t = exp(+1i*omega_1*t).*psi_1_t;
a2_t = exp(+1i*omega_0*t).*psi_2_t;
b2_t = exp(+1i*omega_1*t).*psi_2_t;
%}

%{
a1_t = exp(+1i*omega_0_q*t);
b1_t = exp(+1i*omega_1_q*t);
a2_t = exp(-1i*omega_0_q*t);
b2_t = exp(-1i*omega_1_q*t);
%}

%individual state measurement:
a_1 = abs(1/tspan(end)*trapz(t,a1_t))^2 %wb1_state0
b_1 = abs(1/tspan(end)*trapz(t,b1_t))^2 %wb1_state1
a_2 = abs(1/tspan(end)*trapz(t,a2_t))^2 %wb1_state0
b_2 = abs(1/tspan(end)*trapz(t,b2_t))^2 %wb1_state1

%composite state measurement:
a_00 = 1/tspan(end)*trapz(t,a1_t.*a2_t) %wb1_state0
a_01 = 1/tspan(end)*trapz(t,a1_t.*b2_t) %wb1_state0
a_10 = 1/tspan(end)*trapz(t,b1_t.*a2_t) %wb1_state0
a_11 = 1/tspan(end)*trapz(t,b1_t.*b2_t) %wb1_state0



% Plot the results
figure;
tiledlayout(2,1)
nexttile 
hold on
plot(t*(freq), abs(psi_1_t))
%plot(t*(freq), abs(gamma^2.*(1 + exp(1i*omega_0*t).*exp(-1i*omega_1*t))))
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('Abs(\psi_1)');
%legend('cos(\theta/2)〈t|0〉', 'e^{i \phi}sin(\theta/2)〈t|1〉','〈t|\psi_1〉');
legend('|0〉', '|1〉');
%ylim([0 1])
grid on
box on
title('Qubit 1');

% Plot the results
nexttile
hold on
plot(t*(freq), abs(psi_2_t))
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('Abs(\psi_2)');
%legend('cos(\theta/2)〈t|0〉', 'e^{i \phi}sin(\theta/2)〈t|1〉','〈t|\psi_2〉');
legend('|0〉', '|1〉');
%ylim([0 1])
grid on
box on
title('Qubit 2');
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
