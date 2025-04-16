close all
clear all

%load('./non_reciprocal_pulse.mat');
%load('./topo_dynamic_sweep.mat')
%load('./topo_static.mat')
load('./BW.mat')
% Assuming your timetable is named 'audioTimetable' and has 16 channels
% Extract channel 1 and channel 2
channel_L = signal_control_raw.("data.p11");
channel_R = signal_control_raw.("data.p42");
sample_rate = round(signal_control_raw.Properties.SampleRate);


% Calculate the number of samples for 5 seconds
numSamples = 10 * sample_rate;

% Extract the first 5 seconds of audio data
channel_L = channel_L(1:numSamples);
channel_R = channel_R(1:numSamples);


% Combine channel 1 and channel 2 into a stereo signal
stereoSignal = [channel_L, channel_R];


% Play the stereo signal
sound(stereoSignal, sample_rate);


%% Export to MP3
%
filename = './white_noise.mp3';
audiowrite(filename, stereoSignal, 16000);
%}