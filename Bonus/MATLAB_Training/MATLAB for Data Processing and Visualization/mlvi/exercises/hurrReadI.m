%% HURRREAD reads the hurricane data from the file 'hurricanes.data'

%% 1. Open hurricanes.data file. 
edit('hurricanes.data')

%% 2. Import the header lines
% Open the connection to the file
fid = fopen('hurricanes.data','rt');

% Read the header line using fgetl
for idx = 1:11
    headerLine = fgetl(fid);
end

% Read the header line using textscan
frewind(fid)
headers = textscan(fid,repmat('%s',1,10),1,'HeaderLines',10);

%% 3. Import all hurricane data
% Make sure that data for all hurricanes have been imported. 
% (Hint: all columns in the file are fixed width to 11 character)
hurrData = textscan(fid,'%f %f %f %f %f %11c %f %f %f %f');

%% 4. Import only selected columns
frewind(fid);
hurrSelData = textscan(fid,'%f %f %f %f %*f %*11c %*f %*f %f %*f','headerlines',11);
fclose(fid);
