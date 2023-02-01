%%% Back Pressure and Displacement transfer function meausrement 
%%% Generate frequency sweep and measure velocity v,front pressure pf and
%%% back pressure pb.
%%% OPEN CIRCUIT CONFIGURATION

%%% add toolbox library
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox');
%clear all
close all
clc

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('../params.m')
%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%source = A*sin(2*pi*f.*t);% +randn(size(t))/10; %noisy chirp

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('setup__tf_Pb_Xi_measure.m');
%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
figure(1)
tile = tiledlayout(3,1);
ax1 = nexttile;
plot(ax1,t,pf)

ax2 = nexttile;
plot(ax2,t,v)

ax3 = nexttile;
plot(ax3,t,pb)

% Link the axes
linkaxes([ax1,ax2,ax3],'x');
xlim([0,tmax])
title(tile,'front pressure, velocity, back pressure vs time')
xlabel(tile,'time (s)')
ylabel(tile,'Amplitude')

% Move plots closer together
xticklabels(ax1,{})
tile.TileSpacing = 'compact';



%%%
figure(2);
plot(F,abs(tf_Pb_Xi),'LineWidth',3)
xlim([fi ff]);
xlabel("Frequency (Hz)")
ylabel("Magnitude (Pa\cdot{}m^{-1})")
title("H_{P_b,\xi} \approx " + tf_Pb_Xi_AVG + " (Pa\cdot{}m^{-1})")
box on
grid on
legend("data",'Location','northwest')



%%%
figure(3);
semilogx(F,abs(Zs),'LineWidth',3)
xlim([fi ff]);
xlabel("Frequency (Hz)")
ylabel("Magnitude (Pa\cdot{}s\cdot{}m^{-1})")
title("Z_s")
box on
grid on
legend("data",'Location','northwest')

autoArrangeFigures
%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save('tf_Pb_Xi__out','F','tf_Pb_Xi');

%OCData = open('OC.mat');
   



