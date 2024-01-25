function [param_new] = disorder(p,idx_rng)
    %%% 2023.08.10 Passive unit cell dispersion measurement.
    addpath('__fun');

    %%% UPLOAD PARAMETERS 
    if ~exist('p') ||  isempty(p)
       p = param_struct(); % in case some parameters are overwritten
       fprintf('Using default parameters\n')
    end

    if ~exist('idx_rng') ||  isempty(idx_rng)
       idx_rng = 1; % in case some parameters are overwritten
       fprintf('Using default seed\n')
    end
    
    % seed for random function
    rng(idx_rng);
    
    % lambda_cpl: reciprocal coupling disorder
    %for ii = 1:numel(p.cpl)
    %    p.cpl(ii) = p.cpl(ii)*normrnd(1,p.sigma_cpl);%(1 + p.lambda_cpl*2*(rand(1) - 0.5));
    %end
    
    %non-reciprocal coupling disorder selector
    if p.isnonreciprocal == true %non-reciprocal 
        for ii = 1:numel(p.cpl)
            p.cpl_L(ii)    =    p.cpl_L(ii)*normrnd(1,p.sigma_cpl);%*(1 + p.lambda_cpl_NR*2*(rand(1) - 0.5));%linear coupling
            p.cpl_R(ii)    =    p.cpl_R(ii)*normrnd(1,p.sigma_cpl);%*(1 + p.lambda_cpl_NR*2*(rand(1) - 0.5));
            p.cpl_nl_L(ii) = p.cpl_nl_L(ii)*normrnd(1,p.sigma_cpl);%*(1 + p.lambda_cpl_NR*2*(rand(1) - 0.5));%nonlinear coupling
            p.cpl_nl_R(ii) = p.cpl_nl_R(ii)*normrnd(1,p.sigma_cpl);%*(1 + p.lambda_cpl_NR*2*(rand(1) - 0.5));
        end %
    else %%reciprocal 
        for ii = 1:numel(p.cpl)
            p.cpl_L(ii)    =    p.cpl_L(ii)*normrnd(1,p.sigma_cpl);%linear coupling
            p.cpl_R(ii)    =    p.cpl_L(ii);
            p.cpl_nl_L(ii) = p.cpl_nl_L(ii)*normrnd(1,p.sigma_cpl);%nonlinear coupling
            p.cpl_nl_R(ii) = p.cpl_nl_L(ii);
        end 
    end
    
    % lambda_loc: Local disorder
    for ii = 1:8
        for jj = 1:2
             p.Bl(ii,jj) =  p.Bl(ii,jj)*normrnd(1,p.sigma_loc); %*(1 + p.lambda_loc*2*(rand(1) - 0.5)); %1 pm 0.5 max!
            p.Rms(ii,jj) = p.Rms(ii,jj)*normrnd(1,p.sigma_loc); %*(1 + p.lambda_loc*2*(rand(1) - 0.5));
            p.Mms(ii,jj) = p.Mms(ii,jj)*normrnd(1,p.sigma_loc); %*(1 + p.lambda_loc*2*(rand(1) - 0.5)); 
            p.Cmc(ii,jj) = p.Cmc(ii,jj)*normrnd(1,p.sigma_loc); %*(1 + p.lambda_loc*2*(rand(1) - 0.5)); 
        end
    end
    %setparam(p); %sets the new parameters p
    param_new = p;
end