function [RunConditions] = Extreme_Tests()
    RunConditions(6) = struct(...
      'Model','Beta_2,5atm_3Hz_9in_95C_5C_18DP - Optimized',...
      'title','',...
      'simTime',60,... [s]
      'SS',true,...
      'movement_option','C',...
      'rpm',60,... [rpm]
      'max_dt',0.1,... [s]
      'SourceTemp',150 + 273.15,... [K]
      'SinkTemp',5 + 273.15,... [K]
      'EnginePressure',101325*10,...
      'NodeFactor',1,...
      'Uniform_Scale',1,...
      'HX_Convection', 1);
      %'PressureBounds',[101325 10*101325],...
      %'SpeedBounds',[20 1000]);
   for i = 1:6
       RunConditions(i) = RunConditions(end);
   end
   rpm = [0.5, 1, 2, 3, 4, 5];
   for i = 1:5
       RunConditions(i).rpm = rpm(i)*60;
       RunConditions(i).title = ['Stress Test 9in, rpm- ' num2str(rpm(i))];
   end
end

