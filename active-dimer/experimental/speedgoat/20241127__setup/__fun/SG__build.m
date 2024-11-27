function SG__build()
    %%% COMPILES AND UPLOADS SIMULINK MODEL TO SPEEDGOAT
    %%% Tricks to find the parameter name
    %%% https://www.mathworks.com/help/simulink/slref/block-specific-parameters.html
    %%% get_param([MDL, '/source/sweep'], 'ObjectParameters')
    %%% View block mask
    %%% VIEW TARGET SCREEN 
    %%% BE SURE TO ESTABLISH CONNECTION TO SG BEFORE FLASHING (slrtexplr) (duh...)
    %%%% NEVER CLEAR --> CLEARING MESSES UP THE APP!
    
    %% ADD SG LIB PATH %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    addpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox\speedgoat-controller');
    addpath('__fun');
    %%% UPLOAD PARAMETERS 
    p = param_struct(); % in case some parameters are overwritten

    %% CHECK IF CONNECTED
    tg = slrealtime(p.tg_model); % target computer interface

    if tg.isConnected == 0
        tg.connect ;  
        if tg.isConnected == 0
            error('ERROR. Unable to establish connection.')
        end
    end

    %% UPLOAD MODEL TO WORKSPACE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    load_system(p.MDL); % loads slx model defined in params.m
    
    %% MAKE BUILD FILE TO LOCAL DIRECTORY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Simulink will produce multiple intermediate build files. We do not wish
    % that these files pollute our working directory. Let's put them in
    % ``BUILD_DIR``.
    create_build_dir() ;% creates build file on local PC (runs faster) 
    
    %% SET THE DEFAULT SIMULINK PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('Setting non-tuneable parameters...\n');
    
    %%% for running time
    set_param(p.MDL, 'StopTime',num2str(Inf)) 
    
    %%% Set sample times (changes depending on the SG machine used)
    if p.MDL == 'SG__MDL_IO135_setup'     
        set_param([p.MDL, '/ao'], 'parSampleTime', num2str(p.ts_acq)); 
        set_param([p.MDL, '/ai'], 'parSampleTime', num2str(p.ts_acq));  
        fprintf('Parameters set for IO135.\n');
    else %'SG__MDL_IO104_setup'
        set_param([p.MDL, '/ao'], 'parTs', num2str(p.ts_acq)); 
        set_param([p.MDL, '/ai'], 'parTs', num2str(p.ts_acq));
         fprintf('Parameters set for IO104.\n');
    end
    
    %% BUILD APPLICATION FOR SG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    fprintf('Building the application...\n');
    
    slbuild(p.MDL); %%% build the code of the model (only does this once)
    
    if strcmpi(get_param(p.MDL, 'shown'), 'off')
        % if simulink GUI of the model is not shown, close the model. It is no
        % longer needed in memory. Close it without saving it.
        close_system(p.MDL, 0);
    end
    
    fprintf('\t[DONE]\n');
    %% LOAD TARGET %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %
    % Multiple applications can be uploaded on a single target. Each time the
    % target is stopped, the correct application must first be loaded then
    % started. The ``tg.load`` function will upload the *.mldatx file if not up
    % to date on the target and load it.
    fprintf('Loading the application...\n');
    
    %%% UPLOAD PARAMETERS TO WORKSPACE
    %params % in case some parameters are overwritten
    % MDL and tg are defined there.
    
    tg = slrealtime(p.tg_model); % target computer interface
    tg.stop(); % make sure the target is stopped
    tg.load(p.MDL); % loads the application in the RT target
    
    fprintf('\t[DONE]\n');
    %}

end