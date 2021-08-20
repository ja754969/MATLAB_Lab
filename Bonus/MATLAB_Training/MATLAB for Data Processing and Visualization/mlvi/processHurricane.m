function [avgWS,days] = processHurricane(date,windSpeed)
% processHurricane
% Inputs: a cell array of date strings and a vector of wind speeds
% Outputs: a vector of average wind speeds for each month and a matrix of
% (average) days per month storms of each category were recorded

% Get month of each observation
[~,month] = datevec(date);

% Remove any measurements below the minimum wind speed for a Tropical Storm
% Define the wind speeds for the boundaries of the Saffir-Simpson scale
SSscale = [39,74,96,111,130,157];

% Find the speeds above the minimum
idx = windSpeed >= SSscale(1);
% Extract the data
month = month(idx);     % Method 1: keep the "good" values
windSpeed(~idx) = [];   % Method 2: discard the "bad" values

% Calculate average wind speed for each month
avgWS = accumarray(month,windSpeed,[12,1],@mean);

% Categorize each measurement according to the Saffir-Simpson scale
% Compare each wind speed measurement to S-S scale
cmpr = bsxfun(@ge,windSpeed,SSscale);   % GE is function name for ">="
% Sum (for each measurement) to get storm category
ctgry = sum(cmpr,2);

% Calculate the total number of days of each category (in each month)
% Count number of measurements in each month and category (count => add ones)
days = accumarray([month,ctgry],1,[12,6]);

% Convert observation count into number of days per year.  Each observation
% represents 6 hours (= 1/4 day) so divide by 4 to get days.
% Observations are for a decade, so divide by 10 to get days/year.
days = days/40;
