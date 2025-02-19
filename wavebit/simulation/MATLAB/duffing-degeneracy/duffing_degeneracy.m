%%% DUFFING RESONATOR: COURTESY OF RAHIM VESAL
close all;
clear;
clc;
%% Parameters
Rho       = 1.2047;                             %[kg/m^3]
C0        = 343.2;                              %[m/s]
M_ms      = 0.000618;                           %[kg]
S_d       = 0.0012;                             %[m^2]
S_Duct    = (5e-2)^2;                           %[m^2]
Bl        = 1.1141;                             %[V.s/m OR T.m]
R_ms      = 0.2806;                             %[N.s/m]
R_ms      = R_ms + S_d*(S_d/S_Duct)*Rho*C0;     %[N.s/m]                   correct
C_mc      = 0.0002174;                          %[m/N]
Ratio_pb  = 1.21e6;                             %[Pa/m]
C_ab      = S_d/Ratio_pb;                       %[m^3/Pa]
G_mic     = -0.36;                              %[V/Pa]
G_ui      = 0.0095;                             %[A/V]
kesi_bar  = 1e-7;                               %[m]       ???
Omega_bar = 1/((C_mc*M_ms)^0.5);
P_bar     = 0.2;                                  %[Pa]
Epsilon   = 0.01* (R_ms/(M_ms*Omega_bar));
P0        = P_bar*S_d/(Epsilon*kesi_bar*(Omega_bar^2)*M_ms);                                %[Pa]
Alpha_nl_list  = [80 29.5 0 -29.5 -80];                               %[V^-2]    ???
%% Perturbation Solution
for ii = 1:5
    Alpha_nl = Alpha_nl_list(ii);
    D         = (R_ms/(M_ms*Omega_bar))/Epsilon;                                                       % correct
    k_nl      = ((Bl*G_ui*Alpha_nl*((G_mic*S_d/C_ab)^3)*((kesi_bar)^2))/(M_ms*(Omega_bar^2)))/Epsilon; % correct
    Sigma_L   = -300;                 % Lower frequency margin
    Sigma_R   = 300;                  % Higher frequency margin
    Nodes     = 201;
    Sigma     = (Sigma_L:(Sigma_R-Sigma_L)/(Nodes-1):Sigma_R)';
    Norm_Resp = zeros(Nodes,3);       % 1st Column: Normalized Output (Lower Branch) | 2nd: Middle Unstable | 3rd: Upper Branch
    a = sym('aaa');
    for j = 1:Nodes
        result    = vpasolve((0.25*(D^2) + Sigma(j)^2)*(a^2) + (-0.75*Sigma(j)*k_nl)*(a^4) + ((9/64)*(k_nl^2))*(a^6) - (P0^2), a);
        result_R  = zeros(3,1);
        k         = 1;
        if j < 2
           Result_Length = length(result)
        end
        for i = 1:Result_Length
            if result(i) == abs(result(i))
               result_R(k,1) = double(result(i));
               k = k+1;
            end
        end
        result_R      = sort(result_R);
        Norm_Resp(j,1) = result_R(1);
        Norm_Resp(j,2) = result_R(2);
        Norm_Resp(j,3) = result_R(3);
    end
    % Post Processing Data
    Dnorm_Res(:,:) = kesi_bar*Norm_Resp;
    Dnorm_Frq(:,1) = (Omega_bar/(2*pi))*(ones(Nodes,1) + Epsilon*Sigma);
    Jump_Region_StartPoint = 2;
    Jump_Region_EndPoint   = Nodes-1;
    for i = 2:Nodes-1
        if abs(Dnorm_Res(i+1,1) - Dnorm_Res(i,1)) > 3*abs(Dnorm_Res(i,1) - Dnorm_Res(i-1,1))
           if (Dnorm_Res(i+1,1) - Dnorm_Res(i,1)) > 0
              Jump_Region_StartPoint = i+1;
           end
           if (Dnorm_Res(i+1,1) - Dnorm_Res(i,1)) < 0
              Jump_Region_EndPoint = i;
           end
        end
    end
    if Jump_Region_EndPoint - Jump_Region_StartPoint < 5
       Jump_Region_EndPoint - Jump_Region_StartPoint
       disp('write down b');
    end
    if Alpha_nl < -50
       sign01 = 'blacko';
       sign02 = 'black';
    elseif Alpha_nl < 0 && Alpha_nl > -50
       sign01 = 'blacks';
       sign02 = 'black';
    elseif Alpha_nl < 5 && Alpha_nl > -5
       sign01 = 'blackx';
       sign02 = 'black';
    elseif Alpha_nl < 50 && Alpha_nl > 0
       sign01 = 'blacks';
       sign02 = 'white';
    elseif Alpha_nl > 50
       sign01 = 'blacko';
       sign02 = 'white';
    end
    Dnorm_Frq_mat(ii,:) = Dnorm_Frq(:,1);
    Dnorm_Res_mat(ii,:,:) = Dnorm_Res(:,:);
end
%%
f = fig_params_thesis();
% clf
%{
Dnorm_Res_test = cat(2,Dnorm_Res_mat(:,:),Dnorm_Res_mat(:,:,2),Dnorm_Res_mat(:,:,3));
figure(1)
    plot(Dnorm_Frq_mat(1,1),  1e6*Dnorm_Res_test,'linewidth',2);
     xlim([100 800]);
    ylim([0.05  0.40]);
    yticks([0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35 0.4]);
    xlabel('Frequency (Hz)');
    ylabel('Displacement amplitude (\mum)');
%}

fig2 = figure(2);
for ii = 3:5
    plot(Dnorm_Frq_mat(ii,Jump_Region_StartPoint:Jump_Region_EndPoint),  1e6*Dnorm_Res_mat(ii,Jump_Region_StartPoint:Jump_Region_EndPoint,1),'-k','linewidth',2);
    hold on
    plot(Dnorm_Frq_mat(ii,Jump_Region_StartPoint:Jump_Region_EndPoint),  1e6*Dnorm_Res_mat(ii,Jump_Region_StartPoint:Jump_Region_EndPoint,2),'-k','linewidth',2);
    plot(Dnorm_Frq_mat(ii,1:Jump_Region_StartPoint-1),                   1e6*Dnorm_Res_mat(ii,1:Jump_Region_StartPoint-1,3),'-k','linewidth',2);
    plot(Dnorm_Frq_mat(ii,Jump_Region_StartPoint-1:Jump_Region_EndPoint),1e6*Dnorm_Res_mat(ii,Jump_Region_StartPoint-1:Jump_Region_EndPoint,3),'-k','linewidth',2);
    plot(Dnorm_Frq_mat(ii,Jump_Region_EndPoint+1:end),                   1e6*Dnorm_Res_mat(ii,Jump_Region_EndPoint+1:end,3),'-k','linewidth',2);
    xlim([100 800]);
    ylim([0.05  0.40]);
    yticks([0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35 0.4]);
    xlabel('Frequency (Hz)');
    ylabel('Displacement amplitude (\mum)');
end
    grid on
    box on
legend('\alpha = 0 V^{-2}','\alpha = -29.5 V^{-2}','\alpha = -80 V^{-2}','Location','northwest')
set(gcf,'units','centimeters','position',f.window_size);
set(gca,f.fig_prop{:}); 


vecrast(fig2 , 'duffing', 600, 'bottom', 'pdf');