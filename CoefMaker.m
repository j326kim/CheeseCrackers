E = xlsread('InputFile', 1, 'B2');
StiffnessGlobal = zeros(3*(length(xfinal)+1));
DampingGlobal = zeros(3*(length(xfinal)+1));
G_K = zeros(3*(length(xfinal)+1));
G_C = zeros(3*(length(xfinal)+1));
KeffMatrises = zeros(length(xfinal), 6, 6);

for i = 2:(length(xfinal))
    N1 = i-1;
    N2 = i;
    L = elementVec(i);
    A = w*thickness(i); 
    Angle = angles(i);
    I = w*thickness(i)^3/12; 
        
    [G_K, KeffMatrises(i,:,:)] = MatInsert(G_K,Angle,E,L,A,I,N1,N2);
    [G_C ] = dampInsert(G_C,Angle,L,A,N1,N2);
    
end

L = stringL/2;
E = stringE;
A = pi*stringR^2;

N1 = 1; 
N2 = length(xfinal)+1;

% Angle = 


