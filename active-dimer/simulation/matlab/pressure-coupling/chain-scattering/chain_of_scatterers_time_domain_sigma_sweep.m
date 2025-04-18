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

%%% SAVE DATA FOR PLOTS
sim_name = "20240318__sigma_phase__0_0p2__6";

%% SIMULATION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% LOAD DATA
load('.\__data\20240318__sigma_phase__0_0p2__6.mat')

%%% COUPLING DISORDER Rmk: use 0.8
%{
idx_dis_max = 11;
sigma_list = linspace(0,0.5,idx_dis_max); %  coupling disorder w/r to initial value (0 to 0.2) (must be ascending)
idx_rng_max = 10; % average over different seeds
fprintf("### SIMULATING PULSE DYNAMICS ON METACRYSTAL...\n")
idx_rng_temp = idx_rng_max + 1; % initialize fail seed.
for idx_dis = 1:idx_dis_max
    for idx_rng = (0 + (1:idx_rng_max))
        %%% INITIALISATION
        sys_param = sys_params(); %RESET to prevent disorder propagation
        sys_param.sigma_cpl = sigma_list(idx_dis); % change sigma value and run simulation LOC OR CPL!
        sys_param = disorder(sys_param,idx_rng)
        y0 = zeros(2*sys_param.mat_size,1);% solver initial condition %y = [x1,...,xn,q1,...qn]'
        
        %%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tic
        %'NormControl','on'
        opts = odeset('InitialStep', 1e-5, 'Refine', 10,'Stats','on'); % use refine to compute additional points
    
        fprintf(strcat("### DISORDER = ", string(sigma_list(idx_dis)), ", RANDOM SEED = ", string(idx_rng), '\n'))
        [t_out,y_out] = ode89(@(t,y) odecrystal(t,y,sys_param),[0,sys_param.t_fin], y0, opts); %dynamically adjusts sampling time
        while t_out(end) ~= sys_param.t_fin % If simulation fails (diverging solution), choose new seed
            warning('### UNSTABLE SIMULATION. ASSIGNING A NEW SEED.');
            sys_param = sys_params(); %%%% RESET SYS_PARAM For each iteration (couplings set back to initial val)
            sys_param.sigma_cpl = sigma_list(idx_dis);% Set current loop sigma value
            sys_param = disorder(sys_param, idx_rng_temp); % not + idx_rng_max to prevent seed repititions. 
            fprintf(strcat("### DISORDER = ", string(sigma_list(idx_dis)), ", RANDOM SEED = ", string(idx_rng_temp), '\n'))
            [t_out,y_out] = ode89(@(t,y) odecrystal(t,y,sys_param),[0,sys_param.t_fin], y0, opts); %dynamically adjusts sampling time
            idx_rng_temp = idx_rng_temp + idx_rng_max; % not + 1 to prevent seed repititions. 
        end
        toc
        %%% y_out = [x1,...,xn,q1,...qn] ? [acoustic charge, acoustic flow]
        x = y_out(:,1:sys_param.mat_size);   % acoustic charge
        q = y_out(:,sys_param.mat_size+1:end);% acoustic flow
        x_s = x(:,3:4:end); %the third node is where the first speaker is located and then every 4th that follows until the end.e.g. N=1 -> two columns: one for each speaker
        p_s = 1/(sys_param.Caa)*(x(:,2:4:end) - x(:,3:4:end) - x(:,4:4:end)); %(xi-xs-xo)
        sim_raw = array2timetable(abs(p_s),'RowTimes',seconds(t_out)); 
        p_sim_amp(idx_dis,idx_rng,:) = findamplitude(sim_raw ,sys_param.t_fin/2 - 50e-3,sys_param.t_fin/2); % find mean pressure amplitude in 50ms before excitation end (where equilibrium is reached)
        %p_sim_amp(idx_dis,idx_rng,:) = findamplitude(sim_raw,sys_param.t_fin/2,sys_param.t_fin); % find mean pressureamplitude in when excitation is over (only works for linear coupling where
    end
    p_sim_amp_temp = squeeze(p_sim_amp(idx_dis,:,:)); % sqz rmvs unused dimension
    p_sim_amp_avg(idx_dis,:) = mean(p_sim_amp_temp,1); % averaging over different runs
end
fprintf("### DONE.\n")
%}

%%% PHASE DISORDER RMK: Set kappa to 1e-2 to get similar as coupling disorder !
%
idx_dis_max = 19;
sigma_list = linspace(1,19,idx_dis_max); %  phase disorder in number of samples (ts = 35e-6) starts at 1 bc thats the real sampling time
idx_rng_max = 2; % average over different seeds (not necessary set to 1)
fprintf("### SIMULATING PULSE DYNAMICS ON METACRYSTAL...\n")
idx_rng_temp = idx_rng_max + 1; % initialize fail seed.
for idx_dis = 1:idx_dis_max
    for idx_rng = (0 + (1:idx_rng_max))
        %%% INITIALISATION
        %%% rng(idx_rng)
        %%% lag = sys_param.a/sys_param.c0/2*[abs(sigma_list(idx_dis)*2*(rand(16,1) - 0.5))]; %list of phase delays bewteen two speakers in terms of time delay between two speakers
        lag = 30e-6*[sigma_list(idx_dis)]; % where 35us is the exp sampling time.
        %%% the spread of delay increases with idx_dis
        %%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        tic
        %'NormControl','on'
        opts = odeset('InitialStep', 1e-5, 'Refine', 10,'Stats','on'); % use refine to compute additional points
        fprintf(strcat("### PHASE DISORDER = ", string(sigma_list(idx_dis)), ", RANDOM SEED = ", string(idx_rng), '\n'))
        sol = dde23(@(t,y,Z) dodecrystal(t,y,Z,sys_param),lag,@(t) history(t,sys_param),[0,sys_param.t_fin], opts); %delayed dynamics % history holds the intial values
        t_out = sol.x'; %DELAYED
        y_out = sol.y';
        toc
        %%% y_out = [x1,...,xn,q1,...qn] ? [acoustic charge, acoustic flow]
        x = y_out(:,1:sys_param.mat_size);   % acoustic charge
        q = y_out(:,sys_param.mat_size+1:end);% acoustic flow
        x_s = x(:,3:4:end); %the third node is where the first speaker is located and then every 4th that follows until the end.e.g. N=1 -> two columns: one for each speaker
        p_s = 1/(sys_param.Caa)*(x(:,2:4:end) - x(:,3:4:end) - x(:,4:4:end)); %(xi-xs-xo)
        sim_raw = array2timetable(abs(p_s),'RowTimes',seconds(t_out)); 
        p_sim_amp(idx_dis,idx_rng,:) = findamplitude(sim_raw ,sys_param.t_fin/2 - 50e-3,sys_param.t_fin/2); % find mean pressure amplitude in 50ms before excitation end (where equilibrium is reached)
        %p_sim_amp(idx_dis,idx_rng,:) = findamplitude(sim_raw,sys_param.t_fin/2,sys_param.t_fin); % find mean pressureamplitude in when excitation is over (only works for linear coupling where
    end
    p_sim_amp_temp = squeeze(p_sim_amp(idx_dis,:,:)); % sqz rmvs unused dimensionq
    p_sim_amp_avg(idx_dis,:) = mean(p_sim_amp_temp,1);%.*linspace(1,1.1,16); % averaging over different runs %%%%%%%% COMPENSATION!!!!
end
fprintf("### DONE.\n")
%}

%%% SAVE RAW DATA
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

%% FIGURES  INVERSE PARTICIPATION RATIO (Fixed freq)
close
site_vec = [1:sys_param.N_cell*2];
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
    plot([1:sys_param.N_cell*2], p_sim_amp_avg(idx_dis,:),'-*','Color',cmap(idx_dis,:),'LineWidth',2,'DisplayName',strcat("\sigma = ",string(100*sigma_list(idx_dis)),'%'));
end
%}
hold off
box on
xlabel('site n')
ylabel('|p_n| (Pa)')
%legend
cbar = colorbar;
cbar.Label.String = '\sigma (%)';
cbar.TickLabels = [0,20,40,60,80,100]
colormap(cmap)
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:},'YGrid','off','GridLineStyle', '--');

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
fig2 = figure(2)
hold on
plot(100*sigma_list,100*IPR_exp_avg,'b-o','LineWidth', 4) % FLIP???????????
patch(100*[sigma_list flip(sigma_list)], 100*[(IPR_exp_avg+IPR_exp_std)' flip(IPR_exp_avg-IPR_exp_std)'],'b','FaceAlpha',0.1,'EdgeColor','None','HandleVisibility','off')
yline(100*1/(sys_param.N_cell*2),'--','Fully delocalized baseline','LabelHorizontalAlignment','center','LabelVerticalAlignment','bottom','FontSize',20,'LineWidth', 3)%1/N --> Delocalised regime
hold off
xlabel('Disorder \sigma (%)')
ylabel('IPR (\times 10^{-2})')
%xlim([1.5 12])
%ylim([6.1 7.2])
grid off
box on
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
%}
%vecrast(fig2, 'IPR_vs_sigma', 600, 'bottom', 'pdf'); %%% SAVE GRAPHICS 

save("sigma_phase_sim.mat","sigma_list","IPR_exp_avg","IPR_exp_std")
autoArrangeFigures