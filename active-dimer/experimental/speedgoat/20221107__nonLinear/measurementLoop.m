%%% loop for many frequencies
%%% data{freq_idx} = [ch1, ch2, ch3, ch4]
%%% freq{freq_idx} = [frq, frq, frq, frq]
close; clear
addpath('__fun');
p = param_struct(); % is a structure with all of the parameter
p.use_cst = true;
p.tmax = 2;

p.beta = 10;

%% MEASUREMENT
freq_idx = 1; % source frequency
loop_freq_list = linspace(p.fi,p.ff,10); % measure at 10 frequencies between fi and ff.
for freq_idx = 1:numel(loop_freq_list)
    p.cst_freq = loop_freq_list(freq_idx);
    p.tmax = 2; % run for 2 seconds
    [data{freq_idx},time{freq_idx}] = SG__measure(p);
    freq_idx = freq_idx + 1;
end
%%% data{freq_idx} = [ch1, ch2, ch3, ch4]
%%% freq{freq_idx} = [frq, frq, frq, frq]

%% PROCESSING
%data{:} = data{:}(:,1);

num_extr = 1; %maximum numbers of extremas to find

freq_idx = 1; %index corresponding to the source frequency.
smpl_skip = 1*(round(p.fs_acq/p.fi)); %skip first oscillation

P1_temp = {};
nfft = {};
for freq_idx = 1:numel(loop_freq_list)
    %%% FFT
    nfft{freq_idx} = 2^(nextpow2(size(data{freq_idx},1))); % number of samples + more for zero epadding
    %nfft{freq_idx} = size(data{freq_idx},1); % number of samples 
    fftData{freq_idx} = fft(data{freq_idx}(smpl_skip:end,:),nfft{freq_idx}); % discrete fourier transform
    
    P2{freq_idx} = abs(fftData{freq_idx}/nfft{freq_idx}); % normalize to get the double-sided amplitude spectrum
    P1{freq_idx} = P2{freq_idx}(1:floor(nfft{freq_idx}/2+1),:); % get single-sided spectrum based on P2
    P1{freq_idx}(2:end-1) = P1{freq_idx}(2:end-1)*2; % amplitude is doubled
    
    freq = (p.fs_acq/nfft{freq_idx})*(0:nfft{freq_idx}/2)'.*ones(1,4);
    
    P1_temp{freq_idx} = P1{freq_idx};
    P1_temp{freq_idx}(freq(:, 1) <= loop_freq_list(freq_idx)- 10, :) = 0;
    
    %%% FIND LOCAL MAXIMAS
    
    local_max{freq_idx} = islocalmax(P1_temp{freq_idx},1,'MinSeparation',20,'MaxNumExtrema',num_extr);  %min seperation is at least 30 Hz
    end

%% FIGURES
clf

freq_idx = 4;
figure(1)
%%% TIME DOMAIN
    subplot(2,1,1);
    plot(time{freq_idx},data{freq_idx})
    xlim([0 5/loop_freq_list(freq_idx)])
    xlabel('Time [s]');
    ylabel('Amplitude (V)');
    legend("Ch1","Ch2","Ch3","Ch4")
    grid on

%%% FREQ DOMAIN
    subplot(2,1,2);
    plot(freq, P1{freq_idx}, freq(local_max{freq_idx}), P1{freq_idx}(local_max{freq_idx}),'r*')
    xlim([0 loop_freq_list(end)*1.1])
    xlabel('Frequency (Hz)');
    ylabel('Amplitude (V)');
    grid on

%%% FIRST HARMONICS
freq_idx = 1;
figure(2)
    clf
    hold on
    for freq_idx = 1:numel(loop_freq_list)
        P1_temp = P1{freq_idx}(local_max{freq_idx});
        freq_temp = freq(local_max{freq_idx});
        plot(freq_temp(1:(4*num_extr)), P1_temp(1:(4*num_extr)),'o')
        plot(freq_temp, P1_temp,'o')
        hold on
    end
    hold off
    xlim([0 loop_freq_list(end)*1.1])
    xlabel('Frequency (Hz)');
    ylabel('Amplitude (V)');
    grid on
    box on

    autoArrangeFigures()