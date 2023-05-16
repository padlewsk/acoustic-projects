
%between resonatros %%%%%%%%%%%%%%%%%%%%
 %mass term
M_b = [
   -Mab/2,    0  ;
     0  , -Mab/2;
    ];

%resistance term
R_b = [
     0 , 0;
     0 , 0;
    ];

%complicance term
K_b = [
     -1/Cab,  +1/Cab ;
     1/Cab,  -1/Cab;
    ];

% at resonator %%%%%%%%%%%%%%%%%%%% 
%mass term
M_a = [
   -Maa/2, 0,    0  ;
     0 ,  Mas,    0  ;
     0 ,   0 , -Maa/2;
    ];
%resistance term
R_a = [
    0,  0, 0;
    0, Ras, 0;
    0,  0  ,0;
    ];
%complicance term
K_a = [
     -1/Caa,    +1/Caa   , +1/Caa  ;
    -1/Caa,  1/Cac+1/Caa,  1/Caa;
     1/Caa,    -1/Caa   , -1/Caa;
    ];

%%% cell builder  %%%%%%% BABBAB 2+3+2+2+3+2 - (6-1) = 9
M = zeros(9,9);
R = zeros(9,9);
K = zeros(9,9);

M(1:2,1:2) = M(1:2,1:2) + M_b; %between speaker
M(2:4,2:4) = M(2:4,2:4) + M_a; %at speaker
M(4:5,4:5) = M(4:5,4:5) + M_b;
M(5:6,5:6) = M(5:6,5:6) + M_b;
M(6:8,6:8) = M(6:8,6:8) + M_a;
M(8:9,8:9) = M(8:9,8:9) + M_b;

R(1:2,1:2) = R(1:2,1:2) + R_b; %between speaker
R(2:4,2:4) = R(2:4,2:4) + R_a; %at speaker
R(4:5,4:5) = R(4:5,4:5) + R_b;
R(5:6,5:6) = R(5:6,5:6) + R_b;
R(6:8,6:8) = R(6:8,6:8) + R_a;
R(8:9,8:9) = R(8:9,8:9) + R_b;

K(1:2,1:2) = K(1:2,1:2) + K_b; %between speaker
K(2:4,2:4) = K(2:4,2:4) + K_a; %at speaker
K(4:5,4:5) = K(4:5,4:5) + K_b;
K(5:6,5:6) = K(5:6,5:6) + K_b;
K(6:8,6:8) = K(6:8,6:8) + K_a;
K(8:9,8:9) = K(8:9,8:9) + K_b;
   