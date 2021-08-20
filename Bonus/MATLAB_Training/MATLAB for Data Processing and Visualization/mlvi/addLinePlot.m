%% Create the bar plot
makeBarPlot

%% Add the line plot
%  Create a new set of axes in the same figure
ha2 = axes('parent',hf);
%  Plot into the new axes
plot(ha2,avgWS,'Color','r','LineWidth',2)
%  Clean up properties of the new axes:
%  - make them transparent
%  - turn off the x-axis ticks (both axes have the same x-axis)
%  - y-axis a different color and on the right
%  - limits and ticks are the same
set(ha2,'Color','none','YAxisLocation','right','XTick',[],...
    'YColor','r','Box','off')
set(ha2,'XLim',[0,13],'YLim',[0,100],'YTick',0:25:100)
%  Ensure the new axes are *exactly* aligned with the old ones
%  Use get to query, then set to apply
set(ha2,'Position',get(ha,'Position'))

%  Add a label to the new y-axis
ylabel(ha2,'Wind speed [mph]')
