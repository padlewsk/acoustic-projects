%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION
%DELAYED DIFF EQU SOLEVER
function dydt = dodecrystal(t,y,Z,sys_param)
    %%% TEST y = ones(1,2*sys_param.mat_size);
    %sys_param = sys_params();
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%y = [x1,...,xn,q1,...qn]
    x = y(1:sys_param.mat_size);            % acoustic charge at each node
    q = y(sys_param.mat_size+1:sys_param.mat_size*2); % acoustic flow at each node
    
    %delayed (for multiple delay values)
    xlag = Z(1:sys_param.mat_size,:);            %  acoustic charge at each node
    qlag = Z(sys_param.mat_size+1:sys_param.mat_size*2,:); % acoustic flow at each node
   
    %% SOURCE AND BOUNDARY CONDITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% SRC
    if sys_param.src_select == 0 %%% SINE*SIGMOIDE (temporal cutoff)
        p_src = 1/(1+exp(500*(-t)))*sys_param.A_src*sin(2*pi*sys_param.f_src*t)*1/(1+exp(1000*(t-sys_param.t_fin/2))); %500 on the signal rise and 1000 on signal fall
    elseif sys_param.src_select == 1  %%% CENTER PULSE 
    % gaussian pulse centered at omega_src: P_src \propto  *exp(-(omega-omega_src)^2*(tau^2)) 
        freq_src = sys_param.f_src; %param.c0/param.a/2; %centering pulse on this frequency
        omega_src = 2*pi*freq_src;
        T_src = 1/freq_src; %1/freq 
        t0 = 3*T_src;% delay for single pulse %%%%%%%%%%%%%%%%%
        tau = 0.5*T_src/sqrt(2);% width

        p_src = sys_param.A_src*exp(1i*(omega_src*t))*exp(-(t-t0)^2/(2*tau^2)); %single pulse
        %{
        pulse_period = (5*sys_param.N_cell*sys_param.a/sys_param.c0);
        p_src = 0;
        for nn = 1:floor(sys_param.t_fin/pulse_period)  %multi pulse
            tt = pulse_period*nn;
            p_src = p_src + sys_param.A_src*exp(1i*(omega_src*t))*exp(-(t-tt)^2/(2*tau^2));
        end
        %}
       

    elseif sys_param.src_select == 2  %%% SWEEP  (temporal cutoff)
        %p_src = 1/(1+exp(1000*(-t)))*sys_param.A_src*rand(1)*1/(1+exp(1000*(t-sys_param.t_fin/2)));
           
        if t < sys_param.t_fin %sys_param.t_fin/2
            % linear %%% https://en.wikipedia.org/wiki/Chirp
             chirp_rate = (sys_param.ff-sys_param.fi)/sys_param.t_fin;
             phi =  2*pi*(chirp_rate/2*t^2 + sys_param.fi*t);
             p_src =  sys_param.A_src*sin(phi); 
            %p_src = param.A_src*sin(2*pi*param.f_src*t); 
                
            % logarithmic 
            %chirp rate = log(( sys_param.ff/ sys_param.fi)^(1/(sys_param.t_fin/2)));
            %phi = 2*pi*sys_param.fi*(exp(k*t) - 1)/k;
            %f_src =  sys_param.fi*exp(k*t);
            %p_src =  sys_param.A_src*sin(2*pi*f_src*t); 
            p_src =  sys_param.A_src*sin(phi); 
        else
            p_src = 0;
        end
    else
        fprintf("%%% No source selected.\n")
    end

 

    %%% BOUNDARY CONDITIONS
    P = zeros(sys_param.mat_size,1); % acoustic pressure at each node

    %%%%%% HARDWALL
    % comment out anechoic.
    %q(end)= 0;
    %%%%%% ANECHOIC
    %
    P(1)   =  sys_param.Zc*q(1)/sys_param.S;  % RMK: opposite sign 
    P(end) =  sys_param.Zc*q(end)/sys_param.S;  
    %}
    
    %%% SOURCE LOCATION(s)
    for nn = sys_param.src_loc
        if nn == 1 || mod(nn,10) == 0 % RMK: opposite sign on every first pressure node to aid with building the cell matrix
            P(nn) = P(nn) -  2*p_src;
        else
            P(nn) = P(nn) +  2*p_src;
        end
    end
    %% SPEAKER PRESSURE AND CONTROL CURRENT --> c.f. 20240312__
    %sys_param.idx_rng


    p_s = 1/sys_param.Caa*(x(2:4:end) - x(3:4:end) - x(4:4:end)); %SYMMETRIC DELAY IS HERE! x(3:4:end) is air at the speaker
    p_s_lag = 1/sys_param.Caa*(xlag(2:4:end,:) - xlag(3:4:end,:) - xlag(4:4:end,:)); %ASYMMETRIC DELAY LIST 
    %%% p_s = diag(p_s_lag).*mod(1:2*sys_param.N_cell,2)' + p_s.*mod(2:2*sys_param.N_cell+1,2)'; %IF MULTIPLE RANDOM LAGS% diag(p_s_lag) gets diagonal elements of p_s_lag which assures that lags are different 
    p_s = p_s_lag.*mod(1:2*sys_param.N_cell,2)' + p_s.*mod(2:2*sys_param.N_cell+1,2)';
    
    % fix to match the experimental data cf 20240320__ 
    %{
    temp1 = [ 1     0     1     0     1     0     0     1     0     1     0     1     0    1    0   0];
    temp2 = -(temp1-1);
    p_s = p_s_lag.*temp1' + p_s.*temp2';
    %}

    %%% coupling matrix
    cpl_mat = diag(sys_param.cpl_L,-1) + diag(sys_param.cpl_R,1);  %linear coupling matrix k 
    cpl_mat_nl = diag(sys_param.cpl_nl_L,-1) + diag(sys_param.cpl_nl_R,1); % nonlinear coupling matrix k_nl
    %cpl_mat_nl = diag(sys_param.cpl_nl_L,-1) + diag(sys_param.cpl_nl_R,1) + diag(sys_param.kappa_nl*ones(sys_param.N_cell*2,1)); % nonlinear local + coupling matrix k_nl 

    i_s = sys_param.Sd/sys_param.Bl*(cpl_mat*p_s + cpl_mat_nl*p_s.^3); 

    % Active control A
    A = zeros(sys_param.mat_size,1);
    A(3:4:end) = +sys_param.Bl*i_s/sys_param.Sd; % 3rd node is speaker node
    
    % Acoustic volumetric acceleration
    a = inv(sys_param.M)*(P - A - sys_param.R*q - sys_param.K*x); %acceleration
    
    dydt = zeros(2*sys_param.mat_size,1); % initialize
    dydt(1:sys_param.mat_size) = q;            %[v1,v2,...,vn]
    dydt(sys_param.mat_size+1:2*sys_param.mat_size) = a; %[a1,a2,...,an]
end