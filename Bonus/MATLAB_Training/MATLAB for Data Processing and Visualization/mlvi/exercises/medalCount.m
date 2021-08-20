%% MEDALCOUNT organizes and counte the medals
% from the 2008 Beijing Olympics

%% 1. Run medalRead to bring in the data
medalRead

%% 2. Answer questions

%% Which country had the most number of gold medals?
% Create a variable containing the number of gold medals
gold = data{15};

% Find the maximum for total gold
[maxGoldNum, idGold] = max(gold);

% Extract the country name
countries = data{2};
maxGoldCountry = countries{idGold};

% Display the results
fprintf(1,'%s had the most gold medals with %d medals\n',...
    maxGoldCountry,maxGoldNum);

%% Which country had the most number of total medals?
% Create a variable containing the number of gold medals
total = data{18};

% Find the maximum for total gold
[maxNum, id] = max(total);

% Extract the country name
maxTotCountry = countries{id};

% Display the results
fprintf(1,'%s had the most total number of medals with %d medals\n',...
    maxTotCountry,maxNum);

%% Which country had the highest ratio of gold to total?
% Find the ratio between gold to total for each country
ratio = gold./total;

% Find the maximum ratio
[maxRatNum, idRat] = max(ratio);

% Extract the country name
maxRatCountry = countries{idRat};

% Display the results
fprintf(1,['%s had the highest ratio of gold to total medals with a '....
    'ratio of  %.2f\n'],maxRatCountry,maxRatNum);

%% 3. Sort the countries in order of total medals
[s, index] = sort(total, 'descend');

% Arrange the countries based on the sorted indices
sortedCountries = countries(index);
disp('Countries sorted based on total medals:')
disp(sortedCountries)
fprintf(1,'\n');

%% 4. List the countries with more than 15 gold medals
tgGtr15 = gold>15;

% Which countries won more than 15 medals?
totalGoldGtr15 = countries(tgGtr15);
disp('Countries with more than 15 gold medals:')
disp(totalGoldGtr15)
fprintf(1,'\n');

%% 5. Countries that did not win a silver medal
% Create a variable with the number of total silver medals for each country
silver = data{16};

% Determine the index values where countries had no entry
tsNan = isnan(silver);

% Index into the countries with the logical array to determine which
% countries had no silver medals
countriesNS = countries(tsNan);
disp('Countries with no silver medals:')
disp(countriesNS)
