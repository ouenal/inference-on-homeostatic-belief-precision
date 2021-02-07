function [args] = generate_perturbation(args)

switch args.sim.perturbation_case
    case 0
        args.patient.u = zeros(args.sim.iter, 1);
        args.patient.u(150) = -1.5;
        args.patient.u(900) = -1.5;
        args.patient.u(1700) = 1.5;
    otherwise
        error('Not implemented!')
end