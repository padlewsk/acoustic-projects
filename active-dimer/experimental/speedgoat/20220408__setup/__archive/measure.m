%% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n### Measurement started...\n\n');

%%% UPLOAD SOURCE PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('../params.m');
tg.StopTime = Inf; 
tg.setparam('enable_source', 'Value', true); %turn source on
tg.setparam('source/use_random', 'Value', false); %use sweep

%%% UPLOAD PARAMETERS TO SWEEP
tg.setparam('source/sweep_gain', 'Gain', A)
tg.setparam('source/sweep', 'f0', fi)
tg.setparam('source/sweep', 'f1', ff)
tg.setparam('source/sweep', 't1', tmax)
tg.setparam('source/sweep', 'Tsweep', tmax)

%%% SCOPE RECORD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sc_list = tg.getscope; % all the scopes
sc = sc_list([sc_list.ScopeId] == 2); % scope 2 record
sc.NumSamples = tmax/ts;
sc.start;
tg.start; % starts target

%%% WAIT FOR INPUT SIGNAL AND MEASURE FOR tmax
while strcmpi(sc.Status, 'Ready for being Triggered') || strcmpi(sc.Status, 'Acquiring')
    pause(0.01);   
end

tg.Status;
tg.stop; % stops target
fprintf('### Measurement Complete.\n')

%%% Estimates mechanical parameters from the measured specific acoustic
%%% impedances for the Open Circuit and Close Circuit case

%% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = ((0:size(sc.Data, 1)-1)*ts)';
Data = sc.Data;

N = length(t);

pf = sc.Data(:,1)/sens_pf; %front pressure (Pa)
v  = sc.Data(:,2)/sens_v;  %velocity (m/s)
pb = sc.Data(:,3)/sens_pb; %% back pressure (Pa)
source_0 = sc.Data(:,4); 

%%% Frequency vector
f = fi+(ff-fi)*t/tmax; %frequency vector

%%% tf_Pb_Xi: Relation between displacement Xi and backpressure Pb
%[tf_Pb_V,F] = tfestimate(v,pb,hamming(N/8),'',N);% If you specify noverlap as empty, then tfestimate uses a number that produces 50% overlap between segments. 
[tf_Pb_V,F] = tfestimate(v,pb,hamming(N/8),'',f,fs);
tf_Pb_Xi = 1i*2*pi*F.*tf_Pb_V;

%%% Zs: Acoustic Impedance.
[Zs,F] = tfestimate(v,pf,hamming(N/8),'',f,fs); %returns the transfer function estimate at the frequencies specified in f.

%%% Proportionality factor between displacement and back-pressure (within a
%%% certain frequency range)
tf_Pb_Xi_AVG =  mean(abs(tf_Pb_Xi(F>200 & F<1200))); 
fprintf('tf_Pb_Xi = %f Pa/m \n', tf_Pb_Xi_AVG);


%%% Absorption coefficient
alpha = 1 - abs((Zs-Zc)./(Zs+Zc)).^2;
