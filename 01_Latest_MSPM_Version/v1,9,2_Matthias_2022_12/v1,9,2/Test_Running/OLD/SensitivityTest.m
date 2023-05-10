function [runs] = SensitivityTest()
% title: String: Filename under which the test data will be saved
% simTime: double: Maximum simulation time over which the model will run
% SS: logical:  True/False on whether or not the model will stop on steady state
% movement_option: character: 'C' Continuous, 'V' Variable Speed
% rpm: Starting speed in RPMS
% max_dt = maximum timestep used by the model
% SourceTemp = Source Temperature assigned to model
% SinkTemp = Sink Temperature assigned to model
% EnginePressure = Pressure assigned to internal gas zones

%% Default parameters
runs(15) = struct(...
  'Model','EP_1 0,09 DP e0 PP e0 - DV',...
  'title','',...
  'simTime',4000,... [s]
  'SS',true,...
  'movement_option','C',...
  'rpm',120,... [rpm]
  'max_dt',0.1,... [s]
	'SourceTemp',90 - 2 + 273.15,... [K]
  'SinkTemp',5 + 2 + 273.15,... [K]
  'EnginePressure',101325, ...
  'HX_Convection', 1, ...
  'Regen_Convection', 1, ...
  'Outside_Matrix_Convection', 1, ...
  'Friction', 1, ...
  'Solid_Conduction', 1, ...
  'Axial_Mixing_Coefficient', 1, ...
  'NodeFactor', double(1.0));

for i = 1:length(runs)
  runs(i) = runs(end);
end

variations = [0.50 1.5];
HX_Convection = ones(26,1); HX_Convection(2:3) = variations;
Regen_Convection = ones(26,1); Regen_Convection(4:5) = variations;
Outside_Matrix_Convection = ones(26,1); Outside_Matrix_Convection(6:7) = variations;
Friction = ones(26,1); Friction(8:9) = variations;
Solid_Conduction = ones(26,1); Solid_Conduction(10:11) = variations;
Axial_Mixing_Coefficient  = ones(26,1); Axial_Mixing_Coefficient(12:13) = variations;
NodeFactor = ones(26,1); NodeFactor(14:15) = variations;


runs(1).title = ['Baselines Sensitivity - ' num2str(runs(1).rpm) ' Hz'];

for i = 2:length(runs)
  runs(i).title = ['Sensitivity - ' num2str(runs(i).rpm) ...
    'Hz hHX- ' num2str(runs(i).HX_Convection.*HX_Convection(i-1)) ...
    ' hR- ' num2str(Regen_Convection(i-1)) ...
    ' hO- ' num2str(Outside_Matrix_Convection(i-1)) ...
    ' FR- ' num2str(Friction(i-1)) ...
    ' kS- ' num2str(Solid_Conduction(i-1)) ...
    ' Nk- ' num2str(Axial_Mixing_Coefficient(i-1)) ...
    ' NF- ' num2str(runs(i).NodeFactor.*NodeFactor(i-1))];
  runs(i).HX_Convection = runs(i).HX_Convection.*HX_Convection(i-1);
  runs(i).Regen_Convection = Regen_Convection(i-1);
  runs(i).Outside_Matrix_Convection = Outside_Matrix_Convection(i-1);
  runs(i).Friction = Friction(i-1);
  runs(i).Solid_Conduction = Solid_Conduction(i-1);
  runs(i).Axial_Mixing_Coefficient = Axial_Mixing_Coefficient(i-1);
  runs(i).NodeFactor = NodeFactor(i-1);
end
% 
% runs(end+1:end+length(runs)) = runs;
% for j = 16:length(runs)
%     runs(j).rpm = 120;
%     i = j - 15;
%     runs(j).title = ['Sensitivity - ' num2str(runs(j).rpm) ...
%     'Hz hHX- ' num2str(HX_Convection(i)) ...
%     ' hR- ' num2str(Regen_Convection(i)) ...
%     ' hO- ' num2str(Outside_Matrix_Convection(i)) ...
%     ' FR- ' num2str(Friction(i)) ...
%     ' kS- ' num2str(Solid_Conduction(i)) ...
%     ' Nk- ' num2str(Axial_Mixing_Coefficient(i)) ...
%     ' NF- ' num2str(NodeFactor(i))];
% end
runs(1:12) = [];