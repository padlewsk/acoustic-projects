function param = fig_params_thesis()
%param = struct;

%%% LIST OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RMK: Manually update the asterixed parameters after running either

%% FIGURE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$

param.line_width = 2; %tikzs size in pt
param.fig_prop = {'Fontsize',25,'LineWidth', param.line_width};%,'Layer', 'Top'}
param.window_size = [0, 0, 600,800]; %[left bottom width height] [1500, 100, 680, 1000]
param.box_shade = [626, 740]; %[min, max]
param.export_switch = 0;
param.tikz_prop = {'height','1.75\textwidth','width','1\textwidth','interpretTickLabelsAsTex',true};
end
