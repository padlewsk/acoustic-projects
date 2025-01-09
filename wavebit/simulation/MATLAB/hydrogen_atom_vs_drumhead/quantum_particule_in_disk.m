%%% ELECTRON IN CIRCULAR BOX 
clear all
close all
clc
clf
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));
%%

% Parameters
radius = 1; % Radius of the disk
m = 4; %  value of m
n = 2; % value of n
%mmax = 1; % Maximum value of m
%nmax = 0; % Maximum value of n


% Function to find the k-th zero of the n-th Bessel function
besselzero = @(n, k) fzero(@(x) besselj(n, x), [(k-1)*pi, k*pi]);

% Define the eigenvalue k[m, n] based on the zeros of the Bessel function
k = @(m, n) besselzero(n, m); %%% WHY INVERTED??

% Define the wave functions using Bessel functions and Fourier series
psi = @(r, t, m, n) besselj(n, k(m, n) * r) .* exp(1i * m * t);

% Generate data for demonstration
%{
data = zeros(5, 3);
for m = 1:5
    for n = 0:2
        data(m, n+1) = k(m, n); % Storing the eigenvalues
    end
end

% Display the data
disp(data);

% Plotting the probability density
figure;
plotIndex = 1;
for n = 0:nmax
    for m = 1:mmax
        subplot(nmax + 1, mmax, plotIndex);
        [X, Y] = meshgrid(linspace(-radius, radius, 100), linspace(-radius, radius, 100));
        R = sqrt(X.^2 + Y.^2);
        T = atan2(Y, X);
        Z = abs(psi(R, T, m, n)).^2; % Probability density
        Z(R > radius) = NaN; % Ensure the plot is only within the disk
        %mesh(X, Y, Z);
        contourf(X, Y, abs(Z),1e3,'edgec','n');
        title(sprintf('Probability Density: n=%d, m=%d', n, m));
        colormap magma;
        axis equal off;
        plotIndex = plotIndex + 1;
    end
end
%}
fig = figure(1);
[X, Y] = meshgrid(linspace(-radius, radius, 100), linspace(-radius, radius, 100));
R = sqrt(X.^2 + Y.^2);
T = atan2(Y, X);
Z = abs(psi(R, T, m, n)).^2; % Probability density
Z(R > radius) = NaN; % Ensure the plot is only within the disk
%mesh(X, Y, Z);
contourf(X, Y, abs(Z),1e3,'edgec','n');
title(sprintf('Probability Density: n=%d, m=%d', n, m));
colormap magma;
axis equal off;
% Export the figure with a transparent background
%filename = strcat('membrane_mn_', num2str(m), num2str(n), '.png');
%export_fig(filename, '-transparent');