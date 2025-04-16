%%% NON HERMITIAN SKIN EFFECT - winding
% cf https://www.annualreviews.org/content/journals/10.1146/annurev-conmatphys-040521-033133


clear all
close all
clc
addpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox')  
addpath('./__fun/')
%% PARAMETERS
E0 = 0; % Note the onsite energy here but simply a spectral shift!!!
t0 = 0.5  + 0* 1i; % coupling
gamma = 0.25; %non-hermitian term + --> H^+ right mover

ka_list = linspace(-pi,pi,100);

for jj = 1:numel(ka_list)
    ka = ka_list(jj);
    E(jj) = E0 + (t0 + gamma)*exp(+1i*ka) + (t0  - gamma)*exp(-1i*ka);
end


% Compute the winding number from the energy
winding_number = sum(angle(E(2:end) .* conj(E(1:end-1)))) / (2 * pi);% Verify this... also saig to be sng(gamma)

disp(['The winding number is ', num2str(winding_number)]);
%% FIG
clf
dx = real(E(:));
dy = imag(E(:));


set(0,'DefaultAxesColorOrder',magma(1))
fig1 = figure(1);

plot(ka_list, dy,'-','LineWidth',3)
ylabel('Im(E) (a.u)')
ylim([-1, 1])
yyaxis right %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(ka_list, dx,'k-','LineWidth',3)
ylim([-1, 1])
ylabel('Re(E) (a.u)')

box on
xlabel('q')
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
set(0,'DefaultAxesColorOrder',magma(1))
fig2 = figure(2);
%colormap('magma')
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
xlim([-1,1])
ylim([-1,1])
xlabel('Re(E) (a.u)')
ylabel('Im(E) (a.u)')
axis square

%{
set(gca,'CLim',[0 1]);
cb = colorbar 
cb.Label.String = 'Intensity (a.u)'
cb.LineWidth = 2;
%}
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

