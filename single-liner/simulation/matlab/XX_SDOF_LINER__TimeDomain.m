clear 
close all
clc

c0=344.5389; %% sound velocity in the air
rho=1.1965; %% mass density of the air

Zc=rho*c0; %% specific acoustic impedance of the air

%%%%%%%%%%%% Closed-box Loudspeaker parameter settings %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Loudspeaker model = Visaton %%%%%%%%%%%%%%%%%%%%
Mms=0.5936e-3; %% moving mass
Rms=0.3529; %% mechanical resistance
Cmc=1.7285e-4; %% mechanical overall compliance (loudspeaker with enclosure)
Kmc=1/Cmc; %% mechanical stiffness

Sd=12e-4; %% effective surface area
Bl=1.4351; %% force factor

Mas=Mms/Sd;
Ras=Rms/Sd;
Kac=Kmc/Sd;
Cac=Cmc*Sd;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%% Control law settings %%%%%%%%%%%%%%%%%%%%
% mu_R=Zc*Sd/Rms;
mu_R=1;

%%%% analytical expressions
omega_th=linspace(1,1500,3000)*2*pi; %% angular frequency

mu_M1=1;
mu_C1=1;
Za_1=(mu_M1*Mms*1j*omega_th+mu_R*Rms+mu_C1/Cmc./(1j*omega_th))/Sd;
alpha_1=1-abs((Za_1-Zc)./(Za_1+Zc)).^2;

mu_M2=1;
mu_C2=0.25;
Za_2=(mu_M2*Mms*1j*omega_th+mu_R*Rms+mu_C2/Cmc./(1j*omega_th))/Sd;
alpha_2=1-abs((Za_2-Zc)./(Za_2+Zc)).^2;
% 
% Za_mddl=1./(1./Za_1+1./Za_2);
% alpha_mddl=1-abs((Za_mddl-Zc)./(Za_mddl+Zc)).^2;

e=0; %% coupling parameter between 2 loudspeaker
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%% parameters settings %%%%%%%%%%%%%%%%%%%%%%%%%%%
h=0.05;
Sd1=h*sqrt(Sd);
Vb=Sd1*(sqrt(Sd));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% NL coupling parameters %%%%%%%%%%%%%%%%%%%%%%%%%%
sens=-40e-3; %%% sensibilité micro
ampli=1/103.8; %%%% V to I %%%%
Ratio_pb=1.25e6;
sens_uv=10;

beta_NL1=-12; %% Vi*abs(Uj)

% e_NL=beta_NL1*((Ratio_pb*sens)*abs(Ratio_pb*sens)*ampli*Bl)/Sd;

% e_NL=beta_NL1*((sens_uv)*(abs(Ratio_pb*sens))^0.5*ampli*Bl)/Sd;
e_NL=0;
e_NL2=0;
e_L=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% RK4 time integration method %%%%%%%%%%%%%%%%%%%%%%%%%%%
t_inc=0;
t_final=10;
fe=1e5;
dt=1/fe;
N=floor((t_final-t_inc)/dt+1);%% length of the time signal
t=linspace(t_inc,t_final,N);

%%%%%%%%%%%%%%%%%%%% Time delay of Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% t_delay=20e-6; 
% N_delay=round(t_delay/dt);

%%%% N_delay=1 if no additional time delay
t_delay=dt; 
N_delay=1;%% N_delay=1 if no additional time delay
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% excitation source (pressure) %%%%%%%%%%%%%%%%%%%%
%%%%% source = sweep from f0 to f1
f0=20;
f1=2020;
T=t_final;
k=(f1-f0)/T;
source=@(t) sin(2*pi*(f0*t+k/2*t.^2)); %% sweep sine
dsource=@(t) cos(2*pi*(f0*t+k/2*t.^2))*2*pi*(f0+k*t); %% first derivative sweep sine

% % %%% source = sine wave
% finc=250;
% source=@(t) sin(2*pi*finc*t); %% sine wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% motion equation %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ca=Vb/1/rho/c0^2/Sd1*1;
Ma=Vb/2*rho/Sd1*1;

motion1=@(U1,V1,U3,V3,U4,V4,Source) (1/Ca*(U3-U1*Sd/Sd1-U4)-mu_C1*Kac*U1-mu_R*Ras*V1-e_NL*(1/Ca*(U3-U1*Sd/Sd1-U4))^2-e_NL2*(1/Ca*(V3-V1*Sd/Sd1-V4))^2-e_L*(1/Ca*(U3-U1*Sd/Sd1-U4)))/Mas/mu_M1; %% motion equation of the loudspeaker membrane 1
motion3=@(U1,V1,U3,V3,U4,V4,Source) (2*Source-Zc*V3-1/Ca*(U3-U1*Sd/Sd1-U4))/Ma; 
motion4=@(U1,V1,U3,V3,U4,V4,Source) (1/Ca*(U3-U1*Sd/Sd1-U4)-Zc*V4)/Ma;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% solving equations with 4th-order time integration method %%%%%%%%%
%%%%% initial values
u1=0; %% membran displacement 1
v1=0; %% membrane velocity 1

u3=0; %% membran displacement 3
v3=0; %% membrane velocity 3

u4=0; %% membran displacement 4
v4=0; %% membrane velocity 4


%%%%% for recording the results
uu1=zeros(N,1);
vv1=zeros(N,1);

uu3=zeros(N,1);
vv3=zeros(N,1);

uu4=zeros(N,1);
vv4=zeros(N,1);



%%%%%% solving the equations
for n=2:N

%%%%%%%%% k1 %%%%%%%%%%%%
t1=t(n-1);
s1=source(t1);
% n_delay=1+(n-N_delay-2)*(sign(n-N_delay-2)+1)/2;

u1_1=u1;
v1_1=v1;

u3_1=u3;
v3_1=v3;

u4_1=u4;
v4_1=v4;


k1_u1=dt*v1_1;
k1_v1=dt*motion1(u1_1,v1_1,u3_1,v3_1,u4_1,v4_1,s1);

k1_u3=dt*v3_1;
k1_v3=dt*motion3(u1_1,v1_1,u3_1,v3_1,u4_1,v4_1,s1);

k1_u4=dt*v4_1;
k1_v4=dt*motion4(u1_1,v1_1,u3_1,v3_1,u4_1,v4_1,s1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% k2 %%%%%%%%%%%
t2=t(n-1)+0.5*dt;
s2=source(t2);

u1_2=u1_1+0.5*k1_u1;
v1_2=v1_1+0.5*k1_v1;

u3_2=u3_1+0.5*k1_u3;
v3_2=v3_1+0.5*k1_v3;

u4_2=u4_1+0.5*k1_u4;
v4_2=v4_1+0.5*k1_v4;


k2_u1=dt*v1_2;
k2_v1=dt*motion1(u1_2,v1_2,u3_2,v3_2,u4_2,v4_2,s2);

k2_u3=dt*v3_2;
k2_v3=dt*motion3(u1_2,v1_2,u3_2,v3_2,u4_2,v4_2,s2);

k2_u4=dt*v4_2;
k2_v4=dt*motion4(u1_2,v1_2,u3_2,v3_2,u4_2,v4_2,s2);



%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% k3 %%%%%%%%%%%
t3=t(n-1)+0.5*dt;
s3=source(t3);

u1_3=u1_1+0.5*k2_u1;
v1_3=v1_1+0.5*k2_v1;

u3_3=u3_1+0.5*k2_u3;
v3_3=v3_1+0.5*k2_v3;

u4_3=u4_1+0.5*k2_u4;
v4_3=v4_1+0.5*k2_v4;


k3_u1=dt*v1_3;
k3_v1=dt*motion1(u1_3,v1_3,u3_3,v3_3,u4_3,v4_3,s3);

k3_u3=dt*v3_3;
k3_v3=dt*motion3(u1_3,v1_3,u3_3,v3_3,u4_3,v4_3,s3);

k3_u4=dt*v4_3;
k3_v4=dt*motion4(u1_3,v1_3,u3_3,v3_3,u4_3,v4_3,s3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%% k4 %%%%%%%%%
t4=t(n-1)+dt;
s4=source(t4);

u1_4=u1_1+1*k3_u1;
v1_4=v1_1+1*k3_v1;

u3_4=u3_1+1*k3_u3;
v3_4=v3_1+1*k3_v3;

u4_4=u4_1+1*k3_u4;
v4_4=v4_1+1*k3_v4;


k4_u1=dt*v1_4;
k4_v1=dt*motion1(u1_4,v1_4,u3_4,v3_4,u4_4,v4_4,s4);

k4_u3=dt*v3_4;
k4_v3=dt*motion3(u1_4,v1_4,u3_4,v3_4,u4_4,v4_4,s4);

k4_u4=dt*v4_4;
k4_v4=dt*motion4(u1_4,v1_4,u3_4,v3_4,u4_4,v4_4,s4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u1=u1_1+(k1_u1+2*k2_u1+2*k3_u1+k4_u1)/6;
v1=v1_1+(k1_v1+2*k2_v1+2*k3_v1+k4_v1)/6;

u3=u3_1+(k1_u3+2*k2_u3+2*k3_u3+k4_u3)/6;
v3=v3_1+(k1_v3+2*k2_v3+2*k3_v3+k4_v3)/6;

u4=u4_1+(k1_u4+2*k2_u4+2*k3_u4+k4_u4)/6;
v4=v4_1+(k1_v4+2*k2_v4+2*k3_v4+k4_v4)/6;


uu1(n)=u1;
vv1(n)=v1;

uu3(n)=u3;
vv3(n)=v3;

uu4(n)=u4;
vv4(n)=v4;


% n/N
end

%%
pinc=source(t)';
vv=vv3;
pref=source(t)'-Zc*(vv3);

ptr=Zc*vv4;

NFFT = 2^nextpow2(N);
%%% with transfer function
ff=linspace(0,pi,NFFT/2+1)/pi/2/dt; %% frequency vector 

c=4;
R_tf=tfestimate(pinc,pref,hamming(round(N/c)),'',NFFT); 

T_tf=tfestimate(pinc,ptr,hamming(round(N/c)),'',NFFT); 

alpha_tf=1-abs(R_tf).^2-abs(T_tf).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% with FFT
f = linspace(0,1,NFFT/2+1)/2/dt; %% frequency vector 

Pinc = fft(pinc,NFFT)/N*2; %% FFT of pressure
Pref = fft(pref,NFFT)/N*2; %% FFT of pressure
Ptr = fft(ptr,NFFT)/N*2; %% FFT of pressure

V = fft(vv,NFFT)/N*2; %% FFT of velocity

R_fft=(Pref./Pinc);

T_fft=Ptr./Pinc;

alpha_fft=1-abs(R_fft).^2-abs(T_fft).^2; %% absorption coefficient
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Datac=load('SDOF_RT.txt');

ffc=50:5:2000;
alphac=mean(Datac(:,5:3:end));
Tc=mean(Datac(:,4:3:end));
Rc=mean(Datac(:,3:3:end));

% Datac=load('SDOF_passive_muR=1_Matlab_test.txt');
% n= find(abs(f-1500)==min(abs(f-1500)));
% ffc=ff(1:n);
% Rc=Datac(:,1);
% Tc=Datac(:,2);
% alphac=Datac(:,3);
% % 

figure(1)
set(gcf,'Position',[400 200 1200 800])
plot(ffc, Rc,'.-','LineWidth',2)
hold on
plot(ffc, Tc,'.-','LineWidth',2)
plot(ffc, alphac,'.-','LineWidth',2)
plot(ff, abs(R_tf),'--','LineWidth',2)
plot(ff, abs(T_tf),'--','LineWidth',2)
plot(ff, alpha_tf,'--','LineWidth',2)
hold off
xlim([100,1000])
legend('abs(R) (Comsol)', 'abs(T) (Comsol)', 'alpha (Comsol)','abs(R) (Matlab)', 'abs(T) (Matlab)', 'alpha (Matlab)')
% legend('abs(R) (passive)', 'abs(T) (passive)', 'alpha (passive)','abs(R) (Matlab)', 'abs(T) (Matlab)', 'alpha (Matlab)')
title('Theoretical (Matlab) VS Simulation (Comsol)')
ylim([0,1])
set(gca, 'FontSize',18)

% Datac=load('2DOF_scattering_2_Comsol.txt');
% 
% ffc=50:5:1600;
% alphac=mean(Datac(:,3:3:end));
% Tc=mean(Datac(:,4:3:end));
% Rc=mean(Datac(:,5:3:end));
% % 
% figure(2)
% set(gcf,'Position',[400 200 1200 800])
% plot(ffc, Rc.^2,'.-','LineWidth',2)
% hold on
% plot(ffc, Tc.^2,'.-','LineWidth',2)
% plot(ffc, alphac,'.-','LineWidth',2)
% plot(ff, abs(R_tf).^2,'--','LineWidth',2)
% plot(ff, abs(T_tf).^2,'--','LineWidth',2)
% plot(ff, alpha_tf,'--','LineWidth',2)
% hold off
% xlim([100,1500])
% legend('abs(R)^2 (Comsol)', 'abs(T)^2 (Comsol)', 'alpha (Comsol)','abs(R)^2 (Matlab)', 'abs(T)^2 (Matlab)', 'alpha (Matlab)')
% title('Theoretical (Matlab) VS Simulation (Comsol)')
% ylim([0,1])
% set(gca, 'FontSize',18)



%%
figure(3)
set(gcf,'Position',[400 200 1800 500])
subplot(1,3,1)
plot(f, abs(Pref(1:NFFT/2+1))/max(abs(Pinc(1:NFFT/2+1))),'.-','LineWidth',2)
xlim([100,2000])
ylim([0,1])
title('reflected pressure')
set(gca, 'FontSize',18)

subplot(1,3,2)
plot(f, abs(Ptr(1:NFFT/2+1))/max(abs(Pinc(1:NFFT/2+1))),'.-','LineWidth',2)
xlim([100,2000])
ylim([0,1])
title('transmitted pressure')
set(gca, 'FontSize',18)

subplot(1,3,3)
plot(f, abs(V(1:NFFT/2+1)),'.-','LineWidth',2)
xlim([100,2000])
title('velocity')
set(gca, 'FontSize',18)


