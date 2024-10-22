function [F,FUN] = twosideft(fun,fs,pad)
    %if nargin < 3
    %    pad =   3;
    %end
    NFFT = 2^(nextpow2(length(fun))+ pad); % n-point dft + padding
    Y = fft(fun,NFFT);
    Y = Y/length(fun); %normalize to get amplitude
    F = fs/NFFT*(-NFFT/2:NFFT/2-1);
    FUN = fftshift(Y);
    
end
