% % % ENSE 623 Project - AGV System Simulation
% % % 
% % % AGV Function 
% Testing the git on matlab

function [data_table, lead_time, idle_time] = agv_plant(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate)

% The inuputs to the function are:
% agv_speed -> Speed of the AGV in km/h (scalar)
% agv_mean_load -> Mean capacity of the robots between each node in units (1x4 array)
% agv_count -> Number of AGVs between two nodes (1x4 array)
% arrival_rate -> Arrival rate of material in units/hr (scalar)
% node_distances -> Distance between nodes in km (1x4 array)
% mfg_rate -> Manufacturing rate in units/hr (scalar)
% pkg_rate -> Packaging rate in units/hr (scalar)

if(nargin < 7)  % if the number of inputs to the function is less than 7, use fixed values
    agv_speed = 5.4;                % km/h [based on Otto]
    
    lambda_D = 200;                 % Delivery Node arrival rate
    mu_M = 300;                     % Assumed Manufacturing rate = 300 units/hr
    mu_P = 600;                     % Assumed Packaging rate = 1200 units/hr
    
    mean_load_DS = 1;              % 10 units
    n_DS = 10;                       % No. of AGVs 
    d_DS = 0.040;                   % distance between D and S = 40m = 0.04km
    
    mean_load_SM = 1;              % 10 units
    n_SM = 12;                       % No. of AGVs 
    d_SM = 0.030;                   % distance between D and S = 30m = 0.03km
    
    mean_load_MB = 1;              % 10 units
    n_MB = 13;                       % No. of AGVs 
    d_MB = 0.020;                   % distance between D and S = 20m = 0.0200km
    
    mean_load_BP = 1;              % 10 units
    n_BP = 19;                       % No. of AGVs 
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

%% Delivery Node (M/D/1)

mu_DS = mean_load_DS*n_DS/((2*d_DS/agv_speed)+(2/60));

rho_DS = lambda_D/mu_DS;        % Delivery Node utilization

W_DS = (1/mu_DS) + (rho_DS/(2*mu_DS*(1-rho_DS)));      % Wait time for delivery node (hr/units)

%% Storage Node (D/D/1)

lambda_S = lambda_D;               % Storage Node arrival rate

mu_SM = mean_load_SM*n_SM/((2*d_SM/agv_speed)+(2/60));

rho_SM = lambda_S/mu_SM;        % Storage Node utilization

% W_SM = (1/mu_SM) + (rho_SM/(2*mu_SM*(1-rho_SM)));      % Wait time for Storage node (hr/units)
W_SM = (1/mu_SM);      % Wait time for Storage node (hr/units)

%% Manufacturing Node (D/M/1)

lambda_M = lambda_S;               % Manufacturing Node arrival rate
beta = 1/lambda_M;

rho_M = lambda_M/mu_M;          % Manufacturing Node utilization

% W_M = (1/mu_M) + (rho_M/(2*mu_M*(1-rho_M)));        % Wait time for Manufacturing process (hours/unit)

delta = -lambertw(0, -beta*mu_M*exp(-beta*mu_M))/(beta*mu_M); % reference: https://en.wikipedia.org/wiki/D/M/1_queue
W_M = (1/mu_M)*delta/(1-delta);

%% Pseudo Manufacturing Transportation Node (M/D/1)

lambda_MB = lambda_M;

mu_MB = mean_load_MB*n_MB/((2*d_MB/agv_speed)+(2/60));

rho_MB = lambda_MB/mu_MB;

W_MB = (1/mu_MB) + (rho_MB/(2*mu_MB*(1-rho_MB)));     % Wait time for Manufacturing Transport node (hr/units)

%% Buffer Node (D/D/1)

lambda_B = lambda_MB;        

mu_BP = mean_load_BP*n_BP/((2*d_BP/agv_speed)+(2/60));

rho_BP = lambda_B/mu_BP;

% W_BP = (1/mu_BP) + (rho_BP/(2*mu_BP*(1-rho_BP)));      % Wait time for Buffer node (hr/units)
W_BP = (1/mu_BP);

%% Packaging Node (D/M/1) 

lambda_P = lambda_B;
beta = 1/lambda_P;

rho_P = lambda_P/mu_P;          % Packaging Node utilization

% W_P = 1/(mu_P-lambda_P);        % Wait time for Manufacturing process (hours/unit)
delta = -lambertw(0, -beta*mu_P*exp(-beta*mu_P))/(beta*mu_P);
W_P = (1/mu_P)*delta/(1-delta);

%% Total wait time

W = W_DS + W_SM + W_M + W_MB + W_BP + W_P; 

%% Arranging Data in a table

all_data = [lambda_D, mu_DS, rho_DS, W_DS;
            lambda_S, mu_SM, rho_SM, W_SM;
            lambda_M, mu_M, rho_M, W_M;
            lambda_MB, mu_MB, rho_MB, W_MB;
            lambda_B, mu_BP, rho_BP, W_BP;
            lambda_P, mu_P, rho_P, W_P;];
% 
% Table = array2table(all_data, 'RowNames' , {'Delivery Node','Storage Node','Manufacturing Node','Manufacturing Transport','Buffer Node','Packaging Node'},...
%     'VariableNames', {'Lambda','Mu','Rho','Wait_time'});

%% Return outputs
lead_time = round(W,3);
idle_time = round(1-rho_M,2);
data_table = all_data;

%% Display output
 %disp(Table)
 %fprintf('Wait Time = %.2f mins \n \n', W*60)

end
