function [] = plot_shape(data)
figure
for i = 1:4
subplot(2,2,i); 
plot(1:100,data.out.CH{i},':'); axis tight; title(['PMT ' num2str(i)]); xlabel('Samples'); ylabel('ADC Counts')
end