%%% QUANTUM HYDROGEN ATOM EIGENMODES 
%%% CF 20250109 for settings
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%%
N=1; % N>=1
L=0; % 0<=L<=N-1
M=0; % -L<=M<=L, but only use 0<=M<=L

zoom = 10;%10
r=meshgrid(0:100)/zoom;
t=r'/50*pi*zoom;
a=N-L-1;

% Short version of laguerre polynomial
F=0;
for i=0:a
F=F+(-1)^i*nchoosek(N+L,a-i)*(2*r/N).^i/prod(1:i);
end
G=legendre(L,cos(t));
P=squeeze(G(1+M,:,:)).*F.*exp(-r/2).*r.^L;
%P=squeeze(G(1+M,:,:)).*F.*cos(-r/2).*r.^L;


% Plot the mode shape
fig = figure(1);
colormap magma;
contourf(r.*sin(t),r.*cos(t),(abs(P)),1e3,'edgec','n'); %1e4
%contourf(r.*sin(t),r.*cos(t),(abs(P)).^(1/3),1e3,'edgec','n'); %1e4 .^(1/3) to reduce the exponential decay
%contourf(r.*sin(t),r.*cos(t),(real(P)),20);
%surf(r.*sin(t),r.*cos(t),100*(abs(P)), 'EdgeColor', 'none');
%zlim([0 0.005])
%clim([0 0.4]); % Change caxis because P is not normalized
axis equal off;
%axis(70*[-1 1 -1 1]);
%colorbar
%title(['State for N=', num2str(N), ', L=', num2str(L), ', M=', num2str(M)]);

%% SAVE GRAHICS
filename =strcat('orbital_nlm_', num2str(N), num2str(L), num2str(M),'.png');
%exportgraphics(fig, strcat('orbital_nlm_', num2str(N), num2str(L), num2str(M),'.eps'), 'Append', false,'BackgroundColor','none');
export_fig(filename, '-transparent');

