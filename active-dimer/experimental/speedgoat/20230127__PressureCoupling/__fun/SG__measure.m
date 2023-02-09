function Data = SG__measure(p, dlg)
    %%% 2022.09.06 Passive unit cell dispersion measurement.
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
    % UPLOAD SOURCE PARAMETERS 


    tg.setparam([p.MDL, '/src_select'], 'Value', p.src_select); %src 0 and src 1
    tg.setparam([p.MDL, '/enable_source'], 'Value', true); %turn source on
    tg.setparam([p.MDL, '/source/sweep_gain'], 'Gain', p.A);%
    tg.setparam([p.MDL, '/source/tmax'], 'Value', p.tmax);%
    tg.setparam([p.MDL, '/source/fi'], 'Value', p.fi);%
    tg.setparam([p.MDL, '/source/ff'], 'Value', p.ff);%

    
    % SET ACQUISITION TIME 
    tg.setparam([p.MDL, '/Triggered Pulse'], 'N', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);% +1 to record a little after the sweep end %sigInfo.SamplePeriod = ts_rec NOT CLEAR
    % UPLOAD CONTROL PARAMETERS 
    % (defaut is 0 control)
    
    %turn control on
    tg.setparam([p.MDL, '/enable_control'], 'Value', true);
   
    % gain factor for control
    % linear coupling coupling   
    tg.setparam([p.MDL, '/control/kappa_m'], 'Gain', p.kappa/p.Bl_m);%
    tg.setparam([p.MDL, '/control/kappa_p'], 'Gain', p.kappa/p.Bl_p);%
    % non-linear coupling coupling   
    tg.setparam([p.MDL, '/control/kappa_nl_m'], 'Gain', p.kappa_nl/p.Bl_m);%
    tg.setparam([p.MDL, '/control/kappa_nl_p'], 'Gain', p.kappa_nl/p.Bl_p);%
    
    % onsite non-linear (backpressure)
    tg.setparam([p.MDL, '/control/rho_m'], 'Gain', p.rho/p.Bl_m);%
    tg.setparam([p.MDL, '/control/rho_p'], 'Gain', p.rho/p.Bl_p);%
    
    % mic sensitivity
    tg.setparam([p.MDL, '/control/sens_p_m'], 'Gain', p.sens_p_m);%
    tg.setparam([p.MDL, '/control/sens_p_p'], 'Gain', p.sens_p_p);%
    
    % back pressure to displacement transfer function
    tg.setparam([p.MDL, '/control/pb2disp_m'], 'Gain', p.pb2disp_m );%
    tg.setparam([p.MDL, '/control/pb2disp_p'], 'Gain', p.pb2disp_p);%

    % Onsite nonlinearity
    %{
    tg.setparam([p.MDL, '/control/NL_m'], 'Gain', 0);%
    tg.setparam([p.MDL, '/control/NL_p'], 'Gain', 0);%
    %}

    % impedance synthesis
    n = p.Phi_d_m.num{1};
    d = p.Phi_d_m.den{1};
    n = [n, zeros(1, 3-numel(n))]; 
    d = [d, zeros(1, 3-numel(d))];
    tg.setparam([p.MDL, '/control/tf_m'], 'Numerator', n); %Block tf
    tg.setparam([p.MDL, '/control/tf_m'], 'Denominator', d); %Block tf
    
    n = p.Phi_d_p.num{1};
    d = p.Phi_d_p.den{1};
    n = [n, zeros(1, 3-numel(n))];
    d = [d, zeros(1, 3-numel(d))];
    tg.setparam([p.MDL, '/control/tf_p'], 'Numerator', n); %Block tf
    tg.setparam([p.MDL, '/control/tf_p'], 'Denominator', d); %Block tf
    
    % current to voltage
    tg.setparam([p.MDL, '/control/i2u_m'], 'Gain', 1/p.u2i);%converts current to voltage (will be converted back with u2i)
    tg.setparam([p.MDL, '/control/i2u_p'], 'Gain', 1/p.u2i);%converts current to voltage (will be converted back with u2i)
    
    Simulink.sdi.view
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
    tg.start('AutoImportFileLog', false);
    tg.setparam([p.MDL, '/rec'], 'Value', false);
    % wait until the signal 'acq' is false, meaning the acquisition is over
    while tg.getsignal(sigInfo.BlockPath, sigInfo.PortIndex)
        pause(0.1);
        if dlg.CancelRequested %%% Check if cancel button is pressed
            dlg.Message = 'Measurement aborted.'
            tg.stop;% stops target
            Data = [NaN NaN NaN NaN];
            return
        end
    end
    
    %fprintf('\t[DONE]\n');
    

    tg.setparam([p.MDL, '/enable_source'], 'Value', false); %turn source off
    fprintf('\t[DONE]\n');


    tg.stopRecording();

    %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fprintf('Fetching data from target...\n');
    
    %tg.FileLog.import(p.MDL); % import the file log in the SDI
    signal_data_raw = get_signals(tg, {'data.p1', 'data.p2', 'data.p3', 'data.p4'}); % c.f. function

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
    
    
    %run('suuu.m');
    
    %t = ((0:size(Data, 1)-1)*ts)';
    %N = length(t);
    
    %%% Frequency vector
    %f = fi+(ff-fi)*t/tmax; %frequency vector tmax is the time when the frequency reaches ff
