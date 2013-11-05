%A - square matrix
%B - Output matrix
%iteration - number to times to iterate
function result = seidelSolver(A,B,iteration)
    loopVector = ones(size(B)); %Initial guess - can be anything ?
    loopVector(2,1) = 0;
    for i=1:1:iteration % More iteration = better approximation
        for j=1:1:length(A) % Number of rows or columns of square A matrix
            sumInEachRow = 0;
            for k=1:1:length(loopVector) %Loop through number of columns
                if (k ~= j)
                   %Calculate row sum when known values are subbed in
                   sumInEachRow = sumInEachRow + A(j,k) * loopVector(k,1);
                end
            end
            %May need convergence check here...
            %%%%-----------Convergence Check---------------%%%%
            %Update the loop vector for further calculation
            loopVector(j,1) = (B(j,1) - sumInEachRow)/A(j,j);
        end
    end
    %transfer loopVector to result then return output of the function
    result = loopVector;
end