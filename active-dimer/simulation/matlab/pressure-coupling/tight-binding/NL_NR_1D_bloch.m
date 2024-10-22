%%% NONRECIPROCAL NONLINEAR 1D PERIODIC BOUNDARY CONDITIONS

clear all
close all
clc
addpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox')  
addpath('./__fun/')
%% PARAMETERS
a = 0.28; % cell size half??
c0 = 344;%m/s
omega0 = 2*pi*(c0/a/2); %(c0/a/2) = 614 Hz (gap opens here?) Not the onsite energy here but simply a spectral shift!!!
t0 = 2*pi*(100);% 2*pi*((c0/a/2)/2 + 0*2*1i); % MAX coupling

N = 38; %number of nonlinear steps
I_list = linspace(0,0.2*t0,N);
ka_list = linspace(-pi,pi,100);

for ii = 1:numel(I_list)
     I = I_list(ii);
    for jj = 1:numel(ka_list)
        ka = ka_list(jj);
        omega(jj,ii) = omega0 + (t0 + 2*pi*8*1i - I + 10*1i)*exp(+1i*ka) + (t0 + 2*pi*8*1i + I)*exp(-1i*ka);
    end
end

%% FIG
clf
dx = real(omega(:,:))/(2*pi);
dy = imag(omega(:,:))/(2*pi);

%{
fig1 = figure(1);
set(gca,'linewidth',2)
% Get handle to current axes.
ax = gca
yyaxis left
plot(ka_list, dx','-','Color', '#734c9e','LineWidth',2)
ax.YColor = '#734c9e';
xlabel('Values from 0 to 25')
ylabel('Left Side')
yyaxis right
plot(ka_list, dy','-','Color', '#327ee3','LineWidth',2)
ax.YColor = '#327ee3';
ylabel('Right Side')
hold off
xlim([-pi pi])
%legend
%grid on
%}

set(0,'DefaultAxesColorOrder',magma(N))
fig1 = figure(1);

plot(ka_list, dy,'-','LineWidth',3)
ylabel('Im(f) (Hz)')

yyaxis right %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(ka_list, dx,'-','LineWidth',3)
%ylim([560 670])
ylabel('Re(f) (Hz)')

box on
xlabel('ka')
xlim([-pi pi])
set(gca,'XTick',-pi:pi/2:pi) 
set(gca,'XTickLabel',{'\pi','-\pi/2','0','\pi/2','\pi'})
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;
axis square
saveas(gcf,'topo_1','pdf') %%%%%%%%%%%%%%%%%

%%%%%-----------------------------------------------------------%%%%
set(0,'DefaultAxesColorOrder',magma(N))
fig2 = figure(2);
colormap('magma')
hold on
ax = gca;
%ax.XAxisLocation = 'origin';
%ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;

plot(dx,dy,'-','LineWidth',3)
%fill(dx',dy','-','LineWidth',3,'FaceAlpha',0.1,'EdgeColor','none')
%plot(0,0,'ro','LineWidth',3)
hold off
xlim([400,820])
%ylim([-1,1])
xlabel('Re(f) (Hz)')
ylabel('Im(f) (Hz)')
axis square

set(gca,'CLim',[0 1]);
cb = colorbar 
cb.Label.String = 'Intensity (a.u)'
cb.LineWidth = 2;
box on
saveas(gcf,'topo_2','pdf')
%% SAVE FIGURES
%sim_name = "NL_NR_cpl__delta_0";

%{
tic
if ~exist("__figures", 'dir')
   mkdir("__figures")
end
if ~isfile(string("./__figures/fig__" + sim_name + ".pdf"))
    exportgraphics(fig1, string("./__f igures/fig__" + sim_name + ".pdf"), 'ContentType', 'vector')% save the figure as a tightly cropped PDF file
else
    fprintf("### FIGURE NOT SAVED: FILE NAME ALREADY EXISTS\n")
end
toc
%}

