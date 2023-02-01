%%% ACOUSTIC SSH MODEL %%%%%%%%%%%%%%%%%%

%%% https://www.animations.physics.unsw.edu.au/jw/compliance-inertance-impedance.htm
clear all
close all
clc


%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox'));%
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('params.m');

%% SPEAKER MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% [q_Am, q_Ap, q_Bm, qBp]$

L = sqrt(Sd);
a = 2*L; %Cell size

Q = [];
K = [];
E = [];
F = [];

fi = 0;
ff = 4*c0/(2*a);

Cmc = Cmc;% 
Mms = Mms;% 
Rms = Rms*0;% 
Zac = Zc/S;








px_num = 512;
for ii = 1:px_num; 
    for jj = 1:px_num;
        %k = (ii/px_num)*2*pi/a;
        f = (ii/px_num)*ff;
        k = 2*pi*f/c0;
        
        q = (jj/px_num-0.5)*2*pi/a;
        
        Zas = (Mms.*(1i*2*pi*f) + Rms + 1./(Cmc.*(1i*2*pi*f)))/Sd^2;%acoustic impedance of the liner 1E8;%
        Zac = Zc/S;
        beta = Zas/Zac;

        
        T12 = [cos(k*L),-(1i*Zac)*sin(k*L); 
              -(1i/Zac)*sin(k*L), cos(k*L)];
        T23 = [1,0;-1/Zas,1]; % helmoltz resonator model
        gamma = k*L*(1i+beta*k*h/4);
        %T23 = 1/(gamma-1i*sin(k*L))*[gamma*cos(k*L)-1i*sin(k*L), -Sd*(2-2*cos(k*L)+gamma*1i*sin(k*L));   -Sd*gamma*1i*sin(k*L), gamma*cos(k*L)-1i*sin(k*L)];
        T31 = T12;
        
        T = T12*T23*T31;
        
        %E(ii,jj) = det(T-exp(-1i*q*a));%minimize the det
        Z(ii) = Zas;
        E_temp = cos(q*a)-0.5*trace(T); %huge resonance at f0 = 500... 
        E_temp(abs(E_temp)>0.1) = NaN;
        E_temp(abs(E_temp)<0.1) = 0;
        
        E(ii,jj) = E_temp;
    end
end

[Q_mesh,K_mesh]  = meshgrid(((1:px_num)/px_num-0.5)*2*pi/a,((1:px_num)/px_num)*2*pi/a);
%% FIgures
clf
%{
figure(1)
semilogy(F,abs(Z))
%xlim([-1,1])
%xlabel("Re(qa/\pi)")
%ylabel("ka/\pi")
%}
figure(2)
surf(Q_mesh*a/pi,K_mesh*a/pi,abs(E),'EdgeColor','none','facecolor','interp'); view(0,90); 
%surf(Q*a/pi,F,-abs(E),'EdgeColor','none','facecolor','interp'); view(0,90); 
%zlim([-5,5])
xlabel("Re(qa/\pi)")
ylabel("ka/\pi")


