% Samples from a normal distribution given a mean and standard deviation
% Input
%  mean : scalar mean
%  pi   : precision (1/standard deviation)
% Output
%  sampled scalar
function x = sample_normal(mean, pi, size)
    if nargin < 3
        size = 1;
    end
    x = mean + 1./sqrt(pi) * randn(size);
end