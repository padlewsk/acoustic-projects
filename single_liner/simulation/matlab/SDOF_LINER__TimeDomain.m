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
Df = 10; % frequency step

%%% SAMPLING 
fs = 5E5;%Hz 
ts = 1/fs;

%%% SIMULATION TIME (MATLAB odes use adaptive step size)
tf = 0.5; %simulation time in seconds
tspan_vec =  0:ts:tf; %This time vector used to interpolate before performing the FFT 

%%% INITIALISATION
%%% xi_s: liner speaker displacement
%%% xi_tot: total displacement at the inlet of the duct
%%% xi_t: transmitted displacement at the outlet of the duct
%%% y = [xi_s, v_s, xi_tot, v_tot, xi_t,v_t]
y0 = [0,0.05*A_pinc/Zc,0,0.05*A_pinc/Zc,0,0.05*A_pinc/Zc]; % solver initial condition
%y0 = [0,0,0,0,0,0];
F = []; R = []; T = []; alpha = [];

fig1 = figure(1);
set(gca,'FontSize',18) % Creates an axes and sets its FontSize to 18
hold on

%% 
for f = fi:Df:ff %Hz

    fprintf("### f = "+ string(f)+ " Hz \n")
    
    %%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic
    [t_out,y_out] = ode15s(@(t,y) odefun(t,y,f),[0 tf],y0);
    toc
    
    tic
    %%% OUTPUT AND PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    vtot = y_out(:,2);
    vtra = y_out(:,6);
    
    %%% COMPUTE PRESSURES
    pinc = source(A_pinc,f,t_out);
    pref = pinc - rho0*c0*vtot;
    ptra = rho0*c0*vtra;

    %INTERPOLATION (JUST BEFORE FFT)
    pinc = interp1(t_out,pinc,tspan_vec);
    pref = interp1(t_out,pref,tspan_vec);
    ptra = interp1(t_out,ptra,tspan_vec);
    
    %%%% ASSUME CYCLE LIMIT IS ACHEIVED AFTER 10 CYCLES
    pinc = pinc(tspan_vec>10/f);
    pref = pref(tspan_vec>10/f);
    ptra = ptra(tspan_vec>10/f);
    
    %%% FFT
    [F1,Pinc] = onesideft(pinc,fs,2); %2sided spectrum, padding
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
    
    %%% REF&TRA PRESSURES
    subplot(2,2,2);
    hold on
    plot(F_temp,abs(Ptra_f0),'*r')
    plot(F_temp,abs(Pref_f0),'*b')
    hold off
    box on
    grid on
    xlim([0 1000]);
    ylim([0 A_pinc]);
    xlabel("Frequency (Hz)")
    ylabel("Amplitude (Pa)")
    %%str = {'$$ max(FFT(P_{ref})) $$','$$ max(FFT(P_{tra})) $$'};
    str = {'$$ P_{ref} $$','$$ P_{tra} $$'};
    legend(str, 'Interpreter','latex', 'Location','NW')
    
    %%% REF,TRA,ABS COEFS
    subplot(2,2,[3,4]); 
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
    
    toc
end
hold off

%% FIGURES
%close all
%%% Figure 2
clf
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
function dydt = odefun(t,y,f)
    run('params.m');
     
    xtot=y(1); vtot=y(2); xspk=y(3); vspk=y(4);  xtra=y(5);  vtra=y(6);
    
    gamma = (1/Ca)*(xtot - (Sd/S)*xspk - xtra);
    pinc = source(A_pinc,f,t); %source pressure
   
    dydt = zeros(6,1);
    dydt(1) = vtot; %vs
    dydt(2) =(2/Ma)*(-gamma + 2*pinc - Zc*vtot);
    dydt(3) = vspk; %vtot
    dydt(4) = (1/Mas)*(gamma - Ras*vspk - 1/Cac*xspk);
    dydt(5) = vtra; %vt
    dydt(6) = (2/Ma)*(gamma - Zc*vtra) ;
end

%%% 
