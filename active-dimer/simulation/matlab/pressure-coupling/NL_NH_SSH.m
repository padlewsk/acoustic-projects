%% NONLINEAR NON-HERMITIAN SSH MODEL (8 CELLS)
clear all
close all
clc

global N omega
omega = 3.8933e+03; 
N = 8;% number of cells
T = 2*pi/omega;
tspan = [0,20000*T];%linspace(0,100*T,50000);
p0 = [zeros(2*N,1)];% [1;zeros(2*N-1,1)];%zero initial condition
[t,p] = ode45(@nl_nh_ssh, tspan, p0); % x = [p11,p12,p11,p12]

%%
close all
%
%%abs?
clf
figure(1)
%tiledlayout(2,1)
%nexttile
hold on
plot(t/T,abs(p(:,1)),'-')
plot(t/T,abs(p(:,2)),'-')
plot(t/T,abs(p(:,3)),'-.')
plot(t/T,abs(p(:,4)),'-.')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t/T');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')
%ylim([-1,1])
%}



figure(2)
set(gca,'FontSize',20)
%set(gcf,'position',[0, 0, 800, 1000]);
hold on
image([1:2*N],t/T,abs(p(:,[1:2*N])),'CDataMapping','scaled')% all resonators
c = colorbar;
c.Label.String = 'Amplitude';
%caxis([0 1]), %clim after 2022a!!!!
xlabel("site (N)",'Interpreter','latex')
ylabel("t",'Interpreter','latex')
xlim([0.5,2*N+0.5])
ylim([t(1)/T,t(end)/T])
%title("Transmission peak as a function of local disorder")

%box on

%}

%{
nexttile
hold on
plot(t,angle(p(:,1))/pi,'-')
plot(t,angle(p(:,2))/pi,'--')
plot(t,angle(p(:,3))/pi,'-')
plot(t,angle(p(:,4))/pi,'--')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t');
ylabel('Phase (rad/pi)');
ylim([-1,1])
%legend('p_{11}','p_{12}','p_{21}','p_{22}')
%}
%% functions
function dpdt = nl_nh_ssh(t,p)
global omega;
global N;
% number of cells
c0 = 347;
a = 0.28;
T = 2*pi/omega; %1/freq
t0 = 200*T;% delay
tau = 100*T;% width


src =  exp(-1i*(omega*t)) + 0*exp(-1i*(omega*t)-(t-t0)^2/tau^2); %% physicist time convention!!!
epsilon = 1; %linear coupling of src to first resonator
%p(1) = p(1) + src;

Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)
gamma = 0*exp(t*(-Rms + sqrt(Rms^2 - 4*Mms*Cmc))/(2*Mms)); %loss function (neglect for now!)
omega0 = 3.8933e+03; %c0/a/(2*pi)/2

lambda_L  = 0.5; % 0 --> v = w
lambda_NL = 0; % >0

K = 1/2 + 53.25*0; %% daily 20230308x§

v = K*(1+lambda_L);
w = K*(1-lambda_L);


M = []; %N sites;
for ii = 1:2*N %row
    for jj = 1:2*N %column
        if jj == ii % reference to the diagonal
            M(ii,jj)  = omega0-1i*gamma; 
            if ii == 1 % edge exception
                M(ii,jj+1)  =  v;
                %M(ii,2*N)  =  w; %Born–von Karman boundary conditions
            elseif ii == 2*N  % edge exception
                M(ii,jj-1)  =  v; 
                %M(ii,1)  =  w; %Born–von Karman boundary conditions
            else
                W = (w + lambda_NL*(abs(p(jj+1))^2 + abs(p(jj))^2)); % check this!
                %W_m = (w + lambda_NL*(abs(p(jj-2))^2 + abs(p(jj+1))^2));
                if mod(ii,2) == 1 && mod(jj,2) == 1  % A site 
                    M(ii,jj+1)  =  v; 
                    M(ii,jj-1)  =  W ; 
                elseif mod(ii,2) == 0 && mod(jj,2) == 0 %B site
                    M(ii,jj-1)  =  v; 
                    M(ii,jj+1)  = W; 
                end
            end
        end 
    end
end



%{
W_p = (w + lambda_NL*(abs(p(3))^2 + abs(p(2))^2));
W_m = (w + lambda_NL*(abs(p(1))^2 + abs(p(4))^2));

M = [
        omega0-1i*gamma ,    v,         0,       0*W_p    ;
            v,    omega0-1i*gamma,    W_p,        0    ;
            0,      W_m,    omega0-1i*gamma,      v    ;
           0*W_m,       0,         v,      omega0-1i*gamma;
    ];
%}
dpdt = -1i*(M*p(:) + [epsilon*src; zeros(2*N-1,1)]); % p(:) = [p(1),p(2),...,P(2N)] and [epsilon*src;zeros(2*N-1,1)]) = [epsilon*src,0,0,...,0]
end