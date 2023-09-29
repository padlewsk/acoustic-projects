function [taskInfo, numtask, isDeploymentDiagram]=slrealtime_task_info()
   taskInfo(1).samplePeriod = 0.0001;
   taskInfo(1).sampleOffset = 0;
   taskInfo(1).taskPrio = 9;
   taskInfo(1).taskName = 'Model1_500us';
   taskInfo(1).entryPoints = {'ref_main_model_R2022b:1'};
   taskInfo(2).samplePeriod = 0.0001;
   taskInfo(2).sampleOffset = 0;
   taskInfo(2).taskPrio = 9;
   taskInfo(2).taskName = 'Model2_500us';
   taskInfo(2).entryPoints = {'ref_main_model_R2022b:2'};
   taskInfo(3).samplePeriod = 0.0001;
   taskInfo(3).sampleOffset = 0;
   taskInfo(3).taskPrio = 9;
   taskInfo(3).taskName = 'Model3_400us';
   taskInfo(3).entryPoints = {'ref_main_model_R2022b:19'};
   taskInfo(4).samplePeriod = 0.0001;
   taskInfo(4).sampleOffset = 0;
   taskInfo(4).taskPrio = 9;
   taskInfo(4).taskName = 'Model4_400us';
   taskInfo(4).entryPoints = {'ref_main_model_R2022b:20'};
   numtask = 4;
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
