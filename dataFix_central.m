function [data] = dataFix_central(data)
data.out.n.old = length(data.out.NDAQ{1}.CH{1});


for j=1:length(data.out.NDAQ)
    
    for i=1:8
        TH=mean(mean(data.out.NDAQ{j}.CH{i}([1:15],: )));
        
%         inde{j}(i,:)=ones(1,length(max(data.out.NDAQ{j}.CH{i}([1:20],:))));
%         indd{j}(i,:)=ones(1,length(max(data.out.NDAQ{j}.CH{i}([60:100],:))));
%         indi{j}(i,:)=ones(1,length(min(data.out.NDAQ{j}.CH{i}([20:60],:))));
        
                inde{j}(i,:)=max(data.out.NDAQ{j}.CH{i}([1:20],:))<TH+4;
                indd{j}(i,:)=max(data.out.NDAQ{j}.CH{i}([60:100],:))<TH+5;
                indi{j}(i,:)=min(data.out.NDAQ{j}.CH{i}([20:60],:))>TH-10;
        %         [j i TH-4]
    end
    
    inde{j}=sum(inde{j})==8;
    indd{j}=sum(indd{j})==8;
    indi{j}=sum(indi{j})==8;
    ind{j} = (inde{j}+indd{j}+indi{j})==3;
    indpos{j} = find(ind{j}==1);
end

indfinal = indpos{1};

for j=1:length(data.out.NDAQ)
    indfinal=intersect(indfinal,indpos{j});
end

for j=1:length(data.out.NDAQ)
    for i=1:8
        data.out.NDAQ{j}.CH{i}=data.out.NDAQ{j}.CH{i}(:,indfinal);
    end
end

data.out.n.new = length(data.out.NDAQ{1}.CH{1});
disp(['MEASURE[DATA REMAINING][' num2str((data.out.n.new/data.out.n.old)*100) '%]'])