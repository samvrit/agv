function [lead_time, ste, idle_time, total_wait_time] = montecarlo(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate, t)
      
if(nargin < 8)  % if the number of inputs to the function is less than 7, use fixed values
    t = 10000;
    agv_speed = 4.9;                % km/h [based on Otto]
    
    lambda_D = 200;                 % Delivery Node arrival rate
    mu_M = 300;                     % Assumed Manufacturing rate = 300 units/hr
    mu_P = 600;                     % Assumed Packaging rate = 1200 units/hr
    
    mean_load_DS = 1;              % 1 unit
    n_DS = 10;                       % No. of AGVs 
    d_DS = 0.040;                   % distance between D and S = 40m = 0.04km
    
    mean_load_SM = 1;              % 1 unit
    n_SM = 11;                       % No. of AGVs 
    d_SM = 0.040;                   % distance between D and S = 30m = 0.03km
    
    mean_load_MB = 1;              % 1 unit
    n_MB = 15;                       % No. of AGVs 
    d_MB = 0.040;                   % distance between D and S = 20m = 0.0200km
    
    mean_load_BP = 1;              % 1 unit
    n_BP = 16;                       % No. of AGVs 
    d_BP = 0.040;                   % distance between B and P = 70m = 0.070km
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

pd1 = makedist('Exponential','mu',1/lambda_D); % Arrival time distribution
pd2 = makedist('Exponential','mu',1/mu_M); % Manufacturing rate distribution
pd3 = makedist('Exponential','mu',1/mu_P); % Packaging rate distribution

mu_DS = mean_load_DS*n_DS/((2*d_DS/agv_speed)+(2/60));
mu_SM = mean_load_SM*n_SM/((2*d_SM/agv_speed)+(2/60));
mu_MB = mean_load_MB*n_MB/((2*d_MB/agv_speed)+(2/60));
mu_BP = mean_load_BP*n_BP/((2*d_BP/agv_speed)+(2/60));

serv_time_D = 1/mu_DS;
serv_time_S = 1/mu_SM;
serv_time_M2 = 1/mu_MB;
serv_time_B = 1/mu_BP;

a_prev_D = 0;
c_prev_D = 0;
c_prev_S = 0;
c_prev_M1 = 0;
c_prev_M2 = 0;
c_prev_B = 0;
c_prev_P = 0;
mfg_empty_time = 0;

queue_wait_time = zeros(t,6);
wait_time = zeros(t,6);
total_wait_time = zeros(t,1);

for i = 1:t
    %% Delivery Node
    a_curr_D = a_prev_D + random(pd1);      % current arrival time
    
    if a_curr_D >= c_prev_D       % check if arrival is after previous service
        queue_wait_time(i,1) = 0;       % if yes, then wait time is zero
    else
        queue_wait_time(i,1) = c_prev_D - a_curr_D;     % else calculate wait time
    end
    c_curr_D = a_curr_D + queue_wait_time(i,1) + serv_time_D; % calculate completion time
    wait_time(i,1) = queue_wait_time(i,1) + serv_time_D; % calculate time in system
    total_wait_time(i) = total_wait_time(i) + wait_time(i,1);
    
    a_prev_D = a_curr_D;        % update arrival time
    c_prev_D = c_curr_D;        % update completion time
    
    %% Storage Node
    a_curr_S = c_curr_D;    % arrival at storage node is same as the departure time from delivery node
    
    if a_curr_S >= c_prev_S
        queue_wait_time(i,2) = 0;
    else
        queue_wait_time(i,2) = c_prev_S - a_curr_S;
    end
    c_curr_S = a_curr_S + queue_wait_time(i,2) + serv_time_S;
    wait_time(i,2) = queue_wait_time(i,2) + serv_time_S;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,2);
    
    c_prev_S = c_curr_S;
    
    %% Manufacturing Node
    a_curr_M1 = c_curr_S;
    serv_time_M1 = random(pd2);
    
    if a_curr_M1 >= c_prev_M1
        mfg_empty_time = mfg_empty_time + (a_curr_M1 - c_prev_M1);
        queue_wait_time(i,3) = 0;
    else
        queue_wait_time(i,3) = c_prev_M1 - a_curr_M1;
    end
    c_curr_M1 = a_curr_M1 + queue_wait_time(i,3) + serv_time_M1;
    wait_time(i,3) = queue_wait_time(i,3) + serv_time_M1;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,3);
    
    c_prev_M1 = c_curr_M1;
    
    %% Pseudo Manufacturing Transport Node
    a_curr_M2 = c_curr_M1;
    
    if a_curr_M2 >= c_prev_M2
        queue_wait_time(i,4) = 0;
    else
        queue_wait_time(i,4) = c_prev_M2 - a_curr_M2;
    end
    c_curr_M2 = a_curr_M2 + queue_wait_time(i,4) + serv_time_M2;
    wait_time(i,4) = queue_wait_time(i,4) + serv_time_M1;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,4);
    
    c_prev_M2 = c_curr_M2;
    
    %% Buffer Node
    a_curr_B = c_curr_M2;
    
    if a_curr_B >= c_prev_B
        queue_wait_time(i,5) = 0;
    else
        queue_wait_time(i,5) = c_prev_B - a_curr_B;
    end
    c_curr_B = a_curr_B + queue_wait_time(i,5) + serv_time_B;
    wait_time(i,5) = queue_wait_time(i,5) + serv_time_B;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,5);
    
    c_prev_B = c_curr_B;
    
    %% Packaging Node
    a_curr_P = c_curr_B;
    serv_time_P = random(pd3);
    
    if a_curr_P >= c_prev_P
        queue_wait_time(i,6) = 0;
    else
        queue_wait_time(i,6) = c_prev_P - a_curr_P;
    end
    c_curr_P = a_curr_P + queue_wait_time(i,6) + serv_time_P;
    wait_time(i,6) = queue_wait_time(i,6) + serv_time_P;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,6);
    
    c_prev_P = c_curr_P;
    
end
lead_time = mean(total_wait_time);
idle_time = mfg_empty_time/c_curr_P;
ste = std(total_wait_time)/sqrt(t);
%fprintf('Mean System Lead Time = %0.4f \n',mean(total_wait_time));
%fprintf('Manufacturing Node Idle Time = %0.4f \n',idle_time);
%fprintf('Standard Error = %0.4f \n',std(total_wait_time)/sqrt(t));
end