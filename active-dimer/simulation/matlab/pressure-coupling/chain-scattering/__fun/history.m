% Define the initial condition based on the problem
% For example, y0 = 100 for t <= t0
function y0 = history(t,sys_param) % history function for t <= 0
  y0 = zeros(2*sys_param.mat_size,1);
end
%-------------------------------------------