% Computes a damped harmonic function following
%       d^2x/dt^2+2*gamma*dx/dt+omega^2*x
% For critically damped, chose gamma^2 = omega^2
% Final step discretizes to timestep and modified the function such that
% the following hold:
% 1. dh_k \in [0,1] such that the precision can be controlled as desired
% 2. For time points k >= k_minima, y = 0.
function [dh_k] = modified_damped_harmonic(omega,gamma,timestep)
    
    % Compute damped harmonic
    syms x(t)
    eq = diff(x,t,2) + gamma*diff(x,t) + omega^2*x == 0;
    dx = diff(x,t);
    cond = [x(0)==1, dx(0)==0];
    dh(t) = dsolve(eq, cond);
    
    % Discretize dh
    dh_k = double(dh(1:timestep+1));
    
    % Process dh_k for continuous derivative such that the above mentioned
    % criteria hold
    [mi, i] = min(dh_k);
    if(i == timestep+1)
        error('Minima exceeds timestep. Choose a larger one.')
    end
    dh_k = dh_k - mi;  % Raise damped harmonic such
                       % for k=k_minima, y=0
    dh_k(i:end) = 0;   % and also for k>k_minima, y=0
    [ma, ~] = max(dh_k);
    dh_k = dh_k./ma;   % Normalize to [0,1] to control precision levels
    dh_k = dh_k(1:timestep)';

end