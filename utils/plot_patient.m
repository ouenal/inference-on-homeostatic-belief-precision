function [] = plot_patient(args)

% Variables
fontsize = 12;
iter = args.sim.iter;
tick_width = iter/20;
color = 'k';

% Plot
f1 = figure;
f1.Position = [145   183   924   522];

if ~args.patient.plot.PLOT
    f1.Visible = 'off';
end

suprise = -1/2*(log(args.patient.pi(1:iter)) - args.patient.pi(1:iter).*( args.patient.y(1:iter) - args.patient.mu_prior(1:iter)).^2);
sp1 = subplot(411);
    plot(args.patient.x(1:iter),'Color',color);
    set(sp1,'XTick',1:tick_width:iter,'XTickLabel',[],'YTick',[0, 5],'FontSize',fontsize)
    set(sp1,'XGrid','on','GridLineStyle',':','GridColor','k','GridAlpha',0.5)
    ylim([-1, 3])
    yticks([0, 1, 2])
    pbaspect([6 1 1])
sp2 = subplot(412);
    plot(suprise,'Color',color)
    set(sp2,'XTick',1:tick_width:iter,'XTickLabel',[],'YTick',[0, 5],'FontSize',fontsize)
    set(sp2,'XGrid','on','GridLineStyle',':','GridColor','k','GridAlpha',0.5)
    ylim([-1, 7])
    yticks([0 5])
    pbaspect([6 1 1])
sp3 = subplot(413);
    plot(args.patient.a(1:iter),'Color',color)
    set(sp3,'XTick',1:tick_width:iter,'XTickLabel',[],'YTick',[-7, 7],'FontSize',fontsize)
    set(sp3,'XGrid','on','GridLineStyle',':','GridColor','k','GridAlpha',0.5)
    ylim([-9, 9])
    yticks([-7, 0, 7])
    pbaspect([6 1 1])
    
sp4 = subplot(414);
    plot(args.patient.pi,'Color',color)
    ylim([0 7])
    set(sp4,'XTick',1:tick_width:iter,'XTickLabel',[],'YTick',[1, 5],'FontSize',fontsize)
    set(sp4,'XGrid','on','GridLineStyle',':','GridColor','k','GridAlpha',0.5)
    pbaspect([6 1 1])
    yticks([1, 4])

% Save
if args.patient.plot.SAVE
    f1.PaperPositionMode='auto';
    print(args.patient.plot.save_dir,'-dsvg')
end

end