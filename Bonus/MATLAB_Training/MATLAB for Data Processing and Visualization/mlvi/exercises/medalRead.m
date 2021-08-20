%% MEDALREAD imports the 2008 Beijing Olympics data

%% 1. Open medalcount.txt to view contents
edit('medalcount.txt')

%% 2. Read the column headers
% Open the file for reading
fid = fopen('medalcount.txt');

% Read the column headers from the file
% The third entry, 19, indicates the number of entries to read
colHeaders = textscan(fid, '%s', 19, 'HeaderLines', 4, 'Delimiter', '\t');

%% 3. Read the data
% Read the data from the file
formatstr = ['%f%s' repmat('%f', 1, 17)];
data = textscan(fid, formatstr, 'Delimiter', '\t');

% Close the file
fclose(fid);
