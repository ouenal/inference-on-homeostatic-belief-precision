% Source material: K.  E.  Stephan,  Z.  M.  Manjaly,  C.  D.  Mathys,  
% L.  A.  E.  Weber,  S.  Pali-wal,  T.  Gard,  M.  Tittgemeyer,  
% S.  M.  Fleming,  H.  Haker,  A.  K.  Seth,and  F.  H.  Petzschner, 
% “Allostatic  self-efficacy:  A  metacognitive  theory  of dyshomeostasis-
% induced fatigue and depression, Frontiers in Human Neu-roscience, vol. 
% 10, p. 550, 2016.
function [args] = simulate_patient(args)

% Parameter allocation
iter = args.sim.iter;

% Allocate space
args.patient.y  = zeros(iter, 1);
args.patient.PE = zeros(iter, 1);
args.patient.a  = zeros(iter, 1);
args.patient.S  = zeros(iter, 1);
args.patient.x  = zeros(iter, 1);

% Variable initialization
args.patient.x(1) = args.patient.mu_prior(1);

% Allostatic control
for i = 1:iter - 1
    args.sim.current_iter = i;
    % Generate sensory input
    args.patient.y(i) = sample_sensory_signal(args.patient.x(i), args.patient.pi_data);
    args.patient.PE(i) = args.patient.y(i) - args.patient.mu_prior(i);
    % Differential equations
    args.patient.a(i) = -args.patient.pi(i) * args.patient.PE(i);
    dx = args.patient.a(i) / args.patient.lambda;
    args.patient.x(i+1) = args.patient.x(i) + dx + args.patient.u(i);
end

if args.patient.plot.PLOT || args.patient.plot.SAVE
    plot_patient(args);
end

end



