function dydt = first_order(t,y,u)
    tau = 5;
    k = 2.0;
    
    dydt = (-y + k*u)/tau
end
