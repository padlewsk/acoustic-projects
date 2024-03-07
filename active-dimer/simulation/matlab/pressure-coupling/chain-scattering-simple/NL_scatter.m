%% NONLINEAR SCATTERING CHAIN (-> PSEUDO SSH, OMIT LOCAL RESONANCE)
clear all
close all
clc
% cutoff frequency = c0/a =  1.2393e+03
%% PARAMETERS

c0 = 347;
a = 0.28; %unitcell size
% excitation angular frequency
global N freq_samp  t_0 t_1 tspan
freq_cutoff = c0/a;
freq_samp =  2*freq_cutoff; % ??? Why does the dispersion change if sample freq changes...
N = 64;
t_0 = 0;    
t_1 = 1*N/freq_cutoff  ; %also in function of K
tspan = (t_0:1/freq_samp:t_1)'; % equal spacing required for FFT

%% SIMULATION
%%% initial condition
p0 = zeros(2*N,1); %zeros(4*N,1); 
p0(1) = 0;%2*N+    %δ-function type input at the site n = 1 initially,
%p0(2*N) = 8;
%%% dynamics
%[t_raw,p_raw] = ode45(@nl_nh_ssh, tspan, p0); 
%
opts = odeset('Reltol',1e-13,'Refine',8,'Stats','on');
[t_raw,p_raw] = ode89(@nl_nh_ssh, [t_0 t_1], p0,opts); % automatically selects appropriate timescale
%}
p_interp = interp1(t_raw,p_raw,tspan);
t_interp = tspan;
%}
%p_interp= p_interp(:,(end-2*N+1):end);

%% FIGURES
close all
%%% Time domain plot of edge sites
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
legend('|p_{11}|','|p_{12}|','|p_{21}|','|p_{22}|')
%ylim([-1,1])
%}

%%% TIME DOMAIN p(t,N) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%surface plot
[X,Y] = meshgrid(1:2*N,t_raw*freq_samp);
Z = abs(p_raw(:,:));

figure(2) % \Delta t simulation time step
%colormap hot
set(gca,'FontSize',20)
surface(X,Y,Z,'EdgeColor','none')
xlim([0.5,2*N+0.5])
ylim([t_raw(1),t_raw(end)]*freq_samp)
xlabel("site",'Interpreter','latex')
ylabel("$t/\Delta t$",'Interpreter','latex')
zlabel("$|\psi_n|$",'Interpreter','latex')
box on
grid on
view(45,60)
%}

%%% FRENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% omit first data points
p_seg = p_interp(:,:);
t_seg = t_interp;

%% amplitude difference between a and b sites
delta = abs(p_seg(:,2:2:end)) - abs(p_seg(:,1:2:end-1)); %amplitude difference between a and b sites
Y = fft(delta,2^(nextpow2(length(delta(:,1)))));
L = length(t_seg);
P2 = abs(Y/L);
P1 = P2(1:L/2+1,:);
P1(:,2:end-1) = 2*P1(:,2:end-1);
freq = freq_samp/L*(0:(L/2));

figure(4)
for ii = 1:N
plot(freq,P1(:,ii))
hold on
end
hold off

%% DISPERSION
Y = fft2(p_seg,2^(nextpow2(size(p_seg,1))+2),size(p_seg,2))/length(p_seg); %2D FFT --> normalized to get amplitude in (Pa). Extra points are for zero padding.
%Y = fft2(p_seg)/length(p_seg); 
%Y = fftshift(Y); %filters out DC component

NFFT_f = size(Y,1); % signal length
%omega = 2*pi*freq_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1))'+ pi*c0/a; %
omega = -2*pi*freq_samp*((0:(NFFT_f-1))/(NFFT_f-1)) + 2*pi*c0/a;
NFFT_qa = size(Y,2); % signal length
qa = 2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1));

%{
Y = fft2(p_seg);
Y = fftshift(Y,1);

%Y = min(max(abs(Y), 0), 100); % CONTRAST ADJUST!
NFFT_f = length(t_seg); % signal lengh
%omega = 2*pi*freq_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1)) + pi*c0/a; %- 0.5/NFFT_f is to center the plot! minus because waves are propagating left to right?
omega = 2*pi*freq_samp*((0:(NFFT_f-1))/(NFFT_f-1));
NFFT_qa = length(p_seg);
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1)); % q*a*N)
%}
figure(3)
set(gca,'FontSize',20)
set(gcf,'position',[0, 0, 800, 1000]);
hold on
imagesc(qa/(pi),omega/(2*pi),abs(Y));% all resonators
yline(c0/a/2,'r--',{'Bragg'},'LineWidth',1);
%yline([422.380 c0/a/2],'r--',{'Local','Bragg'},'LineWidth',2);
hold off
c = colorbar;
c.Label.String = 'Amplitude';
xlabel("$q/\pi$",'Interpreter','latex')
ylabel("$\omega/(2\pi)$",'Interpreter','latex')
xlim([-1,1])
ylim([-freq_samp/2 + c0/a/2 freq_samp/2 + c0/a/2])

autoArrangeFigures
%% FUNCTIONS
function dpdt = nl_nh_ssh(t,p)
    global N t_0 t_1;
    
    % number of cells
    c0 = 347;
    a = 0.28;
    omega_0 = (2*pi)*(c0/(2*a))*1; % self-resonnance of unitcell cavity (fundamental cavity energy --> first mode)

    %%% CENTER PULSE 
    %
    % gaussian pulse centered at omega_src: P_src \propto  *exp(-(omega-omega_src)^2*(tau^2)) 
    omega_src = (2*pi)*(c0/a)/2;%centering pulse on this frequency
    T_src = (2*pi)/omega_src; %1/freq 
    t0 = 3*T_src;% delay for single pulse %%%%%%%%%%%%%%%%%
    tau = 0.1*T_src/sqrt(2);% width
    A_src = 1; % 1 
    p_src = A_src*exp(1i*(omega_src*t))*exp(-(t-t0)^2/(2*tau^2)); %single pulse
    p(1) = p(1)+ p_src;
    %}
    %%% LINEAR SWEEP
    %{
    f_0 = 1;
    f_1 = c0/a;
    c = (f_1-f_0)/(t_1-t_0);
    p_src =  sin(2*pi*(c*t^2/2 + f_0*t));
    %}
    %%% CONSTANT
    %{
    p_src = sin(2*pi*1200*t); %dispersion is upside down and halved==
    %}

    p(1) = p(1) + p_src;
    lambda_L  = 0.1; % -1 --> v = 0; 0 --> v = w; 1 --> w = 0
    lambda_NL = 0; %
    
    K = (2*pi)*(c0/a)/4;  %--> omega_cutoff/2 --> lambda_L = 1 --> v = (2*pi)*(c0/a)/2 (symmetric coupling)
    K_NL = 0*3e-3*K;

    v = K*(1+lambda_L);
    w = K*(1-lambda_L);
    v_NL = K_NL*(1+lambda_NL);
    w_NL = K_NL*(1-lambda_NL);

    %disorder = 0; %*(1+disorder*2*(rand-0.5))
    M = []; %N sites;
    for ii = 1:2*N % --> row/column % with reference to the matrix diagonal
        M(ii,ii)  = omega_0; % self resonance on diagonal
        if ii == 1 % edge exception 1
            M(ii,ii+1)  =  v + v_NL*(0*abs(p(ii))^2 + abs(p(ii+1))^2); %the ii are the onsite kerr nonlinearities
            %M(ii,2*N)  =  w; %Born–von Karman boundary conditions
        elseif ii == 2*N  % edge exception 2
            M(ii,ii-1)  =  v + v_NL*(0*abs(p(ii))^2 + abs(p(ii-1))^2); %abs(p(ii-1))^2
            %M(ii,1)  =  w; %Born–von Karman boundary conditions
        elseif mod(ii,2) == 1  % --> A site 
            M(ii,ii+1)  =  v + v_NL*(0*abs(p(ii))^2 + abs(p(ii+1))^2); %to right from diagonal 
            M(ii,ii-1)  =  w + w_NL*(0*abs(p(ii))^2 + abs(p(ii-1))^2); %to left from diagonal
        elseif mod(ii,2) == 0  % --> B site
            M(ii,ii-1)  =  v + v_NL*(0*abs(p(ii))^2 + abs(p(ii-1))^2); 
            M(ii,ii+1)  =  w + w_NL*(0*abs(p(ii))^2 + abs(p(ii+1))^2); 
        end   
    end
    %EXPLICIT EXAMPLE FOR 4 SITES :
    %{
    W_p = (w + lambda_NL*(abs(p(3))^2 + abs(p(2))^2));
    W_m = (w + lambda_NL*(abs(p(1))^2 + abs(p(4))^2));
    
    M = [
             omega0 ,    v,         0,        0   ;
                v,     omega0,     W_p,       0   ;
                0,      W_m,     omega0,      v   ;
                0,       0,         v,      omega0;
        ];
    %}

    dpdt =  -1i*M*p(1:2*N); 
end
