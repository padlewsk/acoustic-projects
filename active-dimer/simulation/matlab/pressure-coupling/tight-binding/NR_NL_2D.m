clear all
close all
clc

%% PARAMETERS
% Hamiltonian
M = 32;  % number of atoms in one dimension (rows)
N = M;   % number of atoms in the other dimension (columns)
%H = createHamiltonian(M, N);

% Initialize the state vector
psi_0 = zeros(M, N);
psi_0(floor(3*M/4),floor(N/4)) = 1; %dirac 0.5 or 1 
psi_0 = reshape(psi_0, M*N,1);


% excitation angular frequency
%freq_src = 1; %SOURCE FREQ
%freq_samp =  1*1.2393e+03; % must be at least equal to the cutoff frequency
t_0 = 0; % initial time    
t_1 = 200 ; % final time

tspan = (t_0:1:t_1)'; % equal spacing required for FFT
xspan = 0:M;
yspan = 0:N;


%% SIMULATION


%%% LINEAR SYSTEM
%[t_raw,psi_raw] = ode45(@(t, psi) nr_2D(t,psi, M,N), tspan, psi_0); 

%%% NONLINEAR SYSTEM
%opts = odeset('InitialStep', 1e-5, 'Refine', 10,'Stats','on'); % use refine to compute additional points
[t_raw,psi_raw] = ode89(@(t, psi) nl_nr_2D(t,psi, M,N), tspan, psi_0); 

psi2D = reshape(psi_raw, numel(t_raw), M, N);%

%[U,E] = eigs(H);

%% FIGURES
clf
% Create a new figure
figure(1);
% Remove box lines:
axis square;
% Loop over the time vector
for idx = 1:length(t_raw)
    colormap magma
    % Draw the X and Y components
    %imagesc(abs(squeeze(psi2D(idx,:,:)))); %sqweeze is used to reduce the dimension to MxN (rmv time)
    surfl(abs(squeeze(psi2D(idx,:,:))),'light');
    shading interp
    %colorbar;
    %set(gca, 'YDir','normal')   
    zlim([0, 1]);%30 for linear
    view(-45,30)
    ax = gca;
    ax.ZAxis.Visible = 'off';
    ax.GridAlpha = 0.01;  
    ax.XGrid = 'off';
    ax.YGrid = 'off';
    ax.ZGrid = 'on';
    ax.Color = 'none';
    %exportgraphics(gcf,'NL_NR_cpl_high.gif','Append',true);
    % Pause execution for a short while
    pause(0.01);
end

%title(sprintf('State %d', stateIdx));

%{
figure(1)
plot(diag(E));

% Assuming 'U' contains the eigenvectors from eig(H)
numStates = size(U, 2); % Number of states (eigenvectors)

for stateIdx = 1:numStates
    % Reshape the eigenvector to a 2D matrix
    state2D = reshape(U(:, stateIdx), [M, N]);%

    % Create a new figure for each state
    figure;
    axis square;
    axis equal;
    %axis image;
    imagesc(abs(state2D));
    colorbar;
    set(gca, 'YDir','normal')
    title(sprintf('State %d', stateIdx));
end
autoArrangeFigures
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
        
        alpha = 0.044; % NL parameter
        % NORTH AND SOUTH HALF
        if mod(ii,N) ~= 0 && mod(ii,N)<=floor(N/2) % NORTH
            H(ii,ii+1) = t_h + alpha*abs(p(ii)); %to top
            H(ii+1,ii) = t_h - alpha*abs(p(ii+1)); %to bottom
        elseif mod(ii,N) ~= 0 && mod(ii,N)>floor(N/2) % SOUTH
            H(ii,ii+1) = t_h - alpha*abs(p(ii)); %to top
            H(ii+1,ii) = t_h + alpha*abs(p(ii+1)); %to bottom
        end

        % WEST AND EAST HALF
        if ii <= N*(M-1)  && ii<=floor(N*M/2) % WEST
            H(ii,ii+N) = t_v + alpha*abs(p(ii)); % to left
            H(ii+N,ii) = t_v - alpha*abs(p(ii+N)); % to right
        elseif ii <= N*(M-1)  && ii>floor(N*M/2) % EAST
            H(ii,ii+N) = t_v - alpha*abs(p(ii)); % to left
            H(ii+N,ii) = t_v + alpha*abs(p(ii+N)); % to right
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