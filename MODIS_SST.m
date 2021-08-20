% 1. Download MODIS SST monthly data produced at 9 km resolution from 2011/07 to 2012/07
%% 2. Use NetCDF package to load the data to Matlab. You might need to understand nc_dump and nc_varget
% https://oceancolor.gsfc.nasa.gov/l3/
current_folder  = pwd
cd(current_folder)
clear;clc;clf
filename = 'A20022132002243.L3m_MO_SST4_sst4_4km.nc';
%ncdisp(filename)
nc_dump(filename); % nc_dump 載入檔案
sst4 = nc_varget(filename,'sst4');           % nc_varget 取出檔案中的變數 sst4
qual_sst4 = nc_varget(filename,'qual_sst4'); % nc_varget 取出檔案中的變數 qual_sst4
Sublat = nc_varget(filename,'lat');          % nc_varget 取出檔案中的變數 lat
Sublon = nc_varget(filename,'lon');          % nc_varget 取出檔案中的變數 lon
palette = nc_varget(filename,'palette');     % nc_varget 取出檔案中的變數 palette
% data = nc_varget('A20022132002243.L3m_MO_SST4_sst4_4km.nc',varname)
% Sublon(Sublon < 0) = Sublon(Sublon < 0) + 360;
% Sublat(Sublat < 0) = Sublat(Sublat < 0) + 180;
%% 3. First, Plot the whole world data by M_map on 2012/01 and 2012/07.
figure(1)
m_proj('miller','lon',[-180 180],'lat',[-90 90]);
[Xlon,Ylat] = meshgrid(Sublon,Sublat);
m_pcolor(Xlon,Ylat,sst4);
% m_gshhs_l('patch',[.1 .1 .1]);
m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[-180:60:180],'ytick',[-90:20:90],...
        'XaxisLocation','bottom','YaxisLocation','left');
colormap(jet)
colorbar
%% 4. Then, Plot the data from 100°E to 160°E and 30°S to 30°N on the map.
LONLIM2=[100 160];LATLIM2=[-30 30];  % 重複用到的數字要用變數呈現，改資料才不用一個一個改
figure(2)
m_proj('miller','lon',LONLIM2,'lat',LATLIM2);
Sublon2 = nc_varget(filename,'lon');
Sublat2 = nc_varget(filename,'lat');
%--------------------------------------------------------------------------
ind1 = find(Sublon2 <= LONLIM2(2) & Sublon2 >= LONLIM2(1));
lonlim = Sublon2(ind1);
ind2 = find(Sublat2 <= LATLIM2(2) & Sublat2 >= LATLIM2(1));
latlim = Sublat2(ind2);
lonlim2 = lonlim';
latlim2 = latlim';
%--------------------------------------------------------------------------
% ind_comm = find(Sublon2 <= 160 & Sublon2 >= 100 & Sublat2 <= 30 & Sublat2 >= -30 );
%--------------------------------------------------------------------------
sst4_lim = sst4(ind2,ind1);
%--------------------------------------------------------------------------
[Xlon2,Ylat2] = meshgrid(lonlim,latlim);
m_pcolor(Xlon2,Ylat2,sst4_lim);
% m_coast('patch',[.1 .1 .1],'edgecolor','k');
m_gshhs_l('patch',[.1 .1 .1],'edgecolor','k');
m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[LONLIM2(1):30:LONLIM2(2)],'ytick',[LATLIM2(1):10:LATLIM2(2)],...
        'XaxisLocation','bottom','YaxisLocation','left');
colormap(jet)
colorbar
caxis([15 max(max(sst4_lim))]) %把 colormap 的區間範圍從 0 到 30 改成 0 到 max(max(sst4_lim)) 
%% 5. Plot the data from 100°E to 100°W and 30°S to 30°N on the map.
figure(3)
Sublon3 = nc_varget(filename,'lon');
Sublat3 = nc_varget(filename,'lat');
Sublon331 = Sublon3(Sublon3 < 0);
Sublon332 = Sublon3(Sublon3 > 0);
Sublon33 = [Sublon332;Sublon331];
Sublon33(Sublon33 < 0) = Sublon33(Sublon33 < 0) + 360;
% Sublat3(Sublat3 < 0) = Sublat3(Sublat3 < 0) + 180;
LONLIM3=[100 260];LATLIM3=[-30 30];  % 重複用到的數字要用變數呈現，改資料才不用一個一個改
m_proj('miller','lon',LONLIM3,'lat',LATLIM3);
%--------------------------------------------------------------------------
ind3 = find(Sublon33 <= 260 & Sublon33 >= 100);
lonlim3 = Sublon33(ind3)';
ind4 = find(Sublat3 <= 30 & Sublat3 >= -30 );
latlim3 = Sublat3(ind4)';
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
sst4_21 = sst4(:,1:4320);
sst4_22 = sst4(:,4320:end);
sst4_22 = [sst4_22,sst4_21];
sst4_lim2 = sst4_22(ind4,ind3);
%--------------------------------------------------------------------------
[Xlon3,Ylat3] = meshgrid(lonlim3,latlim3);
m_pcolor(Xlon3,Ylat3,sst4_lim2);
m_gshhs_l('patch',[.1 .1 .1],'edgecolor','k');
m_grid('linewi',2,'linestyle','none','tickdir','out','ticklen',0.0001,...
        'xtick',[100:40:260],'ytick',[-30:10:30],...
        'XaxisLocation','bottom','YaxisLocation','left');
colormap(jet)
colorbar
caxis([0 max(max(sst4_lim2))]) 