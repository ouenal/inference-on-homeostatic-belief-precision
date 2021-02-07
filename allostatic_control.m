clear all
close all
rng(14)

% Define simulation parameters
args.sim.iter = 2000;
args.sim.pi_a = 100;
args.sim.mu_prior_case = 0; 	% Cases defined in generate_prior_mean.m
args.sim.pi_case = 1; 			% Cases defined in generate_precision.m
args.sim.perturbation_case = 0; % Cases defined in generate_perturbation.m

% Define patient parameters
args.patient.pi_data = 2;
args.patient.lambda = 50;
args.patient.plot.PLOT = 0;
args.patient.plot.SAVE = 0;
args.patient.plot.save_dir = 'figs/model';

% Define model parameters
args.model.window_size = 15;
args.model.MODEL = 'stdp' ; 	% stdp or lepe
args.model.plot.PLOT = 0;
args.model.plot.SAVE = 0;
args.model.plot.save_dir = ['figs/' args.model.MODEL];

% Main
args = generate_prior_mean(args);
args = generate_precision(args);
args = generate_perturbation(args);
args = simulate_patient(args);
args = infer_precision(args);




