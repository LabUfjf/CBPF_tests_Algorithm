function [data,ind] = find_error_NDAQ(data,ind)

    data = data(ind.meas,:);
    A=find(data(:,1)==903);
    B=diff(A);
    C=find(B~=101);
    ind.wrong = A(C)+1;
    ind.meas = setdiff(1:length(data),ind.wrong);
    data = data(ind.meas,:);  
    
end