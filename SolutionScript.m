clear all;
clc;

%Constants
Flim = 10000; %Limit on force vector; biiigggg value to set
                 %limit outside of possible failure point
Fslope = 200; %ROC of the force increments; calculated based on
              %typical loading at 1s, or full draw in regular use
dt = 0.00001; %time step
p = xlsread('InputFile', 1, 'B4'); %Density (wood)
w = xlsread('InputFile', 1, 'B6'); %Width of wood (Constant)
stringMass = xlsread('InputFile', 1, 'H4'); % Mass of the string 
stringE = xlsread('InputFile', 1, 'H2'); %String modulus of elasticity
stringD = xlsread('InputFile', 1, 'H6'); %String Radius
failure = 0; %Failure flag; if failure condition is reached, set to 1
count = 0; %Number of iterations the while loop has gone through.


%Initial setup; creates xfinal(), yfinal(), angles(), thickness()
Initial_Matrix_Maker;
U = zeros(3*(length(xfinal(1,:))+1),1); %Change the hard-coded value to (length(Global),1))
Uplus = zeros(3*(length(xfinal(1,:))+1),1);
Uminus = zeros(3*(length(xfinal(1,:))+1),1);
F = zeros(3*(length(xfinal(1,:))+1),1);
XAni = zeros(length(xfinal(1,:))+1, Flim); %X animation matrix
YAni = zeros(length(xfinal(1,:))+1, Flim); %Y animation matrix
StringLE = sqrt((stringy(3)-stringy(2))^2 + (stringx(3)-stringx(2))^2);

%force input vector
Fap = 0:Fslope*dt:Flim; 

ElementVec;
CoefMaker; 
[G_K,G_C,G_M,Uplus,U,Uminus,F]= Sparse(G_K,G_C,G_M,Uplus,U,Uminus,F,indexcenternode);

while failure == 0 || Fap(1,count+1) ~= Flim
    % Making Global matrices
    if count > 0
        for i = 1:(length(xfinal(1,:))-1)
            if i == indexcenternode
                i = i+1;
            end
                xfinal(1,i) = xfinal(1,i) + U(3*i-2,1);
                XAni(i,count+1) = xfinal(1,i);
                yfinal(1,i) = yfinal(1,i) + U(3*i-1,1);
                YAni(i,count+1) = yfinal(1,i);
        end
        
        XAni(i+1,count+1) = stringx(1, 1);
        stringx(2) = stringx(2) + U(3*i+1,1);
        YAni(i+1,count+1) = stringx(1, 1);
        F(3*i+1,1) = Fap(1, count);
    end
    
    %update position of string
    stringx(1) = xfinal(1);
    stringx(3) = xfinal(1);
    stringy(1) = yfinal(1);
    stringy(3) = yfinal(length(yfinal));

    %update angle
    for j=2:3
        stringangle(j) = atan((stringy(j)-stringy(j-1)) ./ (stringx(j)-stringx(j-1)));
        if j==3
            stringangle(j) = pi - stringangle(j); %hard code the angle tranfer, who cares, theres only ever 3 string nodes
        end
    end
    
    
    StringLE = sqrt((stringy(3)-stringy(2))^2 + (stringx(3)-stringx(2))^2);

    % make garbage to fuck around with
    LoopU = zeros(3*(length(xfinal(1,:))+1),1); 
    LoopUd = zeros(3*(length(xfinal(1,:))+1),1);
    LoopUdd = zeros(3*(length(xfinal(1,:))+1),1);
    LoopF = zeros(3*(length(xfinal(1,:))+1),1);
    clearvars G_K G_M G_C;
    
    ElementVec; % Makes a vector, elementVec(), with element lengths.
    CoefMaker; 
    [G_K,G_C,G_M,LoopU,LoopUd,LoopUdd,LoopF]= Sparse(G_K,G_C,G_M,LoopU,LoopUd,LoopUdd,LoopF,indexcenternode);
    clearvars LoopU;
    clearvars LoopUd;
    clearvars LoopUdd;
    clearvars LoopF;
    
%     %Setup to make everything in the form Ax = B
%     A = 1/dt^2*G_M + 1/(2*dt)*G_C; 
%     G1 = (G_K - 2/dt^2*G_M)*U;
%     G2 = (1/dt^2*G_M - 1/(2*dt)*G_C)*Uminus;
%     
%     %make force vector
%     B =  G1 + G2 + F;
%     
    %Solve for Uplus
    Uplus = seidelSolver(G_M,G_K,G_C,Uminus,U,dt,F);
    Uminus = U;
    U = Uplus; 
%     
%     %Check for failure
%     failure = IsBroken;
%  

      count = count + 1;
      if count> 2
        failure = 1; %remove once IsBroken is done
      end
end
