close all; pause(0); 
clear all; 
clc;
%%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));


% Define constants
a = 0.280/2;%[m] unitcell
s = 0.01*12*10-4;%[m]^2 speaker cross section
S = 25*10-4;%[m]^2 duct cross section
c0 = 347.13; 
rho0 = 1.1839;
M = 0.00154;
R = 0*8.326843e-01;
C = 8.949133e-05;

% Define frequency range
omega = linspace(0, 2*pi*1500, 1000); % Adjust the range and number of points as needed

% Define Z(omega)
Z_omega = 1i * omega * M + R + 1 ./ (1i * omega * C);
sigma_omega = - 1i * omega * rho0 * s ./ (S * Z_omega);%*0

% Calculate the function
%q_cont = sqrt((omega / c0).^2 - sigma_omega);
%q_cont = omega/c0;
q_cont = acos(cos(omega/c0*a) + sigma_omega./(2*(omega/ c0)).*sin(omega/c0*a))/a; % transfer matrix method
q_disc = acos(a^2/2*(sigma_omega - (omega / c0).^2)+1)/a;

% Plot the function
fig1 = figure(1);
plot( real(q_cont*a)/pi, omega/(2*pi), '-b', 'DisplayName', 'Continuous','LineWidth',3); %omega/(2*pi) for display in 
hold on;
plot( real(q_disc*a)/pi, omega/(2*pi), ':b', 'DisplayName', 'Discrete','LineWidth',3);
ylabel('Frequency (Hz)');
xlabel('q (\pi/a)');
%title('Plot of \pm\sqrt{(\omega / c)^2 + i * \omega * s /
%(S*Z(\omega)}');
xlim([0,1])
ylim([0,c0/a/2])
legend('Location','northwest');
grid on;
box on
yline(644.5,'--','HandleVisibility','off','LineWidth',3);% edge BZ
yline(427,'--','HandleVisibility','off','LineWidth',3);% edge BZ
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;
%axis square
%pbaspect([2 1 1]);

%%% band fold
fig2 = figure(2);
plot( 2*(real(q_cont*a)/pi), real(omega)/(2*pi), '-b', 'DisplayName', 'Continuous','LineWidth',3);
hold on;
plot( 2*(-real(q_cont*a)/pi+1), real(omega)/(2*pi), '-b','HandleVisibility','off','LineWidth',3);
plot( 2*(real(q_disc*a)/pi), real(omega)/(2*pi), ':b', 'DisplayName', 'Discrete','LineWidth',3);
plot( 2*(-real(q_disc*a)/pi+1), real(omega)/(2*pi), ':b','HandleVisibility','off','LineWidth',3);
ylabel('Frequency (Hz)');
xlabel('q (\pi/(2a))');
%title('Plot of \pm\sqrt{(\omega / c)^2 + i * \omega * s /
%(S*Z(\omega)}');
xlim([0,1])
ylim([0,c0/a/2])
legend('Location','northwest');
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




% IN TERMS OF ka/pi
%{
fig1 = figure(1);
plot( real(q_cont*a)/pi, omega/(c0*pi)*a, '-b', 'DisplayName', 'Continuous','LineWidth',3); %omega/(2*pi) for display in 
hold on;
plot( real(q_disc*a)/pi, omega/(c0*pi)*a, '--b', 'DisplayName', 'Discontinuous','LineWidth',3);
%plot(imag(q_disc*a)/pi, omega/(2*pi),  'r', 'DisplayName', 'Imaginary part','LineWidth',3);
ylabel('ka/\pi');
xlabel('qa/\pi');
%title('Plot of \pm\sqrt{(\omega / c)^2 + i * \omega * s /
%(S*Z(\omega)}');
xlim([0,1])
%ylim([0,c0/a/2])
ylim([0,1])
legend('Location','northwest');
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
%}

%%SAVE FIGURE
%vecrast(fig1 , 'disp_comp_WG_res', 600, 'bottom', 'pdf');
%vecrast(fig2 , 'disp_comp_WG_res_fold', 600, 'bottom', 'pdf');    
