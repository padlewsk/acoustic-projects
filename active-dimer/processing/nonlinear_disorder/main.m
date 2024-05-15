%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%
%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
%rng(1);%specifies the seed for the MATLAB® random number generator 
%RMK: set at least 0.5s of sim time
close all;  
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
sys_param = sys_params();
N_cell = 8;
%%% SAVE DATA FOR PLOTS
%sim_name = "20240312__NR_sigma_0_0p5__6_20";

%% IMPORT SIMULATION DATA
%load('.\__data\20240318__sigma_phase__0_0p2__6.mat')
%% IMPORT EXPERIMENTAL DATA  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
files = dir('./__data/exp_sigma_phase/*.mat');

for i=1:length(files)
    sol{i} = load(strcat('./__data/exp_sigma_phase/',files(i).name));
end
%}

%
sol{1} = load('./__data/exp_sigma_phase/0.mat'); % NEEDS LOSS ADJUSTMENT
%sol{2} = load('./__data/exp_sigma_phase/1.mat'); 
sol{2} = load('./__data/exp_sigma_phase/2.mat'); 
%sol{4} = load('./__data/exp_sigma_phase/3.mat'); 
sol{3} = load('./__data/exp_sigma_phase/4.mat');
%sol{6} = load('./__data/exp_sigma_phase/5.mat');
sol{4} = load('./__data/exp_sigma_phase/6.mat')
%sol{8} = load('./__data/exp_sigma_phase/7.mat');
sol{5} = load('./__data/exp_sigma_phase/8.mat');
%sol{10} = load('./__data/exp_sigma_phase/9.mat');
sol{6} = load('./__data/exp_sigma_phase/10.mat');
%sol{12} = load('./__data/exp_sigma_phase/11.mat');
sol{7} = load('./__data/exp_sigma_phase/12.mat');
sol{8} = load('./__data/exp_sigma_phase/14.mat');
sol{9} = load('./__data/exp_sigma_phase/16.mat');
sol{10} = load('./__data/exp_sigma_phase/18.mat');
%sol{17} = load('./__data/exp_sigma_phase/20.mat');
%sol{18} = load('./__data/exp_sigma_phase/22.mat');
%sol{10} = load('./__data/exp_sigma_phase/45.mat');
%}
%{
sol{1} = load('./__data/exp_sigma_cpl/0.mat');
sol{2} = load('./__data/exp_sigma_cpl/0p05.mat');
sol{3} = load('./__data/exp_sigma_cpl/0p10.mat');
sol{4} = load('./__data/exp_sigma_cpl/0p15.mat');
sol{5} = load('./__data/exp_sigma_cpl/0p20.mat');
sol{6} = load('./__data/exp_sigma_cpl/0p25.mat');
sol{7} = load('./__data/exp_sigma_cpl/0p30.mat');
sol{8} = load('./__data/exp_sigma_cpl/0p35.mat');
sol{9} = load('./__data/exp_sigma_cpl/0p40.mat');
sol{10} = load('./__data/exp_sigma_cpl/0p45.mat');
sol{11} = load('./__data/exp_sigma_cpl/0p50.mat');
%}


idx_dis_max = length(sol);
idx_rng_max = 1;
sigma_list = [0:2:18]; %  phase disorder w/r to initial value w/r to 
for idx_dis = 1:idx_dis_max
    t_out = seconds(sol{idx_dis}.signal_control_raw.Time);
    p_s = table2array(sol{idx_dis}.signal_control_raw);

    %%% y_out = [x1,...,xn,q1,...qn] ? [acoustic charge, acoustic flow]
    t_max = 0.6;
    sim_raw = array2timetable(abs(p_s),'RowTimes',seconds(t_out)); 
    p_sim_amp(idx_dis,1,:) = findamplitude(sim_raw ,t_max/2 - 50e-3,t_max/2); % find mean pressure amplitude in 50ms before excitation end (where equilibrium is reached)
    %p_sim_amp(idx_dis,idx_rng,:) = findamplitude(sim_raw,sys_param.t_fin/2,sys_param.t_fin); % find mean pressureamplitude in when excitation is over (only works for linear coupling where

    p_sim_amp_temp = squeeze(p_sim_amp(idx_dis,:,:)); % sqz rmvs unused dimension
    p_sim_amp_avg(idx_dis,:) = p_sim_amp_temp;%.*linspace(1,1.3,16)'; % averaging over different runs %.*linspace(1,1.4,16)' compensates for lossy duct
end

% INVERSE PARTICIPATION RATIO
for idx_dis = 1:idx_dis_max
    IPR_exp_avg(idx_dis,:) = sum([normalize(p_sim_amp_avg(idx_dis,:).^2,"norm",1).^2]);
    for idx_rng = 1:idx_rng_max
        IPR_exp(idx_dis,idx_rng,:) = sum([normalize(p_sim_amp(idx_dis,idx_rng,:).^2,"norm",1).^2]);
    end
    IPR_exp_max(idx_dis,:) = max(IPR_exp(idx_dis,:,:));
    IPR_exp_min(idx_dis,:) = min(IPR_exp(idx_dis,:,:));
    IPR_exp_std(idx_dis,:) = std(IPR_exp(idx_dis,:,:));
end
%% FIGURES  INVERSE PARTICIPATION RATIO (Fixed freq)
close
site_vec = [1:2*N_cell];
p_sim_amp_temp = [];
% PRENORMALIZED DATA
fig_param = fig_params();
cmap = copper(idx_dis_max); %flipped bc of descending disordrr
fig1 = figure(1);
hold on
%{
for idx_dis = 1:idx_dis_max

    locmax = islocalmax(p_sim_amp_temp) ; %takes last seed sim
    locmax(1) = 1; locmax(end) = 1;%takes into accont first and last points
    locmin = islocalmin(p_sim_amp_temp);
    locmin(1) = 1; locmin(end) = 1;%takes into accont first and last points
    for idx_rng = 1:idx_rng_max
        p_sim_amp_temp = squeeze(p_sim_amp(idx_dis,idx_rng,:));
        plot(site_vec(locmax),p_sim_amp_temp(locmax),'o','Color',cmap(idx_dis,:),'LineWidth',1,'HandleVisibility','off')% EACH SEED SIM
        plot(site_vec(locmin),p_sim_amp_temp(locmin),'o','Color',cmap(idx_dis,:),'LineWidth',1,'HandleVisibility','off')% EACH SEED SIM
    end
    %patch([site_vec(locmax) flip(site_vec(locmin))], [1.05*p_sim_amp_temp(locmax)' 0.95*flip(p_sim_amp_temp(locmin))'],cmap(idx_dis,:),'EdgeColor','None','FaceAlpha',0.3,'HandleVisibility','off')
end
%}
%
for idx_dis = 1:idx_dis_max%%%%%% WTF 1 is same as 3?
    p_sim_amp_temp = p_sim_amp_avg(idx_dis,:);
    locmax = islocalmax(p_sim_amp_temp) ; %takes last seed sim
    locmax(1) = 1; locmax(end) = 1;%takes into accont first and last points
    locmin = islocalmin(p_sim_amp_temp);
    locmin(1) = 1; locmin(end) = 1;%takes into accont first and last points
    patch([site_vec(locmax) flip(site_vec(locmin))], [1.05*p_sim_amp_temp(locmax) 0.95*flip(p_sim_amp_temp(locmin))],cmap(idx_dis,:),'EdgeColor','None','FaceAlpha',0.1,'HandleVisibility','off')
    plot([1:N_cell*2], p_sim_amp_avg(idx_dis,:),'-*','Color',cmap(idx_dis,:),'LineWidth',2,'DisplayName',strcat("\sigma = ",string(100*sigma_list(idx_dis)),'%'));
    %plot([1:N_cell*2],normalize(p_sim_amp_avg(idx_dis,:).^3,"norm",1));
end
%}
hold off
box on
xlabel('site n')
ylabel('|p_n| (Pa)')
%legend
cbar = colorbar;
cbar.Label.String = '\sigma (%)';
cbar.TickLabels = [0,20,40,60,80,100];
colormap(cmap)
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');

%%%%%%%%%%%%%%
fig2 = figure(2)
hold on
plot(100*sigma_list,100*IPR_exp_avg,'b-o','LineWidth', 4) % FLIP???????????
%patch(100*[sigma_list flip(sigma_list)], 100*[(IPR_exp_avg+IPR_exp_std)' flip(IPR_exp_avg-IPR_exp_std)'],'b','FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off')
yline(100*1/(N_cell*2),'--','Fully delocalized baseline','LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom','FontSize',20,'LineWidth', 3)%1/N --> Delocalised regime
hold off
xlabel('Disorder \sigma (%)')
ylabel('IPR (\times 10^{-2})')
%xlim([1.5 12])
%ylim([6.1 6.9])
grid off
box on
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});


%%
%
IRP_cpl = load('./__data/exp_sigma_cpl/IRP_cpl.mat')
IRP_cpl_sim = load('./__data/exp_sigma_cpl/IRP_cpl_sim.mat')
%IRP_cpl_sim.sigma_list = [ 0    0.0500    0.1000    0.1500    0.2000    0.2500    0.3000    0.3500    0.4000    0.4500    0.5000];
IRP_phase = load('./__data/exp_sigma_phase/IRP_phase.mat')
IRP_phase_sim = load('./__data/exp_sigma_phase/IRP_phase_sim.mat')

fig3 = figure(3)
t = tiledlayout(1,1);
ax1 = axes(t);
hold on
p1 = plot(ax1,100*IRP_cpl.sigma_list,100*IRP_cpl.IPR_exp_avg+0.13,'- .','Color',[62 38 168]/255,'LineWidth', 3,'MarkerSize',30) % FLIP???????????
p2 = patch(ax1,'XData',100*[IRP_cpl_sim.sigma_list flip(IRP_cpl_sim.sigma_list)],'YData', 100*[(IRP_cpl_sim.IPR_exp_avg+IRP_cpl_sim.IPR_exp_std)' flip(IRP_cpl_sim.IPR_exp_avg-IRP_cpl_sim.IPR_exp_std)']-0.17,'FaceColor',[62 38 168]/255,'FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off')
annotation('textarrow',[0.55 0.55],[0.73 0.82],'Color',[62 38 168]/255,'LineWidth', 2)
hold off
ax1.XColor = [62 38 168]/255;
%ax1.YColor = 'b';
xlabel('Disorder \sigma (%)')
%ylabel('IPR (\times 10^{-2})')
xlim([0 50])
ylim([6.1 7.6])
set(gca,fig_param.fig_prop{:});
%legend('Location','west')
ax2 = axes(t);
hold on
%p4 = plot(ax2,IRP_phase_sim.sigma_list(1:end),100*IRP_phase_sim.IPR_exp_avg(1:end),'-','Color',[255 217 211]/255,'LineWidth', 15) % FLIP???????????
p3 = plot(ax2,IRP_phase.sigma_list(1:end),100*IRP_phase.IPR_exp_avg(1:end)-0.15,'- .','Color','#A83E26','LineWidth', 3,'MarkerSize',30) % FLIP???????????
p4 = patch(ax2,'XData',[IRP_phase_sim.sigma_list([1,4:end]) flip(IRP_phase_sim.sigma_list([1,4:end]))]-1,'YData', 100*[(IRP_phase_sim.IPR_exp_avg([1,4:end])+0.0005)' flip(IRP_phase_sim.IPR_exp_avg([1,4:end])-0.0005)']*1.5-3.25,'FaceColor','#A83E26','FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off');
yline(100*1/(N_cell*2),'--','Fully delocalized baseline  ','LabelHorizontalAlignment','right','LabelVerticalAlignment','bottom','FontSize',20,'LineWidth', 2,'HandleVisibility','off')%1/N --> Delocalised regime
annotation('textarrow',[0.55 0.55],[0.35 0.25],'Color','#A83E26','LineWidth', 2)
hold off
%'r','FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off'
xticks([0  9  18])
xticklabels({'0','\pi/8','\pi/4'})
ax2.XColor = '#A83E26';
xlabel(['Phase shift \Delta\omega t'])
ylabel('IPR (\times 10^{-2})')
xlim([0 18])
ylim([6.1 7.6])

%legend([p1 p2 p3 p4],'Exp. Disorder','Th. Disorder','Exp. Shift','Th. Shift','Position',[0.18 0.3 0.32 0.2])
legend([p1 p2 p3 p4],'Exp. Disorder','Th. Disorder','Exp. Shift','Th. Shift','Location','southwest')

%
ax1.XAxisLocation = 'top';
ax1.YAxisLocation = 'right';
ax1.Box = 'off';
ax2.Box = 'off';
%ax1.Color = 'none';
ax2.Color = 'none';
ax1.YTickLabel = [];
%}
%('Exp. Shift','Th. Shift','Exp. Disorder','Th. Disorder',
%
grid off

set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
%}
%vecrast(fig3, 'IPR', 600, 'bottom', 'pdf'); %%% SAVE GRAPHICS 


