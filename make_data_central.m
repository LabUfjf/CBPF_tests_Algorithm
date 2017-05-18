function [dataout] = make_data_central(data)
%% SEPARAR OS SINAIS DAS PMTS EM AMOSTRAS POR EVENTOS
ind.all = 1:length(data(:,1));
ind.setup = (find(data(:,1)==902)); % SELECIONAR CABEÇALHOS DA AQUISIÇÃO
ind.meas = setdiff(ind.all,ind.setup); % REMOVER OS CABEÇALHOS
ok = mod(length(ind.meas),101); % PROTEÇÃO PARA GARANTIR QUE TEMOS 100 AMOSTRAS PARA CADA  EVENTO

if ok == 0
    disp('MEASURE[OK]')
    data = data(ind.meas,:);
else
     disp(['MEASURE[ERROR][REMOVING FAIL EVENTS = ' num2str(round(ok/4)) ']'])     
    [data] = find_error_NDAQ(data,ind); 
    ok = mod(length(data),101); % PROTEÇÃO PARA GARANTIR QUE TEMOS 100 AMOSTRAS PARA CADA  EVENTO

end

ind_ndaq = find(data(:,1)==903);
Ndaq=data(ind_ndaq ,2);
data = data(setdiff(1:length(data),ind_ndaq),:);
% length(Ndaq)
% pause
Nevt = length(ind_ndaq);

if Nevt >= 40000
Nevt = 40000;
end

for i = 1:Nevt
    AQNdaq(i,:) = ones(1,100).*Ndaq(i);
end

AQNdaq = reshape(AQNdaq',1,100*Nevt);
NdaqNumber=unique(Ndaq);

if ok == 0
    disp('MEASURE[OK]')
    for indaq = 1:length(NdaqNumber);
        ind_data = find(AQNdaq==NdaqNumber(indaq));
        
        dataout.NDAQ{indaq}.CH{1} = reshape(data(ind_data,4),100,length(ind_data)/100);
        dataout.NDAQ{indaq}.CH{2} = reshape(data(ind_data,5),100,length(ind_data)/100);
        dataout.NDAQ{indaq}.CH{3} = reshape(data(ind_data,6),100,length(ind_data)/100);
        dataout.NDAQ{indaq}.CH{4} = reshape(data(ind_data,7),100,length(ind_data)/100);
        
        dataout.NDAQ{indaq}.CH{5} = reshape(data(ind_data,8),100,length(ind_data)/100);
        dataout.NDAQ{indaq}.CH{6} = reshape(data(ind_data,9),100,length(ind_data)/100);
        dataout.NDAQ{indaq}.CH{7} = reshape(data(ind_data,10),100,length(ind_data)/100);
        dataout.NDAQ{indaq}.CH{8} = reshape(data(ind_data,11),100,length(ind_data)/100);
        
    end
    dataout.NDAQNumber = NdaqNumber;
else
    disp('MEASURE[ERROR][REMOVING EVENTS][FAIL]')
end
