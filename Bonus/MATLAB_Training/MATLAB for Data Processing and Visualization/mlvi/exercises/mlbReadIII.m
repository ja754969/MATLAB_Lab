%% MLBREADIII reads the baseball statistics from mlb07.dat.

%% 1. Open mlb07.dat file
edit('mlb07.dat')

%% 2. Read the column header line
fid = fopen('mlb07.dat','rt');
colHeaders = textscan(fid,'%s',8,'HeaderLines',6);

%% 3. Read data from mlb07.dat
fmt = '%11[^0123456789] %f %f %f %s %s %s %f-%f';
data = textscan(fid,fmt);

%% 4. Read selected data from mlb07.dat
frewind(fid)
fmt = '%11[^0123456789] %f %f %*[^\n]';
data = textscan(fid,fmt,'headerlines',7);
fclose(fid);
