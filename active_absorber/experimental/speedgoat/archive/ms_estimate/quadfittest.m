clear all
close all
%%% https://fr.mathworks.com/help/optim/ug/nonlinear-data-fitting-example.html
%%% READ HELP

t = linspace(0,10,100); 
y = (t-5).^2 + rand(size(t)); %random datA

%
%function to fit with a coefficient
F = @(a,xdata) a(1) + a(2).*xdata + a(3).*xdata.^2; %anonymous function
a0 = [1 1 1 0]; %initial guess

% finds coefficients X to best fit the nonlinear functions in FUN to the data YDATA (in the least-squares sense)
[coef,resnorm,~,exitflag,output] = lsqcurvefit(F,a0,t,y) ;
%}
   

figure(1)
hold on
plot(t,y,'ro')
plot(t,F(coef,t))
title('Data points')
hold off
