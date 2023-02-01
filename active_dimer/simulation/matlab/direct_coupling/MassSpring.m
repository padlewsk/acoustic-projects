
 function dxdt = MassSpring(t,x,kappa,freq)
    %%% x = [x_1,v_1, x_2, v_2]
    a = 0.28; % unitcell size
    m = 5.3e-04;
    r = 2.78e-01*0.15;
    k =  (1/1.82e-04)*0.5; %intra-coupling
    c0 = 343;
    omega = 2*pi*freq;
 
    da1dt = x(2);
    db1dt = (0.5*sin(omega*t)                - r*x(2) - k*x(1) - kappa*(x(1)-x(3)))/m ;
 
    da2dt = x(4);
    db2dt = (0.5*sin(omega*t + a/2*omega/c0) - r*x(4) - k*x(3) - kappa*(x(3)-x(1)))/m ;

    dxdt = [da1dt; db1dt;  da2dt; db2dt];
 end
