%%% UPDATED: 21.11.2022
%%% DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));%
addpath('./__fun');
addpath('./__data');
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct();

%k = 2*pi*p.freq/p.c0; %+ 70%corresponding wave vector
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

%% CORRECTION DATA
delimiterIn = '\t';
headerlinesIn = 84;

H21I  = import_pulse_data('H21I.txt');
H31I  = import_pulse_data('H31I.txt');
H41I  = import_pulse_data('H41I.txt');

H21II = import_pulse_data("H21II.txt");
H31II = import_pulse_data("H31II.txt");
H41II = import_pulse_data("H41II.txt");

%%% CORRECTION TRANSFERFUNCTION cor
cal.H21_corr = sqrt(H21II.data.*H21I.data); %%%20221110--> changes from ./" to ".*" !!!! %correction
cal.H31_corr = sqrt(H31II.data.*H31I.data);
cal.H41_corr = sqrt(H41II.data.*H41I.data);

p.freq = H21I.freq; %%%% The frequency should be the same for all
k = 2*pi*p.freq/p.c0; 
p.N = length(k);
%% TRANSFER FUNCTION DATA
processed_data_a.H21 = import_pulse_data('H21a.txt').data;
processed_data_a.H31 = import_pulse_data('H31a.txt').data;
processed_data_a.H41 = import_pulse_data('H41a.txt').data;

processed_data_b.H21 =  import_pulse_data('H21b.txt').data;
processed_data_b.H31 =  import_pulse_data('H31b.txt').data;
processed_data_b.H41 =  import_pulse_data('H41b.txt').data;



H11_a = ones(p.N,1);
H21_a = processed_data_a.H21./cal.H21_corr;
H31_a = processed_data_a.H31./cal.H31_corr;
H41_a = processed_data_a.H41./cal.H41_corr;

H11_b = ones(p.N,1);
H21_b =  processed_data_b.H21./cal.H21_corr;
H31_b =  processed_data_b.H31./cal.H31_corr;
H41_b =  processed_data_b.H41./cal.H41_corr;

%%% COMPUTE WAVE COEFFICIENTS
A_a = 1i*(H11_a.*exp(1i*k*l1)       - H21_a.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B_a = 1i*(H21_a.*exp(-1i*k*(l1-s1)) - H11_a.*exp(-1i*k* l1))./(2*sin(k*s1));
C_a = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2));
D_a = 1i*(H41_a.*exp(-1i*k*l2)      - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

A_b = 1i*(H11_b.*exp(1i*k*l1)       - H21_b.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B_b = 1i*(H21_b.*exp(-1i*k*(l1-s1)) - H11_b.*exp(-1i*k* l1))./(2*sin(k*s1));
C_b = 1i*(H31_b.*exp(+1i*k*(l2+s2)) - H41_b.*exp(+1i*k*l2))./(2*sin(k*s2));
D_b = 1i*(H41_b.*exp(-1i*k*l2)      - H31_b.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

%%% COMPUTE SCATTERING MATRIX --> RECHECK THIS!
%{
s11 = +(D_b.*B_a - D_a.*B_b)./( A_a.*D_b - A_b.*D_a);
s21 = +(D_b.*C_a - D_a.*C_b)./( A_a.*D_b - A_b.*D_a).*exp(-1i*k*p.a);
s12 = +(A_a.*B_b - A_b.*B_a)./( A_a.*D_b - A_b.*D_a).*exp(-1i*k*p.a);
s22 = +(A_a.*C_b - A_b.*C_a)./( A_a.*D_b - A_b.*D_a);
%}

s11 = (D_b.*B_a - D_a.*B_b)./( A_a.*D_b - A_b.*D_a);
s12 = (A_a.*B_b - A_b.*B_a)./( A_a.*D_b - A_b.*D_a).*exp(-1i*k*p.a);% should be +!
s21 = (D_b.*C_a - D_a.*C_b)./( A_a.*D_b - A_b.*D_a).*exp(+1i*k*p.a);% should be -!
s22 = (A_a.*C_b - A_b.*C_a)./( A_a.*D_b - A_b.*D_a);

%}

%%% COMPUTE TRANSFER MATRIX 
t11 = 1./conj(s12);%s21-(s11.*s22./s12); ????????????????????????????????
t12 = s22./s12;
t21 = -s11./s12;
t22 = 1./s12;

%%% COMPUTE FLOQUET-BLOCH WAVE VECTOR q:
%%% General solutions \pm
%
for ii = 1:p.N
    T = [t11(ii),t12(ii);t21(ii),t22(ii)];
    q = log(0.5*(trace(T) - sqrt(trace(T)^2-4*det(T))))/(1i*p.a);
    %q = log(0.5*(trace(T) - sqrt(trace(T)^2-4*det(T))))/(1i*a);
    
    q_real(ii) = real(q);
    q_imag(ii) = imag(q);
end
%}
%%% If reciprocal, the eigensolutions are the same and can be simplified:
 %q_real = real(acos((t11+t22)/2)/p.a);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %q_imag = imag(acos((t11+t22)/2)/p.a);

%% GRAPHICS 
%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf, p 69
close all
%%% DISPERSION 
figure(1);
hold on
plot(abs(q_real)*p.a/pi,p.freq,'-r','LineWidth',3)
plot(abs(q_imag)*p.a/pi,p.freq,'-k','LineWidth',3)
plot(k*p.a/pi,p.freq,'-b','LineWidth',1)
plot(2-k*p.a/pi,p.freq,'-b','LineWidth',1)

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
figure(2);

plot(p.freq, abs(s11).^2, 'DisplayName', 's11^2','LineWidth',2);
hold on;
plot(p.freq, abs(s21).^2, 'DisplayName', 's21^2','LineWidth',2);
plot(p.freq, abs(s12).^2, 'DisplayName', 's12^2','LineWidth',2);
plot(p.freq, abs(s22).^2, 'DisplayName', 's22^2','LineWidth',2);
legend show
ylim([0,1])
xlim([0,p.ff])
xlabel("Frequency (Hz)")
title("Transmission/reflection")
box on
grid on

grid on

%autoArrangeFigures
%% Other...

%%% T-MATRIX
%{
figure(4);
%hold on;
plot(f, abs(t11), 'DisplayName', 't11');
hold on;
plot(f, abs(t21), 'DisplayName', 't21');
plot(f, abs(t12), 'DisplayName', 't12');
plot(f, abs(t22), 'DisplayName', 't22');
legend show;
ylim([0,1])
xlabel("Frequency (Hz)")
box on
grid on
%}


%{
figure(2);
subplot(2,1,1);
%hold on;
plot(f, abs(s11), 'DisplayName', 's11');
hold on;
plot(f, abs(s21), 'DisplayName', 's21');
plot(f, abs(s12), 'DisplayName', 's12');
plot(f, abs(s22), 'DisplayName', 's22');
legend show;

subplot(2,1,2);
plot(f, angle(s11), 'DisplayName', 's11');
hold on
plot(f, angle(s21), 'DisplayName', 's21');
plot(f, angle(s12), 'DisplayName', 's12');
plot(f, angle(s22), 'DisplayName', 's22');
legend show;
%}

