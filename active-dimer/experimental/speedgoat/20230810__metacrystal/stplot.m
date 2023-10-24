%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%

%rng(1);%specifies the seed for the MATLAB® random number generator TEST
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
addpath('./__data/')
load signal_control_raw_a.mat signal_control_raw
sys_param = sys_params();
sys_param.N_cell = 4;

%%% SAVE DATA FOR PLOTS
%sim_name = "L_ref";

p_s = signal_control_raw.Variables;
p_s = p_s(:,1:8); %only first 4 cells
t_out = signal_control_raw.Time;
t_out = seconds(t_out);

%% FIGURES
%%% LOAD FIGURE PARAMETERS
fig_param = fig_params();

%%% PLOT
tic
close all
%%% Time domain plot of edge sites
fig1 = figure(1);
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
hold on
plot(t_out,real(p_s(:,1)),'-')
plot(t_out,real(p_s(:,2)),'-')
plot(t_out,real(p_s(:,3)),'-.')
plot(t_out,real(p_s(:,4)),'-.')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t/T');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')
%ylim([-1,1])
%}


%%% TIME DOMAIN p(t,N) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%surface plot
[X,Y] = meshgrid(1:2*sys_param.N_cell,t_out*1000);
Z = abs(p_s); 
Z = smoothdata(Z,"movmean");%%%% SMOOTHING DATA!

fig2 = figure(2); % \Delta t simulation time step
%waterfall
%{
h = waterfall(X',Y',Z');
set( h, 'LineWidth', 2);
%hidden off; %removes white separator
%}
%ribonn
%
h = ribbon(Y,Z,0.5);
[h(:).EdgeColor] = deal('none');
set(h, {'CData'}, get(h,'ZData'), 'FaceColor','interp','MeshStyle','column'); % make colour indicate amplitude
%}
set(gcf,'position',fig_param.window_size);
set(gcf, 'InvertHardCopy', 'off'); % to make black figure
set(gcf,'Color',[0 0 0]);% to make black figure

set(gca,fig_param.fig_prop{:});
set(gca,'color','none','YDir','normal','XColor','w','YColor','w','ZColor','w')
%set(gca,'color','none','YDir','normal')
grid("off")
%box("on")
xlim([0.5,2*sys_param.N_cell+0.5])
%xlim([sys_param.N_cell-2.5,sys_param.N_cell+2.5]) % zoom on topological interface
%ylim([t_out(1),300])
%ylim([t_out(1),t_out(end)/5]*1000)
%zlim([0,sys_param.A_src*1.5])
xlabel('site n')
ylabel('t (ms)')
zlabel("|p_n| (Pa)")
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';
%clim([0, sys_param.A_src*1.5]);
view(135,60)


%%% FRENQUENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_vec =  0:sys_param.t_samp:sys_param.t_fin; 

%%% ZERO PADDING
%t_vec = linspace(0,sys_param.t_fin,2^(nextpow2(numel(t_out))+4));%This time vector used to interpolate before performing the FFT. 
p_seg = interp1(t_out,p_s,t_vec); % Interpolate data 

t0 = 3/(sys_param.f_src); %3/(2*pi*param.c0/param.a/2);% pulse delay

t_seg = t_vec(t_vec>2*t0); %omit first data points
p_seg = p_seg(t_vec>2*t0,:); 

Y = fft2(p_seg)/length(p_seg); %2D FFT --> normalized to get amplitude in (Pa)
Y = fftshift(Y); %filters out DC component

NFFT_f = length(t_seg); % signal length
omega = 2*pi*sys_param.f_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1)); %

NFFT_qa = length(p_seg); % signal length
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1));

%%% BAND FOLDING %%% RMK: sys_param.N_cell must be EVEN
%{
Y_inner = [Y(:,sys_param.N_cell/2+1:3*sys_param.N_cell/2)];
Y_outer = flip([Y(:,3*sys_param.N_cell/2+1:2*sys_param.N_cell) Y(:,1:sys_param.N_cell/2)],2);
Y_fold = (Y_inner+Y_outer);
%}
Y_fold = Y; %Bypass

%%% CUT OFF HIGH FREQUENCIES
fig3 = figure(3);
set(gcf,'position',fig_param.window_size);
set(gcf, 'InvertHardCopy', 'off'); % to make black figure
set(gcf,'Color',[0 0 0]);% to make black figure
set(gca,fig_param.fig_prop{:},'XColor','w','YColor','w');
%set(gca,'FontSize',20)
%set(gcf,'position',[50, 50, 800, 1000]);
hold on
%imagesc(qa/pi,omega/(2*pi),abs(Y)); 
%imagesc(abs(Y_fold));
imagesc(qa/(pi),omega/(2*pi)/1000,abs(Y_fold));
%yline([422.380/1000 param.c0/param.a/2/1000],'r--',{'Local','Bragg'},'LineWidth',2);
%yline([415/1000 644.5/1000],'r--',{'Local','Bragg'},'LineWidth',2);
hold off
%colormap('hot');
colormap(magma);
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';
%clim([0, sys_param.A_src*0.5]);
%clim([0, 1.5]);
xlabel("qa/\pi")% full unitcell
%ylabel("$(\omega-\omega_0)/(2\pi)$",'Interpreter','latex')
%xlabel("$qa/(2\pi)$",'Interpreter','latex')% halved unitcell
%ylabel("$\omega/(2\pi)$",'Interpreter','latex')
ylabel("f (kHz)")
xlim([-1,1])
ylim([-2*sys_param.c0/sys_param.a*0 sys_param.c0/sys_param.a]/1000)

%title("Transmission peak as a function of local disorder")

box on

hold off


autoArrangeFigures
toc