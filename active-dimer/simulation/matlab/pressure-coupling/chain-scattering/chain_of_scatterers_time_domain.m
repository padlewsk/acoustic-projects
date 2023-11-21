%%% SCATTERING THROUGH AN ACOUSTIC LINER IN TIME DOMAIN %%%%%%%%%%%%%%%%%%
%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
%rng(1);%specifies the seed for the MATLAB® random number generator TEST
close all;  
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

%% SIMULATION  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% INITIALISATION
y0 = zeros(2*sys_param.mat_size,1);% solver initial condition %y = [x1,...,xn,q1,...qn]'
%y0 = zeros(1,6)%RES 
%y0(sys_param.mat_size + 3) = Caa*Sd;
 
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
    opts = odeset('InitialStep', 1e-5, 'Refine', 10,'Stats','on'); % use refine to compute additional points
    temp = 0; %Future settings?
    [t_out,y_out] = ode89(@(t,y) odecrystal(t,y,temp),[0,sys_param.t_fin], y0, opts);%dynamically adjusts sampling time
    toc
    fprintf("### DONE.\n")
else
    sys_param.mat_size = size(y_out,2)/2;%%% extracts cell size from imported data
    sys_param.N_cell   = (sys_param.mat_size-1)/8; 
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
x = y_out(:,1:sys_param.mat_size);   % acoustic charge
q = y_out(:,sys_param.mat_size+1:end);% acoustic flow
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
hold on
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
%ylim([-1,1])
%}

%%% TIME DOMAIN p(t,N) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%surface plot
[X,Y] = meshgrid(1:2*sys_param.N_cell,t_out*1000);
Z = abs(p_s); 
Z = smoothdata(Z,"movmean");%%%% SMOOTHING DATA!
%{
    fig2 = figure(2); % \Delta t simulation time step
    %colormap("pink");
    surface(X,Y,Z,'EdgeColor','none')
    set(gcf,'position',fig_param.window_size);
    set(gca,fig_param.fig_prop{:});
    set(gca,'color','none','YDir','normal')
    %set(gcf,'InvertHardcopy','off','Color','none')
    %{
    c = imagesc(t_out*1000,1:2*sys_param.N_cell,abs(p_s)'); %clims = [4 18];
    c = colorbar;
    c.Label.String = "AER pressure (Pa)";
    c.Label.Interpreter = 'latex';
    %}
    %set(h, 'EdgeColor', 'none');
    %{
    for nn = 1:2*sys_param.N_cell
    plot3(nn*ones(numel(t_out)),t_out*1000,Z(:,nn))
    hold on
    end
    hold off
    %}
    %xlim([0.5,2*sys_param.N_cell-0.5])
    ylim([t_out(1),t_out(end)/5]*1000)%
    zlim([0,sys_param.A_src*2])
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
%}

fig2 = figure(2); % \Delta t simulation time step
%waterfall
%{
h = waterfall(X',Y',Z');
set( h, 'LineWidth', 2);
%hidden off; %removes white separator
%}
%ribbon
h = ribbon(Y,Z,0.5);
[h(:).EdgeColor] = deal('none');
set(h, {'CData'}, get(h,'ZData'), 'FaceColor','interp','MeshStyle','column'); % make colour indicate amplitude

%add interface position
p1 = [sys_param.N_cell 0 0];
p2 = [sys_param.N_cell sys_param.t_fin*1000 0];
p3 = [sys_param.N_cell sys_param.t_fin*1000 max(Z(:))/2];
p4 = [sys_param.N_cell 0 max(Z(:))/2];  
xx = [p1(1) p2(1) p3(1) p4(1)];
yy = [p1(2) p2(2) p3(2) p4(2)];
zz = [p1(3) p2(3) p3(3) p4(3)];
hold on;
fill3(xx, yy, zz,'w', 'EdgeColor', 'none', 'FaceAlpha',0.3);
hold off
%%% figure style
set(gcf,'position',fig_param.window_size);
set(gcf, 'InvertHardCopy', 'off'); % to make black figure
set(gcf,'Color',[0 0 0]);% to make black figure
set(gca,fig_param.fig_prop{:});
set(gca,'color','none','YDir','normal','XColor','w','YColor','w','ZColor','w')
%set(gca,'color','none','YDir','normal')
grid("off")
%box("on")
xlim([0.5,2*sys_param.N_cell+0.5])
%xlim([sys_param.N_cell-2.5,sys_param.N_cell+2.5]) % zoom on topological interface
%ylim([t_out(1),t_out(end)/5]*1000)
%zlim([0,sys_param.A_src*1.5])
%zlim([0,10])
xlabel('site n')
ylabel('t (ms)')
zlabel("|p_n| (Pa)")
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';

%clim([0, sys_param.A_src*1.5]);
view(135,60)


%%% FRENQUENCY DOMAIN p(omega,q) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_vec =  (0:sys_param.t_samp:sys_param.t_fin)'; %need to create another time vector because the output of the simulation isn't with constant sampling.
p_vec = interp1(t_out,p_s,t_vec); % Interpolate data 


%% NONLINEARITY TEST 

L = length(t_vec);             % Length of signal
t = t_vec;        % Time vector

FFT = fft(real(p_s(:,:)));
P2 = abs(FFT/L);
P1 = P2(1:L/2+1,:)';
P1(2:end-1) = 2*P1(2:end-1);
f = (0:(L/2))./(sys_param.t_samp*L);

fig5 = figure(5);
set(gcf,'position',fig_param.window_size);
set(gca,fig_param.fig_prop{:});
cmp = flip(copper(sys_param.N_cell*2));
colororder(cmp);
hold on
plot(f,P1(1:1:16,:),"LineWidth",2) 
hold off
box on
grid on
xlim([sys_param.fi ,sys_param.ff])
legend(string("P_{" + [1:1:sys_param.N_cell*2]+"}"), 'Location', 'NorthEast', 'NumColumns', 2)
%title("Single-Sided Amplitude Spectrum of S(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")







%omit first data points
%%% single pulse
%{
t0 = 3/(sys_param.f_src); %3/(2*pi*param.c0/param.a/2);% corresponds to the pulse time
t_seg = t_vec(t_vec>2*t0); %omit first data points to get the natural response without the drive
p_seg = p_vec(t_vec>2*t0,:); 
%}

%%% multipulse pulse%omit first data points to get the natural response without the drive
%{
pulse_period = (5*sys_param.N_cell*sys_param.a/sys_param.c0);
tau = 0.5*(1/sys_param.f_src)/sqrt(2); % width

t_lower = (pulse_period-tau/2) + pulse_period*1:4;
t_upper = (pulse_period+tau/2) + pulse_period*1:4;

for nn = 1:numel(t_lower)
t_seg = t_vec(t_lower(nn)<t_vec<t_upper(nn)); 
p_seg = p_vec(t_lower(nn)<t_vec<t_upper(nn),:); 
end
%}
t_seg = t_vec; 
p_seg = p_vec; 

Y = fft2(p_seg,2^(nextpow2(size(p_seg,1))+2),size(p_seg,2))/length(p_seg); %2D FFT --> normalized to get amplitude in (Pa). Extra points are for zero padding.
%Y = fft2(p_seg)/length(p_seg); 
Y = fftshift(Y); %filters out DC component

NFFT_f = size(Y,1); % signal length
omega = 2*pi*sys_param.f_samp*((-(NFFT_f-1)/2:(NFFT_f-1)/2)/(NFFT_f-1))'; %

NFFT_qa = size(Y,2); % signal length
qa = -2*pi*((-((NFFT_qa-1)/2):(NFFT_qa-1)/2)/(NFFT_qa-1));

%%% BAND FOLDING %%% RMK: sys_param.N_cell must be EVEN
%{
Y_inner = [Y(:,sys_param.N_cell/2+1:3*sys_param.N_cell/2)];
Y_outer = flip([Y(:,3*sys_param.N_cell/2+1:2*sys_param.N_cell) Y(:,1:sys_param.N_cell/2)],2);
Y_fold = (Y_inner+Y_outer);
%}
Y_fold = Y; %Bypass

%%% CUT OFF HIGH FREQUENCIES
fig3 = figure(3);
set(gcf,'position',fig_param.window_size);
set(gcf, 'InvertHardCopy', 'off'); % to make black figure
set(gcf,'Color',[0 0 0]);% to make black figure
set(gca,fig_param.fig_prop{:},'XColor','w','YColor','w');
%set(gca,'FontSize',20)
%set(gcf,'position',[50, 50, 800, 1000]);
hold on
yline([415/1000 644.5/1000],'w-',{'Local','Bragg'},'LineWidth',2,'alpha',0.3);
%imagesc(qa/pi,omega/(2*pi),abs(Y));
%imagesc(abs(Y_fold));
imagesc(qa/(pi),omega/(2*pi)/1000,abs(Y_fold));
%yline([422.380/1000 param.c0/param.a/2/1000],'r--',{'Local','Bragg'},'LineWidth',2);

hold off
%colormap('hot');
colormap(magma);
c = colorbar;
c.Label.String = 'Amplitude (Pa)';
c.Color = 'w';
%clim([0, sys_param.A_src*0.5]);
%clim([0, 1.5]);
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
q_i = y_out(:,sys_param.mat_size+1);
q_o = y_out(:,2*sys_param.mat_size);

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
box on

hold off

fig4 = figure(4);
plot(t_out(2:end)-t_out(1:end-1))
title("step size (s)")

autoArrangeFigures
toc

%% SAVE FIGURES
%

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