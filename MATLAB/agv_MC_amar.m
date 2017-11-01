clc
clear
%% Configuration Management Block

% ENSE 623 - Systems Projects Verification and Validation
% Fall -2017
% Group-3 : Automated Guided Vehicle System Simulation
% Developer - Amar Vamsi Krishna (UID 114921871)
% Development Team - Samvrit Srinivas, Kersasp Cawsji, Rishabh Agarwal,
% Kunal Mehta, Amar Vamsi Krishna
% Monte-Carlo module of the Project
% Version 1.0 : Deterministic AGV Service rates, Stochastic Material
% Arrival rate, Stochastic Manufacturing rate, and Stochastic Packaging
% rate | Static Inputs(No user input either through CLI or GUI)
% Assumption : All AGVs used are the same commercially available model

%% Inputs

lambda = 200;               % Mean Material Arrival Rate at the Delivery Node | Unit = #items/hour

% AGV - Model 1 parameters
agv1_speed = 5.4;           % Speed of the 1st set of AGVs | Unit = km/h 
agv1_capacity = 10;         % The maximum capacity of the 1st set of AGVs | Unit = #
agv1_number = 1;           % The number of Type-1 model AGV | Unit = #

% AGV - Model 2 parameters
agv2_speed = 5.4;           % Speed of the 1st set of AGVs | Unit = km/h 
agv2_capacity = 10;         % The maximum capacity of the 2nd set of AGVs | Unit = #
agv2_number = 1;           % The number of Type-1 model AG | Unit = #

% AGV - Model 3 parameters
agv3_speed = 5.4;           % Speed of the 1st set of AGVs | Unit = km/h
agv3_capacity = 10;         % The maximum capacity of the 3rd set of AGVs | Unit = #
agv3_number = 1;           % The number of Type-1 model AG | Unit = #

% AGV - Model 4 parameters
agv4_speed = 5.4;           % Speed of the 1st set of AGVs | Unit = km/h
agv4_capacity = 10;         % The maximum capacity of the 4th set of AGVs | Unit = #
agv4_number = 1;           % The number of Type-1 model AG | Unit = #

% Distance Factors
d_DS = 0.04;                  % Distance between the Delivery Node and the Storage Node | Unit = km
d_SM = 0.04;                  % Distance between the Storage Node and the Manufacturing Node | Unit = km
d_MB = 0.04;                  % Distance between the Manufacturing Node and the Buffer Node | Unit = km
d_BP = 0.04;                  % Distance between the Buffer Node and the Packaging Node | Unit = km

% Capacity Factors
c_storage = 1200;            % Capacity of the Storage Node | Unit = #
c_buffer = 1200;             % Capacity of the Buffer Node | Unit = #

% Service Rate Factors
mu_mfg = 300;               % Mean Service Rate of the Manufacturing Node | Unit = #units/hour
mu_pkg = 300;               % Mean Service Rate of the Packaging Node | Unit = #units/hour

%% Stochastic Inputs

t_arrival = -(1/lambda)*log(rand);   % Random number generator for the inter-arrival time | exponential/markovian distribution
t_mfg = -(1/mu_mfg)*log(rand);       % Random number generator for the manufacturing time | exponential/markovian distribution
t_pkg = -(1/mu_pkg)*log(rand);       % Random number generator for the packaging time | exponential/markovian distribution

%% Loading and Unloading time Calculations

t_load = 1/60;              % Loading time for an AGV | Unit = hr
t_unload = 1/60;            % Unloading time for an AGV | Unit = hr

%% AGV Service Rate Calculations

mu_DS = (agv1_number*agv1_capacity)/((2*d_DS/agv1_speed)+t_load+t_unload);       % Calculating the service time of AGV 1 based on the AGV and environment parameters
mu_SM = (agv2_number*agv2_capacity)/((2*d_SM/agv2_speed)+t_load+t_unload);       % Calculating the service time of AGV 2 based on the AGV and environment parameters
mu_MB = (agv3_number*agv3_capacity)/((2*d_MB/agv3_speed)+t_load+t_unload);       % Calculating the service time of AGV 3 based on the AGV and environment parameters
mu_BP = (agv4_number*agv4_capacity)/((2*d_BP/agv4_speed)+t_load+t_unload);       % Calculating the service time of AGV 4 based on the AGV and environment parameters

%% Timestamp log 

% Column -1     :       id          :   Material ID Number
% Column -2     :       day         :   Day Number
% Column -3     :       t_arrival   :   Material Arrival Time
% Column -4     :       t_d_pickup  :   AGV-1 Pickup Time at Delivery Node
% Column -5     :       t_waitD     :   Wait Time at Delivery Node
% Column -6     :       t_s_drop    :   AGV-1 Dropoff time at Storage Node
% Column -7     :       t_s_pickup  :   AGV-2 Pickup time at Storage Node
% Column -8     :       t_waitS     :   Wait Time at Storage Node
% Column -9     :       t_m_drop    :   AGV-2 Dropoff time at Manufacturing Node
% Column -10    :       t_mfg_enter :   Time the item enters the Manufacturing Machine
% Column -11    :       t_waitM1    :   Wait Time at Manufacturing Node -1
% Column -12    :       t_mfg_exit  :   Time the item exits the Manufacturing Machine
% Column -13    :       t_m_pickup  :   AGV-3 Pickup time at Manufacturing Node
% Column -14    :       t_waitM2    :   Wait Time at Manufacturing Node -2
% Column -15    :       t_waitM     :   Total Wait time at the Manufacturing Node
% Column -16    :       t_b_drop    :   AGV-3 Dropoff time at the Buffer Node
% Column -17    :       t_b_pickup  :   AGV-4 Pickup time at the Buffer Node
% Column -18    :       t_waitB     :   Wait time at the Buffer Node
% Column -19    :       t_p_drop    :   AGV-4 Dropoff time at the Packaging Node
% Column -20    :       t_pkg_enter :   Time the item enters the Packaging Machine
% Column -21    :       t_waitP     :   Wait time at the Packaging Node
% Column -22    :       t_pkg_exit  :   Time the item exits the Packaging Node
% Column -23    :       t_wait      :   Total Wait Time for the item
% Column -24    :       t_service   :   Total Service Time for the item
% Column -25    :       t_total     :   Total System Lead Time for the item
% Column -26    :       t_idle      :   Net Manufacturing Idle Time for the day

%% Defining the time log arrays for each of the AGVs
% Timelog sheet contains two arrays for each AGV. First array notes down
% the previous pick up time and the second array contains the next time
% that particular AGV is available for pickup.

t_agv1_pickup = zeros(agv1_number,1);           % previous pickup time for the jth AGV-1                
t_agv1_nextpickup = zeros(agv1_number,1);       % next available pickup time for the jth AGV-1

t_agv2_pickup = zeros(agv2_number,1);           % previous pickup time for the jth AGV-2
t_agv2_nextpickup = zeros(agv2_number,1);       % next available pickup time for the jth AGV-2

t_agv3_pickup = zeros(agv3_number,1);           % previous pickup time for the jth AGV-3
t_agv3_nextpickup = zeros(agv3_number,1);       % next available pickup time for the jth AGV-3

t_agv4_pickup = zeros(agv4_number,1);           % previous pickup time for the jth AGV-1
t_agv4_nextpickup = zeros(agv4_number,1);       % next available pickup time for the jthe AGV-1
%% Monte-Carlo Algorithm

n = 100;             % Number of material arrivals modelled | Number of rows in the final table
chart=zeros(n,26);
% Populating the time chart for the first item arrival
 
id(1) = 1;
day(1) = 1;
t_arrival









