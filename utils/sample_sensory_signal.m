% Generates actual sensory signal
% Input
%  x  : current state
%  pi : precision (1/standard deviation)
% Output
%  scalar sensory signal
function y = sample_sensory_signal(x, pi)
    y = x + sample_normal(0, pi);
end
