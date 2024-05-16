%%% NONRECIPROCAL NONLINEAR 1D EIGENVALUE SOLVER

clear all
close all
clc
addpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox\')  
addpath('./__fun/')
%% PARAMETERS
% Hamiltonian
N = 50;   % number of atoms in one side
U = 0;   % onsite energy
t = -0.1; % default hopping integral in the horizontal direction (left/right)
delta = 0.5*(-0.01); %Change the intensity param. d=0, d=0.25 and d=0.5
H = zeros(2*N, 2*N);

psi = ones(2*N,1);
errormin = 15;
f=1;
while f==1 % energy minimizing
    % Fill the Hamiltonian matrix
    for ii = 1:2*N
        % Onsite energy
        H(ii,ii) = U;
        if ii > 1 && ii < 2*N %edge cases
            if ii <= N 
                H(ii,ii+1) = t - delta*(abs(psi(ii))^2 + abs(psi(ii+1))^2); %0
                H(ii,ii-1) = t + delta*(abs(psi(ii))^2 + abs(psi(ii-1))^2); %
            end
    
            if ii > N
                H(ii,ii+1) = t + delta*(abs(psi(ii))^2 + abs(psi(ii+1))^2); %
                H(ii,ii-1) = t - delta*(abs(psi(ii))^2 + abs(psi(ii-1))^2); %0
            end
        end
    end

    %eigen solver   
    [eig_V,eig_E] = eig(H);

    norm(diag(eig_E) - eig_V) % is minimized?

    if norm(diag(eig_E) - eig_V) < errormin
        f = 0; %stop iteration
    else
        psi = diag(eig_E); 
    end
end

%% FIGURES
%%% LOAD FIGURE PARAMETERS
fig_param = fig_params();


x=1:2*N;
y=1:2*N;
nn=1;

for i=1:length(x) %%% MAKE 3D PLOT
    for j=1:length(y)
        X(nn) = x(i); % site
        Y(nn) = y(j); % mode
        Z(nn) = abs(eig_V(i,j)); %% psi_abs
        nn = nn+1;
    end
end

fig1 = figure(1)

colormap magma
scatter3(X-N,Y,Z,2*N,Z,'filled','MarkerEdgeColor','none','MarkerFaceAlpha',1,'linewidth',0.5)
shading interp

view(-15,30)

ax = gca;
ax.ZAxis.Visible = 'off';
ax.GridAlpha = 0.01;  
ax.XGrid = 'off';
ax.YGrid = 'off';
ax.ZGrid = 'on';
ax.Color = 'none';

set(gcf,'position',fig_param.window_size);
%set(gcf, 'InvertHardCopy', 'off'); % to make black figure
%set(gcf,'Color',[0 0 0]);% to make black figure
%set(gca,fig_param.fig_prop{:},'XColor','w','YColor','w');
set(gca,fig_param.fig_prop{:});

clim([0,0.4])

xlim([-N,N])
xlabel('Site')
ylabel('Mode')

%
%add interface highlight
p1 = [0 0 0];
p2 = [0 2*N 0];
p3 = [0 2*N -5*t];
p4 = [0 0 -5*t];  
XX = [p1(1) p2(1) p3(1) p4(1)];
YY = [p1(2) p2(2) p3(2) p4(2)];
ZZ = [p1(3) p2(3) p3(3) p4(3)];
hold on;
fill3(XX, YY, ZZ,'w', 'EdgeColor', 'none', 'FaceAlpha',0.3);
%}
hold off
    
%% SAVE FIGURES
sim_name = "NL_NR_cpl__delta_0";

%
tic
if ~exist("__figures", 'dir')
   mkdir("__figures")
end
if ~isfile(string("./__figures/fig__" + sim_name + ".pdf"))
    exportgraphics(fig1, string("./__figures/fig__" + sim_name + ".pdf"), 'ContentType', 'vector')% save the figure as a tightly cropped PDF file
else
    fprintf("### FIGURE NOT SAVED: FILE NAME ALREADY EXISTS\n")
end
toc

