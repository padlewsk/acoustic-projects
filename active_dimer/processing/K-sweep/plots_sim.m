
%close

%% PARAMETERS
addpath('./__fun')
f = fig_params;
s = sys_params;
spline_freq = linspace(1,1200,100); 

c0 = s.c0;
a = s.a;

t_list = [0, 0.25, 0.5, 0.75, 1];
cmap = flipud(copper(numel(t_list)));  % Cell array of colors.6

%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q_re_temp = load('./__data/sim/dimer_config7_3D__q_re.mat');
q_im_temp = load('./__data/sim/dimer_config7_3D__q_im.mat');
f_temp = load('./__data/sim/dimer_config7_3D__f.mat');

q_re = q_re_temp.q_re;
q_im = q_im_temp.q_im;
freq = f_temp.f;


%%% DISPERSION
figure()
%subplot(1,2,2);
set(gcf,'position',f.window_size);
set(gca,f.fig_prop{:},'position',ref_pos_disp); 
set(gca,'YTickLabel',[]);

hold on
for ii = 1:numel(t_list)
    %q_norm = q_re{ii}; % {1st t_hop value}
    k_norm = real((2*pi*freq{ii}/c0*a)/(2*pi));%/fact(hop_list(ii)); %<----- NORMALIZATION
    hop  = t_list(ii).*(k_norm.*0 + 1);
    
    %k_mdl_p = acos(sqrt((1-t_list(ii))^2 + t_list(ii)^2 + 2*(1-t_list(ii))*t_list(ii)*cos(q_re{ii}*a)))/pi;
    %k_mdl_m = acos(-sqrt((1-t_list(ii))^2 + t_list(ii)^2 + 2*(1-t_list(ii))*t_list(ii)*cos(q_re{ii}*a)))/pi;
    qq_re_norm = abs(q_re{ii});
    qq_im_norm = abs(q_im{ii});

    plot(qq_re_norm,freq{ii},'-','color',cmap(ii,:), 'LineWidth',f.line_width) % real part of q_bloch
    plot(qq_im_norm,freq{ii},'--','color',cmap(ii,:), 'LineWidth',f.line_width,'HandleVisibility','off') %  part of q_bloch
    
    xlabel("$q_F a/\pi$",'Interpreter','latex')
    %ylabel("$f$ (Hz)",'Interpreter','latex')

    xlim([0 1])
    ylim([0 1200])
    
    
    %legend("$\tilde{\delta} = 1.00 \cdot a/4$", "$\tilde{\delta} = 0.75\cdot a/4$", "$\tilde{\delta} = 0.50\cdot a/4$", "$\tilde{\delta} = 0.25\cdot a/4$", "$\tilde{\delta} = 0$",'Interpreter','latex')%,'Location','northeastoutside')
    %legend("$\delta = 0$","$\delta = 0.25 \cdot a/4$", "$\delta = 0.50\cdot a/4$", "$\delta = 0.75\cdot a/4$", "$\delta = 1.00\cdot a/4$",'Interpreter','latex')
    %title("Dispersion vs t: simulation",'Interpreter','latex')
    box on
    grid on
    hold on %% must hold on AFTER initial axis is created
end

ShadePloty(f.box_shade(1), f.box_shade(2),cmap(1,:),0.2) % area to shade
hold off

if f.export_switch
    print(gcf, '-dpdf', './__figures/disp_sim.pdf'); 
    matlab2tikz('./__figures/disp_sim.tex',f.tikz_prop{:});
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
freq = freq{5};

x_AlphaDelta = M_11 - conj(M_22);
x_BetaGamma = M_21 - conj(M_12);

z_AlphaDelta = (x_AlphaDelta - mean(x_AlphaDelta))./std(x_AlphaDelta); 
z_AlphaDelta = spline(freq,z_AlphaDelta,spline_freq);
z_BetaGamma = (x_BetaGamma  - mean(x_BetaGamma))./std(x_BetaGamma);
z_BetaGamma = spline(freq, z_BetaGamma, spline_freq);

M_11_sqr = real(M_11.*M_11 + M_12.*M_21);
M_12_sqr = real(M_11.*M_12 + M_12.*M_22);
M_21_sqr = real(M_21.*M_11 + M_22.*M_21);
M_22_sqr = real(M_21.*M_12 + M_22.*M_22);

figure()

set(gcf,'position',f.window_size);
set(gca,f.fig_prop{:},'position',ref_pos_su1);
set(gca,'YTickLabel',[])

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

%legend("$Z_{\alpha\gamma^*}$", "$Z_{\beta\delta^*}$",'Interpreter','latex','Location','northeast')

grid on
hold on %% must hold on AFTER initial axis is created
box on
hold off

if f.export_switch
    print(gcf, '-dpdf', './__figures/su1_sim.pdf');
    matlab2tikz('./__figures/su1_sim.tex','width',f.tikz_prop{:});
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
