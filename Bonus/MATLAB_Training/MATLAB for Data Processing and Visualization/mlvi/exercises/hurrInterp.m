%% HURRVISI
% As the windspeed increases the risk of hurricane also increases.
% We want to plot windpeed vs day of the year vs year to investigate which 
% months had the most hurricanes over the years.

%% 1. Load data
load hurr

%% 2. Create the x-y grid for surface plot
days = 1:365;
hurrYear = hurr{1};
year = min(hurrYear):max(hurrYear);

% Create the grid x-y grid for surface plot
[D,Y] = meshgrid(days,year);

%% 3. Create a windspeed matrix 
hurrWs = hurr{9};
ws = griddata(dayNum,hurrYear,hurrWs,D,Y);

%% 4. Generate a surface plot
surf(Y,D,ws)
shading interp
axis tight
xlabel('\bf Year')
ylabel('\bf Day of the Year')
zlabel('\bf Windspeed (knots)')
title('\bf North Atlantic Hurricane Data for 1970 - 2006')

%% 5. Interpolate the data to smoothen the display
% Define a vector of grid spaces
dx = [0.1, 0.25, 2, 5];

% Create the interpolant
F = scatteredInterpolant(dayNum,hurrYear,hurrWs,'linear','none');

for k = 1:length(dx)
    % Create the vectors of day and year values
    d = 1:dx(k):365;
    y = year(1):dx(k):year(end);
    % Create the mesh needed for the plot
    [Di,Yi] = meshgrid(d,y);
    % Evaluate the interpolant at the new points
    wsi = F(Di,Yi);
    figure
    surf(Yi,Di,wsi)
    shading interp
    axis tight
    % Annotate the plot
    xlabel('\bf Year')
    ylabel('\bf Day of the Year')
    zlabel('\bf Windspeed (knots)')
    title('\bf North Atlantic Hurricane Data for 1970 - 2006')
end
