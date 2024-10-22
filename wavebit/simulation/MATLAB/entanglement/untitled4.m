% Parameters
m1 = 1; % mass of first oscillator
m2 = 1; % mass of second oscillator
omega1 = 1; % angular frequency of first oscillator
omega2 = 1; % angular frequency of second oscillator
hbar = 1; % reduced Planck's constant
k = 0.1; % coupling constant
N = 100; % number of grid points
x_max = 5; % maximum position
x = linspace(-x_max, x_max, N); % position grid
dx = x(2) - x(1); % grid spacing

% Hamiltonian matrix
H = zeros(N, N);
for n = 1:N
    for m = 1:N
        if n == m
            H(n,m) = (n-1/2)*hbar*omega1 + (n-1/2)*hbar*omega2;
        elseif abs(n-m) == 1
            H(n,m) = sqrt(n*m)*hbar*omega1/2 + sqrt(n*m)*hbar*omega2/2;
        end
    end
end

% Interaction term
H_int = k * (x' * x);

% Total Hamiltonian
H_total = H + H_int;

% Initial state (Gaussian wave packet)
psi0 = exp(-x.^2);
psi0 = psi0 / norm(psi0); % normalize

% Time evolution
dt = 0.01; % time step
t_max = 10; % maximum time
num_steps = t_max / dt;
psi_t = psi0;

% Time evolution loop
for t = 1:num_steps
    psi_t = exp(-1i * H_total * dt / hbar) * psi_t;
    % Visualization (plot every 100 steps)
    if mod(t, 100) == 0
        plot(x, abs(psi_t).^2);
        title(['Time = ', num2str(t*dt)]);
        drawnow;
    end
end