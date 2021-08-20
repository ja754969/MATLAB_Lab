%% 讀取 NC 檔案
clear;clc;clf
close  all;
% 用迴圈讀檔 (先讀五個)
cd('C:\201108_201505NSST') % 設定檔案路徑

a=dir('A*'); % * 意思 : 在資料夾中取出任意一個 A 開頭的檔案
% a2 = struct2table(a);  %其實可以不用轉table ， table 只是方便查看
%% 將檔名轉換成易讀的日期
% mon = [201108:201112 201201:201212 201301:201312 201401:201412 201501:201505]';
for i = 1:2 %讀取資料範圍
    %---------------------- 讀取 NC 檔案------------------------------------
    filename = a(i).name;
    %ncdisp(filename)
    nc_dump(filename); % nc_dump 載入檔案
    %--------------將檔名轉換成易讀的日期(不是直接改檔名)---------------------
    sst = nc_varget(a(i).name,'sst');             % nc_varget 取出檔案中的變數 sst
    qual_sst = nc_varget(a(i).name,'qual_sst');   % nc_varget 取出檔案中的變數 qual_sst
    Sublat = nc_varget(a(i).name,'lat');          % nc_varget 取出檔案中的變數 lat
    Sublon = nc_varget(a(i).name,'lon');          % nc_varget 取出檔案中的變數 lon
    palette = nc_varget(a(i).name,'palette');     % nc_varget 取出檔案中的變數 palette
    
    s1 = a(i).name(2:8);
    t = datetime(s1,'InputFormat','uuuuDDD');
    n = datestr(t,'yyyy-mm');
%     a2.name{i}=['A' num2str(mon(i)) '.L3m_MO_NSST_sst_9km.nc'];
%---------------------------畫圖並以 print 存圖-----------------------------
%   sst2{i} = reshape(sst{i},[],1);
    sst(find(sst >= 45.0007)) = NaN;
%     figure(i)
    LONLIM = [110 160]; LATLIM = [0 40];
    m_proj('miller','lon',LONLIM,'lat',LATLIM);
    [Xlon,Ylat] = meshgrid(Sublon,Sublat);
    m_pcolor(Xlon,Ylat,sst);
    shading interp
    m_gshhs_i('patch',[.1 .1 .1]);
%     m_coast('patch',[.1 .1 .1],'edgecolor','k');
    m_grid('linewi',2,'linestyle','none','tickdir','out',...
        'xtick',[LONLIM(1):5:LONLIM(2)],'ytick',[LATLIM(1):5:LATLIM(2)],...
        'XaxisLocation','bottom','YaxisLocation','left');
    colormap(jet)
    colorbar
    caxis([0 max(max(sst))]) %把 colormap 的區間範圍從 0 到 30 改成 0 到 max(max(sst)) 
    title([n,' SST_MODIS'],'Interpreter','none');
    print(n,'-dpng')
end
% n = datestr(t,'yyyy-mm-dd')
%% 北半球冬季(12月~2月)SST
% mon = [201108:201112 201201:201212 201301:201312 201401:201412 201501:201505]';
for i = [5 6 7 17 18 19 29 30 31 41 42 43]
    %---------------------- 讀取 NC 檔案------------------------------------
    filename = a(i).name;
    %ncdisp(filename)
    nc_dump(filename); % nc_dump 載入檔案
    %---------------------------將檔名轉換成易讀的日期-----------------------
    sst = nc_varget(a(i).name,'sst');             % nc_varget 取出檔案中的變數 sst
    qual_sst = nc_varget(a(i).name,'qual_sst');   % nc_varget 取出檔案中的變數 qual_sst
    Sublat = nc_varget(a(i).name,'lat');          % nc_varget 取出檔案中的變數 lat
    Sublon = nc_varget(a(i).name,'lon');          % nc_varget 取出檔案中的變數 lon
    palette = nc_varget(a(i).name,'palette');     % nc_varget 取出檔案中的變數 palette
    
    s1 = a(i).name(2:8);
    t = datetime(s1,'InputFormat','uuuuDDD');
    n = datestr(t,'yyyy-mm');
%     a2.name{i}=['A' num2str(mon(i)) '.L3m_MO_NSST_sst_9km.nc'];
%---------------------------畫圖並以 print 存圖-----------------------------
%   sst2{i} = reshape(sst{i},[],1);
    sst(find(sst >= 45.0007)) = NaN;
%     figure(i)
    LONLIM = [110 160]; LATLIM = [0 40];
    m_proj('miller','lon',LONLIM,'lat',LATLIM);
    [Xlon,Ylat] = meshgrid(Sublon,Sublat);
    m_pcolor(Xlon,Ylat,sst);
    shading interp
    m_gshhs_i('patch',[.1 .1 .1]);
%     m_coast('patch',[.1 .1 .1],'edgecolor','k');
    m_grid('linewi',2,'linestyle','none','tickdir','out',...
        'xtick',[LONLIM(1):5:LONLIM(2)],'ytick',[LATLIM(1):5:LATLIM(2)],...
        'XaxisLocation','bottom','YaxisLocation','left');
    colormap(jet)
    colorbar
    caxis([0 max(max(sst))]) %把 colormap 的區間範圍從 0 到 30 改成 0 到 max(max(sst)) 
    title([n,' SST_MODIS'],'Interpreter','none');
    print(n,'-dpng')
end
% n = datestr(t,'yyyy-mm-dd')
%% 畫圖並以 print 存圖  (較麻煩且沒效率的方法)
% for i=1:5
% %     sst2{i} = reshape(sst{i},[],1);
%     sst{1,i}(find(sst{1,i} >= 45.0007)) = NaN;
%     figure(i)
%     m_proj('miller','lon',[-180 180],'lat',[-90 90]);
%     [Xlon,Ylat] = meshgrid(Sublon{i},Sublat{i});
%     m_pcolor(Xlon,Ylat,sst{i});
%     % m_gshhs_l('patch',[.1 .1 .1]);
%     m_coast('patch',[.1 .1 .1],'edgecolor','k');
%     m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
%         'xtick',[-180:60:180],'ytick',[-90:30:90],...
%         'XaxisLocation','bottom','YaxisLocation','left');
%     colormap(jet)
%     colorbar
%     caxis([0 28]) %把 colormap 的區間範圍從 0 到 30 改成 0 到 28 
%     title([n(i,1:7),' SST_MODIS'],'Interpreter','none');
%     print(n(i,1:7),'-dpng')
% end

%%  MOCIS_SST_mutil02  檢討 (2019/10/25)

% a 不需要用structrue2table
% 迴圈要簡化
% 重複用到的數字要用變數呈現，改資料才不用一個一個改

a(1).name
% ans =
% 
%     'A20112132011243.L3m_MO_NSST_sst_9km.nc'

a(i).name(1:10)

% ans =
% 
%     'A201133520'

a(i).name(2:9)

% ans =
% 
%     '20113352'

a(i).name(2:8)

% ans =
% 
%     '2011335'

num2str(10)

% ans =
% 
%     '10'