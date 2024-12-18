%%% SCATTERING THROUGH AN INFINITE ACOUSTIC LINER IN FREQUENCY DOMAIN %%%%%%%%%%%%%%%%%%
%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
sys_param = sys_params();
sys_param.Rms = 0.261*2; % lossy 
sys_param.Mms = 0.75*6.6710e-04; % to change the res freq
sys_param.kappa = 0.9*sys_param.Sd; % RMK: Sd in the time domain code is found in the odecrystal part... 0.8

%% DISPERSION 


freq = linspace(sys_param.fi*0,sys_param.ff,0.1*sys_param.f_samp)'; % frequency vector (reduced for better graphics!)
k = 2*pi*freq/sys_param.c0; % free space wavevector/ dispersionless omega = c0*k => v_g = v_p = c0

%%% LOSSY
%{
zs = (1i*k*sys_param.c0)*sys_param.Mms + sys_param.Rms + 1./((1i*k*sys_param.c0)*sys_param.Cms);
zr = sys_param.rho0*sys_param.c0 + sys_param.Sd/sys_param.S;

% Unitcell transfer matrix:
num = 4*zs.*(1i*sys_param.kappa*zr*sin((sys_param.a*k)/2)+zs);
den = -(sys_param.kappa-sys_param.Sd)*(sys_param.kappa+sys_param.Sd)*zr.^2*(-1+cos(sys_param.a*k)) - 4*1i*zr*(sys_param.kappa*sin((sys_param.a*k)/2) - sys_param.Sd*sin(sys_param.a*k)).*zs + 4*cos(sys_param.a*k).*zs.^2;
q_F_lossy  = asec(num./den)/sys_param.a;
%}
M = M_cell(k,sys_param);
for k_idx = 1:numel(k)
        %[V(:,:,k_idx),D(:,:,k_idx)] = eig(M(:,:,k_idx));
        q_F_lossy(k_idx) = (acos(0.5*trace(M(:,:,k_idx)))/sys_param.a)'; % CONSISTANCY CHECK!
end

%%% LOSSLESS
%{
zs = (1i*k*sys_param.c0)*sys_param.Mms + sys_param.Rms + 1./((1i*k*sys_param.c0)*sys_param.Cms);
%zr = sys_param.rho0*sys_param.c0 + sys_param.Sd/sys_param.S;

% Unitcell transfer matrix:
num = 4*zs.*(1i*sys_param.kappa*zr*sin((sys_param.a*k)/2)+zs);
den = -(sys_param.kappa-sys_param.Sd)*(sys_param.kappa+sys_param.Sd)*zr.^2*(-1+cos(sys_param.a*k)) - 4*1i*zr*(sys_param.kappa*sin((sys_param.a*k)/2) - sys_param.Sd*sin(sys_param.a*k)).*zs + 4*cos(sys_param.a*k).*zs.^2;

q_F_lossless  = asec(num./den)/sys_param.a;
q_F_lossless(1) = 0;% rmv the NaN;
%}
sys_param.Rms = 0;
M = M_cell(k,sys_param);
for k_idx = 1:numel(k)
        %[V(:,:,k_idx),D(:,:,k_idx)] = eig(M(:,:,k_idx));
        q_F_lossless(k_idx) = (acos(0.5*trace(M(:,:,k_idx)))/sys_param.a)'; % CONSISTANCY CHECK!
end
q_F_lossless(1) = 0;% rmv the NaN;

%%% UNFOLD DISPERSION
q_F_lossy_unfolded = [q_F_lossy(1,1:320),flip(q_F_lossy(1,321:end))+pi/sys_param.a]; %320 bc that is in the gap...
q_F_lossless_unfolded = [q_F_lossless(1,1:320),flip(q_F_lossless(1,321:end))+pi/sys_param.a]; %320 bc that is in the gap...

%%% ZAK PHASE %%% FALSE!!! --> ce geometric phase and band inversion in

 %The poles and zeros of the eigenvalues as well as the eigenvectors of the S-matrix in the complex-frequency plane provide rich information, as they are identified with the resonances of the system
S = 0*M; %eigenvector
for k_idx = 1:numel(k)
        S(1,1,k_idx) = -M(2,1,k_idx)/M(2,2,k_idx);
        S(1,2,k_idx) = 1/M(2,2,k_idx);
        S(2,1,k_idx) = M(1,1,k_idx) - M(1,2,k_idx)*M(2,1,k_idx)/M(2,2,k_idx);
        S(2,2,k_idx) = M(1,2,k_idx)/M(2,2,k_idx);
end

V = 0*S; %eigenvector
D = V;   %eigenvalue [p+;p-]
for k_idx = 1:numel(k)
        [V(:,:,k_idx),D(:,:,k_idx)] = eig(S(:,:,k_idx));
end


%{
%%% periodic acoustic systems
delta_phi = [0; angle(q_F_lossless(2:end)) - angle(q_F_lossless(1:end-1))]
%%% B1
delta_phi_B1 = delta_phi(freq<340);
zak_B1 = mod(sum(delta_phi_B1), 2*pi);
%%% B2
delta_phi_B2 = delta_phi(380<freq<610);
zak_B2 = mod(sum(delta_phi_B2)-2*pi, 2*pi);
%%% B3
delta_phi_B3 = delta_phi(freq>730);
zak_B3 = mod(sum(delta_phi_B1), 2*pi);
%}



%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close
fig_param = fig_params();

f_bragg_min = 0.54 - 50*sys_param.kappa;
f_bragg_max = 0.54 + 50*sys_param.kappa;

f_local_min = sys_param.f_res*sys_param.a/(sys_param.c0) - 0.06 - 0.02;
f_local_max = sys_param.f_res*sys_param.a/(sys_param.c0) + 0.06 - 0.02;
%%% FIGURE 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)
cmp = copper(10);
set(gcf,'position',fig_param.window_size);
ax(1) = subplot(1,2,1);%%%%%%%%%%%%%%%%%%%%%%%%%%
plt(1)=plot(abs(real(q_F_lossless))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0),"Color", "#0072BD","LineWidth",1.5);
hold on
plt(2) = plot(abs(real(q_F_lossy))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0),":","Color", "#0072BD","LineWidth",2);
hold off
yline([mean([f_local_min,f_local_max]) mean([f_bragg_min,f_bragg_max]) ],"Alpha", 0)
yregion(f_bragg_min, f_bragg_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5); 
yregion(f_local_min, f_local_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5); 
xlabel("Re(qa/\pi)")% full unitcell
ylabel("Nomalized Frequency, $f/ \frac{c_0}{a}$",'Interpreter','latex' )
xlim([0,1])
%ylim([0 sys_param.c0/sys_param.a]/1000)
ylim([0 1])

ax(2) = subplot(1,2,2); %%%%%%%%%%%%%%%%%%%%%%%%%%%
plt(3)=plot(abs(imag(q_F_lossless))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0), "Color", 	"#A2142F","LineWidth",1.5);
hold on
plt(4)= plot(abs(imag(q_F_lossy))*sys_param.a/pi,freq*sys_param.a/(sys_param.c0),":","Color", 	"#A2142F","LineWidth",2);
hold off
%yline([mean([f_local_min,f_local_max]) mean([f_bragg_min,f_bragg_max])],'k--',{'Local','Bragg'},'LabelHorizontalAlignment','center','LabelVerticalAlignment','middle')
yregion(f_bragg_min, f_bragg_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5); 
yregion(f_local_min, f_local_max, 'FaceColor', 'k','FaceAlpha',0.05, 'EdgeColor','k','LineStyle','--','LineWidth',1.5);  
xlabel("Im(qa/\pi)")% full unitcell
xlim([0,1])
ylim([0 1])

%%% LEGEND
legend(ax(2),plt(1:2),{'Lossless','Lossy'})

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
%% FIGURE 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% UNFOLDED BAND
q_sim = (q_F_lossless_unfolded);
freq_sim = freq;
save("./__data/sim.mat","freq_sim","q_sim")
figure(2)
%plot(linspace(-1,1,numel(delta_phi_B1)),delta_phi_B1/pi);
hold on
plot(abs(real(q_F_lossless_unfolded))*sys_param.a/pi/2,freq,"-","Color", "#0072BD","LineWidth",2);
plot(abs(imag(q_F_lossless_unfolded))*sys_param.a/pi/2,freq,":","Color", "#0072BD","LineWidth",2);

hold off
%}