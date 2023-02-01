clear all
close all
clc

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Zc = 346.13*1.1839; % characteristic specific acoustic impedence at 25°C
tf_Pb_Xi = 925000; % Back pressure to displacement transfer function.

%%% Speaker (Visaton AL-170)
Sd = 133E-4;    % Effective piston area [m^2]
Mms  = 13E-3;      % Moving mass [kg] **
Rms = 0.6;       % Mechanical resitance [N.s/m] **
Cms = 594.85E-6; % Mechanical complicance due to surround suspension and spider [m/N]
Cab = 10;       % Compliance of enclosure due to back pressure [N/m^4]
%Cmc = (1/Cms + Sd^2/Cab)^-1; % **
Cmc = 5.9485e-04 % [m/N] % **

f0 = 1/(2*pi*sqrt((Mms*Cms*Cab)/(Sd^2*Cms+Cab))); % Resonnance frequency Hz

Bl = 6.9;        % Force factor [N/A] **
Le = 0.9E-3;    % Voice coil inductance [H] NOT NECESSARY
Re = 5.6;       % DC coil resistance [Ohm] 

% ** are measured with ms_estimate.m 

%%% TARGET IMPEDENCE WEIGHTS 
%%% muR = muM = muC = 1 -> open circuit
%%% <1 reflection ; >1 absorption
muR = (Zc/(Rms/Sd)); % Optimal absorption = Zc/Zas
muM = 1; 
muC = 1; 
fst = f0*sqrt(muC/muM); %Target resonnance frequency


%%% TRANSFER FUNCTION COEFFICIENTS
%num:
a2 = Sd*(muM - 1)*Mms;
a1 = Sd*(muR - 1)*Rms;
a0 = Sd*(muC - 1)/Cmc ;

%den:
b2 = Bl*muM*Mms;
b1 = Bl*muR*Rms;
b0 = Bl*muC/Cmc;

%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tmax = 5; %% total mesaurement time (s)

fi = 1; %% initial frequency
ff = 1000; %% final frequency

fs = 10*ff; %% sampling frequency (Hz)
ts = 1/fs; %% % sampling period (s)

t = (0:ts:tmax)'; %time vector
f = fi+(ff-fi)*t/tmax; %frequency vector

N = length(t); %Number of samples

A = 0.5; %% source amplitude (V)
%source = A*sin(2*pi*f.*t);% +randn(size(t))/10; %noisy chirp
source = chirp(0,fi,tmax,tf);
%FAKE DATA
%
F  = f; 
Zs  = 20+rand(size(F))/10 + i*(4*(2*pi*F) - 1./(2*pi*F*12)); %data 
%}

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
run('pb_control_measurement.m')
%%% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = sc.Time; 
Data = sc.Data;
%%% TRY TO COMPACTIFY!!!s
pf = Data(:,1); % front pressure
%v  = Data(:,2);  %velocity
pb  = Data(:,2);  %back pressure
source_out = Data(:,3); %% generated source 
feedback_voltage = Data(:,4); %% feedback voltage

%}

%% COMPUTE IMPEDENCE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Acoustic impedance

%{
%%% tfestimate method (Determines the transfer function between v and pf):
[Zs{ii},F] = tfestimate(v_out.data,pf_out.data,wind,[],[],fs);

%%% FFT method (Does the same as tfestimate):
pf = pf_out.data; %wind.*pf_out.data; %hamming(L).*pf_out.data;
v = v_out.data;% wind.*v_out.data;
%}

%%% FFT method (Does the same as tfestimate)
NFFT = 2^(nextpow2(length(pf))+3); % n-point dft + padding

Pf = fft(pf,NFFT); %2sided spectrum
%V = fft(v,NFFT);
Pb = fft(pb,NFFT);

Pf = Pf(1:NFFT/2);%1sided spectrum (up to Nyquist bin)
%V = V(1:NFFT/2);
Pb = Pb(1:NFFT/2);


%%% Specific acoustic impedance
F = (1/ts*((1:NFFT/2))/NFFT)'; %FFT frequency vector
V = (i*2*pi.*F)/tf_Pb_Xi; % back pressure is prop to displacement.

Zs  = Pf./V; %Specific Acoustic Impedance
%%% Absorption coefficient
alpha = 1 - abs((Zs-Zc)./(Zs+Zc)).^2;

%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%%% alpha vs freq %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
semilogx(F,alpha,'LineWidth',3)

%linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([1 ff]);
ylim([0 1.1]);

xlabel("Frequency (Hz)")
ylabel("Absorbtion coefficient")
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
legend("data",'Location','northwest')


%%% Bode plot %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);
cmap = copper(numel(alpha)); % Cell array of colors.

tt = tiledlayout(2,1); %Create tile layout

%%% Magnetude of Specific Acoustic Impedance
ax1 = nexttile; 

semilogx(ax1,F,abs(Zs),'LineWidth',3)

%xline(f0,'-.k');
%xline(fst,'-.k');
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

%linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});
ylabel("Phase (rad)")
box on
grid on
ylim([-pi pi])
set(ax2,'YTick',-pi:pi/2:pi)
set(ax2,'YTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})

% Link the axes
linkaxes([ax1,ax2],'x');
xlim([1 ff]);

% Move plots closer together
xticklabels(ax1,{})
tt.TileSpacing = 'compact';


autoArrangeFigures 



