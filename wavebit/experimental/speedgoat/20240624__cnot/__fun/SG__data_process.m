function data_struct = SG__data_process(data)
%SG__SAVE Summary of this function goes here
%   Detailed explanation goes here
    addpath('__fun');
    p = param_struct();
    
    % average the time data wrt nyquist frequency
    %{
    freq_nyquist = 3*params.freq_fin; % over 2 to be safe...
    mean_window = 3;%floor(params.fs_log/freq_nyquist);
    data = movmean(data,mean_window); %cf 20231122__experiment
    %}

    H21 = [];               
    H31 = [];
    H41 = [];
    
    C21 = [];% coherence 
    C31 = [];% coherence
    C41 = [];% coherence  

    %{
    load('C:\Speedgoat\temp\signal_control_raw_a.mat');  %%%%
    data = signal_control_raw.Variables;
    tic
    [H21,F] = tfestimate(data(:,1), data(:,2), p.wind, [], p.freq, p.fs_log);
    [H31,F] = tfestimate(data(:,1), data(:,3), p.wind, [], p.freq, p.fs_log);
    [H41,F] = tfestimate(data(:,1), data(:,4), p.wind, [], p.freq, p.fs_log);
     
    [C21,F] = mscohere(data(:,1), data(:,2), p.wind, [], p.freq, p.fs_log);
    [C31,F] = mscohere(data(:,1), data(:,3), p.wind, [], p.freq, p.fs_log);
    [C41,F] = mscohere(data(:,1), data(:,4), p.wind, [], p.freq, p.fs_log);
    toc
    %}

    tic
    [H21,freq] = tfestimate(data(:,1), data(:,2), p.wind, [], [], p.fs_log);
    [H31,freq] = tfestimate(data(:,1), data(:,3), p.wind, [], [], p.fs_log);
    [H41,freq] = tfestimate(data(:,1), data(:,4), p.wind, [], [], p.fs_log);
     
    [C21,freq] = mscohere(data(:,1), data(:,2), p.wind, [], [], p.fs_log);
    [C31,freq] = mscohere(data(:,1), data(:,3), p.wind, [], [], p.fs_log);
    [C41,freq] = mscohere(data(:,1), data(:,4), p.wind, [], [], p.fs_log);
    toc
    %data_struct = struct;

    data_struct.H21 = H21;
    data_struct.H31 = H31;
    data_struct.H41 = H41;

    data_struct.C21 = C21;
    data_struct.C31 = C31;
    data_struct.C41 = C41;

    data_struct.freq = freq;
end
