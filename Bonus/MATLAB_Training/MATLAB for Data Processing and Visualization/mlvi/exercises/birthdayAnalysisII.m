%% BIRTHDAYANALYSISII  Organize and count birthday data.

%% 1. Execute birthdayRead.m file
% This creates the cell array of data (data)
birthdayRead

%% 2. Create an array that stores the number of births by month
numBirths = data{:,2};
dates = datenum(data{:, 1});

% Determine the month for each date
[~,months] = datevec(dates);

% Accumulate the values based on the month
monthTally = accumarray(months, numBirths);

% Determine the months with the maximum and minimum number of births
[maxBM,maxM] = max(monthTally);
[minBM,minM] = min(monthTally);

% Create a cell array with the months of the year
allMonths = { 'Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep',...
    'Oct','Nov','Dec'}';

% Display the results
fprintf(1,'%s had the most births with %.0f births\n',allMonths{maxM},...
    maxBM);
fprintf(1,'%s had the fewest births with %.0f births\n\n',...
    allMonths{minM},minBM);

%% 3. Create an array that stores the number of births by day of the week
day = weekday(dates);

% Accumulate the values based on the day of the week
dayTally = accumarray(day, numBirths);

% Determine the months with the maximum and minimum number of births
[maxBD,maxD] = max(dayTally);
[minBD,minD] = min(dayTally);

% Create a cell array with the days of the week
allDays = { 'Sun','Mon','Tues','Wed','Thurs','Fri','Sat'}';

% Display the results
fprintf(1,'%s had the most births with %.0f births\n',allDays{maxD},maxBD);
fprintf(1,'%s had the fewest births with %.0f births\n\n',allDays{minD},...
    minBD);
