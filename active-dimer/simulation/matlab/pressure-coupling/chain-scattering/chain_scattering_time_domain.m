%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%
clear all
close all
clc

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');

%% SETTINGS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FREQ SWEEP RANGE
freq_ini = 100; % initial frequency
freq_fin = 1000; % final frequency
Df = 100; % frequency step

global N_cell %number of unit cells (= half the number of sites)
N_cell = 2; 
mat_size = 9*N_cell-(N_cell-1);

%%% SAMPLING (for post processing --> doesn't affect sim time alot)
f_samp = 5E5;
t_samp = 1/f_samp;

%%% SIMULATION TIME (MATLAB odes use adaptive step size)
t_fin = 0.5; %simulation time in seconds (SHOULD adapt in loop)
tspan_vec =  0:t_samp:t_fin; %This time vector used to interpolate before performing the FFT 

%%% INITIALISATION
y0 = zeros(1,2*mat_size);% solver initial condition %y = [x1,...,xn,q1,...qn]
%y0(mat_size + 3) = Caa*Sd;
    
F = [];     %frequency
R = [];     %reflection
T = [];     %transmission
alpha = []; %absorption

%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("### COMPUTING SPECIFIC ACOUSTIC IMPEDANCE FOR EACH FREQUENCY...\n")
fig1 = figure(1);
set(gca,'FontSize',18) % Creates an axes and sets its FontSize to 18
hold on
freq = 0;
%for f = fi:Df:ff %Hz
    
fprintf("### f = "+ string(freq)+ " Hz \n")
%%% ADAPTATIVE SIMULATION TIME TEST
%tf = 40/f; 
%%%ts = 0.1*(1/f);%10 samples per period
%%%tspan_vec =  0:ts:tf;

%%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%tf = 20/f %20 cycles
tic
[t_out,y_out] = ode78(@(t,y) odecrystal(t,y,freq),[0, t_fin],y0);%dynamically adjusts sampling time
toc
%y_out = [x1,...,xn,q1,...qn]

tic
q = y_out(:,mat_size+1:end);
q_s = q(:,3:4:end); %the third node is where the first speaker is located and then every 4th that follows until the end.e.g. N=1 -> two columns: one for each speaker
p_s = 1/Caa*(q(:,2:4:end) - q(:,3:4:end) - q(:,4:4:end)); %(qi-qs-qo)

%% FIGURES
close all
%%% Time domain plot of edge sites
figure(1)
hold on
plot(t_out,real(p_s(:,1)),'-')
plot(t_out,real(p_s(:,2)),'-')
plot(t_out,real(p_s(:,3)),'-.')
plot(t_out,real(p_s(:,4)),'-.')
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
[X,Y] = meshgrid(1:2*N_cell,t_out*f_samp);
Z = abs(p_s(:,:));

figure(2) % \Delta t simulation time step
%colormap hot
set(gca,'FontSize',20)
surface(X,Y,Z,'EdgeColor','none')
xlim([0.5,2*N_cell+0.5])
ylim([t_out(1),t_out(end)]*f_samp)
xlabel("site",'Interpreter','latex')
ylabel("$t/\Delta t$",'Interpreter','latex')
zlabel("$|\psi_n|$",'Interpreter','latex')
box on
grid on
view(45,60)

%%% FRENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% omit first data points
p_seg = p_s(:,:);%p_s(:,:);%p_raw(100:end,1+11:end-12);% segment p_raw(10:end,5:2*N);
t_seg = t_out(:);%t_out;%t_raw(100:end);

Y = fft2(p_seg);
%Y = min(max(abs(Y), 0), 100); %%%%%% CONTRAST ADJUST! 

NFFT_f = length(t_seg); % signal lengh
omega = 2*pi*f_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1)) + pi*c0/a; %- 0.5/NFFT_f is to center the plot! minus because waves are propagating left to right?
%omega = 2*pi*freq_samp/2*((0:(NFFT_f-1))/(NFFT_f-1));% 0*(2*pi*c0/a/2)/2; 

NFFT_qa = length(p_seg);
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1)); % q*a*N)

figure(3)
set(gca,'FontSize',20)
set(gcf,'position',[0, 0, 800, 1000]);
hold on
imagesc(qa/pi,omega/(2*pi),abs(fftshift(Y)));% all resonators

%yline([422.380 c0/a/2],'r--',{'Local','Bragg'},'LineWidth',2);

hold off
c = colorbar;
c.Label.String = 'Amplitude';
xlabel("$q/\pi$",'Interpreter','latex')
%ylabel("$(\omega-\omega_0)/(2\pi)$",'Interpreter','latex')
ylabel("$\omega/(2\pi)$",'Interpreter','latex')
xlim([-1,1])
ylim([-f_samp/2+ c0/a/2 f_samp/2+ c0/a/2])


%ylim([0 c0/a/2])
%title("Transmission peak as a function of local disorder")




%{
%%% OUTPUT AND PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q_i = y_out(:,mat_size+1);
q_o = y_out(:,2*mat_size);

%%% COMPUTE PRESSURES
psrc = source(A_pinc,f,t_out); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pref = psrc - rho0*c0*q_i;
ptra = rho0*c0*q_o;

%INTERPOLATION (JUST BEFORE FFT)
psrc = interp1(t_out,psrc,tspan_vec);
pref = interp1(t_out,pref,tspan_vec);
ptra = interp1(t_out,ptra,tspan_vec);


%%% CUT: ASSUME LIMIT CYCLE IS ACHEIVED AFTER 10 CYCLES
psrc = psrc(tspan_vec>10/f);
pref = pref(tspan_vec>10/f);
ptra = ptra(tspan_vec>10/f);

%%% FFT
[F1,Pinc] = onesideft(psrc,fs,2); %2sided spectrum, padding
[F2,Pref] = onesideft(pref,fs,2);
[F3,Ptra] = onesideft(ptra,fs,2);

%%% FIND FUNDAMENTAL AMPLITUDE
Pinc_idx = find(abs(Pinc) == max(abs(Pinc)));
Pref_idx = find(abs(Pref) == max(abs(Pref)));
Ptra_idx = find(abs(Ptra) == max(abs(Ptra)));

Pinc_f0 = Pinc(Pinc_idx);
Pref_f0 = Pref(Pref_idx);
Ptra_f0 = Ptra(Ptra_idx);

%%% FREQUENCY
F_temp = f;  

%%% REFLECTION COEF:
R_temp = Pref_f0/Pinc_f0;
%%% TRANSMISSION COEF:
T_temp = Ptra_f0/Pinc_f0;
%%% ABSORBTION COEF:
alpha_temp = 1 - abs(R_temp)^2 - abs(T_temp)^2;

%%% LOG
F = [F,F_temp];
R = [R,R_temp];
T = [T,T_temp];
alpha = [alpha,alpha_temp]; %transmission loss or inserstion loss

%%% FIGURE LOOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf, 'Position',  [100, 100, 1600, 1000])

%%% DIAPHRAGM DISPL.
subplot(2,2,1);
plot(t_out*1000, y_out(:,3)*1000) 
grid on
box on%Pinc
xlim([0,tf*1000 + 0*(500/ff)*1000])
%ylim([-5E-4 5E-4])
xlabel("Time (ms)")
ylabel("Diaphragm displacement (mm)")
str = {'$$ \xi_{s} $$'};
legend(str, 'Interpreter','latex', 'Location','NW')
set(gca,'FontSize',18) 

%%% REF&TRA PRESSURES
subplot(2,2,2);
set(gca,'FontSize',18) 
hold on
%plot(F1,Pinc,'-')
plot(F3,Ptra,'-', 'Color', [0 0 1 0.4],'Linewidth',1)
plot(F2,Pref,'-', 'Color', [1 0 0 0.4],'Linewidth',1)
plot(F_temp,abs(Ptra_f0),'.b','MarkerSize',20)
plot(F_temp,abs(Pref_f0),'.r','MarkerSize',20)
hold off
box on
grid on
xlim([0 1000]);
ylim([0 A_pinc]);
xlabel("Frequency (Hz)")
ylabel("Amplitude (Pa)")
%%str = {'$$ max(FFT(P_{ref})) $$','$$ max(FFT(P_{tra})) $$'};
str = {'$$ FFT(p_{tra}) $$','$$ FFT(p_{ref}) $$'};
legend(str, 'Interpreter','latex', 'Location','NW')

%{
%%% FFTS
subplot(2,3,3);
set(gca,'FontSize',18) 
hold on
plot(F_temp,abs(Ptra_f0),'ob')
plot(F_temp,abs(Pref_f0),'or')
hold off
box on
grid on
xlim([0 1000]);
ylim([0 A_pinc]);
xlabel("Frequency (Hz)")
ylabel("Amplitude (Pa)")
str = {'$$ max(FFT(P_{tra})) $$','$$ max(FFT(P_{ref})) $$'};
%str = {'$$ P_{ref} $$','$$ P_{tra} $$'};
legend(str, 'Interpreter','latex', 'Location','NW')
%}

%%% REF,TRA,ABS COEFS
subplot(2,2,[3,4]); 
set(gca,'FontSize',18) 
hold on
plot(F,alpha,'o-','color',[0, 0.4470, 0.7410])
plot(F,abs(R),'o-','color',[0.8500, 0.3250, 0.0980])
plot(F,abs(T),'o-','color',[0.9290, 0.6940, 0.1250])
hold off
xlim([fi,ff])
ylim([0,1])
xlabel("Frequency (Hz)")
box on
grid on
str = {'$\alpha$','R','T'};
legend(str, 'Interpreter','latex', 'Location','NW')

drawnow
%}
toc

%end
hold off

%% FIGURES
%{
%close all
%%% Figure 2
%clf
fig2 = figure(2);
set(gca,'FontSize',18,'LineWidth',1) 
hold on
%plot(F, Zs)
plot(F,alpha,'LineWidth',2)%xi
plot(F,abs(R),'LineWidth',2)%xi
plot(F,abs(T),'LineWidth',2)%xi
xlabel("Frequency (Hz)")
hold off
box on
grid on
str = {'$\alpha$','R','T'};
legend(str, 'Interpreter','latex', 'Location','NW')
%}

%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% PRESSURE SOURCE (sin) 
function S = source(amp,freq,time)
S = amp*sin(2*pi*freq*time); 
end


%{
function dydt = oderes(t,y,f)
    run('params.m');
    
    x = y(1:3); % [x_i, x_s, x_o] = [y(1), y(2), y(3)]; %acoustic displacement
    q = y(4:6); % [v_i, v_s, v_o] = [y(3), y(4), y(5)]; %acoustic velocity
   
        pinc = source(A_pinc,f,t); %source pressure
        P = [2*pinc - Zc*q(1);  0;  Zc*q(3)];

        %mass term
        M = [
           Maa/2, 0,    0  ;
             0 ,  Mas,    0  ;
             0 ,   0 , -Maa/2;
            ];
        %resistance term
        R = [
            0,  0, 0;
            0, Ras, 0;
            0,  0  ,0;
            ];
        %complicance term
        K = [
             1/Caa,    -1/Caa   , -1/Caa  ;
            -1/Caa,  1/Cac+1/Caa,  1/Caa;
             1/Caa,    -1/Caa   , -1/Caa;
            ];
    
    a = inv(M)*(P - R*q - K*x);%acoustic acceleration
    
    dydt = zeros(6,1);
    dydt(1:3) = q; %[v_i, v_s, v_o]
    dydt(4:6) = a; %[a_i, a_s, a_o]
end

function dydt = odetube(t,y,f)
    run('params.m');
    
    x = y(1:2); % [x_i, x_o] = [y(1), y(2)]; %acoustic flow displacement
    q = y(3:4); % [v_i, v_o] = [y(3), y(4)]; %acoustic flow velocity
   
    pinc = source(A_pinc,f,t); %source pressure
    P = [2*pinc - Zc*q(1); Zc*q(2)];

    %mass term
    M = [
       Mab/2,    0  ;
         0  , -Mab/2;
        ];

    %resistance term
    R = [
         0 , 0;
         0 , 0;
        ];

    %complicance term
    K = [
         1/Cab,  -1/Cab ;
         1/Cab,  -1/Cab;
        ];
    
    a = inv(M)*(P - R*q - K*x);%acoustic acceleration
    
    dydt = zeros(4,1);
    dydt(1:2) = q; %[v_i, v_s, v_o]
    dydt(3:4) = a; %[a_i, a_s, a_o]
end

%}