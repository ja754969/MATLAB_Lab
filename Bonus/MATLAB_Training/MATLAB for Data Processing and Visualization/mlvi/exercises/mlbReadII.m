%% MLBREADII reads the baseball statistics from mlb07.csv.

%% 1. Import the data into MATLAB using XLSREAD
% Use XLSREAD to read in the data
[numData,charData,rawData] = xlsread('mlb07.csv','A8:H21');

%% 2. Read the data from mlb07al.csv
edit('mlb07al.csv')
fi = fopen('mlb07al.csv');
fmt = '%s %f %f %f %f-%f %s %s %f-%f';
alData = textscan(fi,fmt,'Delimiter',',','CommentStyle','++');
fclose(fi);


