function ax = plot_bode(varargin)
    % PLOT_BODE draws a bode-plot
    % plot_bode(ax, f_, H_)
    % plot_bode(f_, H_)
    % plot_bode(ax, f_, H_, linespec)
    % plot_bode(f_, H_, linespec)
    % * ax: axes on which to plot (zero, one or two elements)
    % * f_:         frequency vector in [Hz]
    % * H_:         response vector or numlti object
    % * linespec:   line specification (same as for plot functions)
    % Magnitude and phase are plot on the same axes if ax is single
    % element, or on separate axes if ax contains two elements.
    % Optionnal argument pairs:
    % * 'DisplayName':  name to display
    % * 'fUnit'         frequency units
    % * 'MagUnit        magnitude units
    % * 'PlotMag'       true/false to plot/hide magnitude
    % * 'PlotPhase'     true/false to plot/hide phase
    % * 'logx'          true/false for logarithmic/linear frequency axis
    % * 'logy'          true/false for logarithmic/linear magnitude axis
    % * 'unwrap'        true/false to (un)wrap phase
    % * 'ShowLegend'    true/false to show/hide legend
    % * 'Combined'      true/false to have combined/separate axes. Ignored
    %                   if ax argument is given.
    % * other           any other name-value pair supported by plot
    %                   functions
    
    assert(nargin >= 2, 'Not enough input arguments.');
    
    % default argument values
    disp_name = '';
    f_unit = '';
    mag_unit = '';
    flim = [];
    plot_mask = true(1, 2);
    logx = true;
    logy = true;
    unwrap_phase = false;
    show_legend = true;
    combined = false;
    linespec = '';
    opt_pairs = {};
    
    % get mandatory and leading optional parameters
    if all(ishandle(varargin{1}))
        assert(nargin >= 3, 'Not enough input arguments.');
        ax = varargin{1};
        f_ = varargin{2}(:);
        H_ = varargin{3};
        opt_start = 4;
    else
        ax = [];
        f_ = varargin{1}(:);
        H_ = varargin{2};
        opt_start = 3; % first optional argin
    end
    
    if mod(nargin - opt_start, 2) == 0
        linespec = varargin{opt_start};
        opt_start = opt_start + 1;
    end
    
    if isa(H_, 'numlti') && isscalar(H_)
        H_ = freqresp(H_, 2*pi*f_);
    end
    H_ = reshape(H_, size(f_));
    
    % get optional arguments pairs
    for i = opt_start:2:nargin
        switch lower(varargin{i})
            case 'displayname'
                disp_name = varargin{i+1};
            case 'funit'
                f_unit = varargin{i+1};
            case 'magunit'
                mag_unit = varargin{i+1};
            case 'flim'
                flim = varargin{i+1};
            case 'plotmag'
                plot_mask(1) = varargin{i+1};
            case 'plotphase'
                plot_mask(2) = varargin{i+1};
            case 'logx'
                logx = varargin{i+1};
            case 'logy'
                logy = varargin{i+1};
            case 'unwrap'
                unwrap_phase = varargin{i+1};
            case 'showlegend'
                show_legend = varargin{i+1};
            case 'combined'
                combined = varargin{i+1};
            otherwise
                opt_pairs = [opt_pairs, varargin(i:i+1)]; %#ok
        end
    end
    
    % Create axes if not specified
    if isempty(ax)
        if all(plot_mask) && ~combined
            ax = [subplot(2, 1, 1), subplot(2, 1, 2)];
        else
            ax = gca();
        end
    end
    
    if ~logx && ~logy
        plotFnMag = @plot;
        plotFnPhase = @plot;
    elseif logx && ~logy
        plotFnMag = @semilogx;
        plotFnPhase = @semilogx;
    elseif ~logx && logy
        plotFnMag = @semilogy;
        plotFnPhase = @plot;
    else
        plotFnMag = @loglog;
        plotFnPhase = @semilogx;
    end
    
    
    % to manually update colors
    col_ord = get(ax(1), 'defaultAxesColorOrder');
    idx = max(ax.ColorOrderIndex);
    col = col_ord(idx, :);
    
    % plot magnitude
    if plot_mask(1)
        if all(plot_mask) && numel(ax) == 1
            yyaxis(ax, 'left');
        end
        plotFnMag(ax(1), f_, abs(H_), linespec, ...
            'DisplayName', disp_name, ...
            'Color', col, ...
            opt_pairs{:});
        hold(ax(1), 'on');
        ylabel(ax(1), sprintf('mag. %s', mag_unit));
    end
    
    % plot phase
    if plot_mask(2)
        if unwrap_phase
            phi_ = rad2deg(unwrap(angle(H_)));
        else
            phi_ = rad2deg(angle(H_));
        end
        if all(plot_mask) && numel(ax) == 1
            yyaxis(ax, 'right');
        end
        h = plotFnPhase(ax(end), f_, phi_, linespec, ...
            'DisplayName', disp_name, ...
            'Color', col, ...
            opt_pairs{:});
        hold(ax(end), 'on');
        ylabel(ax(end), 'phase (deg)');
        if all(plot_mask) && numel(ax) == 1
            yyaxis(ax, 'left'); % back to left axis (for zoom and others...)
            h.HandleVisibility = 'off';
            h.LineStyle = '--';
        end
    end
    
    % cosmetics
    for ax_elem = ax
        if show_legend
            legend(ax_elem, 'show');
        else
            legend(ax_elem, 'hide');
        end
    end
    set(vertcat(ax.YAxis), 'Color', 'k')
    xlabel(ax, sprintf('freq %s', f_unit));
    set(ax, 'ColorOrderIndex', 1 + mod(idx, size(col_ord, 1))); % manually cylce through colors
    grid(ax, 'off'); % so that minor cannot disable
    grid(ax, 'on');
    grid(ax, 'minor');
    if ~isempty(flim)
        xlim(ax, flim);
    end
    if numel(ax) == 2
        linkaxes(ax, 'x');
    end
end
