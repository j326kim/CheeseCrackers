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
    if linelength  >  0.0274*100    %0.1655
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
xfinal = xfinal/100;
yfinal = yfinal/100;

%final values
%x=173.0785
%y=+-748.8488

%angle matrix
angles = NaN(1,length(xfinal));

stringx = zeros(1,3);
stringy = zeros(1,3);
stringangle = zeros(1,3);

stringx(1) = xfinal(1);
stringx(2) = xfinal(1);
stringx(3) = xfinal(1);
stringy(1) = yfinal(1);
stringy(2) = 0;
stringy(3) = yfinal(length(yfinal));

%changes---------------------------------------------------
for i=2:3
    stringangle(i) = atan((stringy(i)-stringy(i-1)) / (stringx(i)-stringx(i-1)));
    if stringangle(i) < 0
        stringangle(i) = pi + stringangle(i);
    end
end


% ---------------- element x composed of node x and node x-1 -------------%
%angle
for i = 2:1:length(xfinal)
    angles(i) = atan( (yfinal(i)-yfinal(i-1)) / (xfinal(i)-xfinal(i-1)));
    if angles(i) < 0
        angles(i) = pi + angles(i);
    end
end

%make width and thinkness matrix
indexcenternode = ceil(length(yfinal)/2);
if yfinal(indexcenternode) ~= 0
    error('Error with thinkness function')
end

w = xlsread('InputFile', 1, 'B6'); %Width of wood (Constant)

thickness = NaN(1,length(xfinal));
thicknessincrement = (0.0127) / ( (length(xfinal) - 1 ) / 2 - 1 );

for i = 2:1:indexcenternode
    thickness(i) = 0.00635 + thicknessincrement * (i-2);
end

for i = indexcenternode+1:1:length(xfinal)
    thickness(i) = 0.01905 - thicknessincrement * (i - indexcenternode - 1);
end

f = figure('color','white');
bow=zeros(length(xfinal)-1,1);
axis equal, axis off
ylim([-1 1]);
xlim([-1 1]);

%thickness is multiplied by ten so that the change in thickness is apparent
for i=1:(length(xfinal)-1)
    bow(i,1)=line(xfinal(1,i:i+1),yfinal(1,i:i+1),'color','blue','LineWidth',thickness(i+1)*100);
end

%Gauss Seidel: Input Parameters - Mass Matrix, stiffness matrix, damping matrix, U0 - Initial Guess 0
%U1 - Initial Guess 1, Two initial guess (see formula sheet), dt - time step, fap - Applied Force Vector
%seidelSolver(MassMat,stiffnessMat,DampingMat,U0,U1,dt,Fap)

%Call animation function - two matrices will be inputed
%Animation(setOfFinalXPos,setOfFinalYPos);

