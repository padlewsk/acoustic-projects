function sig = get_signals(tg, signal_names)
    % GET_SIGNALS acquires some signals from the target computer
    % This function does not work with bus signals (only vector signals of
    % one or more elements). This function will also delete the SDI run
    % after it has been imported.
    % tg:           target object from which to import the signals
    % signal_names: string array containing the names of the signals to
    %               import.

    arguments
        tg (1, 1) slrealtime.Target
        signal_names (1, :) string
    end

    run_info = get_filelog_entry(tg);
    assert(~isempty(run_info), 'No valid entry to import in the FileLog.');
    if run_info.Size == 0
        warning('FileLog is empty.');
    end

    % get all the currently acquired runs. The set difference between all
    % runs ids before and after import will give which run is the one
    % corresponding to the import.
    run_id = Simulink.sdi.getAllRunIDs();

    % check if the target is currently recording. FileLog cannot be
    % imported while the target is running.
    try
        % if stopRecoding doesn't throw an error, it was indeed recoding.
        % Note that if the target was started with 'AutoImportFileLog' set
        % to true (default behavior) tg.stopRecording will import the
        % FileLog automatically.
        tg.stopRecording();
        is_recording = true;
    catch me %#ok<NASGU>
        % stopRecodging threw an error meaning it was already not
        % recording.
        is_recording = false;
    end

    try
        if numel(run_id) == Simulink.sdi.getRunCount()
            % import filelog: it was not automatically imported when
            % tg.stopRecording was called.
            tg.FileLog.import(run_info);
        end

        % find the new run id (imported one) and get its reference
        run_id = setdiff(Simulink.sdi.getAllRunIDs(), run_id);
        run_ref = Simulink.sdi.getRun(run_id);

        % export its data (and delete it)
        sig = export_signals(run_ref, signal_names);
        % Simulink.sdi.deleteRun(run_ref.id);

        % resume recording if it was recording before the import
        if is_recording
            tg.startRecording();
        end
    catch me
        % if something went wrong, resume recording anyway if it was before
        % the import/error
        if is_recording
            tg.startRecording();
        end

        % rethrow the error anyway so the user knows what went wrong
        rethrow(me);
    end
end

function run_info = get_filelog_entry(tg)
    % GET_FILELOG_ENTRY gets the last filelog entry of the currently
    % running or last run application.

    run_info = tg.FileLog.list();
    if isempty(run_info)
        return;
    end

    % Keep only the correct model entries
    mask = strcmpi(run_info.Application, tg.ModelStatus.Application);
    run_info = run_info(mask, :);

    % Take the most recently started one (can happen if multiple FileLogs
    % are allowed).
    [~, idx] = max([run_info.StartDate]);
    run_info = run_info(idx, :);
end

function data = export_signals(run_ref, signal_names)
    % EXPORT_SIGNALS exports the signals from run_ref to a timetable
    % run_ref:      reference to the run containing the signals
    % signal_names: string array of the names of the signals to export

    sig_ref = arrayfun(@run_ref.getSignalsByName, signal_names, 'UniformOutput', false);
    assert(all(cellfun(@isscalar, sig_ref)), ...
        'Signal names must all exist and be unique');
    sig_ref = [sig_ref{:}];

    data = arrayfun(@export, sig_ref, 'UniformOutput', false);
    assert(all(cellfun(@(x) isa(x, 'timeseries'), data)), ...
        'Bus signals are not supported');
    data = [data{:}]; % convert to array (they all have same class)

    if all([data.Length] == 0)
        data = timetable.empty();
    else
        data = timeseries2timetable(data);
    end
end
