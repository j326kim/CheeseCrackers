function [] = Animation()
    
    setsOfPositionVectors = rand(93,93); %Take this hard code out
    
    figure('color','white');
    title('Bow and Arrow!','Color',[.6 0 0])
    axis off,axis equal
    ylim([-1000 1000]);
    xlim([-1000 1000])
    
    numOfLoop = length(setsOfPositionVectors);
    for j=1:1:numOfLoop
        x;
        y;
        xx = horzcat
        positionVector = setsOfPositionVectors(:,j);
        %for i=1:1:size(positionVector,1)-2
        for i=1:1:length(positionVector)
            n = 3;
            x = positionVector(1 : n : end);
            y = positionVector(2 : n : end);
            %plot(x,y,'color','blue','LineWidth',4);
            %hold on
            %drawnow 
        end
    end
end


%x=[positionVector(3*i-2) positionVector(3*(i+1)-2)];
%y=[positionVector(3*i-1) positionVector(3*(i+1)-1)];



