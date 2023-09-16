# DSMfor3dTrusses
MatLab code to solve 3D Trusses with Direct Stiffness Method
The code in MatLab implements the direct stinffnes method for 3D trusses. It consists of a function that implements the method and a function that lpot the truss and its deformed shape.


INPUT DATA

Matrix of Nodes ( Node ID, X Node Y Node Z Node;..... )

Matrix of Conectinity (Node1 ID Node1 ID;....)

Area for each Element (Area of Element 1;.....)

Young Module for each Element (Young Module 1;.....)

Supports Matrix ( Node ID degree of freedom of Node in each directory xyz 1 = fix  0= free.... )

Matrix of ExternalForces (Node ID / Force X direction / Force Y direction /Force X direction)

FOR EXAMPLE:

![5BarsTruss](https://github.com/diamontkarakat/DSMfor3dTrusses/assets/72194340/1bd8cb38-d089-4b87-b9dd-c015418740ae)


Matrix of Nodes :T.node =[1 0 0 10;2 -4 3 0;3 4 3 0;4 4 -3 0;5 -4 -3 0];

Matrix of Conectinity: T.element = [1 2;1 3;1 4;1 5;];

Area for each Element: T.A = [1000e-6;1000e-6;1000e-6;1000e-6;]

Young Module for each Element T.E=[200e9;200e9;200e9;200e9;]
 
Supports Matrix [2 1 1 1;3 1 1 1;4 1 1 1;5 1 1 1;]; ( Node ID, degree of freedom for x direcory =1 (fix),, degree of freedom for y direcory =1 (fix), degree of freedom for z direcory =1 (fix) )

T.ExternalForces = [1, 60000, -80000,0;]; ( Node ID, force in x direcory =1 (fx), force in y direcory =1 (fy), force inr z direcory =1 (fz) )



