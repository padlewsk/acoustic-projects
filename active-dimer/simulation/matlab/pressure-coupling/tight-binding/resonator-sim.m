clear all
close all


N = 64;
freq_samp =  40000;
t_0 = 0;    
t_1 = 0.25 ; %also in function of 

tspan = (t_0:1/freq_samp:(t_1-1/freq_samp))'; %

[t,beta] = ode45(@zop,tspan,[0; 1; 0; 1]); % tspan*0 + 
%beta = beta(:,2),;
%beta4 = beta(:,4);


gamma = (diff(beta)./diff(t));% this is the "finite difference" derivative. Note it is  one element shorter than y and x
td = (t(2:end) + t(1:(end-1)))/2; % this is to assign yd an abscissa midway between two subsequent x


NFFT = numel(t);
Y = fft(beta); %fft across the colomn
Y = abs(Y); %two-sided spectrum 
Y = Y(1:(NFFT/2+1),:); %single-sided spectrum 
Y(2:end-1,:) = 2*Y(2:end-1,:); % Double the amplitude to account for single-sided spectrum


freq = freq_samp*(0:(NFFT/2))/NFFT;

figure(1)
plot(t,beta,'-')
title('Solution of oscillator with ODE45');
xlabel('Time t');
ylabel('Solution y');
legend('y')


figure(2)
hold on
plot(freq,abs(Y),'-')
title('spectrum');
xlabel('frequency');
ylabel('amplitude');
xlim([0 2000])
legend('Y')

function dydt = zop(t,y)
    Rms	= 0.261*0.2;	% mechanical resistance
    Mms	= 6.670769e-04; % moving mass (kg)
    Cmc	= 2.128414e-04; % mechanical compliance (N/m)
    dydt = [y(2); -1/Mms*(Rms*y(2)+1/Cmc*y(1)); y(4); -1/Mms*(Rms*y(4)+1/Cmc*y(3))];
end
