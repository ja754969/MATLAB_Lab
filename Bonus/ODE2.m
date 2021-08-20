clear;clc
F = @(t,y) 1*exp(t)-t-1
tspan = [-1 1]
y0 = 0
[t,y] = ode45(F,tspan,y0)
plot(t,y,'o-')