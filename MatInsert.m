function [G_K,ok,local] = MatInsert(Global,angle,E,L,A,I,Node1,Node2)

%   Detailed explanation goes here
    %E(Pa),L(m),A(m^2),I(m^4),angle(rads)
    %Global is the global stiffness matrix and Node1 and Node2 are the node
    %numbers
    
    if Node1==Node2
        ok=0;
    else
        %   create local matrix
        C=floor(cos(angle)*10^10)/10^10;
        S=floor(sin(angle)*10^10)/10^10;

        local=[(A*C^2*E)/L+(12*E*I*S^2)/L^3 (A*C*E*S)/L-(12*C*E*I*S)/L^3 ...
           -(6*E*I*S)/L^2 -(A*C^2*E)/L-(12*E*I*S^2)/L^3 (12*C*E*I*S)/L^3-(A*C*E*S)/L ...
           -(6*E*I*S)/L^2;(A*C*E*S)/L-(12*C*E*I*S)/L^3 (12*C^2*E*I)/L^3+(A*E*S^2)/L ...
           (6*C*E*I)/L^2 (12*C*E*I*S)/L^3-(A*C*E*S)/L -(12*C^2*E*I)/L^3-(A*E*S^2)/L ...
           (6*C*E*I)/L^2;-(6*E*I*S)/L^2 (6*C*E*I)/L^2 (4*E*I)/L (6*E*I*S)/L^2 ...
           -(6*C*E*I)/L^2 (2*E*I)/L; -(A*C^2*E)/L-(12*E*I*S^2)/L^3 (12*C*E*I*S)/L^3-(A*C*E*S)/L ...
           (6*E*I*S)/L^2 (A*C^2*E)/L+(12*E*I*S^2)/L^3 (A*C*E*S)/L-(12*C*E*I*S)/L^3 ...
           (6*E*I*S)/L^2;(12*C*E*I*S)/L^3-(A*C*E*S)/L -(12*C^2*E*I)/L^3-(A*E*S^2)/L ...
           -(6*C*E*I)/L^2 (A*C*E*S)/L-(12*C*E*I*S)/L^3 (12*C^2*E*I)/L^3+(A*E*S^2)/L ...
           -(6*C*E*I)/L^2;-(6*E*I*S)/L^2 (6*C*E*I)/L^2 (2*E*I)/L (6*E*I*S)/L^2 ...
           -(6*C*E*I)/L^2 (4*E*I)/L];

    %   take local matrix and insert 
        Node1=Node1*3-2; 
        Node2=Node2*3-2;
        Global(Node1:Node1+3-1,Node1:Node1+3-1)= local(1:3,1:3);
        Global(Node2:Node2+3-1,Node2:Node2+3-1)= local(4:6,4:6);
        Global(Node2:Node2+3-1,Node1:Node1+3-1)= local(1:3,4:6);
        Global(Node1:Node1+3-1,Node2:Node2+3-1)= local(4:6,1:3);
        G_K=Global;
    end
end

