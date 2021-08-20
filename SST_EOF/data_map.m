clear;clc;clf
filename = 'sst_ndjfm_anom.nc';
nc_dump(filename);
sst = nc_varget(filename,'sst');
size_sst = size(sst);
sst_new = NaN(size_sst(2),size_sst(3),size_sst(1));
for i = 1:size_sst(1)
   sst_new(:,:,i) = sst(i,:,:); 
end
lon = nc_varget(filename,'longitude');
% lon = lon-180;
lat = nc_varget(filename,'latitude');
time = nc_varget(filename,'time');
[XX,YY] = meshgrid(lon,lat);
m_proj('miller','lon',[lon(1) lon(end)],'lat',[lat(1) lat(end)]);  % 繪製海面(白色)
m_pcolor(XX,YY,-sst_new(:,:,1));shading flat;colormap('jet')
m_gshhs_c('patch',[.7 .7 .7],'edgecolor','k');    % 繪製陸地
m_grid('linewi',1,'linestyle',':','tickdir','in','gridcolor','k',...
        'XaxisLocation','bottom','YaxisLocation','left','box','fancy');
