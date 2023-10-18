clear all; clc;
%% 
% Note: This is not the completed code. It is intended for testing Malab's
%       'solve' function

%% 
eta = 0.95; %efficiency
kb = 2.18e-2; %must Change
n = 4;  %Reduction Ratio  

jArm = 0.0078;
T_ramp = 0.3;
T_fin = 0.5;
r = 1;
%% Call practive function
[W_cruise,T_ret,q_ret,a_ret] = practice(2.5,0,T_fin,r);

% 4 outputs are solved in symbolic form (sym), so 'double' function is used
W_cruise = double(W_cruise);
T_ret = double(T_ret);
q_ret = double(q_ret);
a_ret = double (a_ret);

% Run Simulink File
sim('throwingarmproject_2021a.slx', 3) 
 
