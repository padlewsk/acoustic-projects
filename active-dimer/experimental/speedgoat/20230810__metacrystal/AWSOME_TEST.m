tmax = 3;

k0 = 2.5;
k1 = 7;

log = [];

tmr = tic;
while true
    t = toc(tmr);
    if t < 0.25*tmax
        k = k0;
    elseif t < 0.75*tmax
        k = k0 + (t - 0.25*tmax)*(k1 - k0)/(0.5*tmax);
    else
        k = k1;
    end
    log = [log; t, k];
    if t >= tmax
        break;
    end
end


figure();
plot(log(:, 1), log(:, 2));





