function [ mi, sigma ] = testGP( GPData )

N = size(GPData.X,1); %TODO mozda je N broj primera mozda kolona
Ns = size(GPData.Xtest,1);

trainingInputs = GPData.X./(repmat(GPData.parameters(3:end),N,1)).^2;
testInputs = GPData.Xtest./(repmat(GPData.parameters(3:end),Ns,1)).^2;

[xx yy] = meshgrid(1:N,1:N);
temp_sum = ((trainingInputs(xx,:)-trainingInputs(yy,:)).^2)./2;
K = GPData.parameters(2)*reshape(exp(-sum(temp_sum,2)),N,N) + GPData.parameters(1)*eye(N);

[xx yy] = meshgrid(1:Ns,1:N);
temp_sum = ((testInputs(xx,:)-trainingInputs(yy,:)).^2)./2;
Ks = GPData.parameters(2)*reshape(exp(-sum(temp_sum,2)),N,Ns);

[xx yy] = meshgrid(1:Ns,1:Ns);
temp_sum = ((testInputs(xx,:)-testInputs(yy,:)).^2)./2;
k = GPData.parameters(2)*reshape(exp(-sum(temp_sum,2)),Ns,Ns) + GPData.parameters(1)*eye(Ns);

mi = Ks'*(K\GPData.Y);
mi = mi';
sigma = sqrt(diag(k-Ks'*(K\Ks)));
sigma = sigma';


% x_test = [GPData.X; GPData.Xtest];
% N = size(GPData.X, 1);
% K = zeros(N, N);
% 
% for i = 1:N
%     for j = 1:N
%         K(i,j) = gaussianKernel(x_test(i,:), x_test(j,:), GPData.parameters);
%     end
% end
% 
% K = GPData.parameters(1)*eye(N, N) + K;
% 
% k = zeros(size(GPData.Xtest, 1) * N, 1);
% k_prim = zeros(size(GPData.Xtest, 1), 1);
% for i = 1:size(GPData.Xtest, 1)
%     k_prim(i,1) = gaussianKernel(GPData.Xtest(i,:), GPData.Xtest(i,:), GPData.parameters);
%     for j = 1:N
%         k((i-1)*size(GPData.Xtest, 1) + j, 1) = ...
%             gaussianKernel(GPData.Xtest(i,:), GPData.X(j, :), GPData.parameters);
%     end
% end
% k = reshape(k, N, size(GPData.Xtest, 1));
% 
% 
% mi = k'/K*GPData.Y;
% 
% size(k')
% size(GPData.parameters(1)*ones(size(GPData.Xtest, 1), size(GPData.Xtest, 1)))
% size(k'/K*k)
% 
% sigma = GPData.parameters(1)*ones(size(GPData.Xtest, 1), size(GPData.Xtest, 1)) + k_prim - k'/K*k

end

