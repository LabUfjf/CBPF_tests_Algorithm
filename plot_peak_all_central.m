function [] = plot_peak_all_central(MS)
figure
[ys,xs]=hist(sum(MS),256);
stairs(xs,ys,'k')
set(gca, 'YScale','log');
legend('\SigmaEnergy');
% set(h,'FontSize',14);

axis tight
% title(['Energy (Pico)'])
ylabel('log(Events)')
xlabel('Amplitude (ADC Counts)')
grid on
set(gca,'GridLineStyle',':')
end