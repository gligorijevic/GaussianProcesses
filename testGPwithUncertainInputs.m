function [ mi_x, sigma ] = testGPwithUncertainInputs( GPData )
%TESTGPWITHUNCERTAININPUTS Summary of this function goes here
% Refer to:
% Girard, A., Rasmussen, C. E., Candela, J. Q., & Murray-Smith, R. (2003). 
% Gaussian process priors with uncertain inputs – application
% to multiple-step ahead time series forecasting.
% In Advances in Neural Information Processing % Systems (p. 545-552). MIT Press


N = size(GPData.X,1); %TODO mozda je N broj primera mozda kolona
Ns = size(GPData.Xtest,1);

mu_X = mean(GPData.X, 1);

trainingInputs = GPData.X./(repmat(GPData.parameters(3:end),N,1)).^2;
testInputs = mu_X./(repmat(GPData.parameters(3:end),Ns,1)).^2;

[xx yy] = meshgrid(1:N,1:N);
temp_sum = ((trainingInputs(xx,:)-trainingInputs(yy,:)).^2)./2;
K_x = GPData.parameters(2)*reshape(exp(-sum(temp_sum,2)),N,N) + GPData.parameters(1)*eye(N);

[xx yy] = meshgrid(1:Ns,1:N);
temp_sum = ((testInputs(xx,:)-trainingInputs(yy,:)).^2)./2;
Ks_x = GPData.parameters(2)*reshape(exp(-sum(temp_sum,2)),N,Ns);

[xx yy] = meshgrid(1:Ns,1:Ns);
temp_sum = ((testInputs(xx,:)-testInputs(yy,:)).^2)./2;
k_x = GPData.parameters(2)*reshape(exp(-sum(temp_sum,2)),Ns,Ns) + GPData.parameters(1)*eye(Ns);

mi_x = Ks_x'*(K_x\GPData.Y);
mi_x = mi_x';
sigma_x = sqrt(diag(k_x-Ks_x'*(K_x\Ks_x)));
sigma_x = sigma_x';

Sigma_x = cov(GPData.X, 1);

%TODO implementiraj
sigma = sigma_x + 




end

