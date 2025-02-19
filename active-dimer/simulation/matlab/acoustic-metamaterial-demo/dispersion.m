%%% SCATTERING THROUGH AN ACOUSTIC METAMATERIAL %%%%%%%%%%%%%%%%%%
%%% RMK: Different transfer matrices used for unit cell stores in _fun
%%% M_AER: Unit cell composed of active electroacoustic resonators
%%% M_PC: unit cell of stratified medium with two impedances --> Photonic crystal
%%% M_HR: unit cell of helmholtz resonators (same as AER with kappa =1)

close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
%%% FOR M_AER
sys_param = sys_params();
sys_param.Rms = 0.261*0; % lossy --> *2
sys_param.Mms = 0.75*6.6710e-04; % to change the res freq
sys_param.kappa = 1*sys_param.Sd; % RMK: Sd in the time domain code is found in the odecrystal part... 0.8

%% DISPERSION 
freq = linspace(sys_param.fi*0,sys_param.ff,0.1*sys_param.f_samp)'; % frequency vector (reduced for better graphics!)
k = 2*pi*freq/sys_param.c0; % free space wavevector/ dispersionless omega = c0*k => v_g = v_p = c0
M = M_HR(k,sys_param); %M_AER = M_HR, M_PC
for k_idx = 1:numel(k)
        %[V(:,:,k_idx),D(:,:,k_idx)] = eig(M(:,:,k_idx));
        q_F(k_idx) = (acos(0.5*trace(M(:,:,k_idx)))/sys_param.a)'; % CONSISTANCY CHECK!
end
q_F(1) = 0;% rmv the NaN;

%%% UNFOLD DISPERSION
q_F_unfolded = [q_F(1,1:320),flip(q_F(1,321:end)) + pi/sys_param.a]; %320 bc that is in the gap...




%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close
fig_param = fig_params();

f_bragg_min = 0.56 - 50*sys_param.kappa;
f_bragg_max = 0.56 + 50*sys_param.kappa;

f_local_min = sys_param.f_res*sys_param.a/(sys_param.c0) - 0.04;
f_local_max = sys_param.f_res*sys_param.a/(sys_param.c0) + 0.04;

%%% FIGURE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
cmp = copper(10);
set(gcf,'position',fig_param.window_size);
ax(1) = subplot(1,2,1);%%%%%%%%%%%%%%%%%%%%%%%%%%
plt(1)=plot(abs(real(q_F))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0),"Color", "#0072BD","LineWidth",1.5);
yline([mean([f_local_min,f_local_max]) mean([f_bragg_min,f_bragg_max]) ],"Alpha", 0)
yregion(f_bragg_min, f_bragg_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5); 
yregion(f_local_min, f_local_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5); 
xlabel("Re(qa/\pi)")% full unitcell
ylabel("Nomalized Frequency, f/(c_0/a)" )
xlim([0,1])
%ylim([0 sys_param.c0/sys_param.a]/1000)
ylim([0 1])

ax(2) = subplot(1,2,2); %%%%%%%%%%%%%%%%%%%%%%%%%%%
plt(3)=plot(abs(imag(q_F))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0), "Color", 	"#A2142F","LineWidth",1.5);
%yline([mean([f_local_min,f_local_max]) mean([f_bragg_min,f_bragg_max])],'k--',{'Local','Bragg'},'LabelHorizontalAlignment','center','LabelVerticalAlignment','middle')
yregion(f_bragg_min, f_bragg_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5); 
yregion(f_local_min, f_local_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5);  
xlabel("Im(qa/\pi)")% full unitcell
xlim([0,1])
ylim([0 1])

%%% LEGEND
%legend(ax(2),plt(1:2),{'Lossless','Lossy'})

%%% SET AX STYLE, SIZE AND POSITION
pos = get(ax(2), 'OuterPosition');
%pos(4) = 1 ;                       % Position move 
pos(1) = 0.46;                        % Position move 
set(ax(1),fig_param.fig_prop{:},'XMinorTick','on','YMinorTick','on');
set(ax(2),'OuterPosition',pos,fig_param.fig_prop{:},'YTickLabel',[],'XMinorTick','on','YMinorTick','on');

%%% ANNOTATIONS
annotation('textbox',[.83 0.4 .1 .2], 'String','\leftarrow Bragg','EdgeColor','none')
annotation('textbox',[.83 0.237 .1 .2], 'String','\leftarrow Local','EdgeColor','none')

%
%%% FIGURE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% UNFOLDED BAND
%{
q_sim = (q_F_unfolded);
freq_sim = freq;
save("./__data/sim.mat","freq_sim","q_sim")
%}
figure(2)
%plot(linspace(-1,1,numel(delta_phi_B1)),delta_phi_B1/pi);

plot(abs(real(q_F_unfolded))*sys_param.a/pi/2,freq,"-","Color", "#0072BD","LineWidth",2);

%}

%%% FIGURE 3

fig3 = figure(3)
set(gcf,'units','centimeters','position',fig_param.window_size);
set(gca,fig_param.fig_prop{:}); %%% UNCOMMENT WHEN RUNNING PLOTS MAIN
cmp = copper(10);

plot(abs(real(q_F))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0),'-r');
hold on
plot(abs(imag(q_F))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0),'--k');
hold off
yline([mean([f_local_min,f_local_max]) mean([f_bragg_min,f_bragg_max]) ],"Alpha", 0)
yregion(f_bragg_min, f_bragg_max, 'FaceColor', 'k','FaceAlpha',0.05); 
yregion(f_local_min, f_local_max, 'FaceColor', 'k','FaceAlpha',0.05); 
xlabel("Re(qa/\pi)")% full unitcell
ylabel("Nomalized Frequency, f/(c_0/a)" )
xlim([0,1])
%ylim([0 sys_param.c0/sys_param.a]/1000)
ylim([0 1])
grid on
box on
%%% LEGEND
legend('Re(q_F a/\pi)','Im(q_F a/\pi)')
%%% SAVE FIG
vecrast(fig3 , 'disp_PC', 600, 'bottom', 'pdf');
