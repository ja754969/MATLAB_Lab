clear;clc;close all
%%
% cd('H:\JT_NTOU_ERS_lab\SAR_typhoon_sentinel1')
cd('C:\Users\user\Documents\MATLAB\Sentinel-1')
filename = 's1a-iw-ocn-vv-20201201t100119-20201201t100144-035491-042632-001.nc';
%ncdisp(filename)
nc_dump(filename); % nc_dump 載入檔案
% sst4 = nc_varget(filename,'sst4');           % nc_varget 取出檔案中的變數 sst4
% qual_sst4 = nc_varget(filename,'qual_sst4'); % nc_varget 取出檔案中的變數 qual_sst4
% Sublat = nc_varget(filename,'lat');          % nc_varget 取出檔案中的變數 lat
% Sublon = nc_varget(filename,'lon');          % nc_varget 取出檔案中的變數 lon
% palette = nc_varget(filename,'palette');     % nc_varget 取出檔案中的變數 palette