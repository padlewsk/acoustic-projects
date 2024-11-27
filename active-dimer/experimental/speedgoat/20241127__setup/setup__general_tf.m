%%% GENERAL TRANSFER FUNCTION MEASUREMENT

%%% ADD TOOLBOX %%%
addpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox');
addpath('__fun');

%% PARAMETERS
p = param_struct();
p.spkrName = "wb_2";
p.A = 0.4;

%%% INPUT CHANNEL SELECTION %%% y(s) = tf(s) x(s)
ch_x = 5;  % e.g. velocity
ch_y = 1;  % e.g. pressure

p.in_select  = [ch_x ch_y 3 4]; % Model has 4 input channels (here only use 1)
p.out_select  = [1]; 

%%% SENSITIVITY %%%
sens_x = 1; % e.g. voltage to velocity
sens_y = 1; % e.g. voltage to pressure


%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sigData = SG__measure(p);

%% EXTRACT DATA
Data = sigData.Variables; %freq;sig1;sig2;sig3;

f = Data(:, 1); % frequency
x = Data(:, 1+1)*sens_x;  % + 1 bc frequency is 1st column 
y = Data(:, 2+1)*sens_y;

%% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[tf_xy,F] = tfestimate(x,y,hamming(p.N/8),[],p.freq,p.fs_acq); % transfer function - x to y

%%% EXAMPLE FOR BACK PRESSURE - DISPLACEMENT
%{
%tf_pb_xi = tf_pb_v./(1i*2*pi*F); %[m/s/Pa] % transfer function - back pressure to displacement

%%% Proportionality factor between displacement and back-pressure (within a certain frequency range)
[fit,delta] = polyfit(F(F>f_min & F<f_max),tf_pb_xi(F>f_min & F<f_max),0);
tf_pb_xi_AVG =  mean(abs(tf_pb_xi(F>f_min & F<f_max))); 
fprintf(['tf_Pb_Xi_AVG = %e  m/s/Pa \n'], tf_pb_xi_AVG);
%}

%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf

%%%
figure(1);

plot(F,abs(tf_xy),'LineWidth',2)
xlim([p.fi p.ff]);
%ylim([1E-5 2.5E-5]);
%ylim([0 1]);
xlabel("Frequency (Hz)")
ylabel("Magnitude ")
title("Estimated Transfer function TF_{xy}")
box on
grid on
legend("data",'Location','northwest')

%autoArrangeFigures
%% SAVE DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%save([strcat('./__data/','tf_pb_xi_',p.spkrName)],'sigData');





