function plotHurricane(avgWS,days)
% plotHurricane 
% Inputs: a vector of average wind speeds for each month and a matrix of
%         (average) days per month storms of each category were recorded
% Outputs: none returned, but a customized plot is created

% Create a cell array of text labels for the hurricane categories
catLabels = {'TS';'1';'2';'3';'4';'5'};

% Create a stacked bar plot in a new figure window
% Set colormap for the bars, and make the plot
% Keep the handles to the graphics objects
hf = figure('colormap',jet(6));
hb = bar(days,'stacked');
ha = gca;

% Customize the plot
% Change the bar width to be a little thicker
set(hb,'BarWidth',0.90)

% Set the axis limits
xlim(ha,[0,13])
ylim(ha,[0,40])

% Change the x-axis tick labels
mletters = {'J','F','M','A','M','J','J','A','S','O','N','D'};
set(ha,'XTick',1:12,'XTickLabel',mletters)

% Create y-ticks at every 10 units
set(ha,'YTick',0:10:40)

% Add axis annotations
xlabel(ha,'Month')
ylabel(ha,'Days')
legend(ha,catLabels,'location','NW')

% Add the line plot
% Create a new set of axes in the same figure
ha2 = axes('parent',hf);
% Plot into the new axes
plot(ha2,avgWS,'Color','r','LineWidth',2)
% Clean up properties of the new axes:
% - make them transparent
% - turn off the x-axis ticks (both axes have the same x-axis)
% - y-axis a different color and on the right
% - limits and ticks are the same
set(ha2,'Color','none','YAxisLocation','right','XTick',[],...
    'YColor','r','Box','off')
set(ha2,'XLim',[0,13],'YLim',[0,100],'YTick',0:25:100)
% Ensure the new axes are *exactly* aligned with the old ones
% Use get to query, then set to apply
set(ha2,'Position',get(ha,'Position'))

% Add a label to the new y-axis
ylabel(ha2,'Wind speed [mph]')
