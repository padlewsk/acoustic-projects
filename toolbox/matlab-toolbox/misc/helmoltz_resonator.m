c0 = 343;

a = 0.05; % (m) total HR size
r = 0.4*a;%cavity radius
h = 0.8*a;%cavity height

S = pi*r^2; %neck cross section
l = 0.2*a; % neck length



V = pi*r^2*h;

f_0 = sqrt(S/(V*l))%*a/c0*2*pi