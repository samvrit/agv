# Automated Guided Vehicles in a Manufacturing Facility - System Analysis
## ENSE623 Project - University of Maryland, College Park

This is a system performance simulation of a manufacturing plant which has the following **five** nodes:
1. **Delivery Node**: Where the raw materials are delivered to the plant
2. **Storage Node**: The pre-manufacturing buffer node
3. **Manufacturing Node**: Where the actual manufacturing takes place
4. **Buffer Node**: The post-manufacturing buffer node
5. **Packaging Node**: Where the finished materials are packaged

Automated Guided Vehicles (AGVs) are the mode of transport for the materials between any two nodes. 
The nodes are assumed as queues, and the AGVs are assumed as servers (in Queueing Theory terms).
This repository contains both the simulation software (inside the "MATLAB" folder) as well as the simulation architecture in SysML (Papyrus).

The simulation analyses the following system metrics:
1. **System Lead Time**: The average total response time for the materials to be processed by the manufacturing plant
2. **Manufacturing Node Idle Time**: The percentage of time that the Manufacturing Node is idle due to lack of incoming materials

## System Requirements
1. Windows PC
2. MATLAB 2012 or higher
3. MS Excel
4. Papyrus (optional, only for viewing the simulation architecture)

## Installation
As long as MATLAB 2012 or higher, and MS Excel are installed on the Windows PC, no additional installation is required.
Just clone the repository into a local folder, and navigate to the "MATLAB" folder. Run the "agv_simulation.m" through MATLAB to get started.
A user's manual for the simulation is included in the "MATLAB" folder.
