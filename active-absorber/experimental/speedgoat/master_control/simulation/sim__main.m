%%% CLOSED BOX LOUD SPEAKER MEASURE FRONT PRESSURE
%%% TIME REPRESENTATION APPROACH

addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox');
fprintf('### Running Simulation...\n')
%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('../params.m') %imports parameters
%% SOURCE GENERATOR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = (0:ts:tmax)'; %time vector
f = fi+(ff-fi)*t/tmax; %frequency vector
source = sin(2*pi*f.*t);% source is directly in pressure +randn(size(t))/10; %noisy chirp c

%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tau_max = 50E-6; % Maximum time delay for contorl loop (s)
ii = 1;

tau_list = linspace(0,tau_max,5); %[0:ts:(tau_max-ts),tau_max]; %tau list
%tau_list = tau_max; %tau list bypass

for tau = tau_list 
    sim('ClosedBoxLS_MDL_v2020a',tmax); %simulink
    
    %%% Acoustic impedance
    
    %%% tfestimate method (Determines the transfer function between v and pf):
    %[Zs{ii},F] = tfestimate(v_out.data,pf_out.data,[],[],N);
    %F=F/pi/2*fs;

    
    %%% FFT method (Does the same as tfestimate):
    %
    pf_sim = pf_sim_out.data; %wind.*pf_out.data; %hamming(L).*pf_out.data;
    v_sim = v_sim_out.data;% wind.*v_out.data;

    NFFT = 2^(nextpow2(length(pf_sim))+3); % n-point dft + padding

    Pf_sim = fft(pf_sim,NFFT); %2sided spectrum
    V_sim = fft(v_sim,NFFT);

    Pf_sim = Pf_sim(1:NFFT/2);%1sided spectrum (up to Nyquist bin)
    V_sim = V_sim(1:NFFT/2);

    Zs_sim{ii}  = Pf_sim./V_sim; %Specific Acoustic Impedance
    F_sim = (1/ts*((1:NFFT/2))/NFFT)'; %FFT frequency vector
%}

    %%% Absorption coefficient
    alpha_sim{ii} = 1 - abs((Zs_sim{ii}-Zc)./(Zs_sim{ii}+Zc)).^2;
    
    
    %%% Bandwitsh of efficient absorption
    %{
    idx_temp = alpha{ii}>0.83 & F<ff & F>fi;
    alpha_temp =  alpha{ii}(idx_temp);
    F_temp = F(idx_temp);
    
    TF{ii} = islocalmin(alpha_temp,'MinSeparation',fs*10,'SamplePoints', F_temp);
    %BW{ii} = F_temp(TF) - min(BW_temp);
    %}
    
    
    ii = ii + 1;
end
%t = tout; %Sometimes t is different??? WHY???

fprintf('### Simulation Complet\n')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FIGURES


%% pf&v VS t&f --------------------------------------------------------
%
figure(3)
tt = tiledlayout(1,1);
ax1 = axes(tt);
plot(ax1,t(f<100),v_sim(f<100)*1000,'-k','LineWidth',1)
xlabel("Time (s)")
ylabel("Velocity (mm/s)")
ax1.XColor = 'k';
ax1.YColor = 'k';


ax2 = axes(tt);
plot(ax2,f(f<100),pf_sim(f<100),'-r','LineWidth',1)
xlabel("Corresponding frequency (Hz)")
ylabel("Front pressure (Pa)")
ylim([-A*4 A*4])

ax2.XAxisLocation = 'top';
ax2.YAxisLocation = 'right';
ax2.Color = 'none';
ax2.XColor = 'r';
ax2.YColor = 'r';

ax1.Box = 'off';
ax2.Box = 'off';


%{
yyaxis right
plot(t,pf_out.data);
ylim([-20 20])
ylabel("Front pressure (Pa)")

yyaxis left
plot(t,v_out.data);
ylabel("Velocity (m.s^{-1})")
xlim([0 ff]);
xlabel("Frequency (Hz)")
legend("v","P_f")
%}


%}




%% alpha vs freq
figure(4);
cmap = copper(numel(alpha_sim)); % Cell array of colors.

for ii = 1:numel(alpha_sim)
    semilogx(F_sim,alpha_sim{ii},'color',cmap(ii,:),'LineWidth',3)
    %plot(F(TF{ii}),alpha{ii}(TF{ii}),'r*')
    hold on %% must hold on AFTER initial axis is created
end
hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([fi ff]);
ylim([0 1.1]);

xlabel("Frequency (Hz)")
ylabel("Absorbtion coefficient")
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
legend("\tau = " + string(tau_list*1000) + " ms",'Location','northwest')








%%% Bode plot 
figure(5);
cmap = copper(numel(alpha_sim)); % Cell array of colors.

tt = tiledlayout(2,1); %Create tile layout

%%% Magnetude of Specific Acoustic Impedance
ax1 = nexttile; 
for ii = 1:numel(alpha_sim) 
    semilogx(ax1,F_sim,abs(Zs_sim{ii}),'color',cmap(ii,:),'LineWidth',3)
    xline(f0,'-.k');
    xline(fst,'-.k');
    ylabel("Magnetiude (Pa.s/m)")
    ylim([0 1200]);
    box on
    grid on
    set(ax1,'xticklabel',[])
    hold on %% must hold on AFTER initial axis is created
end
hold off
%legend("\tau = " + string(tau_list*1000) + " ms",'Location','northwest')
title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)

%%% Phase
ax2 = nexttile;
for ii = 1:numel(alpha_sim) 
    semilogx(ax2,F_sim,angle(Zs_sim{ii}),'color',cmap(ii,:),'LineWidth',3)
    linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
    xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
    xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});
    ylabel("Phase (rad)")
    %xlabel("Frequency (Hz)")
    box on
    grid on
    ylim([-pi pi])
    set(ax2,'YTick',-pi:pi/2:pi)
    set(ax2,'YTickLabel',{'-\pi','-\pi/2','0','\pi/2','\pi'})
    hold on %% must hold on AFTER initial axis is created
end
hold off

% Link the axes
linkaxes([ax1,ax2],'x');
xlim([fi ff]);

% Move plots closer together
xticklabels(ax1,{})
tt.TileSpacing = 'compact';



 %% Sweep spectral analisis
 %{
figure(2);
%pspectrum(Pf,t,'spectrogram','TimeResolution',0.1,'OverlapPercent',99,'Leakage',0)
pspectrum(Pf,t,'spectrogram','FrequencyLimits',[f_i f_f],'TimeResolution',0.1,'OverlapPercent',99,'Leakage',0.9)
 %axis([0 t_f 0 f_f])
%}

