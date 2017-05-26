%% main TEST CBPF
clc; close all; clear variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file = 'raw_00000001_0001_1495054629.dat';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HABILITAR PLOTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
doPlot.NPMT = 0;        % Plot da eficiência pelo número de PMTs diparadas;'
doPlot.PMT = 0;         % Plot da eficiência de cada PMT individualmente
doPlot.ENERGY = 0;      % Histograma de energia
doPlot.SHAPE = 1;       % Plot de todos os Shapes dos eventos nas 8 PMTs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRIGGER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trigger.type = '';   % '' ou 'PMT' [Obs: '' = trigger somente com os pads]
trigger.pmt = 2;        % habilitado somente com type = 'PMT'; número da PMT
% utilizada no trigger pode ser vetor Ex:[ 1 2 4 5 6 7 8]
trigger.th = 4;         % habilitado com type = 'PMT' Threshold em ADC das PMTs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRATAMENTO DOS DADOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data.raw = importdata(file);           % carregar dados
[data.raw] = loaddata_neutrinos(file);
[data.out] = make_data_central(data.raw);      % modifica formato dos dados
% [data] = dataFix_central(data);                % ajustar dados removendo eventos estranhos

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CÁLCULO DAS EFICIÊNCIAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:length(data.out.NDAQNumber)
    [eff{i}] = PMTeff_central(data.out.NDAQ{i}.CH,trigger.type,trigger.th,trigger.pmt);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOTS FINAIS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if doPlot.NPMT == 1
    % Plot da eficiência pelo número de PMTs diparadas
    for i = 1:length(data.out.NDAQNumber)
        figure(data.out.NDAQNumber(i))
        plot_pro2_central(eff{1}.TH,100*eff{i}.max.NPMT,['Eficiência por PMTs Disparadas'],{'PMT\geq1';'PMT\geq2';'PMT\geq3';'PMT\geq4';'PMT\geq5';'PMT\geq6';'PMT\geq7';'PMT= 8'},'Limiar (ADC Counts)','Eficiência (%)',{'o';'s';'d';'^';'+';'v';'>';'<'});
        xlim([-127 127])
    end
end

if doPlot.PMT == 1;
    % Plot da eficiência de cada PMT individualmente
    for i = 1:length(data.out.NDAQNumber)
        figure(data.out.NDAQNumber(i))
        plot_pro2_central(eff{1}.TH,100*eff{i}.max.POS,['Eficiência Individual'],{'PMT 1';'PMT 2';'PMT 3';'PMT 4';'PMT 5';'PMT 6';'PMT 7';'PMT 8'},'Limiar (ADC Counts)','Eficiência (%)',{'o';'s';'d';'^';'+';'v';'>';'<'});
        axis tight
        xlim([-127 127])
    end
    
end

if doPlot.ENERGY == 1
    % Histograma de energia
    for i = 1:length(data.out.NDAQNumber)
        figure(data.out.NDAQNumber(i))
        [MS(i,:)]=plot_peak_central(data.out.NDAQ{i});
        axis tight
    end
    plot_peak_all_central(MS)
end

if doPlot.SHAPE == 1
    % Plot de todos os Shapes dos eventos
    for i = 1:length(data.out.NDAQNumber)
        figure(data.out.NDAQNumber(i))
        [M(i,:)]=plot_shape_central(data.out.NDAQ{i}); %title(['NDAQ ' num2str(data.out.NDAQNumber(i))])
    end
    
    figure
    bar3(M)
    set(gca,'yticklabels',{num2str(data.out.NDAQNumber)})
    xlabel('PMT')
    ylabel('NDAQ')
    zlabel('Saturation(%)')
    axis tight
    
end


