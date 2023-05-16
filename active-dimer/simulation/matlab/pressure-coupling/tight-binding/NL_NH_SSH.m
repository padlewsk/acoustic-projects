%% NONLINEAR NON-HERMITIAN SSH MODEL (8 CELLS)
clear all
close all
clc

% cutoff frequency = c0/a =  1.2393e+03
%test
%% PARAMETERS

% excitation angular frequency
global N freq_samp freq_src t_0 t_1 tspan
freq_src = 1; %SOURCE FREQ


freq_samp =  1*1.2393e+03; % must be at least equal to the cutoff frequency

N = 64;
t_0 = 0;    
t_1 = 2*N/freq_samp ; %also in function of K
% number of cells
c0 = 347;
a = 0.28;

tspan = t_0:1/freq_samp:t_1; % equal spacing required for FFT
xspan = 0:a/2:a*N;

%% SIMULATION

%%% initial condition
p0 = zeros(2*N,1); %zeros(4*N,1); 
p0(1) = 1;%2*N+    %δ-function type input at the site n = 1 initially,
%p0 = 2*rand(2*N,1)-1; 
%p0 = ones(4*N,1) ;%+ 0.2*(2*rand(2*N,1)-1);


%%% dynamics
[t_raw,p_raw] = ode45(@nl_nh_ssh, tspan, p0); 
p_raw = p_raw(:,(end-2*N+1):end);


%{
%Conservation rule:
x = 1:length(t_raw);
for idx =  1:length(t_raw)
    SS(idx) = sum(abs(p_raw(idx,:)).^2);
end
figure()
plot(SS)
%}
%% FIGURES
close all

%%% Time domain plot of edge sites
figure(1)
%tiledlayout(2,1)
%nexttile
hold on
plot(t_raw,real(p_raw(:,1)),'-')
plot(t_raw,real(p_raw(:,2)),'-')
plot(t_raw,real(p_raw(:,3)),'-.')
plot(t_raw,real(p_raw(:,4)),'-.')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t/T');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')
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

%{
figure(3)
set(gca,'FontSize',20)
%set(gcf,'position',[0, 0, 800, 1000]);
hold on
B = image(1:2*N,t_raw,abs(p_raw(:,1:2*N)),'CDataMapping','scaled')% all resonators
c = colorbar;
c.Label.String = 'Amplitude';
%caxis([0 1]), %clim after 2022a!!!!
xlabel("site (N)",'Interpreter','latex')
ylabel("t",'Interpreter','latex')
xlim([0.5,2*N+0.5])
ylim([t_raw(1),t_raw(end)])
%title("Transmission peak as a function of local disorder")
box on
%}

%{
Z = peaks+10;
figure()
surf(Z)
hold on 
image(Z,'CDataMapping','scaled')
%}

%%% FRENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% omit first data points
p_seg = p_raw(:,:);%p_raw(100:end,1+11:end-12);% segment p_raw(10:end,5:2*N);
t_seg = t_raw;%t_raw(100:end);

Y = fft2(p_seg);
Y = min(max(abs(Y), 0), 100); % CONTRAST ADJUST!

NFFT_f = length(t_seg); % signal lengh
omega = 2*pi*freq_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1)) + pi*c0/a; %- 0.5/NFFT_f is to center the plot! minus because waves are propagating left to right?
%omega = 2*pi*freq_samp/2*((0:(NFFT_f-1))/(NFFT_f-1));% 0*(2*pi*c0/a/2)/2; 

NFFT_qa = length(p_seg);
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1)); % q*a*N)

figure(3)
set(gca,'FontSize',20)
set(gcf,'position',[0, 0, 800, 1000]);
hold on
imagesc(qa/pi,omega/(2*pi),abs(fftshift(Y)));% all resonators

yline([422.380 c0/a/2],'r--',{'Local','Bragg'},'LineWidth',2);

hold off
c = colorbar;
c.Label.String = 'Amplitude';
xlabel("$q/\pi$",'Interpreter','latex')
%ylabel("$(\omega-\omega_0)/(2\pi)$",'Interpreter','latex')
ylabel("$\omega/(2\pi)$",'Interpreter','latex')
xlim([-1,1])
ylim([-freq_samp/2+ c0/a/2 freq_samp/2+ c0/a/2])
%ylim([0 c0/a/2])
%title("Transmission peak as a function of local disorder")



  %{
P_f = fft(p_seg,'',1); %fft across the colomn
P_f = abs(P_f/NFFT_f); %two-sided spectrum 
P_f = P_f(1:NFFT_f/2+1,:); %single-sided spectrum 
P_f(2:end-1,:) = 2*P_f(2:end-1,:); % Double the amplitude to account for single-sided spectrum

%{
% Determine the modes of vibration
[peaks,locs] = findpeaks(P1,f); % Find peaks in the frequency response
frequencies = f(locs); % Get frequencies of the peaks
wavelengths = 2*pi*speed_of_sound./frequencies; % Calculate wavelengths based on speed of sound
%}

NFFT_q = 2*N;
q = 2*pi*(a/2)*(0:(NFFT_q/2))/NFFT_q;

P_q = fft(p_seg,'',2); %fft across the rows
P_q = abs(P_q/NFFT_q); % two-sided spectrum 
P_q = P_q(1:NFFT_q/2+1,:); % single-sided spectrum 
P_q(2:end-1,:) = 2*P_q(2:end-1,:); % Double the amplitude to account for single-sided spectrum

figure(3)
set(gca,'FontSize',20)
%set(gcf,'position',[0, 0, 800, 1000]);
hold on
image(P_f,'CDataMapping','scaled')% all resonators
%image(q*pi/a,freq,abs(P_q),'CDataMapping','scaled')% all resonators
c = colorbar;
c.Label.String = 'Amplitude';
%caxis([0 1]), %clim after 2022a!!!!
xlabel("qa/pi",'Interpreter','latex')
ylabel("freq",'Interpreter','latex')
%xlim([0,1])
%ylim([0,1])
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
%% FUNCTIONS
function dpdt = nl_nh_ssh(t,p)
global freq_samp freq_src N tspan;

% number of cells
c0 = 347;
a = 0.28;
omega_0 = 0*2*pi*c0/a/2; % self-resonnance:c0/a/(2*pi)/2 --> shifts the spectrum up

% source parameters
omega_src = 2*pi*freq_src;
T_src = 1/freq_src; %1/freq

% pulse parameters
t0 = 3*T_src;% delay
tau = 1*T_src;% width

%src = exp(1i*(omega_src*t))*exp(-(t-t0)^2/tau^2); %% PULSE. physicist time convention!!!
src = (rand-0.5);%[-0.5,0.5}

%{
c = 2/(t_1-t_0);%(f1-f0/T)
src =exp(+1i*(0.5*c*t^2));
%}

%[tt,beta] = ode45(@dbetadt,tspan,[1; 0]); % tspan*0 + 
%beta = beta(:,2);
%gamma = diff(beta)./diff(t);% this is the "finite difference" derivative. Note it is  one element shorter than y and x
%td = (t(2:end) + t(1:(end-1)))/2; % this is to assign yd an abscissa midway between two subsequent x

lambda_L  = 0.2; % 0 --> v = w
lambda_NL = 0; % >0

K = pi*(c0/a)/2; %0*1/2*(2*pi*freq_cut/2); %--> 1/2*(omega_cut/2) cutoff freq
v = K*(1+lambda_L);
w = K*(1-lambda_L);

%%% LOSS FUNCTION
%
Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)     
%{
lambda_m = (-Rms - sqrt(Rms^2 - 4*Mms*(1/Cmc - Rms)))/(2*Mms); % m has biggest contribution
lambda_p = (-Rms + sqrt(Rms^2 - 4*Mms*(1/Cmc - Rms)))/(2*Mms);
gamma = 0*pi*(c0/(a))*(Rms/2)*(exp(t*lambda_p) - exp(t*lambda_m));%Rms/2* loss function (scaled)
%}
gamma = 0;

disorder = 0;
M = []; %N sites;
for ii = 1:2*N %row
    for jj = 1:2*N %column
        if jj == ii % reference to the diagonal
            M(ii,jj)  = omega_0 - 1i*gamma;% *exp(1i*2*pi*(ii - mod(ii-1,2))/2);
            if ii == 1 % edge exception
                M(ii,jj+1)  =  v*(1+disorder*2*(rand-0.5));
                %M(ii,2*N)  =  w; %Born–von Karman boundary conditions
            elseif ii == 2*N  % edge exception
                M(ii,jj-1)  =  v*(1+disorder*2*(rand-0.5)); 
                %M(ii,1)  =  w; %Born–von Karman boundary conditions
            else
                W = (w + lambda_NL*K*(abs(p(jj+1))^2 + abs(p(jj))^2)); % check this!
                if mod(ii,2) == 1 && mod(jj,2) == 1  % A site 
                    M(ii,jj+1)  =  v*(1+disorder*2*(rand-0.5)); 
                    M(ii,jj-1)  =  W*(1+disorder*2*(rand-0.5)) ; 
                elseif mod(ii,2) == 0 && mod(jj,2) == 0 %B site
                    M(ii,jj-1)  =  v*(1+disorder*2*(rand-0.5)); 
                    M(ii,jj+1)  =  W*(1+disorder*2*(rand-0.5)); 
                end
            end
        end 
    end

end
    if t ==tspan(2)
        M(1:4,1:4)
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
%dpdt = [p(1:2*N); -1i*(M*p((1:2*N)+2*N)) - 1/Mms*(Rms*p(1:2*N)+1/Cmc*p((1:2*N)+2*N))]; %  +  0*src*ones(2*N,1) + 0*[src; zeros(2*N-1,1)]% p(:) = [p(1),p(2),...,P(2N)] and [epsilon*src;zeros(2*N-1,1)]) = [epsilon*src,0,0,...,0]
dpdt =  -1i*M*p(1:2*N); 
end

function dbdt = dbetadt(t,p)
    Rms	= 0.261*0.2;	% mechanical resistance
    Mms	= 6.670769e-04; % moving mass (kg)
    Cmc	= 2.128414e-04; % mechanical compliance (N/m)
    dbdt = [p(2); -1/Mms*(Rms*p(2)+1/Cmc*p(1))];
end
