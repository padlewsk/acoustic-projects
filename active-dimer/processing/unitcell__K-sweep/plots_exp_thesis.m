%
clear all; %%% TEMP
close all;
clc;
%}
addpath('./__fun')
addpath('./__data')
%% FIGURE PARAMETERS
f = fig_params_thesis;
s = sys_params;

spline_freq = linspace(150,1200,100); 

%% LOAD DATA
%t_list = [0, 0.25, 0.5, 0.75, 1];
t_list = [0];
cmap = flipud(copper(numel(t_list))); % Cell array of colors.6

%% EXPERIMENTAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% GET DATA FROM FIGURES
%{
fig_file_name= ["disp__t_0.fig","disp__t_0p25.fig","disp__t_0p5.fig","disp__t_0p75.fig","disp__t_1.fig"];

data_lab=[];
for ii = 1:length(fig_file_name)
    fig=openfig(fig_file_name(ii));
    dataObjsY = findobj(fig,'-property','YData');
    y1 = dataObjsY(3).YData;
    y2 = dataObjsY(4).YData;
    dataObjsX = findobj(fig,'-property','XData');
    x1 = dataObjsX(3).XData;
    x2 = dataObjsX(4).XData;
    %
    %Re(q_floquet)
    data_lab(:,1,ii)=x1'; %freq
    data_lab(:,2,ii)=y1'; 

    %Im(q_floquet)
    data_lab(:,3,ii)=x2'; %freq
    data_lab(:,4,ii)=y2';
    close
end

%save('data_lab.mat','data_lab');

data_lab = load('./__data/sim/data_lab.mat'); %struct
data_lab = data_lab.data_lab; % matrix
%}

data_lab = load('./__data/exp/data_lab.mat'); %struct
data_lab = data_lab.data_lab; % matrix

%%% DISPERSION
figure()
set(gcf,'position',f.window_size);
set(gca,f.fig_prop{:}); %%% UNCOMMENT WHEN RUNNING PLOTS MAIN 
%set(gca,'YTickLabel',[]);


hold on
for ii = flip(1:numel(t_list))
    qq_re = spline(data_lab(:,4,ii),data_lab(:,3,ii),spline_freq); %% interpolate to have data points on ff vector
    qq_im = spline(data_lab(:,2,ii),data_lab(:,1,ii),spline_freq);

    %plot(data_lab(:,3,ii),data_lab(:,4,ii),'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    %plot(data_lab(:,1,ii),data_lab(:,2,ii),'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
    plot(qq_re,spline_freq/1000,'-','color',cmap(ii,:), 'LineWidth',f.line_width) % real part of q_bloch
    plot(qq_im/1.3,spline_freq/1000,'--','color',cmap(ii,:), 'LineWidth',f.line_width)%,'HandleVisibility','off') %  part of q_bloch

    xlabel("q_F a/\pi")
    ylabel("Frequency (kHz)")
   
    xlim([0 1])
    ylim([0 1.200])

    %legend(plt)
    %legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')
    %legend("$\delta = 1.00 \cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.25\cdot a/4$", "$\delta = 0$",'Interpreter','latex')%,'Location','northeastoutside')
    %legend("$\delta = 0$","$\delta = 0.25 \cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 1.00\cdot a/4$",'Interpreter','latex')
    legend("Real","Complex")
    %title("Dispersion vs t: experiment",'Interpreter','latex')
    
    grid on
    hold on %% must hold on AFTER initial axis is created
end
box on
%ShadePloty(f.box_shade(1), f.box_shade(2),cmap(1,:),0.2) % area to shade
hold off
%
%Returns handles to the patch and line objects
%chi = get(gca, 'Children');
%Reverse the stacking order so that the patch overlays the line
%set(gca, 'Children',flipud(chi));
%}
if f.export_switch
    print(gcf, '-dpdf', './__figures/disp_exp.pdf'); 
    %matlab2tikz('./__figures/disp_exp.tex',f.tikz_prop{:});
end

%% SU(1,1)-NESS 
%{
k = 2*pi*s.freq/s.c0; %+ 70%corresponding wave vector

l1 = s.x2 - s.offset; %distance between left edge of specimen and mic 2 (c.f. 20220629 notes)
l2 = s.x3 - s.offset ; %distance between left edge of specimen and mic 3
s1 = abs(s.x2-s.x1); %mic separation
s2 = abs(s.x4-s.x3);%mic separation

%%% SYMMETRIC CASE
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

%%% ASYMMETRIC CASE
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

%%% STANDARD SCORE or Z-SCORE (number of standard deviations by which the value of a raw score is above or below the mean value)
x_AlphaDelta = M_11 - conj(M_22);
x_BetaGamma = M_21 - conj(M_12);
z_AlphaDelta = (x_AlphaDelta - mean(x_AlphaDelta))./std(x_AlphaDelta);
z_AlphaDelta = spline(s.freq,z_AlphaDelta,spline_freq);
z_BetaGamma = (x_BetaGamma  - mean(x_BetaGamma))./std(x_BetaGamma);
z_BetaGamma = spline(s.freq, z_BetaGamma,spline_freq);


%M_11_sqr = real(M_11.*M_11 + M_12.*M_21);
%M_12_sqr = real(M_11.*M_12 + M_12.*M_22);
%M_21_sqr = real(M_21.*M_11 + M_22.*M_21);
%M_22_sqr = real(M_21.*M_12 + M_22.*M_22);

figure()
    set(gcf,'position',f.window_size);
    set(gca,f.fig_prop{:},'position',ref_pos_su1); 
    set(gca,'YTickLabel',[]);
    hold on
    
    plot(real(z_AlphaDelta),spline_freq,'-','color','k', 'LineWidth',f.line_width) % real part of q_bloch
    plot(imag(z_AlphaDelta),spline_freq,'--','color','k', 'LineWidth',f.line_width,'HandleVisibility','off') %  part of q_bloch
    plot(real(z_BetaGamma),spline_freq,'-','color','r', 'LineWidth',f.line_width) % real part of q_bloch
    plot(imag(z_BetaGamma),spline_freq,'--','color','r', 'LineWidth',f.line_width,'HandleVisibility','off') %  part of q_bloch


    
    xlabel("Standard score",'Interpreter','latex')
    %ylabel("$f$ (Hz)",'Interpreter','latex')
    
    xlim([-1 1])
    ylim([0 1200])
    ShadePloty(f.box_shade(1), f.box_shade(2),cmap(1,:),0.2) % area to shade
    %legend(plt)
    %legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

    %legend("$(\alpha -\gamma^*)/|\alpha +\gamma^*|$", "$(\beta -\delta^*)/|\beta +\delta^*|$",'Interpreter','latex','Location','northeast')
    %legend("$Z_{\alpha\gamma^*}$", "$Z_{\beta\delta^*}$",'Interpreter','latex','Location','northeast')
    grid on
    hold on %% must hold on AFTER initial axis is created
    box on
    hold off
if f.export_switch   
    print(gcf, '-dpdf', './__figures/su1_exp.pdf');
    matlab2tikz('./__figures/su1_exp.tex',f.tikz_prop{:});
end
%}