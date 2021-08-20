%% Load data
load('SST.mat')

%% Set up grid for interpolation
[lonGrid,latGrid] = meshgrid(-150:-90,-10:10);

%% Make initial surface plot
%  Interpolate data onto grid
sstGrid = griddata(lon,lat,sst(:,1),lonGrid,latGrid);
%  Make surface
h = surf(lonGrid,latGrid,sstGrid);
set(h,'EdgeColor','none')
set(h,'FaceColor','interp')
%  Set viewpoint
view([-30,35])
xlabel('Longitude'), ylabel('Latitude'), zlabel('Temperature [K]')
ht = title('Jan 2003');
%  Set vertical axis and color limits
limits = [min(sst(:)),max(sst(:))];  % min/max of all data (over all months)
set(gca,'CLim',limits)
set(gca,'ZLim',limits)

%  The "zbuffer" rendering can be a bit more robust (when exporting
%  animations in older versions)
set(gcf,'renderer','zbuffer')

%% Set up animation output file
%  Create a VideoWriter variable
sstVideo = VideoWriter('SSTanimation.mp4','MPEG-4');
%  Set the frame rate of the VideoWriter
sstVideo.FrameRate = 6;
%  Open the file for writing
open(sstVideo);

%% Animate surface
%  Loop over all months
for k = 1:size(sst,2)
    % Interpolate data to grid
    sstGrid = griddata(lon,lat,sst(:,k),lonGrid,latGrid);
    % Update surface
    set(h,'ZData',sstGrid)
    % Update title -- use DATESTR to create a string from the month number
    set(ht,'String',datestr([2003,k,1,0,0,0],'mmm yyyy'))
    pause(0.2)
    % Get snapshot of current figure
    frame = getframe(gcf);
    % Write frame to video
    writeVideo(sstVideo,frame)
end

%% Finish up
%  Close video file
close(sstVideo);

%  View results
winopen('SSTanimation.mp4')
