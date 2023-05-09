%% NON-HERMITIAN SSH MODEL (BLOCH TH APPLIES)

%REGIME 1: WEAKLY COUPLED DIMER: |v| << |w|
%REGIME 2: STRONGLY COUPLED DIMER: |v| >> |w|
close all
clear all
clc
% parameters
global a c0 
a = 0.28; % cell size (m)
c0 = 347; % air speed (m/s)

%
N = 80; %number of frequency points
%qa = linspace(-pi,pi,N); %q_Floquet
freq = linspace(0,c0/a,N); %q_Floquet
lambda = 0.13; %dimerization parameter 
K = 1/2; %must be 0.5
v = K*(1 + lambda); % intracell coupling
w = K*(1 - lambda); % intercell coupling

kl = 2*pi*freq/c0*a/2; %kl!!!
E0 = cos(2*pi*(c0/a/2)*a/2) % pseudo acoustic energy := cos(q0a/2), q0 =2*pi*omega0/0 ?????
qa_h = acos(((1/K)*(cos(kl) - E0 ).^2 - (1+lambda^2))/(1-lambda^2)); %hermitian
qa_nh = acos(((1/K)*(cos(kl) - E0 + 1i*gamma(kl)).^2 - (1+lambda^2))/(1-lambda^2)); %non hermitian
%qa_dn_0 = 


%% FIGURES %%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
fig1=figure(1)

set(gca,'FontSize',18)
set(gca,'LineWidth',2)
hold on
plot(real(gamma(kl)),kl/(pi),'k-','LineWidth',3)
plot(imag(gamma(kl)),kl/(pi),'k--','LineWidth',3)
hold off
grid on
xlim([-1,1])
ylim([0,1])
box on
xlabel("q_Fa/\pi")
ylabel("ka/(2\pi)")
legend('Re(q_Fa/\pi)','Im(q_Fa/\pi)','Y_{norm}')
%title('Effective losses')
axis square

fig2 = figure(2)
set(gca,'FontSize',18)
set(gca,'LineWidth',2)
%xlim([-1,1])
%ylim([0,1])
hold on
plot(real(qa_h)/pi,kl/(pi) ,'r-','LineWidth',3)
plot(abs(imag(qa_h))/pi,kl/(pi) ,'k--','LineWidth',3)
%plot(abs(gamma(kl)),kl/(pi),'b-','LineWidth',3)
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
ylabel("ka/(2\pi)")
legend('Re(q_Fa/\pi)','Im(q_Fa/\pi)','Y_{norm}')
%title('BAND DIAGRAM', strcat('\lambda ',sprintf(' = %.2f',lambda)))
axis square
box on

fig3 = figure(3)
set(gca,'FontSize',18)
set(gca,'LineWidth',2)

%xlim([-1,1])
%ylim([0,1])
hold on
plot(real(qa_nh)/pi,kl/(pi) ,'r-','LineWidth',3)
plot(abs(imag(qa_nh))/pi,kl/(pi) ,'k--','LineWidth',3)

grid on
hold off
%set(gca,'XTick',-pi:pi/2:pi)
%set(gca,'XTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
xlabel("q_Fa/\pi")
%ylabel("Unitcell Eigenfrequencies (\omega_0)")
ylabel("ka/(2\pi)")
legend('Re(q_Fa/\pi)','Im(q_Fa/\pi)','Y_{norm}')
%title('BAND DIAGRAM', strcat('\lambda ',sprintf(' = %.2f',lambda)))
axis square
box on

%% SAVE GRAPHICS
%matlab2tikz('NH_SSH_Znorm.tex');
%print(gcf, '-dpdf', './__figures/NH_SSH_Znorm.pdf');
exportgraphics(fig1,'./__figures/NH_SSH_Znorm.pdf','BackgroundColor','none')
exportgraphics(fig2,'./__figures/NH_SSH_dispersion_H.pdf','BackgroundColor','none')
exportgraphics(fig3,'./__figures/NH_SSH_dispersion_NH.pdf','BackgroundColor','none')


function YY = gamma(kl) %loss function
global c0
global a
Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)
freq =  2*c0.*kl./(2*pi*a);
f0 = 1/(2*pi*sqrt(Mms*Cmc));
%kl = 2*pi*freq/c0*a0/2; %kl!!!
% losses
YY = Rms./((1i*2*pi*freq).*Mms + Rms + 1./((1i*2*pi*freq)*Cmc));
end


