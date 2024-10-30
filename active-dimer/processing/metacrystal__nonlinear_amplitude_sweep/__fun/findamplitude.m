function [p_max,t,p] = findamplitude(data,t_min,t_max)
%finds and averages out amplitudes p of all 16 channels in 150 250 ms
%range

if nargin < 2
    t_min = 150e-3;
    t_max = 250e-3;
end

p = data.Variables;
p = p(:,1:size(p,2)); %already the absolute value
t = data.Time;
t = seconds(t);

t = t-t(1); %reset t_o = 0;
%t_cut_idx = logical((t<250e-3).*(t>=150e-3)); %
t_cut_idx = logical((t<t_max).*(t>=t_min)); %
t = t(t_cut_idx);
t = t-t(1); %reset t_o = 0;
p = p(t_cut_idx,:);

p_temp = islocalmax(p).*p;
p_temp(p_temp==0) = NaN; % replace the 0s by NaNs to correctly compute the mean
p_max = mean(p_temp,1,"omitnan");
%p_max = rms(p,1); % rms 

%figure
%plot(t,p(:,1))

end