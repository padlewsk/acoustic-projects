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
ff = 5000;%c0/(2*cell_size)

%k_F= -pi;


%q = -pi/a:0.1:pi/a;

q = pi/a;

for f = fi:1:ff; %s = i*omega = i*2pi*freq
    omega = 2*pi*f;
    k = omega./c0;
    
    M = [cos(2*k*L) - exp(1i*q*a) , Zc*1i*sin(2*k*L)      ;
         (1/Zc)*1i*sin(2*k*a/2), cos(2*k*L) - exp(1i*q*a)];
    
    Y = [0; 0;];
    
    
    
    %X = [X,M\Y]; 
   
    [V,D] = eig(M);
    
    X{1,ii} = D;
    X{2,ii} = V;

    
    %{
    alpha_k = 1-cos(2*k*cell_size/2);
    
    lambda_p = (-alpha_k + sqrt(alpha_k.^2-4*alpha_k))/2;
    lambda_m = (-alpha_k - sqrt(alpha_k.^2-4*alpha_k))/2;
    X_p = [X_p,lambda_p];
    X_m = [X_m,lambda_m];
    %}
    F = [F,f]; %ROUNDS TO THE CLOSEST INTEGER
    
    ii = ii + 1;
end
    %{

    %}


eig_val_p = cellfun(@(x) x(1),X(1,:));
eig_val_m = cellfun(@(x) x(4),X(1,:));

p4_p = cellfun(@(x) x(1),X(2,:));
q4_p = cellfun(@(x) x(3),X(2,:));

p4_m = cellfun(@(x) x(2),X(2,:));
q4_m = cellfun(@(x) x(4),X(2,:));

%Z_4 = X(1,:)./X(2,:);

figure()
hold on
%plot(F,imag(eig_val_p))
plot(F,real(q4_m))
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