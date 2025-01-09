% Parameters
radius = 1; % Radius of the disk
numR = 50; % Number of radial points
numTheta = 80; % Number of angular points

% Function to find the k-th zero of the n-th Bessel function
besselzero = @(n, k) fzero(@(x) besselj(n, x), [(k-1)*pi, k*pi]);

% Define the eigenvalue k[m, n] based on the zeros of the Bessel function
k = @(m, n) besselzero(m, n);

% User inputs
m = 2; % Azimuthal quantum number
n = 4; % Radial quantum number
view = 'Plot3D'; % View type: 'Plot3D', 'Density', 'Contour'

% Generate RList
RList = @(m, n) arrayfun(@(r) besselj(m, r * k(m, n)).^2, linspace(0, 1, numR));

% Generate PhiList
PhiList = @(m) arrayfun(@(theta) cos(m * theta).^2, linspace(0, 2*pi, numTheta));

% Generate rPhiMatrix
[r, theta] = meshgrid(linspace(0, 1, numR), linspace(0, 2*pi, numTheta));
X = r .* cos(theta);
Y = r .* sin(theta);

% Calculate the probability density
R = RList(m, n);
Phi = PhiList(m);
[RR, TT] = meshgrid(R, Phi);
Z = RR .* TT;

% Plot the probability density
figure(1)
contourf(X, Y, abs(Z),1e3,'edgec','n');
colormap magma;
axis equal off;

filename = strcat('infinite_well_mn_', num2str(m), num2str(n), '.png');
export_fig(filename, '-transparent');
