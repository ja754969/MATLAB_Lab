clear;clc
x = linspace(-2,1,5)
y = linspace(2*exp(x(1))-x(1)-1,2*exp(x(end))-x(end)-1,5)
plot(x,y,'o')
