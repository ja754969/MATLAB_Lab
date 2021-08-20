%% HURRVISII Solution for "Hurricanes and SST" exercise

%% 1. Load windSst
load windSst

%% 2. Plot the data
[ax,h1,h2]=plotyy(t,w,t,sst);

%% 3. Change markers to points
set([h1,h2],'Marker','.')

%% 4. Add labels
xlabel('date')
ylabel(ax(1),{'Total windspeed of all';'Atlantic hurricanes [kts]'})
ylabel(ax(2),'Average North Atlantic SST [^\circ C]')

%% 5. Set the tick labels
% Set the x-tick labels on the first set of axes
datetick(ax(1),'x','mm/yy')
% Set the x-tick labels on the second set of axes to the empty matrix
set(ax(2),'XTick',[])

%% 6. Zoom in on the decade
xl = [datenum(1990,1,1),datenum(2000,1,1)];
xlim(ax(1),xl)
xlim(ax(2),xl)

%% 7. Reset the x-tick locations and labels
set(ax(1),'XTickMode','auto','XTickLabelMode','auto')
datetick('x','mm/yy','keeplimits')

%% Alternative, using set & get
% tnum = datenum(1990:2:2000,1,1);
% set(ax,'XTick',tnum,'XTickLabel',datestr(tnum,'mm/yy'))