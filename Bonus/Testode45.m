clear;clc

[t, y] = meshgrid(1:5, 4:-1:1);

%dt���涡�Z����y���ļ˶��j,�C���Z��t���ļ˶��j

dt = ones(4, 5);

dy = (t - y)/2;

figure; quiver(t, y, dt, dy);

hold on;

x = -2:0.5:1;

z1 = exp(x) +(1/2)* x.^2 +1;

z2 = exp(x) +(1/2)* x.^2 +2;

plot(x, z1, x, z2);

