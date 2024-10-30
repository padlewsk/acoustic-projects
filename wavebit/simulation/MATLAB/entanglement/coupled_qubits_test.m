close all
clear all

%qubit a and b
freq = 500; %Hz
omega_0 = [2 * pi * freq; 2 * pi * freq]; %first oscillator res freq
omega_1 = 2 * omega_0; %second oscillator res freq
alpha_int = [0;0]; %internal coupling should be zero as these are orthogonal states

cpl_ext = [1 0;
             0 0]; %cross"external" coupling
cpl_ext = cpl_ext/norm(cpl_ext); %normalization

%initial state
theta = [pi/2; pi/2];
phi = [ 0; 0];
rho = [1;1];
gamma = [0;pi/2]; %nonzero relative global phase IMPORTANT TO observe 00,11

% Initial conditions [x1, v1, x2, v2, x3, v3, x4, v4]
y0 = [rho(1)*exp(1i*gamma(1))*cos(theta(1)/2); 0; rho(1)*exp(1i*gamma(1))*exp(1i*phi(1))*sin(theta(1)/2); 0;
      rho(2)*exp(1i*gamma(2))*cos(theta(2)/2); 0; rho(2)*exp(1i*gamma(2))*exp(1i*phi(2))*sin(theta(2)/2); 0];

% Time span
tspan = [0 5*(2*pi)/omega_0(1)];% why is it twice the frequency????? because (psi)^2

% Solve the system using ode45
[t, y] = ode89(@(t, y) odefun(y,omega_0, omega_1, alpha_int, cpl_ext), tspan, y0);

 
% Plot the results
figure;
tiledlayout(2,1)
nexttile 
hold on
plot(t*(freq), abs(y(:, 1)))
plot(t*(freq), abs(y(:, 3)));
%plot(t*(freq), abs(y(:, 1)).^2 + abs(y(:, 3)).^2,'--k');
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('Abs(\psi_1)');
%legend('cos(\theta/2)〈t|0〉', 'e^{i \phi}sin(\theta/2)〈t|1〉','〈t|\psi_1〉');
legend('|0〉', '|1〉');
%ylim([0 1])
grid on
box on
title('Qubit 1');

% Plot the results
nexttile
hold on
plot(t*(freq), abs(y(:, 5)))
plot(t*(freq), abs(y(:, 7)));
%plot(t*(freq), abs(y(:, 5)).^2 + abs(y(:, 7)).^2,'--k');
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('Abs(\psi_2)');
%legend('cos(\theta/2)〈t|0〉', 'e^{i \phi}sin(\theta/2)〈t|1〉','〈t|\psi_2〉');
legend('|0〉', '|1〉');
%ylim([0 1])
grid on
box on
title('Qubit 2');
%{
nexttile
hold on
plot(t*(freq), (1/2)*abs((y(:, 1)+y(:, 3)).*(y(:, 5)+y(:, 7))));
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('Probability amplitude');
legend('|00〉', '|01〉', '|10〉', '|11〉');
ylim([0 1])
grid on
title('Composite state');
%}

%number of qubits times hermitian product --> probability:
2/tspan(end)*trapz(t,abs(y(:, 1)).^2) %wb1_state0
2/tspan(end)*trapz(t,abs(y(:, 3)).^2) %wb1_state1
2/tspan(end)*trapz(t,abs(y(:, 5)).^2) %wb2_state0
2/tspan(end)*trapz(t,abs(y(:, 7)).^2) %wb2_state1

%same but with measurement integral
abs(2/tspan(end)*trapz(t,exp(1i*omega_0(1)*t).*(y(:, 1) + y(:, 3))))^2 %wb1_state0
abs(2/tspan(end)*trapz(t,exp(1i*omega_1(1)*t).*(y(:, 1) + y(:, 3))))^2 %wb1_state1
abs(2/tspan(end)*trapz(t,exp(1i*omega_0(2)*t).*(y(:, 5) + y(:, 7))))^2 %wb1_state0
abs(2/tspan(end)*trapz(t,exp(1i*omega_1(2)*t).*(y(:, 5) + y(:, 7))))^2 %wb1_state1


4/tspan(end)*trapz(t,abs((y(:, 1) + y(:, 3)).*(y(:, 5) + y(:, 7))).^2)%tatal state

%%% norm(psi)^2
%{
figure;
tiledlayout(2,1)
nexttile 
hold on
plot(t*(freq), abs(y(:, 1)).^2)
plot(t*(freq), abs(y(:, 3)).^2);
plot(t*(freq), abs(y(:, 1)).^2 + abs(y(:, 3)).^2,'--k');
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('|\psi|^2');
legend('|0〉', '|1〉','mixed');
ylim([0 1])
grid on
title('Qubit 1');

% Plot the results
nexttile
hold on
plot(t*(freq), abs(y(:, 5)).^2)
plot(t*(freq), abs(y(:, 7)).^2);
plot(t*(freq), abs(y(:, 5)).^2 + abs(y(:, 7)).^2,'--k');
hold off
xlabel('Moments (s \cdot f_0)');
ylabel('|\psi|^2');
legend('|0〉', '|1〉','mixed');
ylim([0 1])
grid on
title('Qubit 2');

%}


%{
function dydt = odefun( y, omega_0, omega_1, alpha_int, alpha_ext) % omega_0 are vectors
    %y = [x1, v1, x2, v2, x3, v3, x4, v4]; cf 20240814__
    dydt = zeros(length(y), 1);
    %qubit 1
    dydt(1) = y(2); %state 0
    dydt(2) = - omega_0(1)^2 * (y(1) ...
        - alpha_int(1) * (y(3) - y(1)) ... %internal coupling
        - alpha_ext(1,1) * (y(5) - y(1)) ...  %external coupling alpha00
        - alpha_ext(1,2) * (y(7) - y(1)));  %external coupling alpha01
    dydt(3) = y(4); %state 1
    dydt(4) = - omega_1(1)^2  * (y(3) ...
        - alpha_int(1) * (y(1) - y(3)) ... %internal coupling
        - alpha_ext(2,2) * (y(7) - y(3))... %external coupling alpha11
        - alpha_ext(2,1) * (y(5) - y(3)));   %external coupling alpha10

    %qubit 2
    dydt(5) = y(6);%state 0
    dydt(6) = - omega_0(2)^2 * (y(5) ...
        - alpha_int(2) * (y(7) - y(5)) ... %internal coupling
        - alpha_ext(1,1) * (y(1) - y(5)) ...  %external coupling alpha00
        - alpha_ext(2,1) * (y(3) - y(5))); %external coupling alpha10
    dydt(7) = y(8);%state 1
    dydt(8) =  - omega_1(2)^2  * (y(7) ...
        - alpha_int(2) * (y(5) - y(7)) ... %internal coupling
        - alpha_ext(2,2) * (y(3) - y(7)) ... %external coupling alpha11
        - alpha_ext(1,2) * (y(1) - y(7))); %external coupling alpha01
end
%}

%
function dydt = odefun( y, omega_0, omega_1, cpl_int, cpl_ext) % omega_0 are vectors
    %y = [x1, v1, x2, v2, x3, v3, x4, v4]; cf 20240814__
    dydt = zeros(length(y), 1);
    %qubit 1
    dydt(1) = y(2); %state 0
    dydt(2) = - omega_0(1)^2 * y(1) ...
        + cpl_int(1)*omega_0(1)*omega_1(1) * (y(3) - y(1)) ... %internal coupling
        + cpl_ext(1,1)*omega_0(2)*omega_0(1) * (y(5) - y(1)) ...  %external coupling alpha00
        + cpl_ext(1,2)*omega_1(2)*omega_0(1) * (y(7) - y(1));  %external coupling alpha01
    dydt(3) = y(4); %state 1
    dydt(4) = - omega_1(1)^2  * y(3) ...
        + cpl_int(1)*omega_0(1)*omega_1(1) * (y(1) - y(3)) ... %internal coupling
        + cpl_ext(2,2)*omega_1(2)*omega_1(1) * (y(7) - y(3))... %external coupling alpha11
        + cpl_ext(2,1)*omega_0(2)*omega_1(1) * (y(5) - y(3));   %external coupling alpha10

    %qubit 2
    dydt(5) = y(6);%state 0
    dydt(6) = - omega_0(2)^2 * y(5) ...
        + cpl_int(2)*omega_0(2)*omega_1(2) * (y(7) - y(5)) ... %internal coupling
        + cpl_ext(1,1)*omega_0(1)*omega_0(2) * (y(1) - y(5)) ...  %external coupling alpha00
        + cpl_ext(2,1)*omega_1(1)*omega_0(2) * (y(3) - y(5)); %external coupling alpha10
    dydt(7) = y(8);%state 1
    dydt(8) =  - omega_1(2)^2  * y(7) ...
        + cpl_int(2)*omega_0(2)*omega_1(2) * (y(5) - y(7)) ... %internal coupling
        + cpl_ext(2,2)*omega_1(1)*omega_1(2) * (y(3) - y(7)) ... %external coupling alpha11
        + cpl_ext(1,2)*omega_0(1)*omega_1(2) * (y(1) - y(7)); %external coupling alpha01
end
%}