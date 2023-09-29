ts = 400e-6;   
tg = slrealtime;
slbuild('SG__MDL');

tg.load('SG__MDL');
tg.setStopTime(1);

% Run Profiler and get profiler data
startProfiler(tg);
tg.start;
pause(1)
stopProfiler(tg);
profiler_data_single = getProfilerData(tg)



