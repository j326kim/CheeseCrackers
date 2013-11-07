function [] = Animation(setOfFinalXBow,setOfFinalYBow, ...
setOfFinalXString, setOfFinalYString)

    figure('color','white');
    title('Bow and Arrow!','Color',[.6 0 0])
    axis off,axis equal
    ylim([-1000 1000]);
    xlim([-1000 1000])
    
    numOfLoop = length(setOfFinalXBow);
    for j=1:1:numOfLoop
        vectorXBow = setOfFinalXBow(:,j);
        vectorYBow = setOfFinalYBow(:,j);
        vectorXString = setOfFinalXString(:,j);
        vectorYString = setOfFinalYString(:,j);
        pause(0.1);
        figure(1)
        plot(vectorXBow,vectorYBow,'color','blue','LineWidth',4);
        plot(vectorXString,vectorYString,'color','red','LineWidth',2);
        drawnow 
    end
end
