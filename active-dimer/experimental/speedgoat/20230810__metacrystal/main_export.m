%%% FOR EXPORTING GRAPHICS
%%% UPDATED: 17.12.2024 
%%%
%%% DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));
addpath('./__fun');
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct();

%k = 2*pi*freq/p.c0; %corresponding wave vector
%N = length(k);

%%% MICROPHONE POSITION (wrt to edge of unit cell)
% l1 = abs(-x2-a/2);
% l2 = abs(x3+a/2);
% s1 = abs(x2-x1);
% s2 = abs(x4-x3);

l1 = p.x2 - p.offset; %distance  between left edge of specimen and mic 2 (c.f. 20220629 notes)
l2 = p.x3 - p.offset ; %distance between left edge of specimen and mic 3

s1 = abs(p.x2-p.x1); %mic  separation
s2 = abs(p.x4-p.x3);%mic separation

%% SYMMETRIC + RECIPROCAL CASE (use with anechoic terminal and src A)
%{
%%% CORRECTION DATA
fstruct = dir('./__data/*70us*.mat');% change manually!!!
load(strcat(fstruct.folder,'\',fstruct.name));

%%% TRANSFER FUNCTION DATA
load('./__data/processed_data_a.mat') ; %Manual Load 
freq = processed_data_a.freq; %corresponding wave vector

k = 2*pi*freq/p.c0; %corresponding wave vector
N = numel(k);

%%% CORRECTION DATA INTERPOLATION
cal.H21_corr = interp1(cal.freq, cal.H21_corr, freq, 'spline');
cal.H31_corr = interp1(cal.freq, cal.H31_corr, freq, 'spline');
cal.H41_corr = interp1(cal.freq, cal.H41_corr, freq, 'spline');

%%% CORRECTION 
H11_a = ones(N,1);
H21_a = processed_data_a.H21./cal.H21_corr;
H31_a = processed_data_a.H31./cal.H31_corr;
H41_a = processed_data_a.H41./cal.H41_corr;

%%% COMPLEX AMPLITUDES 
A = 1i*(H11_a.*exp(1i*k*l1) - H21_a.*exp(1i*k*(l1-s1)))./(2*sin(k*s1))   ;
B = 1i*(H21_a.*exp(-1i*k*(l1-s1)) - H11_a.*exp(-1i*k* l1))./(2*sin(k*s1));
C = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2)) ;
D = 1i*(H41_a.*exp(-1i*k*l2) - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2)) ;

%%% S-MATRIX
s11 = (A.*B-C.*D)./(A.^2 - D.^2.*exp(2*1i*k*p.a));
s12 = (A.*C.*exp(-1i*k*p.a) - B.*D.*exp(1i*k*p.a))./(A.^2-D.^2.*exp(2*1i*k*p.a));
s22 = s11;
s21 = s12;
%}

%% ASYMMETRIC + CASE
%

%%% CORRECTION DATA
fstruct = dir('./__data/*70us*.mat');%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MANUAL INPUT !!!
load(strcat(fstruct.folder,'\',fstruct.name));

%%% TRANSFER FUNCTION DATA
load('./__data/processed_data_a.mat') ; %Manual Load 
load('./__data/processed_data_b.mat') ; %Manual Load 
freq = processed_data_a.freq; %corresponding wave vector

%%% CORRECTION DATA INTERPOLATION
cal.H21_corr = interp1(cal.freq, cal.H21_corr, freq, 'spline');
cal.H31_corr = interp1(cal.freq, cal.H31_corr, freq, 'spline');
cal.H41_corr = interp1(cal.freq, cal.H41_corr, freq, 'spline');


k = 2*pi*freq/p.c0; %corresponding wave vector
N = numel(k);

%%% CORRECTION SMOOTHING HERE!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% cf 20231212

cal.H21_corr = smoothdata(cal.H21_corr,"movmean", (10/p.freq_res)/(freq(2)-freq(1)));% average over nearest neighbors
cal.H31_corr = smoothdata(cal.H31_corr,"movmean", (10/p.freq_res)/(freq(2)-freq(1)));
cal.H41_corr = smoothdata(cal.H41_corr,"movmean", (10/p.freq_res)/(freq(2)-freq(1)));


H11_a = ones(N,1);
H21_a=  processed_data_a.H21./cal.H21_corr; 
H31_a = processed_data_a.H31./cal.H31_corr;
H41_a = processed_data_a.H41./cal.H41_corr;

H11_b = ones(N,1);
H21_b = processed_data_b.H21./cal.H21_corr;
H31_b = processed_data_b.H31./cal.H31_corr;
H41_b = processed_data_b.H41./cal.H41_corr;

%%% COMPUTE WAVE COEFFICIENTS
A_a = 1i*(H11_a.*exp(1i*k*l1)       - H21_a.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B_a = 1i*(H21_a.*exp(-1i*k*(l1-s1)) - H11_a.*exp(-1i*k* l1))./(2*sin(k*s1));
C_a = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2));
D_a = 1i*(H41_a.*exp(-1i*k*l2)      - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

A_b = 1i*(H11_b.*exp(1i*k*l1)       - H21_b.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B_b = 1i*(H21_b.*exp(-1i*k*(l1-s1)) - H11_b.*exp(-1i*k* l1))./(2*sin(k*s1));
C_b = 1i*(H31_b.*exp(+1i*k*(l2+s2)) - H41_b.*exp(+1i*k*l2))./(2*sin(k*s2));
D_b = 1i*(H41_b.*exp(-1i*k*l2)      - H31_b.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

%%% COMPUTE SCATTERING MATRIX
s11 = (D_b.*B_a - D_a.*B_b)./( A_a.*D_b - A_b.*D_a);
s12 = (A_a.*B_b - A_b.*B_a)./( A_a.*D_b - A_b.*D_a).*exp(+1i*k*p.a);% should be +! .*exp(+1i*k*p.a*p.N_cell)
s21 = (D_b.*C_a - D_a.*C_b)./( A_a.*D_b - A_b.*D_a).*exp(-1i*k*p.a);% should be -! ISSUE WITH s21!!.*exp(-1i*k*p.a*p.N_cell)
s22 = (A_a.*C_b - A_b.*C_a)./( A_a.*D_b - A_b.*D_a);

%}

%%% DATA SMOOTHING HERE!!!%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% cf 20231212
%
s11 = smoothdata(s11,"movmean", 40/(freq(2)-freq(1)));% average over 5 nearest neighbors
s12 = smoothdata(s12,"movmean", 40/(freq(2)-freq(1)));
s21 = smoothdata(s21,"movmean", 40/(freq(2)-freq(1)));
s22 = smoothdata(s22,"movmean", 40/(freq(2)-freq(1)));
%}

%%% COMPUTE TRANSFER MATRIX 
t11 = (s21 - (s22.*s11)./s12); % ???????????????????????????????? = 1./conj(s12) = 1./conj(s21) if reciprocal;
%t11 = 1./conj(s21);
t12 = (s22./s12);
t21 = (-s11./s12);
t22 = (1./s12);

%%% COMPUTE FLOQUET-BLOCH WAVE VECTOR q:
%%% General solutions \pm IS THIS CORRECT ?: CF BLOCH AN TRANSFER
%%% MATRIX METHOD in onenote
%{
for ii = 1:N
    T = ([t11(ii),t12(ii);t21(ii),t22(ii)]);
    %q = log(0.5*(trace(T) - sqrt(trace(T)^2 - 4*det(T))))/(1i*p.a);
    q = log(0.5*(trace(T) + sqrt(trace(T)^2 - 4*det(T))))/(1i*p.a);
    q_real(ii) = real(q);
    q_imag(ii) = imag(q);
end
%}
%%% This is due to continuity equation, the can be simplified:
%
q_real = real(acos((t11+t22)/2)/p.a);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q_imag = imag(acos((t11+t22)/2)/p.a);
%}
%% GRAPHICS 
%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf, p 69
close all

cmap = copper(4)
%%% LOAD FIGURE PARAMETERS
fig_param = fig_params(); % must be done to utilize the structure

data_crop = freq>150; %crop the data to remover the low frequency garbage

%%% DISPERSION (ONLY FOR SINGLE CELL)
%
figure(1);
hold on
plot(abs(q_real)*p.a/pi,freq,'-r','LineWidth',3)
plot(abs(q_imag)*p.a/pi,freq,'-k','LineWidth',3)
plot(k*p.a/pi,freq,'-b','LineWidth',1)
plot(2-k*p.a/pi,freq,'-b','LineWidth',1)

hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%yline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%yline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([0 1]);
ylim([0 p.c0/p.a]);

ylabel("Frequency (Hz)")
xlabel("q_Fa/pi")
%title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
legend("Re(q_{F})","Im(q_{F})","q_F = 2\pif/a ")
%legend("\tau = " + string(tau_list*1000) + " ms",'Location','northwest')
%}

%%% S-MATRIX   
fig2 = figure(2);
%
plot(freq(data_crop), abs(s11(data_crop)).^2, 'DisplayName', '|s_{11}|^2','LineWidth',4,'Color',cmap(1,:));
hold on;
plot(freq(data_crop), abs(s12(data_crop)).^2, 'DisplayName', '|s_{12}|^2','LineWidth',4,'Color',cmap(2,:));
plot(freq(data_crop), abs(s21(data_crop)).^2, 'DisplayName', '|s_{21}|^2','LineWidth',4,'Color',cmap(4,:));
plot(freq(data_crop), abs(s22(data_crop)).^2, 'DisplayName', '|s_{22}|^2','LineWidth',4,'Color',cmap(3,:));
%}
%{
plot(freq(data_crop), (0.5*(abs(s11(data_crop))+abs(s22(data_crop)))).^2,'LineWidth',4);
hold on;
plot(freq(data_crop), (0.5*(abs(s12(data_crop))+abs(s21(data_crop)))).^2,'LineWidth',4);
%}
%xline(647,'--',{'Topological','interface'},fig_param.fig_prop{:}) % 
%xline(647,'--',fig_param.fig_prop{:},'DisplayName','Bragg') % 
legend('Location','NorthWest')
%legend(' R',' T', 'Location','NorthWest')
xlim([0,p.freq_fin])
ylim([0,1])
xlabel("Frequency (Hz)")
%title("Transmission/reflection ")
box on
grid on
set(gca,fig_param.fig_prop{:});
%set(gca,'color','none','YDir','normal')
%vecrast(fig2 , 'S_matrix_NR_example', 600, 'bottom', 'pdf');

%Correlation (C-files)
figure(3);
plot(freq, processed_data_a.C21, 'DisplayName', 'C_{21}','LineWidth',2);
hold on;
plot(freq, processed_data_a.C31, 'DisplayName', 'C_{31}','LineWidth',2);
plot(freq, processed_data_a.C41, 'DisplayName', 'C_{41}','LineWidth',2);
legend show;
xlim([0,p.freq_fin])
ylim([0, 1.2])
xlabel("Frequency (Hz)")
title("Coherence w/r to mic. 1 of run A")
box on
grid on

%
figure(4);
plot(freq, abs(cal.H21_corr), 'DisplayName', 'H_{21,corr}','LineWidth',2);
hold on;
plot(freq, abs(cal.H31_corr), 'DisplayName', 'H_{31,corr}','LineWidth',2);
plot(freq, abs(cal.H41_corr), 'DisplayName', 'H_{41,corr}','LineWidth',2);
legend show;
xlim([0,p.freq_fin])
ylim([0, 1.2])
xlabel("Frequency (Hz)")
title("Transfer function corrections w/r to mic. 1")
box on
grid on
%}
autoArrangeFigures
%% Other...

%%% T-MATRIX
%{
figure(5);
%hold on;
plot(freq, abs(t11).^2, 'DisplayName', 't11');
hold on;
plot(freq, abs(t21).^2, 'DisplayName', 't21');
plot(freq, abs(t12).^2, 'DisplayName', 't12');
plot(freq, abs(t22).^2, 'DisplayName', 't22');
legend show;
xlim([0,p.freq_fin])
ylim([0,1])
xlabel("Frequency (Hz)")
box on
grid on
%}


%{
figure(5);
subplot(2,1,1);
%hold on;
plot(freq, abs(s11).^2, 'DisplayName', 's11');
hold on;
plot(freq, abs(s21).^2, 'DisplayName', 's21');
plot(freq, abs(s12).^2, 'DisplayName', 's12');
plot(freq, abs(s22).^2, 'DisplayName', 's22');
legend show;
ylim([0,1])

subplot(2,1,2);
plot(freq, angle(s11), 'DisplayName', 's11');
hold on
plot(freq, angle(s21), 'DisplayName', 's21');
plot(freq, angle(s12), 'DisplayName', 's12');
plot(freq, angle(s22), 'DisplayName', 's22');
legend show;
%}

