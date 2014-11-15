function [ derivs ] = derivGaussKernel( params, GPData, K, invK )
N = size(GPData.Y, 1);
M = size(GPData.X, 2);
derivs = zeros(1, size(params,2));

derivs(1) = params(1) + ...
    (-1/2) * trace(K * params(1)) + ...
    1/2 * GPData.Y' * invK * params(1) * invK * GPData.Y;

% k = zeros(N, N);
% for i = 1:N
%     for j = 1:N
%         k(i,j) = gaussianKernel(GPData.X(i,:), GPData.X(j,:), params);
%     end
% end

GPData.xscaled = GPData.X./(repmat(params(3:end),N,1)).^2;
[xx yy] = meshgrid(1:N,1:N);
temp_sum = ((GPData.xscaled(xx,:)-GPData.xscaled(yy,:)).^2)./2;
k = params(2)*reshape(exp(-sum(temp_sum,2)),N,N);

derivs(2) = params(2) + ...
    (-1/2) * trace(K * params(1)) + ...
    1/2 * GPData.Y' * invK * k * invK * GPData.Y;

for p=3:size(params,2)
    
%     k = zeros(N, N);
%     for i = 1:N
%         for j = 1:N
%             exponent = (GPData.X(i,p-2) - GPData.X(j,p-2)).^2;
%             exponent = (2*params(p)*exponent)/(params(p).^4);
%             c = params(2) * exp((-1/2) * exponent);
%             k(i,j) = c;
%         end
%     end
    
    GPData.xscaled = GPData.X.*params(p)./(repmat(params(p),N,M)).^4;
    [xx yy] = meshgrid(1:N,1:N);
    temp_sum = ((GPData.xscaled(xx,:)-GPData.xscaled(yy,:)).^2);
    k = params(2)*reshape(exp(-sum(temp_sum,2)),N,N);
     
    derivs(p) = params(p) + ...
        (-1/2) * trace(K * params(1)) + ...
        1/2*GPData.Y'*invK* k *invK*GPData.Y;
end

end
