clear all; clc;
tic;
%% Electrical
eta = 0.95; %efficiency
kb = 2.18e-2; %must Change --> "motor constant"
n = 4;  %Reduction Ratio  

T_ramp = 0.1;
T_fin = 0.5;

jArm = 0.0078;
a_ret = -4;
q_ret = 1; % this value changes when practice function is called


%% Mechanical
% Sphere dimensions
radius_sphere = 0.01;

% Box and ball dimensions
radius_ball = 0.0315; 
box_length = 0.063;
box_breadth = 0.063;
box_height = 0.005;
box_height_s = 0.002;
base_length = 3.5;
base_breadth = 1;
base_height = 0.05;

%% Run Simulink
% % function [W_cruise2, T_ret2, q_ret2] = practice(Pos_fin_x1, Pos_fin_y1, T_fin1, r1, q_ret, a_ret)
des_pos = 0.3; % change this value for the desired position Meters
[W_cruise,T_ret,Vel_fin_y, limit_value] = practice(des_pos,0.0315,T_fin,0.14,q_ret,a_ret);
% q_ret;
W_cruise = double(W_cruise);
T_ret = double(T_ret);

Vel_fin_y = double(Vel_fin_y);

simOut = sim('throwingArmProjectIntegrate_2021a_chad.slx', 6); % 6 Seconds is the Maximum time to run, Can end preemptively when done
 
position = num2str(simOut.x_position.Data(end,:));  % changes position value to string to display
error = num2str(simOut.error.Data(end,:));
power = num2str(simOut.power_use.Data(end,:));
time = num2str(simOut.time.Data(end,:));
y_position_max = num2str(simOut.y_position_max.Data(end,:));
fprintf( '\n---------------- Results ---------------- \n')
fprintf(['X Landing Position of Ball (m): ', position, ' Meters \n']) % gets the data of x_position (defined in simulink) and the last value
fprintf(['Error X Landing Position of Ball (m): ', error, ' Meters \n']) % gets the data of x_position (defined in simulink) and the last value
fprintf(['Y Max Position of Ball (m): ', y_position_max, ' Meters \n']) % gets the data of x_position (defined in simulink) and the last value
fprintf(['Time taken for Simulation: ', time, ' Seconds \n']) % gets the data of x_position (defined in simulink) and the last value
fprintf(['Power Usage (W): ', power, ' Watts \n']) % gets the data of power (defined in simulink) and the last value
toc;

