% % % ENSE 623 Project - AGV System Simulation
% % % 
% % % Master Code

clc
clear

%% Common Variables

agv_speed = 5.4;    % km/h




%% Delivery Node

lambda_D = 200;                 % Delivery Node arrival rate

mean_load_DS = 10;              % 10 units
% agv_speed = 5.4;              % based on Otto (km/hr)
n_DS = 1;                       % No. of AGVs 
d_DS = 0.040;                   % distance between D and S = 40m = 0.04km

mu_DS = mean_load_DS*n_DS/((2*d_DS/agv_speed)+(2/60));

rho_DS = lambda_D/mu_DS;        % Delivery Node utilization

W_DS = 1/(mu_DS-lambda_D);      % Wait time for delivery node (hr/units)

%% Storage Node

lambda_S = mu_DS;               % Storage Node arrival rate

mean_load_SM = 10;              % 10 units
% agv_speed = 5.4;              % based on Otto (km/hr)
n_SM = 1;                       % No. of AGVs 
d_SM = 0.030;                   % distance between D and S = 30m = 0.03km

mu_SM = mean_load_SM*n_SM/((2*d_SM/agv_speed)+2/60);

rho_SM = lambda_S/mu_SM;        % Storage Node utilization

W_SM = 1/(mu_SM-lambda_S);      % Wait time for Storage node (hr/units)

%% Manufacturing Node

lambda_M = mu_SM;               % Manufacturing Node arrival rate
mu_M = 300;                     % Assumed Manufacturing rate = 300 units/hr

rho_M = lambda_M/mu_M;          % Manufacturing Node utilization

W_M = 1/(mu_M-lambda_M);        % Wait time for Manufacturing process (hours/unit)

%% Pseudo Manufacturing Transportation Node

lambda_MB = mu_M;        
mean_load_MB = 10;              % 10 units
% agv_speed = 5.4;              % based on Otto (km/hr)
n_MB = 2;                       % No. of AGVs 
d_MB = 0.020;                   % distance between D and S = 20m = 0.0200km

mu_MB = mean_load_MB*n_MB/((2*d_MB/agv_speed)+2/60);

rho_MB = lambda_MB/mu_MB;

W_MB = 1/(mu_MB-lambda_MB);     % Wait time for Manufacturing Transport node (hr/units)

%% Buffer Node

lambda_B = mu_MB;        
mean_load_BP = 10;              % 10 units
% agv_speed = 5.4;              % based on Otto (km/hr)
n_BP = 3;                       % No. of AGVs 
d_BP = 0.070;                   % distance between B and P = 70m = 0.070km

mu_BP = mean_load_BP*n_BP/((2*d_BP/agv_speed)+2/60);

rho_BP = lambda_B/mu_BP;

W_BP = 1/(mu_BP-lambda_B);      % Wait time for Buffer node (hr/units)


%% Packaging Node

lambda_P = mu_BP;        
mu_P = 600;                     % Assumed Packaging rate = 1200 units/hr

rho_P = lambda_P/mu_P;          % Packaging Node utilization

W_P = 1/(mu_P-lambda_P);        % Wait time for Manufacturing process (hours/unit)


%% Total wait time

W = W_DS + W_SM + W_M + W_MB + W_BP + W_P; 

%% Arranging Data in a table

fprintf('Wait Time = %.2f mins \n \n', W*60)

all_data = [lambda_D, mu_DS, rho_DS, W_DS;
    lambda_S, mu_SM, rho_SM, W_SM;
    lambda_M, mu_M, rho_M, W_M;
    lambda_MB, mu_MB, rho_MB, W_MB;
    lambda_B, mu_BP, rho_BP, W_BP;
    lambda_P, mu_P, rho_P, W_P;];

Table = array2table(all_data, 'RowNames' , {'Delivery Node','Storage Node','Manufacturing Node','Manufacturing Transport','Buffer Node','Packaging Node'},...
    'VariableNames', {'Lambda','Mu','Rho','Wait_time'});

disp(Table)
