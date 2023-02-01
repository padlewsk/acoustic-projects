%%% Estimates mechanical parameters from the measured specific acoustic
%%% impedances for the Open Circuit and Close Circuit case


%%% Absorption coefficient
alpha = 1 - abs((Zs-Zc)./(Zs+Zc)).^2;

if case_select == 1;
    save('OC.mat','F','Zs','alpha');
elseif case_select == 2;
    save('CC.mat','F','Zs','alpha')
elseif case_select == 3;
    
    OCData = open('OC.mat');
    CCData = open('CC.mat');
    
    %%% Estimate Bl %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Bl = mean(sqrt(Re*real(OCData.Zs - CCData.Zs))); %%% VERIFY SIGN!!!!
    
    %%% Estimate R %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Rms =  mean(real(OCData.Zs)); 
    
    %%% Estimate M & C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%RMK see 20211006 notes
    XX = [-(2*pi*f).^-1, 2*pi.*f]; %[omega^-1 omega]
    YY = 0.5*imag(CCData.Zs + OCData.Zs); % normally length(Zoc) = length(Zcc)
    coef = XX\YY;
    
    Cms = 1/coef(1);
    Mmc = coef(2);  % Get the total mechanical complicance (suspension + spider + enclosure)
end