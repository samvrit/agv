pd1 = makedist('Exponential','mu',1/200); % Arrival time distribution
% pd2 = makedist('Exponential','mu',1/12); % Service time distribution

t = 1000000;
a_prev = 0;
c_prev = 0;
queue_wait_time = zeros(1,t);
wait_time = zeros(1,t);

for i = 1:t
    a_curr = a_prev + random(pd1);      % current arrival time
    %serv_time = random(pd2);
    serv_time = 1/201.37;
    
    if a_curr >= c_prev       % check if arrival is after previous service
        queue_wait_time(i) = 0;       % if yes, then wait time is zero
    else
        queue_wait_time(i) = c_prev - a_curr;     % else calculate wait time
    end
    c_curr = a_curr + queue_wait_time(i) + serv_time; % calculate completion time
    wait_time(i) = queue_wait_time(i) + serv_time; % calculate time in system
    
    a_prev = a_curr;        % update arrival time
    c_prev = c_curr;        % update completion time
end
disp(mean(wait_time));
fprintf('Variance = %0.4f \n',var(wait_time));