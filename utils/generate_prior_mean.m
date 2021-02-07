function [args] = generate_prior_mean(args)

switch args.sim.mu_prior_case
    case 0
        args.patient.mu_prior = ones(args.sim.iter, 1);
        args.patient.mu_prior(500:1300) = 2;
    case 1
        args.patient.mu_prior = zeros(args.sim.iter, 1);
        args.patient.mu_prior(1:500) = 2.5;
        args.patient.mu_prior(500:1000) = 5;
        args.patient.mu_prior(1500:2000) = 1:6/800:7;
    otherwise
        error('Not implemented!')
end