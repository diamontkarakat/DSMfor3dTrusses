%  /\_/\
% ((@v@))
% ():::()
%  VV-VV
%Diamantis Karakatsanis 
%diamontkarakat@gmail.com
%Aristotle University Thessaloniki September 2023
%Thessaloniki September 2023
%Department of Civil Engineering
% The script is based on the FEM code for 2D trusses by Mansour Torabi. 
% The necessary modifications   and additions from 2d to 3d as well as the examples were made by Diamantis Karakatsanis
function trussData = DSMfor3dTrusses(trussData)
%recive data
Nodes = trussData.node;
Elements = trussData.element;
A =trussData.A;
E = trussData.E;
Supports = trussData.Supports;
ExternalForces = trussData.ExternalForces;

%% Local stiffness matrix for each element
% loop for calculating each element' angle, length and stiffness matrix
for i = 1:size(Elements,1)
    n1 = Elements(i,1);
    n2 = Elements(i,2);

    x1 = Nodes(n1,2);
    x2 = Nodes(n2,2);
    Dx = x2-x1;
    
    y1 = Nodes(n1,3); 
    y2 = Nodes(n2,3); 
    Dy = y2-y1;
    
    z1 = Nodes(n1,4); 
    z2 = Nodes(n2,4); 
    Dz = z2-z1;    
    
    L  = sqrt(Dx^2+Dy^2+Dz^2); % Element Length
    Cx = ((x2-x1)/L);      
    Cy = ((y2-y1)/L);       
    Cz  = ((z2-z1)/L);      
    Elements(i, 3) = L;
    Elements(i,4) = A(i,1) ; % Area
    Elements(i,5) = E(i,1);  % Young's Modulus    
    

   % Stiffness matrix for each Element
    k{i} = A(i,1)*E(i,1)/L * [Cx^2 Cx*Cy Cx*Cz -Cx^2 -Cx*Cy -Cx*Cz;
                    Cx*Cy Cy^2 Cy*Cz -Cx*Cy -Cy^2 -Cy*Cz;
                    Cx*Cz Cy*Cz Cz^2 -Cx*Cz -Cy*Cz -Cz^2;
                    -Cx^2 -Cx*Cy -Cx*Cz Cx^2 Cx*Cy Cx*Cz;
                    -Cx*Cy -Cy^2 -Cy*Cz Cx*Cy Cy^2 Cy*Cz;
                    -Cx*Cz -Cy*Cz -Cz^2 Cx*Cz Cy*Cz Cz^2;
                    ];                
    
    Elements(i, 6) = Cx;
    Elements(i, 7) = Cy;
    Elements(i, 8) = Cz;
end

%%  Assembling the Global stiffness matrix
KGlobal  = zeros(3*size(Nodes,1)); % Initial Values
for i = 1:size(Elements,1)

    n1 = Elements(i,1); 
    n2 = Elements(i,2);
g = [ 3*n1-2 ; 3*n1-1 ; 3*n1 ; 3*n2-2 ; 3*n2-1 ; 3*n2 ];% Degree of freedom of Start and End of each Element

KGlobal(g, g) = KGlobal(g, g) + k{i};%Assembling the local matrix to Global
end

%%  Supports  Conditions
cnt = size(Supports,1);
for i = 1:size(Supports,1) 
    
    Snode  = Supports(i,1); % Support node
    Sx  = Supports(i,2); % Support x direction
    Sy = Supports(i,3); % Support y direction
    Sz = Supports(i,3); % Support z direction
    if Sx == 1 && Sy == 1 && Sz == 1
       uu_zero(i,:)= [3*Snode-2 ; 3*Snode-1 ; 3*Snode]; 
%     elseif Sx == 1 && Sy == 1 && Sz == 0
%        uu_zero(i,:)= [3*Snode-2 ; 3*Snode-1 ; 0];
%     elseif Sx == 1 && Sy == 0 && Sz == 0
%        uu_zero(i,:)= [3*Snode-2 ; 0; 0];
%     elseif Sx == 0 && Sy == 1 && Sz == 0
%        uu_zero(i,:)= [3*Snode-2 ; 0; 0];
% % % % %  THE OTHER CASES ARE MISSING
    end
    
end
uu_zero=reshape(uu_zero,[1,3*size(Supports,1)]);
%%---------------------------------------------------------------------------------------
%% Applying external forces in the equation
F0 = zeros(3*size(Nodes,1),1);% Initial Values
for i = 1:size(ExternalForces,1)
    
    Fnode  = ExternalForces(i,1); % Node of force
    Fx   = ExternalForces(i,2); % Force x directory
    Fy   = ExternalForces(i,3); % Force y directory
    Fz   = ExternalForces(i,4); % Force z directory
    F0(3*Fnode-2,1) = Fx; %Assembling the force matrix in x directory
    F0(3*Fnode-1,1) = Fy; %Assembling the force matrix in y directory
    F0(3*Fnode,1) = Fz;%Assembling the force matrix in z directory
end
% -------------------------------------------------------------------------
% Solving equation

Kc = KGlobal;
Fc = F0;

Kc(:, uu_zero) = [];  % Removing  support Columns
Kc(uu_zero, :) = [];  % Removing support  Rows
Fc(uu_zero,:)  = [];  % Removing Rows from "Force" Vector
%--------------------**************************---------------------------- 
U0 = Kc^-1*Fc;       % Nodal displacements 
%--------------------**************************----------------------------
uu_all     = 1:3*size(Nodes,1); 
uu_nonzero = uu_all; 
uu_nonzero(uu_zero) = [];
U(uu_all,1)     = 0; 
U(uu_nonzero,1) = U0;   % Nodal displacements array
F = KGlobal*U;                % Nodal forces array

%% Post Process: Element Force, Stress
for i = 1:size(Elements,1)
    n1 = Elements(i,1); 
    n2 = Elements(i,2);      
    L  = Elements(i, 3);
    A = Elements(i,4); 
    E = Elements(i,5);    
    Cx = Elements(i, 6);
    Cy = Elements(i, 7);
    Cz = Elements(i, 8);     
  
    % Element Elongation
    Delta = [-Cx -Cy -Cz Cx Cy Cz]*[U(3*n1-2);U(3*n1-1); U(3*n1); U(3*n2-2); U(3*n2-1); U(3*n2)];   
     P = A*E/L * Delta;    
    Results(i, 1) = Delta;  % Element elongation
    Results(i, 2) = P  ;   % Element axial force
    Results(i, 3) = P/A ;   % Element stress
end
nodalForces  = reshape(F, 3, []).';
trussData.elementElongation = Results(:, 1);
trussData.elementForce      = Results(:, 2);
trussData.elementStress     = Results(:, 3);
trussData.nodalForces  = nodalForces; 
trussData.U  = U; 
trussData.F  = F; 
for i = 1:size(Supports,1) 
Reactions(i,:) = nodalForces(Supports(i,1),:);
end
trussData.Reactions  = Reactions;

end




