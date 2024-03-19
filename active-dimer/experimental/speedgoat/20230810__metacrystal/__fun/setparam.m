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
    tg.setparam('', 'freq_sine', p.freq_sine);% 
    tg.setparam('', 'src_select_type', p.src_select_type); % 1 random 0 cte
    tg.setparam('', 'src_select_ab', p.src_select_ab); % 1 = src A, 2 = src B r = src A+B
    tg.setparam('', 'src_gain', p.A);%
    
    %{
    %sweep not used for now
    tg.setparam('', 'tmax', p.tmax);%
    tg.setparam('', 'freq_ini',  p.freq_ini);%
    tg.setparam('', 'freq_fin',  p.freq_fin);%
    %} 

    % CONTROL PARAMETERS
    % coupling
    tg.setparam('','k_mat',   diag(p.cpl_L,-1)*p.Sd    + diag(p.cpl_R,1)*p.Sd);    %linear coupling matrix k 
    tg.setparam('','k_mat_NL',diag(p.cpl_nl_L,-1)*p.Sd + diag(p.cpl_nl_R,1)*p.Sd); % nonlinear coupling matrix k_nl

    % coupling disorder
    tg.setparam('','sigma_T', p.sigma_T);    %set temperature variance
    tg.setparam('','isnonreciprocal',p.isnonreciprocal); 

    % phase disorder
    %tg.setparam('','t_delay', 10); 

    % Bl
    tg.setparam('','Bl',reshape(p.Bl',[] ,1)); %RMK: the reshape is simply to change the 8x2 matrix to a 16x1 

    % impedance synthesis
    [b, a] = tfdata(p.Phi_d);
    b = cell2mat(b);
    %b = reshape(b',[] ,3);??? doesn't work ...
    b = [b(1,1:3); b(1,4:6);
         b(2,1:3); b(2,4:6);
         b(3,1:3); b(3,4:6);
         b(4,1:3); b(4,4:6);
         b(5,1:3); b(5,4:6);
         b(6,1:3); b(6,4:6);
         b(7,1:3); b(7,4:6);
         b(8,1:3); b(8,4:6)]; % [num coefs of 1.1 atom; num coefs of 1.2 atom] % check if this is ok!
    tg.setparam('','dtf_b',b);
    
    a = cell2mat(a);
    %a = reshape(a',[] ,3);??? doesn't work ...
    a = [a(1,1:3); a(1,4:6);
         a(2,1:3); a(2,4:6);
         a(3,1:3); a(3,4:6);
         a(4,1:3); a(4,4:6);
         a(5,1:3); a(5,4:6);
         a(6,1:3); a(6,4:6);
         a(7,1:3); a(7,4:6);
         a(8,1:3); a(8,4:6)];
    tg.setparam('','dtf_a',a);% [den coefs of 1.1 atom; den coefs of 1.2 atom]
   
    % current to voltage
    tg.setparam('', 'i2u', p.i2u); %converts current to voltage (will be converted back with u2i)

    % mic sensitivity     %%% F(unitcell,atom) 
    tg.setparam('', 'sens_p', reshape(p.sens_p',[] ,1));%

    % back pressure to displacement transfer function
    tg.setparam('','pb2disp', reshape(p.pb2disp',[] ,1));%

end