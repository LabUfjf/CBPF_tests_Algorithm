function [MS] = plot_peak_central(data)

for j = 1:8
    TH(j) = mean(mean(data.CH{j}(1:15,:)));
end

for i = 1:size(data.CH{1},2)
    M1(i) = max(data.CH{1}(:,i));
    M2(i) = max(data.CH{2}(:,i));
    M3(i) = max(data.CH{3}(:,i));
    M4(i) = max(data.CH{4}(:,i));
    M5(i) = max(data.CH{5}(:,i));
    M6(i) = max(data.CH{6}(:,i));
    M7(i) = max(data.CH{7}(:,i));
    M8(i) = max(data.CH{8}(:,i));
    
    MTH1(i) = max(data.CH{1}(:,i))-TH(1);
    MTH2(i) = max(data.CH{2}(:,i))-TH(2);
    MTH3(i) = max(data.CH{3}(:,i))-TH(3);
    MTH4(i) = max(data.CH{4}(:,i))-TH(4);
    MTH5(i) = max(data.CH{5}(:,i))-TH(5);
    MTH6(i) = max(data.CH{6}(:,i))-TH(6);
    MTH7(i) = max(data.CH{7}(:,i))-TH(7);
    MTH8(i) = max(data.CH{8}(:,i))-TH(8);
    
    MS(i) =   MTH1(i)+ MTH2(i)+ MTH3(i)+ MTH4(i)+ MTH5(i)+ MTH6(i)+ MTH7(i)+ MTH8(i);
end

% bin = 1000*calcnbins(M1,'fd');
bin = 256;
% figure
[y1,x1]=hist(M1,bin);
hold on
[y2,x2]=hist(M2,bin);
[y3,x3]=hist(M3,bin);
[y4,x4]=hist(M4,bin);
[y5,x5]=hist(M5,bin);
[y6,x6]=hist(M6,bin);
[y7,x7]=hist(M7,bin);
[y8,x8]=hist(M8,bin);
[ys,xs]=hist(MS,bin);
% set(gca,'FontSize',14);
x1=x1(y1~=0); y1 = y1(y1~=0);
x2=x2(y2~=0); y2 = y2(y2~=0);
x3=x3(y3~=0); y3 = y3(y3~=0);
x4=x4(y4~=0); y4 = y4(y4~=0);
x5=x5(y5~=0); y5 = y5(y5~=0);
x6=x6(y6~=0); y6 = y6(y6~=0);
x7=x7(y7~=0); y7 = y7(y7~=0);
x8=x8(y8~=0); y8 = y8(y8~=0);
xs=xs(ys~=0); ys = ys(ys~=0);
subplot(1,2,1);stairs(x1,y1,'k'); hold on
subplot(1,2,1);stairs(x2,y2,'r')
subplot(1,2,1);stairs(x3,y3,'b')
subplot(1,2,1);stairs(x4,y4,'c')
subplot(1,2,1);stairs(x5,y5,'k:')
subplot(1,2,1);stairs(x6,y6,'r:')
subplot(1,2,1);stairs(x7,y7,'b:')
subplot(1,2,1);stairs(x8,y8,'c:')
subplot(1,2,1);set(gca, 'YScale','log');
subplot(1,2,1);legend('PMT1','PMT2','PMT3','PMT4','PMT5','PMT6','PMT7','PMT8');
% set(h,'FontSize',14);

subplot(1,2,1);axis tight
subplot(1,2,1);title(['Energia (Pico)'])
subplot(1,2,1);ylabel('log(Eventos)')
subplot(1,2,1);xlabel('Pico de Amplitude (ADC Counts)')
subplot(1,2,1);grid on
subplot(1,2,1);set(gca,'GridLineStyle',':')

subplot(1,2,2);stairs(xs,ys,'k')
subplot(1,2,2);set(gca, 'YScale','log');
subplot(1,2,2);legend('(PMT(1:8))');
% set(h,'FontSize',14);

subplot(1,2,2);axis tight
subplot(1,2,2);title(['Energia (Pico)'])
subplot(1,2,2);ylabel('log(Eventos)')
subplot(1,2,2);xlabel('Somatório dos Picos de Amplitude (ADC Counts)')
subplot(1,2,2);grid on
subplot(1,2,2);set(gca,'GridLineStyle',':')
% h = findobj(gca,'Type','patch');
% h(1).FaceColor = 'None';
% h(1).EdgeColor = 'c';
% h(1).LineWidth = 0.5;
% h(1).LineStyle= 'none';
% h(1).Marker = '^';
% h(1).MarkerSize= 4;
%
%
% h(2).FaceColor = 'None';
% h(2).EdgeColor = 'b';
% h(2).LineWidth = 0.5;
% h(2).LineStyle= 'none';
% h(2).Marker = 'd';
% h(2).MarkerSize= 4;
%
%
% h(3).FaceColor = 'None';
% h(3).EdgeColor = 'r';
% h(3).LineWidth = 0.5;
% h(3).LineStyle= 'none';
% h(3).Marker = 's';
% h(3).MarkerSize= 4;
%
% h(4).FaceColor = 'None';
% h(4).EdgeColor = 'k';
% h(4).LineWidth = 0.5;
% h(4).LineStyle= 'none';
% h(4).Marker = 'o';
% h(4).MarkerSize= 4;


% set(gca, 'YScale','log');

%

% filename=['Gray_PeakAmplitude_' pad '_' veto '_' pmt];
% saveas(gcf,['Figuras\Eff\POS_v3\' filename '.fig']);
% saveas(gcf,['Figuras\Eff\POS_v3\' filename '.png']);
% saveas(gcf,['Figuras\Sinal\Amplitude\' filename '.fig']);
% saveas(gcf,['Figuras\Sinal\Amplitude\' filename '.png']);
