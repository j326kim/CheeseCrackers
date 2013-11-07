clear all;

%Constants
Flim = 10000000; %Limit on force vector; biiigggg value to set
                 %limit outside of possible failure point
Fslope = 200; %ROC of the force increments; calculated based on
              %typical loading at 1s, or full draw in regular use
dt = 0.001; %time step
p = xlsread('InputFile', 1, 'B4'); %Density (wood)
w = xlsread('InputFile', 1, 'B6'); %Width of wood (Constant)
stringMass = xlsread('InputFile', 1, 'H4'); % Mass of the string 
stringE = xlsread('InputFile', 1, 'H2'); %String modulus of elasticity
stringL = xlsread('InputFile', 1, 'H6'); %String length
stringR = xlsread('InputFile', 1, 'H8'); %String Radius
thicknessStart = xlsread('InputFile', 1, 'C2');
thicknessEnd = xlsread('InputFile', 1, 'D2');
failure = 0; %Failure flag; if failure condition is reached, set to 1
count = 0; %Number of iterations the while loop has gone through.


%Initial setup; creates xfinal(), yfinal(), angles(), thickness()
Initial_Matrix_Maker;
U = zeros(3*(length(xfinal(1,:))+1),1); %Change the hard-coded value to (length(Global),1))
Uplus = zeros(3*(length(xfinal(1,:))+1),1);
Uminus = zeros(3*(length(xfinal(1,:))+1),1);
F = zeros(3*(length(xfinal(1,:))+1),1);
XAni = zeros(3*(length(xfinal(1,:))+1), Flim); %X animation matrix
YAni = zeros(3*(length(xfinal(1,:))+1), Flim); %Y animation matrix

%force input vector
Fap = 0:Fslope*dt:Flim; 

while failure == 0 && Fap(1,count+1) ~= Flim
    % Making Global matrices
    if count > 0
        for i = 1:length(xfinal(1,:))
            xfinal(1,i) = xfinal(1,i) + U(3*i-2,1);
            yfinal(1,i) = yfinal(1,i) + U(3*i-1,1);
            
                    
        end
        XAni(:,count+1) = xfinal; 
        YAni(:,count+1) = yfinal;
        F(3*i-2,1) = Fap(1, count);
    end
    
    ElementVec; % Makes a vector, elementVec(), with element lengths.
    MassX;
    CoefMaker; 
    Sparse(G_K,G_C,G_M,U,Uplus,Uminus,F,indexcenternode);
    
    %Setup to make everything in the form Ax = B
    A = 1/dt^2*G_M + 1/(2*dt)*G_C; 
    G1 = (G_K - 2/dt^2*G_M)*U;
    G2 = (1/dt^2*G_M - 1/(2*dt)*G_C)*Uminus;
    
    %make force vector
    B =  G1 + G2 + F;
    
    %Solve for Uplus
    Uplus = seidelSolver(A,U,B);
    Uminus = U;
    U = Uplus; 
    
    %-elemental force calculation here-
    
    
    %     %-Plot the displacement vector here
    %     %Increment Force applied on center of bow
    %     %Update Force Matrix - Calculate force applied on each element for next
    %     %iteration
    %     %Update Matrices of Constants, i.e C,K
    %     %Get global matrix again with mass, stiffness, and damping functions
    % end
    count = count + 1;
    failure = 1;
end