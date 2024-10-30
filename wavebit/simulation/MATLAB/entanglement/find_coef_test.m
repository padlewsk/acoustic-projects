close all
clear all
clc

syms t a0_1(t) a1_1(t) a0_2(t) a1_2(t)
T = 10;
a00 = 1/sqrt(2);
a01 = 0;
a10 = 0;
a11 = 1/sqrt(2);

% Define the integral equations
eq1 = T^(-1)*int(a0_1(t)*a0_2(t), t, 0, T) == a00;
eq2 = T^(-1)*int(a0_1(t)*a1_2(t), t, 0, T) == a01;
eq3 = T^(-1)*int(a1_1(t)*a0_2(t), t, 0, T) == a10;
eq4 = T^(-1)*int(a1_1(t)*a1_2(t), t, 0, T) == a11;

% Solve the system of equations
[sol_a0_1, sol_a1_1, sol_a0_2, sol_a1_2] = solve([eq1, eq2, eq3, eq4], [a0_1(t), a1_1(t), a0_2(t), a1_2(t)]);

% Display the solutions
sol_a0_1
sol_a1_1
sol_a0_2
sol_a1_2
