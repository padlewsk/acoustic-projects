%RMK: SAVE PARAMS FILE BEFORE RUNNING SIMULATION

function dydt = odecrystal(t,y,f)
    run('params.m');
    %%% UNIT CELL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%% BETWEEN RESONATORS
    M_b = [% specific acoustic mass term
       -Mab/2,    0  ;  % RMK: opposite sign to aid with building the cell matrix (first line only)c.f.__20230515__theory
         0  , -Mab/2;
        ];
    R_b = [% resistance term
         0 , 0;% RMK:
         0 , 0;
        ];
    K_b = [% specific acoustic  complicance term
         -1/Cab,  1/Cab ;
         1/Cab,  -1/Cab;
        ];

    %%% AT RESONATORS 
    M_a = [% specific acoustic  mass term
       -Maa/2, 0,    0  ;
         0 ,  Mas,    0  ;
         0 ,   0 , -Maa/2;
        ];
    R_a = [%  specific acoustic resistance term
        0,  0, 0;% RMK:
        0, Ras, 0;
        0,  0  ,0;
         ];
    K_a = [%  specific acoustic complicance term
         -1/Caa,     1/Caa   , +1/Caa  ;% RMK:
         -1/Caa,  1/Cas+1/Caa,  1/Caa;
          1/Caa,    -1/Caa   , -1/Caa;
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
    global N_cell % number of cells
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
   
    %%% SOURCE AND BOUNDARY CONDITIONS
    %p_src = 50*rand(1)+0*sin(2*pi*422*t);  %source pressure
    %dirac
    %{
    if t == 0
        p_src = 0;
        q(1) = 1e-3; 
        fprintf(sprintf("%f Pa Dirac \n",p_src))  
    else
        p_src = 0;
    end
    %} 
    
    % pulse 
    freq_src = c0/a/2; %centre
    omega_src = 2*pi*freq_src;
    T_src = 1/freq_src; %1/freq
    t0 = 0*T_src;% delay
    tau = T_src;% width
    p_src = 1e2*exp(1i*(omega_src*t))*exp(-(t-t0)^2/(2*tau^2)); %gaussian pulse centered at omega_src
    %P_src \propto  *exp(-(omega-omega_src)^2*(tau^2)) 
    %}
    % boundary condition %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %q(1) = 0;% hard wall q = 0 
    %q(end) = 0;
    p_i = 2*p_src - Zc*q(1)/S; 
    p_o = - (2*p_src - Zc*q(end)/S);

    %x(floor(mat_size/2)) = p_src*1e-8;
    
    P = zeros(mat_size,1); %P vector
    P(1)   = - p_i; % RMK: opposite sign to aid with building the cell matrix
    P(end) = p_o;  
    
    %%% SPEAKER PRESSURE AND CONTROL CURRENT --> c.f. 20230516__
    %q_s = q(3:4:end); %the third node is where the first speaker is located and then every 4th node that follows until the end.
    p_s = 1/Caa*(x(2:4:end) - x(3:4:end) - x(4:4:end)); 
    
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
    
    % Active control A
    A = zeros(mat_size,1);
    A(3:4:end) = +Bl*i_s/Sd; % 3rd node is speaker node
    
    % Acoustic volumetric acceleration
    a = inv(M)*(P - A - R*q - K*x); %acceleration
    
    dydt = zeros(2*mat_size,1); % initialize
    dydt(1:mat_size) = q;            %[v1,v2,...,vn]
    dydt(mat_size+1:2*mat_size) = a; %[a1,a2,...,an]
end