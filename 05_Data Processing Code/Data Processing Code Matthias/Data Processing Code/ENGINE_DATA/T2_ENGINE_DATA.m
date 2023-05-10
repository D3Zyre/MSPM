function ENGINE_DATA = T2_ENGINE_DATA

% This function will define a structure that describes the geometric data, 
% operating conditions, and working fluid properties for the engine.

% The values in this particular script correspond to the original displacer
% diameter, and the identical heater and cooler.

%% Drive Mechanism:
% Engine Type
ENGINE_DATA.engine_type = 'x'; % x --> Gamma slider crank

% Link 1 (Base)
ENGINE_DATA.Pr1 = 0; % Desaxe offset of piston in (m).
ENGINE_DATA.Dr1 = 0; % Desaxe offset of displacer in (m).

% Link 2 (Crank)
ENGINE_DATA.Pr2 = 0.0375 ; %[m] Piston crank throw radius (half stroke)
ENGINE_DATA.Dr2 = 0.0375; %[m] Displacer crank throw radius
ENGINE_DATA.Cb = -0.01599; % Distance from output shaft to crank center of mass (m)
ENGINE_DATA.Cphi = 0; % Angle between Cb line and center line of crank (radians)
ENGINE_DATA.Cm = 2.57134; % Mass of crank (kg). Entire crankshaft assembly. Sans flywheel assembly since the flywheel center of mass doesn't move.
ENGINE_DATA.CIG = 0.00966444; % Moment of inertia of crank about the axis of rotation (kg*m^2)

% Link 3 (Connecting Rod for Piston)
ENGINE_DATA.Pr3 = 0.146; % Center to center distance of con rod (m).
ENGINE_DATA.PRb = 0.06932; % Distance from wrist pin to con rod center of mass (m).
ENGINE_DATA.PRphi = 0; % Angle b/w Rb line and center line of con rod (radians)
ENGINE_DATA.PRm = 0.238; % Mass of connecting rod (kg)
ENGINE_DATA.PRIG = 0.00049283; % Moment of inertia about center of mass (kg*m^2)

% Link 4 (Piston)
ENGINE_DATA.Pm = 0.788; % Mass of piston in (kg)(Piston + Wrist Pin + Bushing + Snap Rings) ADD MASS OF SEALS AND WEAR RINGS!!
ENGINE_DATA.Pbore = 0.08573 ; %[m]

% Link 5 (Connecting Rods for Displacer)
ENGINE_DATA.Dr3 = 0.130; % Center to center distance of con rod (m).
ENGINE_DATA.DRb = 0.07294; % Distance from wrist pin to con rod center of mass (m).
ENGINE_DATA.DRphi = 0; % Angle b/w Rb line and center line of con rod (radians)
ENGINE_DATA.DRm = 2*0.130; % Mass of connecting rod (kg)
ENGINE_DATA.DRIG = 2*0.00017865; % Moment of inertia about center of mass (kg*m^2)

% Link 6 (Displacer)
ENGINE_DATA.Dm = 1.858; % Mass of displacer in (kg)(Displacer Body, Displacer Base ASM, and Crossheads)
ENGINE_DATA.Dbore = 0.200; %[m]

% Crankshaft Axial Geometry
ENGINE_DATA.LCB2 = 0.07335; % Distance b/w large and small crankshaft bearings (m)
ENGINE_DATA.LPR = 0.05131; % Distance b/w large crankshaft bearing and center of power con rod bearing (m)

% Flywheel
ENGINE_DATA.FIG = 0.06237836; %(kg*m^2) Moment of inertia of the flywheel assembly about the axis of rotation.

%% Volumes: DISPLACER ROD SHOULD BE ADDED TO VOLUME VARIATIONS
% Total Dead Volume
ENGINE_DATA.Vdead = 1831.788987/1e6; %[m^3]

% Power Piston Clearance Volume for Gamma Engines
% --> Includes the Cyl Head, Con Pipe, Disp Mount, and clearance disk in this case.
ENGINE_DATA.Vclp = 170.6/1e6; %[m^3]

% Power Piston Swept Volume for Sinusoidal Gammas (and Schmidt analysis)
ENGINE_DATA.Vswp = ENGINE_DATA.Pr2*(pi/4)*ENGINE_DATA.Pbore^2; %[m^3]

% Total Displacer Clearance Volume (above, below, annular, and appendix gap) for Gammas
ENGINE_DATA.Vcld_bottom = (pi/4)*(ENGINE_DATA.Dbore^2)*0.001+... % 1mm clearance of displacer
    0.01215*(pi/4)*(0.207^2-ENGINE_DATA.Dbore^2); % Heat exchanger annular space
ENGINE_DATA.Vcld_top = pi/4*(ENGINE_DATA.Dbore^2)*0.001+... % 1mm clearance
    0.01215*(pi/4)*((0.207^2)-(ENGINE_DATA.Dbore^2))+... % Heat exchanger annular space
    (pi/4)*((ENGINE_DATA.Dbore^2)-(0.198^2))*0.1404; % Appendix gap

% Displacer Swept Volume for Sinusoidal Gammas (and Schmidt analysis)
ENGINE_DATA.Vswd = ENGINE_DATA.Dr2*(pi/4)*ENGINE_DATA.Dbore^2; %[m^3]

% Displacer Phase Angle Advance for Gamma
ENGINE_DATA.beta_deg = 90.0; %[deg]

% Displacer Drive Rod Volume
ENGINE_DATA.d_disprod = 0.012; %(m) Diameter of the displacer rod.
ENGINE_DATA.V_disprod_min = ((ENGINE_DATA.d_disprod)^2)*(pi/4)*0.001; %(m^3) Minimum volume of the displacer rod in the working space. 1 mm clearance.

%% Cooler:
% Cooler Type
% p --> smooth pipes
% a --> smooth annulus
% s --> slots
ENGINE_DATA.cooler_type = 's';

% Cooler Slot Width for Slot Cooler (circumferential direction)
ENGINE_DATA.cooler_slot_width = 1.00e-03; %[m]

% Cooler Slot Height for Slot Cooler (radial direction)
ENGINE_DATA.cooler_slot_height = 2.00e-02; %[m]

% Cooler Heat Exchanger Length (flow direction)
ENGINE_DATA.cooler_length = 9.600e-02; %[m]

% Cooler Number of Slots
ENGINE_DATA.cooler_num_slots = 289; %[m]

% Hydraulic Diameter [m]
ENGINE_DATA.cooler_D_h = 2*ENGINE_DATA.cooler_slot_width / (1 + ENGINE_DATA.cooler_slot_width/ENGINE_DATA.cooler_slot_height);

ENGINE_DATA.cooler_A_cross = 5749e-6;
%% Regenerator:
% Regenerator Configuration
% t --> tubular regenerator
% a --> annular regenerator
ENGINE_DATA.regen_config = 'a';

% Regen Housing I.D. for Annular Regenerator
ENGINE_DATA.regen_housing_ID = 0.247; %[m]

% Matrix I.D. for Annular Regenerator
ENGINE_DATA.regen_matrix_ID = 0.207; %[m]

% Regenerator Length
ENGINE_DATA.regen_length = 0.0254; %[m]

% Regenerator Number of Tubes
ENGINE_DATA.regen_num_tubes = 1;

% Regenerator Matrix Type
% m --> mesh
% f --> foil
% n --> no matrix
ENGINE_DATA.regen_matrix_type = 'm';

% Matrix Porosity for Mesh Matrix
ENGINE_DATA.regen_matrix_porosity = 0.96;

% Matrix Wire Diameter for Mesh Matrix
ENGINE_DATA.regen_wire_diameter = 0.0001; %[m]
% ENGINE_DATA.regen_wire_diameter = 5.08e-05; %[m] (Connor)

%% Heater:
% Heater Type
% p --> smooth pipes
% a --> smooth annulus
% s --> slots
ENGINE_DATA.heater_type = 's';

% Heater Slot Width for Slot Heater (circumferential direction)
ENGINE_DATA.heater_slot_width = ENGINE_DATA.cooler_slot_width; %[m]

% Heater Slot Height for Slot Heater (radial direction)
ENGINE_DATA.heater_slot_height = ENGINE_DATA.cooler_slot_height; %[m]

% Heater Heat Exchanger Length (flow direction)
ENGINE_DATA.heater_length = ENGINE_DATA.cooler_length; %[m]

% Heater Number of Slots for Slot Heater
ENGINE_DATA.heater_num_slots = ENGINE_DATA.cooler_num_slots;

ENGINE_DATA.heater_D_h = ENGINE_DATA.cooler_D_h;

%% Operating Conditions:
% Working Fluid
% hy --> hydrogen
% he --> helium
% ai --> air
ENGINE_DATA.gas_type = 'ai';

% Mean Pressure
ENGINE_DATA.pmean = 1000000.0; %[Pa]  (= 10 bar)

% Cold Sink Temperature
ENGINE_DATA.Tsink = 5 + 273.15; %[K]

% Cooler Gas Temperature
ENGINE_DATA.Tgk = 21 + 273.15; %[K]

% Cooler Wall Temperature
ENGINE_DATA.Twk = 21 + 273.15; %[K]

% Compression Space Temperature
ENGINE_DATA.Tgc = 21 + 273.15; %[K]

% Hot Source Temperature
ENGINE_DATA.Tsource = 273 + 150; %[K]

% Heater Gas Temperature
ENGINE_DATA.Tgh = 273 + 130; %[K]

% Heater Wall Temperature
ENGINE_DATA.Twh = 273 + 130; %[K]

% Expansion Space Temperature
ENGINE_DATA.Tge = 273 + 130; %[K]

% Operating Frequency
ENGINE_DATA.freq = 2; %[Hz]

%% Cooling System
% ENGINE_DATA.c_coolant = 4184; % Specific heat capacity of water in [J/kgK]
% ENGINE_DATA.dens_coolant = 1000; % Water density [kg/m^3]
ENGINE_DATA.c_coolant = 3118.57; %(J/kgK) - for 50% ethylene glycol water mix at 10 deg C
ENGINE_DATA.dens_coolant = 1101.12; %(kg/m^3) - for 50% ethylene glycol water mix at 10 deg C

%% Heating System
% ENGINE_DATA.c_hot_liquid = 4184; % Specific heat capacity of water in [J/kgK]
% ENGINE_DATA.dens_hot_liquid = 1000; % Water density [kg/m^3]
ENGINE_DATA.c_hot_liquid = 1510; %(J/kgK) - for SIL 180 at 20 deg C
ENGINE_DATA.dens_hot_liquid = 930; %(kg/m^3) - for SIL 180 at 20 deg C

%% Data for Engine Specific Loss Calculations:
% Maximum volume of the buffer space
% Volume of crankcase extension has been added
% Matthias from Solidworks (300mm extension)
ENGINE_DATA.V_buffer_max = 0.007312332;
% Connor (460mm extension)
% ENGINE_DATA.V_buffer_max = 0.0032 + (0.460*(pi/4)*(0.1282^2)); %[m^3]

% Constant mechanism effectiveness
ENGINE_DATA.effect = 0.8; % [unitless]

% Configuration code for GSH calculation
ENGINE_DATA.GSH_config = 1; % Big CC extension
