E = xlsread('InputFile', 1, 'B2');
G_K = zeros(3*(length(xfinal)+1));
G_C = zeros(3*(length(xfinal)+1));
G_M = zeros(3*(length(xfinal)+1));
KeffMatrices = zeros(6, 6,length(xfinal)); %KeffMatrises(:,:,i)
Icircle=pi* 1.5875^4 / 64;
l=yfinal(length(yfinal)); %last element in yfinal vector is half the length of the string
A=pi*1.5875^2;

[G_K, KeffMatrices(:,:,1)] = MatInsert(G_K,stringE,l,stringangle(2),Icircle,1,length(yfinal)+1); %Node 1 to Node 90
[G_K, KeffMatrices(:,:,length(yfinal)+1)] = MatInsert(G_K,stringE,l,stringangle(3),Icircle,length(yfinal),length(yfinal)+1); %Node 89 to Node 90
G_C = dampInsert(G_C,stringangle(2),l,A,1,length(yfinal)+1);
G_C = dampInsert(G_C,stringangle(2),l,A,length(yfinal),length(yfinal)+1);

%manual insertion of point masses of string into mass matrix
Imass=0.5*stringMass*(1.5875/2)^2;
lyfinal=3*length(yfinal);
G_M(1,1)=G_M(1,1)+stringMass;
G_M(2,2)=G_M(2,2)+stringMass;
G_M(3,3)=G_M(3,3)+Imass;
G_M(lyfinal,lyfinal)=G_M(lyfinal,lyfinal)+2*stringMass;
G_M(lyfinal+1,lyfinal+1)=G_M(lyfinal+1,lyfinal+1)+2*stringMass;
G_M(lyfinal+2,lyfinal+2)=G_M(lyfinal+2,lyfinal+2)+2*Imass;
G_M(lyfinal+3,lyfinal+3)=G_M(lyfinal+3,lyfinal+3)+stringMass;
G_M(lyfinal+4,lyfinal+4)=G_M(lyfinal+4,lyfinal+4)+stringMass;
G_M(lyfinal+5,lyfinal+5)=G_M(lyfinal+5,lyfinal+5)+Imass;

for i = 2:(length(xfinal))
    N1 = i-1;
    N2 = i;
    L = elementVec(i);
    A = w*thickness(i); 
    Angle = angles(i);
    I = w*thickness(i)^3/12; 
        
    [G_K, KeffMatrices(:,:,i)] = MatInsert(G_K,Angle,E,L,A,I,N1,N2);
    G_C = dampInsert(G_C,Angle,L,A,N1,N2);
    G_M = DistributedMassMatrixMaker(G_M,N1,N2,p,A,L);
end





