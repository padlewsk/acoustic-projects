function test_bitstream(basename, H, T_END)
    % test_bitstream is a script that runs the test models

    % basename = 'IO324_IO';
    % basename = 'IO324_SOS';
    % basename = 'IO334_IO';
    % basename = 'IO334_SOS';
    % basename = 'IO397';
    % basename = 'IO397_IO';
    % basename = 'IO397_SOS';
    % basename = 'IO104';
    % basename = 'cRIO_9014';
    % basename = 'cRIO_9022';
    % basename = 'cRIO_9056'

    arguments
        basename (1, :) char = 'IO397_SOS'
        H (1, 2) zpk = drss(4, 1, 2)
        T_END (1, 1) double {mustBePositive} = 5
    end

    %% Setup
    rng(0); % make the randomness repeatable

    if H.Ts == 0
        H = c2d(H, 1/SG_interface.F_CPU, 'tustin');
    elseif H.Ts == -1
        H.Ts = 1/SG_interface.F_CPU;
    else
        H = d2d(H, 1/SG_interface.F_CPU, 'tustin');
    end

    sos = sosdata(H, ...
        SG_interface.N_MAX, ...
        SG_interface.COEF_FL, ...
        SG_interface.COEF_WL);

    fprintf('End time:\n\t%.2f[s]\n', T_END);
    fprintf('Sampling time:\n\t%.2f[us]\n', 1e6*H.Ts);
    fprintf('SOS matrix #1:\n');
    disp(sos{1});
    fprintf('SOS matrix #2:\n');
    disp(sos{2});

    %% Configure and build
    fprintf('Building Simulink model...\n');
    model = [upper(basename), '_test'];
    create_build_dir();
    load_system(model);
    set_param([model, '/Random Number'], 'SampleTime', num2str(1/SG_interface.F_CPU));
    slbuild(model);
    if strcmpi(get_param(model, 'shown'), 'off')
        close_system(model, 0);
    end
    fprintf('\t[DONE]\n');

    fprintf('Loading target...\n');
    if contains(basename, 'IO334', 'IgnoreCase', true)
        tg = slrealtime('Performance');
    elseif contains(basename, 'IO397', 'IgnoreCase', true)
        tg = slrealtime('Baseline');
    elseif contains(basename, 'IO104', 'IgnoreCase', true)
        tg = slrealtime('Mobile');
    else
        error('Unknown model ''%s''.', basename);
    end
    tg.stop();
    tg.load(model);
    tg.setparam('', 'stdev', 5e-3);
    tg.setparam('', 'sos1', sos{1});
    tg.setparam('', 'sos2', sos{2});
    fprintf('\t[DONE]\n');

    %% RUN
    fprintf('Running target for %.3f[s]...\n', T_END);
    tg.start('StopTime', T_END, 'AutoImportFileLog', false);
    if isfinite(T_END)
        while strcmpi(tg.status, 'running')
            pause(0.1);
        end
    else
        fprintf('Press any key to stop recording...');
        pause();
        tg.stop();
    end
    fprintf('\tTarget stopped.\n');

    signals = get_signals(tg, {'u', 'y'});
    u_ = signals.u;
    y_ = signals.y;
    fprintf('\t[DONE]\n');

    %% Display
    [Hs_, f_] = tfestimate(u_, y_, [], [], [], SG_interface.F_CPU, 'mimo');
    H_ = freqresp(H, 2*pi*f_);
    Hs_ = squeeze(Hs_);
    H_ = squeeze(H_).';
    y_sim_ = lsim(H, u_);

    idx_ = round(0.25*numel(f_)) : round(0.75*numel(f_));
    dphi_ = unwrap(angle(H_(idx_)) - angle(Hs_(idx_)));
    tau = polyfit(2*pi*f_(idx_), dphi_, 1);
    tau = tau(1);
    fprintf('==================\n');
    fprintf('Delay = %.3f[us]\n', 1e6*tau);
    fprintf('==================\n');

    figure('name', 'Test results');
    ax = [subplot(2, 2, 1), subplot(2, 2, 2)];
    plot_bode(ax, f_, H_, ...
        'DisplayName', 'Theory', ...
        'fUnit', '[Hz]');
    plot_bode(ax, f_, Hs_, ...
        'DisplayName', 'Implemented', ...
        'fUnit', '[Hz]');

    subplot(2, 2, [3, 4]);
    plot(u_, 'DisplayName', 'Input signal');
    hold on;
    plot(y_sim_, 'DisplayName', 'Theory, double');
    plot(y_, 'DisplayName', 'Implemented');
    legend show;
    grid on;
    grid minor;
    xlabel('samples');
    ylabel('y');
end
