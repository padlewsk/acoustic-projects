close all; pause(0); 
clear all; 
clc;
%%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));


% Define constants
a = (0.28/2);%[m] unitcell
s = 0.01*12*10-4;%[m]^2 speaker cross section
S = 25*10-4;%[m]^2 duct cross section
c0 = 347.13; %
rho0 = 1.1839;
M = 0.00154;
R = 0.2*8.326843e-01;
C = 8.949133e-05;

% Define frequency range
qa = linspace(-pi, pi, 1000); % Adjust the range and number of points as needed



% Calculate the function
%q_cont = sqrt((omega / c0).^2 - sigma_omega);
%q_cont = omega / c0 * a;
omega = +c0/a*sqrt(2*(1-cos(qa)));

% Plot the function
figure;
plot( real(qa)/pi, real(omega)/(2*pi), '-b', 'DisplayName', 'Discrete','LineWidth',3);
hold on;
plot( qa/pi,  qa*c0/a/(2*pi),  '--r', 'DisplayName', 'Continuous','LineWidth',3);
ylabel('Frequency (Hz)');
xlabel('qa/\pi');
%title('Plot of \pm\sqrt{(\omega / c)^2 + i * \omega * s /
%(S*Z(\omega)}');
xlim([0,1])
ylim([0,c0/a/2])
legend;
grid on;
box on
%grid on
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;

%
% band fold
figure;
plot( real(qa)/pi, real(omega)/(2*pi), '-b', 'DisplayName', 'Discr','LineWidth',3);
hold on;
plot( -real(qa)/pi+1, real(omega)/(2*pi), '-b','LineWidth',3);
plot( qa/pi,  qa*c0/a/(2*pi),  '--r','LineWidth',3);
plot( -qa/pi+1,  qa*c0/a/(2*pi),  '--r','LineWidth',3);
ylabel('Frequency (Hz)');
xlabel('qa/\pi');
%title('Plot of \pm\sqrt{(\omega / c)^2 + i * \omega * s /
%(S*Z(\omega)}');
xlim([0,1])
ylim([0,c0/a/2])
%legend;
grid on;

box on
%grid on
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;
%axis square
%pbaspect([2 1 1]);

