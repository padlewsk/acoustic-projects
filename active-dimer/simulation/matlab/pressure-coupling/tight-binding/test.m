% 2D NL_NH_SSH

% https://physics.stackexchange.com/questions/230101/tight-binding-hamiltonian-for-2d-finite-dimensional-lattice-and-nanowire

close all
clear all
clc

Na = 32; % Number of cells in a direction
Nb = 32; % Number of cells in b direction
Ni = 2; % number of basis functions per site

% Hamiltonian for same site interaction
H_SS = [ 
    0.5 0.5 ; 
    0.5 0.5
]; 

% Hamiltonian for nearest neighbour interaction [W N; E S]  [ 0.1 0.0 ; 0.0 0.1 ] ; 
H_NN = [ 
    -0.1 0.0 ;
    0.0 -0.1 
    ]; 

% Values to store the constructed sparse Hamiltonian
nn1 = [];
nn2 = [];
Hnn = [];

% Loop over all lattice sites
for a1 = 1:Na, for b1 = 1:Nb
  % Loop over all neighbouring sites
  for da = -1:1  % basis vector a
    a2 = a1 + da;
    if (a2 < 1 || a2 > Na) % edge case
        continue;
    end
    for db = -1:1 % basis vector b
        b2 = b1 + db;
        if (b2 < 1 || b2 > Nb) % edge case
          continue;
        end
        % Loop over all basis function pairs (pointer)
        for i1 = 1:Ni, for i2 = 1:Ni % NEWS
            n1 = ((a1-1) + (b1-1) * Na) * Ni + i1; % origin
            n2 = ((a2-1) + (b2-1) * Na) * Ni + i2; % target

            NN = max(abs(da),abs(db)); % to separate ss from nn
            
            if (NN == 0) % points to same site
                nn1 = [ nn1 n1 ]; % origin vector
                nn2 = [ nn2 n2 ]; % target vector
                Hnn = [ Hnn H_SS(i1,i2)]; % sort of a "line" Hamiltonian
            end
            if (NN == 1) % points to nearest neighbor
                nn1 = [ nn1 n1 ]; 
                nn2 = [ nn2 n2 ];
                Hnn = [ Hnn H_NN(i1,i2)]; 
            end
        end, end
    end
  end
end, end

%% Data processing + plot

H = full(sparse(nn1, nn2, Hnn)); % turns "line" Hamiltonian into matrix form by summing the energies on each site

[U,E] = eigs(H);

%plot 6 dominant eigenenergies
figure(1)
plot(diag(E));

% Assuming 'U' contains the eigenvectors from eig(H)
numStates = size(U, 2); % Number of states (eigenvectors)

for stateIdx = 1:numStates
    % Reshape the eigenvector to a 2D matrix
    state2D = reshape(U(:, stateIdx), [Na, Nb*Ni]);%

    % Create a new figure for each state
    figure;
    imagesc(abs(state2D));
    colorbar;
    title(sprintf('State %d', stateIdx));
end
autoArrangeFigures