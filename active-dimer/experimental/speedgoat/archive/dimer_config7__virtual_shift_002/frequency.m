%%% Used when computing H transfer functions in app and for generating the
%%% dispersion curves.



%N = length(0:ts/2:tmax)-1; %Number of samples
%t = (0:ts/2:tmax-ts/2)'; %time vector

N = 2^12;
t = linspace(0,tmax,N)';

f = fi + ((ff - fi)/(tmax))*t; %%%linear frequency vector;
