function [dataout] = make_data(data)
%% SEPARAR OS SINAIS DAS PMTS EM AMOSTRAS POR EVENTOS
ind.all = 1:length(data(:,1)); 
ind.setup = union(find(data(:,1)==902),find(data(:,1)==903)); % SELECIONAR CABEÇALHOS DA AQUISIÇÃO
% ind.setup = (find(data(:,1)==902)); % SELECIONAR CABEÇALHOS DA AQUISIÇÃO
ind.meas = setdiff(ind.all,ind.setup); % REMOVER OS CABEÇALHOS
ok = mod(length(ind.meas),101); % PROTEÇÃO PARA GARANTIR QUE TEMOS 100 AMOSTRAS PARA CADA  EVENTO
%% ORGANIZAR O SINAL DAS QUATRO(4) PMTS

if ok == 0
    disp('MEASURE[OK]')
    dataout.CH{1} = reshape(data(ind.meas,4),100,length(ind.meas)/100);
    dataout.CH{2} = reshape(data(ind.meas,5),100,length(ind.meas)/100);
    dataout.CH{3} = reshape(data(ind.meas,6),100,length(ind.meas)/100);
    dataout.CH{4} = reshape(data(ind.meas,7),100,length(ind.meas)/100);
    
    dataout.CH{5} = reshape(data(ind.meas,8),100,length(ind.meas)/100);
    dataout.CH{6} = reshape(data(ind.meas,9),100,length(ind.meas)/100);
    dataout.CH{7} = reshape(data(ind.meas,10),100,length(ind.meas)/100);
    dataout.CH{8} = reshape(data(ind.meas,11),100,length(ind.meas)/100); 
else
    disp('MEASURE[ERROR]')
end

dataout.n.old = length(dataout.CH{1});
