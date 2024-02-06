%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%
%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
%rng(1);%specifies the seed for the MATLAB® random number generator TEST
close all;  
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
sys_param = sys_params();

%%% SAVE DATA FOR PLOTS
sim_name = "sim_sigmasweep_cells";

%% SIMULATION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
idx_dis_max = 5;
sigma_list = linspace(0,0.2,idx_dis_max); % percent of disorder w/r to initial value
idx_rng_max = 9; % average over different seeds

for idx_dis = 1:idx_dis_max
    for idx_rng = 1:idx_rng_max
        sys_param.sigma_cpl = sigma_list(idx_dis); % change sigma value and run simulation LOC OR CPL!
        sys_param = disorder(sys_param,idx_rng)
        %%% INITIALISATION
        y0 = zeros(2*sys_param.mat_size,1);% solver initial condition %y = [x1,...,xn,q1,...qn]'
        fprintf("### SIMULATING PULSE DYNAMICS ON METACRYSTAL...\n")
        %%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tic
        %'NormControl','on'
        opts = odeset('InitialStep', 1e-5, 'Refine', 10,'Stats','on'); % use refine to compute additional points
        [t_out,y_out] = ode89(@(t,y) odecrystal(t,y,sys_param),[0,sys_param.t_fin], y0, opts); %dynamically adjusts sampling time
        toc
        fprintf("### DONE.\n")
        %%% y_out = [x1,...,xn,q1,...qn] ? [acoustic charge, acoustic flow]
        x = y_out(:,1:sys_param.mat_size);   % acoustic charge
        q = y_out(:,sys_param.mat_size+1:end);% acoustic flow
        x_s = x(:,3:4:end); %the third node is where the first speaker is located and then every 4th that follows until the end.e.g. N=1 -> two columns: one for each speaker
        p_s = 1/(sys_param.Caa)*(x(:,2:4:end) - x(:,3:4:end) - x(:,4:4:end)); %(xi-xs-xo)
        sim_raw = array2timetable(abs(p_s),'RowTimes',seconds(t_out)); 
        p_sim_amp_temp{idx_rng} = findamplitude(sim_raw ,150e-3,250e-3); % find mean pressure amplitude in 150-250 ms interval
    end
    p_sim_amp{idx_dis} = mean(cell2mat(p_sim_amp_temp'),1); % averaging over 
end

%% SAVE DATA
%{
tic
% make timetable
sim_raw = array2timetable(abs(p_s),'RowTimes',seconds(t_out)); 
if ~exist("__data", 'dir')
   mkdir("__data")
end
if ~isfile(string("./__data/" + sim_name + ".mat"))
    save(string("./__data/" + sim_name + ".mat"),"sim_raw")
else
    fprintf("### FILE NOT SAVED: FILE NAME ALREADY EXISTS\n")
end
toc
%}

%% FIGURES
fig_param = fig_params();
cmap = copper(idx_dis_max);
fig1 = figure(1);
hold on
for idx_dis = 1:5
    plot([1:16], p_sim_amp{idx_dis},'--o','Color',cmap(idx_dis,:),'LineWidth',2)
end
hold off
box on
xlabel('site n')
ylabel('|p_n| (Pa)')
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');
