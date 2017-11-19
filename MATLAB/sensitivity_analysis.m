filename = 'results_sensitivity.xlsx';
A = xlsread(filename,'Test Cases');
n = size(A,1);
idle_time = zeros(1,n);
lead_time = zeros(1,n);
data_tuple = zeros(n,18);
for i = 1:n
    agv_speed = A(i,1);
    agv_mean_load = A(i,6:9);
    agv_count = A(i,2:5);
    arrival_rate = A(i,14);
    node_distances = A(i,10:13);
    mfg_rate = A(i,15);
    pkg_rate = A(i,16);
    [~, lead_time(i), idle_time(i)] = agv_plant(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate);
    % fprintf('Row %d \n',i);
    data_tuple(i,:) = [agv_speed, agv_count, agv_mean_load, node_distances, arrival_rate, mfg_rate, pkg_rate, lead_time(i), idle_time(i)];
end
xlswrite(filename,data_tuple,'Results','A2');
xlswrite(filename,{''},'Data','A15');
winopen(filename);