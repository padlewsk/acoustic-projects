%%% UPDATED: 08.11.2023
%%% DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));%
addpath('./__fun');


%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct();

p.A = 0.02;% source gain (Pa)
p.rho = [sqrt(1);sqrt(1)];

p.theta = [0;0]; %[0 pi]  = [omega_0 omega_1]
p.phi = [0;0]; %dephase of omega_1 w/r to omega_0

%%  PROCESS AND GRAPHICS 
close all
%%% BLOCH SPHERE

figure(3)
bloch_sphere(p,p.rho(1),p.theta(1),p.phi(1))
title('State');

%{
% Define polar angles (in radians)
rho = rho_0;
theta = deg2rad(theta_0);
phi =  deg2rad(phi_0);  
 
% Calculate Bloch coordinates
x = 1 * sin(theta) * cos(phi); y = 1 * sin(theta) * sin(phi);
z = 1 * cos(theta);
hold on
% Create the Bloch sphere (transparent)
[x_sphere, y_sphere, z_sphere] = sphere(128);
surf(x_sphere, y_sphere, z_sphere, 'FaceAlpha', 0.3, 'EdgeColor', 'none'); % Transparent sphere
colormap copper
shading interp
% Add the state vector (as an arrow)
arrow_length = rho; % (adjust as desired)
arrow_start = [0, 0, 0];
arrow_end = [x, y, z];
arrow_dir = arrow_end - arrow_start;
quiver3(arrow_start(1), arrow_start(2), arrow_start(3), ...
    arrow_dir(1), arrow_dir(2), arrow_dir(3), arrow_length, ...
    'Color', 'r', 'LineWidth', 2);

% Customize the plot (optional)
axis equal;
% Set the axis limits symmetrically around the origin
axis auto;
a = 1.5;
amax = max(abs(a));
axis([-amax, amax, -amax, amax, -amax, amax]);

% Add lines for the axes intersecting at the origin
hold on;
line(xlim, [0, 0], [0, 0], 'Color', 'k');  % X-axis
line([0, 0], ylim, [0, 0], 'Color', 'k');  % Y-axis
line([0, 0], [0, 0], zlim, 'Color', 'k');  % Z-axis

text(-0.05, -0.05, 1.1*amax, '|0\rangle')
text(-0.05, -0.05, -1.1*amax, '|1\rangle')
%text(x(end), y(end), z(end), 'End Point')

title(' Bloch Sphere');
hold off
box off
grid off
axis off

% Adjust view angle
view(-45, 30); % (adjust as desired)
%}
%autoArrangeFigures







