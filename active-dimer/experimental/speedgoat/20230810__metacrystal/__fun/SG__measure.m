function Data = SG__measure(p, dlg)
    %%% 2023.08.10 Passive unit cell dispersion measurement.
    addpath('__fun');

    %%% UPLOAD PARAMETERS 
    if ~exist('p') ||  isempty(p)
       p = param_struct(); % in case some parameters are overwritten
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
    fprintf('Loading the application...\n');
    app = slrealtime.Application(p.MDL); % reference to the built application
    % Find the signal 'acq' in the application which will later be polled.
    sigInfo = app.getSignals; % list of all the signals in the application
    sigInfo = sigInfo(strcmp({sigInfo.SignalLabel}, 'acq')); % keep only one
    
    fprintf('tg stop\n')
    tg.stop(); % make sure the target is stopped
    fprintf('tg load\n')
    tg.load(p.MDL); % loads the application in the RT target
    %NECESSARY TO LOAD EVERY TIME?
    fprintf('\t[DONE]\n');
    
    %% SET PARAMETERS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SOURCE PARAMETERS 
    tg.setparam([p.MDL, '/src_select'], 'Value', p.src_select); %src 0 and src 1
    tg.setparam([p.MDL, '/enable_source'], 'Value', true); %turn source on
    tg.setparam([p.MDL, '/source/sweep_gain'], 'Gain', p.A);%
    tg.setparam([p.MDL, '/source/tmax'], 'Value', p.tmax);%
    tg.setparam([p.MDL, '/source/fi'], 'Value', p.fi);%
    tg.setparam([p.MDL, '/source/ff'], 'Value', p.ff);%
    tg.setparam([p.MDL, '/Triggered Pulse'], 'N', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);% CONTROL PARAMETERS% +1 to record a little after the sweep end %sigInfo.SamplePeriod = ts_rec NOT CLEAR

    % CONTROL PARAMETERS
    for ii = 1:8
        for jj = 1:2
        tg.setparam([p.MDL, char("/enable_uc_"+ii)], 'Value', true); %turn control on
        % coupling
        if ii <= 4 %specify coupling for first 4 cells 
            kappa = p.kappa_A;
            kappa_nl = p.kappa_nl_A;
            kerr_nl = p.kerr_nl_A;
        else %specify coupling for last 4 cells 
            kappa = p.kappa_B;
            kappa_nl = p.kappa_nl_B;
            kerr_nl = p.kerr_nl_B;
        end
        % linear coupling coupling   
        tg.setparam([p.MDL, char("/uc_"+ii+"/kappa_"+jj)], 'Gain', kappa/p.Bl(ii,jj));%
    
        % non-linear coupling coupling   
        tg.setparam([p.MDL, char("/uc_"+ii+"/kappa_nl_"+jj)], 'Gain', kappa_nl/p.Bl(ii,jj));%
        
        % onsite kerr like non-linear (backpressure)
        tg.setparam([p.MDL, char("/uc_"+ii+"/kerr_nl_"+jj)], 'Gain', kerr_nl/p.Bl(ii,jj));%
        
        % mic sensitivity
        tg.setparam([p.MDL, char("/uc_"+ii+"/sens_p_"+jj)], 'Gain', p.sens_p(ii,jj));%
        
        % back pressure to displacement transfer function
        tg.setparam([p.MDL, char("/uc_"+ii+"/pb2disp_"+jj)], 'Gain', p.pb2disp(ii,jj));%
    
        % Onsite nonlinearity
        %{
        tg.setparam([p.MDL, '/control/NL_m'], 'Gain', 0);%
        tg.setparam([p.MDL, '/control/NL_p'], 'Gain', 0);%
        %}
    
        % impedance synthesis
        n = p.Phi_d(ii,jj).num{1};
        d = p.Phi_d(ii,jj).den{1};
        n = [n, zeros(1, 3-numel(n))]; 
        d = [d, zeros(1, 3-numel(d))];
        tg.setparam([p.MDL, char("/uc_"+ii+"/tf_"+jj)], 'Numerator', n); %Block tf
        tg.setparam([p.MDL, char("/uc_"+ii+"/tf_"+jj)], 'Denominator', d); 
        
        %{
        n = p.Phi_d_p.num{1};
        d = p.Phi_d_p.den{1};
        n = [n, zeros(1, 3-numel(n))];
        d = [d, zeros(1, 3-numel(d))];
        tg.setparam([p.MDL, '/control/tf_2'], 'Numerator', n); %Block tf
        tg.setparam([p.MDL, '/control/tf_2'], 'Denominator', d); %Block tf
        %}

        % current to voltage
        tg.setparam([p.MDL, char("/uc_"+ii+"/i2u_"+jj)], 'Gain', 1/p.u2i);%converts current to voltage (will be converted back with u2i)
        end
    end

    Simulink.sdi.view; % view the data
    pause(0.05);

    %% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %     if tg.FileLog.LoggingService ~= 'STOPPED' %#ok<BDSCA>
%         tg.stopRecording();
%     end
    
    tg.stopRecording();
        
    Simulink.sdi.clear();
    tg.startRecording();

    fprintf('Measuring...\n'); 
    % record data from start
    % make a short pulse of the Constant block 'rec'
    tg.setparam([p.MDL, '/rec'], 'Value', true);
    tg.start('AutoImportFileLog', false); %starts the system and omits the log data file
    tg.setparam([p.MDL, '/rec'], 'Value', false);
    % wait until the signal 'acq' is false, meaning the acquisition is over
    while tg.getsignal(sigInfo.BlockPath, sigInfo.PortIndex)
        pause(0.1);
        if dlg.CancelRequested %%% Check if cancel button is pressed
            dlg.Message = 'Measurement aborted.'
            tg.stop;% stops target
            Data = nan(1,4);
            return
        %{ 
        % DOESN'T WORK         
        elseif tg.status == 'targetError'
            dlg.Message = 'CPU OVERLOAD. RESTARTING...'
            tg.update;% reboots target
            return
        %}
        end
    end

    tg.setparam([p.MDL, '/enable_source'], 'Value', false); %turn source off
    fprintf('\t[DONE]\n');


    tg.stopRecording();

    %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fprintf('Fetching data from target...\n');
    
    %tg.FileLog.import(p.MDL); % import the file log in the SDI
    signal_data_raw = get_signals(tg, {'data.p1', 'data.p2', 'data.p3', 'data.p4'}); % c.f. function in acoustic-projects\toolbox\matlab-toolbox\speedgoat-controller

    %preprocessing
    %signal_data.Variables = movmean(signal_data_raw.Variables,seconds(signal_data_raw.Time),p.ds_acq);
    %toc
    
    %% TARGET STOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % When the target is stopped, it cannot be started using ``tg.start()``.
    % You must first load the application again.
    tg.stop; % stops target
    fprintf('\t[DONE]\n');
    
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
    
    Data = signal_data_raw.Variables; % store data in data array
    fprintf('\t[DONE]\n');

    
    
    %run('suuu.m');
    
    %t = ((0:size(Data, 1)-1)*ts)';
    %N = length(t);
    
    %%% Frequency vector
    %f = fi+(ff-fi)*t/tmax; %frequency vector tmax is the time when the frequency reaches ff