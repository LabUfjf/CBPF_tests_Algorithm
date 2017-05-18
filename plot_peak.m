function [] = plot_peak(data)

for i = 1:size(data.out.CH{1},2)
    M1(i) = max(data.out.CH{1}(:,i));
    M2(i) = max(data.out.CH{2}(:,i));
    M3(i) = max(data.out.CH{3}(:,i));
    M4(i) = max(data.out.CH{4}(:,i));
end


figure
[y1,x1]=hist(M1,1000*calcnbins(M1,'fd'));
hold on
[y2,x2]=hist(M2,1000*calcnbins(M1,'fd'));
[y3,x3]=hist(M3,1000*calcnbins(M1,'fd'));
[y4,x4]=hist(M4,1000*calcnbins(M1,'fd'));

% set(gca,'FontSize',14);
x1=x1(y1~=0); y1 = y1(y1~=0);
x2=x2(y2~=0); y2 = y2(y2~=0);
x3=x3(y3~=0); y3 = y3(y3~=0);
x4=x4(y4~=0); y4 = y4(y4~=0);

stairs(x1,y1,'k')
stairs(x2,y2,'r')
stairs(x3,y3,'b')
stairs(x4,y4,'c')
set(gca, 'YScale','log');

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
legend('PMT1','PMT2','PMT3','PMT4');
% set(h,'FontSize',14);

axis tight
title(['Energia (Pico)'])
ylabel('log(Eventos)')
xlabel('Pico de Amplitude (ADC Counts)')
grid on
% 

% filename=['Gray_PeakAmplitude_' pad '_' veto '_' pmt];
% saveas(gcf,['Figuras\Eff\POS_v3\' filename '.fig']);
% saveas(gcf,['Figuras\Eff\POS_v3\' filename '.png']);
% saveas(gcf,['Figuras\Sinal\Amplitude\' filename '.fig']);
% saveas(gcf,['Figuras\Sinal\Amplitude\' filename '.png']);
