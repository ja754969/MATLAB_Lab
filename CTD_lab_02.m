%% 比較CTD上升和下降的溫鹽差異
% # name 0 = depSM: Depth [salt water, m]
% # name 1 = longitude: Longitude [deg]
% # name 2 = latitude: Latitude [deg]
% # name 3 = t090C: Temperature [ITS-90, deg C]
% # name 4 = sal00: Salinity, Practical [PSU]
% # name 5 = sigma-?0: Density [sigma-theta, kg/m^3]
% # name 6 = sbeox0Mg/L: Oxygen, SBE 43 [mg/l]
% # name 7 = flag: flag
% # span 0 =      1.000,     46.000       
% # span 1 =  121.79360,  121.79446       
% # span 2 =   25.18824,   25.18836       
% # span 3 =    22.9294,    25.5022       
% # span 4 =    33.7129,    33.9936       
% # span 5 =    22.2163,    23.1933       
% # span 6 =     6.3641,     6.6797       
% # span 7 = 0.0000e+00, 0.0000e+00       
% # interval = meters: 1                  
% # start_time = Oct 07 2019 02:12:29 [NMEA time, header]
% # bad_flag = -9.990e-29
%% 讀取CTD資料夾裡的所有檔案
clear;clc;clf
cd('C:\Users\user\Documents\MATLAB\CTD') % 設定檔案路徑

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
%% S1-1
% % isint1 = find(isinteger(c1_1_s(:,1))); % c1_1_s 的深度資料沒有整數型態
% for i=1:length(c1_1_s)
%     
%     dp1s{i,1} = find(c1_1_s(:,1) > (i-1) & c1_1_s(:,1) < i);
%     avg1s_T(i,1) = mean(c1_1_s(dp1s{i,1},4)); % 平均溫度
%     avg1s_S(i,1) = mean(c1_1_s(dp1s{i,1},5)); % 平均鹽度
%     avg1s_D(i,1) = mean(c1_1_s(dp1s{i,1},6)); % 平均密度
% end
% figure(4)
% dep11s = (1:max(c1_1_s))';
% % subplot(2,1,1)
% [ax1_21s,yy111,yy112] = plotyy(c1_1_s(1:max(c1_1_s(:,1)),1),c1_1_s(1:max(c1_1_s(:,1)),4),...
%     c1_1_s(1:max(c1_1_s(:,1)),1),c1_1_s(1:max(c1_1_s(:,1)),5));
% set(get(ax1_21s(1),'Ylabel'),'String','Temperature (^oC)');
% set(get(ax1_21s(2),'Ylabel'),'String','Salinity (psu)');
% % set(ax1_21s(1), 'YColor', [0 1 0]) 
% % set(yy111,'Color','b'); % 溫
% set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
% hold on
% % axis([-inf inf 33 35])
% % subplot(2,1,2)
% [ax1_22s,yy121,yy122] = plotyy(c1_1_s(max(c1_1_s(:,1)):end,1),c1_1_s(max(c1_1_s(:,1)):end,4),...
%     c1_1_s(max(c1_1_s(:,1)):end,1),c1_1_s(max(c1_1_s(:,1)):end,5));
% set(get(ax1_22s(1),'Ylabel'),'String','Temperature (^oC)');
% set(get(ax1_22s(2),'Ylabel'),'String','Salinity (psu)');
% set(yy121,'Marker','s','Color','c'); % 溫
% set(yy122,'Marker','s','Color','r'); % 鹽
% 
% set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
% hold off
% xlabel('depth (m)');
% get(gca)

%% S1-1 ~ S8-1
for i = 1:8
    for j=1:max(ctd_s{1,i}(:,1))
    
    dps{i} = find(ctd_s{1,i}(:,1) > (j-1) & ctd_s{1,i}(:,1) < j);
    avgs_T(i,1) = mean(ctd_s{i}(dps{i},4)); % 平均溫度
    avgs_S(i,1) = mean(ctd_s{i}(dps{i},5)); % 平均鹽度
    avgs_D(i,1) = mean(ctd_s{i}(dps{i},6)); % 平均密度
    end
    figure(1) % CTD 的下放資料與收回資料比較(s1-1~s8-1)
    dep21s = (1:max(ctd_s{i}))';
    % subplot(2,1,1)
    [ax1_21s,yy111,yy112] = plotyy(ctd_s{i}(1:max(ctd_s{i}(:,1)),1),ctd_s{i}(1:max(ctd_s{i}(:,1)),4),...
        ctd_s{i}(1:max(ctd_s{i}(:,1)),1),ctd_s{i}(1:max(ctd_s{i}(:,1)),5));
    set(get(ax1_21s(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax1_21s(2),'Ylabel'),'String','Salinity (psu)');
    % set(ax1_21s(1), 'YColor', [0 1 0]) 
    % set(yy111,'Color','b'); % 溫
    set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
    hold on
    % axis([-inf inf 33 35])
    % subplot(2,1,2)
    [ax1_22s,yy121,yy122] = plotyy(ctd_s{i}(max(ctd_s{i}(:,1)):end,1),ctd_s{i}(max(ctd_s{i}(:,1)):end,4),...
        ctd_s{i}(max(ctd_s{i}(:,1)):end,1),ctd_s{i}(max(ctd_s{i}(:,1)):end,5));
    set(get(ax1_22s(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax1_22s(2),'Ylabel'),'String','Salinity (psu)');
    set(yy121,'Marker','s','Color','c'); % 溫
    set(yy122,'Marker','s','Color','r'); % 鹽

    set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
    hold off
    xlabel('depth (m)');
    legend([yy111,yy112,yy121,yy122],['Temperature ' num2str(i) '-1(down)'],...
        ['Salinity ' num2str(i) '-1(down)'],...
        ['Temperature ' num2str(i) '-1(up)'],['Salinity ' num2str(i) '-1(up)'],...
        'vertical','boxoff','Location','best')
    
    pngname = ['TScompare_' num2str(i)]
    print(pngname,'-dpng')
end
