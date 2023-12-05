%%% SPATIO-TEMPORAL AND DISPERSION PLOTS %%%%%%%%%%%%%%%%%%
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
addpath('./__data/')
load 'C:/Speedgoat/temp/signal_control_raw_a_b.mat' signal_control_raw ;
%load './__data/signal_control_raw_a_638Hz_notopo.mat' signal_control_raw ;
sys_param = param_struct();
sys_param.N_cell = 8;

%%% SAVE DATA FOR PLOTS
%sim_name = "L_ref";

p_out = signal_control_raw.Variables;
p_out = p_out(:,1:16); %8 cells %p_out(:,1:8); %only first 4 cells
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
plot(t_out,real(p_out(:,1)),'-')
plot(t_out,real(p_out(:,2)),'-')
plot(t_out,real(p_out(:,3)),'-.')
plot(t_out,real(p_out(:,4)),'-.')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t (s)');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')
%ylim([-1,1])
%}

%%% TIME DOMAIN p(t,N) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% OMIT FIRST DATA POINTS
t_cut_idx = t_out>=0*50e-3; %cf 20231025 with fix at 20231128
t_out = t_out(t_cut_idx);
t_out = t_out-t_out(1); %reset t_o = 0;
p_out = p_out(t_cut_idx,:);

%surface plot
[X,Y] = meshgrid(1:2*sys_param.N_cell,t_out*1000);
Z = abs(p_out); 
Z = smoothdata(Z,"movmean");%%%% SMOOTHING DATA! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig2 = figure(2); % \Delta t simulation time step
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
ylim([t_out(1),300])
%zlim([0, 1.5])
xlabel('site n')
ylabel('t (ms)')
zlabel("|p_n| (Pa)")
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';
%clim([0, 1.5]);
view(135,60)
view(180,0)


%% FRENQUENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% OMIT FIRST DATA POINTS
t_vec = t_out; %already omited
p_vec = p_out;

Y = fft2(p_vec,2^(nextpow2(size(p_vec,1))),size(p_vec,2))/length(p_vec);% size(p_vec,2) = number of sites %0 padding up to next power normalized to get amplitude in (Pa) 
%Y = fft2(p_vec,2^12,size(p_vec,2))/length(p_vec);% TRUNCATED SIGNAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Y = fftshift(Y); %filters out DC component

NFFT_f = length(t_vec); % signal length
omega = 2*pi*sys_param.fs_log*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1))'; %

NFFT_qa = length(p_vec); % signal length
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1))'+ 0.25 ; %%% WHY THIS 0.5???'

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
%yline([422.380/1000 sys_param.c0/sys_param.a/2/1000],'r--',{'Local','Bragg'},'LineWidth',2);
yline([444/1000 638/1000],'w-',{'Local','Bragg'},'LineWidth',2,'alpha',0.3,'LabelHorizontalAlignment', 'center');
%yline([444/1000 595/1000],'w-',{'Local','Bragg'},'LineWidth',2,'alpha',0.3,'LabelHorizontalAlignment', 'center');
hold off
%colormap('hot');
colormap(magma);
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';
%clim([0, 2]);
xlabel("qa/\pi")% full unitcell
ylabel("f (kHz)")
xlim([-1,1])
ylim([-2*sys_param.c0/sys_param.a*0 sys_param.c0/sys_param.a]/1000)

%title("Transmission peak as a function of local disorder")
box on

hold off

%% NONLINEARITY TEST 

L = length(t_vec);  % Length of signal
t = t_vec;        % Time vector

FFT = fft(real(p_vec(:,:)));
P2 = abs(FFT/L);
P1 = P2(1:L/2+1,:)';
P1(2:end-1) = 2*P1(2:end-1);
f = (0:(L/2))./(sys_param.ts_log*L);

fig5 = figure(5);
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
cmp = flip(copper(sys_param.N_cell*2));
colororder(cmp);
hold on
plot(f,P1(1:1:16,:),"LineWidth",2) 
hold off
box on
grid on
%xlim([sys_param.freq_ini ,sys_param.freq_fin])
xlim([0 ,sys_param.freq_fin])
legend(string("P_{" + [1:1:sys_param.N_cell*2]+"}"), 'Location', 'NorthEast', 'NumColumns', 2)
%title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

autoArrangeFigures
toc