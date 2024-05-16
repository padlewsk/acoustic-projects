clear all
close all
clc
addpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox')  
%% PARAMETERS
% Hamiltonian
M = 40;  % number of atoms in one dimension (rows)
N = M;   % number of atoms in the other dimension (columns)
%H = createHamiltonian(M, N);

% Initialize the state vector
psi_0 = zeros(M, N);
psi_0(floor(3*M/4),floor(N/4)) = 1; %dirac 0.5 or 1 
%psi_0(floor(M/4),floor(3*N/4)) = -0.02; %dirac 0.5 or 1 
psi_0 = reshape(psi_0, M*N,1);


% excitation angular frequency
%freq_src = 1; %SOURCE FREQ
%freq_samp =  1*1.2393e+03; % must be at least equal to the cutoff frequency
t_0 = 0; % initial time    
t_1 = 100 ; % final time 200

tspan = (t_0:1:t_1)'; % equal spacing required for FFT
xspan = 0:M;
yspan = 0:N;


%% SIMULATION
%%% LINEAR SYSTEM
%[t_raw,psi_raw] = ode45(@(t, psi) nr_2D(t,psi, M,N), tspan, psi_0); 

%%% NONLINEAR SYSTEM
[t_raw,psi_raw] = ode89(@(t, psi) nl_nr_2D(t,psi, M,N), tspan, psi_0); 

psi2D = reshape(psi_raw, numel(t_raw), M, N);%

%[U,E] = eigs(H);

%% FIGURES
clf
%%% ANIMATION
%
fig1 = figure(1);
% Remove box lines:
axis square;
% Loop over the time vector
for idx = 1:length(t_raw)
    colormap magma
    % Draw the X and Y components
    %imagesc(abs(squeeze(psi2D(idx,:,:)))); %sqweeze is used to reduce the dimension to MxN (rmv time)
    sl =surfl(abs(squeeze(psi2D(idx,:,:))),'light');
    %sl.EdgeColor = 'none';
    shading interp
    %colorbar;
    %set(gca, 'YDir','normal')   
    %clim([0, 0.5]); %30 for linear
    zlim([0, 1.65]); %30 for linear
    view(-45,15)
    ax = gca;
    ax.XAxis.Visible = 'off';
    ax.YAxis.Visible = 'off';
    ax.ZAxis.Visible = 'off';
    ax.GridAlpha = 0.01;  
    ax.XGrid = 'off';
    ax.YGrid = 'off';
    ax.ZGrid = 'off';
    ax.Color = 'none';
    %exportgraphics(gcf,'NR_cpl_pi_0.gif','Append',true);
    % Pause execution for a short while
    pause(0.01);
end
%title(sprintf('State %d', stateIdx));
%}

%%% STILL
%
x=1:N;
y=1:N;
z =abs(squeeze(psi2D(2,:,:)));
nn=1;

for i=1:length(x) %%% MAKE 3D PLOT
    for j=1:length(y)
        X(nn) = x(i); % site
        Y(nn) = y(j); % mode
        Z(nn) = abs(z(i,j)); %% psi_abs
        nn = nn+1;
    end
end
%{
fig2 = figure(2)
colormap magma
scatter3(-X,-Y,Z,2*N,Z,'filled','MarkerEdgeColor','none','MarkerFaceAlpha',1,'linewidth',0.5)
%shading interp
%colorbar;
clim([0, 1]);
%view(0,90)
view(-45,15)
ax = gca;
ax.XAxis.Visible = 'off';
ax.YAxis.Visible = 'off';
ax.ZAxis.Visible = 'off';
ax.ZAxis.Visible = 'off';
ax.GridAlpha = 0.01;  
ax.XGrid = 'off';
ax.YGrid = 'off';
ax.ZGrid = 'off';
ax.Color = 'none';
zlim([0, 1]);
%}


autoArrangeFigures


%% SAVE FIGURES
sim_name = "NL_NR_2D__low__t_100";

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
%}


%% FUNCTIONS
function dpdt = nl_nr_2D(t, p, M,N) % nonlinear nonreciprocal 2D system
    %BEGIN HAMILTONIAN
    E = 0 - 0*1i;   % onsite energy (complex to counter act the NonHermiticity)
    t_h = -0.1; % hopping integral in the horizontal direction (left/right) alters simulation speed
    t_v = t_h; % hopping integral in the vertical direction (up/down)

    % M is the number of atoms in one dimension (rows)
    % N is the number of atoms in the other dimension (columns)
    % E is the onsite energy
    % t is the hopping integral

    % Initialize the Hamiltonian matrix
    H = zeros(M*N, M*N);

    % Fill the Hamiltonian matrix
    for ii = 1:M*N
        % Onsite energy
        H(ii,ii) = E;
        
        delta = 0.04; % NL parameter
        % NORTH AND SOUTH HALF
        if mod(ii,N) ~= 0 && mod(ii,N)<=floor(N/2) % NORTH
            H(ii,ii+1) = t_h + delta*abs(p(ii)); %to top
            H(ii+1,ii) = t_h - delta*abs(p(ii+1)); %to bottom
        elseif mod(ii,N) ~= 0 && mod(ii,N)>floor(N/2) % SOUTH
            H(ii,ii+1) = t_h - delta*abs(p(ii)); %to top
            H(ii+1,ii) = t_h + delta*abs(p(ii+1)); %to bottom
        end

        % WEST AND EAST HALF
        if ii <= N*(M-1)  && ii<=floor(N*M/2) % WEST
            H(ii,ii+N) = t_v + delta*abs(p(ii)); % to left
            H(ii+N,ii) = t_v - delta*abs(p(ii+N)); % to right
        elseif ii <= N*(M-1)  && ii>floor(N*M/2) % EAST
            H(ii,ii+N) = t_v - delta*abs(p(ii)); % to left
            H(ii+N,ii) = t_v + delta*abs(p(ii+N)); % to right
        end
    end
    %END HAMILTONIAN
dpdt =  -1i*H*p; 
end



function dpdt = nr_2D(t, p, M,N) % linear nonreciprocal 2D system
    % HAMILTONIAN
    E = 0 - 0*1i;   % onsite energy (complex to counter act the NonHermiticity)
    t_h = -0.1; % hopping integral in the horizontal direction (left/right) alters simulation speed
    t_v = t_h; % hopping integral in the vertical direction (up/down)

    % M is the number of atoms in one dimension (rows)
    % N is the number of atoms in the other dimension (columns)
    % E is the onsite energy
    % t is the hopping integral

    % Initialize the Hamiltonian matrix
    H = zeros(M*N, M*N);

    % Fill the Hamiltonian matrix
    for ii = 1:M*N
        % Onsite energy
        H(ii,ii) = E;

        % Hopping integrals
        NR_param = 0.35; %non reciprocal coupling parameter (1 --> fully NR)
        
        % NORTH AND SOUTH HALF
        if mod(ii,N) ~= 0 && mod(ii,N)<=floor(N/2) % NORTH
            H(ii,ii+1) = (1-NR_param)*t_h; %to top
            H(ii+1,ii) = (1+NR_param)*t_h; %to bottom
        elseif mod(ii,N) ~= 0 && mod(ii,N)>floor(N/2) % SOUTH
            H(ii,ii+1) = (1+NR_param)*t_h; %to top
            H(ii+1,ii) = (1-NR_param)*t_h; %to bottom
        end

        % WEST AND EAST HALF
        if ii <= N*(M-1)  && ii<=floor(N*M/2) % WEST
            H(ii,ii+N) = (1-NR_param)*t_v; % to left
            H(ii+N,ii) = (1+NR_param)*t_v; % to right
        elseif ii <= N*(M-1)  && ii>floor(N*M/2) % EAST
            H(ii,ii+N) = (1+NR_param)*t_v; % to left
            H(ii+N,ii) = (1-NR_param)*t_v; % to right
        end
    end
    %END HAMILTONIAN
dpdt =  -1i*H*p; 
end


%{
function H = createHamiltonian(M,N)
    E = 0 - 0*1i;   % onsite energy (complex to counter act the NonHermiticity)
    t_h = -0.1; % hopping integral in the horizontal direction (left/right) alters simulation speed
    t_v = t_h; % hopping integral in the vertical direction (up/down)

    % M is the number of atoms in one dimension (rows)
    % N is the number of atoms in the other dimension (columns)
    % E is the onsite energy
    % t is the hopping integral

    % Initialize the Hamiltonian matrix
    H = zeros(M*N, M*N);

    % Fill the Hamiltonian matrix
    for ii = 1:M*N
        % Onsite energy
        H(ii,ii) = E;

        % Hopping integrals
        NR_param = 0.35; %non reciprocal coupling parameter (1 --> fully NR)
        
        % NORTH AND SOUTH HALF
        if mod(ii,N) ~= 0 && mod(ii,N)<=floor(N/2) % NORTH
            H(ii,ii+1) = (1-NR_param)*t_h; %to top
            H(ii+1,ii) = (1+NR_param)*t_h; %to bottom
        elseif mod(ii,N) ~= 0 && mod(ii,N)>floor(N/2) % SOUTH
            H(ii,ii+1) = (1+NR_param)*t_h; %to top
            H(ii+1,ii) = (1-NR_param)*t_h; %to bottom
        end

        % WEST AND EAST HALF
        if ii <= N*(M-1)  && ii<=floor(N*M/2) % WEST
            H(ii,ii+N) = (1-NR_param)*t_v; % to left
            H(ii+N,ii) = (1+NR_param)*t_v; % to right
        elseif ii <= N*(M-1)  && ii>floor(N*M/2) % EAST
            H(ii,ii+N) = (1+NR_param)*t_v; % to left
            H(ii+N,ii) = (1-NR_param)*t_v; % to right
        end
    end
end
%}

