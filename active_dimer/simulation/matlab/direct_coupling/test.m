
 a = 0.28; % unitcell size
t=linspace(0,0.05,1000); % time scale
init_x1 = 1;
init_dx1dt = 0;

init_x2 = 1;
init_dx2dt = 0;

[t,x] = ode45( @rhs, t, [init_x1 init_dx1dt init_x2 init_dx2dt] ); % x = [x1,dx1dt,x2,dx2dt]


deltax = x(:,3) - x(:,1);
deltav=  x(:,4) - x(:,2);


 label1 = ['x_1[m]', 'x_2[m]'];
 fig1 = figure(1);
 plot(t, x(:,1));
 hold on
 plot(t, x(:,3));
 legend(label1);
hold off

%
 label2 = ['$v_1$[m/s]', '$v_2$[m/s]'];
 fig2 = figure(2);
 plot(t, x(:,2));
 hold on
  plot(t, x(:,4));
 legend(label2);
 hold off



 fig3 = figure(3);
 plot(deltax, deltav)
 xlabel('$\Delta x$[m]')
 ylabel('$\Delta v$[m]')


 function dxdt = rhs(t,x)
 
    a = 0.28; % unitcell size
    m = 5.3e-04*0.5;
    r = 2.78e-01*0.08;
    k =  (1/1.82e-04)*0.43; %intra-coupling
    kappa = k*0; %inter-coupling-0.5*k< 
 
    da1dt = x(2);
    db1dt = (sin(2*pi*500*t) -r*x(2) -k*x(1) - kappa*(x(1)-x(3)))/m ;

    da2dt = x(4);
    db2dt = (sin(2*pi*500*t+pi/4) -r*x(4) -k*x(3) - kappa*(x(3)-x(1)))/m ;

    dxdt = [da1dt; db1dt;  da2dt; db2dt];
 end

