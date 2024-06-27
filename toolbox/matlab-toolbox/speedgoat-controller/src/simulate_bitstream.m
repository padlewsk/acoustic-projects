function simout = simulate_bitstream(basename)

    arguments
        basename (1, :) string = "IO397"
    end

    if numel(basename) > 1
        simout = arrayfun(@(x) simulate_bitstream(x), basename);
        return;
    end

    model = sprintf('%s_src', basename);
    T_END = 1e-3;
    OS = 100;
    N_MAX = 8;
    COEF_FL = 26;
    COEF_WL = 32;

    % 2-input 1-output random transfer function
    rng(0); % repeatability
    sys = zpk(drss(N_MAX, 1, 2));
    sos = sosdata(sys, N_MAX, COEF_FL, COEF_WL);
    sos = cellfun(@(x) fi(x, 1, COEF_WL, COEF_FL), sos, 'UniformOutput', false);

    %% Simulation
    fprintf('Simulating %s...\n', model);

    load_system(model);
    set_param(model, 'StopTime', num2str(T_END));
    set_param([model, '/sos1'], 'Value', mat2str(sos{1}));
    set_param([model, '/sos2'], 'Value', mat2str(sos{2}));
    set_param([model, '/ticks'], 'Value', mat2str(OS));
    simout = sim(model);
    if strcmpi(get_param(model, 'shown'), 'off')
        close_system(model, 0); % if GUI is not shown, close it
    end

    fprintf('\t[DONE]\n');

    %% Processing
    fprintf('Calculating reference signals and transfer functions...\n');

    u_ = double(simout.simout.ai.Data(:, 1:2));
    y_ = double(simout.simout.ao1.Data);

    % find the first rise of u_
    idx = find(any(u_ ~= u_(1,:), 2), 1);
    u_ = u_(idx:end, :);
    y_ = y_(idx:end, :);

    % theoretical signal
    y_truth_ = reshape(repmat(lsim(sys, u_(1:OS:end, :))', OS, 1), [], 1);

    [rho_, lag_] = xcorr(y_, y_truth_, 100*OS);
    rho_ = rho_./sqrt(sum(y_truth_.^2).*sum(y_.^2));
    [~, idx] = max(rho_, [], 1);

    fprintf('\tdelay:       %s samples\n',  mat2str(lag_(idx)));
    fprintf('\tcorr. coef.: %s\n',          mat2str(rho_(idx)));
    fprintf('\t[DONE]\n');

    %% Display
    figure('name', sprintf('Simulation results %s', basename));
    plot(y_truth_, 'DisplayName', 'Theory, double');
    hold on;
    plot(y_, 'DisplayName', 'Simulated, fxp SOS');
    legend show;
    grid on;
    grid minor;
    xlabel('samples');
    ylabel('y');

end
