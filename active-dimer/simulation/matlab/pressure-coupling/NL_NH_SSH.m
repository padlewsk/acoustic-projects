%% NONLINEAR NON-HERMITIAN SSH MODEL (8 CELLS)
clear all
close all
clc

%% PARAMETERS

% excitation angular frequency
global N freq_src
freq_src = 1000;

f_samp = 10000;
% number of cells
N = 2;
c0 = 347;
a = 0.28;


tspan = 0:1/f_samp:1; % equal spacing required for FFT
xspan = 0:a/2:a*N;

%% SIMULATION
% initial condition
p0 = [zeros(2*N,1)];% [1;zeros(2*N-1,1)];
[t_raw,p_raw] = ode45(@nl_nh_ssh, tspan, p0); 
%% FIGURES
close all


figure(1)
%tiledlayout(2,1)
%nexttile
hold on
plot(t_raw,abs(p_raw(:,1)),'-')
plot(t_raw,abs(p_raw(:,2)),'-')
plot(t_raw,abs(p_raw(:,3)),'-.')
plot(t_raw,abs(p_raw(:,4)),'-.')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t/T');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')
%ylim([-1,1])
%}

%%% p(t,N)
figure(2)
set(gca,'FontSize',20)
%set(gcf,'position',[0, 0, 800, 1000]);
hold on
image(1:2*N,t_raw,abs(p_raw(:,1:2*N)),'CDataMapping','scaled')% all resonators
c = colorbar;
c.Label.String = 'Amplitude';
%caxis([0 1]), %clim after 2022a!!!!
xlabel("site (N)",'Interpreter','latex')
ylabel("t",'Interpreter','latex')
xlim([0.5,2*N+0.5])
ylim([t_raw(1),t_raw(end)])
%title("Transmission peak as a function of local disorder")
box on

%%% p(omega,q)
fs = 1/(t_raw(2)-t_raw(1));
NFFT_f = length(t_raw); % signal lengh
freq = fs*(0:(NFFT_f/2))/NFFT_f;

P_f= fft(p_raw,'',1);
P_f = abs(P_f/NFFT_f); %two-sided spectrum 
P_f = P_f(1:NFFT_f/2+1,:); %single-sided spectrum 
P_f(2:end-1,:) = 2*P_f(2:end-1,:);


NFFT_q = 2*N;
q = 2*pi*(a/2)*(0:(NFFT_q/2))/NFFT_q;

P_q = fft(P_f,'',2);
P_q = abs(P_q/NFFT_q); %two-sided spectrum 
P_q = P_q(1:NFFT_q/2+1,:); %single-sided spectrum 
P_q(2:end-1,:) = 2*P_q(2:end-1,:);

figure(3)
set(gca,'FontSize',20)
%set(gcf,'position',[0, 0, 800, 1000]);
hold on
image(q*pi/a,freq,abs(P_f),'CDataMapping','scaled')% all resonators
c = colorbar;
c.Label.String = 'Amplitude';
%caxis([0 1]), %clim after 2022a!!!!
xlabel("qa/pi",'Interpreter','latex')
ylabel("freq",'Interpreter','latex')
xlim([-1,1])
ylim([0,max(freq)])
%title("Transmission peak as a function of local disorder")

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

src =  omega_src/2*exp(+1i*(omega_src*t))*0 + omega_src/2*exp(1i*(omega_src*t)-(t-t0)^2/tau^2); %% physicist time convention!!!


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
                    M(ii,jj+1)  =  W; 
                end
            end
        end 
    end
end

%phase_vec = [exp(1i*a/2*(1:2*N))]';
%p(:) = p(:).*phase_vec;
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
dpdt = -1i.*(M*p(:) + [src; zeros(2*N-1,1)]); % p(:) = [p(1),p(2),...,P(2N)] and [epsilon*src;zeros(2*N-1,1)]) = [epsilon*src,0,0,...,0]
end