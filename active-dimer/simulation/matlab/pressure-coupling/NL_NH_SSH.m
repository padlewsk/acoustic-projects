%% NONLINEAR NON-HERMITIAN SSH MODEL (8 CELLS)
clear all
close all
clc

%% PARAMETERS

% excitation angular frequency
global N freq_src
freq_src = 2000;
T_src = 1/freq_src;
% number of cells
N = 2;


tspan = 0:T_src/100:(5000-1/100)*T_src; % equal spacing required for FFT
%% SIMULATION
% initial condition
p0 = [zeros(2*N,1)];% [1;zeros(2*N-1,1)];
[t_sig,p_sig] = ode45(@nl_nh_ssh, tspan, p0); 
%% PROCESSING
%p(t,x) --> p(omega,q)
fs = 1/(t_sig(2)-t_sig(1));
L_sig = length(t_sig); % signal lengh

P = fft(p_sig);
P = abs(P/L_sig); %two-sided spectrum 
P = P(1:L_sig/2+1,:); %single-sided spectrum 
P(2:end-1,:) = 2*P(2:end-1,:);

freq_sig = fs*(0:(L_sig/2))/L_sig;

figure(3)
semilogy(freq_sig,P) 
title("Single-Sided Amplitude Spectrum of P(t)")
xlabel("f (Hz)")
ylabel("|P(f)|")
xlim([0,2000])

%{
figure(4)
hold on
plot(tspan,real(conj(p_sig(:,1))))
plot(tspan,imag(conj(p_sig(:,1))))
hold off
%}
%% FIGURES
%%abs?

figure(1)
%tiledlayout(2,1)
%nexttile
hold on
plot(t_sig/T_src,abs(p_sig(:,1)),'-')
plot(t_sig/T_src,abs(p_sig(:,2)),'-')
plot(t_sig/T_src,abs(p_sig(:,3)),'-.')
plot(t_sig/T_src,abs(p_sig(:,4)),'-.')
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
image([1:2*N],t_sig/T_src,abs(p_sig(:,[1:2*N])),'CDataMapping','scaled')% all resonators
c = colorbar;
c.Label.String = 'Amplitude';
%caxis([0 1]), %clim after 2022a!!!!
xlabel("site (N)",'Interpreter','latex')
ylabel("t",'Interpreter','latex')
xlim([0.5,2*N+0.5])
ylim([t_sig(1)/T_src,t_sig(end)/T_src])
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
%% FUNCTION
function dpdt = nl_nh_ssh(t,p)
global freq_src;
global N;
% number of cells
c0 = 347;
a = 0.28;
omega_0 = 2*pi*1000; %c0/a/(2*pi)/2

omega_src = 2*pi*freq_src;
T_src = 2*pi/omega_src; %1/freq

t0 = 10*T_src;% delay
tau = 3*T_src;% width

src =  0*omega_src/2*exp(+1i*(omega_src*t)) + omega_src/2*exp(1i*(omega_src*t)-(t-t0)^2/tau^2); %% physicist time convention!!!

Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)
gamma = 0*exp(t*(-Rms + sqrt(Rms^2 - 4*Mms*Cmc))/(2*Mms)); %loss function (neglect for now!)


lambda_L  = 0; % 0 --> v = w
lambda_NL = 0; % >0

K = 1/2; %%53.25 daily 20230308x§

v = K*(1+lambda_L);
w = K*(1-lambda_L);

M = []; %N sites;
for ii = 1:2*N %row
    for jj = 1:2*N %column
        if jj == ii % reference to the diagonal
            M(ii,jj)  = omega_0-1i*gamma; 
            if ii == 1 % edge exception
                M(ii,jj+1)  =  v;
                %M(ii,2*N)  =  w; %Born–von Karman boundary conditions
            elseif ii == 2*N  % edge exception
                M(ii,jj-1)  =  v; 
                %M(ii,1)  =  w; %Born–von Karman boundary conditions
            else
                W = (w + lambda_NL*(abs(p(jj+1))^2 + abs(p(jj))^2)); % check this!
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
dpdt = -1i.*(M*p(:)+ [src; zeros(2*N-1,1)]); % p(:) = [p(1),p(2),...,P(2N)] and [epsilon*src;zeros(2*N-1,1)]) = [epsilon*src,0,0,...,0]
end