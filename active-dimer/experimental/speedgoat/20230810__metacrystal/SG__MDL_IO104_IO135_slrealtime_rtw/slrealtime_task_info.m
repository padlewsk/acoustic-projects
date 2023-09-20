function [taskInfo, numtask, isDeploymentDiagram]=slrealtime_task_info()
   taskInfo(1).samplePeriod = 0.0001;
   taskInfo(1).sampleOffset = 0;
   taskInfo(1).taskPrio = 9;
   taskInfo(1).taskName = 'IO';
   taskInfo(1).entryPoints = {'SG__MDL_IO104_IO135:1381'};
   taskInfo(2).samplePeriod = 0.0001;
   taskInfo(2).sampleOffset = 0;
   taskInfo(2).taskPrio = 9;
   taskInfo(2).taskName = 'task3';
   taskInfo(2).entryPoints = {'SG__MDL_IO104_IO135:1883'};
   numtask = 2;
   for i = 1:numtask
      if ( 0 == isnumeric(taskInfo(i).samplePeriod) )
         taskInfo(i).samplePeriod = evalin('base', taskInfo(i).samplePeriod);
      end
      if ( isempty(taskInfo(i).taskName) )
         taskInfo(i).taskName = ['AutoGen' i ];
      end
   end
   isDeploymentDiagram = 1;
end 
