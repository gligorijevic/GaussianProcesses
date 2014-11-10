clc
clear -all

% f = @(x) 0.2*x.^2 + 0.3*sin(x).^3 + 10*sin(x) + 6;
% domain = 1:0.1:10;
% y = f( domain );
% 
% plot(domain , y, '-b', 'LineWidth', 0.6)
% hold on
% 
% x_tr = domain(1:10:end)
% y_tr = f(x_tr);
% 
% scatter(x_tr, y_tr, 'r')
% 
% kernel = @(x1, x2, parameters) parameters{2} * ((x1 - x2).^parameters{3}) / 2; % Gaussian Kernel
% 
% parameters{1} = 1;
% parameters{2} = 1;
% parameters{3} = 1;
% parameters{4} = 1;
% 
% K = zeros(size(y_tr, 2), size(y_tr, 2));
% for i = 1:size(y_tr, 2)
%     for j = 1:size(y_tr, 2)
%         K(i,j) = kernel(x_tr(i), x_tr(j), parameters);
%     end
% end
% 
% mi = y_tr*inv(K);
% sigma = K;
% 
% plot( x_tr, mi, 'y') 
% 
% plot( x_tr, (mi + 1.96*diag(sigma)'), 'b')
% hold on
% 
% plot( x_tr, (mi - 1.96*diag(sigma)'), 'b')

GPData.X = randn(200, 3);
GPData.Xtest = randn(30, 3);
GPData.Y = rand(200,1);
GPData.maxiter = 20;
GPData.parameters = [1 1 ones(1, size(GPData.X, 2))];

u = trainGP(GPData, false)

[mu, sigma] = testGP(GPData)


