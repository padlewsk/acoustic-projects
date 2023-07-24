function params = fig_params()
    params = struct;

    %%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% RMK: Manually update the asterixed parameters after running either
    
    %% PHYSICS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    params.c0 = 347.13; % 300K
    params.rho0 = 1.1839;
    params.Zc = params.c0*params.rho0; % characteristic specific acoustic impedence at 300K
    params.a = 0.2806;
    %% FIGURE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$
    
    %params.pos = [0.2520    0.1100    0.6530    0.8150];%[left bottom width height]%this is the axis size that is the same as the analytical plot WITH axis (pos=get(gca,'position'))
    params.line_width = 2; %tikzs size in pt
    params.fig_prop = {'Fontsize',35,'TickLabelInterpreter','latex','LineWidth', params.line_width+1,'ClippingStyle', 'rectangle', 'Layer', 'top'};
    params.window_size = [0, 0, 800, 1000]; %[left bottom width height] [1500, 100, 680, 1000]
    params.box_shade = [626, 740]; %[min, max]
    params.export_switch = 1;
    params.tikz_prop = {'height','1.75\textwidth','width','1\textwidth','interpretTickLabelsAsTex',true};

end