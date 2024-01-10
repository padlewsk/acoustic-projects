%%% Transfer matrix computed analytically with MATHEMATICA:
%%% pressure_coupling__TM.nb

function M = M_cell(k,sys_param)
    kk = reshape(k, 1, 1, []); 

    %waveguide portion
    M_wg = [
        exp(-1i*kk*sys_param.a/4) 0.*kk;
        0.*kk exp(1i*kk*sys_param.a/4)
        ];%waveguide
    
    %coupled resonator portion
    zs = (1i*kk*sys_param.c0)*sys_param.Mms + sys_param.Rms + 1./((1i*kk*sys_param.c0)*sys_param.Cms);
    zr = sys_param.rho0*sys_param.c0 + sys_param.Sd/sys_param.S;
    
    a1 = 2*zs.*((-1 + exp(1i*kk*sys_param.a))*zr*sys_param.kappa + 2*exp(1i*kk*sys_param.a/2).*zs);
    a2 = (zr^2)*(-1 + exp(1i*kk*sys_param.a))*(sys_param.kappa.^2 - sys_param.Sd.^2);
    a3 = 4*(zr*zs.*(exp(1i*kk*sys_param.a/2)*sys_param.kappa - sys_param.Sd) + zs.^2);
    a4 = 2*zr*zs.*(-2*exp(1i*kk*sys_param.a/2)*sys_param.kappa + sys_param.Sd*(exp(1i*kk*sys_param.a) + 1));
    a5 = 4*exp(1i*kk*sys_param.a).*(zr*zs.*(-exp(-1i*kk*sys_param.a/2)*sys_param.kappa + sys_param.Sd) + zs.^2);

    M_cr = (1./a1).*[ 
        a2+a3, a2-a4;
        -(a2-a4), -a2+a5
    ];
   
    M = 0*M_cr;
    for kk_idx = 1:numel(kk)
        M(:,:,kk_idx) =  M_wg(:,:,kk_idx)*M_cr(:,:,kk_idx)*M_wg(:,:,kk_idx);
    end
end