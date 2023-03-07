%% NH SSH MODEL 

%REGIME 1: WEAKLY COUPLED DIMER: |v| << |w|
%REGIME 2: STRONGLY COUPLED DIMER: |v| >> |w|
close all
clear all
clc
% parameters
global a0 c0 
a0 = 0.28; % cell size (m)
c0 = 347; % air speed (m/s)

%
N = 80;
%qa = linspace(-pi,pi,N); %q_Floquet
freq = linspace(0,c0/a0,N); %q_Floquet
lambda = 0.13; %dimerization parameter 
v = 0.5*(1 + lambda); % intracell coupling
w = 0.5*(1 - lambda); % intercell coupling




kl = 2*pi*freq/c0*a0/2; %kl!!!
gamma0 = (Yms(kl)); %losses
qa_up_0 = acos((2*(cos(kl)+1i*gamma0).^2 - (1+lambda^2))/(1-lambda^2));
%qa_dn_0 = 




%%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
figure(1)
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
box on
plot(kl/(pi),imag(Yms(kl)),'b-','LineWidth',3)


figure(2)
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
box on
%xlim([-1,1])
%ylim([0,1])
hold on
plot(real(qa_up_0)/pi,kl/(pi) ,'r-','LineWidth',3)
plot(abs(imag(qa_up_0))/pi,kl/(pi) ,'k--','LineWidth',3)
plot(abs(Yms(kl)),kl/(pi),'b-','LineWidth',3)
%plot(qa/pi,real(ka_dn_0)/pi,'r-','LineWidth',3)
%plot(qa/pi,ka_up_1/pi,'b-','LineWidth',3)
%plot(qa/pi,ka_dn_1/pi,'r-','LineWidth',3)
%yline(omega_0,'--','\omega_0','LineWidth',2,'FontSize',18)
%yline(gamma_0,'--','','LineWidth',2,'FontSize',18)
grid on
hold off
%set(gca,'XTick',-pi:pi/2:pi)
%set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})

 
xlabel("q_Fa/\pi")
%ylabel("Unitcell Eigenfrequencies (\omega_0)")
ylabel("ka/\pi")
legend('Re(q_Fa/\pi)','Im(q_Fa/\pi)','Y_{norm}')
%title('BAND DIAGRAM', sprintf('v = %.1f, w = %.1f',[v,w]))

axis square

%%%

function YY = Yms(kl)
global c0
global a0
Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)
freq =  2*c0.*kl./(2*pi*a0);
%kl = 2*pi*freq/c0*a0/2; %kl!!!
% losses
YY = Rms./((1i*2*pi*freq).*Mms + Rms + 1./((1i*2*pi*freq)*Cmc));
end
