%% HURRANIMI plots the hurricane paths for 1975

%% 1. Import the data
load('hurr1975')

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
    x = -hurr1975{k,2}(:,2);
    y = hurr1975{k,2}(:,1);
    % Create the track for that particular hurricane
    hl = line(x,y,'Color','y','LineWidth',3);
    drawnow;
    pause(0.5)
    if k~=length(hurr1975)
        delete(hl)
    end
end

%% BONUS Segment by segment
figure
%  Load background image file, get size and set up variables for latitude
%  and longitude
load NAimage

%  Plot background image, set axes, labels, etc.
image(lng,lat,naimg);
set(gca,'YDir','normal'), axis image
xlabel('\bf Longitude'), ylabel('\bf Latitude')
title('\bf Hurricane paths for 1975')

% The first 7 rows of jet(8) turn out to be very nice colors for the 7
% classifications (depression/storm/hurricane category 1-5)
cmap = jet(8);
% Define the borderline windspeeds in the Saffir-Simpson system
safsim = [35,64,83,96,113,137];

%  Loop through hurricanes in given year 
for k = 1:length(hurr1975)
    %  Get the x (long) and y (lat).  
    %  Flip x to standard coordinates (+ = E / - = W)
    x = -hurr1975{k,2}(:,2);
    y = hurr1975{k,2}(:,1);
    ws = hurr1975{k,2}(:,3);
    % Create array to store categories; initially everything is 1
    % (depression)
    ctg = ones(size(ws));
    % Loop through the array of borderline values.  If windspeed is greater
    % than the borderline value, increase the storm's category.  Repeat.
    for j=1:6
        idx = (ws>safsim(j));
        ctg(idx) = ctg(idx)+1;
    end

    % Create the track for that particular hurricane
    ns = length(x)-1;
    hl = nan(1,ns);
    for j=1:ns
        hl(j) = line([x(j) x(j+1)],[y(j) y(j+1)],'Color',cmap(ctg(j),:),'LineWidth',3);
        drawnow
        pause(0.05)
    end
    
    if k~=length(hurr1975)
        pause(0.5)
        delete(hl)
    end
end
