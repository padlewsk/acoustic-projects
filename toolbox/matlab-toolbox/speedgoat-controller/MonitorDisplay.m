classdef MonitorDisplay < handle
    properties
        fig matlab.ui.Figure {mustBeScalarOrEmpty}
        monitor Monitor {mustBeScalarOrEmpty}
    end
    
    methods
        function obj = MonitorDisplay(mon, opts)
            arguments
                mon (1, 1) Monitor
                opts.name (1, :) char = 'Monitor'
                opts.show_psd (1, 1) logical = true;
            end

            obj.monitor = mon;
            obj.monitor.resume();

            obj.fig = uifigure( ...
                'Position', [100 100 640 480], ...
                'Name', opts.name, ...
                'CloseRequestFcn',  @(s, e) delete(obj));
            layout = uigridlayout(obj.fig, ...
                    'ColumnWidth', {'1x'}, ...
                    'RowHeight', {'1x', 'fit'});
            ax = uiaxes(layout);
            xlabel(ax, 'time [s]');
            ylabel(ax, 'amplitude [AU]');
            plot(ax, [0; 1], NaN(2, 2));
            grid(ax, 'on');
            mon.axes_td(end+1) = ax;
            if opts.show_psd
                layout.RowHeight = {'1x', '1x', 'fit'};
                ax = uiaxes(layout);
                xlabel(ax, 'frequency [Hz]');
                ylabel(ax, 'PSD [AU^2/Hz]');
                plot(ax, [0; 1], NaN(2, 2));
                grid(ax, 'on');
                mon.axes_fd(end+1) = ax;
            end
            uibutton(layout, 'state', ...
                'Text', 'Pause', ...
                'ValueChangedFcn', @(s, e) obj.btnValueChanged(s));
        end

        function delete(obj)
            delete(obj.monitor);
            delete(obj.fig);
        end
    end

    methods (Access = private)
        function btnValueChanged(obj, src)
            if src.Value
                obj.monitor.pause();
            else
                obj.monitor.resume();
            end
        end
    end
end

