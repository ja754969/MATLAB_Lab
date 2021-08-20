function fh = mlbAutoPlot(wins,losses,teams,region)
%MLBAUTOPLOT plots the data for 

fh = figure;
barh([wins,losses])
legend('wins','losses','Location','E')
title(['American League Baseball - ',region,' - 2007'])
xlim([60,100])

% Update the tick labels
set(gca,'YTickLabel',teams)
