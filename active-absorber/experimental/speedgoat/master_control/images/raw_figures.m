%%% RAW DATA EXTRACTED FROM SCREENSHOT OF DATA
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox');
%clear all
close all
clc

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('..\');
run('params.m');
fig_param = fig_params();
raw_alpha_data = readmatrix('.\absorbtion__muM_1__muR_1p9__muC_0p5__tau_50ms.csv');
raw_absZ_data = readmatrix('.\absZ__muM_1__muR_1p9__muC_0p5__tau_50ms.csv');
raw_angleZ_data = readmatrix('.\angleZ__muM_1__muR_1p9__muC_0p5__tau_50ms.csv');
%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = raw_alpha_data(:,1);
alpha = raw_alpha_data(:,2);

%%% alpha vs freq %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
semilogx(F,alpha,'LineWidth',3)

hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([fi ff]);
ylim([0 1.1]);

xlabel("Frequency (Hz)")
ylabel("Absorbtion coefficient")
%title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});

%
%%% Bode plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2);
tt = tiledlayout(2,1); %Create tile layout

%%% Magnetude of Specific Acoustic Impedance
F = raw_absZ_data(:,1);
absZs = raw_absZ_data(:,2);

ax1 = nexttile; 
semilogx(ax1,F,absZs/1000,'LineWidth',3)
xline(f0,'-.k');
xline(fst,'-.k');
ylabel("Magnetiude (kPa.s/m)")
ylim([0 1200/1000]);
box on
grid on
set(ax1,'xticklabel',[])
%title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});

%%% Phase
F = raw_angleZ_data(:,1);
angleZs = raw_angleZ_data(:,2);

ax2 = nexttile;
semilogx(ax2,F,angleZs,'LineWidth',3)
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});
ylabel("Phase (rad)")
%xlabel("Frequency (Hz)")
box on
grid on
ylim([-pi pi])
set(ax2,'YTick',-pi:pi/2:pi)
set(ax2,'YTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})

% Link the axes
linkaxes([ax1,ax2],'x');
xlim([fi ff]);

% Move plots closer together
xticklabels(ax1,{})
tt.TileSpacing = 'compact';
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});

%vecrast(fig3, 'passive_64_cell_freq', 600, 'bottom', 'pdf');
%autoArrangeFigures