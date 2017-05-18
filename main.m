%% main TEST CBPF
clc; close all; clear variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

file = 'raw_00000001_0001_1494880326.dat';
% edit (file)  %--->>>>> APÓS REMOVER O HEADER COMENTAR ESSA LINHA <<<<<---

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HABILITAR PLOTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
doPlot.NPMT = 0;        % Plot da eficiência pelo número de PMTs diparadas;
doPlot.PMT = 0;         % Plot da eficiência de cada PMT individualmente
doPlot.ENERGY = 0;      % Histograma de energia
doPlot.SHAPE = 1;       % Plot de todos os Shapes dos eventos nas 4 PMTs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRIGGER
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trigger.type = '';   % '' ou 'PMT' [Obs: '' = trigger somente com os pads]
trigger.pmt = 3;        % habilitado somente com type = 'PMT'; número da PMT
                        % utilizada no trigger pode ser vetor Ex:[ 1 2 4]
trigger.th = 4;         % habilitado com type = 'PMT' Threshold em ADC das PMTs

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TRATAMENTO DOS DADOS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data.raw = importdata(file);           % carregar dados
[data.raw] = loaddata_neutrinos(file);
[data.out] = make_data_central(data.raw);      % modifica formato dos dados
[data] = dataFix_central(data);                % ajustar dados removendo eventos estranhos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CÁLCULO DAS EFICIÊNCIAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[eff] = PMTeff(data.out.NDAQ{1}.CH,trigger.type,trigger.th,trigger.pmt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%PLOTS FINAIS:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if doPlot.NPMT == 1
    % Plot da eficiência pelo número de PMTs diparadas
    plot_pro2(100*eff.max.NPMT,['Eficiência por PMTs Disparadas'],{'PMT\geq1';'PMT\geq2';'PMT\geq3';'PMT\geq4'},'Limiar (ADC Counts)','Eficiência (%)',{'o';'s';'d';'^';'+'});
    xlim([4 30])
end

if doPlot.PMT == 1;
    % Plot da eficiência de cada PMT individualmente
    plot_pro2(100*eff.max.POS,['Eficiência Individual'],{'PMT 1';'PMT 2';'PMT 3';'PMT 4'},'Limiar (ADC Counts)','Eficiência (%)',{'o';'s';'d';'^';'+'});
    axis tight
    xlim([4 30])
    
end

if doPlot.ENERGY == 1
    % Histograma de energia
    plot_peak(data);
    xlim([0 60])
end

if doPlot.SHAPE == 1
    % Plot de todos os Shapes dos eventos
    plot_shape(data)
end