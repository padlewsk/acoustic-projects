%%% DRUMHEAD EIGENMODE AMPLITUDES
clear all
close all
clc
clf
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));
%%
% Parameters
m = 2; % Angular mode number
n = 4; % Radial mode number k

R = 1; % Radius of the membrane
T = 100; % Tension per unit length
rho = 0.01; % Mass per unit area
r = linspace(0, 1, 100); % Radial coordinate
theta = linspace(0, 2*pi, 100); % Angular coordinate

% Create a meshgrid for plotting
[R_grid, Theta] = meshgrid(r, theta);

% Function to find the nth zero of the Bessel function of the first kind
bessel_zero = @(m, n) fzero(@(z) besselj(m, z), (n-1)*pi + pi/2);

% Calculate the zeros of the Bessel function of the first kind
zeros = arrayfun(@(k) bessel_zero(m, k), 1:n);

% Calculate the mode shape
Z = cos(m * Theta) .* besselj(m, R_grid * zeros(end));

% Convert polar coordinates to Cartesian for plotting
X = R_grid .* cos(Theta);
Y = R_grid .* sin(Theta);

% Plot the mode amplitude using contourf
fig = figure(1);
%contourf(X, Y, abs(Z), 20); % 20 contour levels
contourf(X, Y, abs(real(Z)),1e3,'edgec','n'); %abs(Z).^2 recovers the quantum 
%colormap('viridis');
colormap magma;
%colorbar;
%title(['Mode shape for m=', num2str(m), ', n=', num2str(n)]);
xlabel('X');
ylabel('Y');
axis equal off;
% Calculate the associated frequency
alpha_mn = zeros(end);
f_mn = (alpha_mn / (2 * pi * R)) * sqrt(T / rho);
disp(['The frequency of the mode (m=', num2str(m), ', n=', num2str(n), ') is ', num2str(f_mn), ' Hz']);

%exportgraphics(fig, strcat('membrane_mn_', num2str(m), num2str(n),'.pdf'), 'Append', false);
% Export the figure with a transparent background
filename = strcat('membrane_mn_', num2str(m), num2str(n), '.png');
export_fig(filename, '-transparent');
%vecrast(fig , strcat('membrane_mn_', num2str(M), num2str(N)), 600, 'bottom', 'pdf');