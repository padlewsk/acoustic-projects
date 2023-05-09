%%% SCATTERING THROUGH AN ACOUSTIC LINER IN FREQ DOMAIN %%%%%%%%%%%%%%%%%%%
%%% c.f. non-linear SSH\ meta-atom\ simple liner model
clear all
close all
clc
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');
%% MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% xi_s: liner speaker displacement
%%% xi_tot: total displacement at the inlet of the duct
%%% xi_t: transmitted displacement at the outlet of the duct

ii = 1;
X = [];
V = [];
F = [];

fi = 10;
ff = 2000;

for s = 1i*2*pi*[fi:10:ff]; %s = i*omega = i*2pi*freq
    
    M = [Mas*s.^2 + Ras.*s + (Sd/(S*Ca)+1/Cac), -1/Ca, 1/Ca;
    -Sd/(S*Ca), 0.5*Ma*s.^2 + Zc.*s + 1/Ca, -1/Ca;
    Sd/(S*Ca), -1/Ca, 0.5*Ma*s.^2 + Zc.*s + 1/Ca];

    Y = [0; 2*A_pinc; 0]; % The pressure is driving the total displacement
    
    X = [X,M\Y]; %[xi_s;xi_tot;xi_t]
    V = [V,s*(M\Y)]; %[v_s;v_tot;v_t]
    
    F = [F,s/(1i*2*pi)];
    
    ii = ii + 1;
end
%specify inc Pressure)
 Pinc = A_pinc*ones(1,ii-1);
%%% Reflection coefficient:
R = (Pinc-Zc*V(2,:))./Pinc;

%%% Transmission coefficient:
T = Zc*V(3,:)./Pinc;


alpha = 1 - abs(R).^2 - abs(T).^2;

f0 = 1/(2*pi*sqrt(Cmc*Mms))
%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
figure(1)
%plot(F,real(X))
hold on
plot(F,alpha)
plot(F,abs(R))
plot(F,abs(T))
hold off
box on
grid on
legend("alpha","R","T")
