%%% EXPERIMENTAL DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
addpath('./__fun');
addpath('./__data/exp/Copy_of_smatrix_data_t_1');
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = sys_params();

k = 2*pi*s.freq/s.c0; %+ 70%corresponding wave vector
%N = length(k);



%%% MICROPHONE POSITION (wrt to edge of unit cell)
% l1 = abs(-x2-a/2);
% l2 = abs(x3+a/2);
% s1 = abs(x2-x1);
% s2 = abs(x4-x3);

l1 = s.x2 - s.offset; %distance between left edge of specimen and mic 2 (c.f. 20220629 notes)
l2 = s.x3 - s.offset ; %distance between left edge of specimen and mic 3
s1 = abs(s.x2-s.x1); %mic separation
s2 = abs(s.x4-s.x3);%mic separation

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

%
load('H21_corr.mat');
load('H31_corr.mat');
load('H41_corr.mat');

H11_a = ones(s.N,1);
H21_a = load('H21_a.mat').H21_a.*H21_corr;
H31_a = load('H31_a.mat').H31_a.*H31_corr;
H41_a = load('H41_a.mat').H41_a.*H41_corr;

A = 1i*(H11_a.*exp(1i*k*l1) - H21_a.*exp(1i*k*(l1-s1)))./(2*sin(k*s1));
B = 1i*(H21_a.*exp(-1i*k*(l1-s1)) - H11_a.*exp(-1i*k* l1))./(2*sin(k*s1));
C = 1i*(H31_a.*exp(+1i*k*(l2+s2)) - H41_a.*exp(+1i*k*l2))./(2*sin(k*s2));
D = 1i*(H41_a.*exp(-1i*k*l2) - H31_a.*exp(-1i*k*(l2+s2)))./(2*sin(k*s2));

s11 = (A.*B-C.*D)./(A.^2-D.^2.*exp(2*1i*k*s.a));
s12 = (A.*C.*exp(-1i*k*s.a) - B.*D.*exp(1i*k*s.a))./(A.^2-D.^2.*exp(2*1i*k*s.a));
s22 = s11;
s21 = s12;

%}

%% ASYMMETRIC CASE
%{
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
M_11 = s21-(s11.*s22./s12);
M_12 = s22./s12;
M_21 = -s11./s12;
M_22 = 1./s12;

%%% COMPUTE FLOQUET-BLOCH WAVE VECTOR q:
%%% General solutions \pm
%
for ii = 1:s.N
    T = [M_11(ii),M_12(ii);M_21(ii),M_22(ii)];
    q = log(0.5*(trace(T) - sqrt(trace(T)^2-4*det(T))))/(1i*s.a);
    %q = log(0.5*(trace(T) - sqrt(trace(T)^2-4*det(T))))/(1i*a);
    
    q_real(ii) = real(q);
    q_imag(ii) = imag(q);
end
%}
%%% If reciprocal, the eigensolutions are the same and can be simplified:
% q_real = real(acos((t11+t22)/2)/a);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% q_imag = imag(acos((t11+t22)/2)/a);

%% GRAPHICS 

ff = linspace(150,1200,100); %%% interpolate on this vector

%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf
%%% p 69
clf
%%% DISPERSION 
figure(1);
hold on
plot(abs(q_real)*s.a/pi,s.freq,'-r','LineWidth',3)
plot(abs(q_imag)*s.a/pi,s.freq,'-k','LineWidth',3)
plot(k*s.a/pi,s.freq,'-b','LineWidth',1)
plot(2-k*s.a/pi,s.freq,'-b','LineWidth',1)

hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%yline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%yline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([0 1]);
ylim([0 s.ff]);

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
plot(s.freq, abs(s11), 'DisplayName', 's11');
hold on;
plot(s.freq, abs(s21), 'DisplayName', 's21');
plot(s.freq, abs(s12), 'DisplayName', 's12');
plot(s.freq, abs(s22), 'DisplayName', 's22');
legend show;
ylim([0,1])
xlabel("Frequency (Hz)")
box on
grid on

%% STANDARD SCORE or Z-SCORE (number of standard deviations by which the value of a raw score is above or below the mean value)
x_AlphaDelta = M_11 - conj(M_22);
x_BetaGamma = M_21 - conj(M_12);
z_AlphaDelta = (x_AlphaDelta - mean(x_AlphaDelta))./std(x_AlphaDelta);
z_AlphaDelta = spline(s.freq,z_AlphaDelta,ff)
z_BetaGamma = (x_BetaGamma  - mean(x_BetaGamma))./std(x_BetaGamma);
z_BetaGamma = spline(s.freq, z_BetaGamma, ff)


%M_11_sqr = real(M_11.*M_11 + M_12.*M_21);
%M_12_sqr = real(M_11.*M_12 + M_12.*M_22);
%M_21_sqr = real(M_21.*M_11 + M_22.*M_21);
%M_22_sqr = real(M_21.*M_12 + M_22.*M_22);

figure(3)
    fig_prop = {'Fontsize',35,'TickLabelInterpreter','latex','LineWidth',5,'ClippingStyle', 'rectangle', 'Layer', 'top'};
    window_size = [1500,100, 680, 1000]; %[1000,100, 1200, 1000]
    y_shade = [626, 740]; %[min, max]
    t_list = [0, 0.25, 0.5, 0.75, 1];%linspace(0,1,10+1);%15
    cmap = copper(numel(t_list)); % Cell array of colors.6
    set(gca,fig_prop{:});
    set(gcf,'position',window_size);
    set(gca,'YTickLabel',[])
    hold on
    
    plot(real(z_AlphaDelta),ff,'-','color','k', 'LineWidth',4) % real part of q_bloch
    plot(imag(z_AlphaDelta),ff,'--','color','k', 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
    plot(real(z_BetaGamma),ff,'-','color','r', 'LineWidth',4) % real part of q_bloch
    plot(imag(z_BetaGamma),ff,'--','color','r', 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch


    %xlabel("",'Interpreter','latex')
    %ylabel("$f$ (Hz)",'Interpreter','latex')
    xlim([-1 1])
    ylim([0 1200])
    ShadePloty(y_shade(1), y_shade(2),cmap(5,:),0.2) % area to shade
    %legend(plt)
    %legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

    %legend("$(\alpha -\gamma^*)/|\alpha +\gamma^*|$", "$(\beta -\delta^*)/|\beta +\delta^*|$",'Interpreter','latex','Location','northeast')
    legend("$Z_{\alpha\gamma^*}$", "$Z_{\beta\delta^*}$",'Interpreter','latex','Location','northeast')
    grid on
    hold on %% must hold on AFTER initial axis is created
    box on
    hold off
    print(gcf, '-dpdf', './__figures/su1_exp.pdf');


%% Other...
%clf
%%% T-MATRIX
%qq_re = spline(data_lab(:,4,ii),data_lab(:,3,ii),ff); 
figure(4);
subplot(2,1,1);
%hold on;
plot(s.freq, abs(M_11), 'DisplayName', 'M_{11}');
hold on;
plot(s.freq, abs(M_12), 'DisplayName', 'M_{21}');
plot(s.freq, abs(M_21), 'DisplayName', 'M_{12}');
plot(s.freq, abs(M_22), 'DisplayName', 'M_{22}');
legend show;
grid on

subplot(2,1,2);
plot(s.freq, angle(M_11), 'DisplayName', 'M_{11}');
hold on
plot(s.freq, angle(M_21), 'DisplayName', 'M_{21}');
plot(s.freq, angle(M_12), 'DisplayName', 'M_{12}');
plot(s.freq, angle(M_22), 'DisplayName', 'M_{22}');
legend show;
grid on
%}
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
figure(5);
subplot(2,1,1);
%hold on;
plot(p.freq, abs(s11), 'DisplayName', 's11');
hold on;
plot(p.freq, abs(s21), 'DisplayName', 's21');
plot(p.freq, abs(s12), 'DisplayName', 's12');
plot(p.freq, abs(s22), 'DisplayName', 's22');
legend show;
grid on

subplot(2,1,2);
plot(p.freq, angle(s11), 'DisplayName', 's11');
hold on
plot(p.freq, angle(s21), 'DisplayName', 's21');
plot(p.freq, angle(s12), 'DisplayName', 's12');
plot(p.freq, angle(s22), 'DisplayName', 's22');
legend show;
grid on
%}

