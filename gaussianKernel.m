function [ c ] = gaussianKernel( x1, x2, parameters )

exponent = (x1 - x2).^2;
exponent = exponent./(parameters(3:end).^2);
c = parameters(2) * exp((-1/2).*sum(exponent));


end

