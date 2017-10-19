% % % ENSE 623 Project - AGV System Simulation
% % % 
% % % AGV Function

function [data_table, lead_time, idle_time] = agv_plant(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate)

if(nargin < 7)
    agv_speed = 5.4;                % km/h [based on Otto]
    
    mu_M = 300;                     % Assumed Manufacturing rate = 300 units/hr
    mu_P = 600;                     % Assumed Packaging rate = 1200 units/hr
    lambda_D = 200;                 % Delivery Node arrival rate
    
    mean_load_DS = 10;              % 10 units
    n_DS = 1;                       % No. of AGVs 
    d_DS = 0.040;                   % distance between D and S = 40m = 0.04km
    
    mean_load_SM = 10;              % 10 units
    n_SM = 1;                       % No. of AGVs 
    d_SM = 0.030;                   % distance between D and S = 30m = 0.03km
    
    mean_load_MB = 10;              % 10 units
    n_MB = 2;                       % No. of AGVs 
    d_MB = 0.020;                   % distance between D and S = 20m = 0.0200km
    
    mean_load_BP = 10;              % 10 units
    n_BP = 3;                       % No. of AGVs 
    d_BP = 0.070;                   % distance between B and P = 70m = 0.070km
else
    lambda_D = arrival_rate;
    mu_M = mfg_rate;
    mu_P = pkg_rate;
    
    mean_load_DS = agv_mean_load(1);
    mean_load_SM = agv_mean_load(2);
    mean_load_MB = agv_mean_load(3);
    mean_load_BP = agv_mean_load(4);
    
    n_DS = agv_count(1);
    n_SM = agv_count(2);
    n_MB = agv_count(3);
    n_BP = agv_count(4);
    
    d_DS = node_distances(1);
    d_SM = node_distances(2);
    d_MB = node_distances(3);
    d_BP = node_distances(4);
end

%% Delivery Node

mu_DS = mean_load_DS*n_DS/((2*d_DS/agv_speed)+(2/60));

rho_DS = lambda_D/mu_DS;        % Delivery Node utilization

W_DS = 1/(mu_DS-lambda_D);      % Wait time for delivery node (hr/units)

%% Storage Node

lambda_S = mu_DS;               % Storage Node arrival rate

mu_SM = mean_load_SM*n_SM/((2*d_SM/agv_speed)+2/60);

rho_SM = lambda_S/mu_SM;        % Storage Node utilization

W_SM = 1/(mu_SM-lambda_S);      % Wait time for Storage node (hr/units)

%% Manufacturing Node

lambda_M = mu_SM;               % Manufacturing Node arrival rate

rho_M = lambda_M/mu_M;          % Manufacturing Node utilization

W_M = 1/(mu_M-lambda_M);        % Wait time for Manufacturing process (hours/unit)

%% Pseudo Manufacturing Transportation Node

lambda_MB = mu_M;        

mu_MB = mean_load_MB*n_MB/((2*d_MB/agv_speed)+2/60);

rho_MB = lambda_MB/mu_MB;

W_MB = 1/(mu_MB-lambda_MB);     % Wait time for Manufacturing Transport node (hr/units)

%% Buffer Node

lambda_B = mu_MB;        

mu_BP = mean_load_BP*n_BP/((2*d_BP/agv_speed)+2/60);

rho_BP = lambda_B/mu_BP;

W_BP = 1/(mu_BP-lambda_B);      % Wait time for Buffer node (hr/units)

%% Packaging Node

lambda_P = mu_BP;

rho_P = lambda_P/mu_P;          % Packaging Node utilization

W_P = 1/(mu_P-lambda_P);        % Wait time for Manufacturing process (hours/unit)

%% Total wait time

W = W_DS + W_SM + W_M + W_MB + W_BP + W_P; 

%% Arranging Data in a table

all_data = [lambda_D, mu_DS, rho_DS, W_DS;
            lambda_S, mu_SM, rho_SM, W_SM;
            lambda_M, mu_M, rho_M, W_M;
            lambda_MB, mu_MB, rho_MB, W_MB;
            lambda_B, mu_BP, rho_BP, W_BP;
            lambda_P, mu_P, rho_P, W_P;];

Table = array2table(all_data, 'RowNames' , {'Delivery Node','Storage Node','Manufacturing Node','Manufacturing Transport','Buffer Node','Packaging Node'},...
    'VariableNames', {'Lambda','Mu','Rho','Wait_time'});

%% Return outputs
lead_time = W;
idle_time = rho_M;
data_table = all_data;

%% Display output
 %disp(Table)
 %fprintf('Wait Time = %.2f mins \n \n', W*60)

end
