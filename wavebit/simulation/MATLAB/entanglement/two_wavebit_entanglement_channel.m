close all
clear all
clc
addpath('./__fun')  
addpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox')


N = 2; %2 qubits
%system freq
freq = 500; %Hz
omega_0 = 2 * pi * freq; % osc res freq
omega_1 = 2 * omega_0; %osc harmonic

%quantum entanglement channel
Omega_0 = sqrt(2)*5*omega_0; %quantum res freq must be larger than twice envolope freq
Omega_1 = 2 * Omega_0; %first quantum harmonic

%time span
tspan = [0 5*(2*pi)/omega_1]; %[ti tf]

%time scale <-------------------------------------------------------
t_s = 0.001*(2*pi)/Omega_1; %avoid integer multiples --> non separable solutions? 
f_s = 1/t_s;
t = tspan(1):t_s:tspan(2); %ts must be smaller or equal to (2*pi)/omega_1_q (quantum time step) in order to observe mixed state

%%% ENTANGLEMENT CHANNELS (carrier)
ch_0 = 1; %DC "local entanglement" ??????????????????
ch_1 = exp(-1i*Omega_0*t); 
ch_2 = exp(-1i*Omega_1*t);

%%% TEMPORAL STATE REPRESENTAION (signal to transmit)
st_0 = exp(-1i*omega_0*t);
st_1 = exp(-1i*omega_1*t); 


%%% COMPOSITE STATE NORMALIZATION
nrm = (1/sqrt(2))^(1/2);
%%% NONSEPARABLE STATE: modulate the coefficients such as to obtain a bell state
%
psi_1_t =  (nrm*st_0).*(     ch_1 ) + (nrm*st_1).*(     ch_2);
psi_2_t =  (nrm*st_0).*(conj(ch_1)) + (nrm*st_1).*(conj(ch_2));
%}
%{
%random globalphases
psi_1_t =  exp(+1i*(rand-0.5)*2*pi).*((nrm*st_0).*(     ch_1 ) + (nrm*st_1).*(     ch_2));
psi_2_t =  exp(+1i*(rand-0.5)*2*pi).*((nrm*st_0).*(conj(ch_1)) + (nrm*st_1).*(conj(ch_2)));
%}

%%% SEPARABLE STATE
%{
psi_1_t = (st_0).*(ch_0);
psi_2_t = (st_0).*(ch_0);
%}

%{
psi_1_t = (1/sqrt(2)*st_0).*(ch_0) + (1/sqrt(2)*st_1).*(ch_0);
psi_2_t = (st_0).*(ch_0);
%}

% ESTIMATE the coefs, alpha, from the measured data psi: (lockin) TODO!!!
%
a1_t_est = conj(st_0).*psi_1_t;% conj(st_0).*psi_1_t; %% NOT GOOD ESTIMATORS!!!
b1_t_est = conj(st_1).*psi_1_t;
a2_t_est = conj(st_0).*psi_2_t;
b2_t_est = conj(st_1).*psi_2_t;
%}

%estimated individual static state: (get DC value

norm_a1_est = 1/tspan(end)*trapz(t, a1_t_est.*conj(a1_t_est)) %wb1_state0
norm_b1_est = 1/tspan(end)*trapz(t, b1_t_est.*conj(a1_t_est)) %wb1_state1
norm_a2_est = 1/tspan(end)*trapz(t, a2_t_est.*conj(a1_t_est)) %wb2_state0
norm_b2_est = 1/tspan(end)*trapz(t, b2_t_est.*conj(a1_t_est)) %wb2_state1
%}

%estimated composite state ????
%
norm_a_00 = norm(1/tspan(end)*trapz(t,a1_t_est.*a2_t_est))
norm_a_01 = norm(1/tspan(end)*trapz(t,a1_t_est.*b2_t_est))
norm_a_10 = norm(1/tspan(end)*trapz(t,b1_t_est.*a2_t_est))
norm_a_11 = norm(1/tspan(end)*trapz(t,b1_t_est.*b2_t_est))
%}




norm_psi_1 =  1/tspan(end)*trapz(t,psi_1_t.*conj(psi_1_t))/nrm^2% NOT NORMALIZED
norm_psi_2 =  1/tspan(end)*trapz(t,psi_2_t.*conj(psi_2_t))/nrm^2% NOT NORMALIZED

%[F, Psi_1_t] = onesideft(psi_1_t,f_s,2);
%%
fig_param = fig_params;
close all

%%% FIGURE 1 %%%
% Plot the results

fig1 = figure(1)
cmap = copper(3)
set(gcf,'position',fig_param.window_size);
tiledlayout(2,1)
nexttile 
hold on
plot(t*(freq), real(psi_1_t),'-','LineWidth', 2,'color', [0.5, 0.7235, 0.8705])
plot(t*(freq), imag(psi_1_t),'--','LineWidth', 2,'color',[0.5, 0.7235, 0.8705])
plot(t*(freq), abs(psi_1_t),'-','LineWidth', 3,'color',	[0, 0.4470, 0.7410])
hold off
%xlabel('Cycles (s \cdot f_0)');
ylabel('\psi_1');
ylim([-2 2])
grid on
box on
%title('Qubit 1');
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');

% Plot the results
nexttile
hold on
plot(t*(freq), real(psi_1_t),'-','LineWidth', 2,'color', [0.8175, 0.5390, 0.5920])
plot(t*(freq), imag(psi_1_t),'--','LineWidth', 2,'color',[0.8175, 0.5390, 0.5920])
plot(t*(freq),  abs(psi_1_t),'-','LineWidth', 3,'color',[0.6350, 0.0780, 0.1840])
hold off
xlabel('Cycles (2\pi/\omega_0)');
ylabel('\psi_2');
ylim([-2 2])
grid on
box on
%title('Qubit 2');
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');

%%% FIGURE 2 %%%
[F, raw_env] = onesideft(real(1/sqrt(2)*(st_0 + st_1)),f_s,2);
[F, raw_ch1] = onesideft(real(ch_1),f_s,2);
[F, raw_ch2] = onesideft(real(ch_2),f_s,2);
[F, env_ch0] = onesideft(real(1/sqrt(2)*(st_0 + st_1)).*real(ch_0),f_s,2);
[F, env_ch1] = onesideft(real(1/sqrt(2)*(st_0 + st_1)).*real(ch_1),f_s,2);
[F, env_ch2] = onesideft(real(1/sqrt(2)*(st_0 + st_1)).*real(ch_2),f_s,2);
%[F, A0] = onesideft(ch_0.*conj(st_0).*psi_2_t,f_s,2);
%[F, A1] = onesideft(ch_1.*conj(st_0).*psi_2_t,f_s,2);
%[F, A2] = onesideft(ch_2.*conj(st_0).*psi_2_t,f_s,2);

fig2 = figure(2)
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');
hold on
plot(F, abs(raw_env),'LineWidth', 2) 
plot(F, abs(raw_ch1),'LineWidth', 2) 
plot(F, abs(raw_ch2),'LineWidth', 2) 
plot(F, abs(env_ch0),'LineWidth', 2) 
plot(F, abs(env_ch1),'LineWidth', 2) 
plot(F, abs(env_ch2),'LineWidth', 2) 
hold off
xlim([0 10000])
ylim([0 1])
legend('raw env', 'raw ch1', 'raw ch2', 'env ch0 ', 'env ch1 ', 'envch2 ')
box on
grid on


%%% FIGURE 3 %%%
[F, Psi_1_t] = onesideft(real(psi_1_t),f_s,2);
[F, Psi_2_t] = onesideft(real(psi_2_t),f_s,2);
figure(3)
hold on
plot(F, abs(Psi_1_t),'LineWidth', 3, 'color', [0, 0.4470, 0.7410]) 
plot(F, abs(Psi_2_t),'LineWidth', 3, 'color', [0.6350, 0.0780, 0.1840]) 
hold off
xlim([0 10000])
%xlim([-1.2*omega_1_q/(2*pi) 1.2*omega_1_q/(2*pi)]) %onesided
ylim([0 1])
%ch0
xline(omega_0/(2*pi),'--','LineWidth', 2,'Label','\langlet|0\rangle','Color',	[0.5, 0.7235, 0.8705])
xline(omega_1/(2*pi),'--','LineWidth', 2,'Label','\langlet|1\rangle','Color',	[0.8175, 0.5390, 0.5920])

%ch1 %%% CHANGE THESE COLORS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
xline(Omega_0/(2*pi),'--','LineWidth', 2,'Label','QEC_1', 'Color', [0.65875, 0.63125, 0.73125])
xline(Omega_0/(2*pi)+omega_0/(2*pi),'--','LineWidth', 2,'Color',	[0.5, 0.7235, 0.8705])
xline(Omega_0/(2*pi)-omega_0/(2*pi),'--','LineWidth', 2,'Color',	[0.5, 0.7235, 0.8705])
xline(Omega_0/(2*pi)+omega_1/(2*pi),'--','LineWidth', 2,'Color',	[0.8175, 0.5390, 0.5920])
xline(Omega_0/(2*pi)-omega_1/(2*pi),'--','LineWidth', 2,'Color',	[0.8175, 0.5390, 0.5920])

%ch2
xline(Omega_1/(2*pi),'--','LineWidth', 2,'Label','QEC_2', 'Color', [0.65875, 0.63125, 0.73125])
xline(Omega_1/(2*pi)+omega_0/(2*pi),'--','LineWidth', 2,'Color',	[0.5, 0.7235, 0.8705])
xline(Omega_1/(2*pi)-omega_0/(2*pi),'--','LineWidth', 2,'Color',	[0.5, 0.7235, 0.8705])
xline(Omega_1/(2*pi)+omega_1/(2*pi),'--','LineWidth', 2,'Color',	[0.8175, 0.5390, 0.5920])
xline(Omega_1/(2*pi)-omega_1/(2*pi),'--','LineWidth', 2,'Color',	[0.8175, 0.5390, 0.5920])

legend('\psi_1', '\psi_2')
box on
xlabel('Frequency (Hz)');
ylabel('Amplitude (a.u.)');
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');

%{
figure(2)
hold on
plot(t,  0.5*abs(a_1_t_est)) %mean(abs(a_2_t_est).^2)/2 %mean(abs(a_2_est).^2)/2
plot(t,  0.5*abs(b_2_t_est))
plot(t,  0.5*abs(a_2_t_est))% cte
plot(t,  0.5*abs(b_2_t_est))% cte
hold off

figure(3)
hold on
plot(t,  imag(a_1_t_est.*a_2_t_est))
plot(t,  imag(a_1_t_est.*b_2_t_est))
plot(t,  imag(b_1_t_est.*a_2_t_est))% cte
plot(t,  imag(b_1_t_est.*b_2_t_est))% cte
hold off
%}

