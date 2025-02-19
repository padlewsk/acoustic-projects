
%%% DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
addpath('./__fun');
addpath('./__data');
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct();

k = 2*pi*p.freq/p.c0; %+ 70%corresponding wave vector
%N = length(k);


%%% MICROPHONE POSITION (wrt to edge of unit cell)
% l1 = abs(-x2-a/2);
% l2 = abs(x3+a/2);
% s1 = abs(x2-x1);
% s2 = abs(x4-x3);

l1 = p.x2 - p.offset; %distance between left edge of specimen and mic 2 (c.f. 20220629 notes)
l2 = p.x3 - p.offset ; %distance between left edge of specimen and mic 3
s1 = abs(p.x2-p.x1); %mic separation
s2 = abs(p.x4-p.x3);%mic separation

%% SYMMETRIC CASE
%{ 
%%OLD
load('./__data/H21_corr.mat');
load('./__data/H31_corr.mat');
load('./__data/H41_corr.mat');

H11_a = ones(N,1);
H21_a = load('./__data/H21_a.mat').H21_a.*H21_corr;
H31_a = load('./__data/H31_a.mat').H31_a.*H31_corr;
H41_a = load('./__data/H41_a.mat').H41_a.*H41_corr;

A1_a = 1i*(H11_a.*exp(-1i*k* l1) - H21_a.*exp(-1i*k*(l1+s1)))./(2*sin(k*s1));%left
B1_a = 1i*(H21_a.*exp(+1i*k*(l1+s1)) - H11_a.*exp(+1i*k* l1))./(2*sin(k*s1));
A2_a = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2));%right
B2_a = 1i*(H41_a.*exp(-1i*k*l2) - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));


s11 = (A1_a.*B1_a- A2_a.*B2_a)./(A1_a.^2 - B2_a.^2);
s22 = s11;
s12 = (A1_a.*A2_a - B1_a.*B2_a)./(A1_a.^2 - B2_a.^2) ;
s21 = s12;


%}

%{
load('./__data/H21_corr.mat');
load('./__data/H31_corr.mat');
load('./__data/H41_corr.mat');

H11_a = ones(p.N,1);
H21_a = load('./__data/H21_a.mat').H21_a.*H21_corr;
H31_a = load('./__data/H31_a.mat').H31_a.*H31_corr;
H41_a = load('./__data/H41_a.mat').H41_a.*H41_corr;

A = 1i*(H11_a.*exp(1i*k*l1) - H21_a.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B = 1i*(H21_a.*exp(-1i*k*(l1-s1)) - H11_a.*exp(-1i*k* l1))./(2*sin(k*s1));
C = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2));
D = 1i*(H41_a.*exp(-1i*k*l2) - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

s11 = (A.*B-C.*D)./(A.^2-D.^2.*exp(2*1i*k*p.a));
s12 = (A.*C.*exp(-1i*k*p.a) - B.*D.*exp(1i*k*p.a))./(A.^2-D.^2.*exp(2*1i*k*p.a));
s22 = s11;
s21 = s12;

%}

%% ASYMMETRIC CASE
%
%%% IMPORT DATA:
load('./__data/H21_corr.mat');
load('./__data/H31_corr.mat');
load('./__data/H41_corr.mat');

H11_a = ones(N,1);
H21_a = load('./__data/H21_a.mat').H21_a.*H21_corr;
H31_a = load('./__data/H31_a.mat').H31_a.*H31_corr;
H41_a = load('./__data/H41_a.mat').H41_a.*H41_corr;

H11_b = ones(N,1);
H21_b = load('./__data/H21_b.mat').H21_b.*H21_corr;
H31_b = load('./__data/H31_b.mat').H31_b.*H31_corr;
H41_b = load('./__data/H41_b.mat').H41_b.*H41_corr;



%%% COMPUTE WAVE COEFFICIENTS
%%% LOAD a
% A_a = -(H11_a.*exp(-1i*k* l1    ) - H21_a.*exp(-1i*k*(l1+s1)))./(2i*sin(k*s1));
% B_a = -(H21_a.*exp( 1i*k*(l1+s1)) - H11_a.*exp( 1i*k* l1    ))./(2i*sin(k*s1));
% C_a = -(H31_a.*exp( 1i*k*(l2+s2)) - H41_a.*exp( 1i*k* l2    ))./(2i*sin(k*s2));
% D_a = -(H41_a.*exp(-1i*k* l2    ) - H31_a.*exp(-1i*k*(l2+s2)))./(2i*sin(k*s2));


A_a = 1i*(H11_a.*exp(1i*k*l1) - H21_a.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B_a = 1i*(H21_a.*exp(-1i*k*(l1-s1)) - H11_a.*exp(-1i*k* l1))./(2*sin(k*s1));
C_a = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2));
D_a = 1i*(H41_a.*exp(-1i*k*l2) - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));


%%% LOAD b
% A_b = -(H11_b.*exp(-1i*k* l1    ) - H21_b.*exp(-1i*k*(l1+s1)))./(2i*sin(k*s1));
% B_b = -(H21_b.*exp( 1i*k*(l1+s1)) - H11_b.*exp( 1i*k* l1    ))./(2i*sin(k*s1));
% C_b = -(H31_b.*exp( 1i*k*(l2+s2)) - H41_b.*exp( 1i*k* l2    ))./(2i*sin(k*s2));
% D_b = -(H41_b.*exp(-1i*k* l2    ) - H31_b.*exp(-1i*k*(l2+s2)))./(2i*sin(k*s2));

A_b = 1i*(H11_b.*exp(1i*k*l1) - H21_b.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B_b = 1i*(H21_b.*exp(-1i*k*(l1-s1)) - H11_b.*exp(-1i*k* l1))./(2*sin(k*s1));
C_b = 1i*(H31_b.*exp(+1i*k*(l2+s2)) - H41_b.*exp(+1i*k*l2))./(2*sin(k*s2));
D_b = 1i*(H41_b.*exp(-1i*k*l2) - H31_b.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

%%% COMPUTE SCATTERING MATRIX 
%{
M = [A_a, D_a, 0, 0;
     A_b, D_b, 0, 0;
     0, 0, A_a, D_a;
     0, 0, A_b, D_b];
 
K = [B_a, B_b, C_a, C,b];

S = inv(M)*K;
%}


% s11 = +(D_b.*B_a - D_a.*B_b)./( A_a.*D_b - A_b.*D_a);
% s12 = (-A_b.*B_a + A_a.*B_b)./( A_a.*D_b - A_b.*D_a);
% s21 = +(D_b.*C_a - D_a.*C_b)./( A_a.*D_b - A_b.*D_a);
% s22 = (-A_b.*C_a + A_a.*C_b)./( A_a.*D_b - A_b.*D_a);

s11 = +(D_b.*B_a - D_a.*B_b)./( A_a.*D_b - A_b.*D_a);
s21 = +(D_b.*C_a - D_a.*C_b)./( A_a.*D_b - A_b.*D_a).*exp(-1i*k*a);
s12 = s21;%(-A_b.*B_a + A_a.*B_b)./( A_a.*D_b - A_b.*D_a).*exp(-1i*k*a);%s21;
s22 = s11;% (-A_b.*C_a + A_a.*C_b)./( A_a.*D_b - A_b.*D_a).*exp(-2*1i*k*a);%s11;


%}
%%% COMPUTE TRANSFER MATRIX 
t11 = s21-(s11.*s22./s12);
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
% q_real = real(acos((t11+t22)/2)/a);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q_imag = imag(acos((t11+t22)/2)/a);

%% GRAPHICS 

%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf
%%% p 69
clf
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
ylim([0 p.ff]);

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
%hold on;
plot(p.freq, abs(s11), 'DisplayName', 's11');
hold on;
plot(p.freq, abs(s21), 'DisplayName', 's21');
plot(p.freq, abs(s12), 'DisplayName', 's12');
plot(p.freq, abs(s22), 'DisplayName', 's22');
legend show;
ylim([0,1])
xlabel("Frequency (Hz)")
box on
grid on

%% Other...

%%% T-MATRIX
%{
figure(3);
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
z_11 = (1 + s11)./(1 - s11); % A VERIFIER
z_22 = (1 + s22)./(1 - s22); % A VERIFIER (C'EST PROBABLEMENT FAUX)
z_21 = 2./s21 - 2;
z_12 = 2./s12 - 2;

figure;
plot_bode(f, z_11, 'displayName', 'z (s11)');
plot_bode(f, z_21, 'displayName', 'z (s21)');
plot_bode(f, z_12, 'displayName', 'z (s12)');
plot_bode(f, z_22, 'displayName', 'z (s22)');

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

