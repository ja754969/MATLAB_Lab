%% Get data
%  Run readFromFile, or...
load data2000_raw

%% Extract dates and wind speeds
date = data{1};
windSpeed = data{2};

% Get month of each observation...
% ...by converting date strings to date vectors & extracting the second
% element of each vector
%     dv = datevec(date);
%     month = dv(:,2);
% ...or by directly asking for just the second element of each date vector
[~,month] = datevec(date);

%% Remove any measurements below the minimum wind speed for a Tropical Storm
%  Define the wind speeds for the boundaries of the Saffir-Simpson scale
SSscale = [39,74,96,111,130,157];
%  Define corresponding (text) labels
catLabels = {'TS';'1';'2';'3';'4';'5'};
%  Another way, more automated:
%     catLabels = ['TS';cellstr(num2str((1:5)'))];

%  Find the speeds above the minimum
idx = windSpeed >= SSscale(1);
%  Extract the data
month = month(idx);     % Method 1: keep the "good" values
windSpeed(~idx) = [];   % Method 2: discard the "bad" values

%% Calculate average wind speed for each month
%  Brute force way
%     avgWS = zeros(12,1);
%     for k = 1:12
%         idx = (month == k);
%         avgWS(k) = mean(windSpeed(idx));
%     end

%  Using ACCUMARRAY
avgWS = accumarray(month,windSpeed,[12,1],@mean);

%% Categorize each measurement according to the Saffir-Simpson scale
%  Compare each wind speed measurement to S-S scale
cmpr = bsxfun(@ge,windSpeed,SSscale);   % GE is function name for ">="
%  Sum (for each measurement) to get storm category
ctgry = sum(cmpr,2);

%% Calculate the total number of days of each category (in each month)
%  Count number of measurements in each month and category (count => add ones)
days = accumarray([month,ctgry],1,[12,6]);

%  Convert observation count into number of days per year.  Each
%  observation represents 6 hours (= 1/4 day) so divide by 4 to get days.
%  Observations are for a decade, so divide by 10 to get days/year.
days = days/40
