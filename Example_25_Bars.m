clc;clear all;close all;

%% Basic DATA
%This is 25 Bar 3d Truss
T.node =[1 -95.25	0	508;2	95.25	0	508;3	-95.25	95.25	254;4	95.25	95.25	254;5	95.25	-95.25	254;6	-95.25	-95.25	254;7	-254	254	0;8	254	254	0;9	254	-254	0;10	-254	-254	0]; % Matrix of Nodes ( No Node, X node Y node Z node )
T.element = [1 2;1 4;2	3;1	5;2	6;2	4;2	5;1	3;1	6;3	6;4	5;3	4;5	6;3	10;6	7;4	9;5	8;4	7;3	8;5	10;6	9;6	10;3	7;4	8;5	9];% Matrix of Elements - conectinity No 1--> No 2 etc
NofNodes = size(T.node,1);% Number of Nodes
NofElements = size(T.element,1);% Number of Elements
T.A = ones(NofElements,1)*100.1;; % Area for each Element
T.E = ones(NofElements,1)*6895;; % Young Module fro each Element
T.Supports = [7 1 1 1;8 1 1 1;9 1 1 1;10 1 1 1;] % Node/ degree of freedom of Node in each local directory xyz, 1 = fix  0= free 
T.ExternalForces= [1, 4.4537, -44.537,-44.537;2,0 -44.537,-44.537;3, 2.2268 ,0,0;6, 2.664,0,0; ];% Node / Force X direction / Force Y direction /Force X direction
%% Solve Truss
Tr=DSMfor3dTrusses(T);
%% Plot Truss
Plot3DTruss(T.node,T.element,T.Supports,T.ExternalForces,Tr.U,Tr.elementStress,500,5)