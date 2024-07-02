%%% UPDATED: 08.11.2023
%%% DISPERSION VIA TRANSFER MATRIX METHOD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
clf

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox'));%
addpath('./__fun');


%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct();

p.A = 0.02;% source gain (Pa)
p.rho = [1;1];

p.theta = [pi;0]; %[0;pi]  = [omega_0, omega_1]
p.phi = [0;0]; %dephase of omega_1 w/r to omega_0

%correct wavebit amplitude difference and hamonics
p.rho_corr = [1.25;1];
p.harm_corr = [5;13];
%% MEASURE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
signal_raw = SG__measure(p); %with updated parameters

%% GET DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
raw_time = seconds(signal_raw.Time); %raw_time = raw_time -raw_time(1);
raw_data = signal_raw.Variables; %Pa
%%  PROCESS

%%% TWO PHASE LOCKIN TECHNIQUE 
t = raw_time - raw_time(1);%!!!!$
[theta_0,phi_0]  = read_state(p,t,raw_data(:,1)) %%  outputs plot in deg
%[theta_1,phi_1]  = read_state(p,t,raw_data(:,2)); %%  outputs plot

[F,P1] = onesideft(raw_data(:,1),p.fs_ctr,1);
[F,P2] = onesideft(raw_data(:,2),p.fs_ctr,1);

%% GRAPHICS 
%%% see https://link.springer.com/content/pdf/10.1007/978-3-030-84300-7.pdf, p 69
close
%{
figure(1)
hold on
plot(t,raw_data(:,1))
plot(t, real(cos(p.theta(1)/2)*exp(-1i*p.omega_0*t) + sin(p.theta(1)/2)*exp(1i*p.phi(1))*exp(-1i*p.omega_1*t)))
hold off
%}

%{
figure(2)
hold on
plot(t,U_raw,'-','LineWidth',2)
plot(t,R_omega_0*real(exp(-1i*(p.omega_0*t + phi_omega_0))),'--','LineWidth',1)
plot(t,R_omega_1*real(exp(-1i*(p.omega_1*t + phi_omega_1))),'--','LineWidth',1)
plot(t,real(R_omega_0*exp(-1i*(p.omega_0*t + phi_omega_0)) + R_omega_1*exp(-1i*(p.omega_1*t + phi_omega_1))),'-','LineWidth',1)
%plot(t,real(exp(-1i*phi_omega_0)*(R_omega_0*exp(-1i*(p.omega_0*t)) + exp(1i*(phi_omega_0 - phi_omega_1))*R_omega_1*exp(-1i*(p.omega_1*t)))),'-','LineWidth',1)
hold off
box on
xlim([0 5/p.freq_0])
legend("raw","\psi_0","\psi_1","\psi")
title("")
%}


%%% bode plots
%%% wb 1
tol = 0.1;
P1_temp = P1;
P1_temp(abs(P1_temp) < tol) = 0;
theta1 = angle(P1_temp);

figure(2)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
%plot(F,movmean(angle(P1),50)/pi);
stem(F,theta1/pi,'filled')
ylim([-1 1])
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])

%%% wb 2
%{
tol = 0.01;
P2_temp = P2;
P2_temp(abs(P2_temp) < tol) = 0;
theta2 = angle(P2_temp);

figure(4)
ax1=subplot(2,1,1);
plot(F,20*log10(abs(P1)));
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
%plot(F,abs(P1));
grid on
ax2=subplot(2,1,2);
%plot(F,movmean(angle(P2),50)/pi);
stem(F,theta2/pi,'filled')
ylim([-1 1])
xline(p.freq_0,'k--') 
xline(2*p.freq_0,'k--')
grid on
linkaxes([ax1 ax2],'x')
xlim([400 1400])
%}

%%% BLOCH SPHERE
figure(3)
% Define polar angles (in radians)
theta = deg2rad(theta_0);
phi =  deg2rad(phi_0);  

% Calculate Bloch coordinates
x = sin(theta) * cos(phi);
y = sin(theta) * sin(phi);
z = cos(theta);
hold on
% Create the Bloch sphere (transparent)
[x_sphere, y_sphere, z_sphere] = sphere(128);
surf(x_sphere, y_sphere, z_sphere, 'FaceAlpha', 0.3, 'EdgeColor', 'none'); % Transparent sphere
colormap copper
shading interp
% Add the state vector (as an arrow)
arrow_length = 1; % Example arrow length (adjust as desired)
arrow_start = [0, 0, 0];
arrow_end = [x, y, z];
arrow_dir = arrow_end - arrow_start;
quiver3(arrow_start(1), arrow_start(2), arrow_start(3), ...
    arrow_dir(1), arrow_dir(2), arrow_dir(3), arrow_length, ...
    'Color', 'r', 'LineWidth', 2);

% Customize the plot (optional)
axis equal;
% Set the axis limits symmetrically around the origin
axis auto;
a = 1.5;
amax = max(abs(a));
axis([-amax, amax, -amax, amax, -amax, amax]);

% Add lines for the axes intersecting at the origin
hold on;
line(xlim, [0, 0], [0, 0], 'Color', 'k');  % X-axis
line([0, 0], ylim, [0, 0], 'Color', 'k');  % Y-axis
line([0, 0], [0, 0], zlim, 'Color', 'k');  % Z-axis

text(-0.05, -0.05, 1.1*amax, '|0\rangle')
text(-0.05, -0.05, -1.1*amax, '|1\rangle')
%text(x(end), y(end), z(end), 'End Point')


title(' Bloch Sphere');
hold off
box off
grid off
axis off

% Adjust view angle (optional)
view(-45, 30); % Example view angle (adjust as desired)

%{
figure()
% Create a scatter plot
scatter3(S10, S20, S30, 'b.');

% Set the axis limits symmetrically around the origin
axis auto;
a = axis;
amax = max(abs(a));
axis([-amax, amax, -amax, amax, -amax, amax]);

% Add lines for the axes intersecting at the origin
hold on;
line(xlim, [0, 0], [0, 0], 'Color', 'k');  % X-axis
line([0, 0], ylim, [0, 0], 'Color', 'k');  % Y-axis
line([0, 0], [0, 0], zlim, 'Color', 'k');  % Z-axis

% Attach labels to the axes
xlabel('X', 'Position', [amax, 0, 0]);
ylabel('Y', 'Position', [0, amax, 0]);
zlabel('Z', 'Position', [0, 0, amax]);

% Customize the plot as needed (title, view angle, etc.)
title('3D Scatter Plot with Axes at Origin');
view(3);
%}
autoArrangeFigures







