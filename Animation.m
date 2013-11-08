function [] = Animation(setOfFinalXBow,setOfFinalYBow, ...
setOfFinalXString, setOfFinalYString)

    figure(1);
    title('Bow and Arrow!','Color',[.6 0 0])
    axis off,axis equal
    ylim([-1 1]);
    xlim([-1 1])
    
%     numOfLoop = length(setOfFinalXBow);
    
    for i=1:(length(setOfFinalXBow)-1)
        bow(i,1)=line(setOfFinalXBow(1,i:i+1),setOfFinalYBow(1,i:i+1),'color','blue','LineWidth',3);
        if i<3
            string(i,1)=line(setOfFinalXString(1,i:i+1),setOfFinalYString(1,i:i+1),'color','red','LineWidth',4);
        end
    end
% 
%     for j=1:1:numOfLoop
%         vectorXBow = setOfFinalXBow(:,j);
%         vectorYBow = setOfFinalYBow(:,j);
%         if j<4
%             vectorXString = setOfFinalXString(:,j);
%             vectorYString = setOfFinalYString(:,j);
%         end
%         pause(0.1);
%         figure(1)
%         plot(vectorXBow,vectorYBow,'color','blue','LineWidth',4);
%         plot(vectorXString,vectorYString,'color','red','LineWidth',2);
%         drawnow 
%         hold on
%     end
end
