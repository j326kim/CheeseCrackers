close all;
f = figure('color','white');
title('Bow and Arrow!','Color',[.6 0 0])
axis off,axis equal
ylim([-1000 1000]);
xlim([-1000 1000])
%-----makes the target-----%
c = -pi:.04:pi;
cx = 100*cos(c)-800;
cy = -100*sin(c);
target=line(cx, cy, 'color', [.4 .4 .8],'LineWidth',1);
hold on
%--------------------------%

bow=zeros(size(Element,1),1);
for i=1:size(Element,1)
    bow(i,1)=line(Element(1,1:2),Element(1,3:4),'color','blue','LineWidth',x);
end





