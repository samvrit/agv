filename = 'results_tradeoff.xlsx';
A = xlsread(filename,'Inputs');
n = size(A,1);
idle_time = zeros(1,n);
lead_time = zeros(1,n);
data_tuple = zeros(n,18);
t = 10000;
nn = 5;
[~, analysis_type] = xlsread(filename,'Alternatives','B17');
for i = 1:n
    agv_speed = A(i,1);
    agv_mean_load = A(i,6:9);
    agv_count = A(i,2:5);
    arrival_rate = A(i,14);
    node_distances = A(i,10:13);
    mfg_rate = A(i,15);
    pkg_rate = A(i,16);
    if strcmp(analysis_type{1},'Analytical')
        [~, lead_time(i), idle_time(i)] = agv_plant(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate);
    elseif strcmp(analysis_type{1},'Monte Carlo')
        [lead_time(i), ~, idle_time(i), ~, ~, ~, ~, ~] = montecarlo(agv_speed, ...
          agv_mean_load, agv_count, arrival_rate, node_distances, ...
          mfg_rate, pkg_rate, t, nn);
    else
        disp('Select analysis type in Excel file.');
    end
    % fprintf('Row %d \n',i);
    data_tuple(i,:) = [agv_speed, agv_count, agv_mean_load, node_distances, arrival_rate, mfg_rate, pkg_rate, lead_time(i), idle_time(i)];
end
xlswrite(filename,data_tuple,'Results','A2');
xlswrite(filename,{''},'Alternatives','F14');
winopen(filename);