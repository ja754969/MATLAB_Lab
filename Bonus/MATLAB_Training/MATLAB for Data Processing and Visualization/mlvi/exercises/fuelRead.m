%% FUELREAD Reads in fuel efficiency data from a text file.

%% 1. Open 2009FEGuide.csv file
fn = '2009FEGuide.csv';
edit(fn)

%% 2. Read the column headers
% Open the connection to the file
fid = fopen(fn);

% Read the headers using textscan
colHeaders = textscan(fid,'%s',12,'HeaderLines',5,'Delimiter',',');

%% 3. Read data
fmt = '%q %s %s %f %s %f %f %f %f %f %f %s';
data = textscan(fid,fmt,'Delimiter',','); 

%% 4. Read selected data
frewind(fid)
fmtSel = '%*q %s %s %*f %*s %*f %*f %*f %*f %*f %f %*s';
selData = textscan(fid,fmtSel,'HeaderLines',6,'Delimiter',','); 
fclose(fid);
