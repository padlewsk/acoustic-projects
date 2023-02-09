clear
close all

k =  (1/2.511373e-04); % reference sring constant
r = 2.79e-01;
Bl = 1.1;
kappa = 0.8*k; %inter-coupling
rho = 0*r;


a = 0.2806;%0.25 % unitcell size
freq = 650;%hz
tf = 1/freq*100;%s
tspan = linspace(0,tf,50000); %s time scale 
init_x1 = 0;
init_v1 = 0;
init_x2 = 0;
init_v2 = 0;


%%% WITHOUT DELAY
%[tsol,x] = ode45( @(tspan,y) MassSpring(tspan,y,kappa, freq), tspan, [init_x1 init_v1 init_x2 init_v2]); % x = [x1,dx1dt,x2,dx2dt]

%%% WITH DELAY
%
tau = 1e-12;%50e-6; %1e-12;% 
lags = [tau]; %list of possible lags to choose from
sol = dde23( @(t,x,Z) MassSpringDelay(t,x,Z,kappa,rho,freq), lags,  @history, tspan); % x = [x1,dx1dt,x2,dx2dt]
tsol = sol.x'; %%% NOT THE SAME AS BEFORE
xsol = sol.y';
%}

deltax = xsol(:,3) - xsol(:,1);
deltav = xsol(:,4) - xsol(:,2);

%%
clf
fig1 = figure(1);
    subplot(3,1,1);
        label1 = ["x_1 [m]"; "x_2 [m]"];
        plot(tsol, xsol(:,1));
        hold on
        plot(tsol, xsol(:,3));
        legend(label1);
        hold off
        xlim([0,tf])
        grid on
        xlabel('Time (s)')
        ylabel('Displacement (m)')

    subplot(3,1,2); 
        label2 = ["v_1 [m/s]"; "v_2 [m/s]"];
        plot(tsol, xsol(:,2));
        hold on
        plot(tsol, xsol(:,4));
        legend(label2);
        hold off
        xlim([0,tf])
        grid on
        xlabel('Time (s)')
        ylabel('Velocity (m/s)')
        
        subplot(3,1,3);
        label1 = ["i_{kappa,1}"; "i_{kappa,2}";"i_{rho,1}"; "i_{rho,2}"];
        plot(tsol,(kappa/Bl)*(xsol(:,1)-xsol(:,3)));
         hold on
        plot(tsol, (kappa/Bl)*(xsol(:,3)-xsol(:,1)));
        plot(tsol, (rho/Bl)*(xsol(:,2)-xsol(:,4)));
        plot(tsol, (rho/Bl)*(xsol(:,4)-xsol(:,2)));
        legend(label1);
        xlim([0,tf])
        grid on
        xlabel('Time (s)')
        ylabel('Current (A)')

time_window = 0<tsol;%0.04<t;
fig3 = figure(3);
    %plot(deltax(time_window), deltav(time_window))
    hold on
    p1 = plot(xsol(:,1), xsol(:,2))
    p1.Color(4) = 0.5;
    %{
    p2 = plot(x(:,3), x(:,4))
    p2.Color(4) = 0.5;
    %}
    hold off
    xlabel('x [m]')
    ylabel('v [m/s]')
    legend(["site 1"; "site 2"]);
    axis square
    grid on
    box on
    
%figure
%plot(tsol)

%autoArrangeFigures