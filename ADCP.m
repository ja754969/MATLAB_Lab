% �eADCP���C����(u,v,u+v)
%80���إH�W���y�t�e���Z��
%�q�`�u�e80���ز`�H�U�����
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
set(gca,'View',[90 90],'tickdir','out') % �վ�϶b����쨤�B����
colormap('jet')
% x = DISIL000_2.SerDay