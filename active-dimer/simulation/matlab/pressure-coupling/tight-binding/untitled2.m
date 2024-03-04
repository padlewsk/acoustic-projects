clear all
close all

v = 0.5;
w = 0.5;

qa = linspace(-pi/2,pi/2,500);

A_p = (v + w*exp(-i*qa))./sqrt(v^2+w^2+2*v*w*cos(qa));
A_m = -(v + w*exp(-i*qa))./sqrt(v^2+w^2+2*v*w*cos(qa));

figure(1)
hold on
plot(qa,real(A_m),'r',qa,imag(A_m),'--r')
plot(qa,real(A_p),'b',qa,imag(A_p),'--b')
hold off

Delta = (abs(A_p) - 1)./(abs(A_p) + 1)*100;

figure(2)
hold on
plot(qa,Delta )
hold off