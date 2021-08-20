%% WORLDPOP Solution to World Population Exercise

%% 1. Read the Data from the World Population File
% Open the text file
edit('worldPopulation.txt')

% Read the data into the workspace
fid = fopen('worldPopulation.txt');
formatstr = '%*f%s%s%*[^\n]';
data = textscan(fid, formatstr, 'HeaderLines', 6, 'Delimiter', '\t');
fclose(fid);

%% 2. Clean up the data
% Convert numeric values represented as strings with commas to doubles
pops = str2double(data{2});

%% 3. How many countries had populations on the order of 100e6

% Form the logical expression for extracting the data
ind = (pops >= 1e8 & pops <= 1e9);

% Obtain the count
count = nnz(ind);

% Display the results
fprintf(1,'%.0f countries have populations on order of 100e6: \n',count);

%% 4. Which countries had populations on the order of 100e6
% Extract the countries
countries = data{1}(ind);

% Display the results
disp(countries);
