%% HURRREAD reads the hurricane data from the file 'hurricanes.data'

%% 1. Open hurricanes.data file. 
edit('hurricanes.data')

%% 2. Import column headers from hurricanes.data file. 
fid = fopen('hurricanes.data','rt');
headers = textscan(fid,repmat('%s',1,10),1,'headerlines',10);

%% 3. Make use of CollectOutput option in textscan and compare the results.
frewind(fid)
headersCollectOutput = textscan(fid,repmat('%s',1,10),1,...
    'headerlines',10,'CollectOutput',1);

% Compare the results
whos headers headersCollectOutput

% Look compare the first element in each cell array
v1 = headers{1};
v2 = headersCollectOutput{1}{1};
whos v1 v2
