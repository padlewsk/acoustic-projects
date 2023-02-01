%% PARAMETERS
addpath('./__fun')
f = fig_params;
s = sys_params;

spline_freq = linspace(1,1200,100); 

c0 = s.c0;
a = s.a;

t_list = [0, 0.25, 0.5, 0.75, 1];
cmap = flipud(copper(numel(t_list))); % Cell array of colors.6
%% ANALYTICAL 1
%{

figure(3)
set(gca,fig_prop{:});
%set(gcf,'position',[1500,100, 800, 1000]);
set(gcf,'position',[1000,100, 1200, 1000]); 
hold on
for ii = flip(1:numel(t_list))
    
%     qq_re = abs(real(q_ana(2*pi*ff/c0, t_list(ii))));
%     qq_im = abs(imag(q_ana(2*pi*ff/c0, t_list(ii))));
    
    

    qq_re1 = abs(real(q_ana(2*pi*ff/c0, t_list(ii))));
    qq_im = abs(imag(q_ana(2*pi*ff/c0, t_list(ii))));

    

    plot(qq_re1*a/pi,ff,'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    plot(qq_im*a/pi,ff,'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch

    
    %plot(data_lab(:,3,ii),data_lab(:,4,ii),'-','color',cmap(flip(ii),:), 'LineWidth',3) % real part of q_bloch
    %plot(data_lab(:,1,ii),data_lab(:,2,ii),'--','color',cmap(flip(ii),:), 'LineWidth',3,'HandleVisibility','off') %  part of q_bloch

    
    xlabel("$q_Fa/\pi$",'Interpreter','latex')

    ylabel("$f$ (Hz)",'Interpreter','latex')
   
    
    xlim([0 1])
    ylim([0 1200])

    
    %legend(plt)
    %legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')
    
    legend("$\tilde{\delta} = 1.00 \cdot a/4$", "$\tilde{\delta} = 0.75\cdot a/4$", "$\tilde{\delta} = 0.50\cdot a/4$", "$\tilde{\delta} = 0.25\cdot a/4$", "$\tilde{\delta} = 0$",'Interpreter','latex')%,'Location','northeastoutside')
    %title("Dispersion vs t: experiment",'Interpreter','latex')
    
    
    grid on
    hold on %% must hold on AFTER initial axis is created
end
box on
hold off

%export_fig results_ana.pdf -transparent
%}

%% ANALYTICAL 2
%%% PHYSICS 
Mms = 5.5E-4*0.5;
Rms = 0.34*0.09;
Cmc = 1.750252936794995E-4/0.42 ;
Sd = 12E-4;% m^2 diaphragm surface *)
S = 0.05*0.05; %  m^2 duct cross section*)
rho0 = 1.184;%[kg/m^3]*)
c0 = 346; %[m/s]*)
a = 0.2806;%[m]*)

%%% DISPERSION
figure()
set(gca,f.fig_prop{:});
set(gcf,'position',f.window_size);
%set(gca,'YTickLabel',[])


hold on
for ii = 1:numel(t_list)
    freq = spline_freq;
    k = 2*pi*freq/c0;
    
    delta = a/4*t_list(ii);

    w = (c0*rho0*Sd^2/(2*S))./((1i*2*pi*freq)*Mms + Rms + 1./((1i*2*pi*freq)*Cmc));
    
    %%% TRANSFER MATRIX 
    M_11 = exp(-1i*a*k).*(w-1).^2 - w.^2.*exp(1i*2*delta*k);
    M_12 = exp(-1i*a*k/2).*w.*(w-1) - w.*(1+w).*exp(1i*(a/2+2*delta)*k);
    M_21 = exp(1i*a*k/2).*w.*(w+1) - w.*(-1+w).*exp(-1i*(a/2+2*delta)*k);
    M_22 = exp(+1i*a*k).*(1+w).^2 - w.^2.*exp(-1i*2*delta*k);
    
    qq = acos((M_11 + M_22)/2)/a; % = acos(w.^2.*(cos(k*a)-cos(k*2*delta)) + 2*w*1i.*sin(k*a)+cos(k*a))/a
   
    qq_re = abs(real(qq));
    qq_im = abs(imag(qq));

    plot(qq_re*a/pi,freq/1000,'-','color',cmap(ii,:), 'LineWidth',f.line_width) % real part of q_bloch
    plot(qq_im*a/pi,freq/1000,'--','color',cmap(ii,:), 'LineWidth',f.line_width,'HandleVisibility','off') %  part of q_bloch
    
    xlabel("$q_Fa/\pi$",'Interpreter','latex')
    ylabel("$f$ (kHz)",'Interpreter','latex')
    
    xlim([0 1])
    ylim([0 1.2])
 
    %legend("$\delta = 1.00 \cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.25\cdot a/4$", "$\delta = 0$",'Interpreter','latex')%,'Location','northeastoutside')
    legend("$\delta = 0$","$\delta = 0.25 \cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 1.00\cdot a/4$",'Interpreter','latex')
    grid on
    hold on %% must hold on AFTER initial axis is created
end
box on
ShadePloty(f.box_shade(1)/1000, f.box_shade(2)/1000, cmap(1,:),0.2) % area to shade
hold off

if f.export_switch
    print(gcf, '-dpdf', './__figures/disp_ana.pdf');
    matlab2tikz('./__figures/disp_ana.tex',f.tikz_prop{:});
end

ref_pos_disp = get(gca,'position') %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% SU(1,1)-NESS 
freq = spline_freq;%1:1200;
k = 2*pi*freq/c0;
t_hop = 1; %%% SETTING AT MAX COUPLING
delta = a/4*t_hop;

w = (c0*rho0*Sd^2/(2*S))./((1i*2*pi*freq)*Mms + Rms + 1./((1i*2*pi*freq)*Cmc));

%%% TRANSFER MATRIX 
M_11 = exp(-1i*a*k).*(w-1).^2 - w.^2.*exp(1i*2*delta*k);
M_12 = exp(-1i*a*k/2).*w.*(w-1) - w.*(1+w).*exp(1i*(a/2+2*delta)*k);
M_21 = exp(1i*a*k/2).*w.*(w+1) - w.*(-1+w).*exp(-1i*(a/2+2*delta)*k);
M_22 = exp(+1i*a*k).*(1+w).^2 - w.^2.*exp(-1i*2*delta*k);

x_AlphaDelta = M_11 - conj(M_22);
x_BetaGamma = M_21 - conj(M_12);
z_AlphaDelta = (x_AlphaDelta - mean(x_AlphaDelta))./std(x_AlphaDelta); 
z_BetaGamma = (x_BetaGamma  - mean(x_BetaGamma))./std(x_BetaGamma);
M_11_sqr = real(M_11.*M_11 + M_12.*M_21);
M_12_sqr = real(M_11.*M_12 + M_12.*M_22);
M_21_sqr = real(M_21.*M_11 + M_22.*M_21);
M_22_sqr = real(M_21.*M_12 + M_22.*M_22);

figure()
set(gca,f.fig_prop{:});
set(gcf,'position',f.window_size);
%set(gca,'YTickLabel',[])

hold on
plot(real(z_AlphaDelta),freq/1000,'-','color','k', 'LineWidth',f.line_width) % real part of q_bloch
plot(imag(z_AlphaDelta),freq/1000,'--','color','k', 'LineWidth',f.line_width,'HandleVisibility','off') %  part of q_bloch
plot(real(z_BetaGamma),freq/1000,'-','color','r', 'LineWidth',f.line_width) % real part of q_bloch
plot(imag(z_BetaGamma),freq/1000,'--','color','r', 'LineWidth',f.line_width,'HandleVisibility','off') %  part of q_bloch

ShadePloty(f.box_shade(1)/1000, f.box_shade(2)/1000,cmap(1,:),0.2) % area to shade

xlabel("Standard score",'Interpreter','latex')
ylabel("$f$ (kHz)",'Interpreter','latex')
xlim([-1 1])
ylim([0 1.2])

%legend(plt)
%legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

legend("$Z_{\alpha\gamma^*}$", "$Z_{\beta\delta^*}$",'Interpreter','latex','Location','northeast')

grid on
hold on %% must hold on AFTER initial axis is created
box on
hold off

if f.export_switch
    print(gcf, '-dpdf', './__figures/su1_ana.pdf');
    matlab2tikz('./__figures/su1_ana.tex',f.tikz_prop{:});
end


ref_pos_su1 = get(gca,'position') %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
figure(6)
set(gca,fig_prop{:});
set(gcf,'position',window_size);
set(gca,'YTickLabel',[])
hold on
plot(M_11_sqr,freq,'-', 'LineWidth',4) % real part of q_bloch
plot(M_12_sqr,freq,'-', 'LineWidth',4) %  part of q_bloch
plot(M_21_sqr,freq,'-', 'LineWidth',4) % real part of q_bloch
plot(M_22_sqr,freq,'-', 'LineWidth',4) %  part of q_bloch

ShadePloty(y_shade(1), y_shade(2),cmap(5,:),0.2) % area to shade

%xlabel("",'Interpreter','latex')
%ylabel("$f$ (Hz)",'Interpreter','latex')
xlim([0 1.5])
ylim([0 1200])

%legend(plt)
%legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

legend("a","b","c","d",'Interpreter','latex','Location','northeast')

grid on
hold on %% must hold on AFTER initial axis is created
box on
hold off
%}

%{
figure(5)
set(gca,fig_prop{:});
%set(gcf,'position',[1500,100, 800, 1000]);
set(gcf,'position',[1000,100, 1200, 1000]); 
hold on
for ii = flip(1:numel(t_list))
    
    
    freq = 1:1200;
    k = 2*pi*freq/c0;
    t_hop = 1;
     delta = a/4*t_list(ii);


    w = (c0*rho0*Sd^2/(2*S))./((1i*2*pi*freq)*Mms + Rms + 1./((1i*2*pi*freq)*Cmc));

    %%% TRANSFER MATRIX 
    M_11 = exp(-1i*a*k).*(w-1).^2 - w.^2.*exp(1i*2*delta*k);
    M_12 = exp(-1i*a*k/2).*w.*(w-1) - w.*(1+w).*exp(1i*(a/2+2*delta)*k);
    M_21 = exp(1i*a*k/2).*w.*(w+1) - w.*(-1+w).*exp(-1i*(a/2+2*delta)*k);
    M_22 = exp(+1i*a*k).*(1+w).^2 - w.^2.*exp(-1i*2*delta*k);



    AlphaDelta = (M_11 - conj(M_22))./abs(M_11 + conj(M_22)); % = acos(w.^2.*(cos(k*a)-cos(k*2*delta)) + 2*w*1i.*sin(k*a)+cos(k*a))/a
    BetaGamma = (M_12 - conj(M_21))./abs(M_12 + conj(M_12));



    plot(real(AlphaDelta),freq,'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    plot(imag(AlphaDelta),freq,'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
    plot(real(BetaGamma),freq,'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    plot(imag(BetaGamma),freq,'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch


    %plot(data_lab(:,3,ii),data_lab(:,4,ii),'-','color',cmap(flip(ii),:), 'LineWidth',3) % real part of q_bloch
    %plot(data_lab(:,1,ii),data_lab(:,2,ii),'--','color',cmap(flip(ii),:), 'LineWidth',3,'HandleVisibility','off') %  part of q_bloch


    xlabel("",'Interpreter','latex')
    ylabel("$f$ (Hz)",'Interpreter','latex')
    xlim([-1 1])
    ylim([0 1200])

    %legend(plt)
    %legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

    legend("$(\alpha -\gamma^*)/|\alpha +\gamma^*|$", "$(\beta -\delta^*)/|\beta +\delta^*|$",'Interpreter','latex')%,'Location','northeastoutside')

    grid on
    hold on %% must hold on AFTER initial axis is created
end
box on
hold off
%}