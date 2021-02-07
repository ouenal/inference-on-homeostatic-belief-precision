% Allostatic control
function [args] = infer_precision(args)

% Parameter allocation
pi_data = args.patient.pi_data;
a = args.patient.a;
lambda = args.patient.lambda;
window_size = args.model.window_size;
iter = args.sim.iter;

% Assume mu prior is estimated
args.estimate.mu_prior = zeros(size(args.patient.mu_prior));

% Add noise to measurement action
a = a + sample_normal(0, args.sim.pi_a, size(a));

% Initialize model states
args.estimate.pi  = zeros(iter - window_size + 1, 1);
args.estimate.x = zeros(iter+1, 1);

% % Estimate x from measured a
% args.estimate.x(1) = args.estimate.mu_prior(1);
% for i = 2:iter
%     args.estimate.x(i) = args.estimate.x(1) + sum(a(1:i-1))/lambda;
% end

% Override estimate x with real x
args.estimate.x = args.patient.x;

% Run model
switch args.model.MODEL
    case 'stdpe'
        for i = window_size:iter
            args.estimate.pi(i-window_size+1) = sqrt(var(a(i - window_size + 1:i))*pi_data);
        end
    case 'lepe'
        for i = window_size:iter
            args.estimate.mu_prior(i) = mean(args.estimate.x(i - window_size + 1: i));
        end
        for i = window_size:iter
            a_val = 1;
            b_val = (-pi_data/window_size)*sum(a(i - window_size + 1:i).*(args.estimate.x(i - window_size + 1:i)-args.estimate.mu_prior(i - window_size + 1:i)));
            c_val = (-pi_data/window_size)*sum(a(i - window_size + 1:i).^2);
            args.estimate.pi(i-window_size+1) = sqrt(b_val^2-4*a_val*c_val)/(2*a_val); % (-b_val + sqrt(b_val^2-4*a_val*c_val))/(2*a_val);
        end
end

if args.model.plot.PLOT || args.model.plot.SAVE
    plot_precision(args);
end

end