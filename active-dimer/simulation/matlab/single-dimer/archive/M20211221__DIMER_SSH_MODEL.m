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

a = 2*sqrt(Sd);%cell size
L = sqrt(Sd);
ii = 1;
X = [];
D = [];
V = [];
X_p = [];
X_m = [];
F = [];

fi = 10;
ff = 10000;%c0/(2*cell_size)

pnp1Am = 0;
pnAm = 0.5;
pns = 0.1;
Zac = Zc/S;
s = 2;




q = pi/a;

for f = fi:1:ff; %s = i*omega = i*2pi*freq
    omega = 2*pi*f;
    k = omega./c0;
    
    Zas = Zac*1i*sin(k*L)/((s*(pnp1Am-pnAm)+pnp1Am)/pns+1-cos(k*L));
    
    X = [X,Zas];
    F = [F,f]; %ROUNDS TO THE CLOSEST INTEGER
    
    ii = ii + 1;
end


figure()
hold on
%plot(F,imag(eig_val_p))
plot(F,imag(X))
%plot(F,real(X))
hold off




%{
%%% FLOQUET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%L = sqrt(Sd);
%omega = 2*pi*f;
%k = omega./c0;
f=500;

S_A = S*ratio;
S_B = S*ones(size(ratio));

%S_A = S*ratio(F==f);
%S_B = S

u = S_A./(S_A+S_B);
v = S_B./(S_A+S_B);

figure()
plot(F,real(u),F,real(v))

%kf = 2*pi.*F/c0;
kf = linspace(-pi/cell_size,pi/cell_size,length(F));%pi/cell_size
Ep = sqrt(u.^2+v.^2+2*u.*v.*cos(kf*cell_size));%kf =2*pi*f/c0
Em = -Ep;


%% FIGURES
clf
figure(1)
hold on
plot(F,imag(Q(1,:)))
plot(F,imag(Q(2,:)))

%plot(F,imag(ratio))
hold off
box on
grid on
legend("q(x_a-)","q(x_a+)","q(x_a-)/q(x_a+)")


%
figure(2)
plot(kf*cell_size/pi,Ep,'k',kf*cell_size/pi,Em,'k')
plot(kf*cell_size/pi,Ep,'k',kf*cell_size/pi,Em,'k')
box on
grid on
%{
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
ylabel("E = cos(2kl)")
xlabel("q")
xlim([-pi,pi]);
ylim([-1,1]);
%str = {'\alpha','R','T'};
%legend(str, 'Location','NW')
%}

%%
figure(3)
hold on
plot(kf*cell_size/pi,acos(Ep)/pi,'k',kf*cell_size/pi,acos(Em)/pi,'k')
plot(kf*cell_size/pi,acos(Ep)/pi+1,'k',kf*cell_size/pi,acos(Em)/pi+1,'k')
hold off
box on
grid on
%{
set(gca,'XTick',-pi:pi/2:pi)
set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
ylabel("kl/\pi")
xlabel("q")
xlim([-pi,pi]);
ylim([0,2]);
%str = {'\alpha','R','T'};
%legend(str, 'Location','NW')
%}

%}