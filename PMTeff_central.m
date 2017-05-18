function [eff] = PMTeff_central(data,trigger,TH,PMT)

if strcmp(trigger,'PMT')
    k = 0;
    for i = PMT
        k=k+1;
        TGG(k,:)=max(data{i})>=TH;
    end
    if length(PMT)>1
        TGG=sum(TGG)>=1;
    else
        TGG=TGG>=1;
    end
    for i = 1:8
        %        sum(TGG)
        data{i}=data{i}(:,TGG);
        %          size(data{i})
        %          hist(max(data{i}),10000)
        %          pause
        %          close
    end
    N = sum(TGG);
else
    N = size(data{1},2);
end
% CALCULAR A POTENCIA M�DIA DO SINAL
% for i = 1:length(data)
%     [~,data_P{i}] = energy_signal(data{i});
% end
% CRIAR MATRIZES COM M�XIMO E POTENCIA M�DIA DOS SINAIS
MATRIX_max = [max(data{1}); max(data{2}); max(data{3}); max(data{4}); max(data{5}); max(data{6}); max(data{7}); max(data{8})];


% MATRIX_max
% pause
% MATRIX_P = [data_P{1}; data_P{2}; data_P{3}; data_P{4}];
%==========================================================================
% CALCULAR EFICI�NCIA PARA M�XIMO VALOR DO SINAL
%==========================================================================
 % n�mero total de eventos
i = 0;
TH =-127:127;
for THmax = -127:127; % variar limiar em todo range do ADC
    i = i+1;
    hits_max{i}=MATRIX_max>=THmax;
    % efici�ncia em todas as posi��es
    eff.max.POS(i,:)= sum(hits_max{i}')/N;
    % efici�ncia em fun��o do n�mero de PMTs
    eff.max.NPMT(i,1)= sum(sum(hits_max{i})>=1)/N;
    eff.max.NPMT(i,2)= sum(sum(hits_max{i})>=2)/N;
    eff.max.NPMT(i,3)= sum(sum(hits_max{i})>=3)/N;
    eff.max.NPMT(i,4)= sum(sum(hits_max{i})>=4)/N;
    eff.max.NPMT(i,5)= sum(sum(hits_max{i})>=5)/N;
    eff.max.NPMT(i,6)= sum(sum(hits_max{i})>=6)/N;
    eff.max.NPMT(i,7)= sum(sum(hits_max{i})>=7)/N;
    eff.max.NPMT(i,8)= sum(sum(hits_max{i})==8)/N;

    
end
eff.TH = TH;
%==========================================================================
% CALCULAR EFICI�NCIA PARA POTENCIA M�DIA
%==========================================================================
% maxP=max(max([data_P{1} data_P{2} data_P{3} data_P{4}]));
% minP=min(min([data_P{1} data_P{2} data_P{3} data_P{4}]));
% i=0;
% for THP = 0:(maxP-minP)/127:maxP % variar limiar em todo range da pot�ncia m�dia
%     i = i+1;
%     hits_P{i}=MATRIX_P>=THP;
%     % efici�ncia em todas as posi��es
%     eff.P.POS(i,:)= sum(hits_P{i}')/N;
%     % efici�ncia em fun��o do n�mero de PMTs
%     eff.P.NPMT(i,1)= sum(sum(hits_P{i})>=1)/N;
%     eff.P.NPMT(i,2)= sum(sum(hits_P{i})>=2)/N;
%     eff.P.NPMT(i,3)= sum(sum(hits_P{i})>=3)/N;
%     eff.P.NPMT(i,4)= sum(sum(hits_P{i})==4)/N;
% end

end