clear;clc

[t, y] = meshgrid(1:5, 4:-1:1);

%dt的行間距應為y的採樣間隔,列間距為t的採樣間隔

dt = ones(4, 5);

dy = (t - y)/2;

figure; quiver(t, y, dt, dy);

hold on;

x = -2:0.5:1;

z1 = exp(x) +(1/2)* x.^2 +1;

z2 = exp(x) +(1/2)* x.^2 +2;

plot(x, z1, x, z2);

