

% Define Brillouin zone
kx = linspace(-pi, pi, 100);
ky = linspace(-pi, pi, 100);
[KX, KY] = meshgrid(kx, ky);

% Evaluate Berry curvature at each point in Brillouin zone
F = berry_curvature(KX, KY, t);

% Integrate Berry curvature over Brillouin zone
chern = trapz(ky, trapz(kx, F, 2)) / (2*pi);

% Print result
fprintf('Chern number = %d\n', chern);
% Define function to calculate Berry curvature
function F = berry_curvature(kx, ky, t)
  % Calculate Hamiltonian at point (kx, ky)
  H = hamiltonian(kx, ky, t);
  
  % Calculate eigenvectors and eigenvalues of Hamiltonian
  [V, D] = eig(H);
  
  % Calculate Berry curvature
  F = 0;
  for i = 1:size(V,1)
    for j = 1:size(V,1)
      if i ~= j
        F = F + (imag(V(i,:)*(H - D(j,j))*V(j,:)') / ((D(i,i) - D(j,j))^2));
      end
    end
  end
end