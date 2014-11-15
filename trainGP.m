function [ params ] = trainGP( GPData, useWorkers )

x0 = [1 1 ones(1, size(GPData.X, 2))];

if useWorkers == true
    needNewWorkers = (matlabpool('size') == 0);
    if needNewWorkers
        % Open a new MATLAB pool with 4 workers.
        matlabpool open 4
    end
end

options = optimset('Display','Iter','MaxIter',GPData.maxiter,'GradObj','on'); %optimization 
options = optimset(options,'UseParallel','always');

params = fminunc(@(x)objectiveGP(x, GPData), x0, options);  

GPData.w0 = params(1);
GPData.w1 = params(2);
GPData.params = params(3:end);
GPData.parameters = params;

end

