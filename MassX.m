G_M = zeros(3*(length(xfinal)+1));

for j = 1:3*length(elementVec)
    index = mod(j-1,3);
    
    if index <= 1
        if ceil(j/3) == 1
            G_M(j,j) = p*w*thickness(j+1)*elementVec(j+1)/2;
        elseif ceil(j/3) == length(elementVec) 
        G_M(j,j) = p*w/2*(thickness(ceil(j/3))*elementVec(ceil(j/3)));
        else
            G_M(j,j) = p*w/2*(thickness(ceil(j/3))*elementVec(ceil(j/3))+...
             thickness(ceil(j/3)+1)*elementVec(ceil(j/3)+1));
        end
    end
    
    if index == 2
        if ceil(j/3) == 1
            G_M(j,j) = p*thickness(ceil(j/3)+1)*elementVec(ceil(j/3)+1)*(thickness(ceil(j/3)+1)...
                         + elementVec(ceil(j/3)+1))^2/12;
        elseif ceil(j/3) == length(elementVec)
            G_M(j,j) = (p*thickness(ceil(j/3))*elementVec(ceil(j/3))*(thickness(ceil(j/3))...
                         + elementVec(ceil(j/3)))^2)/12;
        else
            G_M(j,j) = (p*thickness(ceil(j/3))*elementVec(ceil(j/3))*(thickness(ceil(j/3))...
                         + elementVec(ceil(j/3)))^2 + p*thickness(ceil(j/3)+1)*elementVec(ceil(j/3)+1)...
                         *(thickness(ceil(j/3)+1) + elementVec(ceil(j/3)+1))^2)/12;
        end
    end
end

G_M(j+1, j+1) = stringMass;
G_M(j+2, j+2) = stringMass;
G_M(j+3, j+3) = 0;
