%% BIRTHDAYREAD  Imports data from the birthday.txt file into the 
% MATLAB Workspace

%% 1. Open birthday.txt to view contents
edit('birthday.txt')

%% 2. Read the column headers
% Open the connection to the text file
fid = fopen('birthday.txt');

% Import the headerline
bdHeaderline = fgetl(fid);

%% 3. Import the data
% Read in the birthday data
data = textscan(fid, '%s%d');

% Close the file connection
fclose(fid);
