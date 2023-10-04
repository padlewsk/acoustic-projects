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
    %addpath(genpath('\\files7\data\padlewsk\My Documents\MATLAB\control-schemes\MATLAB\Speedgoat'));
    addpath(genpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox\speedgoat-controller'));
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
    
    %%% Set sample times 
    if p.tg_model == "Mobile"
        %104
        set_param([p.MDL, '/ao_104'], 'parTs', num2str(p.ts_log)); 
        set_param([p.MDL, '/ai_104'], 'parTs', num2str(p.ts_log));  
        %135 IN DMA mode, this is not to be defined
        %{
        set_param([p.MDL, '/ao_135'], 'parSampleTime', num2str(p.ts_ctrl)); 
        set_param([p.MDL, '/ai_135'], 'parSampleTime', num2str(p.ts_ctrl));
        %}
    elseif  p.tg_model == "Performance"
        %334
        set_param([p.MDL, '/IO334_IO'], 'ts', num2str(p.ts_log));
    end
   
    
    %%% FOR CHIRP remove?
    %{
    set_param([MDL, '/source/sweep'], 'Ts', num2str(ts));
    set_param([MDL, '/source/random'], 'SampleTime', num2str(ts));
    %}
    
    
    %%% UPLOAD PARAMETERS TO SL WORKSPACE
     % current to voltage
    set_param([p.MDL, '/atm/i2u'], 'Gain', num2str(1/p.u2i)); %converts current to voltage (will be converted back with u2i)
   
    
    % mic sensitivity
    set_param([p.MDL, '/sens_p'],'Value', mat2str([p.sens_p(:,1);p.sens_p(:,2)]));%
    
        
    % back pressure to displacement transfer function
    set_param([p.MDL, '/pb2disp'], 'Value', mat2str([p.pb2disp(:,1);p.pb2disp(:,2)]));%
    
    
    
    %%% INITIALIZE EACH TF (RMK: DO NOT INITIALIZE WITH ZEROS!)
    %%% unitcell i and atom j:
    %{
    for ii = 1:8
            for jj = 1:2
            set_param([p.MDL, char("/uc_"+ii+"/tf_"+jj)], 'Numerator',  ['[', num2str([0.5 0.5 0.5]), ']']);
            set_param([p.MDL, char("/uc_"+ii+"/tf_"+jj)], 'Denominator',['[', num2str([1 1 1]), ']']);
            end
    end
%}
    
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
    %{
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