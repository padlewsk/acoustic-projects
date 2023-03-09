
 function dxdt = MassSpringDelay(t,x,Z,kappa,rho,freq)
    %%% x = [x1,v1, x2, v2]
    xlag = Z(:,1); %only tau 
%     xlag2 = Z(:,2);
%     xlag3 = Z(:,3);
%     xlag4 = Z(:,4);

    %beta = 0.1;
    a = 0.28; % unitcell size
    m = 5.3e-04;
    %muM = 1;
    r = 2.78e-01;
    muR = 0.2;
    k =  (1/1.82e-04); %speaker spring constants
    muC = 1;
    c0 = 343;
    omega = 2*pi*freq;
    Sd =  12e-4;
 
    da1dt = x(2);
    db1dt = 1/m*(0.5*sin(omega*t)*Sd                 - r*(x(2)- xlag(2)*(1-muR)) - k*(x(1)-xlag(1)*(1 - muC)) - kappa*(xlag(1) - xlag(3)) - rho*(xlag(2) - xlag(4))) ;

    da2dt = x(4);
    db2dt = 1/m*(0.5*sin(omega*t + a/2*omega/c0)*Sd  - r*(x(4)- xlag(4)*(1-muR)) - k*(x(3)-xlag(3)*(1 - muC)) - kappa*(xlag(3) - xlag(1)) - rho*(xlag(4) - xlag(2))); %phase delay in drive-> spatial separation of speakers

    dxdt = [da1dt; db1dt;  da2dt; db2dt];
 end
