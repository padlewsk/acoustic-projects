%%% Back Pressure and Displacement transfer function meausrement 
%%% Generate frequency sweep and measure velocity v,front pressure pf and
%%% back pressure pb.
%%% OPEN CIRCUIT CONFIGURATION !!!!
%%% ai1 = v
%%% ai2 = pb
%clear
%%% add toolbox library
addpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox');
addpath('__fun');

p = param_struct();
p.spkrName = "wb_2";
%overide
%p.sens_pb = 1/(-36.1e-3); %(m/s)/V 

f_min = 200;
f_max = 900;
%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ... IF NO DATA FOUND...
if isfile(strcat('./__data/','oc_',p.spkrName,'.mat'))
    ocData = open(strcat('./__data/','oc_',p.spkrName,'.mat'));
    f = ocData.f;
    v = ocData.v;
    pb = ocData.pb;%back pressure in Pa
else    
    sigData = SG__measure;
    Data = sigData.Variables; %freq;sig1;sig2;sig3;

    f  = Data(:,1);
    v  = Data(:,p.v_channel + 1)*p.sens_v;  %velocity (m/s)
    pb = Data(:,p.pb_channel + 1)*p.sens_pb; %back pressure in Pa
end
%% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% tf_Pb_Xi: Relation between displacement Xi and backpressure Pb
%[tf_Pb_V,F] = tfestimate(v,pb,hamming(N/8),'',N);% If you specify noverlap as empty, then tfestimate uses a number that produces 50% overlap between segments. 
[tf_pb_v,F] = tfestimate(pb,v,hamming(p.N/8),[],p.freq,p.fs_acq); % transfer function - back pressure to velocity

tf_pb_xi = tf_pb_v./(1i*2*pi*F); %[m/s/Pa] % transfer function - back pressure to displacement

[fit,delta] = polyfit(F(F>f_min & F<f_max),tf_pb_xi(F>f_min & F<f_max),0);

%{
fprintf("\nFit coefficients:\n")
fprintf('%g ', fit);
fprintf("\n")
%}

%%% Proportionality factor between displacement and back-pressure (within a
%%% certain frequency range)
tf_pb_xi_AVG =  mean(abs(tf_pb_xi(F>f_min & F<f_max))); 
fprintf(['tf_Pb_Xi_AVG = %e  m/s/Pa \n'], tf_pb_xi_AVG);

%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf
%%%
%{
figure(1)
tile = tiledlayout(2,1);
ax1 = nexttile;
plot(ax1,f,pb)

ax2 = nexttile;
plot(ax2,f,v)


% Link the axes
linkaxes([ax1,ax2],'x');
xlim([p.fi,p.ff])
title(tile,'front pressure, velocity, back pressure vs time')
xlabel(tile,'frequency (Hz)')
ylabel(tile,'Amplitude')

% Move plots closer together
xticklabels(ax1,{})
tile.TileSpacing = 'compact';
%}


%%%
figure(1);

plot(F,abs(tf_pb_xi)*10^6,'LineWidth',2)
hold on
plot(F,abs(polyval(fit,F))*10^6,'LineWidth',2)
hold off
xlim([p.fi p.ff]);
%ylim([1E-5 2.5E-5]);
ylim([0 1]);
xlabel("Frequency (Hz)")
ylabel("Magnitude (\mu m\cdot Pa^{-1})")
title("Displacement to back pressure transfer function: H_{p_b,\xi}")
box on
grid on
legend("data","fit",'Location','northwest')


%autoArrangeFigures
%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save([strcat('./__data/','tf_pb_xi_',p.spkrName)],'sigData');





