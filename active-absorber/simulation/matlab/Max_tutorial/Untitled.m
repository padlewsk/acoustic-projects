[b, a] = butter(2, 5, 's')

t = 0:0.01:50;
s = sin(2*pi*5*t);
s = rand(size(t));

out = sim('untitled_model');

figure;
plot(out.tout, out.x, 'DisplayName', 'x');
hold on;
plot(out.tout, out.y, 'DisplayName', 'y');

legend show

set_param('untitled_model/sub/myconst', 'Value', '3')


figure
tfestimate(out.x, out.y)

