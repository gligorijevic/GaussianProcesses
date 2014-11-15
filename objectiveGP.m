function [ likelihood params mi K ] = objectiveGP( params, GPData )

N = size(GPData.Y, 1);

GPData.xscaled = GPData.X./(repmat(params(3:end),N,1)).^2;
[xx yy] = meshgrid(1:N,1:N);
temp_sum = ((GPData.xscaled(xx,:)-GPData.xscaled(yy,:)).^2)./2;
K = params(2)*reshape(exp(-sum(temp_sum,2)),N,N)+params(1)*eye(N);

% Ka = zeros(N, N);
% for i = 1:size(GPData.Y, 1)
%     for j = 1:size(GPData.Y, 1)
%         Ka(i,j) = gaussianKernel(GPData.X(i,:), GPData.X(j,:), params);
%     end
% end
% 
% sum(sum(K-Ka))

R = chol(K);
% logdet = 2 * sum(log(diag(R)));
invK = R\(R'\eye(size(K)));

mi = GPData.Y\K;

% sigma = params(1)*ones(N, N) + K;

% likelihood = -1/2 *  logdet(K, 'chol') - 1/2 * (y_tr'/K)*y_tr - 1/2*N*log(2*pi);
likelihood = -1/2 *  sum(log(diag(R))) - ...
    1/2 * (GPData.Y'* invK)*GPData.Y - 1/2*N*log(2*pi);

params = derivGaussKernel(params, GPData, K, invK);



% K = zeros(N, N);
% for i = 1:size(GPData.Y, 1)
%     for j = 1:size(GPData.Y, 1)
%         K(i,j) = gaussianKernel(GPData.X(i,:), GPData.X(j,:), params);
%     end
% end

end

