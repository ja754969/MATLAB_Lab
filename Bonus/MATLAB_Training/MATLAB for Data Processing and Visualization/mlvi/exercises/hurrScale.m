%% HURRSCALE -- Correlation of wind speed against pressure for hurricanes
%
%  The Saffir-Simpson scale is used to categorize hurricanes.  Often both
%  center pressure and maximum sustained wind speed are given even though
%  categorization is based only on wind speed.  This script
%  demonstrates that the two measures are sufficiently correlated that this
%  is reasonable.  In the process, we see how to use plot options.

%% 1.  Load data
load hurr

%% 2. Extract numeric data
ws = hurr{9};
press = hurr{10};

%% 3. Remove missing data
iw = ws>0;
ip = press>0;

ws = ws(ip&iw);
press = press(ip&iw);

%% 4. Define boundaries of SS hurricane scale
ssscalep = [Inf,990,980,965,945,920,0];     % Pressures
ssscalew = [35,64,83,96,113,136,Inf];       % Wind speeds

%% 5.  Make scatter plot
figure
hold on  % Overlay plots
for k=1:6
    %  Extract each category separately
    idx = (ws>=ssscalew(k) & ws<ssscalew(k+1));
    %  Plot it with large points of a specific color
    plot(ws(idx),press(idx),'.','MarkerSize',6,'Color',cmap(k,:))
end

%% 6. Add the scale boundaries
%  Use large, thick, black x's
plot(ssscalew(2:6),ssscalep(2:6),'kx','MarkerSize',8,'LineWidth',2)
%  Add annotations
xlabel('Wind Speed (knots)'), ylabel('Pressure (mbar)')
title({'Storm/Hurricane Pressure Versus Wind Speed';
    'Black crosses show boundaries of Saffir-Simpson Scale'})

%% 7. How well do the values correlate?
r=corrcoef([press,ws]);
fprintf(1,['Pressure and windspeed have a correlation coefficient value '...
    'of %f\n'],r(2));
