%% Process all hurricane data files

%% Define file names
%  Get a file listing of all .txt files in a given data directory
dataDir = 'hurricaneData';
files = dir([dataDir,filesep,'*.txt']);

%% Loop over all files & process them
for k = 1:length(files)
    % Get the name of the kth file
    fname = [dataDir,filesep,files(k).name];
    % Read
    data = readHurricane(fname);
    % Process
    [ws,d] = processHurricane(data{:});
    % Plot
    plotHurricane(ws,d)

    % Add a title
    % Use some regular expression cleverness: find the numbers in the name
    % of the file.  This will give the beginning year of the decade.
    yr = regexp(files(k).name,'\d+','match');
    yr = yr{1};
    % Make a string "beginning_year -- ending_year"
    % Determine the end year by taking the first 3 character of the
    % beginning and adding "9" to the end
    title([yr,' -- ',yr(1:3),'9'])
end
