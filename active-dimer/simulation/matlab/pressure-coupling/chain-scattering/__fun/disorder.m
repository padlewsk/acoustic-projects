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
            %p.cpl_L(ii)    =    p.cpl_L(ii)*normrnd(1,p.sigma_cpl);%linear coupling
            %p.cpl_R(ii)    =    p.cpl_R(ii)*normrnd(1,p.sigma_cpl);
            %p.cpl_nl_L(ii) = p.cpl_nl_L(ii)*normrnd(1,p.sigma_cpl);%nonlinear coupling
            %p.cpl_nl_R(ii) = p.cpl_nl_R(ii)*normrnd(1,p.sigma_cpl);
            %p.cpl_L(ii)    =    p.cpl_L(ii)*(1 + p.sigma_cpl*2*(rand(1) - 0.5));%linear coupling
            %p.cpl_R(ii)    =    p.cpl_R(ii)*(1 + p.sigma_cpl*2*(rand(1) - 0.5));
            %p.cpl_nl_L(ii) = p.cpl_nl_L(ii)*(1 + p.sigma_cpl*2*(rand(1) - 0.5));%nonlinear coupling
            %p.cpl_nl_R(ii) = p.cpl_nl_R(ii)*(1 + p.sigma_cpl*2*(rand(1) - 0.5));
            p.cpl_L(ii)    =    p.cpl_L(ii) + p.sigma_cpl*p.kappa*2*(rand(1) - 0.5);%linear coupling (all couplings)
            p.cpl_R(ii)    =    p.cpl_R(ii) + p.sigma_cpl*p.kappa*2*(rand(1) - 0.5);
            p.cpl_nl_L(ii) = p.cpl_nl_L(ii) + p.sigma_cpl*p.kappa_nl*2*(rand(1) - 0.5);%nonlinear coupling (all couplings)
            p.cpl_nl_R(ii) = p.cpl_nl_R(ii) + p.sigma_cpl*p.kappa_nl*2*(rand(1) - 0.5);
        end %
    else %%reciprocal 
        for ii = 1:numel(p.cpl)
            %p.cpl_L(ii)    =    p.cpl_L(ii)*normrnd(1,p.sigma_cpl);%linear coupling
            %p.cpl_L(ii)    =    p.cpl_L(ii)*(1 + p.sigma_cpl*2*(rand(1) - 0.5));%linear coupling 
            p.cpl_L(ii)    =    p.cpl_L(ii) + p.sigma_cpl*p.kappa*2*(rand(1) - 0.5);%linear coupling (all couplings)
            p.cpl_R(ii)    =    p.cpl_L(ii);
            %p.cpl_nl_L(ii) = p.cpl_nl_L(ii)*normrnd(1,p.sigma_cpl);%nonlinear coupling
            %p.cpl_nl_L(ii) = p.cpl_nl_L(ii)*(1 + p.sigma_cpl*2*(rand(1) - 0.5));%nonlinear coupling
            p.cpl_nl_L(ii) = p.cpl_nl_L(ii) + p.sigma_cpl*p.kappa_nl*2*(rand(1) - 0.5); %nonlinear coupling (all couplings)
            p.cpl_nl_R(ii) = p.cpl_nl_L(ii);
        end 
    end

    % lambda_loc: Local disorder 
    %p.M = p.M.*normrnd(1,p.sigma_loc,size(p.M,1)); % multiply crystal matrices by large random matrices.
    %p.R = p.R.*normrnd(1,p.sigma_loc,size(p.R,1));
    %p.K = p.K.*normrnd(1,p.sigma_loc,size(p.K,1));
    p.M = p.M.*(1 + p.sigma_loc*2*(rand(size(p.M,1)) - 0.5)); % multiply crystal matrices by large random matrices.
    p.R = p.R.*(1 + p.sigma_loc*2*(rand(size(p.R,1)) - 0.5));
    p.K = p.K.*(1 + p.sigma_loc*2*(rand(size(p.K,1)) - 0.5));

    param_new = p;
end