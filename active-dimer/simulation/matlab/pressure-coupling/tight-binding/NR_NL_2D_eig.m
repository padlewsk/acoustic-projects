clear all
close all
clc

%% PARAMETERS
% Hamiltonian
M = 32;  % number of atoms in one dimension (rows)
N = M;   % number of atoms in the other dimension (columns)
E = 1;   % onsite energy
t_h = -0.1; % hopping integral in the horizontal direction (left/right)
t_v = -0.1; % hopping integral in the vertical direction (up/down)
H = createHamiltonian(M, N, E, t_h, t_v);

%eigen solver
[U,E] = eigs(H);

%% FIGURES
%plot 6 dominant eigenenergies
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


%% FUNCTIONS
function H = createHamiltonian(M, N, E, t_h, t_v)
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
        if mod(ii,N) ~= 0  
            H(ii,ii+1) = t_h; %to top
            H(ii+1,ii) = t_h; %to bottom
        end
        if ii <= N*(M-1)  
            H(ii,ii+N) = t_v; % to left
            H(ii+N,ii) = t_v; % to right
        end
    end
end
