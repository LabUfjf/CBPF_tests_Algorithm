function [data] = dataFix(data)

for i=1:4
    inde(i,:)=max(data.out.CH{i}([1:20],:))<4;
    indd(i,:)=max(data.out.CH{i}([60:100],:))<5;
end
inde=sum(inde)==4;
indd=sum(indd)==4;
ind = (inde+indd)==2;

for i=1:4
    data.out.CH{i}=data.out.CH{i}(:,ind);
end

data.out.n.new = length(data.out.CH{1});
disp(['MEASURE[DATA REMAINING][' num2str((data.out.n.new/data.out.n.old)*100) '%]'])