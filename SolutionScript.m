%Constants
Flim = 10000000; %Limit on force vector; biiigggg value to set 
                 %limit outside of possible failure point
Fslope = 200; %ROC of the force increments; calculated based on 
              %typical loading at 1s, or full draw in regular use
dt = 0.0001;  %time step
dx = 0.0001;  %position step

%force input vector
Fap = 0:Fslope*dt:Flim;  %

%Where calculation begins using Gauss Seidel
U = zeros(6,1); %Change the hard-coded value to (length(Global),1))
for i=1:1:length(Global)
    %Global - Square, U - Initial Guess, Fap - Force Vector
    updatedVector = seidelSolver(Global,U, Fap);
    %Check if breakage occurs based on the displacement of every elements
    %-for i=1:1:length(matrix with maxmimum allowable displacement for each element)
    %DO Animation Here
    %-Plot the displacement vector here
    %Increment Force applied on center of bow
    %Update Force Matrix - Calculate force applied on each element for next
    %iteration
    %Update Matrices of Constants, i.e C,K
    %Get global matrix again with mass, stiffness, and damping functions
end



