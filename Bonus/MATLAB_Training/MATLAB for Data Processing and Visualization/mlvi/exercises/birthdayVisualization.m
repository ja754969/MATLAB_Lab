%% BIRTHDAYVISUALIZATION  Plots birthday data for 1978

%% 1. Import variables
load('birthdayData')

%% 2. Create a bar plot for the number of births per month
% Create a bar plot of the tally
hfM = figure;
haM = axes('Parent',hfM);
hoM = bar(haM,monthTally);

% Format the bar plot
set(haM, 'XTickLabel', allMonths);
                    
set(haM, 'XLim', [0.5 12.5]);
set(haM, 'YLim', [0 max(monthTally) + 0.05*max(monthTally)]);

%% 3. Create a bar plot for the number of births per day
% Create a bar plot of the tally
hfD = figure;
haD = axes('Parent',hfD);
hoD = bar(haD,dayTally);

% Format the bar plot
set(haD, 'XTickLabel', allDays);
set(haD, 'XLim', [0.5 7.5]);
set(haD, 'YLim', [0 max(dayTally) + 0.05*max(dayTally)]);
set(hoD, 'FaceColor', 'r', 'EdgeColor', 'r')
