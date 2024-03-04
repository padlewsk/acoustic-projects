close all
clear all
clc

% we set c = 1 --> omega/c = omega
%
pts = 50;
qa = linspace(-pi,pi,pts)'; %q_Floquet
v = 0.5; % intracell coupling
w = 0.5; % intercell coupling

lambda_NL = -1;
v_NL = 0.5*(1+lambda_NL)*1e-3;
w_NL = 0.5*(1-lambda_NL)*1e-3;

gamma_0 = -0; %losses


ka_up_0 = real(acos(gamma_0 + sqrt(v^2+w^2+2*v*w*cos(qa))));
ka_dn_0 = real(acos(gamma_0 - sqrt(v^2+w^2+2*v*w*cos(qa))));
ka_up_1 = real(acos(gamma_0 + sqrt(v^2+w^2+2*v*w*cos(qa)))) + pi ;
ka_dn_1 = real(acos(gamma_0 - sqrt(v^2+w^2+2*v*w*cos(qa)))) + pi ;

%phi_up =  -angle(+sqrt(v^2+w^2+2*v*w*cos(qa))./(v+w*exp(-1i*(qa))));
%phi_dn =  -angle(-sqrt(v^2+w^2+2*v*w*cos(qa))./(v+w*exp(-1i*(qa))));


%% DISPERSION
%{
figure(1)
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
box on
xlim([-1,1])
ylim([0,1])
hold on
plot(qa/pi,real(ka_up_0)/pi,'b-','LineWidth',3)
plot(qa/pi,real(ka_dn_0)/pi,'r-','LineWidth',3)
plot(qa/pi,ka_up_1/pi,'b-','LineWidth',3)
plot(qa/pi,ka_dn_1/pi,'r-','LineWidth',3)
%yline(omega_0,'--','\omega_0','LineWidth',2,'FontSize',18)
%yline(gamma_0,'--','','LineWidth',2,'FontSize',18)
hold off
%set(gca,'XTick',-pi:pi/2:pi)
%set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})

xlabel("qa/\pi")
%ylabel("Unitcell Eigenfrequencies (\omega_0)")
ylabel("ka/\pi")
%legend('\omega_{-}','\omega_{+}')
title('BAND DIAGRAM', sprintf('v = %.1f, w = %.1f',[v,w]))
axis square
%}
%%% WINDING
%qa = linspace(-pi,pi,50)';
N = 10;
%alphasquared = linspace(0,200,N); %% v>w and increasing amp = w_NL*alpha^2
alphasquared = linspace(0,-200,N);  %% v<w and increasing amp

dx = (v+v_NL) + (w+w_NL*alphasquared).*cos(qa) ;
dy = (w+w_NL*alphasquared).*sin(qa);

%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%
set(0,'DefaultAxesColorOrder',magma(N))
figure(1)
colormap('magma')
hold on
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;

plot(dx,dy,'LineWidth',3)
plot(0,0,'ro','LineWidth',3)
hold off
xlim([-0.5,1.5])
ylim([-1,1])
xlabel("d_x")
ylabel("d_y")
axis square
%box on
%set(gca,'CLim',[0 1]);
colorbar 
saveas(gcf,'pauli_circle_m','pdf')
%title(sprintf('WINDING NUMBER = %i',winding))


%%% INTENSITY GAP
N = 100;
lambda_NL = linspace(-1,1,N);
v_NL = 0.5*(1+lambda_NL)*1e-3;
w_NL = 1e-3-v_NL;
alphasquared = linspace(0,400,N);

%delta_E_p = +abs((v+v_NL'*alphasquared)- w - w_NL'*alphasquared);
%delta_E_m = -delta_E_p;


delta_omega_p = +sqrt(abs((v+v_NL'*alphasquared/2)- w - w_NL'*alphasquared/2));
delta_omega_m = -delta_omega_p;


set(0,'DefaultAxesColorOrder',magma(N))
figure(2)
hold on
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
ax.FontSize = 18  ;
ax.LineWidth = 2;
plot(lambda_NL,delta_omega_p,'LineWidth',3)
plot(lambda_NL,delta_omega_m,'LineWidth',3)
ylim([-1 1])
xlabel('\lambda_{NL}')
ylabel('\Re(\Delta\omega)')
%colorbar 
hold off
ax.Layer = 'top';
saveas(gcf,'gap_size','pdf')