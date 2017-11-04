pd1 = makedist('Exponential','mu',1/200); % Arrival time distribution
pd2 = makedist('Exponential','mu',1/300); % Manufacturing rate distribution

t = 1000000;
a_prev_D = 0;
a_prev_S = 0;
a_prev_M1 = 0;
c_prev_D = 0;
c_prev_S = 0;
c_prev_M1 = 0;
queue_wait_time = zeros(t,3);
wait_time = zeros(t,3);
total_wait_time = zeros(t,1);

for i = 1:t
    %% Delivery Node
    a_curr_D = a_prev_D + random(pd1);      % current arrival time
    serv_time_D = 1/201.37;
    
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
    a_curr_S = c_curr_D;
    serv_time_S = 1/221.5;
    
    if a_curr_S >= c_prev_S
        queue_wait_time(i,2) = 0;
    else
        queue_wait_time(i,2) = c_prev_S - a_curr_S;
    end
    c_curr_S = a_curr_S + queue_wait_time(i,2) + serv_time_S;
    wait_time(i,2) = queue_wait_time(i,2) + serv_time_S;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,2);
    
    a_prev_S = a_curr_S;
    c_prev_S = c_curr_S;
    
    %% Manufacturing Node
    a_curr_M1 = c_curr_S;
    serv_time_M1 = random(pd2);
    
    if a_curr_M1 >= c_prev_M1
        queue_wait_time(i,3) = 0;
    else
        queue_wait_time(i,3) = c_prev_M1 - a_curr_M1;
    end
    c_curr_M1 = a_curr_M1 + queue_wait_time(i,3) + serv_time_M1;
    wait_time(i,3) = queue_wait_time(i,3) + serv_time_M1;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,3);
    
    a_prev_M1 = a_curr_M1;
    c_prev_M1 = c_curr_M1;
end
disp(mean(total_wait_time));
fprintf('Standard Error = %0.4f \n',std(total_wait_time)/sqrt(t));