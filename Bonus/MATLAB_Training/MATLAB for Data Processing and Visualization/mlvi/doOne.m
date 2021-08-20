%% Apply the whole process to one file

%% Define the file name
dataDir = 'hurricaneData';
fname = [dataDir,filesep,'hurricaneData2000.txt'];

%% Call the three functions to read/process/plot
data = readHurricane(fname);
[ws,d] = processHurricane(data{:});
plotHurricane(ws,d)

%% Add a title, specific to the file
title('2000 -- 2009')
