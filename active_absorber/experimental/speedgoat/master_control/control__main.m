%%% CONTROL LOOP. Feedback control with model parameters specified in
%%% params.m

addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox');
%clear all
close all
clc

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('control__measure.m');
%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
%legend("\tau = " + string(tau_list*1000) + " ms",'Location','northwest')



%%% Bode plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);

tt = tiledlayout(2,1); %Create tile layout

%%% Magnetude of Specific Acoustic Impedance
ax1 = nexttile; 
semilogx(ax1,F,abs(Zs),'LineWidth',3)
xline(f0,'-.k');
xline(fst,'-.k');
ylabel("Magnetiude (Pa.s/m)")
ylim([0 1200]);
box on
grid on
set(ax1,'xticklabel',[])
%legend("\tau = " + string(tau_list*1000) + " ms",'Location','northwest')
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)

%%% Phase
ax2 = nexttile;
semilogx(ax2,F,angle(Zs),'LineWidth',3)
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

 %figure(7)
%plot(t,Data(:,4))


%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('./simulation/sim__main.m')

%{
w_th=2*pi*linspace(100,1000,901);
Phi_0=(a2*w_th.^2+a1*w_th+a0)./(b2*w_th.^2+b1*w_th+b0);
[Zs1,F1] = tfestimate(Data(:,1),Data(:,4),hamming(N/8),'',f,fs);
figure(8);
hold on
plot(F1,Zs1)
plot(w_th/(2*pi), Phi_0/(sens_pf*u2i))
hold off
%}
autoArrangeFigures()