%% Examples of using DIR to get names of files (but not directories)

%% Get a list of files with a specific extension
dataDir = 'hurricaneData';
files = dir([dataDir,filesep,'*.txt']);
%  See the size of the result
whos files

%  Display each file name
for k = 1:length(files)
    disp(files(k).name)
end


%% List everything in a directory
dataDir = 'hurricaneData';
files = dir(dataDir);
%  See the size of the result
whos files

%  Display each file name
for k = 1:length(files)
    disp(files(k).name)
end

%% List everything in a directory and use post-processing
dataDir = 'hurricaneData';
files = dir(dataDir);
%  See the size of the result
whos files

%  Display each file name
for k = 1:length(files)
    % Check if the file is actually a file or a directory
    if ~files(k).isdir
        disp(files(k).name)
    end
end
