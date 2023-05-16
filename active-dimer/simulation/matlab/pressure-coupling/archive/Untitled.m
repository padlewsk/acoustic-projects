freq_samp =  40000; % must be at least equal to the cutoff frequency

N = 64;
t_0 = 0;    
t_1 = 1 ; %also in function of K
% number of cells
c0 = 347;
a = 0.28;

t = (t_0:1/freq_samp:t_1)'; % equal spacing required for FFT



%%% LOSS FUNCTION

Rms	= 0.261*0.02;	% mechanical resistance
Mms	= 6.670769e-04; % moving mass (kg)
Cmc	= 2.128414e-04; % mechanical compliance (N/m)

% [y(2); -1/Mms*(Rms*y(2)+1/Cmc*y(1))]
        
lambda_m = (-Rms - sqrt(Rms^2 - 4*Mms*(1/Cmc - Rms)))/(2*Mms); % m has biggest contribution
lambda_p = (-Rms + sqrt(Rms^2 - 4*Mms*(1/Cmc - Rms)))/(2*Mms);
gamma = pi*(c0/(a))*(Rms/2)*(exp(t*lambda_p) - exp(t*lambda_m));%Rms/2* loss function (scaled)

figure()
plot(t,-1i*gamma)