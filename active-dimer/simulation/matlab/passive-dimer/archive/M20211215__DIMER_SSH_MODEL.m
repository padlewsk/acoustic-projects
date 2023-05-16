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
cell_size = 2*L;
ii = 1;
Q = [];
F = [];

fi = 500;
ff = 4000;

Cmc = Cmc;% 
Mms = Mms;% 
Rms = Rms*0;% 
fact  = 1;

kf = pi/cell_size; %linspace(-pi/cell_size,pi/cell_size,4); %bloch floquet wave vector

for f = fi:5:ff; %s = i*omega = i*2pi*freq
    s = 1i*2*pi*f;
    alpha = (Mms.*s + Rms + 1./(Cmc.*s))/Sd; %acoustic impedance of the liner 1E8;%

    M = [(Ma/(2*S)).*s - alpha, alpha                , 0                                    , 0                          ;
         -alpha               , alpha + 1./(Ca*S.*s) , 1./(Ca*S.*s)                         , 0                          ;
         0                    , -1./(Ca*S.*s)        , 1./(Ca*S.*s) + 1./(fact*Ca*S.*s)-(Ma/S).*s, -1./(fact*Ca*S.*s)              ;
         0                    , 0                    , 1./(fact*Ca*S.*s)                         , (Ma/(2*S)).*s-1./(fact*Ca*S.*s)];
        

    Y = [A_pinc; 0; 0; A_pinc*exp(1i*kf*cell_size)];
    
    Q = [Q,M\Y]; 
    
    F = [F,f]; %ROUNDS TO THE CLOSEST INTEGER
    
    ii = ii + 1;
end

 ratio = abs((Q(3,:)-Q(1,:))/(Q(4,:)-Q(2,:)));
 
 Zs = Y(1,:)./(Q(2,:)-Q(1,:)+Q(3,:)-Q(4,:));

%%
%%% FLOQUET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
f=500;

S_A = S*ratio;
S_B = S*ones(size(ratio));


u = S_A./(S_A+S_B);
v = S_B./(S_A+S_B);




Ep = sqrt(u.^2+v.^2+2*u.*v.*cos(kf*cell_size));
Em = -Ep;


%% FIGURES
clf

figure(1)
plot(F,real(u),F,real(v))


figure(2)
hold on
plot(F,imag(Q(1,:)))
plot(F,imag(Q(2,:)))

%plot(F,imag(ratio))
hold off
box on
grid on
legend("q(x_a-)","q(x_a+)","q(x_a-)/q(x_a+)")

%
figure(3)
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
figure(4)
hold on
plot(kf*cell_size/pi,acos(Ep)/pi,'k',kf*cell_size/pi,acos(Em)/pi,'k')
plot(kf*cell_size/pi,acos(Ep)/pi+1,'k',kf*cell_size/pi,acos(Em)/pi+1,'k')
hold off
box on
grid on

%% IMPEDANCE
figure(5)
plot(F,abs(Zs))


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