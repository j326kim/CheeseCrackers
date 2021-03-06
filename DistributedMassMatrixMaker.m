function [ G_M ] = DistributedMassMatrixMaker(G_M,Node1,Node2,row,A,L)
%UNTITLED4 Summary of this function goes here

%   Detailed explanation goes here
    
        local=[140 0 0 70 0 0;0 156 22*L 0 54 -13*L; ...
            0 22*L 4*L^2 0 13*L -3*L^2; 70 0 0 140 0 0; ...
            0 54 13*L 0 156 -22*L;0 -13*L -3*L^2 0 -22*L 4*L^2];
        local=local*row*A*L/420;

    %   take local matrix and insert 
        Node1=Node1*3-2; 
        Node2=Node2*3-2;
        G_M(Node1:Node1+3-1,Node1:Node1+3-1)= G_M(Node1:Node1+3-1,Node1:Node1+3-1)+local(1:3,1:3);
        G_M(Node2:Node2+3-1,Node2:Node2+3-1)= G_M(Node2:Node2+3-1,Node2:Node2+3-1)+local(4:6,4:6);
        G_M(Node2:Node2+3-1,Node1:Node1+3-1)= G_M(Node2:Node2+3-1,Node1:Node1+3-1)+local(1:3,4:6);
        G_M(Node1:Node1+3-1,Node2:Node2+3-1)= G_M(Node1:Node1+3-1,Node2:Node2+3-1)+local(4:6,1:3);
end

