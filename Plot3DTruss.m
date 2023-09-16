function [] = Plot3DTruss(Nodes,Elements,Supports,ExternalForces,U,ElementStress,scalefactorDisp,scalefactorForce)
%% Plot 3d truss
figure;
hold on;
% Define fixed support nodes
for i=1:size(Supports ,1)
    temp = Supports(i,1);
    SupportsNode(i,:)= Nodes(temp,2:4);
end
% Plot nodes
 scatter3(Nodes(:, 2), Nodes(:, 3), Nodes(:, 4), 'ro', 'filled');
for i = 1:size(Nodes,1)
    if size(Nodes,1)<100
    text(Nodes(i, 2), Nodes(i, 3), Nodes(i, 4),['  (',num2str(i),')'],'FontSize',15)
    else
    text(Nodes(i, 2), Nodes(i, 3), Nodes(i, 4),['  (',num2str(i),')'],'FontSize',7) 
    end
end
% Mark fixed support nodes
scatter3(SupportsNode(:, 1), SupportsNode(:, 2), SupportsNode(:, 3),'Marker','^');
% Plot elements (connections between nodes)
for i = 1:size(Elements, 1)
    node1 = Elements(i, 1);
    node2 = Elements(i, 2);
    xn = [Nodes(node1, 2), Nodes(node2, 2)];
    yn = [Nodes(node1, 3), Nodes(node2, 3)];
    zn = [Nodes(node1, 4), Nodes(node2, 4)];
    dxzy = sqrt((Nodes(node1, 2)-Nodes(node2, 2))^2+(Nodes(node1, 3)-Nodes(node2, 3))^2+(Nodes(node1, 4)-Nodes(node2, 4))^2);
    if ElementStress(i)>0
    plot3(xn, yn, zn, 'r-', 'LineWidth', 2);
    else
    plot3(xn, yn, zn, 'b-', 'LineWidth', 2);  
    end
end
% Plot force
for i = 1:size(ExternalForces, 1)
    quiver3(Nodes(ExternalForces(i,1), 2), Nodes(ExternalForces(i,1), 3), Nodes(ExternalForces(i,1), 4), scalefactorForce*ExternalForces(i, 2), 0, 0, 'g', 'LineWidth', 2);
    quiver3(Nodes(ExternalForces(i,1), 2), Nodes(ExternalForces(i,1), 3), Nodes(ExternalForces(i,1), 4), 0, scalefactorForce*ExternalForces(i, 3), 0, 'g', 'LineWidth', 2);
    quiver3(Nodes(ExternalForces(i,1), 2), Nodes(ExternalForces(i,1), 3), Nodes(ExternalForces(i,1), 4), 0,0, scalefactorForce*ExternalForces(i, 4), 'g', 'LineWidth', 2);
end
%scale factor for more clear node displacement
Newnodes = [Nodes(:,1),reshape(scalefactorDisp*U,3,[])']+Nodes; % New potition of Nodes

% Plot new nodes
 scatter3(Newnodes(:, 2), Newnodes(:, 3), Newnodes(:, 4), '*');
% Plot elements (connections between nodes)
for i = 1:size(Elements, 1)
    node1 = Elements(i, 1);
    node2 = Elements(i, 2);
    xn = [Newnodes(node1, 2), Newnodes(node2, 2)];
    yn = [Newnodes(node1, 3), Newnodes(node2, 3)];
    zn = [Newnodes(node1, 4), Newnodes(node2, 4)];
    plot3(xn, yn, zn, 'm--', 'LineWidth', 1);
end

% Set axis labels and title
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Truss with Supports and Forces');
% Adjust plot properties
axis equal;
grid on;
view(3);
hold off;
end

