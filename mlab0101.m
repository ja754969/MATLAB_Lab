clear;clc
% 1. Download RLR monthly data
% 2. Load the data set to Matlab and comprehend its contents.
data = readRlrMonthly('C:\Users\mei301\matlab00781035\rlr_monthly\rlr_monthly');
data2=struct2table(data);
data2.name = categorical(data2.name);
% 3. Plot the location of all stations on the map
plon_sub = data2.longitude;
plat_sub = data2.latitude;
m_plot(plon_sub,plat_sub,'Marker','.','Markersize',6,'LineStyle','none')

m_proj('miller','lon',[0 360],'lat',[-90 90]);
m_coast('patch',[.6 .6 .6]);
m_gshhs_i('linewi',1,'color','k');
m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[0:60:360],'ytick',[-90:20:90],...
        'XaxisLocation','bottom','YaxisLocation','left');