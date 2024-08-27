clear all
close all
    % Parameters
    m1 = 1; % Mass of the first oscillator
    m2 = 1; % Mass of the second oscillator
    k1 = 10; % Spring constant of the first oscillator
    k2 = 10; % Spring constant of the second oscillator
    k_coupling = 0; % Coupling spring constant
    A = 1; % Amplitude of the driving force
    omega_0 = sqrt(k1/m1); % Natural frequency of the first harmonic
    omega_1 = sqrt((2*k1)/m1); % Natural frequency of the second harmonic

    % Time span
    tspan = [0 20];

    % Initial conditions [x1, v1, x2, v2]
    y0 = [0; 0; 0; 0];

    % Solve the system of ODEs
    [t, y] = ode45(@(t, y) odefun(t, y, m1, m2, k1, k2, k_coupling, A, omega_0,omega_1), tspan, y0);

    % Plot the results
    figure;
    plot(t, y(:, 1), t, y(:, 3));
    xlabel('Time');
    ylabel('Displacement');
    legend('x1', 'x2');
    title('Coupled Harmonic Oscillator with Driving Force');

    function dydt = odefun(t, y, m1, m2, k1, k2, k_coupling, A, omega_0, omega_1)
        % Unpack the variables
        x1 = y(1);
        v1 = y(2);
        x2 = y(3);
        v2 = y(4);

        % Equations of motion
        dx1dt = v1;
        dv1dt = (-k1*x1 - k_coupling*(x1 - x2) + heaviside(-t + 2*pi/(omega_0/2))*A*real(0*exp(1i*omega_0*t)+exp(1i*omega_1*t))) / m1;
        dx2dt = v2;
        dv2dt = (-k2*x2 - k_coupling*(x2 - x1)) / m2;

        % Return the derivatives
        dydt = [dx1dt; dv1dt; dx2dt; dv2dt];
    end
