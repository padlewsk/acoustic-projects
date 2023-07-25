%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%
%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
%rng(1);%specifies the seed for the MATLAB® random number generator TEST
close all; pause(0); 
clear all; 
clc;
%% TOOLBOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath(genpath('\\files7.epfl.ch\data\padlewsk\My Documents\PhD\acoustic-projects-master\toolbox\matlab-toolbox'));

%% PARAMETERS, FUNCTIONS AND DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% RUN PARAMETERS FILE
addpath('./__fun/')
sys_param = sys_params();

%%% SAVE DATA FOR PLOTS
sim_name = "L_ref";

%%% LOAD DATA FOR PLOTS
%{
fprintf("### LOADING PARAMETERS, FUNCTION AND DATA...\n")
addpath('./__data/')
load raw_data__L_topo.mat % loads t_out and y_out from a saved simulation and skips current simulation
fprintf("### DONE.\n")
%}
%% SIMULATION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FREQ SWEEP RANGE
global N_cell t_fin %number of unit cells (= half the number of sites)
N_cell = 50; %2^5%N_cell/2 needs to be even?
mat_size = N_cell*8+1 ;%9*N_cell-(N_cell-1);

%%% SAMPLING (for post processing --> doesn't affect sim time alot)
f_samp = 5E5;
t_samp = 1/f_samp;

%%% SIMULATION TIME (MATLAB odes use adaptive ste1p size)
t_fin = 500E-3 + 0*4*N_cell*sys_param.a/sys_param.c0; %simulation time in seconds (time for sound to go from source to end of crystal)

%%% INITIALISATION
y0 = zeros(2*mat_size,1);% solver initial condition %y = [x1,...,xn,q1,...qn]'
%y0 = zeros(1,6)%RES 
%y0(mat_size + 3) = Caa*Sd;
 
%%% TODO: CRYSTAL S-MATRIX ANALYSIS
%{ 
F = [];     %frequency
R = [];     %reflection
T = [];     %transmission
alpha = []; %absorption
%}

if ~exist("t_out") % skips simulation if data has been loaded
    fprintf("### SIMULATING PULSE DYNAMICS ON METACRYSTAL...\n")
    %%% COUPLED ODE SOLVER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tic
    %'NormControl','on'
    opts = odeset('InitialStep', 1e-5, 'Refine', 8,'Stats','on'); % use refine to compute additional points
    temp = 0; %Future settings?
    [t_out,y_out] = ode89(@(t,y) odecrystal(t,y,temp),[0,t_fin], y0, opts);%dynamically adjusts sampling time
    toc
    fprintf("### DONE.\n")
else
    mat_size = size(y_out,2)/2;%%% extracts cell size from imported data
    N_cell = (mat_size-1)/8; 
end
%%% y_out = [x1,...,xn,q1,...qn] ? [acoustic charge, acoustic flow]

%% SAVE DATA
tic
if ~exist("__data", 'dir')
   mkdir("__data")
end
if ~isfile(string("./__data/raw_data__" + sim_name + ".mat"))
    save(string("./__data/raw_data__" + sim_name + ".mat"),"t_out","y_out")
else
    fprintf("### FILE NOT SAVED: FILE NAME ALREADY EXISTS\n")
end
toc

%% EXCTRACT DATA
x = y_out(:,1:mat_size);   % acoustic charge
q = y_out(:,mat_size+1:end);% acoustic flow
x_s = x(:,3:4:end); %the third node is where the first speaker is located and then every 4th that follows until the end.e.g. N=1 -> two columns: one for each speaker
p_s = 1/(sys_param.Caa)*(x(:,2:4:end) - x(:,3:4:end) - x(:,4:4:end)); %(xi-xs-xo)

%% FIGURES
%%% LOAD FIGURE PARAMETERS
fig_param = fig_params();

%%% PLOT
tic
close all
%%% Time domain plot of edge sites
fig1 = figure(1);
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});

plot(t_out,real(p_s(:,1)),'-')
plot(t_out,real(p_s(:,2)),'-')
plot(t_out,real(p_s(:,3)),'-.')
plot(t_out,real(p_s(:,4)),'-.')
hold off
box on
grid on
%title('Solution of van der Pol Equation (\mu = 1) with ODE45');
xlabel('Time t/T');
ylabel('Solution p');
legend('p_{11}','p_{12}','p_{21}','p_{22}')
what is fi
%ylim([-1,1])
%}

%%% TIME DOMAIN p(t,N) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%surface plot
[X,Y] = meshgrid(1:2*N_cell,t_out*1000);
Z = abs(p_s);

%{
for nn = 1:2*N_cell
    Z(:,nn) = abs(envelope(p_s(:,nn)));
end
%}

fig2 = figure(2); % \Delta t simulation time step

%colormap("pink");
surface(X,Y,Z,'EdgeColor','none')
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
set(gca,'color','none','YDir','normal')

%set(gcf,'InvertHardcopy','off','Color','none')
%{
c = imagesc(t_out*1000,1:2*N_cell,abs(p_s)'); %clims = [4 18];
c = colorbar;
c.Label.String = "AER pressure (Pa)";
c.Label.Interpreter = 'latex';
%}
%set(h, 'EdgeColor', 'none');
%{
for nn = 1:2*N_cell
plot3(nn*ones(numel(t_out)),t_out*1000,Z(:,nn))
hold on
end
hold off
%}
%xlim([0.5,2*N_cell-0.5])
ylim([t_out(1),t_out(end)/5]*1000)%
%ylim([t_out(1),t_out(end)]*1000)%
%zlim([0,param.A_src*2])
xlabel('site n')
ylabel('t (ms)')
%zlabel("$|p_n| (Pa)$",'Interpreter','latex')
%box on
%grid on
%colormap(jet(50))
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
clim([0, sys_param.A_src*1]);

view(135,60)

%%% FRENQUENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_vec =  0:t_samp:t_fin; 

%%% ZERO PADDING
%t_vec = linspace(0,t_fin,2^(nextpow2(numel(t_out))+4));%This time vector used to interpolate before performing the FFT. 
p_seg = interp1(t_out,p_s,t_vec); % Interpolate data 

t0 = 3/(sys_param.f_src); %3/(2*pi*param.c0/param.a/2);% pulse delay

t_seg = t_vec(t_vec>2*t0); %omit first data points
p_seg = p_seg(t_vec>2*t0,:); 

Y = fft2(p_seg)/length(p_seg); %2D FFT --> normalized to get amplitude in (Pa)
Y = fftshift(Y); %filters out DC component

NFFT_f = length(t_seg); % signal length
omega = 2*pi*f_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1)); %

NFFT_qa = length(p_seg); % signal length
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1));

%%% BAND FOLDING %%% RMK: N_cell must be EVEN
%{
Y_inner = [Y(:,N_cell/2+1:3*N_cell/2)];
Y_outer = flip([Y(:,3*N_cell/2+1:2*N_cell) Y(:,1:N_cell/2)],2);
Y_fold = (Y_inner+Y_outer);
%}
Y_fold = Y; %Bypass

%%% CUT OFF HIGH FREQUENCIES
fig3 = figure(3);
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
%set(gca,'FontSize',20)
%set(gcf,'position',[50, 50, 800, 1000]);
hold on
%imagesc(qa/pi,omega/(2*pi),abs(Y)); 
%imagesc(abs(Y_fold));
imagesc(qa/(pi),omega/(2*pi)/1000,abs(Y_fold));
%yline([422.380/1000 param.c0/param.a/2/1000],'r--',{'Local','Bragg'},'LineWidth',2);
%yline([415/1000 644.5/1000],'r--',{'Local','Bragg'},'LineWidth',2);
hold off
%colormap('hot');
colormap(magma);
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
%clim([0, param.A_src*1.5]);
clim([0, 1.5]);
xlabel("qa/\pi")% full unitcell
%ylabel("$(\omega-\omega_0)/(2\pi)$",'Interpreter','latex')
%xlabel("$qa/(2\pi)$",'Interpreter','latex')% halved unitcell
%ylabel("$\omega/(2\pi)$",'Interpreter','latex')
ylabel("f (kHz)")
xlim([-1,1])
ylim([-2*sys_param.c0/sys_param.a*0 sys_param.c0/sys_param.a]/1000)

%title("Transmission peak as a function of local disorder")

%{
%%% OUTPUT AND PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
q_i = y_out(:,mat_size+1);
q_o = y_out(:,2*mat_size);

%%% COMPUTE PRESSURES
psrc = source(A_pinc,f,t_out); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pref = psrc - rho0*c0*q_i;
ptra = rho0*c0*q_o;

%INTERPOLATION (JUST BEFORE FFT)
psrc = interp1(t_out,psrc,tspan_vec);
pref = interp1(t_out,pref,tspan_vec);
ptra = interp1(t_out,ptra,tspan_vec);


%%% CUT: ASSUME LIMIT CYCLE IS ACHEIVED AFTER 10 CYCLES
psrc = psrc(tspan_vec>10/f);
pref = pref(tspan_vec>10/f);
ptra = ptra(tspan_vec>10/f);

%%% FFT
[F1,Pinc] = onesideft(psrc,fs,2); %2sided spectrum, padding
[F2,Pref] = onesideft(pref,fs,2);
[F3,Ptra] = onesideft(ptra,fs,2);

%%% FIND FUNDAMENTAL AMPLITUDE
Pinc_idx = find(abs(Pinc) == max(abs(Pinc)));
Pref_idx = find(abs(Pref) == max(abs(Pref)));
Ptra_idx = find(abs(Ptra) == max(abs(Ptra)));

Pinc_f0 = Pinc(Pinc_idx);
Pref_f0 = Pref(Pref_idx);
Ptra_f0 = Ptra(Ptra_idx);

%%% FREQUENCY
F_temp = f;  

%%% REFLECTION COEF:
R_temp = Pref_f0/Pinc_f0;
%%% TRANSMISSION COEF:
T_temp = Ptra_f0/Pinc_f0;
%%% ABSORBTION COEF:
alpha_temp = 1 - abs(R_temp)^2 - abs(T_temp)^2;

%%% LOG
F = [F,F_temp];
R = [R,R_temp];
T = [T,T_temp];
alpha = [alpha,alpha_temp]; %transmission loss or inserstion loss

%%% FIGURE LOOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(gcf, 'Position',  [100, 100, 1600, 1000])

%%% DIAPHRAGM DISPL.
subplot(2,2,1);
plot(t_out*1000, y_out(:,3)*1000) 
grid on
box on%Pinc
xlim([0,tf*1000 + 0*(500/ff)*1000])
%ylim([-5E-4 5E-4])
xlabel("Time (ms)")
ylabel("Diaphragm displacement (mm)")
str = {'$$ \xi_{s} $$'};
legend(str, 'Interpreter','latex', 'Location','NW')
set(gca,'FontSize',18) 

%%% REF&TRA PRESSURES
subplot(2,2,2);
set(gca,'FontSize',18) 
hold on
%plot(F1,Pinc,'-')
plot(F3,Ptra,'-', 'Color', [0 0 1 0.4],'Linewidth',1)
plot(F2,Pref,'-', 'Color', [1 0 0 0.4],'Linewidth',1)
plot(F_temp,abs(Ptra_f0),'.b','MarkerSize',20)
plot(F_temp,abs(Pref_f0),'.r','MarkerSize',20)
hold off
box on
grid on
xlim([0 1000]);
ylim([0 A_pinc]);
xlabel("Frequency (Hz)")
ylabel("Amplitude (Pa)")
%%str = {'$$ max(FFT(P_{ref})) $$','$$ max(FFT(P_{tra})) $$'};
str = {'$$ FFT(p_{tra}) $$','$$ FFT(p_{ref}) $$'};
legend(str, 'Interpreter','latex', 'Location','NW')

%{
%%% FFTS
subplot(2,3,3);
set(gca,'FontSize',18) 
hold on
plot(F_temp,abs(Ptra_f0),'ob')
plot(F_temp,abs(Pref_f0),'or')
hold off
box on
grid on
xlim([0 1000]);
ylim([0 A_pinc]);
xlabel("Frequency (Hz)")
ylabel("Amplitude (Pa)")
str = {'$$ max(FFT(P_{tra})) $$','$$ max(FFT(P_{ref})) $$'};
%str = {'$$ P_{ref} $$','$$ P_{tra} $$'};
legend(str, 'Interpreter','latex', 'Location','NW')
%}

%%% REF,TRA,ABS COEFS
subplot(2,2,[3,4]); 
set(gca,'FontSize',18) 
hold on
plot(F,alpha,'o-','color',[0, 0.4470, 0.7410])
plot(F,abs(R),'o-','color',[0.8500, 0.3250, 0.0980])
plot(F,abs(T),'o-','color',[0.9290, 0.6940, 0.1250])
hold off
xlim([fi,ff])
ylim([0,1])
xlabel("Frequency (Hz)")
box on
grid on
str = {'$\alpha$','R','T'};
legend(str, 'Interpreter','latex', 'Location','NW')

drawnow
%}


hold off

fig4 = figure(4);
plot(t_out(2:end)-t_out(1:end-1))
title("step size (s)")

autoArrangeFigures
toc

%% SAVE FIGURES
%
%exportgraphics(fig2, string("./__figures/fig__" + sim_name + "_ST" + ".pdf"), 'ContentType', 'image');
%exportgraphics(fig3, string("./__figures/fig__" + sim_name + "_ST" + ".pdf"), 'ContentType', 'vector')
%{
tic
if ~exist("__figures", 'dir')
   mkdir("__figures")
end
if ~isfile(string("./__figures/fig__" + sim_name + "_ST" + ".pdf"))
    exportgraphics(fig2, string("./__figures/fig__" + sim_name + "_ST" + ".pdf"), 'ContentType', 'vector')
elseif ~isfile(string("./__figures/fig__" + sim_name + "_disp" + ".pdf"))
    exportgraphics(fig3, string("./__figures/fig__" + sim_name + "_disp" + ".pdf"), 'ContentType', 'vector')% save the figure as a tightly cropped PDF file
else
    fprintf("### FIGURE NOT SAVED: FILE NAME ALREADY EXISTS\n")
end
toc
%}