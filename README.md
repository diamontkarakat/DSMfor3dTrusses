# DSMfor3dTrusses
MatLab code to solve 3D Trusses with Direct Stiffness Method
The code in MatLab implements the direct stinffnes method for 3D trusses. It consists of a function that implements the method and a function that lpot the truss and its deformed shape.


INPUT DATA

Matrix of Nodes ( Node ID, X Node Y Node Z Node;..... )

Matrix of Conectinity (Node1 ID Node1 ID;....)

Area for each Element (Area of Element 1;.....)

Young Module for each Element (Young Module 1;.....)

Supports Matrix ( Node ID degree of freedom of Node in each local directory xyz 1 = fix  0= free.... )

Matrix of ExternalForces (Node ID / Force X direction / Force Y direction /Force X direction)

