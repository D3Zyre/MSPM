function startup()
    %{
    adds the necessary subdirectories of MSPM to MATLAB's PATH
    so that functions and code files can be called
    %}
    addpath(...
        'enum',...
        'Helper Function',...
        'Saved Files',...
        'Geometry',...
        'MinorElements',...
        'MajorElements',...
        'Mechanical',...
        'Function - Turb Nusselt',...
        'Function - Turb Friction',...
        'Function - Discretization',...
        'GUI',...
        'Simulation',...
        'ListObjs',...
        'Motion',...
        genpath('Test_Running'),...
        'Relations',...
        'Optimization',...
        'Config Files'...
        );
    %     'Function - Turb Cond Enhancement',...
    %     'Function - Leakage',...
    %     'Function - Laminar Nusselt',...
    %     'Function - Laminar Friction',...
    %     'Function - Laminar Cond Enhancement',...
    %     'Function - Load Function',...
    
    % mex anyEq.c -largeArrayDims;
end