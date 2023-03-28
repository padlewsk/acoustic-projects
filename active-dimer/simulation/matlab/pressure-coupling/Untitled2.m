tspan = (t_0:1/freq_samp:t_1)'; % equal spacing required for FFT

p0 = 1;
[t_raw,p_raw] = ode45(@y, tspan, p0); 


figure(1)
plot(t_raw,p_raw)


function dpdt = y(t,p)
    Rms	= 0.261*0.2;	% mechanical resistance
    Mms	= 6.670769e-04; % moving mass (kg)
    Cmc	= 2.128414e-04; % mechanical compliance (N/m)
    dpdt = [-Rms*p(1)];
end