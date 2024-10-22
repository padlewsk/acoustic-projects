function [signal_raw] = SG__measure(p, dlg)
    %%% 2023.08.10 Passive unit cell dispersion measurement.
    addpath('__fun');

    %%% UPLOAD PARAMETERS 
    if ~exist('p') ||  isempty(p)
       p = param_struct(); % in case some parameters are overwritten
       fprintf('Using default parameters\n')
    end

    if ~exist('dlg') ||  isempty(dlg) %%% This is implemented to make cancel the measurement at any time using "uiprogressdlg" in the app 
       dlg = struct ;
       dlg.CancelRequested = 0; 
    end
    
    %% START APPLICATION
    % The ``tg.start`` function starts the target. The option
    % ``AutoImportFileLog`` is passed to the ``tg.start`` function to specify
    % if the file log should automatically be imported when the application
    % stops. In this example, we explicitly control when the file logging is
    % active and will manually import it.

    % check if connected  
    tg = slrealtime(p.tg_model); % target computer interface

    if tg.isConnected == 0 
        tg.connect;   
        if tg.isConnected == 0
            error('ERROR. Unable to establish connection.')
        end
    end
    fprintf('Loading the application...');
    app = slrealtime.Application(p.MDL); % reference to the built application
    % Find the signal 'acq' in the application which will later be polled.
    sigInfo = app.getSignals; % list of all the signals in the application
    sigInfo = sigInfo(strcmp({sigInfo.SignalLabel}, 'acq')); % keep only one with the acq signal (test point!)
    
    %fprintf('tg stop\n')
    tg.stop(); % make sure the target is stopped
    %fprintf('tg load\n')
    tg.load(p.MDL); % loads the application in the RT target
    %NECESSARY TO LOAD EVERY TIME?
    pause(0.1)
    fprintf('done.\n');
    
    %% SET PARAMETERS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% UPLOAD PARAMETERS TO SL WORKSPACE
    %{
    mdlWks = get_param(p.MDL, 'ModelWorkspace'); % get the model workspace of 'myModel'
    varList = whos(mdlWks); % list all variables in the model workspace
    varList.name % list all variable names in the model workspace
    %}

    %SET RECORDING TIME 
    app = slrealtime.Application(p.MDL); % reference to the built application
    % Find the signal 'acq' in the application which will later be polled.
    sigInfo = app.getSignals; % list of all the signals in the application
    sigInfo = sigInfo(strcmp({sigInfo.SignalLabel}, 'acq')); % keep only one with the acq signal (TEST POINT!)
   % tg.setparam('','N_trig', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);% +1 to record a little after the sweep end %sigInfo.SamplePeriod = ts_rec NOT CLEAR
    tg.setparam('','N_trig', uint32(p.tmax/sigInfo.SamplePeriod))
    %sets the parameters p on the target:!!
    setparam(p);
    tg.setparam('', 'i2u', 0); % sets control current to 0 at the very start
    %{
    % SOURCE PARAMETERS 
    tg.setparam('', 'freq_sine', p.freq_sine);% 
    tg.setparam('', 'src_select_type', p.src_select_type); % 1 random 0 cte
    tg.setparam('', 'src_select_ab', p.src_select_ab); % 1 = src A, 2 = src B r = src A+B
    tg.setparam('', 'src_gain', p.A);%
    %{
    %sweep not used for now
    tg.setparam('', 'tmax', p.tmax);%
    tg.setparam('', 'freq_ini',  p.freq_ini);%
    tg.setparam('', 'freq_fin',  p.freq_fin);%
    %} 

    %SET RECORDING TIME 
    tg.setparam('','N_trig', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);% +1 to record a little after the sweep end %sigInfo.SamplePeriod = ts_rec NOT CLEAR
    % CONTROL PARAMETERS

    % coupling
    tg.setparam('','k_mat',   diag(p.cpl_L,-1)    + diag(p.cpl_R,1));    %linear coupling matrix k 
    tg.setparam('','k_mat_NL',diag(p.cpl_nl_L,-1) + diag(p.cpl_nl_R,1)); % nonlinear coupling matrix k_nl

    % Bl
    tg.setparam('','Bl',reshape(p.Bl',[] ,1)); %RMK: the reshape is simply to change the 8x2 matrix to a 16x1 

    % impedance synthesis
    [b, a] = tfdata(p.Phi_d);
    b = cell2mat(b);
    %b = reshape(b',[] ,3);??? doesn't work ...
    b = [b(1,1:3); b(1,4:6);
         b(2,1:3); b(2,4:6);
         b(3,1:3); b(3,4:6);
         b(4,1:3); b(4,4:6);
         b(5,1:3); b(5,4:6);
         b(6,1:3); b(6,4:6);
         b(7,1:3); b(7,4:6);
         b(8,1:3); b(8,4:6)]; % [num coefs of 1.1 atom; num coefs of 1.2 atom] % check if this is ok!
    tg.setparam('','dtf_b',b);
    
    a = cell2mat(a);
    %a = reshape(a',[] ,3);??? doesn't work ...
    a = [a(1,1:3); a(1,4:6);
         a(2,1:3); a(2,4:6);
         a(3,1:3); a(3,4:6);
         a(4,1:3); a(4,4:6);
         a(5,1:3); a(5,4:6);
         a(6,1:3); a(6,4:6);
         a(7,1:3); a(7,4:6);
         a(8,1:3); a(8,4:6)];
    tg.setparam('','dtf_a',a);% [den coefs of 1.1 atom; den coefs of 1.2 atom]

    % current to voltage
    tg.setparam('', 'i2u', p.i2u); %converts current to voltage (will be converted back with u2i)

    % mic sensitivity     %%% F(unitcell,atom) 
    tg.setparam('', 'sens_p', reshape(p.sens_p',[] ,1));%

    % back pressure to displacement transfer function
    tg.setparam('','pb2disp', reshape(p.pb2disp',[] ,1));%
    %}

    Simulink.sdi.clear(); % clear previous run
    Simulink.sdi.view; % view the data
    pause(0.1)
    %% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %initialize
    tg.setparam('', 'rec', false);
    tg.setparam('', 'enable_source', false); %turn source off

    fprintf('Measuring...'); 
    tic;
    tg.start('AutoImportFileLog', false); %starts the system and omits the log data file
    pause(0.5) % !!!  waits for the system to relax in the first moments cf 20231128
    tg.setparam('', 'i2u', p.i2u); % re-enables control current
    % record data from start
    % make a short pulse of the Constant block 'rec'
    tg.setparam('', 'enable_source', true); %turn source on and wait for signal stabilisation
    pause(0.5)
    
    tg.setparam('', 'rec', true); %start logging --> serves as tg.startRecording();
    tg.setparam('', 'rec', false);
    

    % wait until the signal 'acq' is false, meaning the acquisition is over
    tmr = tic;
    while tg.getsignal(sigInfo.BlockPath, sigInfo.PortIndex)
        %pause(0.05);
    end
    tg.setparam('', 'enable_source', false); %turn source off
    tg.stopRecording();
    fprintf('done.\n');
    toc (tmr)
    toc
   
    %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fprintf('Fetching data from target...');
    signal_raw = get_signals(tg, {'data.p1','data.p2',});
    %preprocessing
    %signal_data.Variables = movmean(signal_data_raw.Variables,seconds(signal_data_raw.Time),p.ds_acq);
    %toc
    
    %% TARGET STOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % When the target is stopped, it cannot be started using ``tg.start()``.
    % You must first load the application again.
    tg.stop; % stops target
    fprintf('done.\n');
    
    %% Display the signals
    %{ 
    clf
    fprintf('Displaying the signals...\n');
    figure(1);
    for i = 1:size(sigData, 2)
    plot(sigData.Time, sigData(:, i).Variables, ...
        'DisplayName', sigData.Properties.VariableNames{i});
    hold on;
    end
    legend show;
    xlabel('Time [s]');
    pause(0); % force rendering of the figure before next loop
    
    fprintf('\t[DONE]\n');
    %}
    
    %data = signal_measure_raw.Variables; % store data in data array
    TET = struct2table(tg.ModelStatus.TETInfo) % print TET info
end
