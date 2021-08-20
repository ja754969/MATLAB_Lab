clear;clc;clf
% 1. Download RLR monthly data
% 2. Load the data set to Matlab and comprehend its contents.
data = readRlrMonthly('.\rlr_monthly');
data2 = struct2table(data); %資料
data2.name = categorical(data2.name);

plon_sub2 = data2.longitude;
plon_sub2(plon_sub2 < 0) = plon_sub2(plon_sub2 < 0) + 360;
% for i = 1:length(plon_sub2) %把小於0的經度值加上360 (解決畫不到180經度之後的問題)
%     if plon_sub2(i) < 0
%         plon_sub2(i) = plon_sub2(i)+360;
%     end
%     plon_sub2;
% end % 解決:不在範圍內的測站點擠在座標軸上的問題
% 用在圖5、圖6
%%  Plot the location of all stations on the map
plon_sub = data2.longitude; %取出資料 data2 中的經度
plat_sub = data2.latitude;  %取出資料 data2 中的緯度

figure(1)
m_proj('miller','lon',[-180 180],'lat',[-90 90]); % 繪製海面(白色)
m_plot(plon_sub,plat_sub,'Marker','.','Markersize',9,'LineStyle','none')
% m_line(plon_sub,plat_sub,'Marker','.')
% m_gshhs_c('patch',[1 1 1]);
%m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_c('patch',[.1 .1 .1],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[-180:60:180],'ytick',[-90:20:90],...
        'XaxisLocation','bottom','YaxisLocation','left');
%% Please use different colors to plot the stations of coastline 612 and 642 on the map.
figure(2)
m_proj('miller','lon',[110 150],'lat',[20 50]);  
% 控制海面範圍           % 這個會被畫進 legend 裡

c1 = data2.coastline;
tw = find(c1 == 612); %the stations of coastline 612 (Taiwan)
twtw = m_plot(plon_sub(tw(1:2)),plat_sub(tw(1:2)),'.r','Markersize',12);
% 612 taiwan {268,1133} (kaohsiung,keelong)

hold on
jp = find(c1 == 642); %the stations of coastline 642 (Japan)
jpjp = m_plot(plon_sub(jp(1:42)),plat_sub(jp(1:42)),'.b','Markersize',12);
hold off
%m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_l('patch',[.15 .15 .15],'edgecolor','k');
m_grid('linewi',2,'linestyle','none','tickdir','in','ticklen',0.0001,...
        'xtick',[110:20:150],'ytick',[20:10:50],...
        'XaxisLocation','bottom','YaxisLocation','left');
legend([twtw,jpjp],'612','642','Location','northwest')
%%  5.　Then, choose Keelung and Kaohsiung stations to plot the time series of sea surface height.
keehei = data2.height{tw(2)}; % sea surface height of Keelung 
kaohei = data2.height{tw(1)}; % sea surface height of Kaohsiung
figure(3)
subplot(2,1,1)
kee_9_time = data2.time{tw(2)}; %the time series of Keelung
startDay = datenum('1954-11');  %datenum : Serial date number
endDay = datenum('1998-09');    
x1=[startDay linspace(datenum('1960-05'),endDay,8)];
plot(kee_9_time,keehei,'db-','MarkerSize',3,'MarkerFaceColor','b')
%--------------------------------------------------------------------------
ax= gca;
ax.XTick = x1; %改變x軸標示
%--------------------------------------------------------------------------
datetick('x','yyyy/mm','keepticks');
title('Keelung');ylabel('Sea surface height (mm)');
axis([startDay,endDay,6600,7400]);
% xlabel('日期')
subplot(2,1,2)
kao_8_time = data2.time{tw(1)}; %the time series of Kaohsiung
startDay2 = datenum('1971-04'); %datenum : Serial date number
endDay2 = datenum('1990-06');
x2=[startDay2 datenum('1974-01') datenum('1976-10') ...
    datenum('1979-07') datenum('1982-03') datenum('1984-12') datenum('1987-09') endDay2];
plot(kao_8_time,kaohei,'dr-','MarkerSize',3,'MarkerFaceColor','r')
%--------------------------------------------------------------------------
ax= gca;
ax.XTick = x2; %改變x軸標示
%--------------------------------------------------------------------------
datetick('x','yyyy/mm','keepticks')
title('Kaohsiung');ylabel('Sea surface height (mm)');
axis([startDay2,endDay2,6600,7400]);
%% Plot the location of the stations where was located from 100°E to 160°E and 0°N to 60°N on the map.
figure(4)
m_proj('miller','lon',[100 160],'lat',[0 60]);
ind_comm = find(plon_sub <= 160 & plon_sub >= 100 & plat_sub <= 60 & plat_sub >= 0);
wplon=[];wplat=[]; %extract the stations where was located from 100°E to 160°E and 0°N to 60°N
for i = 1:length(ind_comm)
    wplon(i) = plon_sub(ind_comm(i));
    wplat(i) = plat_sub(ind_comm(i));
end % 解決:不在範圍內的測站點擠在座標軸上的問題
m_plot(wplon,wplat,'.c','Markersize',12,'LineStyle','none')
% m_line(plon_sub,plat_sub,'Marker','.')
% m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_l('patch',[.1 .1 .1],'edgecolor','k');

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[100:10:160],'ytick',[0:10:60],...
        'XaxisLocation','bottom','YaxisLocation','left');
%%  Plot the location of the stations where was located from 100°E to 100°W and 0°N to 60°N on the map.
figure(5)
%--------------------------------------------------------------------------
ind_comm2 = find(plon_sub2 <= 260 & plon_sub2 >= 100 & plat_sub <= 60 & plat_sub >= 0); 
%找出在共同範圍內所有座標儲存在矩陣裡的索引值
%extract the stations where was located from 100°E to 100°W and 0°N to 60°N
wplon2 = plon_sub2(ind_comm2); 
wplat2 = plat_sub(ind_comm2);
%--------------------------------------------------------------------------
% wplon2=[];wplat2=[]; 
% for i = 1:length(ind_comm2)
%     wplon2(i) = plon_sub2(ind_comm2(i));
%     wplat2(i) = plat_sub(ind_comm2(i));
% end
m_proj('miller','lon',[100 260],'lat',[0 60]);
m_plot(wplon2,wplat2,'.m','Markersize',12,'LineStyle','none')
% m_line(plon_sub,plat_sub,'Marker','.')
%m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_l('patch',[.1 .1 .1],'edgecolor','k');

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[100:20:260],'ytick',[0:10:60],...
        'XaxisLocation','bottom','YaxisLocation','left');
%%  Continuously, use different colors to divide the time series length into more than 100 years, 50 to 100 years, 25 to 50 years and less than 25 years .
figure(6)
%ind_comm2 = find(plon_sub2 <= 260 & plon_sub2 >= 100 & plat_sub <= 60 & plat_sub >= 0);
% wplon2=[];wplat2=[];
% for i = 1:length(ind_comm2)
%     wplon2(i) = plon_sub2(ind_comm2(i));
%     wplat2(i) = plat_sub(ind_comm2(i));
% end
%--------------------------------------------------------------------------
time = data2.year; %time of every station  % time 屬於胞陣列
for i = 1:length(ind_comm2)
    time_s(i) = time(ind_comm2(i)); 
    % time_lim = time_s'  
    % time_s 屬於胞陣列
end
time_lim = time_s';    % time_lim 屬於胞陣列
for i = 1:length(time_lim)
    t(i) = min(time_lim{i}); % 取出每一測站的初始年分，放入 t 中(列向量)
    t_min = t'; % 將 t 轉置為行向量 t_min
end
for i = 1:length(time_lim)
    t2(i) = max(time_lim{i}); % 取出每一測站的最大年分，放入 t2 中(列向量)
    t_max_all = t2'; % 將 t 轉置為行向量 t_min
end
t_max = max(t_max_all);
%--------------------------------------------------------------------------
m=1;n=1;p=1;r=1;
for i = 1:length(time_lim)
    if (t_min(i) > (t_max-25))
        lon_0_25(m) = wplon2(i);
        lat_0_25(m) = wplat2(i);
        m = m+1;
    elseif (t_min(i) <= (t_max-25) & t_min(i) >= (t_max-50))
        lon_25_50(n) = wplon2(i);
        lat_25_50(n) = wplat2(i);
        n = n+1;
    elseif (t_min(i) < (t_max-50) & t_min(i) >= (t_max-100))
        lon_50_100(p) = wplon2(i);
        lat_50_100(p) = wplat2(i);
        p = p+1;
    else (t_min(i) < (t_max-100))
        lon_100_up(r) = wplon2(i);
        lat_100_up(r) = wplat2(i);
        r = r +1;
    end
end
%--------------------------------------------------------------------------
% T_0_25 = find(t_min > (t_max-25));
% for i = 1:length(T_0_25)
%     lon_0_25(i) = wplon2(T_0_25(i));
%     lat_0_25(i) = wplat2(T_0_25(i));
% end
% T_25_50 = find(t_min <= (t_max-25) & t_min > (t_max-50));
% for i = 1:length(T_25_50)
%     lon_25_50(i) = wplon2(T_25_50(i));
%     lat_25_50(i) = wplat2(T_25_50(i));
% end
% T_50_100 = find(t_min <= (t_max-50) & t_min >= (t_max-100));
% for i = 1:length(T_50_100)
%     lon_50_100(i) = wplon2(T_50_100(i));
%     lat_50_100(i) = wplat2(T_50_100(i));
% end
% T_100_up = find(t_min < (t_max-100));
% for i = 1:length(T_100_up)
%     lon_100_up(i) = wplon2(T_100_up(i));
%     lat_100_up(i) = wplat2(T_100_up(i));
% end
m_proj('miller','lon',[100 260],'lat',[0 60]);
h1=m_plot(lon_100_up,lat_100_up,'.r','Markersize',12,'LineStyle','none');
hold on
h2=m_plot(lon_50_100,lat_50_100,'.b','Markersize',12,'LineStyle','none');
hold on
h3=m_plot(lon_25_50,lat_25_50,'.g','Markersize',12,'LineStyle','none');
hold on
h4=m_plot(lon_0_25,lat_0_25,'.m','Markersize',12,'LineStyle','none');
m_gshhs_l('patch',[.1 .1 .1],'edgecolor','k');

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[100:20:260],'ytick',[0:10:60],...
        'XaxisLocation','bottom','YaxisLocation','left');
lgd=legend([h1,h2,h3,h4],'> 100','50~100','25~50','< 25','Location','southoutside','NumColumns',4);
% title(lgd,'Years')