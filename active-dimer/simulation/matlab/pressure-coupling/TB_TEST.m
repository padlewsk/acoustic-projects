clc
clear all
close all


n=10;
syms p_sym [1 n] 



K = 0.5;

e = K*ones(n,1);
M = spdiags([e zeros(n,1) e],-1:1,n,n);
full(M)
p_sym = M*p_sym'

p_sym(n)




%{
%characteristic equation:
p = poly(M);

%eigenvalues:
eigs = roots(p)


%eigenvectors:
M1 = M-eigs(1)*eye(n);
rref(M1)
%}
% OR MATLAB FUNCTION
[V,E] = eigs(M)

%}
