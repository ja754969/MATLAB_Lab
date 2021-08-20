clear;clc
data = readRlrMonthly('C:\Users\user\Documents\MATLAB\rlr_monthly\rlr_monthly');
data2=struct2table(data);
data2.name = categorical(data2.name);


lon1=data2.longitude;
lon1(lon1<0)=lon1(lon1<0)+360;
% for i=1:length(lon1);
%     if lon1(i)<0
%      lon1(i)=lon1(i)+360;
%     end
% end
lat1=data2.latitude;
%%

%%
LONLIM=[100 260];LATLIM=[0 60];
range_select=find(lon1>min(LONLIM) & lon1<max(LONLIM) & lat1>min(LATLIM) & lat1<max(LATLIM));

year=data2.year(range_select);
id=data2.id(range_select)

%%
m=1;n=1;p=1;q=1;
for i=1:length(year);
    timelength=year{i}(end)-year{i}(1);
    if timelength>100
        case1(m)=find(data2.id==id(i));
        m=m+1;
    elseif timelength>50 & timelength<=100
        case2(n)=find(data2.id==id(i));
        n=n+1;
    elseif timelength>25 & timelength<=50
        case3(p)=find(data2.id==id(i));
        p=p+1;
    else 
        case4(q)=find(data2.id==id(i));
        q=q+1;
    end
        
end
%%

%%

range_select1=find(data2.coastline==642) 
range_select2=find(data2.coastline==612)%612 taiwan {268,1133} (kaohsiung,keelong)
range_select=find(data2.id==1831)
%find(data2.id==1831)
%%

figure(1)
%m_proj('hammer-aitoff','lon',[min(LONLIM) max(LONLIM)],'lat',[min(LATLIM) max(LATLIM)]);
m_proj('miller','lon',[min(LONLIM) max(LONLIM)],'lat',[min(LATLIM) max(LATLIM)]);
h1=m_plot(lon1(range_select1),lat1(range_select1),'.b','markersize',10);
hold on
h2=m_plot(lon1(range_select2),lat1(range_select2),'.r','markersize',10);

m_gshhs_l('patch',[.1 .1 .1]);
m_grid('linestyle','none','linewidth',3,'xtick',min(LONLIM):20:max(LONLIM),...
 'fontsize',8,'ytick',min(LATLIM):10:max(LATLIM),'fontsize',8);
legend([h1,h2],'612','642','location','northwest')
% colormap jet 

%%



%%

figure(2)
% plot(data2.time{range_select2(2)},data2.height{range_select2(2)});
dateX=datevec(data2.time{range_select2(2)});
%dateX(:,3:6)=0
%dateT=datenum(dateX);
subplot(2,1,1)
plot(data2.time{range_select2(2)},data2.height{range_select2(2)},'*-','linewidth',1,'markersize',3);
datetick('x','yyyy/mm','keepticks')
title('keelung','FontSize',16)
ylabel('Sea surface height (mm)')

subplot(2,1,2)
plot(data2.time{range_select2(1)},data2.height{range_select2(1)},'*-r','linewidth',1,'markersize',3)
datetick('x','yyyy/mm','keepticks')
title('kaohsiung','FontSize',16)
ylabel('Sea surface height (mm)')
% DateString = {'1956/01';'1995/08'};
% formatIn = 'yyyy/mm';
% set(gca,'xtick',datenum(DateString,formatIn))


%%

figure(3)
%m_proj('hammer-aitoff','lon',[min(LONLIM) max(LONLIM)],'lat',[min(LATLIM) max(LATLIM)]);
m_proj('miller','lon',[min(LONLIM) max(LONLIM)],'lat',[min(LATLIM) max(LATLIM)]);
h1=m_plot(lon1(case1),lat1(case1),'.r','markersize',10);
hold on
h2=m_plot(lon1(case2),lat1(case2),'.b','markersize',10);
h3=m_plot(lon1(case3),lat1(case3),'.g','markersize',10);
h4=m_plot(lon1(case4),lat1(case4),'.m','markersize',10);
m_gshhs_l('patch',[.1 .1 .1]);
m_grid('linestyle','none','linewidth',3,'xtick',min(LONLIM):20:max(LONLIM),...
 'fontsize',8,'ytick',min(LATLIM):10:max(LATLIM),'fontsize',8);
legend([h1,h2,h3,h4],{'>100','50~100','25~50','<25'},'location','southoutside','orientation','horizontal')
% colormap jet 
%%
figure(4)
% plot(data2.time{range_select2(2)},data2.height{range_select2(2)});
dateX=datevec(data2.time{range_select(1)});
%dateX(:,3:6)=0
%dateT=datenum(dateX);

plot(data2.time{range_select(1)},data2.height{range_select(1)},'*-','linewidth',1,'markersize',3);
datetick('x','yyyy/mm','keepticks')
title('Tuvalu','FontSize',16)
ylabel('Sea surface height (mm)')

%%

