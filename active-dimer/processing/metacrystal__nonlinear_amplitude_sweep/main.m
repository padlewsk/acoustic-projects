%%% SPATIO-TEMPORAL AND DISPERSION PLOTS %%%%%%%%%%%%%%%%%%
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));
addpath('./__fun/')
%%% LOAD FIGURE PARAMETERS
fig_param = fig_params(); % must be done to utilize the structure
%% LOAD DATA
addpath('./__data/')

% EXPERIMENTAL % REVERSED??
load('./__data/exp_A1.mat', 'signal_control_raw') ; exp_A{1} = signal_control_raw;% LARGEST AMPLITUDE!??
load('./__data/exp_A2.mat', 'signal_control_raw') ; exp_A{2} = signal_control_raw;
load('./__data/exp_A3.mat', 'signal_control_raw') ; exp_A{3} = signal_control_raw;
load('./__data/exp_A4.mat', 'signal_control_raw') ; exp_A{4} = signal_control_raw;
load('./__data/exp_A5.mat', 'signal_control_raw') ; exp_A{5} = signal_control_raw; % SMALLEST AMPLITUDE

% SIMULATION OF MODEL
load('./__data/sim_A9.mat', 'sim_raw') ; sim_A{1} = sim_raw;
load('./__data/sim_A8.mat', 'sim_raw') ; sim_A{2} = sim_raw;
load('./__data/sim_A6p4.mat', 'sim_raw') ; sim_A{3} = sim_raw;
load('./__data/sim_A4p5.mat', 'sim_raw') ; sim_A{4} = sim_raw;
load('./__data/sim_A2p5.mat', 'sim_raw') ; sim_A{5} = sim_raw;

% SIMULATION OF 64 CELL
%{
load('./__data/sim_A9_64cells.mat', 'sim_raw') ; sim_A_64{1} = sim_raw;
p_sim_max_64{1} = findpmax(sim_A_64{1});
IPR_exp_64 = sum([normalize(p_sim_max_64{1}([32:end-32]).^2,"norm",1).^2])% cropping on to state
figure
hold on
plot(32:96,normalize(p_sim_max_64{1}([32:end-32]).^2,"norm",1))
yline(1/65,'--','LineWidth', 3) %baseline 1/N

hold off

%}
%%
%{
p_A1= exp__A3.Variables;
p_A1= p_A1(:,1:16); 
t_A1= exp__A1.Time;
t_A1= seconds(t_A1);
t_cut_idx = logical((t_A1<800e-3).*(t_A1>=700e-3)); %cf 20231025 with fix at 20231128
t_A1 = t_A1(t_cut_idx);
t_A1 = t_A1-t_A1(1); %reset t_o = 0;
p_A1 = p_A1(t_cut_idx,:);

TF = islocalmax(p_A1);

p_A1 = islocalmax(p_A1).*p_A1
p_A1(p_A1==0) = NaN;
p_A1_max = mean(islocalmax(p_A1).*p_A1,"omitnan");
%}

%
for ii = 1:size(exp_A,2)
    [p_exp_amp{ii},p_exp{ii},t_exp{ii}] = findamplitude(exp_A{ii},150e-3,250e-3); %%% FINDS AMPLITUDE
    % 14 mic correction !!!!
    p_exp_amp{ii}(14) = 1.15*p_exp_amp{ii}(14);
end
%}
for ii = 1:size(sim_A,2)
    [p_sim_amp{ii},p_sim{ii},t_sim{ii}] = findamplitude(sim_A{ii},150e-3,250e-3);
end

%}

%{
site = 8;
fig1 = figure(1);
plot(t_A1, p_A1(:,site))
hold on
%plot(t_A1(TF(:,site)),p_A1(TF(:,site),site),'*')
hold off
%}


%SPACE INTERPOLATION
x = linspace(1, 16, 500);
for ii = 1:size(exp_A,2)
    p_exp_amp_interp{ii} = interp1([1:16],p_exp_amp{ii},x,'spline');%,'spline'
end

for ii = 1:size(sim_A,2)
    p_sim_amp_interp{ii} = interp1([1:16],p_sim_amp{ii},x,'spline');
end

%% FIGURES

fig1 = figure(1);
% Define the colormap
cmap = magma(256);
p_cmax = max(p_exp_amp_interp{5})+1;
p_cmin = min(p_exp_amp_interp{1})-1;
% Calculate the color index based on the amplitude
for ii = 1:size(exp_A,2)
    c_exp{ii} = round((p_exp_amp_interp{ii} - p_cmin*ones(1,500)) / (p_cmax - p_cmin) * 255) + 1;
end
for ii = 1:size(sim_A,2)
    c_sim{ii} = round((p_sim_amp_interp{ii} - p_cmin*ones(1,500)) / (p_cmax - p_cmin) * 255) + 1;
end
% Plot each segment with its color
hold on
for jj = 1:length(x)-1
    for ii =1:size(exp_A,2)
        plot_exp = plot(x(jj:jj+1), p_exp_amp_interp{ii}(jj:jj+1), 'Color', cmap(c_exp{ii}(jj),:), 'LineWidth', 6);
    end
    %for ii =1:size(sim_A,2)
    %    plot(x(jj:jj+1), p_sim_amp_interp{ii}(jj:jj+1), 'Color', cmap(c_sim{ii}(jj),:), 'LineWidth', 5);
    %end
end
for ii =1:size(sim_A,2)
   plot_sim = plot(x, p_sim_amp_interp{ii},'--','Color', 'r', 'LineWidth', 2);
end

legend([plot_exp(1),plot_sim(1)],'Exp.','Th.')  
hold off

%{
plot(x,p_A5_max,'-','LineWidth',fig_param.line_width+2,'Color',cmap(5,:))
hold on
plot(x,p_A4_max,'-','LineWidth',fig_param.line_width+2,'Color',cmap(4,:))
plot(x,p_A3_max,'-','LineWidth',fig_param.line_width+2,'Color',cmap(3,:))
plot(x,p_A2_max,'-','LineWidth',fig_param.line_width+2,'Color',cmap(2,:))
plot(x,p_A1_max,'-','LineWidth',fig_param.line_width+2,'Color',cmap(1,:))
hold off
%}

box on
grid on
xlabel('site n');
ylabel('|p_n| (Pa)');
%xtickangle(45)
xticks([1:16])
%xticklabels({'','2','','4','','6','','8','','10','','12','','14','','16'})
xticklabels({'1','','3','','5','','7','','9','','11','','13','','15',''})
xlim([0, 17])
ylim([0, 14])
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');

%vecrast(fig1, ['MDL_VS_EXP_magma'], 600, 'bottom', 'pdf'); %%% SAVE GRAPHICS 

%% INVERSE PARTICIPATION RATIO ON TOPO MODE 
for ii = 1:size(exp_A,2)
    IPR_exp{ii} = sum([normalize(p_sim_amp{ii}([1:1:16]).^2,"norm",1).^2]);
end

figure(2)
hold on
for ii = 1:5
    plot([1:1:16], normalize(p_sim_amp{ii}([1:1:16]).^2,"norm",1),'-o','LineWidth', 3)
end
yline(1/16,'--','LineWidth', 3) %baseline 1/N
hold off
xlabel('site n')
ylabel('|p_{n,norm}|')
box on
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});

fig3 = figure(3)
hold on
plot([2.5 4.5 6 8 9],100*flip(cell2mat(IPR_exp)),'-*','LineWidth', 4)%% TEMP FIX SEE UP
plot([9 11],[100*flip(cell2mat(IPR_exp(1))) 8],'--','LineWidth', 4)%% TEMP FIX SEE UP
yline(100*1/16,'--','LineWidth', 3)%1/N --> Delocalised regime
hold off
xlabel('A_{src}')
ylabel('IPR(\times10^{-2}) ')
xlim([1.5 12])
ylim(100*[0.06 0.08])
grid off
box on
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});

%vecrast(fig3, 'IPR_FOR_SHOWCASE_FIG', 600, 'bottom', 'pdf'); %%% SAVE GRAPHICS 


%%%%%%%%%%% 
%{
fig5 = figure(5);
% Define the colormap
cmap = magma(256);
p_cmax = max(p_exp_amp_interp{5})+1;
p_cmin = min(p_exp_amp_interp{5})-1;
%p_cmin = min(p_exp_amp_interp{1})-1;
% Calculate the color index based on the amplitude
for ii = 1:size(exp_A,2)
    c_exp{5} = round((p_exp_amp_interp{5} - p_cmin*ones(1,500)) / (p_cmax - p_cmin) * 255) + 1;
end

% Plot each segment with its color
hold on
for jj = 1:length(x)-1
    for ii =5 %1:size(exp_A,2)
        plot_exp = plot(x(jj:jj+1), p_exp_amp_interp{ii}(jj:jj+1), 'Color', cmap(c_exp{ii}(jj),:), 'LineWidth', 6);
    end
    %for ii =1:size(sim_A,2)
    %    plot(x(jj:jj+1), p_sim_amp_interp{ii}(jj:jj+1), 'Color', cmap(c_sim{ii}(jj),:), 'LineWidth', 5);
    %end
end
%{
for ii =1:size(sim_A,2)
   plot_sim = plot(x, p_sim_amp_interp{ii},'--','Color', 'r', 'LineWidth', 2);
end
%}
legend([plot_exp(1),plot_sim(1)],'Exp.','Mdl.')  
hold off
%vecrast(fig5, 'PLOT_FOR_SHOWCASE_FIG', 600, 'bottom', 'pdf'); %%% SAVE GRAPHICS 

%autoArrangeFigures
%}

