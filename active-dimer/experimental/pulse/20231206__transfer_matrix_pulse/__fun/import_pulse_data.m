function pulse = import_pulse_data(filename)
pulse = struct;
delimiterIn = '\t';
headerlinesIn = 84;
import  = importdata(filename ,delimiterIn, headerlinesIn);
data_raw = import.data;
pulse.freq = data_raw(:,2);
pulse.data = data_raw(:,3)+ 1i*data_raw(:,4); % [freq, complex double]
end
