% Generate precision sequence per patient
function [args] = generate_precision(args)

switch args.sim.pi_case
    case 0
        % Initialize with pi_rest
        pi_rest = 1;
        args.patient.pi = pi_rest.* ones(args.sim.iter, 1);
        % Compute modified damped harmonic function
        omega = 0.05;
        gamma = 0.05;
        timestep = 100;
        dh_k = modified_damped_harmonic(omega, gamma, timestep);
        % Add a precision increase at 0.8*iter that ends at 0.9*iter
        % following Stephan et al. 2016
        % Bias added to centralize the damped harmonics
        %   Important, due to the modification, the harmonic is not always
        %   centered, but due to the symmetry, the duration between half
        %   maxima's are equal to timestep.
        ks = args.sim.iter * 0.75 + timestep / 2; % k_start
        ke = args.sim.iter * 0.88 + timestep / 2; % k_end
        precision_delta = 3;
        args.patient.pi(ks:ks+timestep-1) = args.patient.pi(ks:ks+timestep-1) + ...
                                            flip(dh_k) * precision_delta;
        args.patient.pi(ks+timestep:ke-1) = args.patient.pi(ks+timestep:ke-1) + ...
                                            precision_delta;
        args.patient.pi(ke:ke+timestep-1) = args.patient.pi(ke:ke+timestep-1) + ...
                                            dh_k * precision_delta;
    case 1
        % Initialize with pi_rest
        pi_rest = 1;
        args.patient.pi = pi_rest.* ones(args.sim.iter, 1);
        % Compute modified damped harmonic function
        omega = 0.05;
        gamma = 0.05;
        timestep = 100;
        dh_k = modified_damped_harmonic(omega, gamma, timestep);
        
        ks = args.sim.iter * 0.25 + timestep / 2; % k_start
        ke = args.sim.iter * 0.38 + timestep / 2; % k_end
        precision_delta = 2;
        args.patient.pi(ks:ks+timestep-1) = args.patient.pi(ks:ks+timestep-1) + ...
                                            flip(dh_k) * precision_delta;
        args.patient.pi(ks+timestep:ke-1) = args.patient.pi(ks+timestep:ke-1) + ...
                                            precision_delta;
        args.patient.pi(ke:ke+timestep-1) = args.patient.pi(ke:ke+timestep-1) + ...
                                            dh_k * precision_delta;
        
        ks = args.sim.iter * 0.40 + timestep / 2; % k_start
        ke = args.sim.iter * 0.60 + timestep / 2; % k_end
        precision_delta = 2;                                
                                        
        args.patient.pi(ks:ks+timestep-1) = args.patient.pi(ks:ks+timestep-1) + ...
                                            flip(dh_k) * precision_delta;
        args.patient.pi(ks+timestep:ke-1) = args.patient.pi(ks+timestep:ke-1) + ...
                                            precision_delta;
        args.patient.pi(ke:ke+timestep-1) = args.patient.pi(ke:ke+timestep-1) + ...
                                            dh_k * precision_delta;
          
                                        
        ks = args.sim.iter * 0.55 + timestep / 2; % k_start
        ke = args.sim.iter * 0.65 + timestep / 2; % k_end
        precision_delta = 2;
        args.patient.pi(ks:ks+timestep-1) = args.patient.pi(ks:ks+timestep-1) + ...
                                            flip(dh_k) * precision_delta;
        args.patient.pi(ks+timestep:ke-1) = args.patient.pi(ks+timestep:ke-1) + ...
                                            precision_delta;
        args.patient.pi(ke:ke+timestep-1) = args.patient.pi(ke:ke+timestep-1) + ...
                                            dh_k * precision_delta;                                
                                        
        ks = args.sim.iter * 0.75 + timestep / 2; % k_start
        ke = args.sim.iter * 0.88 + timestep / 2; % k_end
        precision_delta = 3;
        args.patient.pi(ks:ks+timestep-1) = args.patient.pi(ks:ks+timestep-1) + ...
                                            flip(dh_k) * precision_delta;
        args.patient.pi(ks+timestep:ke-1) = args.patient.pi(ks+timestep:ke-1) + ...
                                            precision_delta;
        args.patient.pi(ke:ke+timestep-1) = args.patient.pi(ke:ke+timestep-1) + ...
                                            dh_k * precision_delta;                                    
    otherwise
        error('Not implemented!')
end