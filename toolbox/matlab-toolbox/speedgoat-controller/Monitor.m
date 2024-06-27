classdef Monitor < handle
    properties (Constant)
        % Frequency vector associated with psd
        f_ (401, 1) double = linspace(0, 4e3, 401);
    end

    properties (Access = public)
        % Axes on wich to plot time domain data
        axes_td (1, :) matlab.ui.control.UIAxes;

        % Axes on wich to plot frequency domain data
        axes_fd (1, :) matlab.ui.control.UIAxes;
    end

    properties (GetAccess = public, SetAccess = private)
        % Buffered time domain data (#samples x #signals)
        data_td_ (2001, :) double;

        % Time vector associated with data_td
        t_ (2001, 1) double;

        % PSD of the acquired signals
        psd_ (401, :) double;
    end

    properties (Access = private)
        % Instrument object
        instr (1, :) slrealtime.Instrument

        % Target object
        tg slrealtime.Target

        % Flag for updating of not the TD of FD data
        update (1, 1) logical = false;
    end

    methods (Access = public)
        function obj = Monitor(tg, signalName)
            obj.tg = tg;

            obj.instr = slrealtime.Instrument();
            obj.instr.AxesTimeSpan = 0.1;
            obj.instr.AxesTimeSpanOverrun = 'scroll';
            obj.instr.addSignal(signalName);
            obj.instr.connectCallback(@obj.append_to_buffer);
            obj.instr.validate(obj.tg.ModelStatus.Application);
            obj.tg.addInstrument(obj.instr);
        end

        function delete(obj)
            obj.tg.removeInstrument(obj.instr);
            delete(obj.instr);
        end

        function pause(obj)
            for i = 1:numel(obj)
                obj(i).update = false;
                obj(i).data_td_ = NaN(size(obj(i).data_td_));
                obj(i).psd_ = NaN(size(obj(i).psd_));
                obj(i).update_plots();
            end
        end

        function resume(obj)
            [obj.update] = deal(true);
        end

        function value = is_running(obj)
            value = [obj.update];
        end
    end

    methods (Access = private)
        function append_to_buffer(obj, ~, evt)
            if ~isvalid(obj)
                return;
            end
            if ~obj.update
                return;
            end

            ts = mode(diff(evt.AcquireGroupData.Time));
            ts = round(ts, 9);

            x_raw_ = cell2mat(evt.AcquireGroupData.Data);

            if width(x_raw_) ~= width(obj.data_td_) || any(isnan(obj.data_td_), 'all')
                obj.data_td_ = zeros(height(obj.data_td_), width(x_raw_));
            end

            n_buff = height(obj.data_td_);
            n_data = height(x_raw_);

            obj.t_ = 0 : ts : ts*(n_buff - 1);
            if n_data >= n_buff
                obj.data_td_ = x_raw_(end - n_buff + 1: end, :);
            else
                obj.data_td_ = [obj.data_td_(n_data + 1 : end, :); x_raw_];
            end

            obj.psd_ = pwelch(obj.data_td_, numel(obj.f_), [], obj.f_, 1/ts);

            obj.update_plots();
            pause(1e-3); % such that is does not fully occupy main thread
        end

        function update_plots(obj)
            obj.axes_td = obj.axes_td(isvalid(obj.axes_td));
            for j = 1:numel(obj.axes_td)
                n = width(obj.data_td_);
                if numel(obj.axes_td(j).Children) ~= n
                    plot(obj.axes_td(j), [0; 1], NaN(2, n));
                end
                for i = 1:n
                    set(obj.axes_td(j).Children(i), ...
                        {'XData', 'YData'}, ...
                        {obj.t_, obj.data_td_(:, end-i+1)});
                end
            end

            obj.axes_fd = obj.axes_fd(isvalid(obj.axes_fd));
            for j = 1:numel(obj.axes_fd)
                n = width(obj.psd_);
                if numel(obj.axes_fd(j).Children) ~= n
                    plot(obj.axes_fd(j), [0; 1], NaN(2, n));
                end
                for i = 1:n
                    set(obj.axes_fd(j).Children(i), ...
                        {'XData', 'YData'}, ...
                        {obj.f_, obj.psd_(:, end-i+1)});
                end
            end
        end
    end
end
