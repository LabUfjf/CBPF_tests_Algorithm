N = size(data.out.NDAQ{1}.CH{1}(20:60,:),1);
for j=1:length(data.out.NDAQ)
%     figure(data.out.NDAQNumber(j))
cl = ['gbrk'];
    for i=1:8
       TH= mean(data.out.NDAQ{j}.CH{i}(1:15,:));
        DATAMAX{j}(i,:)=  max(data.out.NDAQ{j}.CH{i}(20:60,:)-repmat(TH,N,1));
        DATASUM{j}(i,:)=  sum(data.out.NDAQ{j}.CH{i}(1:100,:)-repmat(TH,100,1));
        subplot(2,4,i);plot(DATAMAX{j}(i,:),DATASUM{j}(i,:),['.' cl(j)] ); hold on
        legend({'NDAQ 6','NDAQ 10','NDAQ 14','NDAQ 18'},'Location','NorthWest')
        axis tight
        xlabel('Peak Value')
        ylabel('Samples sum')
        zlabel('Saturation(%)')        
        title(['PMT' num2str(i)])
    end
hold on
end


