% MLBBATCH Automatically import data from multiple files.
%
% Demonstrates using a FOR-loop in conjunction with programmatic import
% methods to import data from multiple files.  In this example, three
% separate course files -- i.e., 'mlb07al_east.dat', 'mlb07al_central.dat',
% and 'mlb07al_west.dat' -- contain data to be imported.  The FOR-loop
% executes a sequence of FOPEN, TEXTSCAN, and FCLOSE operations
% independently on each of these files.

%% 1. Create a list of files to be imported
filelist = dir('mlb07al_*.dat');

%% 2. Read in the data from each file.
% Gather the file names into a cell array
files = { filelist.name };
n = length(files);

% Preallocate the cell array to collect the data
data = cell(n,1);

% Import data from each file in the list
for k = 1:n
    data{k} = mlbBatchRead(files{k});
end
