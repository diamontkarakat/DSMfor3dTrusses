clc;clear all;close all;

%% Basic DATA
%This is 120 Bar 3d Truss
T.node =[1 0 0 0;2 3 0 0;3 3 3 0;4 0 3 0;5 0 0 1.50000000000000;6 3 0 1.50000000000000;7 3 3 1.50000000000000;8 0 3 1.50000000000000;9 0 0 3;10 3 0 3;11 3 3 3;12 0 3 3;13 0 0 4.50000000000000;14 3 0 4.50000000000000;15 3 3 4.50000000000000;16 0 3 4.50000000000000;17 0 0 6;18 3 0 6;19 3 3 6;20 0 3 6];
T.element = [1 5;2 6;3 7;4 8;1 6;2 5;2 7;3 6;3 8;4 7;4 5;1 8;5 6;6 7;7 8;8 5;5 7;6 8;5 9;6 10;7 11;8 12;5 10;6 9;6 11;7 10;7 12;8 11;8 9;5 12;9 10;10 11;11 12;12 9;9 11;10 12;9 13;10 14;11 15;12 16;9 14;10 13;10 15;11 14;11 16;12 15;12 13;9 16;13 14;14 15;15 16;16 13;13 15;14 16;13 17;14 18;15 19;16 20;13 18;14 17;14 19;15 18;15 20;16 19;16 17;13 20;17 18;18 19;19 20;20 17;17 19;18 20];
NofNodes = size(T.node,1);% Number of Nodes
NofElements = size(T.element,1);% Number of Elements

T.A = ones(NofElements,1)*0.001; % Area for each Element
T.E = ones(NofElements,1)*100e9; % Young Module fro each Element
T.Supports = [1 1 1 1;2 1 1 1;3 1 1 1;4 1 1 1;]; % Node/ degree of freedom of Node in each local directory xyz, 1 = fix  0= free 
T.ExternalForces= [15 2e6 2e6 -2e6];% Node / Force X direction / Force Y direction /Force X direction
%% Solve Truss
Tr=DSMfor3dTrusses(T);
%% Plot Truss
Plot3DTruss(T.node,T.element,T.Supports,T.ExternalForces,Tr.U,Tr.elementStress,5,0.000001)