function [F,FUN] = onesideft(fun,fs,pad)
    %if nargin < 3
    %    pad =   3;
    %end
    NFFT = 2^(nextpow2(length(fun))+ pad); % n-point dft + padding
    Y = fft(fun,NFFT);
    Y = Y(1:NFFT/2+1);%1sided spectrum
    Y = abs(Y/length(fun)); %normalize to get amplitude
    Y(2:end-1) = 2*Y(2:end-1); %%% ???
    
    F =  fs*(0:(NFFT/2))/NFFT;
    FUN = Y;
    
end
