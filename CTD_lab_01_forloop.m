%% 讀取CTD資料夾裡的所有檔案
clear;clc;clf
cd('.\CTD') % 設定檔案路徑

a=dir; %在資料夾中取出所有檔案
%% 用CTD資料夾讀取沒有S開頭的資料，把資料讀進Matlab
% load 1-1.cnv ~ 8-1.cnv
for i = 3:10 
    filename = a(i).name;
    fid = fopen(filename,'r') %讀檔
    while strcmp(fgetl(fid),'*END*') == 0
    %一行一行讀取資料，直到讀取到'*END*'字串為止
        isEND = feof(fid); %測試檔案是否已讀取到末端(是回應1，否回應0)
    end
    ctd_row = fscanf(fid,'%f'); %接續前面的資料讀取中斷點，繼續往下讀取檔案fid裡的資料
                            %並且得到一個行向量
    ctd{i-2} = reshape(ctd_row,8,length(ctd_row)/8)'; %趁機把檔案排序變成(3-2)~(10-2)
    fclose(fid);
end
%% s1-1.cnv ~ s8-1.cnv
as=dir('s*');
for i = 1:8
    filename2 = as(i).name;
    fid2 = fopen(filename2,'r')
    while strcmp(fgetl(fid2),'*END*') == 0
    %一行一行讀取資料，直到讀取到'*END*'字串為止
        isEND2 = feof(fid2); %測試檔案是否已經讀取到末端(是回應1，否回應0)
    end
    ctd_row2 = fscanf(fid,'%f'); %接續前面的資料讀取中斷點，繼續往下讀取檔案fid裡的資料
                            %並且得到一個行向量
    ctd_s{i} = reshape(ctd_row2,8,length(ctd_row2)/8)';
    fclose(fid2);
end
% c1_1_s = ctd_s{1};
% c2_1_s = ctd_s{2};
% c3_1_s = ctd_s{3};
% c4_1_s = ctd_s{4};
% c5_1_s = ctd_s{5};
% c6_1_s = ctd_s{6};
% c7_1_s = ctd_s{7};
% c8_1_s = ctd_s{8};
%% 各測站經緯度
lon(1,1) = 121 + 47.66/60;lat(1,1) = 25 + 11.29/60; % 1-1 的經緯度
lon(2,1) = 121 + 47.88/60;lat(2,1) = 25 + 11.80/60;
lon(3,1) = 121 + 47.88/60;lat(3,1) = 25 + 12.34/60;
lon(4,1) = 121 + 46.89/60;lat(4,1) = 25 + 12.52/60;
lon(5,1) = 121 + 46.99/60;lat(5,1) = 25 + 12.91/60;
lon(6,1) = 121 + 46.42/60;lat(6,1) = 25 + 12.52/60;
lon(7,1) = 121 + 46.04/60;lat(7,1) = 25 + 12.17/60;
lon(8,1) = 121 + 45.80/60;lat(8,1) = 25 + 11.72/60;
LONLIM1 = 121.7:0.05:121.87 ; LATLIM1 = 25.1:0.05:25.25; % 畫圖的經緯度範圍限制
location_color = {[1 0 0],[0 1 0],[0 0 1],[1 1 0],[1 0 1],[0 1 1],...
    [0.8500 0.3250 0.0980],...
    [0 0 0]}
%% all . cnv  CTD上下平均
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 的深度資料沒有整數型態
    for j=1:fix(max(ctd{i}(:,1))+1) %深度資料的選定
    
        dp{j} = find(ctd{i}(:,1) > (j-1) & ctd{i}(:,1) < j);
        %深度資料 : 每個深度j之間以1當作間隔，存放到dp裡
%         dpdp{i,j} = dp{j,1};
        avg_T(i,j) = mean(ctd{i}(dp{j},4)); %特定深度範圍的平均溫度
        avg_S(i,j) = mean(ctd{i}(dp{j},5)); %特定深度範圍的平均鹽度

    end
    figure(1)
    dep{i,1} = (1:fix(max(ctd{i}(:,1))+1))';
    subplot(2,2,1) %CTD上下平均資料
    [ax,h11,h12] = plotyy(dep{i,1},avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        dep{i,1},avg_S(i,1:fix(max(ctd{i}(:,1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % 調整雙y圖的方位角、仰角
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
%     ax.XTickLabelRotation = 45
%     ax.XTick = 1:1:max(ctd{i}(:,1))
    subplot(2,2,2) % 上收與下放的資料
    [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
    set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
    set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
    subplot(2,2,3) % 密度等高線、溫鹽圖
    S{i,1} = linspace(min(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    % 從平均鹽度的最大值與最小值之間，創造dep{i,1}(end)筆資料存放到S{i,1}
    T{i,1} = linspace(min(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    % 從平均溫度的最大值與最小值之間，創造dep{i,1}(end)筆資料存放到T{i,1}
    [SS{i,1},TT{i,1}] = meshgrid(S{i,1},T{i,1});
    sigma{i,1} = den_CTD(SS{i,1},TT{i,1},1.01325+dep{i}*(1.01325*1/10))-1000; % 函式 den_CTD
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %繪製等位密度線
    clabel(c1,h1);hold on %顯示數值
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    subplot(2,2,4)
    m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
    ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
        'MarkerFaceColor','b')
    m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

    m_grid('linewi',2,'linestyle','none','tickdir','out',...
            'xtick',LONLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left');

    title([num2str(i) '-1 Location']);

    print(['D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% all . cnv  CTD 下放平均
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 的深度資料沒有整數型態
    down_max = find(ctd{i}(:,1)==max(ctd{i}(:,1))); % 找到深度資料中最大值的索引值
    %因為得到的最大值可能不只一個(可能重複)，所以將得到的最大值索引值存放到down_max裡
    %再取出down_max的第一個值給down_ctd(i,1)存放
    down_ctd(i,1) = down_max(1); %第一個最大值的索引值
    for j=1:fix(max(ctd{i}(:,1))+1)
    
        dp_down{j} = find(ctd{i}(1:down_ctd(i,1),1) > (j-1) &...
            ctd{i}(1:down_ctd(i,1),1) < j);
%         dpdp{i,j} = dp{j,1};
        avg_Tdown(i,j) = mean(ctd{i}(dp_down{j},4));
        avg_Sdown(i,j) = mean(ctd{i}(dp_down{j},5));

    end
    figure(2)
    dep_down{i,1} = (1:1:fix(max(ctd{i}(:,1))+1))';
    subplot(2,2,1)
    [ax,h11,h12] = plotyy(dep_down{i,1},avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        dep_down{i,1},avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % 調整雙y圖的方位角、仰角
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
%     subplot(2,2,2)
%     [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
%     set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
%     set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
%     set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
%     xlabel('depth (m)');
    subplot(2,2,3) % 密度等高線、溫鹽圖
    Sdown{i,1} = linspace(min(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),...
        max(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),dep_down{i,1}(end));
    Tdown{i,1} = linspace(min(avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),...
        max(avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1))),dep_down{i,1}(end));
    [SSdown{i,1},TTdown{i,1}] = meshgrid(Sdown{i,1},Tdown{i,1});
    sigma_down{i,1} = den_CTD(SSdown{i,1},TTdown{i,1},1.01325+dep_down{i}*(1.01325*1/10))-1000; % 函式 den_CTD
    [c1,h1]=contour(SSdown{i,1},TTdown{i,1},sigma_down{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,down)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    subplot(2,2,2)
    m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
    ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
        'MarkerFaceColor','b')
    m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

    m_grid('linewi',2,'linestyle','none','tickdir','out',...
            'xtick',LONLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left');

    title([num2str(i) '-1 Location (down)']);

        
    subplot(2,2,4) % 密度等高線、溫鹽圖
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %繪製等位密度線
    clabel(c1,h1);hold on %顯示數值
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,mean)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    
    print(['down_mean_D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% all . cnv  CTD 上收平均
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 的深度資料沒有整數型態
    up_max = find(ctd{i}(:,1)==max(ctd{i}(:,1))); % 找到深度資料中最大值的索引值
    %因為得到的最大值可能不只一個(可能重複)，所以將得到的最大值索引值存放到up_max裡
    %再取出up_max的第一個值給up_ctd(i,1)存放
    up_ctd(i,1) = up_max(1); %第一個最大值的索引值
    for j=1:fix(max(ctd{i}(:,1))+1)
    
        dp_up{j} = find(ctd{i}((up_ctd(i,1)+1):end,1) > (j-1) &...
            ctd{i}((up_ctd(i,1)+1):end,1) < j);
%         dpdp{i,j} = dp{j,1};
        avg_Tup(i,j) = mean(ctd{i}(dp_up{j},4));
        avg_Sup(i,j) = mean(ctd{i}(dp_up{j},5));

    end
    figure(3)
    dep_up{i,1} = (1:1:fix(max(ctd{i}(:,1))+1))';
    subplot(2,2,1)
    [ax,h11,h12] = plotyy(dep_up{i,1},avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        dep_up{i,1},avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % 調整雙y圖的方位角、仰角
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
    
    subplot(2,2,3) % 密度等高線、溫鹽圖
    Sup{i,1} = linspace(min(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),...
        max(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),dep_up{i,1}(end));
    Tup{i,1} = linspace(min(avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),...
        max(avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1))),dep_up{i,1}(end));
    [SSup{i,1},TTup{i,1}] = meshgrid(Sup{i,1},Tup{i,1});
    sigma_up{i,1} = den_CTD(SSup{i,1},TTup{i,1},1.01325+dep_up{i}*(1.01325*1/10))-1000; % 函式 den_CTD
    [c1,h1]=contour(SSup{i,1},TTup{i,1},sigma_up{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,up)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    subplot(2,2,2)
    m_proj('miller','lon',[LONLIM1(1) LONLIM1(end)],'lat',[LATLIM1(1) LATLIM1(end)]); % 繪製海面(白色)
    ctd_Location = m_plot(lon(i,1),lat(i,1),'Marker','.','Markersize',10,...
        'MarkerFaceColor','b')
    m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

    m_grid('linewi',2,'linestyle','none','tickdir','out',...
            'xtick',LONLIM1,'ytick',LATLIM1,...
            'XaxisLocation','bottom','YaxisLocation','left');

    title([num2str(i) '-1 Location (up)']);
    
    subplot(2,2,4) % 密度等高線、溫鹽圖
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %繪製等位密度線
    clabel(c1,h1);hold on %顯示數值
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,mean)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');


    print(['up_mean_D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% all . cnv  CTD 上收與下放以及平均的比較
for i = 1:8
    figure(4)
    subplot(1,3,1)
    [c1,h1] = contour(SSdown{i,1},TTdown{i,1},sigma_down{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        avg_Tdown(i,1:fix(max(ctd{i}(1:down_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,down)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
    
    subplot(1,3,2) % 密度等高線、溫鹽圖
    [c1,h1]=contour(SSup{i,1},TTup{i,1},sigma_up{i,1});
    clabel(c1,h1);hold on
    plot(avg_Sup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        avg_Tup(i,1:fix(max(ctd{i}(1:up_ctd(i),1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,up)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
    
    subplot(1,3,3) % 密度等高線、溫鹽圖
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %繪製等位密度線
    clabel(c1,h1);hold on %顯示數值
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k:','LineWidth',2);hold off
    title(['T-S diagram (' num2str(i) '-1,mean)']);
    xlabel('Salinity (psu)');ylabel('Temperature (^oC)');

    print(['T-S_diagram_' num2str(i) '-1_compare'],'-dpng')
end
%% 把溫度鹽度密度的資料做平均，最後平均出來的資料數會和原來一樣

%% 用contour畫sigma(密度)

%% 劃出每一個測站的T-S diagram

%% 利用經緯度的資料畫出測站的所在點在地圖上
figure(5)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % 繪製海面(白色)
ctd11 = m_plot(lon(1,1),lat(1,1),'Marker','.','Markersize',10,'MarkerFaceColor','r')
hold on
ctd21 = m_plot(lon(2,1),lat(2,1),'Marker','.','Markersize',10,'MarkerFaceColor','g')
hold on
ctd31 = m_plot(lon(3,1),lat(3,1),'Marker','.','Markersize',10,'MarkerFaceColor','b')
hold on
ctd41 = m_plot(lon(4,1),lat(4,1),'Marker','.','Markersize',10,'MarkerFaceColor',[1 1 0])
hold on
ctd51 = m_plot(lon(5,1),lat(5,1),'Marker','.','Markersize',10,'MarkerFaceColor',[1 0 1])
hold on
ctd61 = m_plot(lon(6,1),lat(6,1),'Marker','s','Markersize',8,'MarkerFaceColor',[0 1 1])
hold on
ctd71 = m_plot(lon(7,1),lat(7,1),'Marker','s','Markersize',8,'MarkerFaceColor',[0.8500 0.3250 0.0980])
hold on
ctd81 = m_plot(lon(8,1),lat(8,1),'Marker','s','Markersize',8,'MarkerFaceColor',[0 0 0])
% m_line(plon_sub,plat_sub,'Marker','.')
% m_gshhs_c('patch',[1 1 1]);
%m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',LONLIM2,'ytick',LATLIM2,...
        'XaxisLocation','bottom','YaxisLocation','left');
legend([ctd11,ctd21,ctd31,ctd41,ctd51,ctd61,ctd71,ctd81]...
    ,'1-1( 47m)','2-1(111m)','3-1(121m)','4-1(102m)','5-1(101m)','6-1( 92m)','7-1( 65m)','8-1( 46m)')
title('Location of CTD','FontName','times','FontSize',15);
xlabel('    Longtitude');ylabel('Latitude');
print('Location_CTD','-dpng')
%% T-S diagram(由上下平均所得到的資料繪製)
figure(6)
% avg_S = sum()
% [SS,TT] = meshgrid(avg1_S,avg1_T);
% sigma1 = den_CTD(SS1,TT1,1+dep11*(1/10))-1000;
% [c1,h1]=contour(SS1,TT1,sigma1);
% clabel(c1,h1);
% hold on

TS1 = plot(avg_S(1,1:fix(max(ctd{1}(:,1))+1)),avg_T(1,1:fix(max(ctd{1}(:,1))+1)),'r:','LineWidth',2);hold on
TS2 = plot(avg_S(2,1:fix(max(ctd{2}(:,1))+1)),avg_T(2,1:fix(max(ctd{2}(:,1))+1)),'g:','LineWidth',2);hold on
TS3 = plot(avg_S(3,1:fix(max(ctd{3}(:,1))+1)),avg_T(3,1:fix(max(ctd{3}(:,1))+1)),'b:','LineWidth',2);hold on
TS4 = plot(avg_S(4,1:fix(max(ctd{4}(:,1))+1)),avg_T(4,1:fix(max(ctd{4}(:,1))+1)),'y:','LineWidth',2);hold on
TS5 = plot(avg_S(5,1:fix(max(ctd{5}(:,1))+1)),avg_T(5,1:fix(max(ctd{5}(:,1))+1)),'m:','LineWidth',2);hold on
TS6 = plot(avg_S(6,1:fix(max(ctd{6}(:,1))+1)),avg_T(6,1:fix(max(ctd{6}(:,1))+1)),'c:','LineWidth',2);hold on
TS7 = plot(avg_S(7,1:fix(max(ctd{7}(:,1))+1)),avg_T(7,1:fix(max(ctd{7}(:,1))+1)),':','Color',[0.8500 0.3250 0.0980],'LineWidth',2);hold on
TS8 = plot(avg_S(8,1:fix(max(ctd{8}(:,1))+1)),avg_T(8,1:fix(max(ctd{8}(:,1))+1)),':','Color',[0 0 0],'LineWidth',2);
hold on
% 密度等高線
x12 = xlim;
y12 = ylim;
S2 = linspace(x12(1),x12(end),121);
T2 = linspace(y12(1),y12(end),121);
[SS2,TT2] = meshgrid(S2,T2);
sigma2 = den_CTD(SS2,TT2,1.01325+dep{3}*(1.01325*1/10))-1000;
[cc,hh] = contour(SS2,TT2,sigma2);
clabel(cc,hh);
hold off

% get(gca)

title('\it T-S diagram','FontName','times','FontSize',15);
xlabel('Salinity (psu)');ylabel('Temperature (^oC)');
legend([TS1,TS2,TS3,TS4,TS5,TS6,TS7,TS8],'1-1','2-1','3-1','4-1','5-1','6-1','7-1','8-1')
print('T-S_diagram_all_forloop','-dpng')