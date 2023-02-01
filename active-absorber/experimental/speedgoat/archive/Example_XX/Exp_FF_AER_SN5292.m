clear all
close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MDL = 'speedgoat_test_SN5292_R2019a_FF_AER'; % name of the slx model

%set_param(0, 'CodegenFolder', './build/');
%set_param(0, 'CacheFolder', './build/');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% parameter settings %%%%%%%%%%%%%%%%%%%%%%%%%%%
Fe=40e3; %% sample frequency (Hz)

%%% of source (chirp)
t_sample=1/Fe; %% sample time (s)

f_inc=80; %% initial frequency
f_target=1100; %% target frequency

Amp=0.02; %% source amplitude

t_target=10; %% target time (s)
t_sweep=t_target; %% sweep time (s)

%%%%%%%% of from workspace
t_decay=1;
t_zeros=1;
t_total=t_target+t_decay+t_zeros;

tt=linspace(0,t_total,t_total*Fe);

shape=[ones(1,t_target*Fe), 1-linspace(0,1,(t_decay)*Fe), zeros(1,t_zeros*Fe)];

simin.time = tt;
simin.signals.values = shape';
simin.signals.dimensions =1;

t_run=t_total+1; %% Runing time (s) 

%%% of scopes
Nb_decimation=1;%% decimation for recording 

Nb_samples=Fe/Nb_decimation*t_total; %% numebers of samples

%%% of control

rho=1.2;
c0=343;
Zc=rho*c0;

Mms=6.0821e-4;
Rms=0.3727;
Kms=1/1.6899e-4;

% ratio_pu=1.33e6;

TS_para=[Mms Rms Kms];

Sd=12e-4;
Bl=1.5026;
Gain_ui=103.8;

sens_pf=-0.04/0.9937;
sens_pb=-0.04/1.011;

mu_M=0.5;
mu_R=Zc*Sd/Rms;
mu_C=0.5;

NUM=[(mu_M-1) (mu_R-1) (mu_C-1)].*TS_para*(Sd/Bl)*Gain_ui/sens_pf;
DEN=[(mu_M) (mu_R) (mu_C)].*TS_para;

tf_c=tf(NUM, DEN);
tf_d=c2d(tf_c, 1/Fe);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%%%%%%%%%%%%%%%%%%%%%%%% set the parameter values to Simulink model %%%%%%%
%%%%% for runing time
set_param([MDL], 'StopTime',num2str(t_run))

%%%%%% For sources
set_param([MDL, '/Chirp1'], 'f0', num2str(f_inc));
set_param([MDL, '/Chirp1'], 'Tsweep', num2str(t_sweep));
set_param([MDL, '/Chirp1'], 'f1', num2str(f_target));
set_param([MDL, '/Chirp1'], 't1', num2str(t_target));
set_param([MDL, '/Chirp1'], 'Ts', num2str(t_sample));

set_param([MDL, '/Gain1'], 'Gain', num2str(Amp));

set_param([MDL, '/Constant'], 'SampleTime', num2str(t_sample));
set_param([MDL, '/Constant1'], 'SampleTime', num2str(t_sample));

%%%%%% for hiagh pass filters
set_param([MDL, '/Highpass Filter'], 'SampleRate', num2str(Fe));
set_param([MDL, '/Highpass Filter1'], 'SampleRate', num2str(Fe));
set_param([MDL, '/Highpass Filter2'], 'SampleRate', num2str(Fe));
set_param([MDL, '/Highpass Filter3'], 'SampleRate', num2str(Fe));

%%%%%%% For the host scope and the target scope
set_param([MDL, '/Scope '], 'nosamples', num2str(Nb_samples));
set_param([MDL, '/Scope '], 'interleave', num2str(Nb_decimation));

set_param([MDL, '/Scope 2'], 'nosamples', num2str(Nb_samples));
set_param([MDL, '/Scope 2'], 'interleave', num2str(Nb_decimation));

%%%%%% for control
set_param([MDL, '/control system/Phi'], 'Denominator', Phi_d.den);
set_param([MDL, '/control system/Phi'], 'Numerator',  ['[', num2str(tf_d.num{1}), ']']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%% run the model %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load_system(MDL);
rtwbuild(MDL); %%% build the code of the model

tg = slrt('Performance'); %%% create objects to manipulate the target
load(tg, fullfile(get_param(0, 'CodegenFolder'), MDL));
%%
mu_M=0.5;
mu_R=Zc*Sd/Rms;
mu_C=0.5;


NUM=[(mu_M-1) (mu_R-1) (mu_C-1)].*TS_para*(Sd/Bl)*Gain_ui/sens_pf;
DEN=[(mu_M) (mu_R) (mu_C)].*TS_para;

tf_c=idtf(NUM, DEN);
tf_d=c2d(tf_c, 1/Fe);

tg.setparam('control system/Phi', 'Numerator', tf_d.num)
tg.setparam('control system/Phi', 'Denominator', tf_d.den)

tg.start;

sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope whose id is 2
sc.start;

while strcmp(sc.Status, 'Finished')==0
    
pause(0.01);
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%% record the resulting data %%%%%%%%%%%%%%%%%%%%%%%%%%
t=sc.Time; 
Data=sc.Data; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%% process the signals %%%%%%%%%%%%%%%%%%%%

%%%%%% time signals
t=t-t(1);
data1=Data(:,1); %% pressure
data2=Data(:,2); %% velocity
data3=Data(:,3); %% generated source 
data4=Data(:,4); %% feedback voltage

sens_v=-100;  %% V/(m/s)

p=data1/sens_pf; %% front pressure
v=data2/sens_v; %% velocity
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NFFT = length(t); 
%%%%%%  FFT 
% ff = linspace(0,1,NFFT/2+1)/2*Fe; %% vector of frequency
% 
% P = fft(p,NFFT)/NFFT*2; %% FFT
% V = fft(v,NFFT)/NFFT*2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% frequency-domain Transfer Function (TF) 
cut=32;
t_cut=t_decay+t_zeros;
[Zs,f]=tfestimate(v(1:end-t_cut*Fe),p(1:end-t_cut*Fe),hamming(NFFT/cut), '', NFFT); 
f=f/pi/2*Fe; %% frequency vector in Hz

TF_P=tfestimate(data3(1:end-t_cut*Fe),p(1:end-t_cut*Fe),hamming(NFFT/cut), '', NFFT);
TF_V=tfestimate(data3(1:end-t_cut*Fe),v(1:end-t_cut*Fe),hamming(NFFT/cut), '', NFFT);

alpha=1-abs((Zs-Zc)./(Zs+Zc)).^2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%% reset to zero %%%%%%%%
set_param([MDL, '/Chirp1'], 't1', num2str(0));

set_param([MDL, '/control system/Phi'], 'Numerator',  ['[', num2str(0), ']']);
set_param([MDL, '/control system/Phi'], 'Denominator', ['[', num2str(1), ']']);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Phi=tfestimate(data1(1:end-t_cut*Fe),data4(1:end-t_cut*Fe),hamming(NFFT/cut), '', NFFT); 

Phi_0=(NUM(1)*(1j*2*pi*f).^2+NUM(2)*(1j*2*pi*f)+NUM(3))./(DEN(1)*(1j*2*pi*f).^2+DEN(2)*(1j*2*pi*f)+DEN(3));

data0=load('ER_passive.txt');
f0=data0(:,1);
alpha0=data0(:,2);

Zs0=data0(:,3)+1i*data0(:,4);

FontSize=12;
figure(1)
set(gcf, 'Position', [200,150,1600,900])
subplot(3,3,1)
plot(t,p,'-','MarkerSize',10)
xlabel('t (s)')
ylabel('Pa')
ylim([min(p),max(p)]*1.1)
title('Pressure')
xlim([0,t_sweep])
set(gca,'FontSize',FontSize)

subplot(3,3,2)
plot(t,v,'-','MarkerSize',10)
xlabel('t (s)')
title('Velocity')
ylabel('m/s')
ylim([min(v),max(v)]*1.1)
xlim([0,t_sweep])
set(gca,'FontSize',FontSize)

subplot(3,3,4)
plot(f,abs(TF_P),'-','MarkerSize',10)
xlabel('f (Hz)')
title('TF(P,source)')
ylabel('Pa/V')
xlim([f_inc,f_target])
set(gca,'FontSize',FontSize)

subplot(3,3,5)
plot(f,abs(TF_V),'-','MarkerSize',10)
xlabel('f (Hz)')
title('TF(V, source)')
ylabel('(m/s)/V')
xlim([f_inc,f_target])
set(gca,'FontSize',FontSize)

subplot(3,3,7)
plot(t,data4,'-','MarkerSize',10)
xlabel('t (s)')
ylabel('V')
xlim([0,t_target])
ylim([min(data4),max(data4)]*1.1)
title('feedback voltage')
set(gca,'FontSize',FontSize)

subplot(3,3,8)
plot(f,abs(Phi),'-','MarkerSize',10)
hold on
plot(f,abs(Phi_0),'-','MarkerSize',10)
hold off
xlabel('f (Hz)')
ylabel('Abs.')
legend('exp','analytical')
xlim([f_inc,f_target])
title('transfer function')
set(gca,'FontSize',FontSize)

subplot(2,3,3)
plot(f0,abs(Zs0),'-','MarkerSize',10)
hold on
plot(f,abs(Zs),'-','MarkerSize',10)
hold off
xlabel('f (Hz)')
xlim([f_inc,f_target])
legend('passive case',['law: muM=', num2str(mu_M), ', muC=',num2str(mu_C), ', muR=', num2str(mu_R)])
title('Impedance')
ylim([0,6000])
set(gca,'FontSize',FontSize)

subplot(2,3,6)
plot(f0,alpha0,'-','MarkerSize',10)
hold on
plot(f,alpha,'-','MarkerSize',10)
% hold off
xlabel('f (Hz)')
legend('passive case',['law: muM=', num2str(mu_M), ', muC=',num2str(mu_C), ', muR=', num2str(mu_R)])
xlim([f_inc,f_target])
ylim([0,1])
title('absorption coeffient')
set(gca,'FontSize',FontSize)

data=[f,alpha,real(Zs),imag(Zs)];
% MU=zeros(50,3); % MU=[mu_M, mu_R, mu_C];
% MU(1,:)=[1,Zc*Sd/Rms,0.05];
% MU(2,:)=[1,Zc*Sd/Rms,0.06];
% MU(3,:)=[1,Zc*Sd/Rms,0.07];
% MU(4,:)=[1,Zc*Sd/Rms,0.08];
% MU(5,:)=[1,Zc*Sd/Rms,0.09];
% MU(6,:)=[1,Zc*Sd/Rms,0.1];
% MU(7,:)=[1,Zc*Sd/Rms,0.2];
% MU(8,:)=[1,Zc*Sd/Rms,0.3];
% MU(9,:)=[1,Zc*Sd/Rms,0.4];
% MU(10,:)=[1,Zc*Sd/Rms,0.5];
% MU(11,:)=[1,Zc*Sd/Rms,0.6];
% MU(12,:)=[1,Zc*Sd/Rms,0.7];
% MU(13,:)=[1,Zc*Sd/Rms,0.8];
% MU(14,:)=[1,Zc*Sd/Rms,0.9];
% MU(15,:)=[1,Zc*Sd/Rms,1];
% MU(16,:)=[0.9,Zc*Sd/Rms,1];
% MU(17,:)=[0.8,Zc*Sd/Rms,1];
% MU(18,:)=[0.7,Zc*Sd/Rms,1];
% MU(19,:)=[0.6,Zc*Sd/Rms,1];
% MU(20,:)=[0.5,Zc*Sd/Rms,1];
% MU(21,:)=[0.4,Zc*Sd/Rms,1];
% MU(22,:)=[0.3,Zc*Sd/Rms,1];
% MU(23,:)=[0.25,Zc*Sd/Rms,1];
% MU(24,:)=[0.2,Zc*Sd/Rms,1];

% FontSize=12;
% figure(2)
% set(gcf, 'Position', [500,30,1000,1000])
% subplot(2,2,1)
% plot(t,data1,'-','MarkerSize',10)
% xlabel('t (s)')
% ylabel('V')
% ylim([min(data1),max(data1)]*1.1)
% title('input1 (front pressure)')
% xlim([0,t_target+t_decay])
% set(gca,'FontSize',FontSize)
% 
% subplot(2,2,2)
% plot(t,data2,'-','MarkerSize',10)
% xlabel('t (s)')
% ylabel('V')
% ylim([min(data2),max(data2)]*1.1)
% title('input2 (velocity)')
% xlim([0,t_target+t_decay])
% set(gca,'FontSize',FontSize)
% 
% subplot(2,2,3)
% plot(t,data3,'-','MarkerSize',10)
% xlabel('t (s)')
% ylabel('V')
% ylim([min(data3),max(data3)]*1.1)
% title('input3 (source)')
% xlim([0,t_target+t_decay])
% set(gca,'FontSize',FontSize)
% 
% subplot(2,2,4)
% plot(t,data4,'-','MarkerSize',10)
% xlabel('t (s)')
% ylabel('V')
% ylim([min(data4),max(data4)]*1.1)
% title('input4 (feedback voltage)')
% xlim([0,t_target+t_decay])
% set(gca,'FontSize',FontSize)

