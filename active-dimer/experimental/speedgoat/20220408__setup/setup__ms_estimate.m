%%% Estimates mechanical parameters from the measured specific acoustic
%%% impedances for the Open Circuit and Close Circuit case


%%% BEFORE MEASUREMENT: %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

%%% - CHANGE THE VALUE OF Re IN THE PARAMS FOR EACH SPEAKER
%%% - CHANGE THE SENSITIVITY pf the mic

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
%%% INPUT PARAMETERS
%%% add toolbox library
addpath('C:\Users\padlewsk\Desktop\acoustic-projects\toolbox\matlab-toolbox');
addpath('__fun');
p = param_struct();



%%% SPKR NAME AND FILE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
spkrName = p.spkrName;
ocFile = strcat('./__data/','oc_',spkrName,'.mat'); 
ccFile = strcat('./__data/','cc_',spkrName,'.mat'); 

%% BUILD MODEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SG__build;

%% DIALOG BOX %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while 1
    case_select = 0; %default
    str = {'Mechanical Parameter Estimator.';'Select Measurement Step:'};
    S = {'Open Circuit'; 'Closed Circuit'; 'Estimate parameters'};
    case_select = listdlg('PromptString', str, 'ListSize', [300 50] , 'ListString', S, 'SelectionMode', 'single');
   

    if case_select == 1 %Open Circuit Measurement
        if isfile(strcat('./__data/','oc_',p.spkrName,'.mat'))
            fprintf(strcat('###',' " ','oc_',p.spkrName,'.mat',' " ',' already exists.\n'))
        else

            fprintf('### Measuring for Open Circuit case...\n')
            
            %% RUN MEASUREMENT %%%%%%%%%%%%%%%
            sigData = [];
            sigData = SG__measure;
    
            %% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Data = sigData.Variables; %freq;sig1;sig2;sig3;
    
            f = Data(:,1);%data frequency
            v = Data(:,p.v_channel + 1)*p.sens_v;  
            pf = Data(:,p.pf_channel + 1)*p.sens_pf;
            pb = Data(:,p.pb_channel + 1)*p.sens_pb; 
    
            [Zs,F] = tfestimate(v,pf,hamming(p.N/8),[],p.freq,p.fs_acq);
           
            fprintf('### Saving data to file...\n')
            save(ocFile,'f','v','pf','pb','F','Zs');
        end
        ocData = open(ocFile);
        
        figure(1)
        hold on
        loglog(ocData.F,abs(ocData.Zs),'LineWidth',2);
        xlabel("Frequency (Hz)")
        ylabel("Mechanical Impedance (N.s/m)")
        box on
        grid on
        legend('Open Circuit','Closed Circuit')
        fprintf('### Saving data to file...\n')
        
        
    elseif case_select == 2 %Closed Circuit
        if isfile(strcat('./__data/','cc_',p.spkrName,'.mat'))
            fprintf(strcat('###',' " ','cc_',p.spkrName,'.mat',' " ',' already exists.\n'))
        else

            fprintf('### Measuring for Closed Circuit case...\n')
    
            %% RUN MEASUREMENT %%%%%%%%%%%%%%%
            sigData = SG__measure;
            %% PROCESS DATA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Data = sigData.Variables; %freq;sig1;sig2;sig3;
    
            f =  Data(:,1);%data frequency
            v =  Data(:,p.v_channel + 1)*p.sens_v; %ai1; %ai1 
            pf = Data(:,p.pf_channel + 1)*p.sens_pf;%ai2 
            pb = Data(:,p.pb_channel + 1)*p.sens_pb; %b pressure signal (V) 
    
            [Zs,F] = tfestimate(v,pf,hamming(p.N/8),[],p.freq,p.fs_acq);
            
            save(ccFile,'f','v','pf','pb','F','Zs');
        end
        ccData = open(ccFile);
        
        figure(1)
        loglog(ccData.F,abs(ccData.Zs),'LineWidth',2);
        box on
        grid on
        legend('Open Circuit','Closed Circuit')
        hold off
        
    elseif case_select == 3
        %%
        if isfile(ccFile) ==  0 && isfile(ocFile) ==  0
            disp('### No measurement files found.')
            
        elseif isfile(ccFile) ==  0 && isfile(ocFile) ==  1
            msgbox('### Closed Circuit measurement file is missing.')
            
        elseif isfile(ccFile) ==  1 && isfile(ocFile) ==  0
            msgbox('### Open Circuit measurement file is missing. ')
            
        else
            fprintf('\n')
            fprintf('### Estimated mechanical parameters:\n')
            
  
            ocData = open(ocFile);
            ccData = open(ccFile);
            
            F = ocData.F;

            %%% Fit window
            %window = F>350 & F<650; % SELECT FREQUENCY WINDOW TO SUBTRACT DATA
            window = F>p.window_min & F<p.window_max; % SELECT FREQUENCY WINDOW TO SUBTRACT DATA
            
            Zs_OC = -ocData.Zs(window);
            Zs_CC = -ccData.Zs(window);
            
            %%% Estimate Bl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Bl_est = mean(sqrt(p.Re*p.Sd*real(Zs_CC - Zs_OC)));

            %%% Estimate R %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Rms_est =  mean(real(p.Sd*Zs_OC)); 

            %%% Estimate M & C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %%%RMK see 20211006 notes
            
            XX = [-(2*pi*F(window)).^-1, 2*pi.*F(window)]; %[omega^-1 omega]
            YY = 0.5*p.Sd*imag(Zs_CC + Zs_OC); % normally length(Zoc) = length(Zcc)
            coef = XX\YY; % = [k , M]'

            Cmc_est = 1/coef(1);  % Get the total mechanical complicance (suspension + spider + enclosure)
            Mms_est = coef(2);
            
            
            %%% Resesonance Frequency
            f0_est  = 1/(2*pi*sqrt(Mms_est*Cmc_est));
            
            %Facteur qualité
            Q_est = 1/Rms_est*sqrt(Mms_est/Cmc_est);
            

            fprintf('Re = %.2f;\n', p.Re);
            fprintf('Bl = %e;\n', Bl_est);
            fprintf('Rms = %e;\n', Rms_est);
            fprintf('Mms = %e;\n', Mms_est);
            fprintf('Cmc = %e;\n\n', Cmc_est);
            fprintf('f0 = %e\n', f0_est);
            fprintf('Q = %e\n', Q_est);
            fprintf('Fit window = [%.0f,%.0f]\n', p.window_min,p.window_max);
            
            clf
            figure(1)
            loglog(ocData.F,abs(ocData.Zs),'LineWidth',2);
            hold on
            loglog(ccData.F,abs(ccData.Zs),'LineWidth',2);
              xlabel("Frequency (Hz)")
            ylabel("Mechanical Impedance (N.s/m)")
            box on
            legend('Open Circuit','Closed Circuit')
            grid on
            hold off
            xlim([p.fi p.ff]);


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

%{
figure(2);
cmap = copper(5); % Cell array of colors.

plot(F,Zs,'color',cmap(1,:),'LineWidth',2)
%(F,Zs,'color',cmap(1,:),'LineWidth',3)
%plot(F(TF{ii}),alpha{ii}(TF{ii}),'r*')
hold on %% must hold on AFTER initial axis is created

hold off
linespec = {'LabelVerticalAlignment','bottom'}; %'LabelOrientation','horizontal','LabelHorizontalAlignment','center'
%xline(f0,'-.k','f_0 = ' + string(round(f0,1)) + ' Hz',linespec{:});
%xline(fst,'-.k','f_{st} = ' + string(round(fst,1)) + ' Hz',linespec{:});

xlim([p.fi p.ff]);
%ylim([0 1.1]);

xlabel("Frequency (Hz)")
ylabel("Absorbtion coefficient")
%title("\mu_R = " + muR + ",   " + "\mu_M = " + muM + ",   " + "\mu_C = " + muC)
box on
grid on
%legend("Absorption",'Location','northwest')

%}