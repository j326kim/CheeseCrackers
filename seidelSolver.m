%A - square matrix
%B - Output matrix
%iteration - number to times to iterate
function result = seidelSolver(A,B,iteration)
    loopVector = ones(size(B)); %Initial guess - can be anything ?
    loopVector(2,1) = 0;
    iterationVector = loopVector; % Copy of loop vector (for convergence)
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
        %Convergence Test (Only to see if it is diverging or not
        %for each iteration
        maximumError = -99999999;
        %Compare previous iteration vector with current iteration vector
        for d=1:1:length(iterationVector)
            error = (( loopVector(d,1) - iterationVector(d,1) ) ...
                / loopVector(d,1)) * 100;
            if (error > maximumError)
                maximumError = error;
            end
        end
        fprintf('Max Error for iteration %i: %f\n', i, maximumError);
        %Make current copy, the previous copy vector
        iterationVector = loopVector;
    end
    %transfer loopVector to result then return output of the function
    result = loopVector;
end