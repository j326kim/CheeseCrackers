function [ broken ] = IsBroken( Keff, U, angles, length)
    %string_a(2) %%angle from node 2 to 1
    %length is number of nodes on bow
    %U is global displacement
    flocal = zeros((length-1)*3);

        T = [cos(angles(i)) sin(angles(i)) 0 0 0 0; ...
            -sin(angles(i)) cos(angles(i)) 0 0 0 0; ...
            0 0 1 0 0 0; ...
            0 0 0 cos(angles(i)) sin(angles(i)) 0; ...
            0 0 0 -sin(angles(i)) cos(angles(i)) 0; ...
            0 0 0 0 0 1];    
    
    
    for i = 1:6:(length-1)*3
%         Keff(:,:,i) = Keff;
            flocal(i:i+5) = T*Keff(:,:,i+1-2*(i-1))*U(i:i+5);

    end
    
    

