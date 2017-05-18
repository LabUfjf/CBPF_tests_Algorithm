function [  ] = plot_pro2( x,tit,leg,xlab,ylab,mark)
%%----------------------------------------------------------------------%%
% Essa função é utilizada para realizar plots no padrão FIFA             %
%                                                                        %
% Para essa função funcionar os dados 'x' e 'y' tem de ser CELL          %
% bem como a LEGENDA                                                     %
%%----------------------------------------------------------------------%%

[~,b]=size(x);
% c={[mark{1} 'k'];[mark{2} 'r'];[mark{3} 'b'];[mark{4} 'c'];[mark{5} 'g']};
c={[mark{1}];[mark{2}];[mark{3}];[mark{4}];[mark{5}];[mark{6}];[mark{7}];[mark{8}]};
cl = ['krbckrbc'];
% axes('Fontsize',16);
figure
for i=1:b 
%     plot(x(:,i),c{i},'DisplayName',leg{i})
      plot(x(:,i),'Marker',c{i},'MarkerSize',4,'linestyle','none','Color',cl(i),'DisplayName',leg{i});
    hold on
end
h=legend('show','Location','Best');
set(h,'FontSize',14);
title(tit)
ylabel(ylab);
xlabel(xlab);
grid on
axis tight
end

