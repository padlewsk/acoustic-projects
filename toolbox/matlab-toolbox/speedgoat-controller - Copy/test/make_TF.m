function make_TF(basename, H, T_END)
    % make_TF is a script to test the IO*_*_test.mdl files from the library

    % basename = 'IO334_IO';
    % basename = 'IO334_SOS';
    % basename = 'IO397';
    % basename = 'IO397_IO';
    % basename = 'IO397_SOS';
    % basename = 'IO104';
    % basename = 'cRIO_9014';
    % basename = 'cRIO_9022';
    % basename = 'cRIO_9056'

    %% Setup
    use_LV = contains(basename, 'cRIO', 'IgnoreCase', true);
    rng(0); % make the randomness repeatable
    if ~exist('T_END', 'var')
        T_END = 5; % measurement time in [s]
    end

    if use_LV
        f_acq = LV_interface.F_CPU;
    else
        f_acq = SG_interface.F_CPU;
    end

    if ~exist('H', 'var') || isempty(H)
        load('../DATA/H_coef.mat', 'H');
        H = H(1);
        H = H*(104/50e-3); % voltage units -> include sensitivities
    end
    H = zpk(H);
    if H.Ts == 0
        H = c2d(H, 1/f_acq, 'tustin');
    elseif H.Ts == -1
        H.Ts = 1/f_acq;
    else
        H = d2d(H, 1/f_acq, 'tustin');
    end

    sos = sosdata(H, ...
        SG_interface.N_MAX, ...
        SG_interface.COEF_FL, ...
        SG_interface.COEF_WL);

    fprintf('End time: %.2f[s]\n', T_END);
    fprintf('Sampling time: %.2f[us]\n', 1e6*H.Ts);
    fprintf('SOS matrix:\n%s\n', mat2str(sos));

    %% Configure (and build for SG)
    if use_LV
        % LabView
        if strcmpi(basename, 'cRIO_9014')
            itf = LV_connection('192.168.7.11');
        elseif strcmpi(basename, 'cRIO_9022')
            itf = LV_connection('192.168.7.12');
        elseif strcmpi(basename, 'cRIO_9056')
            itf = LV_connection('192.168.7.15');
        else
            error('R9195:badModel', 'Unknown model ''%s''.', basename);
        end
        itf.write('FS', f_acq)
        itf.write('SOS1', sos(:));
        itf.write('CTRL_ON');
        itf.write('SCOPE_LEN', T_END*f_acq+1);
        itf.write('SRC_RMS', 0.2);
        itf.write('APPLY');
        pause(0.5);
    else
        % Speedgoat
        fprintf('Building Simulink model...\n');
        model = [upper(basename), '_test'];
        create_build_dir();
        load_system(model);
        set_param([model, '/u_in'], 'SampleTime', num2str(1/f_acq));
        slbuild(model);
        if strcmpi(get_param(model, 'shown'), 'off')
            close_system(model, 0);
        end
        fprintf('\t[DONE]\n');

        fprintf('Loading and starting target...\n');
        if contains(basename, 'IO334', 'IgnoreCase', true)
            tg = slrealtime('Performance');
        elseif contains(basename, 'IO397', 'IgnoreCase', true)
            tg = slrealtime('Baseline');
        elseif contains(basename, 'IO104', 'IgnoreCase', true)
            tg = slrealtime('Mobile');
        else
            error('R9195:badModel', 'Unknown model ''%s''.', basename);
        end
        tg.stop();
        tg.load(model);
        tg.setparam('', 'stdev', 0.2);
        tg.setparam('', 'sos1', sos);
        tg.setparam('', 'sos2', sosdata(0, 8));
        fprintf('\t[DONE]\n');
    end

    %% RUN
    fprintf('Running target for %.3f[s]...\n', T_END);
    if use_LV
        % LabView
        itf.flushinput();
        itf.write('ACQ_START');
        while true
            pause(0.5);
            [c, ~] = itf.read();
            if strcmpi(c, 'ACQ_DONE')
                break;
            end
        end
        itf.flushinput();
        itf.write('GET_SCOPE');
        pause(1);
        [~, d] = itf.read();
        d = reshape(d, [], 4);
        u_ = d(:,1);
        ys_ = d(:,3);
    else
        % Speedgoat
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
        ys_ = signals.y;
    end
    fprintf('\t[DONE]\n');

    %% Display
    [Hs_, f_] = tfestimate(u_, ys_, [], [], [], f_acq);
    H_fxp_ = freqz(sos, f_, f_acq);
    H_truth_ = reshape(freqresp(H, 2*pi*f_), size(f_));
    y_ = lsim(H, u_);

    idx_ = round(0.25*numel(f_)) : round(0.75*numel(f_));
    dphi_ = unwrap(angle(H_truth_(idx_)) - angle(Hs_(idx_)));
    tau = polyfit(2*pi*f_(idx_), dphi_, 1);
    tau = tau(1);
    fprintf('==================\n');
    fprintf('Delay = %.3f[us]\n', 1e6*tau);
    fprintf('==================\n');

    figure('name', 'Simulation results');
    ax = [subplot(2, 2, 1), subplot(2, 2, 2)];
    plot_bode(ax, f_, H_truth_, ...
        'DisplayName', 'Theory, double', ...
        'fUnit', '[Hz]');
    plot_bode(ax, f_, H_fxp_, ...
        'DisplayName', 'Theory, fxp SOS', ...
        'fUnit', '[Hz]');
    plot_bode(ax, f_, Hs_, ...
        'DisplayName', 'Implemented', ...
        'fUnit', '[Hz]');

    subplot(2, 2, [3, 4]);
    plot(u_, 'DisplayName', 'Input signal');
    hold on;
    plot(y_, 'DisplayName', 'Theory, double');
    plot(ys_, 'DisplayName', 'Implemented');
    legend show;
    grid on;
    grid minor;
    xlabel('samples');
    ylabel('y');
end
