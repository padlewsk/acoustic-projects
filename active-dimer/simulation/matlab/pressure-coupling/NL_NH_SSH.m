%% NONLINEAR NON-HERMITIAN SSH MODEL (8 CELLS)
clear all
close all
clc

global freq
freq = 1.2393e+03/2

tspan = linspace(0,100/freq,5000);
p0 = [
    [0; 0];[0; 0]
      ];
[t,p] = ode45(@nl_nh_ssh, tspan, p0); % x = [p11,p12,p11,p12]


figure(1)
hold on
plot(t,abs(p(:,1)),'-')
plot(t,abs(p(:,2)),'-')
plot(t,abs(p(:,3)),'-')
plot(t,abs(p(:,4)),'-')
hold off

%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')


function dpdt = nl_nh_ssh(t,p)
global freq;
c0 = 347;
a = 0.28;
t0 = 5/freq;
tau = 0.001;

src = 0.5*(-1i*2*pi*freq)*exp(-1i*2*pi*freq*t)+0*exp(-(t-t0)^2/(2*tau^2)); %% physicist time convention!!!
epsilon = 1; %linear coupling of src to first resonator
%p(1) = p(1) + src;


Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)
gamma = 0*exp(t*(-Rms + sqrt(Rms^2 - 4*Mms*Cmc))/(2*Mms)); %loss function (neglect for now!)

lambda_L  = 0.13; % 0 --> v = w
lambda_NL = 0; % >0

K = 53.25; %% daily 20230308

v = K*(1+lambda_L); %% daily 20230308
w = K*(1-lambda_L);


W_p = (w + lambda_NL*(abs(p(3))^2 + abs(p(2))^2));
W_m = (w + lambda_NL*(abs(p(1))^2 + abs(p(4))^2));

M = [
        -1i*gamma ,    v,         0,       W_p    ;
            v,    -1i*gamma,    W_p,        0    ;
            0,      W_m,    -1i*gamma,      v    ;
            W_m,       0,         v,      -1i*gamma;
    ];

dpdt = -1i*(M*[p(1);p(2);p(3);p(4)]+[epsilon*src;0;0;0]);
end