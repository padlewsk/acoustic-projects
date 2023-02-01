%%% Back Pressure and Displacement transfer function meausrement 
%%% Generate frequency sweep and measure velocity v,front pressure pf and
%%% back pressure pb.
%%% OPEN CIRCUIT CONFIGURATION
%%% ai1 = v
%%% ai2 = pb

%%% add toolbox library
addpath('\\files7\data\padlewsk\My Documents\MATLAB\MyToolBox');
addpath('__fun');

p = param_struct();

%% INPUTS: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pb_channel = 1;
v_channel = 3;

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigData = SG__measure;

%% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data = sigData.Variables; %freq;sig1;sig2;sig3;


f = Data(:,1);
v  = Data(:,v_channel + 1)*p.sens_v;  %velocity (m/s)
pb = Data(:,pb_channel + 1); %front pressure signal (V)



%%% tf_Pb_Xi: Relation between displacement Xi and backpressure Pb
%[tf_Pb_V,F] = tfestimate(v,pb,hamming(N/8),'',N);% If you specify noverlap as empty, then tfestimate uses a number that produces 50% overlap between segments. 
[tf_pb_v,F] = tfestimate(pb,v,hamming(p.N/8),[],p.freq,p.fs_acq);

tf_pb_xi = tf_pb_v./(1i*2*pi*F);



[fit,delta] = polyfit(F(F>200 & F<900),tf_pb_xi(F>200 & F<900),0);

fprintf("\nFit coefficients:\n")
fprintf('%g ', fit);
fprintf("\n")




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
xlabel("Frequency (Hz)")
ylabel("Magnitude (m\cdot{}V^{-1})")
title("Displacement to back pressure transfer function: H_{p_b,\xi}")
box on
grid on
legend("data","fit",'Location','northwest')


autoArrangeFigures
%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
save('spkr2.mat','sigData');
%test = load('spkr1.mat','sigData')
%{
figure(3)
pwelch(v)
hold on
pwelch(pb)
%}
 



