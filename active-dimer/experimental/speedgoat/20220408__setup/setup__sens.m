%%% Microphone sensitivties; Microphone (V) --> (Pa) 
%%% Use the 114.0 dB 1000 Hz Sound Calibrator type 1251 and run the code
%%% Plug microphone in input 1 
%%% Takes AVG amplitude over 5s
%%% UPDATE params.m with the correct values.

%%% add toolbox library
addpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox');
addpath('__fun');


%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p = param_struct(); 
p.tmax = 2;  %integration time is 4 seconds
p.A = 0;
p_channel = 1;

%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n### Measurement started...\n\n');
sigData = SG__measure(p);
Data = sigData.Variables;

 %% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
%t_scope = sc.Time;
t = seconds(sigData.Time);%time in secondsè
p = Data(:,p_channel+1); %ai1


%%% Proportionality factor between displacement and back-pressure (within a
%%% certain frequency range)
%sens_est =  rms(p)/(20e-6*10^(114/20)); % (V/Pa) AND NOT A/p(dB)
sens_est =  -sqrt(var(p))/(20e-6*10^(114/20)); 

fprintf('\nSensitivity = %f mV/Pa \n', sens_est*10^3);


    
 %{
    %%% UPLOAD SOURCE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % turn source on
    % select white noise
    tg.StopTime = Inf; 
   
    %%% START TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tg.start();
    pause(0.5);
    %sc.stop;
    
    %%% SCOPE RECORD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    sc_list = tg.getscope; % all the scopes
    sc = sc_list([sc_list.ScopeId] == 2); % scope 2 record
    sc.stop;
    sc.NumSamples = tmax/ts;
    sc.start();
    
    %%% RMK: THE SOURCE MUST BE TURNED ON OR ELSE THE SCOPE WILL NOT BE
    %%% TRIGGERED:
    tg.setparam('enable_source', 'Value', true); %turn source on
    tg.setparam('source/sweep_gain', 'Gain', A/4)
    tg.setparam('source/use_random', 'Value', true); %use white noise 
    

 
    %tg.start; % starts target
    %%% WAIT FOR INPUT SIGNAL AND MEASURE FOR tmax s
    while strcmpi(sc.Status, 'Ready for being Triggered') || strcmpi(sc.Status, 'Acquiring')
        pause(0.01);   
    end

    %tg.Status;

    %return;
    sc.stop;
    tg.stop; % stops target
    

    fprintf('### Measurement Complete.\n')
    %% OUTPUT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    close all
    %t_scope = sc.Time;
    t = (0:size(sc.Data, 1)-1)*ts;
    p = sc.Data(:,input_select); %front pressure (V) 

    %%% Proportionality factor between displacement and back-pressure (within a
    %%% certain frequency range)
    %sens_est =  rms(p)/(20e-6*10^(114/20)); % (V/Pa) AND NOT A/p(dB)
    sens_est =  sqrt(var(p))/(20e-6*10^(114/20)); 

    fprintf('Sensitivity = %f mV/Pa \n', sens_est*10^3);
 %}
    %% PLOT DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf
figure(1);
hold on
plot(t,p,'LineWidth',1)
hold off

%xlim([1 ff]);
%ylim([0 1.1]);

xlabel("Time(s)")
ylabel("Pressure (V)")
box on
grid on
legend("Microphone",'Location','northwest')
    %return;
%end
%}
