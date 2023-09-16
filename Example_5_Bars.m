clc;clear all;close all;

%% Basic DATA
%This is 4Bar 3d Truss
T.node =[1 0 0 10;2 -4 3 0;3 4 3 0;4 4 -3 0;5 -4 -3 0]; % Matrix of Nodes ( No Node, X node Y node Z node )
T.element = [1 2;1 3;1 4;1 5;];% Matrix of Elements - conectinity No 1--> No 2 etc
NofNodes = size(T.node,1);% Number of Nodes
NofElements = size(T.element,1);% Number of Elements
T.A = ones(NofElements,1)*1000e-6; % Area for each Element
T.E = ones(NofElements,1)*200e9; % Young Module fro each Element
T.Supports = [2 1 1 1;3 1 1 1;4 1 1 1;5 1 1 1;]; % Node/ degree of freedom of Node in each local directory xyz, 1 = fix  0= free 
T.ExternalForces= [1, 60000, -80000,0;];% Node / Force X direction / Force Y direction /Force X direction
%% Solve Truss
Tr=DSMfor3dTrusses(T);
%% Plot Truss
Plot3DTruss(T.node,T.element,T.Supports,T.ExternalForces,Tr.U,Tr.elementStress,1,0.00005)