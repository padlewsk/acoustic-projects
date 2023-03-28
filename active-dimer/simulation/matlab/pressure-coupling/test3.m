close all
clear all

freq_samp =  40000; % must be at least equal to the cutoff frequency

N = 64;
t_0 = 0;    
t_1 = 1 ; %also in function of K
% number of cells
c0 = 347;
a = 0.28;

t = (t_0:1/freq_samp:t_1)'; % equal spacing required for FFT


Rms	= 0.261*0.2;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)

lambda_m = (-Rms - sqrt(Rms^2 - 4*Mms*Cmc))/(2*Mms); % m has biggest contribution
lambda_p = (-Rms + sqrt(Rms^2 - 4*Mms*Cmc))/(2*Mms); % m has biggest contribution
y = 1/(pi*(c0/a))*(exp(t*lambda_p) + exp(t*lambda_m)); %loss function (scaled)  DOES NOT WORK!




NFFT = numel(t);
Y = fft(y); %fft across the colomn
Y = abs(Y/NFFT); %two-sided spectrum 
Y = Y(1:NFFT/2+1,:); %single-sided spectrum 
Y(2:end-1,:) = 2*Y(2:end-1,:); % Double the amplitude to account for single-sided spectrum


freq = freq_samp*(0:(NFFT/2))/NFFT;



figure(1)
plot(t,y)

figure(2)
plot(freq,Y,'-')
title('spectrum');
xlabel('frequency');
ylabel('amplitude');
xlim([0 2000])
legend('Y')
