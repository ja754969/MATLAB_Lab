% 畫ADCP的每日資料(u,v,u+v)
%80公尺以上的流速容易擾動
%通常只畫80公尺深以下的資料
cd('C:\Users\user\Documents\MATLAB')
clear;clc

load D1S1L000_2
%%
u = SerEmmpersec*0.001; %(m/s)
v = SerNmmpersec*0.001; %(m/s)
Error_V = SerErmmpersec*0.001; %(m/s) A Series of Error velocities
Mag_V = SerMagmmpersec*0.001;% A Series of Magnitudes (m/sec)
% BTdepth_B1 = 
dep = linspace(0,16.65*2,68);
[d1,t1] = meshgrid(dep,SerDay);

contourf(d1,t1,u)
shading interp
% clabel(c5,h5)
% get(gca)
set(gca,'View',[90 90],'tickdir','out') % 調整圖軸的方位角、仰角
colormap('jet')
% x = DISIL000_2.SerDay