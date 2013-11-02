clear all

t=[0:0.000001:4.5]; 
x=t.^2;
y=18.*t;
linelength = 0;

        xfinal(1) = x(1);
        yfinal(1) = y(1);


n=2;
i=1;
while i < length(x) -1
    %each element is 1.6553cm long
  linelength = (y(i)-yfinal(n-1))^2 + (x(i)-xfinal(n-1))^2;
%   if linelength > 0.0274
%       pause
%   end
    if linelength  >  0.0274    %0.1655
        xfinal(n) = x(i);
        yfinal(n) = y(i);
        n = n +1;
    end
    i=i+1;
    if yfinal(n-1) > 75
        break
    end
end
xfinal(:,length(xfinal))=[];
yfinal(:,length(yfinal))=[];

%reflect to get bottom half of bow
yfinal = horzcat(-fliplr(yfinal(:,2:length(yfinal))),yfinal);
xfinal = horzcat(fliplr(xfinal(:,2:length(xfinal))),xfinal);


%put it in meters
xfinal = xfinal.*10;
yfinal = yfinal.*10;

%final values
%x=173.0785
%y=+-748.8488

%angle matrix
angles = NaN(1,length(xfinal));

% ---------------- element x composed of node x and node x-1 -------------%

for i = 2:1:length(xfinal)
    angles(i) = atan( (xfinal(i)-xfinal(i-1)) / (yfinal(i)-yfinal(i-1)));
end

scatter(xfinal,yfinal)
axis equal
set(gca, 'xlim', [-20 1000], 'ylim', [-1000 1000])
