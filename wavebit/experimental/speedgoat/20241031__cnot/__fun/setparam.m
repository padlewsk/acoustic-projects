function [] = setparam(p)
    addpath('__fun');

    %%% UPLOAD PARAMETERS 
    if ~exist('p') ||  isempty(p)
       p = param_struct(); % in case some parameters are overwritten
       fprintf('Using default parameters\n')
    end
    
    tg = slrealtime(p.tg_model); % target computer interface
    
    %{
    tg.stop(); % make sure the target is stopped
    tg.load(p.MDL); % loads the application in the RT target
    %}
    
    % SOURCE PARAMETERS 

    tg.setparam('', 'omega_0_vec', p.omega_0_vec); % 
    tg.setparam('', 'alpha_mat', p.alpha_mat); % 
    tg.setparam('', 'beta_mat', p.beta_mat); % 
    %tg.setparam('', 'rho', p.rho);% 
    %tg.setparam('', 'theta', p.theta); % 
    %tg.setparam('', 'phi', p.phi); %
    tg.setparam('', 'src_gain', p.A);%
    
    %tg.setparam('', 'rho_corr', p.rho_corr);% 
    %tg.setparam('', 'harm_corr', p.harm_corr); % 

   
    %{
    %sweep not used for now
    tg.setparam('', 'tmax', p.tmax);%
    tg.setparam('', 'freq_ini',  p.freq_ini);%
    tg.setparam('', 'freq_fin',  p.freq_fin);%
    %} 

    % Bl
    %tg.setparam('','Bl',reshape(p.Bl',[] ,1)); %RMK: the reshape is simply to change the 8x2 matrix to a 16x1 
    % Sd
   % tg.setparam('', 'Sd', p.Sd);

    % impedance synthesis (FEEDFORWARD)
    [b, a] = tfdata(p.Phi_d);
    b = cell2mat(b');
    b = [b(1,1:3); b(2,1:3)]; % [num coefs of 1.1 atom; num coefs of 1.2 atom] % check if this is ok!
    tg.setparam('','dtf_b',b);
    
    a = cell2mat(a');
    a = [a(1,1:3); a(2,1:3)];
    tg.setparam('','dtf_a',a);% [den coefs of 1.1 atom; den coefs of 1.2 atom]
   
    % impedance synthesis (FEEDBACK)%
    %tg.setparam('', 'Csb', p.Csb); COMMENT OUT FOR NOW BUT THIS DOES NOT
    %WORK`?????


    % current to voltage
    tg.setparam('', 'i2u', p.i2u); %converts current to voltage (will be converted back with u2i)

    % mic sensitivity     
    tg.setparam('', 'sens_p', reshape(p.sens_p,[] ,1));%
    
end