function build_dir = create_build_dir(build_dir)
    % CREATE_BUILD_DIR sets the simulink build and cache folder on the
    % local drive (for speed)
    % * Build_dir:  absolute or relative build directory. If not specified,
    %               it is set to 'C:\Speedgoat\Build'.
    
    if ~exist('build_dir', 'var')
        build_dir = 'C:\Speedgoat\Build';
    end
    if ~exist(build_dir, 'dir')
        mkdir(build_dir);
    end
    set_param(0, 'CodegenFolder', build_dir);
    set_param(0, 'CacheFolder', build_dir);
    fprintf('### Build directory is now %s\n', build_dir);
end
