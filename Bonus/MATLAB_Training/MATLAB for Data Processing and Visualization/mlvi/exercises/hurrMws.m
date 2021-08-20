%% HURRMWS organizes hurricane data

%% 1.  Load data
load hurr

%% 2. Hurricane with the largest wind speed and the year it occured.
ws = hurr{9};
[wsMax,indWsMax] = max(ws); 

% Year & name of the largest windspeed hurricane
yearMaxWs = hurr{1}(indWsMax);
names = hurr{6};
nameMaxWs = names(indWsMax,:);
nameMaxWs = deblank(nameMaxWs);

fprintf(1,['Hurricane %s with the maximum windspeed of %5.2f knots '...
    'occurred in the year %.0f\n'],nameMaxWs,wsMax,yearMaxWs);

%% 3. Display a unique list of category 5 hurricanes
% Create a logical vector for category 5 hurricane
indCat5 = ws >= 137; 

% Create a cell array of all category 5 hurricane names
names = cellstr(names);
cat5Name = names(indCat5); 

% Find a unique list of category 5 hurricane names
hurr5 = unique(cat5Name); 
disp('Category 5 Hurricanes:')
disp(hurr5)

%% 4. Find a unique list of hurricanes and find their maximum windspeeds
% Find a unique list of hurricane names
namesUnique = unique(names);

% Create an anonymous function that returns the maximum wind speed value
% for a particular hurricane
maxWS = @(hName) max(ws(strcmp(hName,names)));

% find the maximum wind speed for all the hurricanes 
wsMax = cellfun(maxWS,namesUnique);

%% 5. Concatenate the hurricane names and their maximum wind speeds
hurrTable = [namesUnique,num2cell(wsMax)]; 
disp('  Hurricanes   Max WindSpeed')
disp(hurrTable)

%% 6. Sort the hurricanes with respect to their maximum windspeeds in 
% descending order and display them.
hurrWsSort = sortrows(hurrTable,-2); 
disp('  Hurricanes   Sorted WindSpeed')
disp(hurrWsSort)
