pd1 = makedist('Exponential','mu',1/200); % Arrival time distribution
pd2 = makedist('Exponential','mu',1/300); % Manufacturing rate distribution
pd3 = makedist('Exponential','mu',1/600); % Packaging rate distribution

t = 1000000;
a_prev_D = 0;
a_prev_S = 0;
a_prev_M1 = 0;
a_prev_M2 = 0;
a_prev_B = 0;
a_prev_P = 0;
c_prev_D = 0;
c_prev_S = 0;
c_prev_M1 = 0;
c_prev_M2 = 0;
c_prev_B = 0;
c_prev_P = 0;
queue_wait_time = zeros(t,6);
wait_time = zeros(t,6);
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
    
    %% Pseudo Manufacturing Transport Node
    a_curr_M2 = c_curr_M1;
    serv_time_M2 = 1/302.05;
    
    if a_curr_M2 >= c_prev_M2
        queue_wait_time(i,4) = 0;
    else
        queue_wait_time(i,4) = c_prev_M2 - a_curr_M2;
    end
    c_curr_M2 = a_curr_M2 + queue_wait_time(i,4) + serv_time_M2;
    wait_time(i,4) = queue_wait_time(i,4) + serv_time_M1;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,4);
    
    a_prev_M2 = a_curr_M2;
    c_prev_M2 = c_curr_M2;
    
    %% Buffer Node
    a_curr_B = c_curr_M2;
    serv_time_B = 1/322.2;
    
    if a_curr_B >= c_prev_B
        queue_wait_time(i,5) = 0;
    else
        queue_wait_time(i,5) = c_prev_B - a_curr_B;
    end
    c_curr_B = a_curr_B + queue_wait_time(i,5) + serv_time_B;
    wait_time(i,5) = queue_wait_time(i,5) + serv_time_B;
    
    total_wait_time(i) = total_wait_time(i) + wait_time(i,5);
    
    a_prev_B = a_curr_B;
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
    
    a_prev_P = a_curr_P;
    c_prev_P = c_curr_P;
    
end
disp(mean(total_wait_time));
fprintf('Standard Error = %0.4f \n',std(total_wait_time)/sqrt(t));