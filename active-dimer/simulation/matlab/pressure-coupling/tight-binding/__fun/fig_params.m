function param = fig_params()
%param = struct;

%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RMK: Manually update the asterixed parameters after running either

%% FIGURE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$

%params.pos = [0.2520    0.1100    0.6530    0.8150];%[left bottom width height]%this is the axis size that is the same as the analytical plot WITH axis (pos=get(gca,'position'))
param.line_width = 1; %tikzs size in pt
%param.fig_prop = {'Fontsize',25,'LineWidth', param.line_width+1,'ClippingStyle', 'rectangle', 'Layer', 'top'};
param.fig_prop = {'Fontsize',25,'LineWidth', param.line_width+1,'Layer', 'Top'}
param.window_size = [0, 0, 800,600]; %[left bottom width height] [1500, 100, 680, 1000]  
end
