modelName = 'SG__DMA_test';
open_system(modelName);
%at.openProductExample('IO135_DMALoopback')

% Create and connect to the Speedgoat real-time target machine
tg = slrealtime;            
tg.connect;

% Download and install the real-time application on the target machine
tg.load(modelName); 

% Connect the Simulink model with external mode to the real-time application on the target machine
%set_param(modelName,'SimulationMode',   'external')   % put model into External Mode
%set_param(modelName,'SimulationCommand','connect')    % connect with External Mode  
Simulink.sdi.view;
% Start the real-time application
tg.start;

% Wait a few seconds and then stop the real-time application on the target machine
%pause(10)
tg.stop;