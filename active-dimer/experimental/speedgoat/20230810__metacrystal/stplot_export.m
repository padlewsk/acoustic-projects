%%% SPATIO-TEMPORAL AND DISPERSION PLOTS %%%%%%%%%%%%%%%%%%
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));
%addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
addpath('./__data/')

load('./__data/signal_control_raw_a.mat', 'signal_control_raw') ; %Manual Load 

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
fig_param = fig_params(); % must be done to utilize the structure

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
t_cut_idx = t_out>=1; %cf 20231025 with fix at 20231128
%t_cut_idx = t_out<8000e-3; 
t_out = t_out(t_cut_idx);
t_out = t_out-t_out(1); %reset t_o = 0;

p_out = p_out(t_cut_idx,:);
%p_out = p_out(t_cut_idx,:)*0.8;

%surface plot
[X,Y] = meshgrid(1:2*sys_param.N_cell,t_out*1000);
Z = abs(p_out); 
Z = smoothdata(Z,"movmean")*0.8;%%%% SMOOTHING DATA! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig2 = figure(2); % \Delta t simulation time step
colormap('magma');
h = ribbon(Y,Z,0.5);
[h(:).EdgeColor] = deal('none');
set(h, {'CData'}, get(h,'ZData'), 'FaceColor','interp','MeshStyle','column'); % make colour indicate amplitude
%{
set(gcf,'position',fig_param.window_size);
set(gcf, 'InvertHardCopy', 'off'); % to make black figure
set(gcf,'Color',[0 0 0]);% to make black figure
set(gca,'XColor','w','YColor','w','ZColor','w') %dark mode
%}

%add interface position
pos_interface = 9;

p1 = [pos_interface 0 0];
p2 = [pos_interface t_out(end)*1000 0];
p3 = [sys_param.N_cell t_out(end)*1000 max(Z(:))/2];
p4 = [sys_param.N_cell 0 max(Z(:))/2];  
%p3 = [pos_interface t_out(end)*1000 0.5];
%p4 = [pos_interface 0 0.5];
xx = [p1(1) p2(1) p3(1) p4(1)];
yy = [p1(2) p2(2) p3(2) p4(2)];
zz = [p1(3) p2(3) p3(3) p4(3)];
hold on;
fill3(xx, yy, zz,'k', 'EdgeColor', 'none', 'FaceAlpha',0.5);
hold off
%%% figure style

set(gca,fig_param.fig_prop{:});
set(gca,'color','none','YDir','normal')

grid("off") 
xlim([0.5,2*sys_param.N_cell+0.5])
%ylim([t_out(1),t_out(1)+20])
ylim([t_out(1),sys_param.tmax*0.5]*1000)
%zlim([0, 2])
zlim([4, 12])
xlabel('site n')
ylabel('t (ms)')
zlabel("|p_n| (Pa)")
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
%c.Color = 'w';%dark mode
%clim([0, 2]);
clim([4, 12]);
view(135,60)% 50
%view(45,45)
%exportgraphics(gcf,"myplot.png",'BackgroundColor','none')





%% FRENQUENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% OMIT FIRST DATA POINTS
t_vec = t_out; 
p_vec = p_out;

%%% SPLIT SIGNAL INTO PARTS FOR SPECTRAL AVERAGING
% sys_param.freq_res
parts = 100*sys_param.avg_num_wind; % number of parts to split the time domain signal (reduces frequency resolution)
part_size = floor(size(p_vec,1)/parts)*ones(1, parts); % Determine the size of each part
part_size(end) = size(p_vec,1) - sum(part_size(1:end-1)); % removes last bit to have equal-sized matrices
p_vec_split = mat2cell(p_vec, part_size, size(p_vec,2)); % Split the matrix into sys_param.avg_num_wind parts
Y_split = {}; %
for nn = 1:parts-1 %%% -1 bc last cell is not always the right size...
    Y_split{nn} = fft2(p_vec,2^(nextpow2(size(p_vec_split{nn},1))),size(p_vec_split{nn},2))/length(p_vec_split{nn});
end
Y = cat(3, Y_split{:}); % Concatenate the cell array of numeric arrays into a 3D numeric array
Y = mean(Y, 3); % Take the average along the third dimension --> in Fourier space
%
%Y = fft2(p_vec,2^(nextpow2(size(p_vec,1))),size(p_vec,2))/length(p_vec);% size(p_vec,2) = number of sites %0 padding up to next power normalized to get amplitude in (Pa) 

Y = fftshift(Y); %filters out DC component

NFFT_f = length(t_vec); % signal length
omega = 2*pi*sys_param.fs_log*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1))'; %

NFFT_qa = length(p_vec); % signal length
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1))'+ 0.25 ; %%% WHY THIS 0.5???'

%%% BAND FOLDING %%% RMK: sys_param.N_cell must be EVEN
Y_fold = Y;%Bypass folding
%{
Y_inner = [Y(:,sys_param.N_cell/2+1:3*sys_param.N_cell/2)];
Y_outer = flip([Y(:,3*sys_param.N_cell/2+1:2*sys_param.N_cell) Y(:,1:sys_param.N_cell/2)],2);
Y_fold = (Y_inner+Y_outer);
%}

%%% CUT OFF HIGH FREQUENCIES
fig3 = figure(3);
%
set(gcf,'position',fig_param.window_size);
%{
set(gcf, 'InvertHardCopy', 'off'); % to make black figure
set(gcf,'Color',[0 0 0]);% to make black figure
set(gca,'XColor','w','YColor','w');% to make black figure
%}
set(gca,fig_param.fig_prop{:});
%set(gca,'FontSize',20)
%set(gcf,'position',[50, 50, 800, 1000]);
hold on
%
imagesc(qa/(pi),omega/(2*pi)/1000,abs(Y_fold));
yline([440/1000 645/1000],'w--',{'Local','Bragg'},'LineWidth',1,'alpha',0.2,'LabelHorizontalAlignment', 'center');
hold off

%colormap('hot');
colormap('magma');
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
%c.Color = 'w'; % to make black figure
%clim([0, 3]);
xlabel("qa/\pi")% full unitcell
ylabel("f (kHz)")
xlim([-1,1])
ylim([-2*sys_param.c0/sys_param.a*0 sys_param.c0/sys_param.a]/1000)
%title("Transmission peak as a function of local disorder")
box on
hold off

%saveas(fig3,'test','epsc')

%}
%%% 3D
%{
c = colorbar;
NFFT_f = size(Y_fold,1);
[X,Y] = meshgrid(flip(-7.5:7.5)/7.5,((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1))');
Y = Y*sys_param.fs_log/1000;
Z = abs(Y_fold); 
surf(X,Y,Z,'EdgeColor','none','FaceAlpha',1)
yline([440/1000 635/1000],'w--',{'Local','Bragg'},'LineWidth',1,'alpha',0.2,'LabelHorizontalAlignment', 'center');
%hold on
%image(qa/(pi),omega/(2*pi)/1000,abs(Y_fold),'CDataMapping','scaled')
c = colorbar;
colormap(magma);
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';
%clim([0, 3]);
xlabel("qa/\pi")% full unitcell
ylabel("f (kHz)")
xlim([-1,1])
ylim([-2*sys_param.c0/sys_param.a*0 sys_param.c0/sys_param.a]/1000)
%title("Transmission peak as a function of local disorder")
box on
hold off
%}

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
%% SAVE FIGURES

%% SAVE FIGURES
sim_name = "20240111__src_A635__A_5__interface_2__kappaNL_1__sigmaT_5";

%
tic
if ~exist("__figures", 'dir')
   mkdir("__figures")
end
if ~isfile(string("./__figures/fig__" + sim_name + ".pdf")) || ~isfile("./" + string(sim_name)+ ".pdf")
    exportgraphics(fig1, string("./__figures/fig__" + sim_name + ".pdf"), 'ContentType', 'vector')% save the figure as a tightly cropped PDF file
    vecrast(fig2, char(sim_name), 600, 'bottom', 'pdf');
else
    fprintf("### FIGURE NOT SAVED: FILE NAME ALREADY EXISTS\n")
end
toc