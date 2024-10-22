function [a_coeffs, b_coeffs] = findCoefficients(target_state, T)
    % Number of qubits
    N = log2(length(target_state));
    
    % Initialize symbolic variables
    syms t;
    a_coeffs = sym('a', [N, 1], 'real');
    b_coeffs = sym('b', [N, 1], 'real');
    
    % Define the dynamic coefficients as functions of time
    a_funcs = sym('a_func', [N, 1]);
    b_funcs = sym('b_func', [N, 1]);
    for i = 1:N
        a_funcs(i) = exp(1i * (i-1) * t) / sqrt(N);
        b_funcs(i) = exp(-1i * (i-1) * t) / sqrt(N);
    end
    
    % Initialize the equations
    equations = sym(zeros(2^N, 1));
    
    % Construct the equations based on the target state
    for k = 0:(2^N - 1)
        binary_str = dec2bin(k, N);
        product = 1;
        for j = 1:N
            if binary_str(j) == '0'
                product = product * a_funcs(j);
            else
                product = product * b_funcs(j);
            end
        end
        equations(k+1) = int(product, t, 0, T) / T - target_state(k+1);
    end
    
    % Solve the system of equations
    vars = [a_coeffs; b_coeffs];
    solutions = solve(equations == 0, vars);
    
    % Extract the solutions
    a_coeffs = double(subs(a_coeffs, solutions));
    b_coeffs = double(subs(b_coeffs, solutions));
end
