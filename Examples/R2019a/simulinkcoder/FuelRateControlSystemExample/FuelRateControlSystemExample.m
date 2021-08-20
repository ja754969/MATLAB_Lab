%% Air-Fuel Ratio Control System with Stateflow Charts 
% Generate code for an air-fuel ratio
% control system designed with Simulink(R) and Stateflow(R).

% Copyright 1994-2016 The MathWorks, Inc.

%%
% Figures 1, 2, and 3 show relevant portions of the sldemo_fuelsys model, a 
% closed-loop system containing a plant and controller.  The plant 
% validates the controller in simulation early in the design cycle.
% In this example, you generate code for the relevant controller
% subsystem, "fuel_rate_control".  Figure 1 shows the top-level simulation
% model.
%
% Open sldemo_fuelsys via rtwdemo_fuelsys and compile the diagram to 
% see the signal data types.

rtwdemo_fuelsys
sldemo_fuelsys([],[],[],'compile');
sldemo_fuelsys([],[],[],'term');

%%
% *Figure 1: Top-level model of the plant and controller*
%
% The air-fuel ratio control system is comprised of Simulink(R) and
% Stateflow(R). The control system is the portion of the model for which 
% you generate code.

open_system('sldemo_fuelsys/fuel_rate_control');

%%
% *Figure 2: The air-fuel ratio controller subsystem*
%
% The control logic is a Stateflow(R) chart that specifies the different
% modes of operation.

open_system('sldemo_fuelsys/fuel_rate_control/control_logic');

%%
% *Figure 3: Air-fuel rate controller logic*
%

%%
% Close these windows.
close_system('sldemo_fuelsys/fuel_rate_control/airflow_calc');
close_system('sldemo_fuelsys/fuel_rate_control/fuel_calc');
close_system('sldemo_fuelsys/fuel_rate_control/control_logic');
hDemo.rt=sfroot;hDemo.m=hDemo.rt.find('-isa','Simulink.BlockDiagram');
hDemo.c=hDemo.m.find('-isa','Stateflow.Chart','-and','Name','control_logic');
hDemo.c.visible=false;
close_system('sldemo_fuelsys/fuel_rate_control');

%% Configure and Build the Model with Simulink(R) Coder(TM)
% Simulink(R) Coder(TM) generates generic ANSI(R) C code for 
% Simulink(R) and Stateflow(R) models via the Generic Real-Time (GRT)
% target. You can configure a model for code generation programmatically.

rtwconfiguredemo('sldemo_fuelsys','GRT');

%%
% For this example, build only the air-fuel ratio control system.  Once
% the code generation process is complete, an HTML report detailing the generated
% code is displayed.  The main body of the code is located
% in fuel_rate_control.c.

rtwbuild('sldemo_fuelsys/fuel_rate_control');

%% Configure and Build the Model with Embedded Coder(R)
% Embedded Coder(R) generates production
% ANSI(R) C/C++ code via the Embedded Real-Time (ERT) target. You can configure a
% model for code generation programmatically. 

rtwconfiguredemo('sldemo_fuelsys','ERT');

%%
% Repeat the build process and inspect the generated code. In the Simulink(R) 
% Coder(TM) Report, you can navigate 
% to the relevant code segments interactively 
% by using the *Previous* and *Next* buttons. 
% From the chart context menu (right-click the Stateflow(R) block), 
% select *Code Generation > Navigate to Code*. Programmatically, 
% use the rtwtrace utility.

rtwbuild('sldemo_fuelsys/fuel_rate_control');
rtwtrace('sldemo_fuelsys/fuel_rate_control/control_logic')

%%
% View the air-fuel ratio control logic in the generated code.
rtwdemodbtype('fuel_rate_control_ert_rtw/fuel_rate_control.c',...
    '/* Function for Chart:','case IN_Warmup:',1,0);

%%
% Close the model and code generation report.
clear hDemo;
rtwdemoclean;
close_system('sldemo_fuelsys',0);

%% Related Examples
% For related fixed-point examples that use sldemo_fuelsys, see
%
% * *Fixed-point design* - <docid:fixedpoint_examples.example-fxpdemo_fuelsys_script Fixed-Point Fuel Rate Control System> 
% * *Fixed-point production C/C++ code generation* - <docid:simulinkcoder_examples.example-rtwdemo_fuelsys_fxp_script Air-Fuel Ratio Control System with Fixed-Point Data>
% 
