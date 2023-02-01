%%% Estimates mechanical parameters from the measured specific acoustic
%%% impedances for the Open Circuit and Close Circuit case
%%% INPUT PARAMETERS
%%% AI0 = pf
%%% AI1 = v 

clc

%% PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
run('../params.m');

%% DIALOG BOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while 1
    case_select = 0; %default
    str = {'Mechanical Parameter Estimator.'; 'Select Measurement Step:'};
    S = {'Open Circuit'; 'Closed Circuit'; 'Estimate parameters'};
    case_select = listdlg('PromptString', str, 'ListSize', [300 50] , 'ListString', S, 'SelectionMode', 'single');
   

    if case_select == 1 %Open Circuit Measurement
        %%
        close all
        %%% CC FILE EXISTS... PROCEED?
        fprintf('### Measuring for Open Circuit case...\n')
        run('setup__ms_estimate_measure.m');
        
        fprintf('### Saving data to file...\n')
        save('OC.mat','F','Zs','alpha');
        OCData = open('OC.mat');
        
        figure(1)
        hold on
        plot(OCData.F,abs(OCData.Zs));
        xlabel("Frequency (Hz)")
        ylabel("Mechanical Impedance (N.s/m)")
        box on
        legend('Open Circuit','Closed Circuit')
        fprintf('### Saving data to file...\n')
        
    elseif case_select == 2 %Closed Circuit
        %%
        fprintf('### Measuring for Closed Circuit case...\n')
        run('setup__ms_estimate_measure.m');
        
        save('CC.mat','F','Zs','alpha');
        CCData = open('CC.mat');
        
        figure(1)
        plot(CCData.F,abs(CCData.Zs));
        legend('Open Circuit','Closed Circuit')
        hold off
        
    elseif case_select == 3
        %%
        if isfile('CC.mat') ==  0 && isfile('OC.mat') ==  0
            disp('### No measurement files found.')
            
        elseif isfile('CC.mat') ==  0 && isfile('OC.mat') ==  1
            msgbox('### Closed Circuit measurement file is missing.')
            
        elseif isfile('CC.mat') ==  1 && isfile('OC.mat') ==  0
            msgbox('### Open Circuit measurement file is missing. ')
            
        else
            fprintf('\n')
            fprintf('### Estimated mechanical parameters:\n')
            fprintf('\n')
  
            OCData = open('OC.mat');
            CCData = open('CC.mat');
            
            F = OCData.F;

            F_wind = F>350 & F<600; % SELECT FREQUENCY WINDOW TO SUBTRACT DATA
            
            F = F(F_wind);
            OCData.Zs = OCData.Zs(F_wind);
            CCData.Zs = CCData.Zs(F_wind);
            
            %%% Estimate Bl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Bl_est = mean(sqrt(Re*Sd*real(CCData.Zs - OCData.Zs)));

            %%% Estimate R %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Rms_est =  mean(real(Sd*OCData.Zs)); 

            %%% Estimate M & C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%RMK see 20211006 notes
            
            XX = [-(2*pi*F).^-1, 2*pi.*F]; %[omega^-1 omega]
            YY = 0.5*Sd*imag(CCData.Zs + OCData.Zs); % normally length(Zoc) = length(Zcc)
            coef = XX\YY; % = [k , M]'

            Cmc_est = 1/coef(1);  % Get the total mechanical complicance (suspension + spider + enclosure)
            Mms_est = coef(2);
            
            
            %%% Resesonance Frequency
            f0_est  = 1/(2*pi*sqrt(Mms_est*Cmc_est));
            
            %Facteur qualité
            Q_est = 1/Rms*sqrt(Mms_est/Cmc_est);
              
            fprintf('Bl = %e;\n', Bl_est);
            fprintf('Rms = %e;\n', Rms_est);
            fprintf('Mms = %e;\n', Mms_est);
            fprintf('Cmc = %e;\n\n', Cmc_est);
            fprintf('f0 = %e\n', f0_est);
            fprintf('Q = %e\n', Q_est);
            %%
            break;
        end
        
    else
        fprintf('### Something went wrong...\n')
        break;
    end        
end


case_select = 0; %reset case_select to 0
%% PLOTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
%%% TODO: plot |Z_OC| & |Z_CC| vs F

%
figure(2);
cmap = copper(5); % Cell array of colors.

plot(F,Zs,'color',cmap(1,:),'LineWidth',3)
%(F,Zs,'color',cmap(1,:),'LineWidth',3)
%plot(F(TF{ii}),alpha{ii}(TF{ii}),'r*')
hold on %% must hold on AFTER initial axis is created

hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([1 ff]);
%ylim([0 1.1]);

xlabel("Frequency (Hz)")
ylabel("Absorbtion coefficient")
%title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
%legend("Absorption",'Location','northwest')

%}