% MLBAUTOSOL Imports and plots data from multiple files.
%

%% Read in the file names
filelist = dir('mlb07al_*.dat');
files = { filelist.name };
n = length(files);

% Process each file
for k = 1:n
    fn = files{k};
    [wins,losses,teamNames] = mlbAutoRead(fn);
    region = fn(9:end-4);
    mlbAutoPlot(wins,losses,teamNames,region);
end
