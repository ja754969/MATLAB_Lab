%% HURRVISIII plots routes of all hurricanes from 1975

%% 1.  Load data
load hurr1975

%% 2.  Plot the background
%  Load background image file, get size and set up variables for latitude
%  and longitude
load NAimage

%  Plot background image, set axes, labels, etc.
image(lng,lat,naimg);
set(gca,'YDir','normal'), axis image
xlabel('\bf Longitude'), ylabel('\bf Latitude')
title('\bf Hurricane paths for 1975')

%% 3. Overlay the storm paths
%  Loop through hurricanes in given year 
for k = 1:length(hurr1975)
    %  Get the x (long) and y (lat).  
    %  Flip x to standard coordinates (+ = E / - = W)
    x   = -hurr1975{k,2}(:,2);
    y   =  hurr1975{k,2}(:,1);
    % Create the track for that particular hurricane
    line(x,y,'color',rand(1,3),'LineWidth',3);
end
