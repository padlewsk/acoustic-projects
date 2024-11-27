    %%% 2022.09.06 4 channel measurement.

function sigData = SG__measure(params)
    
    addpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox\speedgoat-controller');
    %%% DEFAULT PARAMETERS
    if nargin < 1
    addpath('__fun');
    params = param_struct; % in case some parameters are overwritten
    end
    
    p = params;
    
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
    
  
    tg.stop(); % make sure the target is stopped
    tg.load(p.MDL); % loads the application in the RT target
    %NECESSARY TO LOAD EVERY TIME?

    pause(0.05);
    
    fprintf('\t[DONE]\n');

 
    
    %% SET PARAMETERS  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % UPLOAD SOURCE PARAMETERS 
    %tg.setparam([p.MDL, '/enable_source'], 'Value', true); %turn source on
    %tg.setparam([p.MDL, '/source/sweep_gain'], 'Gain', p.A);%
    %tg.setparam([p.MDL, '/source/tmax'], 'Value', p.tmax);%
    %tg.setparam([p.MDL, '/source/fi'], 'Value', p.fi);%
    %tg.setparam([p.MDL, '/source/ff'], 'Value', p.ff);%
    %tg.setparam([p.MDL, '/Triggered Pulse'], 'N', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);

    tg.setparam('', 'enable_source', true); %turn source on
    tg.setparam('', 'sweep_gain', p.A);%
    tg.setparam('', 'tmax', p.tmax);%
    tg.setparam('', 'fi', p.fi);%
    tg.setparam('', 'ff', p.ff);%
    %tg.setparam('', 'in_select', p.in_select); % 
    %tg.setparam('', 'out_select', p.out_select); 
    % SET ACQUISITION TIME 
    tg.setparam('', 'N', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1); %  ACQUISITION TIME 
    %tg.setparam([p.MDL, '/Triggered Pulse'], 'N', uint32((2*p.tmax)/sigInfo.SamplePeriod) + 1);

    Simulink.sdi.view
    %pause(0.05);
    %% RUN MEASUREMENT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('Measuring...\n'); 
    % record data from start
    % make a short pulse of the Constant block 'rec'
    %tg.setparam([p.MDL, '/rec'], 'Value', true);
    tg.setparam('', 'rec', true);
    tg.start('AutoImportFileLog', false);
    %tg.setparam([p.MDL, '/rec'], 'Value', false);
    tg.setparam('', 'rec', false);
    % wait until the signal 'acq' is false, meaning the acquisition is over
    while tg.getsignal(sigInfo.BlockPath, sigInfo.PortIndex)
        pause(0.1);
    end
    
    %fprintf('\t[DONE]\n');
    
    %% TARGET STOP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % When the target is stopped, it cannot be started using ``tg.start()``.
    % You must first load the application again.
    %tg.setparam([p.MDL, '/enable_source'], 'Value', false); %turn source on
    tg.stop; % stops target
    fprintf('\t[DONE]\n');
    pause(0.1);
    
    %% OUTPUT DATA & PROCESSING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    fprintf('Fetching data from target...\n');
    
    tg.FileLog.import(p.MDL); % import the file log in the SDI
    sigData = get_signals(tg, {'data.freq', 'data.sig1', 'data.sig2', 'data.sig3', 'data.sig4'}); % c.f. function
    
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
    
    %Data = sigData.Variables; % store data in data array
    
    
    %run('suuu.m');
    
   