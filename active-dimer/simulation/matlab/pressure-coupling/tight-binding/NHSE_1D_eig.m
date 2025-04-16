%%% NON HERMITIAN SKIN EFFECT - finite system
close all
clear all
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

% Parameters
N = 10; % Number of sites 
t = 1; % nominal coupling
gamma = +0.5; % non-hermitian coupling

% Initialize Hamiltonian matrix
H = zeros(N);

for nn = 1:N-1
    H(nn, nn+1) = t - gamma;  
    H(nn+1, nn) = t + gamma;
end
    

% Compute eigenvalues and eigenvectors
[V, D] = eig(H);
eigenvalues = diag(D);

% Plot eigenvalues on the complex plane
figure;
plot(real(eigenvalues), imag(eigenvalues), 'o');
xlabel('Real Part');
ylabel('Imaginary Part');
title('Eigenvalues on the Complex Plane');
grid on;

% Plot all eigenvectors to visualize non-Hermitian skin states
set(0,'DefaultAxesColorOrder',flip(magma(N/2)))
figure;
for k = 1:N
    hold on
    plot(abs(V(:, k)),'-','LineWidth',3);
    hold off
    xlabel('Site Index');
    ylabel(['Magnitude']);
end
xlim([1 N])
box on
%grid on
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;
%axis square
pbaspect([2 1 1]);
%saveas(gcf,'NHSE_left','pdf')



%{
% Plot all eigenvectors to visualize non-Hermitian skin states
figure;
for k = 1:N
    subplot(N, 1, k);
    plot(abs(V(:, k)), 'b', 'DisplayName', 'Magnitude');
    xlabel('Site Index');
    ylabel(['Eigenvector ', num2str(k)]);
    legend;
    grid on;
end
%}

% Plot eigenvalues on the complex plane (which should be a line)
%{
figure;
plot(real(eigenvalues), imag(eigenvalues), 'o');
xlabel('Real Part');
ylabel('Imaginary Part');
title('Eigenenergies on the Complex Plane');
grid on;
%}
%% SAVE FOöES
%vecrast(fig1 , 'disorder_non_reciprocal_imag', 600, 'bottom', 'pdf');
%vecrast(fig3 , 'dispersion', 600, 'bottom', 'pdf');

