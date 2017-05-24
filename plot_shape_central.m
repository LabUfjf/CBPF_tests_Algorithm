function [M] = plot_shape_central(data)
% figure
for i = 1:8
subplot(2,4,i); 
if size(data.CH{i},2)>10000
    n=10000;
else
    n = size(data.CH{i},2);
end
plot(1:100,data.CH{i}(:,1:n),'-'); axis tight; title(['PMT ' num2str(i)]); xlabel('Samples'); ylabel('ADC Counts')
T=length(data.CH{i});
S= sum(max(data.CH{i})==127);
M(i) = (S/T)*100;


end