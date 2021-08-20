%% MLBREADI reads the baseball statistics from mlb07.csv.

%% 1. Open mlb07.csv file
edit('mlb07.csv')

%% 2. Read the column header line
fid = fopen('mlb07.csv','rt');
colHeaders = textscan(fid,'%s',8,'HeaderLines',6,'Delimiter',',');

%% 3. Read data from mlb07.csv
fmt = '%s %f %f %f %f-%f %s %s %f-%f';
data = textscan(fid,fmt,'Delimiter',','); 

%% 4. Read selected data from mlb07.csv
frewind(fid)
fmtSel = '%s %f %f %*f %*f-%*f %*s %*s %*f-%*f';
selData = textscan(fid,fmtSel,'HeaderLines',7,'Delimiter',','); 
fclose(fid);
