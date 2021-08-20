%% HURRVISI -- Plots two measures of "hurricanage" by year
%
%  Uses plotyy and handle graphics to annotate

%% 1. Load data from file
load hurrcatbyyear

%% 2. Sum the number of hurricanes each year
% Remember that the first column contains tropical storms and not
% hurricanes
numHurr = sum(cats(:,2:end),2);

%% 3. Get the category count for each year
catVals = sum(bsxfun(@times,cats,(0:5)),2);

%% 4. Make plot
[ax,h1,h2] = plotyy(yr,numHurr,yr,catVals);
xlabel('Year')

%% 5. Label the y axes
ylabel(ax(1),'Number of hurricanes')
ylabel(ax(2),'Weighted Category Sum')

%% Set options
% Add markers
set([h1,h2],'Marker','.');

%  Set limits for x-axis
xlim = [yr(1),yr(end)];
set(ax,'XLim',xlim);

%  Set years that are divisible by 10
y10  = yr(round(yr/10)==(yr/10));
set(ax,'XTick',y10);

title('Hurricanes')
