function [taskInfo, numtask, isDeploymentDiagram]=slrealtime_task_info()
   taskInfo(1).samplePeriod = 0.0001;
   taskInfo(1).sampleOffset = 0;
   taskInfo(1).taskPrio = 9;
   taskInfo(1).taskName = 'Task';
   taskInfo(1).entryPoints = {'SG__MDL:1536'};
   taskInfo(2).samplePeriod = 0.0001;
   taskInfo(2).sampleOffset = 0;
   taskInfo(2).taskPrio = 9;
   taskInfo(2).taskName = 'Task1';
   taskInfo(2).entryPoints = {'SG__MDL:1686'};
   taskInfo(3).samplePeriod = 0.0001;
   taskInfo(3).sampleOffset = 0;
   taskInfo(3).taskPrio = 9;
   taskInfo(3).taskName = 'Task2';
   taskInfo(3).entryPoints = {'SG__MDL:1690'};
   taskInfo(4).samplePeriod = 0.0001;
   taskInfo(4).sampleOffset = 0;
   taskInfo(4).taskPrio = 9;
   taskInfo(4).taskName = 'Task3';
   taskInfo(4).entryPoints = {'SG__MDL:1694'};
   taskInfo(5).samplePeriod = 0.0001;
   taskInfo(5).sampleOffset = 0;
   taskInfo(5).taskPrio = 9;
   taskInfo(5).taskName = 'Task4';
   taskInfo(5).entryPoints = {'SG__MDL:1708'};
   taskInfo(6).samplePeriod = 0.0001;
   taskInfo(6).sampleOffset = 0;
   taskInfo(6).taskPrio = 9;
   taskInfo(6).taskName = 'Task5';
   taskInfo(6).entryPoints = {'SG__MDL:1652'};
   numtask = 6;
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
