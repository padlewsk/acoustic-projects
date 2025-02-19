%%% Transfer matrix relates conjugate variables (p,v) --> W transfer matrix
%%% in https://link.springer.com/article/10.1007/s11082-023-05413-4#Equ30
%%% In either case, W or M have the same trace and determinant

function W = M_PC(k,sys_param)
    kk = reshape(k, 1, 1, []);
    Z1 = sys_param.Zc*0.8;
    Z2 = sys_param.Zc*1.2;

    kk1 = kk;
    kk2 = kk;

   

    a1 = sys_param.a/2;
    a2 = sys_param.a/2;

    %First
    W1 = [
        cos(kk1*a1) 1i*Z1*sin(kk1*a1);
        1i/Z1*sin(kk1*a1) cos(kk1*a1)
        ];%waveguide
     %second
    W2 = [
        cos(kk2*a2) 1i*Z2*sin(kk2*a2);
        1i/Z2*sin(kk2*a2) cos(kk1*a2)
        ];%waveguide
   
    W = 0*W1;%initialize
    for kk_idx = 1:numel(kk)
        W(:,:,kk_idx) =  W1(:,:,kk_idx)*W2(:,:,kk_idx);
    end
end