%% 讀取CTD資料夾裡的所有檔案
clear;clc;clf
cd('.\CTD') % 設定檔案路徑

a=dir; %在資料夾中取出所有檔案
%% 用CTD資料夾讀取沒有S開頭的資料，把資料讀進Matlab
% load 1-1.cnv ~ 8-1.cnv
for i = 3:10 
    filename = a(i).name;
    fid = fopen(filename,'r')%讀檔
    while strcmp(fgetl(fid),'*END*') == 0
    %一行一行讀取資料，直到讀取到'*END*'字串為止
        isEND = feof(fid); %測試檔案是否以讀取到末端(是回應1，否回應0)
    end
    ctd_row = fscanf(fid,'%f'); %接續前面的資料讀取中斷點，繼續往下讀取檔案fid裡的資料
                            %並且得到一個行向量
    ctd{i-2} = reshape(ctd_row,8,length(ctd_row)/8)'; %(3-2)~(10-2)
    fclose(fid);
end
%% s1-1.cnv ~ s8-1.cnv
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
%% 各測站經緯度
lon(1,1) = 121 + 47.66/60;lat(1,1) = 25 + 11.29/60; % 1-1 的經緯度
lon(2,1) = 121 + 47.88/60;lat(2,1) = 25 + 11.80/60;
lon(3,1) = 121 + 47.88/60;lat(3,1) = 25 + 12.34/60;
lon(4,1) = 121 + 46.89/60;lat(4,1) = 25 + 12.52/60;
lon(5,1) = 121 + 46.99/60;lat(5,1) = 25 + 12.91/60;
lon(6,1) = 121 + 46.42/60;lat(6,1) = 25 + 12.52/60;
lon(7,1) = 121 + 46.04/60;lat(7,1) = 25 + 12.17/60;
lon(8,1) = 121 + 45.80/60;lat(8,1) = 25 + 11.72/60;
LONLIM1 = 121.7:0.05:121.87;LATLIM1 = 25.1:0.05:25.25; % 畫圖的範圍限制
location_color = {[1 0 0],[0 1 0],[0 0 1],[1 1 0],[1 0 1],[0 1 1],[0.8500 0.3250 0.0980],[0 0 0]}
%% 1-1 ~ 8-1.cnv  CTD上下平均
for i = 1:8
%     isint(1)=nan;isint(2)=nan;
%     isint(i) = find(isinteger(ctd{i}(:,1))); % c2_1 的深度資料沒有整數型態
    for j=1:fix(max(ctd{i}(:,1))+1)
    
        dp{j} = find(ctd{i}(:,1) > (j-1) & ctd{i}(:,1) < j); %每個測站的深度資料索引值
%         dpdp{i,j} = dp{j,1};
        avg_T(i,j) = mean(ctd{i}(dp{j},4)); %將各測站的溫度一列一列儲存在矩陣avg_T
        avg_S(i,j) = mean(ctd{i}(dp{j},5)); %將各測站的鹽度一列一列儲存在矩陣avg_S
        avg_D(i,j) = mean(ctd{i}(dp{j},6)); %將各測站的密度一列一列儲存在矩陣avg_D
    end
    figure(1)
    dep{i,1} = (1:fix(max(ctd{i}(:,1))+1))'; %每個測站的深度資料
    subplot(2,2,1) %CTD上下平均資料(使用 1-1 ~ 8-1 )
    [ax,h11,h12] = plotyy(dep{i,1},avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        dep{i,1},avg_S(i,1:fix(max(ctd{i}(:,1))+1)))
    % ax = gca
    set(gca,'View',[90 90]) % 調整雙y圖的方位角、仰角
    set(get(ax(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
%     ax.XTickLabelRotation = 45
%     ax.XTick = 1:1:max(ctd{i}(:,1))
    subplot(2,2,2) % 上收與下放的資料(使用 s1-1 ~ s8-1 )
    [ax2,h21,h22] = plotyy(ctd_s{i}(:,1),ctd_s{i}(:,4),ctd_s{i}(:,1),ctd_s{i}(:,5));
    set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
    set(get(ax2(1),'Ylabel'),'String','Temperature (^oC)');
    set(get(ax2(2),'Ylabel'),'String','Salinity (psu)');
    xlabel('depth (m)');
    subplot(2,2,3) % 密度等高線、溫鹽圖
    S{i,1} = linspace(min(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_S(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    %將各測站的鹽度資料avg_S(i,1:fix(max(ctd{i}(:,1))+1)))由最小到最大產生一個長度為dep{i,1}(end)的胞陣列
    T{i,1} = linspace(min(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),max(avg_T(i,1:fix(max(ctd{i}(:,1))+1))),dep{i,1}(end));
    %將各測站的溫度資料avg_T(i,1:fix(max(ctd{i}(:,1))+1)))由最小到最大產生一個長度為dep{i,1}(end)的胞陣列
    [SS{i,1},TT{i,1}] = meshgrid(S{i,1},T{i,1});
    sigma{i,1} = den_CTD(SS{i,1},TT{i,1},1.01325+dep{i}*(1.01325*1/10))-1000; % 函式 den_CTD
    [c1,h1]=contour(SS{i,1},TT{i,1},sigma{i,1}); %繪製等位密度線
    clabel(c1,h1);hold on %顯示數值
    plot(avg_S(i,1:fix(max(ctd{i}(:,1))+1)),avg_T(i,1:fix(max(ctd{i}(:,1))+1)),...
        'k','LineWidth',2);hold off
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

%     print(['D-T_T-S_diagram_' num2str(i) '-1_forloop'],'-dpng')
end
%% 利用CTD_lab的資料做出溫、鹽、密度剖面圖(1-1、2-1、3-1 測站剖面)
% 使用contour
% Y 軸 : 深度(m)
% X 軸 : 測站位置(測站間距離)(m)
% 等高線 : 溫度、鹽度、等位密度
figure(2) % 1-1、2-1、3-1 測站剖面
subplot(2,2,1)
t1dep = 1:121; % 繪圖深度
% t1dep = 1:47; % 繪圖深度
% t1ctd = [avg_T(1,:)' avg_T(2,:)' avg_T(3,:)']
% t1ctd(t1ctd==0)=nan;
t1ctd = [[avg_T(1,:)';zeros(length(t1dep)-length(avg_T(1,:)),1)] ...
    [avg_T(2,:)';zeros(length(t1dep)-length(avg_T(2,:)),1)] ...
    [avg_T(3,:)';zeros(length(t1dep)-length(avg_T(3,:)),1)]]; %取出溫度資料
t1ctd(t1ctd==0)=nan;

% t1ctd = [avg_T(1,1:47)' avg_T(2,1:47)' avg_T(3,1:47)'];

t1lat = [lat(1,1) lat(2,1) lat(3,1)];
[tLAT,tD1] = meshgrid(t1lat,t1dep);
contourf(tD1,tLAT,t1ctd,45); %繪製溫度剖面
shading interp
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
cp = colorbar('Direction','normal',...
    'Ticks',[fix(min(min(t1ctd))):1:max(max(t1ctd))]);
cp.Label.String = 'Temperature(^oC)';
title('Temperature Profile(1,2,3)','FontName','times','FontSize',10);

subplot(2,2,2)
s1ctd = [[avg_S(1,:)';zeros(length(t1dep)-length(avg_S(1,:)),1)] ...
    [avg_S(2,:)';zeros(length(t1dep)-length(avg_S(2,:)),1)] ...
    [avg_S(3,:)';zeros(length(t1dep)-length(avg_S(3,:)),1)]]; %取出鹽度資料
s1ctd(s1ctd==0)=nan;
contourf(tD1,tLAT,s1ctd,45); %繪製溫度剖面
shading interp
% clabel(c3,h3)
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
colorbar
cp2 = colorbar();
cp2.Label.String = 'Salinity(psu)';
title('Salinity Profile(1,2,3)','FontName','times','FontSize',10);

subplot(2,2,3)
d1ctd = [[avg_D(1,:)';zeros(length(t1dep)-length(avg_D(1,:)),1)] ...
    [avg_D(2,:)';zeros(length(t1dep)-length(avg_D(2,:)),1)] ...
    [avg_D(3,:)';zeros(length(t1dep)-length(avg_D(3,:)),1)]]; %取出鹽度資料
d1ctd(d1ctd==0)=nan;
contourf(tD1,tLAT,d1ctd,45); %繪製溫度剖面
shading interp
% clabel(c4,h4)
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
colorbar
cp3 = colorbar();
cp3.Label.String = 'Density(sigma-theta, kg/m^3)';
title('Density Profile(1,2,3)','FontName','times','FontSize',10);

subplot(2,2,4)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % 繪製海面(白色)
ctd11 = m_plot(lon(1,1),lat(1,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{1});
hold on;
ctd21 = m_plot(lon(2,1),lat(2,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{2});
hold on;
ctd31 = m_plot(lon(3,1),lat(3,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{3});

m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

% m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',LONLIM2,'ytick',LATLIM2,...
%         'XaxisLocation','bottom','YaxisLocation','right');
m_grid('box','fancy');
legend([ctd11,ctd21,ctd31],'1-1( 47m)','2-1(111m)','3-1(121m)','Location','southeast');
title('Location of CTD(1,2,3)','FontName','times','FontSize',15);
% xlabel('    Longtitude');ylabel('Latitude');

print('Profile_1_2_3_ctd','-dpng')
%% 利用CTD_lab的資料做出溫、鹽、密度剖面圖(5-1、6-1、7-1、8-1 測站剖面)
% 使用contour
% Y 軸 : 深度(m)
% X 軸 : 測站位置(測站間距離)(m)
% 等高線 : 溫度、鹽度、等位密度
figure(3) % 5-1、6-1、7-1、8-1 測站剖面
subplot(2,2,1)
t2dep = 1:101; % 繪圖深度
% t1dep = 1:47; % 繪圖深度
% t1ctd = [avg_T(1,:)' avg_T(2,:)' avg_T(3,:)']
% t1ctd(t1ctd==0)=nan;
t2ctd = [[avg_T(5,1:101)';zeros(length(t2dep)-length(avg_T(5,1:101)),1)] ...
    [avg_T(6,1:101)';zeros(length(t2dep)-length(avg_T(6,1:101)),1)] ...
    [avg_T(7,1:101)';zeros(length(t2dep)-length(avg_T(7,1:101)),1)] ...
    [avg_T(8,1:101)';zeros(length(t2dep)-length(avg_T(8,1:101)),1)]]; %取出溫度資料
t2ctd(t2ctd==0)=nan; %把t2ctd的0值變為NAN值

% t1ctd = [avg_T(1,1:47)' avg_T(2,1:47)' avg_T(3,1:47)'];

t2lat = [lat(5,1) lat(6,1) lat(7,1) lat(8,1)];
[t2LAT,t2D1] = meshgrid(t2lat,t2dep);
contourf(t2D1,t2LAT,t2ctd,45); %繪製溫度剖面
shading interp
% clabel(c5,h5)
% get(gca)
set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
colormap('jet')
cp4 = colorbar('Direction','normal',...
    'Ticks',[fix(min(min(t2ctd))):1:max(max(t2ctd))]);
cp4.Label.String = 'Temperature(^oC)';
title('Temperature Profile(5,6,7,8)','FontName','times','FontSize',10);

subplot(2,2,2)
s2ctd = [[avg_S(5,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(5,1:length(t2dep))),1)]...
    [avg_S(6,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(6,1:length(t2dep))),1)] ...
    [avg_S(7,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(7,1:length(t2dep))),1)] ...
    [avg_S(8,1:length(t2dep))';zeros(length(t2dep)-length(avg_S(8,1:length(t2dep))),1)]]; %取出鹽度資料
s2ctd(s2ctd==0)=nan;
contourf(t2D1,t2LAT,s2ctd,45); %繪製鹽度剖面
shading interp
% clabel(c6,h6)
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
colorbar
cp5 = colorbar('Direction','normal');
cp5.Label.String = 'Salinity(psu)';
title('Salinity Profile(5,6,7,8)','FontName','times','FontSize',10);

subplot(2,2,3)
d2ctd = [[avg_D(5,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(5,1:length(t2dep))),1)] ...
    [avg_D(6,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(6,1:length(t2dep))),1)] ...
    [avg_D(7,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(7,1:length(t2dep))),1)] ...
    [avg_D(8,1:length(t2dep))';zeros(length(t2dep)-length(avg_D(8,1:length(t2dep))),1)]]; %取出鹽度資料
d2ctd(d2ctd==0)=nan;
contourf(t2D1,t2LAT,d2ctd,45); %繪製密度剖面
shading interp
% clabel(c7,h7)
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
colorbar
cp6 = colorbar('Direction','normal');
cp6.Label.String = 'Density(sigma-theta, kg/m^3)';
title('Density Profile(5,6,7,8)','FontName','times','FontSize',10);

subplot(2,2,4)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % 繪製海面(白色)
ctd51 = m_plot(lon(5,1),lat(5,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{5})
hold on
ctd61 = m_plot(lon(6,1),lat(6,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{6})
hold on
ctd71 = m_plot(lon(7,1),lat(7,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{7})
hold on
ctd81 = m_plot(lon(8,1),lat(8,1),'Marker','.','Markersize',10,'MarkerFaceColor',location_color{8})

m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

% m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',LONLIM2,'ytick',LATLIM2,...
%         'XaxisLocation','bottom','YaxisLocation','right');
m_grid('box','fancy');
legend([ctd51,ctd61,ctd71,ctd81],'5-1(101m)','6-1( 92m)','7-1( 65m)','8-1( 46m)','Location','southeast');
title('Location of CTD(5,6,7,8)','FontName','times','FontSize',15);
% xlabel('    Longtitude');ylabel('Latitude');

print('Profile_5_6_7_8_ctd','-dpng')
%% 利用CTD_lab的資料做出溫、鹽、密度剖面圖(3-1、4-1、6-1 測站剖面)
% 使用contour
% Y 軸 : 深度(m)
% X 軸 : 測站位置(測站間距離)(m)
% 等高線 : 溫度、鹽度、等位密度
figure(4) % 3-1、4-1、6-1 測站剖面
subplot(2,2,1)
t3dep = 1:121; % 繪圖深度
% t1dep = 1:47; % 繪圖深度
% t1ctd = [avg_T(1,:)' avg_T(2,:)' avg_T(3,:)']
% t1ctd(t1ctd==0)=nan;
t3ctd = [[avg_T(3,1:length(t3dep))';zeros(length(t3dep)-length(avg_T(3,1:length(t3dep))),1)] ...
    [avg_T(4,1:length(t3dep))';zeros(length(t3dep)-length(avg_T(4,1:length(t3dep))),1)] ...
    [avg_T(6,1:length(t3dep))';zeros(length(t3dep)-length(avg_T(6,1:length(t3dep))),1)]]; %取出溫度資料
t3ctd(t3ctd==0)=nan; %把t2ctd的0值變為NAN值

% t1ctd = [avg_T(1,1:47)' avg_T(2,1:47)' avg_T(3,1:47)'];

t3lon = [lon(3,1) lon(4,1) lon(6,1)];
[t3LON,t3D1] = meshgrid(t3lon,t3dep);
contourf(t3D1,t3LON,t3ctd,35); %繪製溫度剖面
shading interp
% clabel(c5,h5)
% get(gca)
set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
colormap('jet')
cp4 = colorbar('Direction','normal',...
    'Ticks',[fix(min(min(t3ctd))):1:max(max(t3ctd))]);
cp4.Label.String = 'Temperature(^oC)';
title('Temperature Profile(3,4,6)','FontName','times','FontSize',10);

subplot(2,2,2)
s3ctd = [[avg_S(3,1:length(t3dep))';zeros(length(t3dep)-length(avg_S(3,1:length(t3dep))),1)]...
    [avg_S(4,1:length(t3dep))';zeros(length(t3dep)-length(avg_S(4,1:length(t3dep))),1)] ...
    [avg_S(6,1:length(t3dep))';zeros(length(t3dep)-length(avg_S(6,1:length(t3dep))),1)]]; %取出鹽度資料
s3ctd(s3ctd==0)=nan;
contourf(t3D1,t3LON,s3ctd,35); %繪製鹽度剖面
% pcolor(t3D1,t3LON,s3ctd); %繪製鹽度剖面
shading interp
% clabel(c6,h6)
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
colorbar
cp5 = colorbar();
cp5.Label.String = 'Salinity(psu)';
title('Salinity Profile(3,4,6)','FontName','times','FontSize',10);

subplot(2,2,3)
d3ctd = [[avg_D(3,1:length(t3dep))';zeros(length(t3dep)-length(avg_D(3,1:length(t3dep))),1)] ...
    [avg_D(4,1:length(t3dep))';zeros(length(t3dep)-length(avg_D(4,1:length(t3dep))),1)] ...
    [avg_D(6,1:length(t3dep))';zeros(length(t3dep)-length(avg_D(6,1:length(t3dep))),1)]]; %取出鹽度資料
d3ctd(d3ctd==0)=nan;
contourf(t3D1,t3LON,d3ctd,35); %繪製密度剖面
% pcolor(t3D1,t3LON,d3ctd); %繪製密度剖面
shading interp
% clabel(c7,h7)
% get(gca)
set(gca,'View',[90 90]) % 調整圖軸的方位角、仰角
colormap('jet')
colorbar
cp6 = colorbar('Direction','normal');
cp6.Label.String = 'Density(sigma-theta, kg/m^3)';
title('Density Profile(3,4,6)','FontName','times','FontSize',10);

subplot(2,2,4)
LONLIM2 = 121.65:0.05:121.92;LATLIM2 = 25.1:0.05:25.25;
m_proj('miller','lon',[LONLIM2(1) LONLIM2(end)],'lat',[LATLIM2(1) LATLIM2(end)]); % 繪製海面(白色)
ctd31 = m_plot(lon(3,1),lat(3,1),'Marker','.','Markersize',10,'MarkerFaceColor','y')
hold on
ctd41 = m_plot(lon(4,1),lat(4,1),'Marker','.','Markersize',10,'MarkerFaceColor','r')
hold on
ctd61 = m_plot(lon(6,1),lat(6,1),'Marker','.','Markersize',10,'MarkerFaceColor','g')

m_gshhs_f('patch',[.9 .9 .9],'edgecolor','k');    %繪製陸地

% m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',LONLIM2,'ytick',LATLIM2,...
%         'XaxisLocation','bottom','YaxisLocation','right');
m_grid('box','fancy')
legend([ctd31,ctd41,ctd61],'3-1(121)','4-1(102m)','6-1( 92m)','Location','southeast');
title('Location of CTD(3,4,6)','FontName','times','FontSize',15);

print('Profile_3_4_6_ctd','-dpng')