function [] = Animation()
    
    setOfFinalX = rand(93,1000);
    setOfFinalY = rand(93,1000);

    figure('color','white');
    title('Bow and Arrow!','Color',[.6 0 0])
    axis off,axis equal
    ylim([-1000 1000]);
    xlim([-1000 1000])
    
    numOfLoop = length(setOfFinalX);
    for j=1:1:numOfLoop
        vectorX = setOfFinalX(:,j);
        vectorY = setOfFinalY(:,j);
        pause(0.1);
        figure(1)
        plot(vectorX,vectorY,'color','blue','LineWidth',4);
        drawnow 
    end
end


