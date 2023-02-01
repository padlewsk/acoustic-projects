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
%%% [q_Am, q_Ap, q_Bm, qBp]

ii = 1;
Q = [];
F = [];

fi = 100;
ff = 1000;


for s = 1i*2*pi*[fi:10:ff]; %s = i*omega = i*2pi*freq
    
    alpha = (Mms.*s + Rms + 1./(Cmc.*s))/Sd;
    
    M = [(Ma/(2*S)).*s - alpha, alpha                , 0                                    , 0                          ;
         -alpha               , alpha + 1./(Ca*S.*s) , 1./(Ca*S.*s)                         , 0                          ;
         0                    , -1./(Ca*S.*s)        , 1./(Ca*S.*s) + 1./(Ca*S.*s)-(Ma/S).*s, -1./(Ca*S.*s)              ;
         0                    , 0                    , 1./(Ca*S.*s)                         , (Ma/(2*S)).*s-1./(Ca*S.*s)];
        

    Y = [A_pinc; 0; 0; A_pinc]; % The pressure is driving the total displacement
    
    Q = [Q,M\Y]; 
    
    F = [F,s/(1i*2*pi)];
    
    ii = ii + 1;
end
 Pinc = A_pinc*ones(1,ii-1);
 
 
 ratio = Q(1,:)./Q(2,:);

%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
figure(1)
hold on
plot(F,real(ratio))
hold off
box on
grid on
legend("alpha","R","T")
