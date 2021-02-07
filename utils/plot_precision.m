function [] = plot_precision(args)

% Variables
fontsize = 12;
iter = args.sim.iter;
tick_width = iter/20;
switch args.model.MODEL
    case 'stdpuk'
        NORM = 1;
    case 'wepuk'
        NORM = 1;
    otherwise
        NORM = 0;
end
if NORM
    k=100;
    args.patient.pi =(args.patient.pi - mean(mink(args.patient.pi,k)))./(mean(maxk(args.patient.pi,k))-mean(mink(args.patient.pi,10)));
    args.estimate.pi=(args.estimate.pi - mean(mink(args.estimate.pi,k)))./(mean(maxk(args.estimate.pi,k))-mean(mink(args.estimate.pi,10)));
end

size_es = size(args.estimate.pi);
size_pa = size(args.patient.pi);
delayed_estimate = zeros(size_pa);
delayed_estimate(size_pa(1)-size_es(1)+1:size_pa(1)) = args.estimate.pi;
args.estimate.pi = smoothdata(delayed_estimate, 'movmean', 55);

% Plot
f1 = figure('Position',[1 1 924 522],'Color',[1 1 1]);
if ~args.model.plot.PLOT
    f1.Visible = 'off';
end
    hold on
    plot(args.patient.pi, 'k', 'LineWidth',1.25);  % True distribution in black
    plot(args.estimate.pi , 'r')               % Windowed std in red 
    if NORM
        ylim([-0.5 1.5])
    else
        ylim([0 6])
    end
    pbaspect([6 1 1])
    set(gca,'FontSize',16)
    box on
    hold off
    ax1 = gca;
    if NORM
       set(ax1,'XTick',1:tick_width:iter,'XTickLabel',[],'YTick',[0, 1],'FontSize',fontsize)
       yticks([0, 1])
    else
       set(ax1,'XTick',1:tick_width:iter,'XTickLabel',[],'YTick',[0, 5],'FontSize',fontsize)
        yticks([1, 4])
    end
    set(ax1,'XGrid','on','GridLineStyle',':','GridColor','k','GridAlpha',0.5)
% Save
if args.model.plot.SAVE
    f1.PaperPositionMode='auto';
    print(args.model.plot.save_dir,'-dsvg')
end

end

