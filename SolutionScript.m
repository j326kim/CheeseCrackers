%Constants
Flim = 10000000; %Limit on force vector; biiigggg value to set 
                 %limit outside of possible failure point
Fslope = 200; %ROC of the force increments; calculated based on 
              %typical loading at 1s, or full draw in regular use
dt = 0.0001;  %time step
dx = 0.0001;  %position step

%force input vector
Fap = 0:Fslope*dt:Flim;  %

