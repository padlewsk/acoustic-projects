%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%
clear all
close all
clc

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');

%% FREQUENCY SWEEP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("### COMPUTING SPECIFIC ACOUSTIC IMPEDANCE FOR EACH FREQUENCY...\n")

%%% FREQ SWEEP RANGE
fi = 100; % initial frequency
ff = 1000; % final frequency
Df = 100; % frequency step

global N %number of unit cells cells
N = 1; 
mat_size = 9*N-(N-1);

%%% SAMPLING (for post processing --> doesn't affect sim time alot)
fs = 1E5;
ts = 1/fs;

%%% SIMULATION TIME (MATLAB odes use adaptive step size)
tf = 0.5; %simulation time in seconds (SHOULD adapt in loop)
tspan_vec =  0:ts:tf; %This time vector used to interpolate before performing the FFT 

%%% INITIALISATION
y0 = zeros(1,2*mat_size);% solver initial condition %[x1,...,xN,v1,...vN]
y0 = zeros(1,6);%
    
F = [];
R = []; 
T = []; 
alpha = [];


fig1 = figure(1);
set(gca,'FontSize',18) % Creates an axes and sets its FontSize to 18
hold on

%% 
for f = fi:Df:ff %Hz
    
    fprintf("### f = "+ string(f)+ " Hz \n")
    %%% ADAPTATIVE SIMULATION TIME TEST
    %tf = 40/f; 
    %%%ts = 0.1*(1/f);%10 samples per period
    %%%tspan_vec =  0:ts:tf;
    
    %%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %tf = 20/f %20 cycles
    tic
    [t_out,y_out] = ode45(@(t,y) oderes(t,y,f),[0 tf],y0);%dynamically adjusts sampling time
    toc
    %y_out = [x1,...,xN,v1,...vN]
    
    tic
    %%% OUTPUT AND PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %q_i = y_out(:,mat_size+1);
    %q_o = y_out(:,2*mat_size);
    
    q_i = y_out(:,4);
    q_o = y_out(:,6);

    %%% COMPUTE PRESSURES
    psrc = source(A_pinc,f,t_out);
    pref = psrc - rho0*c0*q_i/S;
    ptra = rho0*c0*(q_o/S);

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
    Pinc_idx = find(Pinc == max(Pinc));%abs necessary??
    Pref_idx = find(Pref == max(Pref));
    Ptra_idx = find(Ptra == max(Ptra));
    
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
    xlim([0,(50/ff)*1000])
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
    %}
    drawnow
    %}
    toc
end
hold off

%% FIGURES
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


%%
%%% FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% PRESSURE SOURCE (sin)
function S = source(amp,freq,time)
S = amp*sin(2*pi*freq*time); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

%%% system of differential equations y′=f(t,y)


function dydt = odecrystal(t,y,f)
    run('params.m');
    %%% UNIT CELL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % between resonatros 
     %mass term
    M_b = [
       -Mab/2,    0  ;  % RMK: opposite sign to aid with building the cell matrix (first line only)c.f.__20230515__theory
         0  , -Mab/2;
        ];
    %resistance term
    R_b = [
         0 , 0;% RMK:
         0 , 0;
        ];
    %complicance term
    K_b = [
         -1/Cab,  +1/Cab ;% RMK:
         1/Cab,  -1/Cab;
        ];

    % at resonator %%%%%%%%%%%%%%%%%%%% 
    %mass term
    M_a = [
       -Maa/2, 0,    0  ;% RMK:
         0 ,  Mas,    0  ;
         0 ,   0 , -Maa/2;
        ];
    %resistance term
    R_a = [
        0,  0, 0;% RMK:
        0, Ras, 0;
        0,  0  ,0;
        ];
    %complicance term
    K_a = [
         -1/Caa,    +1/Caa   , +1/Caa  ;% RMK:
        -1/Caa,  1/Cac+1/Caa,  1/Caa;
         1/Caa,    -1/Caa   , -1/Caa;
        ];

    %%% BUILD UNITCELL 9x9 matrix (--> [_b_a_b_b_a_b_] 2+3+2+2+3+2 - (6-1) = 9)
    M_cell = zeros(9,9);
    R_cell = M_cell;
    K_cell = M_cell;
    
    M_cell(1:2,1:2) = M_cell(1:2,1:2) + M_b; %between speaker
    M_cell(2:4,2:4) = M_cell(2:4,2:4) + M_a; %at speaker
    M_cell(4:5,4:5) = M_cell(4:5,4:5) + M_b;
    M_cell(5:6,5:6) = M_cell(5:6,5:6) + M_b;
    M_cell(6:8,6:8) = M_cell(6:8,6:8) + M_a;
    M_cell(8:9,8:9) = M_cell(8:9,8:9) + M_b;

    R_cell(1:2,1:2) = R_cell(1:2,1:2) + R_b; %between speaker
    R_cell(2:4,2:4) = R_cell(2:4,2:4) + R_a; %at speaker
    R_cell(4:5,4:5) = R_cell(4:5,4:5) + R_b;
    R_cell(5:6,5:6) = R_cell(5:6,5:6) + R_b;
    R_cell(6:8,6:8) = R_cell(6:8,6:8) + R_a;
    R_cell(8:9,8:9) = R_cell(8:9,8:9) + R_b;

    K_cell(1:2,1:2) = K_cell(1:2,1:2) + K_b; %between speaker
    K_cell(2:4,2:4) = K_cell(2:4,2:4) + K_a; %at speaker
    K_cell(4:5,4:5) = K_cell(4:5,4:5) + K_b;
    K_cell(5:6,5:6) = K_cell(5:6,5:6) + K_b;
    K_cell(6:8,6:8) = K_cell(6:8,6:8) + K_a;
    K_cell(8:9,8:9) = K_cell(8:9,8:9) + K_b;
    
    %%% BUILD CRYSTAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    global N % number of cells
    mat_size = 9*N-(N-1);
    M = zeros(mat_size,mat_size);
    R = M;
    K = M;
    
    %RMK M(1:9,1:9) =  M_cell(:,:)% first block
   
    for nn = [1:N] %make huge matrices
        nn = nn-1;
        mat_seg = [1+nn*8:9+nn*8];   
        M(mat_seg, mat_seg) = M(mat_seg, mat_seg)+  M_cell(:,:);
        R(mat_seg, mat_seg) = R(mat_seg, mat_seg)+  R_cell(:,:);
        K(mat_seg, mat_seg) = K(mat_seg, mat_seg)+  K_cell(:,:);
    end
    
    pinc = source(A_pinc,f,t); %source pressure

    x = y(1:mat_size); %acoustic displacement
    q = y(mat_size+1:mat_size*2); %acoustic velocity
    
    % pressure in and out
    p_i = 2*pinc - Zc*q(1)/S; %-Zc*v(1);
    p_o = Zc*q(end)/S;
    P = zeros(mat_size,1);
    
    P(1) = - p_i; % RMK: opposite sign to aid with building the cell matrix
   
    P(end) = p_o;   
    
%{
    %mass term
    M = [
     Mab/2,      0,        0,    0;
       0,   -Mab/2-Maa/2,  0,    0;
       0,        0,       Mas,   0;
       0,        0,        0,  -Maa/2;
        ];

    %resistance term
    R = [
         0, 0, 0,  0;
         0, 0, 0,  0;
         0, 0, Ras,0;
         0, 0, 0,  0;
        ];

    %complicance term
    K = [
         1/Cab,    -1/Cab,       0,         0;
         -1/Cab,-1/Cab-1/Caa,   1/Caa,     1/Caa;
          0,       -1/Caa,  1/Cac+1/Caa,  1/Caa;
           0,      1/Caa,     -1/Caa   ,  -1/Caa;
        ];
    %}
    a = inv(M)*(P - R*q - K*x);%acoustic acceleration
    
    dydt = zeros(2*mat_size,1);
    dydt(1:mat_size) = q; %[v_i, v_s, v_o]
    dydt(mat_size+1:2*mat_size) = a; %[a_i, a_s, a_o]
  
end
%{
function dydt = odecrystal(t,y,f)
    run('params.m');
    pinc = source(A_pinc,f,t); %source pressure
     
    %duct  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x = y(1:4); %acoustic displacement
    v = y(5:8); %acoustic velocity
      
    p_i = 2*pinc - Zc*v(1);
    p_o = Zc*v(4);
    P = [p_i;0;0;p_o];

    %mass term
    M = [
     Mab/2,      0,        0,    0;
       0,   -Mab/2-Maa/2,  0,    0;
       0,        0,       Mas,   0;
       0,        0,        0,  -Maa/2;
        ];

    %resistance term
    R = [
         0, 0, 0,  0;
         0, 0, 0,  0;
         0, 0, Ras,0;
         0, 0, 0,  0;
        ];

    %complicance term
    K = [
         1/Cab,    -1/Cab,       0,         0;
         -1/Cab,-1/Cab-1/Caa,   1/Caa,     1/Caa;
          0,       -1/Caa,  1/Cac+1/Caa,  1/Caa;
           0,      1/Caa,     -1/Caa   ,  -1/Caa;
        ];
    
    a = inv(M)*(P - R*v - K*x);%acoustic acceleration
    
    dydt = zeros(8,1);
    dydt(1:4) = v; %[v_i, v_s, v_o]
    dydt(5:8) = a; %[a_i, a_s, a_o]
  
end
%}

function dydt = oderes(t,y,f)
    run('params.m');
    
    x = y(1:3); % [x_i, x_s, x_o] = [y(1), y(2), y(3)]; %acoustic displacement
    v = y(4:6); % [v_i, v_s, v_o] = [y(3), y(4), y(5)]; %acoustic velocity
   
        pinc = source(A_pinc,f,t); %source pressure
        P = [2*pinc - Zc*v(1);  0;  Zc*v(3)];

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
    
    a = inv(M)*(P - R*v - K*x);%acoustic acceleration
    
    dydt = zeros(6,1);
    dydt(1:3) = v; %[v_i, v_s, v_o]
    dydt(4:6) = a; %[a_i, a_s, a_o]
end

function dydt = odetube(t,y,f)
    run('params.m');
    
    x = y(1:2); % [x_i, x_o] = [y(1), y(2)]; %acoustic displacement
    v = y(3:4); % [v_i, v_o] = [y(3), y(4)]; %acoustic velocity
   
    pinc = source(A_pinc,f,t); %source pressure
    P = [2*pinc - Zc*v(1); Zc*v(2)];

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
    
    a = inv(M)*(P - R*v - K*x);%acoustic acceleration
    
    dydt = zeros(4,1);
    dydt(1:2) = v; %[v_i, v_s, v_o]
    dydt(3:4) = a; %[a_i, a_s, a_o]
end

%%% system of differential equations y′=f(t,y)
%{
function dydt = odefun(t,y,f)
    run('params.m');
     
    x_i=y(1); v_i=y(2); x_s=y(3); v_s=y(4);  x_o=y(5);  v_o=y(6);
    
    gamma = (1/Caa)*(x_i - (Sd/S)*x_s - x_o);
    pinc = source(A_pinc,f,t); %source pressure
   
    dydt = zeros(6,1);
    dydt(1) = v_i; %vs
    dydt(2) =(2/Maa)*(-gamma + 2*pinc - Zc*v_i);
    dydt(3) = v_s; %vtot
    dydt(4) = (1/Mas)*(gamma - Ras*v_s - 1/Cac*x_s);
    dydt(5) = v_o; %vt
    dydt(6) = (2/Maa)*(gamma - Zc*v_o) ;
end
%}
%%% 
