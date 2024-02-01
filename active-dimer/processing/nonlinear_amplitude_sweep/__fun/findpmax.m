function [p_max,t,p] = findpmax(data)
%finds local maximum of all 16 channels between 700 and 800 ms

p = data.Variables;
p = p(:,1:16); 
t = data.Time;
t = seconds(t);

t = t-t(1); %reset t_o = 0;
t_cut_idx = logical((t<250e-3).*(t>=150e-3)); %
t = t(t_cut_idx);
t = t-t(1); %reset t_o = 0;
p = p(t_cut_idx,:);

p_temp = islocalmax(p).*p;
p_temp(p_temp==0) = NaN; % replace the 0s by NaNs to correctly compute the mean
p_max = mean(p_temp,1,"omitnan");

%figure
%plot(t,p(:,1))

end