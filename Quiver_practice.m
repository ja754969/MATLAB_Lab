clear;clc;close all
current_folder  = pwd
cd(current_folder)
%%
t1 = linspace(-1,100,20);
y1 = linspace(-1,150,20);
[T,Y] = meshgrid(t1,y1);
scale_factor =  3./sqrt(T.^2+Y.^2);
figure(1)
quiver(T,Y, scale_factor.*T, scale_factor.*Y,'AutoScale','off');
axis([-1 100 -1 151])
ylabel('y')
xlabel('time (t)')
title('Direction field of function(1) with b=0.005')
%%
figure(2)
