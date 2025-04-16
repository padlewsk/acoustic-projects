%%% Multiple scattering topological cone
close all
clear all
%%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

% Define the range for the cone
r = linspace(-5, 5, 100);
theta = linspace(0, 2*pi, 100);

% Create the mesh grid
[R, Theta] = meshgrid(r, theta);

% Define the equations for the double cone
X = R .* cos(Theta);
Y = R .* sin(Theta);
Z1 = R;  % Upper cone
Z2 = -R; % Lower cone

% Plot the upper cone

figure;
%set(gcf, 'Color', 'none'); % Set figure background to none
surf(X, Y, Z1, 'FaceAlpha', 0.5, 'EdgeColor', 'none');
hold on;

% Plot the lower cone
surf(X, Y, Z2, 'FaceAlpha', 0.5, 'EdgeColor', 'none');

% Add an arrow along the z-axis
quiver3(0, 0, -5, 0, 0, 10, 'k', 'LineWidth', 2, 'MaxHeadSize', 0.1);

% Add labels to the arrow
text(0, 0, 5.5, 'Z', 'FontSize', 12, 'FontWeight', 'bold');

% Set the axis properties
axis equal;
xlabel('\Im(\beta)');
ylabel('\Re(\beta)');
zlabel('\Im(\alpha)');
%title('Double Cone Plot');
grid on;
colormap('magma');

% Adjust the axis limits to center the z-axis
xlim([-5 5]);
ylim([-5 5]);
zlim([-5 5]);
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;

% Set the view to ensure the z-axis goes through the center
%view(3); % 3D view

%% SAVE
vecrast(gcf , 'scattering_cone', 600, 'bottom', 'pdf');
