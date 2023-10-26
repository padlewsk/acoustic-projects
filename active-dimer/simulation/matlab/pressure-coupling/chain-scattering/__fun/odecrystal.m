%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION

function dydt = odecrystal(t,y,temp)
    %%% TEST y = ones(1,2*sys_param.mat_size);
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
    M = zeros(sys_param.mat_size,sys_param.mat_size);
    R = M;
    K = M;

    for nn = [1:sys_param.N_cell]  %RMK M(1:9,1:9) =  M_cell(:,:)% first block
        nn = nn-1;
        mat_seg = [1+nn*8:9+nn*8];   
        M(mat_seg, mat_seg) = M(mat_seg, mat_seg)+  M_cell(:,:);
        R(mat_seg, mat_seg) = R(mat_seg, mat_seg)+  R_cell(:,:);
        K(mat_seg, mat_seg) = K(mat_seg, mat_seg)+  K_cell(:,:);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%y = [x1,...,xn,q1,...qn]
    x = y(1:sys_param.mat_size);            % acoustic charge at each node
    q = y(sys_param.mat_size+1:sys_param.mat_size*2); % acoustic flow at each node
   
    %% SOURCE AND BOUNDARY CONDITIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% SRC
    if sys_param.src_select == 0 %%% SINE*SIGMOIDE (temporal cutoff)
        p_src = 1/(1+exp(1000*(-t)))*sys_param.A_src*sin(2*pi*sys_param.f_src*t)*1/(1+exp(1000*(t-sys_param.t_fin/2)));
    elseif sys_param.src_select == 1  %%% CENTER PULSE 
    % gaussian pulse centered at omega_src: P_src \propto  *exp(-(omega-omega_src)^2*(tau^2)) 
        freq_src = sys_param.f_src; %param.c0/param.a/2; %centre
        omega_src = 2*pi*freq_src;
        T_src = 1/freq_src; %1/freq
        t0 = 3*T_src;% delay %%%%%%%%%%%%%%%%%
        tau = 0.5*T_src/sqrt(2);% width
        p_src = sys_param.A_src*exp(1i*(omega_src*t))*exp(-(t-t0)^2/(2*tau^2)); 
    elseif sys_param.src_select == 2  %%% White noise  (temporal cutoff)
        p_src = 1/(1+exp(1000*(-t)))*sys_param.A_src*rand(1)*1/(1+exp(1000*(t-sys_param.t_fin/2)));
    else
        fprintf("%%% No source selected.\n")
    end

    %%%%%% SWEEP %doesn't work
     %{
    if t < sys_param.t_fin/2
        %p_src = param.A_src*sin(2*pi*param.f_src*t); 
            % logarithmic %%% https://en.wikipedia.org/wiki/Chirp
        k = log((param.ff/param.fi)^(1/(sys_param.t_fin/2)));
        phi = 2*pi*param.fi*(exp(k*t) - 1)/k;
        f_src = param.fi*exp(k*t);
        p_src = param.A_src*sin(2*pi*f_src*t); 
    else
        p_src = 0;
    end
    %} 

    %%% BOUNDARY CONDITIONS
    P = zeros(sys_param.mat_size,1); %P vector
    %%%%%% HARDWALL
    % comment out anechoic.

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
    %% SPEAKER PRESSURE AND CONTROL CURRENT --> c.f. 20230516__
    p_s = 1/sys_param.Caa*(x(2:4:end) - x(3:4:end) - x(4:4:end)); %size = 2*sys_param.N_cell

    %%% coupling matrix
    cpl_mat = diag(sys_param.cpl,-1) + diag(sys_param.cpl,1);  %linear coupling matrix k 
    cpl_mat_nl = diag(sys_param.cpl_nl,-1) + diag(sys_param.cpl_nl,1); % nonlinear coupling matrix k_nl

    i_s = sys_param.Sd/sys_param.Bl*(cpl_mat*p_s + cpl_mat_nl*p_s.^3);

    % Active control A
    A = zeros(sys_param.mat_size,1);
    A(3:4:end) = +sys_param.Bl*i_s/sys_param.Sd; % 3rd node is speaker node
    
    % Acoustic volumetric acceleration
    a = inv(M)*(P - A - R*q - K*x); %acceleration
    
    dydt = zeros(2*sys_param.mat_size,1); % initialize
    dydt(1:sys_param.mat_size) = q;            %[v1,v2,...,vn]
    dydt(sys_param.mat_size+1:2*sys_param.mat_size) = a; %[a1,a2,...,an]
end