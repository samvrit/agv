% % % ENSE 623 Project - AGV System Simulation
% % %
% % % AGV Monte Carlo Function

clear
clc

% function [data_table, lead_time, idle_time] = agv_MC(agv_speed, ...
%     agv_mean_load, agv_count, arrival_rate, node_distances, ...
%     mfg_rate, pkg_rate)

% The inuputs to the function are:
% agv_speed -> Speed of the AGV in km/h (scalar)
% agv_mean_load -> Mean capacity of the robots between each node in units (1x4 array)
% agv_count -> Number of AGVs between two nodes (1x4 array)
% arrival_rate -> Arrival rate of material in units/hr (scalar)
% node_distances -> Distance between nodes in km (1x4 array)
% mfg_rate -> Manufacturing rate in units/hr (scalar)
% pkg_rate -> Packaging rate in units/hr (scalar)

% if(nargin < 7)  % if the number of inputs to the function is less than 7, use fixed values
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
% else
%     lambda_D = arrival_rate;
%     mu_M = mfg_rate;
%     mu_P = pkg_rate;
%     
%     mean_load_DS = agv_mean_load(1);
%     mean_load_SM = agv_mean_load(2);
%     mean_load_MB = agv_mean_load(3);
%     mean_load_BP = agv_mean_load(4);
%     
%     n_DS = agv_count(1);
%     n_SM = agv_count(2);
%     n_MB = agv_count(3);
%     n_BP = agv_count(4);
%     
%     d_DS = node_distances(1);
%     d_SM = node_distances(2);
%     d_MB = node_distances(3);
%     d_BP = node_distances(4);
% end

%% Delivery Node (M/D/1)

mu_DS = mean_load_DS*n_DS/((2*d_DS/agv_speed)+(2/60));

rho_DS = lambda_D/mu_DS;        % Delivery Node utilization

%% Storage Node (D/D/1)

lambda_S = mu_DS;               % Storage Node arrival rate

mu_SM = mean_load_SM*n_SM/((2*d_SM/agv_speed)+2/60);

rho_SM = lambda_S/mu_SM;        % Storage Node utilization

%% Manufacturing Node (D/M/1)

lambda_M = mu_SM;               % Manufacturing Node arrival rate
beta = 1/lambda_M;

rho_M = lambda_M/mu_M;          % Manufacturing Node utilization

%% Pseudo Manufacturing Transportation Node (M/D/1)

lambda_MB = mu_M;

mu_MB = mean_load_MB*n_MB/((2*d_MB/agv_speed)+2/60);

rho_MB = lambda_MB/mu_MB;

%% Buffer Node (D/D/1)

lambda_B = mu_MB;        

mu_BP = mean_load_BP*n_BP/((2*d_BP/agv_speed)+2/60);

rho_BP = lambda_B/mu_BP;

%% Packaging Node (D/M/1) 

lambda_P = mu_BP;
beta = 1/lambda_P;

rho_P = lambda_P/mu_P;          % Packaging Node utilization

%% Monte Carlo code starts

%%%% Delivery Node %%%%

% Initializing System Time
T_s(1,1) = 0;                          
n = 1;

while T_s < 24                                % for T_S in a 24 hr period
    
    n = n+1;
    W_q_D = random('exp',1/lambda_D);         % Inter-arrival times for the Delivery node
    T_s(n,1) = T_s(n-1,1) + W_q_D;            % Inter-arrival times added to System time
    
    W_q_D_matrix(n-1,1) = W_q_D; 
end
T_s = T_s(1:n-1,1);
n = n-1;
disp(T_s)
disp(n)

X_DS(1:n,1) = 1/mu_DS;

%%%% Storage Node %%%%

W_q_S(1:n,1) = 0;           % Because Storage node is A D/D/1 Queue.

X_SM(1:n,1) = 1/mu_SM;      % Interarrival times to Manufacturing Node

%%%% Manufacturing Node %%%%

for const = 1:n
    X_M(const,1) = random('exp',1/mu_M);         % Service times for the Manufacturing node
end

X_MB(1:n,1) = 1/mu_MB;

%%%% Buffer Node %%%%

W_q_B(1:n,1) = 0;           % Because Buffer node is A D/D/1 Queue.

X_BP(1:n,1) = 1/mu_BP;      % Interarrival times to Packaging Node


%%%% Packaging Node %%%%

for const2 = 1:n
    X_P(const2,1) = random('exp',1/mu_P);         % Service times for the Packaging node
end

% Initializing Time Progression Matrix for each piece of raw material in the
% system.
% The 11 columns of this matrix represent the System 
% 1. T_s    (System Time)
% 2. W_q_D  (Interarrical times at Delivery Node)
% 3. X_DS   (Service time for transporting AGV from D to S)
% 4. W_q_S  (Time spent at Storage node (Is 0 because deterministic))
% 5. X_SM   (Service time for transporting AGV from S to M)
% 6. X_M    (Manufacturing Service time)
% 7. X_MB   (Service time for transporting AGV from M to B )
% 8. W_q_B  (Time spent at Buffer node (Is 0 because deterministic))
% 9. X_BP   (Service time for transporting AGV from B to P)
% 10. X_P   (Packaging Service time)


T_prog  = [T_s,W_q_D_matrix,X_DS,W_q_S, X_SM, X_M,X_MB, W_q_B, X_BP, X_P];

% Total Wait time for each item entering the system. (It is a sum of column 2 - 9 of T_prog)
system_lead_time = sum(T_prog(:,2:10),2);  

mean_total_wait_time = mean(system_lead_time)
stddev_total_wait_time = std(system_lead_time)

% Plot of System Lead Time for every piece of raw material in the system. 
plot(system_lead_time.*60)
xlabel('Units in the System')
ylabel('System Lead Time (mins)')
% end
