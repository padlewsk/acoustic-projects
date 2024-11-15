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

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isfile(strcat('./__data/','oc_',p.spkrName,'.mat'))
    ocData = open(strcat('./__data/','oc_',p.spkrName,'.mat'));
    f = ocData.f;
    v = ocData.v;
    pb_V = ocData.pb/p.sens_pb;%back pressure in volts
else    
    sigData = SG__measure;
    Data = sigData.Variables; %freq;sig1;sig2;sig3;

    
    f  = Data(:,1);
    v  = Data(:,p.v_channel + 1)*p.sens_v;  %velocity (m/s)
    pb_V = Data(:,p.pb_channel + 1); %front pressure signal (V)
end
%% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% tf_Pb_Xi: Relation between displacement Xi and backpressure Pb
%[tf_Pb_V,F] = tfestimate(v,pb,hamming(N/8),'',N);% If you specify noverlap as empty, then tfestimate uses a number that produces 50% overlap between segments. 
[tf_pb_v,F] = tfestimate(pb_V,v,hamming(p.N/8),[],p.freq,p.fs_acq);

tf_pb_xi = tf_pb_v./(1i*2*pi*F);

[fit,delta] = polyfit(F(F>200 & F<900),tf_pb_xi(F>200 & F<900),0);

%{
fprintf("\nFit coefficients:\n")
fprintf('%g ', fit);
fprintf("\n")
%}



%%% Proportionality factor between displacement and back-pressure (within a
%%% certain frequency range)
tf_pb_xi_AVG =  mean(abs(tf_pb_xi(F>200 & F<900))); 
fprintf(['tf_Pb_Xi_AVG = %e  m/V \n'], tf_pb_xi_AVG);



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

plot(F,abs(tf_pb_xi),'LineWidth',2)
hold on
plot(F,abs(polyval(fit,F)),'LineWidth',2)
hold off
xlim([p.fi p.ff]);
ylim([1E-5 2.5E-5]);
ylim([0 5E-5]);
xlabel("Frequency (Hz)")
ylabel("Magnitude (m\cdot{}V^{-1})")
title("Displacement to back pressure transfer function: H_{p_b,\xi}")
box on
grid on
legend("data","fit",'Location','northwest')


%autoArrangeFigures
%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save([strcat('./__data/','tf_pb_xi_',p.spkrName)],'sigData');





