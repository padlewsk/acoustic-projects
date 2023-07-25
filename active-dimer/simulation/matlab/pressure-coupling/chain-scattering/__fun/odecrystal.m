%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION

function dydt = odecrystal(t,y,temp)
    %%% TEST y = ones(1,2*mat_size);
    sys_param = sys_params();

    %% TRANSFER MATRIX UNIT CELL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% BETWEEN RESONATORS
    M_b = [% specific acoustic mass term
       -sys_param.Mab/2,    0  ;  % RMK: opposite sign to aid with building the cell matrix (first line only)c.f.__20230515__theory
         0  , -sys_param.Mab/2;
        ];
    R_b = [% resistance term
         0 , 0;% RMK:
         0 , 0;
        ];
    K_b = [% specific acoustic  complicance term
         -1/sys_param.Cab,  1/sys_param.Cab ;
         1/sys_param.Cab,  -1/sys_param.Cab;
        ];

    %%% AT RESONATORS 
    M_a = [% specific acoustic  mass term
       -sys_param.Maa/2, 0,    0  ;
         0 ,  sys_param.Mas,    0  ;
         0 ,   0 , -sys_param.Maa/2;
        ];
    R_a = [%  specific acoustic resistance term
        0,  0, 0;% RMK:
        0, sys_param.Ras, 0;
        0,  0  ,0;
         ];
    K_a = [%  specific acoustic complicance term
         -1/sys_param.Caa,     1/sys_param.Caa   , +1/sys_param.Caa  ;% RMK:
         -1/sys_param.Caa,  1/sys_param.Cas+1/sys_param.Caa,  1/sys_param.Caa;
          1/sys_param.Caa,    -1/sys_param.Caa   , -1/sys_param.Caa;
         ];
  
    %%% BUILD UNITCELL 9x9 matrix (--> [_b_a_b_b_a_b_] 2+3+2+2+3+2 - (6-1) = 9)
    M_cell = zeros(9,9); % Cell mass matrix
    R_cell = M_cell;     % Cell resistance matrix
    K_cell = M_cell;     % Cell complicance matrix
    
    M_cell(1:2,1:2) = M_cell(1:2,1:2) + M_b; %between speaker
    M_cell(2:4,2:4) = M_cell(2:4,2:4) + M_a; %at speaker
    M_cell(4:5,4:5) = M_cell(4:5,4:5) + M_b;
    M_cell(5:6,5:6) = M_cell(5:6,5:6) + M_b;
    M_cell(6:8,6:8) = M_cell(6:8,6:8) + M_a;
    M_cell(8:9,8:9) = M_cell(8:9,8:9) + M_b;

    R_cell(1:2,1:2) = R_cell(1:2,1:2) + R_b; %between speaker
    R_cell(2:4,2:4) = R_cell(2:4,2:4) + R_a; %at speaker
    R_cell(4:5,4:5) = R_cell(4:5,4:5) + R_b;
    R_cell(5:6,5:6) = R_cell(5:6,5:6) + R_b;
    R_cell(6:8,6:8) = R_cell(6:8,6:8) + R_a;
    R_cell(8:9,8:9) = R_cell(8:9,8:9) + R_b;

    K_cell(1:2,1:2) = K_cell(1:2,1:2) + K_b; %between speaker
    K_cell(2:4,2:4) = K_cell(2:4,2:4) + K_a; %at speaker
    K_cell(4:5,4:5) = K_cell(4:5,4:5) + K_b;
    K_cell(5:6,5:6) = K_cell(5:6,5:6) + K_b;
    K_cell(6:8,6:8) = K_cell(6:8,6:8) + K_a;
    K_cell(8:9,8:9) = K_cell(8:9,8:9) + K_b;
    
    %%% BUILD CRYSTAL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    global N_cell t_fin % number of cells
    mat_size = 9*N_cell-(N_cell-1);
    M = zeros(mat_size,mat_size);
    R = M;
    K = M;

    for nn = [1:N_cell]  %RMK M(1:9,1:9) =  M_cell(:,:)% first block
        nn = nn-1;
        mat_seg = [1+nn*8:9+nn*8];   
        M(mat_seg, mat_seg) = M(mat_seg, mat_seg)+  M_cell(:,:);
        R(mat_seg, mat_seg) = R(mat_seg, mat_seg)+  R_cell(:,:);
        K(mat_seg, mat_seg) = K(mat_seg, mat_seg)+  K_cell(:,:);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%y = [x1,...,xn,q1,...qn]
    x = y(1:mat_size);            % acoustic charge at each node
    q = y(mat_size+1:mat_size*2); % acoustic flow at each node
   
    %% SOURCE AND BOUNDARY CONDITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% SRC
    %%%%%% SINE*SIGMOIDE 
    %p_src = 1/(1+exp(1000*(-t)))*param.A_src*sin(2*pi*param.f_src*t)*1/(1+exp(1000*(t-t_fin/2)));

    %%%%%% CENTER PULSE 
    % gaussian pulse centered at omega_src: P_src \propto  *exp(-(omega-omega_src)^2*(tau^2)) 
    %
    freq_src = sys_param.f_src; %param.c0/param.a/2; %centre
    omega_src = 2*pi*freq_src;
    T_src = 1/freq_src; %1/freq
    t0 = 3*T_src;% delay %%%%%%%%%%%%%%%%%
    tau = 0.5*T_src/sqrt(2);% width
    p_src = sys_param.A_src*exp(1i*(omega_src*t))*exp(-(t-t0)^2/(2*tau^2)); 
    %}

    %%% BOUNDARY CONDITIONS 
    %%%%%% HARD WALL
    %q(1) = 0;% hard wall q = 0 
    %q(end) = 0;
    
    %%%%%% sweep
     %{
    if t < t_fin/2
        %p_src = param.A_src*sin(2*pi*param.f_src*t); 
            % logarithmic %%% https://en.wikipedia.org/wiki/Chirp
        k = log((param.ff/param.fi)^(1/(t_fin/2)));
        phi = 2*pi*param.fi*(exp(k*t) - 1)/k;
        f_src = param.fi*exp(k*t);
        p_src = param.A_src*sin(2*pi*f_src*t); 
    else
        p_src = 0;
    end
    %} 


    %%%%%% ANECHOIC TERMINALS
    P = zeros(mat_size,1); %P vector
    P(1)   =  sys_param.Zc*q(1)/sys_param.S;  % RMK: opposite sign 
    P(end) =  sys_param.Zc*q(end)/sys_param.S;  

    %%% SOURCE LOCATION(s)
    src_loc = [1 mat_size];% [round(mat_size/2)]; %%%%%%%
    for nn = src_loc
        if nn == 1 || mod(nn,10) == 0 % RMK: opposite sign on every first pressure node to aid with building the cell matrix
            P(nn) = P(nn) -  2*p_src;
        else
            P(nn) = P(nn) +  2*p_src;
        end
    end
    %% SPEAKER PRESSURE AND CONTROL CURRENT --> c.f. 20230516__
    p_s = 1/sys_param.Caa*(x(2:4:end) - x(3:4:end) - x(4:4:end)); %size = 2*N_cell
  
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %{
    v_cpl_A = 1;  %segment A
    w_cpl_A = 0;

    v_cpl_B = 1;  %segment B
    w_cpl_B = 0;

    v_cpl = zeros(2*N_cell,1);
    w_cpl = zeros(2*N_cell,1);
    
    v_cpl(1:N_cell)          = v_cpl_A*ones(N_cell,1);
    w_cpl(1:N_cell+1)        = w_cpl_A*ones(N_cell+1,1); 
   
    v_cpl(N_cell+1:2*N_cell) = v_cpl_B*ones(N_cell,1);
    w_cpl(N_cell+2:2*N_cell) = w_cpl_B*ones(N_cell-1,1);
    
    p_s_1 = p_s(1:2:end); %pressure at speaker 1 (speaker vector)
    p_s_2 = p_s(2:2:end); %pressure at speaker 2

    %coupling pressure vector
    p_v_cpl = p_s*0; % initialize intra cell matrix of zeros
    p_w_cpl = p_s*0; % initialize inter cell matrix of zeros
    
    p_v_cpl(1:2:end) = p_s_2;
    p_v_cpl(2:2:end) = p_s_1;
   
    p_w_cpl(2:2:end-1) = p_s_1(2:end);   %p_{n,1}
    p_w_cpl(3:2:end-1) = p_s_2(1:end-1); %p_{n,2}

    i_s = Sd/Bl*(v_cpl.*p_v_cpl + w_cpl.*p_w_cpl);
    %}
    %linear coupling
    v.A.L  = 0;  %segment A
    w.A.L  = 0;
    v.B.L  = 0;  %segment B
    w.B.L  = 0;
%1E-3 in hybrid
    %non linear coupling
    v.A.NL = 0E-3; %segment A 
    w.A.NL = 0E-3;
    v.B.NL = 0E-3;  %segment B
    w.B.NL = 0E-3;

    %asymmetrica coupling parameter g % +/- increase/decrease
    %toward right %%% FIX!!!
    g.v.A = 0; % --> non-linear non-Hermitian skin effect
    g.w.A = 0;
    g.v.B = 0;
    g.w.B = 0;
    
    v_L = zeros(2*N_cell,1);
    w_L = zeros(2*N_cell,1);
    v_L(1:N_cell)          = v.A.L*ones(N_cell,1); 
    w_L(1:N_cell+1)        = w.A.L*ones(N_cell+1,1); 
    v_L(N_cell+1:2*N_cell) = v.B.L*ones(N_cell,1);
    w_L(N_cell+2:2*N_cell) = w.B.L*ones(N_cell-1,1);

    v_NL = zeros(2*N_cell,1);
    w_NL = zeros(2*N_cell,1);
    v_NL(1:N_cell)          = v.A.NL*ones(N_cell,1);
    w_NL(1:N_cell+1)        = w.A.NL*ones(N_cell+1,1);  
    v_NL(N_cell+1:2*N_cell) = v.B.NL*ones(N_cell,1);
    w_NL(N_cell+2:2*N_cell) = w.B.NL*ones(N_cell-1,1);
    
    %%%
    p_s_1 = p_s(1:2:end); %pressure at speaker 1 (speaker vector)
    p_s_2 = p_s(2:2:end); %pressure at speaker 2

    %coupling pressure vector
    p_v_cpl = p_s*0; % initialize intra cell matrix of zeros
    p_w_cpl = p_s*0; % initialize inter cell matrix of zeros
    
    %reciprocal
   %
    p_v_cpl(1:2:end) = p_s_2; 
    p_v_cpl(2:2:end) = p_s_1;

    p_w_cpl(2:2:end-1) = p_s_1(2:end);   %p_{n,1}
    p_w_cpl(3:2:end-1) = p_s_2(1:end-1); %p_{n,2}
   %}

    % non-recirpocal % DOESNT WORK
    %{
    p_v_cpl(1:2:end/2)       = (1 - g.v.A)*p_s_2(1:end/2);% first half
    p_v_cpl(2:2:end/2)       = (1 + g.v.A)*p_s_1(1:end/2);
    p_v_cpl(end/2+1:2:end)   = (1 - g.v.B)*p_s_2(end/2+1:end);%second half
    p_v_cpl(end/2+2:2:end)   = (1 + g.v.B)*p_s_1(end/2+1:end);
    
    p_w_cpl(2:2:end/2-1)     = (1 - g.w.A)*p_s_1(2:end/2);   
    p_w_cpl(3:2:end/2-1)     = (1 + g.w.A)*p_s_2(1:end/2-1); 
    p_w_cpl(end/2+2:2:end-1) = (1 - g.w.B)*p_s_1(end/2+2:end);   
    p_w_cpl(end/2+3:2:end-1) = (1 + g.w.B)*p_s_2(end/2+1:end-1); 
    %}

    i_s = sys_param.Sd/sys_param.Bl*(v_L.*p_v_cpl     + w_L.*p_w_cpl     + ...
                 v_NL.*p_v_cpl.^3 + w_NL.*p_w_cpl.^3);

    %{
    % coupling parameters (spkr vector size)
    v_cpl = 1; %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    w_cpl = 0;
    
    p_s_1 = p_s(1:2:end); %pressure at speaker 1 (speaker vector)
    p_s_2 = p_s(2:2:end); %pressure at speaker 2
    
    %coupling pressure vector
    p_v_cpl = p_s*0; % initialize intra cell matrix of zeros
    p_w_cpl = p_s*0; % initialize inter cell matrix of zeros
    
    p_v_cpl(1:2:end) = p_s_2;
    p_v_cpl(2:2:end) = p_s_1;
    
    %p_w_cpl(2:2:end) = p_s_2;
    %p_w_cpl(3:2:end) = p_s_1(1:numel(p_w_cpl(3:2:end)));
   
    p_w_cpl(2:2:end-1) = p_s_1(2:end);
    p_w_cpl(3:2:end-1) = p_s_2(1:end-1);
    i_s = Sd/Bl*(v_cpl*p_v_cpl + w_cpl*p_w_cpl);
    %}
    
    % Active control A
    A = zeros(mat_size,1);
    A(3:4:end) = +sys_param.Bl*i_s/sys_param.Sd; % 3rd node is speaker node
    
    % Acoustic volumetric acceleration
    a = inv(M)*(P - A - R*q - K*x); %acceleration
    
    dydt = zeros(2*mat_size,1); % initialize
    dydt(1:mat_size) = q;            %[v1,v2,...,vn]
    dydt(mat_size+1:2*mat_size) = a; %[a1,a2,...,an]
  
    %{
    if t < t_fin/100
        nn = 1;
    elseif t > t_fin/100*nn
        textprogressbar(t/t_fin*100);
        pause(0.05);
        nn = nn + 1
    end
    %}
end