function G_C = dampInsert(Global,angle,L,A,Node1,Node2)

    %create local matrix
    C=floor(cos(angle)*10^10)/10^10;
    S=floor(sin(angle)*10^10)/10^10;
    
    temp = [C^2 C*S 0;C*S S^2 0;0 0 0];
    
    Node1=Node1*3-2;
    Node2=Node2*3-2;
    Global(Node1:Node1+3-1,Node1:Node1+3-1)= temp;
    Global(Node2:Node2+3-1,Node2:Node2+3-1)= temp;
    Global(Node2:Node2+3-1,Node1:Node1+3-1)= -temp;
    Global(Node1:Node1+3-1,Node2:Node2+3-1)= -temp;
    
    if (isnan(L) || isnan(A))
       Cl = 0.387864561;
       Global = Global*Cl;
    else
       Ce = 1.18125 * L * A;
       Global = Global*Ce;
    end
    G_C = Global;
end