%%% Back Pressure and Displacement transfer function meausrement 
%%% Generate frequency sweep and measure velocity v,front pressure pf and
%%% back pressure pb.
%%% add toolbox library
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox');
%clear all
close all
clc

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('__params.m')
%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
source = A*sin(2*pi*f.*t);% +randn(size(t))/10; %noisy chirp

%FAKE DATA
%{
F  = f; 
pf = 20+rand(size(F))/10 + i*(4*(2*pi*F) - 1./(2*pi*F*12)); %data 
v = pf;
pb = pf;
%}

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%run('tf_Pb_Xi__measurement.m')
%}
%% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = sc.Time; 

pf = sc.Data(:,1)*sens_pf; %front pressure
v  = sc.Data(:,2)*sens_v;  %velocity
pb = sc.Data(:,3)*sens_pb; %% back pressure
source_0 = sc.Data(:,4); 
%}
%% PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Acoustic impedance

%%% FFT method (Does the same as tfestimate without windowing)
%{
NFFT = 2^(nextpow2(length(pf))+3); % n-point dft + padding

Pf = fft(pf,NFFT); %2sided spectrum
V = fft(v,NFFT);
Pb = fft(pb,NFFT);

Pf = Pf(1:NFFT/2);%1sided spectrum (up to Nyquist bin)
V = V(1:NFFT/2);
Pb = Pb(1:NFFT/2);

%%% Specific acoustic impedance
%Zs  = Pf./V; %Specific Acoustic Impedance
%F = (1/ts*((1:NFFT/2))/NFFT)'; %FFT frequency vector

tf_Pb_Xi = (1i*2*pi*F.*Pb)./V; %%% Back pressure to displacement transfer fucntion - c.f. [2020] X.Guo
%} 

%%% tf_Pb_Xi: Relation between displacement Xi and backpressure Pb
[tf_Pb_V,F] = tfestimate(v,pb,hamming(N/8),'',N);% If you specify noverlap as empty, then tfestimate uses a number that produces 50% overlap between segments. 
tf_Pb_Xi = 1i*2*pi*F.*tf_Pb_V;

%%% Zs: Acoustic Impedance.
[Zs,F] = tfestimate(v,pf,hamming(N/8),'',N);
F=F/pi/2*fs;

%%% Proportionality factor between displacement and back-pressure (within a
%%% certain frequency range)
tf_Pb_Xi_AVG =  mean(abs(tf_Pb_Xi(F>100 & F<400))); 
fprintf('tf_Pb_Xi = %f Pa/m \n', tf_Pb_Xi_AVG);



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
title(tile,'My Title')
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

%save('tf_Pb_Xi__out','F','tf_Pb_Xi');

%OCData = open('OC.mat');
   



