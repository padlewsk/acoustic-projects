%%% NON RECIPROCAL SSH MODEL
%%% the winding number changes to non-zero value as soon as non reciprocal
%%% Winding number emerges as soon as w_0 diff than 0
clear all
close all
clc

%syms v w v_0
v = 0.5;
w = 0.5;
w_0 = linspace(-0.5,0.5,50);

syms f(phi)
f(phi) = log(v + w*cos(phi) + 1i*w_0*sin(phi) - 1i*(w*sin(phi) + 1i*w_0*cos(phi)));

W  = -1/(2*pi*1i)*int(diff(f,phi),phi,[-pi pi]);

figure(1)
hold on
plot(w_0,W)
xline(0.5,'--')
xline(-0.5,'--')
hold off
xlabel('w_0')
ylabel('Winding number')
box on




%{
phi = linspace(-pi,pi,500);

dx = v + w*cos(phi) + 1i*w_0*sin(phi);
dy = w*sin(phi) + 1i*w_0*cos(phi);
figure(1)
hold on
plot(real(dx),real(dy),'r',imag(dx),imag(dy),'--r')
%plot(imag(dx),imag(dy),'--r')
hold off
box on
axis equal
xlim([-1 1])
ylim([-1 1])
%}

