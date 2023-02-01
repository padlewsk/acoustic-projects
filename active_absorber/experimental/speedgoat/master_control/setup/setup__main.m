%%% MEASUREMENT SETUP: This is a straight forward way to estimate the sensitivities the
%%% speaker mechanical parameters, and the back
%%% pressure-displacement transfer function.
%%% NEED TO SELECT FREQ WINDOW!!!

close all
clc
%% LIST DIALOG BOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%while 1
    case_select = 0;
    str = {'Select Measurement Step:'};
    S = {'Equipment Sensitivity'; 'Mechanical Parameter Estimator'; ,'Backpressure-Displacement Transfer Function'};

    % Function 
    case_select = listdlg('PromptString', str, 'ListSize', [300 50] , 'ListString', S, 'SelectionMode', 'single');

    if case_select == 0
        fprintf('### Please select a case.\n')

    elseif case_select == 1;
        fprintf('### Measuring equipment sensitivity...\n')
        run('setup__sens.m')
         
    elseif case_select == 2;
        fprintf('### Estimating Mechanical Parameters...\n')
        run('setup__ms_estimate.m')
        
    elseif case_select == 3;
        fprintf('### Estimating Backpressure-Displacement Transfer Function...\n')
        run('setup__tf_Pb_Xi.m')

    else
        fprintf('### Something went wrong...\n')
        return;
        %break;
    end
%end

    