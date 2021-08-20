%% Load data
%  Read from file & process, or...
load data2000_processed

%% Create a stacked bar plot in a new figure window
%  Set colormap for the bars, and make the plot
%  Keep the handles to the graphics objects
hf = figure('colormap',jet(6));
hb = bar(days,'stacked');
ha = gca;

%% Customize the plot
%  Change the bar width to be a little thicker
set(hb,'BarWidth',0.90)

%  Set the axis limits
xlim(ha,[0,13])
ylim(ha,[0,40])

%  Change the x-axis tick labels
mletters = {'J','F','M','A','M','J','J','A','S','O','N','D'};
set(ha,'XTick',1:12,'XTickLabel',mletters)

% Create y-ticks at every 10 units
set(ha,'YTick',0:10:40)

% Add axis annotations
xlabel(ha,'Month')
ylabel(ha,'Days')
legend(ha,catLabels,'location','NW')
