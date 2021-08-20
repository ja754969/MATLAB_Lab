%% finPlot Plot example revenue/expenditure data

%% 1. Load the data
load acmeprofit

%% 2. Plot the custom figure.
figure
%  Define matrix for area() call.  First column is baseline.  Second is how
%  much rev > xpns (use 0 where xpns >= rev).  Third is how
%  much xpns > rev.
z = [min(rev,xpns),max(rev-xpns,0),max(xpns-rev,0)];
%  Make area plot
ha = area(dt,z);
%  And remove the solid area below the baseline
set(ha(1),'FaceColor','none') % this makes the bottom area invisible
%  Color areas & remove edges
set(ha(2),'FaceColor','k')
set(ha(3),'FaceColor','r')
set(ha,'LineStyle','none')
%  If return value requested, return relevant area objects
if nargout
    varargout{1} = ha(2:3);
end

%  Add line series
lh1 = line(dt,rev,'Color','k');
lh2 = line(dt,xpns,'Color','r');

% Make the x-axis readable
datetick('x','keeplimits')

% Annotate the plot
xlabel('Date')
ylabel({'Revenue (black) and expenditure (red)';'(in $10,000s)'})
title('Profit/loss for ACME Corp.')
