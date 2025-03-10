close all
clear all
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

% Parameters
N = 50; % Number of sites (should be even for SSH model)
t1 = 0.05; % Intra-cell hopping
t2 = 1-t1; % Inter-cell hopping
disorder_strength = linspace(0, 1, N); % Range of disorder strengths

% Initialize arrays to store results
energy_bands = zeros(N, length(disorder_strength));
zero_energy_states = zeros(length(disorder_strength), 1); % Array to store zero-energy states count

% Loop over disorder strengths
for d = 1:length(disorder_strength)
    disorder = disorder_strength(d);
    H = zeros(N); % Hamiltonian matrix
 
    %%% I. Construct Hamiltonian with chiral preserving disorder 
    %{
    for i = 1:N/2
        H(2*i-1, 2*i) = t1 + disorder * (rand - 0.5); % Intra-cell hopping with disorder
        H(2*i, 2*i-1) = H(2*i-1, 2*i);
        if i < N/2
            H(2*i, 2*i+1) = t2 + disorder * (rand - 0.5); % Inter-cell hopping with disorder
            H(2*i+1, 2*i) = H(2*i, 2*i+1);
        end
    end
    %}

    %%% II. Onsite disorder
    %{
    for i = 1:N/2
        H(2*i-1, 2*i) = t1 ; % Intra-cell hopping with disorder
        H(2*i, 2*i-1) = H(2*i-1, 2*i);
        if i < N/2
            H(2*i, 2*i+1) = t2; % Inter-cell hopping with disorder
            H(2*i+1, 2*i) = H(2*i, 2*i+1);
        end
    end
    for i = 1:N
        H(i, i) = disorder * (rand - 0.5); % Onsite potential with disorder
    end
    %}

    %%% III. Construct Hamiltonian with chiral non-preserving disorder 
    %
    for i = 1:N/2
        H(2*i-1, 2*i) = t1 + disorder * (rand - 0.5); % Intra-cell hopping with disorder
        H(2*i, 2*i-1) = t1 + disorder * (rand - 0.5); % Intra-cell hopping with disorder
        if i < N/2
            H(2*i, 2*i+1) = t2 + disorder * (rand - 0.5); % Inter-cell hopping with disorder
            H(2*i+1, 2*i) = t2 + disorder * (rand - 0.5); % Inter-cell hopping with disorder
        end
    end
    %}
    

    % Diagonalize Hamiltonian
    eigenvalues = imag(eig(H)); %IS IMAGINARY IF NONRECIPROCAL
    energy_bands(:, d) = eigenvalues;
    
    % Count zero-energy states
    zero_energy_states(d) = sum(abs(eigenvalues) < 1e-2);
end

% Sort eigenvalues to get the bulk modes
energy_bands = sort(energy_bands);

%% PLOTS

% Plot the energy bands
fig1 = figure(1);
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
box on
hold on;
for i = 1:N
    plot(disorder_strength, energy_bands(i, :), 'b','LineWidth',3);
end
xlabel('Disorder Strength (%)');
ylabel('Energy (a.u.)');
ylim([-2 2])
%title('Energy Spectrum of SSH Model vs. Disorder Strength');
axis square
hold off;

% Plot the energy dispersion without disorder
H_no_disorder = zeros(N);
for i = 1:N/2
    H_no_disorder(2*i-1, 2*i) = t1; % Intra-cell hopping
    H_no_disorder(2*i, 2*i-1) = t1;
    if i < N/2
        H_no_disorder(2*i, 2*i+1) = t2; % Inter-cell hopping
        H_no_disorder(2*i+1, 2*i) = t2;
    end
end
energy_bands_no_disorder = sort(eig(H_no_disorder));

fig2 = figure(2);
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
hold on
box on
plot(1:N, energy_bands_no_disorder, 'bo','LineWidth',3);
hold off
xlabel('Site Index');
ylabel('Energy');
ylim([-2 2])
%title('Energy Dispersion of SSH Model without Disorder');
%legend('Energy Bands');
axis square
hold off;

%BRILLOUIN ZONE
%
% Parameters
k = linspace(-pi, pi, N); % Wave vector in the Brillouin Zone

% Initialize arrays to store results
energy_bands_no_disorder = zeros(2, length(k));

% Calculate energy bands in the Brillouin Zone
for i = 1:length(k)
    H_k = [0, t1 + t2 * exp(-1i * k(i)); t1 + t2 * exp(1i * k(i)), 0];
    energy_bands_no_disorder(:, i) = eig(H_k);
end

% Plot the energy dispersion in the Brillouin Zone
fig3 = figure(3)
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
box on
grid on
hold on
plot(k/pi, energy_bands_no_disorder(1, :), 'b', k/pi, energy_bands_no_disorder(2, :), 'b','LineWidth',3);
plot(k/pi, 0*energy_bands_no_disorder(1, :), 'r', k/pi, 0*energy_bands_no_disorder(2, :), 'r','LineWidth',3); % zeroenergy state
xlabel('q/\pi');
ylabel('Energy (a.u.)');
%title('Energy Dispersion of SSH Model in the Brillouin Zone');
%legend('Energy Bands');
hold off;
xlim([-1 1])
ylim([-2 2])
axis square
%}

%% SAVE FOöES
%vecrast(fig1 , 'disorder_non_reciprocal_imag', 600, 'bottom', 'pdf');
%vecrast(fig3 , 'dispersion', 600, 'bottom', 'pdf');

