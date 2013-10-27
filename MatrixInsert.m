function [G_K] = MatrixInsert(Global,angle,kValue,Node1,Node2)

%   Detailed explanation goes here

%   test
%   create local matrix
    a=floor(cos(angle)*10^10)/10^10;
    b=floor(sin(angle)*10^10)/10^10;
    
    temp=[a^2 a*b;a*b b^2];
    local=kValue*[temp -temp; -temp temp];
    
%   take local matrix and insert 
    [r,c]=size(local);
    Node1=Node1*2-1;
    Node2=Node2*2-1;
    Global(Node1:Node1+r-1,Node1:Node1+c-1)= local;
    Global(Node2:Node2+r-1,Node2:Node2+c-1)= local;
    Global(Node2:Node2+r-1,Node1:Node1+c-1)= -local;
    Global(Node1:Node1+r-1,Node2:Node2+c-1)= -local;
    G_K=Global;

end

