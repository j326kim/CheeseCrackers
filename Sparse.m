function [G_K,G_C,G_M,G_U,G_Ud,G_Udd,G_F] = Sparse(G_K,G_C,G_M,G_U,G_Ud,G_Udd,G_F)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    for i=size(G_U,1):-1:1   
        if G_U(i,1)==0
            G_K=removerows(G_K,i); %remove row
            G_K(:,i)=[]; %remove column
            G_C=removerows(G_C,i);
            G_C(:,i)=[];
            G_M=removerows(G_M,i);
            G_M(:,i)=[];
            G_F=removerows(G_F,i);
            G_U=removerows(G_U,i);
            G_Ud=removerows(G_Ud,i);
            G_Udd=removerows(G_Udd,i);
        end
    end
    
end

