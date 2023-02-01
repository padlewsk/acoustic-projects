%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN WITH SIMULINK%%%%%%%%%%%%%%%%%%
clear all
close all
clc

%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');

%% MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf("### COMPUTING SPECIFIC ACOUSTIC IMPEDANCE FOR EACH FREQUENCY...\n")

%%% DEFAULT SAMPLING TIME

fs = 1E5;%Hz  
ts = 1/fs;
%}

tf = 1; %simulation time in seconds

fi = 100;
ff = 1000;

F = [];
R = [];
T = [];
alpha = [];

for f = fi:10:ff %Hz
    tic
    fprintf("### f = "+ string(f)+ " Hz \n")
   
    sim('SDOF_LINER__model',tf); %simulink
    
    %%% SIMULINK OUTPUT:
    y_out= ans.y.Data;%%% [pinc, vtot, vt]
    t_out = ans.y.Time;
    
    
    %%%% ASSUME CYCLE LIMIT IS ACHEIVED AFTER 20 cycles
    y_cut = y_out(t_out>20/f,:); % cut before 20 cycles
    t_cut = t_out(t_out>20/f,:);
    
    pinc = y_cut(:,1);
    vtot = y_cut(:,2);
    vtra = y_cut(:,3);
    
    pref =  pinc - rho0*c0*vtot;
    ptra = rho0*c0*vtra;
    
    [F1,Pinc] = onesideft(pinc,fs,1); %2sided spectrum, padding
    [F2,Pref] = onesideft(pref,fs,1); 
    [F3,Ptra] = onesideft(ptra,fs,1);
    
    Pinc_idx = find(abs(Pinc) == max(abs(Pinc)));
    Pref_idx = find(abs(Pref) == max(abs(Pref)));
    Ptra_idx = find(abs(Ptra) == max(abs(Ptra)));
    
    Pinc_f0 = Pinc(Pinc_idx);
    Pref_f0 = Pref(Pref_idx);
    Ptra_f0 = Ptra(Ptra_idx);
    
    F_temp = f;  
    
    
    %{
    [F1,Pinc] = onesideft(pinc,fs,5); %2sided spectrum, padding
    [F2,Vtot] = onesideft(vtot,fs,5); 
    [F3,Vt] = onesideft(vt,fs,5);
    
    Pinc_idx = find(abs(Pinc) == max(abs(Pinc)));
    Vtot_idx = find(abs(Vtot)== max(abs(Vtot)));
    Vt_idx   = find(abs(Vt) == max(abs(Vt)));
    
    
 
    %
    %%% Reflection coefficient:
    R_temp = (Pinc(Pinc_idx) - Zc*Vtot(Vtot_idx))./Pinc(Pinc_idx); %peak value 

    %%% Transmission coefficient:
    T_temp = Zc*Vt(Vt_idx)./Pinc(Pinc_idx);
    %%% Absorbtion coefficient:
    alpha_temp = 1 - abs(R_temp)^2 - abs(T_temp)^2;
    %} 
    
    %%% Reflection coefficient:
    R_temp = Pref(Pref_idx)/Pinc(Pinc_idx);
    %%% Transmission coefficient:
    T_temp = Ptra(Ptra_idx)/Pinc(Pinc_idx);
    %%% Absorbtion coefficient:
    alpha_temp = 1 - abs(R_temp)^2 - abs(T_temp)^2;
      
    %%% LOG
    F = [F,F_temp];
    R = [R,R_temp];
    T = [T,T_temp];
    alpha = [alpha,alpha_temp]; %transmission loss
    
    
    %%% FIGURE LOOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Enlarge figure to full screen.
    % set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    fig1 = figure(1);
    subplot(2,2,1);
    grid on
    box on
    plot(t_out*1000, y_out(:,4)*1000)%
    xlim([0,(50/ff)*1000])
    %ylim([-5E-4 5E-4])
    xlabel("Time (ms)")
    ylabel("Speaker Displacement (Pa)")
    str = {'$$ \xi_{s} $$'};
    legend(str, 'Interpreter','latex', 'Location','NW')
    
    subplot(2,2,2);
    hold off
    grid on
    hold on
    plot(F_temp,abs(Ptra_f0),'*r')
    plot(F_temp,abs(Pref_f0),'*b')
   
    box on
    xlim([0 1000]);
    ylim([0 A_pinc])
    xlabel("Frequency (Hz)")
    ylabel("Amplitude (a.u)")
    str = {'$$ FFT(P_{ref}) $$','$$ FFT(P_{tra}) $$'};
    legend(str, 'Interpreter','latex', 'Location','NW')
    
     
    subplot(2,2,[3,4]); 
    hold on
    plot(F,alpha,'o','color',[0, 0.4470, 0.7410])
    plot(F,abs(R),'o','color',[0.8500, 0.3250, 0.0980])
    plot(F,abs(T),'o','color',[0.9290, 0.6940, 0.1250])
    xlim([fi,ff])
    ylim([0,1])
    xlabel("Frequency (Hz)")
    hold off
    box on
    grid on
    str = {'$\alpha$','R','T'};
    legend(str, 'Interpreter','latex', 'Location','NW')
    %}
    %}
    toc
end
hold off


%% FIGURES

%
%close all
%%% Figure 2
fig2 = figure(2);
hold on
%plot(F, Zs)
plot(F,alpha)%xi
plot(F,abs(R))%xi
plot(F,abs(T))%xi

hold off
box on
grid on
str = {'$\alpha$','R','T'};
legend(str, 'Interpreter','latex', 'Location','NW')
%}
