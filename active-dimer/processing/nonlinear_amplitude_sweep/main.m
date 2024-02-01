%%% SPATIO-TEMPORAL AND DISPERSION PLOTS %%%%%%%%%%%%%%%%%%
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));
%addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));
addpath('./__fun/')


%% LOAD DATA
addpath('./__data/')

% EXPERIMENTAL
load('./__data/exp_A1.mat', 'signal_control_raw') ; exp_A{1} = signal_control_raw;
load('./__data/exp_A2.mat', 'signal_control_raw') ; exp_A{2} = signal_control_raw;
load('./__data/exp_A3.mat', 'signal_control_raw') ; exp_A{3} = signal_control_raw;
load('./__data/exp_A4.mat', 'signal_control_raw') ; exp_A{4} = signal_control_raw;
load('./__data/exp_A5.mat', 'signal_control_raw') ; exp_A{5} = signal_control_raw;

% EXPERIMENTA
load('./__data/sim_A9.mat', 'sim_raw') ; sim_A{1} = sim_raw;
load('./__data/sim_A8.mat', 'sim_raw') ; sim_A{2} = sim_raw;
load('./__data/sim_A6p4.mat', 'sim_raw') ; sim_A{3} = sim_raw;
load('./__data/sim_A4p5.mat', 'sim_raw') ; sim_A{4} = sim_raw;
load('./__data/sim_A2p5.mat', 'sim_raw') ; sim_A{5} = sim_raw;

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
    [p_exp_max{ii},p_exp{ii},t_exp{ii}] = findpmax(exp_A{ii});
    % 14 mic correction !!!!
    p_exp_max{ii}(14) = 1.15*p_exp_max{ii}(14);
end

for ii = 1:size(sim_A,2)
    [p_sim_max{ii},p_sim{ii},t_sim{ii}] = findpmax(sim_A{ii});
end

%}
%%% LOAD FIGURE PARAMETERS
fig_param = fig_params(); % must be done to utilize the structure

%%% PLOT
close all
%{
site = 8;
fig1 = figure(1);
plot(t_A1, p_A1(:,site))
hold on
%plot(t_A1(TF(:,site)),p_A1(TF(:,site),site),'*')
hold off
%}


x = linspace(1, 16, 500);
for ii = 1:size(exp_A,2)
    p_exp_max_interp{ii} = interp1([1:16],p_exp_max{ii},x,'spline');%,'spline'
end

for ii = 1:size(sim_A,2)
    p_sim_max_interp{ii} = interp1([1:16],p_sim_max{ii},x,'spline');
end

%%% Time domain plot of edge sites
fig2 = figure(2);
%{
bar(p_A5_max,'FaceColor',cmap(5,:))
hold on
bar(p_A4_max,'FaceColor',cmap(4,:))
bar(p_A3_max,'FaceColor',cmap(3,:))
bar(p_A2_max,'FaceColor',cmap(2,:))
bar(p_A1_max,'FaceColor',cmap(1,:))
hold off
%}
% Define the colormap
cmap = parula(256);
p_cmax = max(p_exp_max_interp{5})+1;
p_cmin = min(p_exp_max_interp{1})-1;
% Calculate the color index based on the amplitude
for ii = 1:size(exp_A,2)
    c_exp{ii} = round((p_exp_max_interp{ii} - p_cmin*ones(1,500)) / (p_cmax - p_cmin) * 255) + 1;
end
for ii = 1:size(sim_A,2)
    c_sim{ii} = round((p_sim_max_interp{ii} - p_cmin*ones(1,500)) / (p_cmax - p_cmin) * 255) + 1;
end
% Plot each segment with its color
hold on
for jj = 1:length(x)-1
    for ii =1:size(exp_A,2)
        plot_exp = plot(x(jj:jj+1), p_exp_max_interp{ii}(jj:jj+1), 'Color', cmap(c_exp{ii}(jj),:), 'LineWidth', 6);
    end
    %for ii =1:size(sim_A,2)
    %    plot(x(jj:jj+1), p_sim_max_interp{ii}(jj:jj+1), 'Color', cmap(c_sim{ii}(jj),:), 'LineWidth', 5);
    %end
end
for ii =1:size(sim_A,2)
   plot_sim = plot(x, p_sim_max_interp{ii},'--','Color', 'r', 'LineWidth', 2);
end

 legend([plot_exp(1),plot_sim(1)],'Exp.','Mdl.')  
%text(x(end)+0.2, p_A1_max(end)+0.2, 'A = 2 ',fig_param.fig_prop{:});
%text(x(end)+0.2, p_A2_max(end)+0.2, 'A = 4 ',fig_param.fig_prop{:});
%text(x(end)+0.2, p_A3_max(end)+0.2, 'A = 6 ',fig_param.fig_prop{:});
%text(x(end)+0.2, p_A4_max(end)+0.2, 'A = 4 ',fig_param.fig_prop{:});
%text(x(end)+0.2, p_A5_max(end)+0.2, 'A = 8',fig_param.fig_prop{:});
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

%vecrast(fig2, 'MDL_VS_EXP', 600, 'bottom', 'pdf');
