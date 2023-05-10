function [runs] = MeshIndependencyTest()
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
% NF = [ 0.5 1.0 2.0 4.0];
% NFTXT = { '0,5', '1,0', '2,0', '4,0' };
% NF = [0.5 1.0 2.0 4.0 8.0 16.0 32.0];
% NFTXT = {'0,5', '1,0', '2,0', '4,0', '8,0', '16,0', '32,0'};
NF = [16.0 32.0];
NFTXT = {'16,0', '32,0'};
% NF = [4.0 6.0 8.0 10.0];
% NFTXT = {'4,0','6,0','8,0','10,0'};
runs(length(NF)) = struct(...
  'Model','EP_1 0,09 DP e0 PP e0 - Clean',...
  'title','',...
  'simTime',40,... [s]
  'SS',true,...
  'movement_option','C',...
  'rpm',60,... [rpm]
  'max_dt',0.1,... [s]
	'SourceTemp',95 + 273.15,... [K]
  'SinkTemp',5 + 273.15,... [K]
  'EnginePressure',101325,...
  'NodeFactor',1);
for i = 1:length(runs)-1
  runs(i) = runs(end);
end

for i = 1:length(NF)
  runs(i).NodeFactor = NF(i);
  runs(i).title = ['EP_1 0,09 DP e0 PP e0 - ' NFTXT{i} 'x'];
end

tests = Test_set_EP1();
for i = 1:length(tests)
  runs(end+1) = tests(i);
end
end


