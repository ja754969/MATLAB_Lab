% Load the data, extracted from the text file and organized
load data2000_organized

% Determine the average wind speed for each month
% Set aside space
avgWS = zeros(12,1);
% Loop over months
for k = 1:12
    % Find the observations for just the kth month
    idx = (month == k);
    % Extract the wind speeds and take the average
    avgWS(k) = mean(windSpeed(idx));
end

% View the result
avgWS
