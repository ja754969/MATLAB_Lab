%% 讀取CTD資料夾裡的所有檔案
clear;clc;clf
cd('.\CTD') % 設定檔案路徑

a=dir;
%% 用CTD資料夾讀取沒有S開頭的資料，把資料讀進Matlab
% load 1-1.cnv
for i = 3:10
    filename = a(i).name;
    fid = fopen(filename,'r') %讀檔
    while strcmp(fgetl(fid),'*END*') == 0
    %一行一行讀取資料，直到讀取到'*END*'字串為止
        isEND = feof(fid); %測試檔案是否以讀取到末端(是回應1，否回應0)
    end
    ctd_row = fscanf(fid,'%f'); %接續前面的資料讀取中斷點，繼續往下讀取檔案fid裡的資料
                            %並且得到一個行向量
    ctd{i} = reshape(ctd_row,8,length(ctd_row)/8)';
    fclose(fid);
end
c1_1 = ctd{3};
c2_1 = ctd{4};
c3_1 = ctd{5};
c4_1 = ctd{6};
c5_1 = ctd{7};
c6_1 = ctd{8};
c7_1 = ctd{9};
c8_1 = ctd{10};
%% s1-1.cnv
as=dir('s*');
for i = 1:8
    filename2 = as(i).name;
    fid2 = fopen(filename2,'r')
    while strcmp(fgetl(fid2),'*END*') == 0
    %一行一行讀取資料，直到讀取到'*END*'字串為止
        isEND2 = feof(fid2); %測試檔案是否以讀取到末端(是回應1，否回應0)
    end
    ctd_row2 = fscanf(fid,'%f'); %接續前面的資料讀取中斷點，繼續往下讀取檔案fid裡的資料
                            %並且得到一個行向量
    ctd_s{i} = reshape(ctd_row2,8,length(ctd_row2)/8)';
    fclose(fid2);
end
c1_1_s = ctd_s{1};
c2_1_s = ctd_s{2};
c3_1_s = ctd_s{3};
c4_1_s = ctd_s{4};
c5_1_s = ctd_s{5};
c6_1_s = ctd_s{6};
c7_1_s = ctd_s{7};
c8_1_s = ctd_s{8};
%% 把溫度鹽度密度的資料做平均，最後平均出來的資料數會和原來一樣

%% 用contour畫sigma(密度)

%% 劃出每一個測站的T-S diagram

%% 各測站經緯度
lon1 = 121 + 47.66/60;lat1 = 25 + 11.29/60; % 1-1 的經緯度
lon2 = 121 + 47.88/60;lat2 = 25 + 11.80/60;
lon3 = 121 + 47.88/60;lat3 = 25 + 12.34/60;
lon4 = 121 + 46.89/60;lat4 = 25 + 12.52/60;
lon5 = 121 + 46.99/60;lat5 = 25 + 12.91/60;
lon6 = 121 + 46.42/60;lat6 = 25 + 12.52/60;
lon7 = 121 + 46.04/60;lat7 = 25 + 12.17/60;
lon8 = 121 + 45.80/60;lat8 = 25 + 11.72/60;
LONLIM1 = 121.7:0.05:121.87;LATLIM1 = 25.1:0.05:25.25; % 畫圖的範圍限制
%% 把1-1.cnv的深度資料(第1個行向量)做平均，最後平均出來的資料數會和原來一樣
% 目的 : 把1-1.cnv的深度資料變成和 s1-1.cnv 一樣
% 做平均的目的 : CTD在下放的過程會受到干擾，
% #1 name 0 = depSM: Depth [salt water, m]
% #2 name 1 = longitude: Longitude [deg]
% #3 name 2 = latitude: Latitude [deg]
% #4 name 3 = t090C: Temperature [ITS-90, deg C]
% #5 name 4 = sal00: Salinity, Practical [PSU]
% #6 name 5 = sigma-?0: Density [sigma-theta, kg/m^3]
% #7 name 6 = sbeox0Mg/L: Oxygen, SBE 43 [mg/l]
% #8 name 7 = flag:  0.000e+00
isint1 = find(isinteger(c1_1(:,1))); % c1_1 的深度資料沒有整數型態
for i=1:47
    
    dp1{i,1} = find(c1_1(:,1) > (i-1) & c1_1(:,1) < i);
    avg1_T(i,1) = mean(c1_1(dp1{i,1},4)); % 平均溫度
    avg1_S(i,1) = mean(c1_1(dp1{i,1},5)); % 平均鹽度
    avg1_D(i,1) = mean(c1_1(dp1{i,1},6)); % 平均密度
end
figure(1)
dep11 = (1:47)';
subplot(2,2,1)
ax1_1 = plotyy(dep11,avg1_T,dep11,avg1_S)
% title('(up&down)')
% ax = gca
set(gca,'View',[90 90]) % 調整雙y圖的方位角、仰角
set(get(ax1_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax1_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
% ax.XTickLabelRotation = 45
% ax.XTick = 1:1:47
subplot(2,2,2)
ax1_2 = plotyy(c1_1_s(:,1),c1_1_s(:,4),c1_1_s(:,1),c1_1_s(:,5));
set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
set(get(ax1_2(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax1_2(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,3) % 密度等高線、溫鹽圖
S1 = linspace(min(avg1_S),max(avg1_S),47);
T1 = linspace(min(avg1_T),max(avg1_T),47);
[SS1,TT1] = meshgrid(S1,T1);
sigma1 = den_CTD(SS1,TT1,1.01325+dep11*(1.01325*1/10))-1000; % 函式 den_CTD
[c1,h1]=contour(SS1,TT1,sigma1);
clabel(c1,h1);
hold on
plot(avg1_S,avg1_T,'k','LineWidth',2);hold off
title('T-S diagram (1-1)');xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd11 = m_plot(lon1,lat1,'Marker','.','Markersize',10,'MarkerFaceColor','r')
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out',...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');

title('1-1 Location')

print('D-T_T-S_diagram_1-1','-dpng')

% plot(avg1_S,avg1_T)
% print('T-S_diagram_1-1','-dpng')

% dp01 = find(c1_1(:,1) > 0 & c1_1(:,1) < 1 );
% avg01_T = mean(c1_1(dp01,4));
% dp12 = find(1 < c1_1(:,1) < 2);
% avg12_T = mean(c1_1(dp12,4));
% dp23 = find(2 < c1_1(:,1) < 3);
% avg23_T = mean(c1_1(dp23,4));
% dp34 = find(3 < c1_1(:,1) < 4);
% avg34_T = mean(c1_1(dp34,4));
% dp45 = find(4 < c1_1(:,1) < 5);
% avg45_T = mean(c1_1(dp45,4));
% dp56 = find(5 < c1_1(:,1) < 6);
% avg56_T = mean(c1_1(dp56,4));
% dp67 = find(6 < c1_1(:,1) < 7);
% avg67_T = mean(c1_1(dp67,4));
% dp78 = find(7 < c1_1(:,1) < 8);
% avg78_T = mean(c1_1(dp78,4));
%% 2-1.cnv
isint2 = find(isinteger(c2_1(:,1))); % c2_1 的深度資料沒有整數型態
for i=1:111
    
    dp2{i,1} = find(c2_1(:,1) > (i-1) & c2_1(:,1) < i);
    avg2_T(i,1) = mean(c2_1(dp2{i,1},4));
    avg2_S(i,1) = mean(c2_1(dp2{i,1},5));
end
figure(1)
dep22 = 1:111;
subplot(2,2,1)
ax2_1 = plotyy(dep22,avg2_T,dep22,avg2_S);
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
% ax.XTickLabelRotation = 45
% ax.XTick = 1:1:47
set(get(ax2_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax2_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c2_1_s(:,1),c2_1_s(:,4),c2_1_s(:,1),c2_1_s(:,5))
ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S2 = linspace(min(avg2_S),max(avg2_S),111)';T2 = linspace(min(avg2_T),max(avg2_T),111)';
[SS2,TT2] = meshgrid(S2,T2);
sigma2 = den_CTD(SS2,TT2,1.01325+dep22*(1.01325*1/10))-1000;
[c2,h2]=contour(SS2,TT2,sigma2);
clabel(c2,h2);
hold on
plot(avg2_S,avg2_T,'k','LineWidth',2);hold off
title('T-S diagram (2-1)');xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd21 = m_plot(lon2,lat2,'Marker','.','Markersize',10,'MarkerFaceColor','g')
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('2-1 Location')

print('D-T_T-S_diagram_2-1','-dpng')
% plot(avg2_S,avg2_T)
% print('T-S_diagram_2-1','-dpng')
%% 3-1.cnv
isint3 = find(isinteger(c3_1(:,1))); % c3_1 的深度資料沒有整數型態
for i=1:121
    
    dp3{i,1} = find(c3_1(:,1) > (i-1) & c3_1(:,1) < i);
    avg3_T(i,1) = mean(c3_1(dp3{i,1},4));
    avg3_S(i,1) = mean(c3_1(dp3{i,1},5));
end
figure(1)
dep33 = 1:121;
subplot(2,2,1)
ax3_1 = plotyy(dep33,avg3_T,dep33,avg3_S)
ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
set(get(ax3_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax3_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c3_1_s(:,1),c3_1_s(:,4),c3_1_s(:,1),c3_1_s(:,5))
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S3 = linspace(min(avg3_S),max(avg3_S),121);T3 = linspace(min(avg3_T),max(avg3_T),121);
[SS3,TT3] = meshgrid(S3,T3);
sigma3 = den_CTD(SS3,TT3,1.01325+dep33*(1.01325*1/10))-1000;
[c3,h3]=contour(SS3,TT3,sigma3);
clabel(c3,h3);
hold on
plot(avg3_S,avg3_T,'k','LineWidth',2);hold off
title('T-S diagram (3-1)');xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd31 = m_plot(lon3,lat3,'Marker','.','Markersize',10,'MarkerFaceColor','b')
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('3-1 Location')

print('D-T_T-S_diagram_3-1','-dpng')

% plot(avg3_S,avg3_T)
% print('T-S_diagram_3-1','-dpng')
%% 4-1.cnv
for i=1:102
    
    dp4{i,1} = find(c4_1(:,1) > (i-1) & c4_1(:,1) < i);
    avg4_T(i,1) = mean(c4_1(dp4{i,1},4));
    avg4_S(i,1) = mean(c4_1(dp4{i,1},5));
end
figure(1)
dep44 = 1:102;
subplot(2,2,1)
ax4_1 = plotyy(dep44,avg4_T,dep44,avg4_S)
ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
set(get(ax4_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax4_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c4_1_s(:,1),c4_1_s(:,4),c4_1_s(:,1),c4_1_s(:,5))
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S4 = linspace(min(avg4_S),max(avg4_S),102);T4 = linspace(min(avg4_T),max(avg4_T),102);
[SS4,TT4] = meshgrid(S4,T4);
sigma4 = den_CTD(SS4,TT4,1.01325+dep44*(1.01325*1/10))-1000;
[c4,h4]=contour(SS4,TT4,sigma4);
clabel(c4,h4);
hold on
plot(avg4_S,avg4_T,'k','LineWidth',2);hold off
title('T-S diagram (4-1)');xlabel('Salinity');ylabel('Temperature');
subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd41 = m_plot(lon4,lat4,'Marker','.','Markersize',10,'MarkerFaceColor',[1 1 0])
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('4-1 Location')

print('D-T_T-S_diagram_4-1','-dpng')
%% 5-1.cnv
for i=1:101
    
    dp5{i,1} = find(c5_1(:,1) > (i-1) & c5_1(:,1) < i);
    avg5_T(i,1) = mean(c5_1(dp5{i,1},4));
    avg5_S(i,1) = mean(c5_1(dp5{i,1},5));
end
figure(1)
dep55 = 1:101;
subplot(2,2,1)
ax5_1 = plotyy(dep55,avg5_T,dep55,avg5_S)
ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
set(get(ax5_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax5_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c5_1_s(:,1),c5_1_s(:,4),c5_1_s(:,1),c5_1_s(:,5))
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S5 = linspace(min(avg5_S),max(avg5_S),101);T5 = linspace(min(avg5_T),max(avg5_T),101);
[SS5,TT5] = meshgrid(S5,T5);
sigma5 = den_CTD(SS5,TT5,1.01325+dep55*(1.01325*1/10))-1000;
[c5,h5]=contour(SS5,TT5,sigma5);
clabel(c5,h5);
hold on
plot(avg5_S,avg5_T,'k','LineWidth',2);hold off
title('T-S diagram (5-1)');xlabel('Salinity');ylabel('Temperature');
subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd51 = m_plot(lon5,lat5,'Marker','.','Markersize',10,'MarkerFaceColor',[1 0 1])
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('5-1 Location')

print('D-T_T-S_diagram_5-1','-dpng')
%% 6-1.cnv
for i=1:92
    
    dp6{i,1} = find(c6_1(:,1) > (i-1) & c6_1(:,1) < i);
    avg6_T(i,1) = mean(c6_1(dp6{i,1},4));
    avg6_S(i,1) = mean(c6_1(dp6{i,1},5));
end
figure(1)
dep66 = 1:92;
subplot(2,2,1)
ax6_1 = plotyy(dep66,avg6_T,dep66,avg6_S)
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
set(get(ax6_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax6_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c6_1_s(:,1),c6_1_s(:,4),c6_1_s(:,1),c6_1_s(:,5))
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S6 = linspace(min(avg6_S),max(avg6_S),92);T6 = linspace(min(avg6_T),max(avg6_T),92);
[SS6,TT6] = meshgrid(S6,T6);
sigma6 = den_CTD(SS6,TT6,1.01325+dep66*(1.01325*1/10))-1000;
[c6,h6]=contour(SS6,TT6,sigma6); %繪製密度等高線
clabel(c6,h6);
hold on
plot(avg6_S,avg6_T,'k','LineWidth',2);hold off
title('T-S diagram (6-1)');xlabel('Salinity');ylabel('Temperature');
subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd61 = m_plot(lon6,lat6,'Marker','.','Markersize',10,'MarkerFaceColor',[0 1 1])
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('6-1 Location')

print('D-T_T-S_diagram_6-1','-dpng')
%% 7-1.cnv
for i=1:65
    
    dp7{i,1} = find(c7_1(:,1) > (i-1) & c7_1(:,1) < i);
    avg7_T(i,1) = mean(c7_1(dp7{i,1},4));
    avg7_S(i,1) = mean(c7_1(dp7{i,1},5));
end
figure(1)
dep77 = 1:65;
subplot(2,2,1)
ax7_1 = plotyy(dep77,avg7_T,dep77,avg7_S)
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
set(get(ax7_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax7_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c7_1_s(:,1),c7_1_s(:,4),c7_1_s(:,1),c7_1_s(:,5))
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S7 = linspace(min(avg7_S),max(avg7_S),65);T7 = linspace(min(avg7_T),max(avg7_T),65);
[SS7,TT7] = meshgrid(S7,T7);
sigma7 = den_CTD(SS7,TT7,1.01325+dep77*(1.01325*1/10))-1000;
[c7,h7]=contour(SS7,TT7,sigma7);
clabel(c7,h7);
hold on
plot(avg7_S,avg7_T,'k','LineWidth',2);hold off
title('T-S diagram (7-1)');xlabel('Salinity');ylabel('Temperature');
subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd71 = m_plot(lon7,lat7,'Marker','.','Markersize',10,'MarkerFaceColor',[0.8500 0.3250 0.0980])
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('7-1 Location')

print('D-T_T-S_diagram_7-1','-dpng')
%% 8-1.cnv
for i=1:46
    
    dp8{i,1} = find(c8_1(:,1) > (i-1) & c8_1(:,1) < i);
    avg8_T(i,1) = mean(c8_1(dp8{i,1},4));
    avg8_S(i,1) = mean(c8_1(dp8{i,1},5));
end
figure(1)
dep88 = 1:46;
subplot(2,2,1)
ax8_1 = plotyy(dep88,avg8_T,dep88,avg8_S)
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
set(get(ax8_1(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax8_1(2),'Ylabel'),'String','Salinity (psu)');
xlabel('depth (m)');
subplot(2,2,2)
plotyy(c8_1_s(:,1),c8_1_s(:,4),c8_1_s(:,1),c8_1_s(:,5))
% ax = gca
set(gca,'View',[90 90]) % 方位角、仰角
subplot(2,2,3) % 密度等高線、溫鹽圖
S8 = linspace(min(avg8_S),max(avg8_S),46);T8 = linspace(min(avg8_T),max(avg8_T),46);
[SS8,TT8] = meshgrid(S8,T8);
sigma8 = den_CTD(SS8,TT8,1.01325+dep88*(1.01325*1/10))-1000;
[c8,h8] = contour(SS8,TT8,sigma8);
clabel(c8,h8);
hold on
plot(avg8_S,avg8_T,'k','LineWidth',2);hold off
title('T-S diagram (8-1)');xlabel('Salinity');ylabel('Temperature');
subplot(2,2,4)
m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
ctd81 = m_plot(lon8,lat8,'Marker','.','Markersize',10,'MarkerFaceColor',[0 0 0])
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM1,'ytick',LATLIM1,...
        'XaxisLocation','bottom','YaxisLocation','left');
title('8-1 Location')

print('D-T_T-S_diagram_8-1','-dpng')
%% 利用經緯度的資料畫出測站的所在點在地圖上
figure(2)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % 繪製海面(白色)
ctd11 = m_plot(lon1,lat1,'Marker','.','Markersize',10,'MarkerFaceColor','r')
hold on
ctd21 = m_plot(lon2,lat2,'Marker','.','Markersize',10,'MarkerFaceColor','g')
hold on
ctd31 = m_plot(lon3,lat3,'Marker','.','Markersize',10,'MarkerFaceColor','b')
hold on
ctd41 = m_plot(lon4,lat4,'Marker','.','Markersize',10,'MarkerFaceColor',[1 1 0])
hold on
ctd51 = m_plot(lon5,lat5,'Marker','.','Markersize',10,'MarkerFaceColor',[1 0 1])
hold on
ctd61 = m_plot(lon6,lat6,'Marker','s','Markersize',8,'MarkerFaceColor',[0 1 1])
hold on
ctd71 = m_plot(lon7,lat7,'Marker','s','Markersize',8,'MarkerFaceColor',[0.8500 0.3250 0.0980])
hold on
ctd81 = m_plot(lon8,lat8,'Marker','s','Markersize',8,'MarkerFaceColor',[0 0 0])
% m_line(plon_sub,plat_sub,'Marker','.')
% m_gshhs_c('patch',[1 1 1]);
%m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM2,'ytick',LATLIM2,...
        'XaxisLocation','bottom','YaxisLocation','left');
text(121.7,25.15,'KEELUNG','FontSize',9,'FontName','times','Color','b')%在圖中標示基隆
    
legend([ctd11,ctd21,ctd31,ctd41,ctd51,ctd61,ctd71,ctd81]...
    ,'1-1(  47m)','2-1(111m)','3-1(121m)','4-1(102m)'...
    ,'5-1(101m)','6-1(  92m)','7-1(  65m)','8-1(  46m)')
title('Location of CTD','FontName','times','FontSize',15);
xlabel('    Longtitude');ylabel('Latitude');

print('Location_CTD','-dpng')
%% T-S diagram
figure(3)
% avg_S = sum()
% [SS,TT] = meshgrid(avg1_S,avg1_T);
% sigma1 = den_CTD(SS1,TT1,1+dep11*(1/10))-1000;
% [c1,h1]=contour(SS1,TT1,sigma1);
% clabel(c1,h1);
% hold on

TS1 = plot(avg1_S,avg1_T,'r:','LineWidth',2);hold on
TS2 = plot(avg2_S,avg2_T,'g:','LineWidth',2);hold on
TS3 = plot(avg3_S,avg3_T,'b:','LineWidth',2);hold on
TS4 = plot(avg4_S,avg4_T,'y:','LineWidth',2,'MarkerEdgeColor','k');hold on
TS5 = plot(avg5_S,avg5_T,'m:','LineWidth',2);hold on
TS6 = plot(avg6_S,avg6_T,'c:','LineWidth',2);hold on
TS7 = plot(avg7_S,avg7_T,':','Color',[0.8500 0.3250 0.0980],'LineWidth',2);hold on
TS8 = plot(avg8_S,avg8_T,':','Color',[0 0 0],'LineWidth',2);
hold on
% 密度等高線
x12 = xlim;y12 = ylim;
S = linspace(x12(1),x12(end),121);T = linspace(y12(1),y12(end),121);
[SS,TT] = meshgrid(S,T);
sigma = den_CTD(SS,TT,1.01325+dep33*(1.01325*1/10))-1000;
[cc,hh] = contour(SS,TT,sigma);
clabel(cc,hh);
hold off

% get(gca)

title('\it T-S diagram','FontName','times','FontSize',15);
xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
legend([TS1,TS2,TS3,TS4,TS5,TS6,TS7,TS8],'1-1','2-1','3-1','4-1','5-1','6-1','7-1','8-1')
print('T-S_diagram_all','-dpng')
%% S1-1
% isint1 = find(isinteger(c1_1_s(:,1))); % c1_1_s 的深度資料沒有整數型態
for i=1:length(c1_1_s)
    
    dp1s{i,1} = find(c1_1_s(:,1) > (i-1) & c1_1_s(:,1) < i);
    avg1s_T(i,1) = mean(c1_1_s(dp1s{i,1},4)); % 平均溫度
    avg1s_S(i,1) = mean(c1_1_s(dp1s{i,1},5)); % 平均鹽度
    avg1s_D(i,1) = mean(c1_1_s(dp1s{i,1},6)); % 平均密度
end
figure(4)
dep11s = (1:max(c1_1_s))';
% subplot(2,1,1)
[ax1_21s,yy111,yy112] = plotyy(c1_1_s(1:max(c1_1_s(:,1)),1),c1_1_s(1:max(c1_1_s(:,1)),4),...
    c1_1_s(1:max(c1_1_s(:,1)),1),c1_1_s(1:max(c1_1_s(:,1)),5));
set(get(ax1_21s(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax1_21s(2),'Ylabel'),'String','Salinity (psu)');
% set(ax1_21s(1), 'YColor', [0 1 0]) 
% set(yy111,'Color','b'); % 溫
set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
hold on
% axis([-inf inf 33 35])
% subplot(2,1,2)
[ax1_22s,yy121,yy122] = plotyy(c1_1_s(max(c1_1_s(:,1)):end,1),c1_1_s(max(c1_1_s(:,1)):end,4),...
    c1_1_s(max(c1_1_s(:,1)):end,1),c1_1_s(max(c1_1_s(:,1)):end,5));
set(get(ax1_22s(1),'Ylabel'),'String','Temperature (^oC)');
set(get(ax1_22s(2),'Ylabel'),'String','Salinity (psu)');
set(yy121,'Marker','s','Color','c'); % 溫
set(yy122,'Marker','s','Color','r'); % 鹽

set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
hold off
xlabel('depth (m)');
get(gca)

%% 心得
% 繪製等密度值線時，狀態方程式代入的溫鹽值取的是畫圖範圍的溫鹽值，並非資料本身的溫鹽值
% 而這些等高線取值的方式，是資料的最小值到最大值