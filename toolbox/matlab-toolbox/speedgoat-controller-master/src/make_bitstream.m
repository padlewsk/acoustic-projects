function make_bitstream(basename)
    % MAKE_BITSTREAM calls <basename>_hdlworflow.m to generate bistreams
    arguments
        basename (1, :) char
    end

    %% Simulink models and blocks names
    hdl_script = [basename, '_hdlworkflow']; % hfl workflow script to call
    mdl_src = [basename, '_src']; % simulink source file
    mdl_gm = ['gm_', mdl_src, '_slrt']; % generatef simulink file
    blk_gm = [mdl_gm, '/', basename, '_FPGA']; % generated block in mdl_gm
    mdl_lib = 'SG_library'; % simulink library to update
    blk_lib = [mdl_lib, '/Built elements/private/' basename, '_FPGA'];

    %% Build
    t1 = tic;
    fprintf('### Process started on %s.\n', char(datetime('now')));
    create_build_dir;
    eval(hdl_script);
    if strcmpi(get_param(mdl_src, 'shown'), 'off')
        % if system GUI is not shown, close it
        close_system(mdl_src, 0);
    end
    fprintf('### Process finished on %s (elapsed: %s).\n', ...
        char(datetime('now')), char(seconds(toc(t1))));

    %% Add generated block to the library
    fprintf('Adding generated block to library %s...\n', mdl_lib);
    load_system(mdl_lib);
    set_param(mdl_lib, 'Lock', 'off');
    if getSimulinkBlockHandle(blk_lib) == -1
        % block not present in the library
        add_block(blk_gm, blk_lib);
    else
        % previous version of the block already present in the library
        delete_block(blk_lib);
        add_block(blk_gm, blk_lib);
    end
    set_param(mdl_lib, 'Lock', 'off');
    save_system(mdl_lib);
    close_system(mdl_lib);
    close_system(mdl_gm, 0);
    fprintf('\t[DONE]\n');

    %% Close remaining open systems
    fprintf('Closing remaining systems...\n');
    while ~isempty(gcs)
        fprintf('\tClosing ''%s''...\n', gcs);
        close_system(gcs, 0)
    end
    fprintf('\t[DONE]\n');
end
