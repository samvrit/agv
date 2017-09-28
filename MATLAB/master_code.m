% % % ENSE 623 Project - AGV System Simulation
% % % 
% % % Master Code

clc
clear


% Delivery Node

lambda_D = 100; 

mean_load_DS = 10;      % 10 units
agv_speed = 5.4;        % based on Otto (km/hr)
n_DS = 1;               % No. of AGVs 
d_DS = 0.040;           % distance between D and S = 40m = 0.04km

mu_DS = mean_load_DS*agv_speed*n_DS/d_DS

rho_DS = lambda_D/mu_DS

% Storage Node

lambda_S = mu_DS; 

mean_load_SM = 10;      % 10 units
agv_speed = 5.4;        % based on Otto (km/hr)
n_SM = 1;               % No. of AGVs 
d_SM = 0.030;           % distance between D and S = 30m = 0.03km

mu_SM = mean_load_SM*agv_speed*n_SM/d_SM

rho_SM = lambda_S/mu_SM

% Manufacturing Node

lambda_M = mu_SM; 
mu_M = 120;             % Assumed Manufacturing rate = 12 units/hr

rho_M = lambda_M/mu_M

% Manufacturing Transportation Node

lambda_M = mu_SM; 
mu_M = 120;             % Assumed Manufacturing rate = 12 units/hr

rho_M = lambda_M/mu_M

% Testing git





