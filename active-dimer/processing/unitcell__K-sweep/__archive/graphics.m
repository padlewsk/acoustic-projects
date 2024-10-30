%%
clear all;
close all;
clc;

a = 0.2806;
c0 = 347;
%% FIGURE OPTIONS
close
fig_prop = {'Fontsize',35,'TickLabelInterpreter','latex','LineWidth',5,'ClippingStyle', 'rectangle', 'Layer', 'top'};

window_size = [1500,100, 680, 1000]; %[1000,100, 1200, 1000]
y_shade = [626, 740]; %[min, max]



export_switch = 0;

ff = linspace(150,1200,100); 
%% LOAD DATA
t_list = [0, 0.25, 0.5, 0.75, 1];%linspace(0,1,10+1);%15
cmap = copper(numel(t_list)); % Cell array of colors.6




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
close
figure(1)
ax = gca; % current axes
fig = gcf;
fig.Position = window_size;
set(ax,fig_prop{:});
ax.PositionConstraint = "innerposition";

%
%subplot(1,2,1);
%set(gca,fig_prop{:})
%set(gcf,'position',window_size);
%set(gca,'YTickLabel',[])

hold on
for ii = 1:numel(t_list)
    qq_re = spline(data_lab(:,4,ii),data_lab(:,3,ii),ff); %% interpolate to have data points on ff vector
    qq_im = spline(data_lab(:,2,ii),data_lab(:,1,ii),ff);

    %plot(data_lab(:,3,ii),data_lab(:,4,ii),'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    %plot(data_lab(:,1,ii),data_lab(:,2,ii),'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
    plot(qq_re,ff,'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    plot(qq_im,ff,'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch

    %xlabel("$qa/\pi$",'Interpreter','latex')
    %ylabel("$f$ (Hz)",'Interpreter','latex')
   
    xlim([0 1])
    ylim([0 1200])

    %legend(plt)
    %legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')
    %legend("$\tilde{\delta} = 1.00 \cdot a/4$", "$\tilde{\delta} = 0.75\cdot a/4$", "$\tilde{\delta} = 0.50\cdot a/4$", "$\tilde{\delta} = 0.25\cdot a/4$", "$\tilde{\delta} = 0$",'Interpreter','latex')%,'Location','northeastoutside')
    %title("Dispersion vs t: experiment",'Interpreter','latex')
    
    grid on
    hold on %% must hold on AFTER initial axis is created
end
box on
ShadePloty(y_shade(1), y_shade(2),cmap(5,:),0.2) % area to shade
hold off
%
%Returns handles to the patch and line objects
chi = get(gca, 'Children');
%Reverse the stacking order so that the patch overlays the line
set(gca, 'Children',flipud(chi));
%}
if export_switch
    %set(gcf, 'Color', 'none');
    print(gcf, '-dpdf', './__figures/disp_exp.pdf'); 
%export_fig results_exp.pdf 
end

%%% SU(1,1)-NESS
%%% RUN dimer_config7__main

%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q_re_temp = load('./__data/sim/dimer_config7_3D__q_re.mat');
q_im_temp = load('./__data/sim/dimer_config7_3D__q_im.mat');
f_temp = load('./__data/sim/dimer_config7_3D__f.mat');

q_re = q_re_temp.q_re;
q_im = q_im_temp.q_im;
f = f_temp.f;


%%% DISPERSION
figure(3)
%subplot(1,2,2);
%set(gca,fig_prop{:}); 
%set(gcf,'position',window_size);
%set(gca,'YTickLabel',[])
ax = gca; % current axes
fig = gcf;
set(ax,fig_prop{:})
%ax.YTickLabel= ''
ax.PositionConstraint = "innerposition";
fig.InnerPosition = window_size;



hold on
for ii = flip(1:numel(t_list))
    %q_norm = q_re{ii}; % {1st t_hop value}
    k_norm = real((2*pi*f{ii}/c0*a)/(2*pi));%/fact(hop_list(ii)); %<----- NORMALIZATION
    hop  = t_list(ii).*(k_norm.*0 + 1);
    
    %k_mdl_p = acos(sqrt((1-t_list(ii))^2 + t_list(ii)^2 + 2*(1-t_list(ii))*t_list(ii)*cos(q_re{ii}*a)))/pi;
    %k_mdl_m = acos(-sqrt((1-t_list(ii))^2 + t_list(ii)^2 + 2*(1-t_list(ii))*t_list(ii)*cos(q_re{ii}*a)))/pi;
    qq_re_norm = abs(q_re{ii});
    qq_im_norm = abs(q_im{ii});

    plot(qq_re_norm,f{ii},'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    plot(qq_im_norm,f{ii},'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
    
    %xlabel("$q_Fa/\pi$",'Interpreter','latex')
    %ylabel("$f$ (Hz)",'Interpreter','latex')

    xlim([0 1])
    ylim([0 1200])
    
    legend("$\delta = 1.00 \cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.25\cdot a/4$", "$\delta = 0$",'Interpreter','latex')%,'Location','northeastoutside')
    %title("Dispersion vs t: simulation",'Interpreter','latex')
    box on
    grid on
    hold on %% must hold on AFTER initial axis is created
end

ShadePloty(y_shade(1), y_shade(2),cmap(5,:),0.2) % area to shade
hold off

if export_switch
    print(gcf, '-dpdf', './__figures/disp_sim.pdf'); 
end

%%% SU(1,1)-NESS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

M_11_temp = load('./__data/sim/dimer_config7_3D__M_11.mat');
M_12_temp = load('./__data/sim/dimer_config7_3D__M_12.mat');
M_21_temp = load('./__data/sim/dimer_config7_3D__M_21.mat');
M_22_temp = load('./__data/sim/dimer_config7_3D__M_22.mat');

%%%%%%%%%%%%%%% 
M_11 = M_11_temp.M_11{5};% 5th data is the data with max t_hop
M_12 = M_12_temp.M_12{5};
M_21 = M_21_temp.M_21{5};
M_22 = M_22_temp.M_22{5};
f = f{5};

x_AlphaDelta = M_11 - conj(M_22);
x_BetaGamma = M_21 - conj(M_12);

z_AlphaDelta = (x_AlphaDelta - mean(x_AlphaDelta))./std(x_AlphaDelta); 
%z_AlphaDelta = spline(f,z_AlphaDelta,ff)
z_BetaGamma = (x_BetaGamma  - mean(x_BetaGamma))./std(x_BetaGamma);
%z_BetaGamma = spline(f, z_BetaGamma, ff)

M_11_sqr = real(M_11.*M_11 + M_12.*M_21);
M_12_sqr = real(M_11.*M_12 + M_12.*M_22);
M_21_sqr = real(M_21.*M_11 + M_22.*M_21);
M_22_sqr = real(M_21.*M_12 + M_22.*M_22);

figure(4)
set(gca,fig_prop{:});
set(gcf,'position',window_size);
set(gca,'YTickLabel',[])
hold on
plot(real(z_AlphaDelta),f,'-','color','k', 'LineWidth',4) % real part of q_bloch
plot(imag(z_AlphaDelta),f,'--','color','k', 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
plot(real(z_BetaGamma),f,'-','color','r', 'LineWidth',4) % real part of q_bloch
plot(imag(z_BetaGamma),f,'--','color','r', 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch

%xlabel("",'Interpreter','latex')
%ylabel("$f$ (Hz)",'Interpreter','latex')
xlim([-1 1])
ylim([0 1200])
ShadePloty(y_shade(1), y_shade(2),cmap(5,:),0.2) % area to shade
%legend(plt)
%legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

%legend("$Z_{\alpha\gamma^*}$", "$Z_{\beta\delta^*}$",'Interpreter','latex','Location','northeast')

grid on
hold on %% must hold on AFTER initial axis is created
box on
hold off

if export_switch
    print(gcf, '-dpdf', './__figures/su1_sim.pdf'); 
end

%% simulation 3D
%{

figure(2)
set(gca,fig_prop{:});
set(gcf,'position',[1000,100, 800, 1000]);
%view([-45 30])
view([0 0])
hold on
for ii = 1:numel(t_list)
    %q_norm = q_re{ii}; % {1st t_hop value}
    k_norm = real((2*pi*f{ii}/c0*a)/(2*pi));%/fact(hop_list(ii)); %<----- NORMALIZATION
    hop  = t_list(ii).*(k_norm.*0 + 1);
    
    k_mdl_p = acos(sqrt((1-t_list(ii))^2 + t_list(ii)^2 + 2*(1-t_list(ii))*t_list(ii)*cos(q_re{ii}*a)))/pi;
    k_mdl_m = acos(-sqrt((1-t_list(ii))^2 + t_list(ii)^2 + 2*(1-t_list(ii))*t_list(ii)*cos(q_re{ii}*a)))/pi;

    %plot3(q_norm, hop, k_norm,'o','color',cmap(ii,:))
    
    plot3(abs(q_re{ii}),hop,f{ii},'-','color',cmap(ii,:), 'LineWidth',3) % real part of q_bloch
    plot3(abs(q_im{ii}),hop,f{ii},'--','color',cmap(ii,:), 'LineWidth',3,'HandleVisibility','off') %  part of q_bloch

    
    %{
    plot3(q_norm(1,:),hop(1,:),k_mdl_p(1,:),'-','color',cmap(ii,:),'linewidth',1,'HandleVisibility','off') % band 
    plot3(q_norm(1,:),hop(1,:),k_mdl_m(1,:),'-','color',cmap(ii,:),'linewidth',1,'HandleVisibility','off')
    plot3(q_norm(1,:),hop(1,:),k_mdl_p(1,:)+1,'-','color',cmap(ii,:),'linewidth',1,'HandleVisibility','off')
    plot3(q_norm(1,:),hop(1,:),k_mdl_m(1,:)+1,'-','color',cmap(ii,:),'linewidth',1,'HandleVisibility','off')
    %}
    xlabel("$qa/\pi$",'Interpreter','latex')
    ylabel("$t$",'Interpreter','latex')
    zlabel("$f$ (Hz)",'Interpreter','latex')
   
    
    xlim([0 1])
    zlim([0 1200])
    %zlim([0 2])
    
    %legend(plt)
    %legend("$t_{h} = $ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')
    %title("Dispersion vs t: simulation",'Interpreter','latex')
    box on
    %grid on
    hold on %% must hold on AFTER initial axis is created
end

hold off

%export_fig results_sim.pdf -transparent
%}

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
%%% DISPERSION
Mms = 5.5E-4*0.5;
Rms = 0.34*0.09;
Cmc = 1.750252936794995E-4/0.42 ;
Sd = 12E-4;% m^2 diaphragm surface *)
S = 0.05*0.05; %  m^2 duct cross section*)
rho0 = 1.184;%[kg/m^3]*)
c0 = 346; %[m/s]*)
a = 0.2806;%[m]*)

figure(5)
%set(gca,fig_prop{:});
%set(gcf,'position',[1500, 100, 775, 1020]);
%set(gcf,'position',window_size);
%set(gca,'YTickLabel',[])
ax = gca; % current axes
fig = gcf;
fig.Position = window_size;
set(ax,fig_prop{:});
ax.PositionConstraint = "outerposition";

hold on
for ii = flip(1:numel(t_list))
    freq = 1:1200;
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

    plot(qq_re*a/pi,freq,'-','color',cmap(flip(ii),:), 'LineWidth',4) % real part of q_bloch
    plot(qq_im*a/pi,freq,'--','color',cmap(flip(ii),:), 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
    
    xlabel("$q_Fa/\pi$",'Interpreter','latex')
    ylabel("$f$ (Hz)",'Interpreter','latex')
    
    xlim([0 1])
    ylim([0 1200])
 
   legend("$\delta = 1.00 \cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.25\cdot a/4$", "$\delta = 0$",'Interpreter','latex')%,'Location','northeastoutside')

    grid on
    hold on %% must hold on AFTER initial axis is created
end
box on
ShadePloty(y_shade(1), y_shade(2), cmap(5,:),0.2) % area to shade
hold off
if export_switch
    print(gcf, '-dpdf', './__figures/disp_ana.pdf'); 
end

%%% SU(1,1)-NESS
freq = 1:1200;
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

figure(6)
%set(gca,fig_prop{:});
%set(gcf,'position',[1500, 100, 775, 1020]);
%set(gca,'YTickLabel',[])
ax = gca; % current axes
fig = gcf;
fig.Position = window_size;
set(ax,fig_prop{:});
ax.PositionConstraint = "outerposition";

hold on
plot(real(z_AlphaDelta),freq,'-','color','k', 'LineWidth',4) % real part of q_bloch
plot(imag(z_AlphaDelta),freq,'--','color','k', 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch
plot(real(z_BetaGamma),freq,'-','color','r', 'LineWidth',4) % real part of q_bloch
plot(imag(z_BetaGamma),freq,'--','color','r', 'LineWidth',4,'HandleVisibility','off') %  part of q_bloch

ShadePloty(y_shade(1), y_shade(2),cmap(5,:),0.2) % area to shade

xlabel("",'Interpreter','latex')
ylabel("$f$ (Hz)",'Interpreter','latex')
xlim([-1 1])
ylim([0 1200])

%legend(plt)
%legend("$t_{h} =$ " + string(round(t_list,2)),'Interpreter','latex')%,'Location','northeastoutside')

legend("$Z_{\alpha\gamma^*}$", "$Z_{\beta\delta^*}$",'Interpreter','latex','Location','northeast')

grid on
hold on %% must hold on AFTER initial axis is created
box on
hold off

if export_switch
    print(gcf, '-dpdf', './__figures/su1_ana.pdf'); 
end

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
