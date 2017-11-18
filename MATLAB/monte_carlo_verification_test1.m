A = xlsread('results_montecarlo.xlsx','Test Cases');    % read the test cases
n = size(A,1);  % get the size of the test case table
idle_time = zeros(1,n); % initialize variables
ste1 = zeros(1,n);
lead_time = zeros(1,n);
ste2 = zeros(1,n);
data_tuple = zeros(n,22);
t = 10000;  % number of arrivals
nn = 5;     % number of iterations
for i = 1:size(A,1)
    agv_speed = A(i,1); % get all the corresponding values from the data
    agv_mean_load = A(i,6:9);
    agv_count = A(i,2:5);
    arrival_rate = A(i,14);
    node_distances = A(i,10:13);
    mfg_rate = A(i,15);
    pkg_rate = A(i,16);
    [lead_time(i), ste1(i), idle_time(i), ste2(i), ~, ~, ~, ~] = montecarlo(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate, t, nn);   % call the monte carlo function with the parameters
    data_tuple(i,:) = [agv_speed, agv_count, agv_mean_load, node_distances, arrival_rate, mfg_rate, pkg_rate, lead_time(i), ste1(i), idle_time(i), ste2(i), t, nn]; % store all the data in a data tuple
end
xlswrite('results_montecarlo.xlsx',data_tuple,'Results','A2');  % write the data in the data tuple