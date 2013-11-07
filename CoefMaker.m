E = xlsread('InputFile', 1, 'B2');
StiffnessGlobal = zeros(3*(length(xfinal)+1));
DampingGlobal = zeros(3*(length(xfinal)+1));
G_K = zeros(3*(length(xfinal)+1));
G_C = zeros(3*(length(xfinal)+1));

for i = 2:((length(xfinal)))
    N1 = i-1;
    N2 = i;
    L = elementVec(i);
    A = w*thickness(i); 
    Angle = angles(i);
    I = w*thickness(i)^3/12; 
        
    G_K = G_K + MatInsert(StiffnessGlobal,Angle,E,L,A,I,N1,N2);
    G_C = G_C + dampInsert(DampingGlobal,Angle,L,A,N1,N2);
    
   end



