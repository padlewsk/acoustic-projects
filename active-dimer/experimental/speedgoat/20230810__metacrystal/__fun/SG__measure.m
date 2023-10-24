function [signal_measure_raw, signal_control_raw] = SG__measure(p, dlg)
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
    sigInfo = sigInfo(strcmp({sigInfo.SignalLabel}, 'acq')); % keep only one with the acq signal
    
    fprintf('tg stop\n')
    tg.stop(); % make sure the target is stopped
    fprintf('tg load\n')
    tg.load(p.MDL); % loads the application in the RT target
    %NECESSARY TO LOAD EVERY TIME?
    fprintf('\t[DONE]\n');
   
    %% SET PARAMETERS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% UPLOAD PARAMETERS TO SL WORKSPACE
    
    % SOURCE PARAMETERS 
    tg.setparam('', 'use_random', p.use_random); 
    tg.setparam('', 'src_select', p.src_select); %src 0 and src 1
    tg.setparam('','sweep_gain', p.A);%
    tg.setparam('', 'tmax', p.tmax);%
    tg.setparam('', 'freq_ini',  p.freq_ini);%
    tg.setparam('', 'freq_fin',  p.freq_fin);%

    %SET RECORDING TIME 
    tg.setparam('','N_trig', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);% +1 to record a little after the sweep end %sigInfo.SamplePeriod = ts_rec NOT CLEAR
    %tg.setparam('','N_trig', p.N);
    % CONTROL PARAMETERS

    % coupling
    tg.setparam('','k_mat',   diag(p.cpl,-1)    + diag(p.cpl,1));    %linear coupling matrix k 
    tg.setparam('','k_mat_NL',diag(p.cpl_nl,-1) + diag(p.cpl_nl,1)); % nonlinear coupling matrix k_nl

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
    tg.setparam('', 'i2u', 1/p.u2i); %converts current to voltage (will be converted back with u2i)

    % mic sensitivity     %%% F(unitcell,atom) 
    tg.setparam('', 'sens_p', reshape(p.sens_p',[] ,1));%

    % back pressure to displacement transfer function
    tg.setparam('','pb2disp', reshape(p.pb2disp',[] ,1));%


    Simulink.sdi.view; % view the data
    pause(0.05);

    %% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    tg.stopRecording();
    Simulink.sdi.clear();
    tg.startRecording();

    fprintf('Measuring...\n'); 
    % record data from start
    % make a short pulse of the Constant block 'rec'
    tg.setparam('', 'enable_source', true); %turn source on
    tg.setparam('', 'rec', true);
    tg.start('AutoImportFileLog', false); %starts the system and omits the log data file
    tic;
    tg.setparam('', 'rec', false);
    % wait until the signal 'acq' is false, meaning the acquisition is over
    while tg.getsignal(sigInfo.BlockPath, sigInfo.PortIndex)
        pause(0.1);
        if dlg.CancelRequested %%% Check if cancel button is pressed
            dlg.Message = 'Measurement aborted.';
            tg.stop;% stops target
            data = nan(1,4+16);
            return
        end
    end
    toc
    tg.setparam('', 'enable_source', false); %turn source off
    fprintf('\t[DONE]\n');

    tg.stopRecording();

    %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fprintf('Fetching data from target...\n');
    
    %tg.FileLog.import(p.MDL); % import the file log in the SDI
    signal_measure_raw = get_signals(tg, {'data.p1', 'data.p2', 'data.p3', 'data.p4'}); % c.f. function in acoustic-projects\toolbox\matlab-toolbox\speedgoat-controller
    signal_control_raw = get_signals(tg, { ...
        'data.p11', ...
        'data.p12', ...
        'data.p21', ...
        'data.p22', ...
        'data.p31', ...
        'data.p32', ...
        'data.p41', ...
        'data.p42', ...
        'data.p51', ...
        'data.p52', ...
        'data.p61', ...
        'data.p62', ...
        'data.p71', ...
        'data.p72', ...
        'data.p81', ...
        'data.p82' ...
        });
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
    
    %data = signal_measure_raw.Variables; % store data in data array
    TET = struct2table(tg.ModelStatus.TETInfo) % print TET info
    fprintf('\t[DONE]\n');
end
