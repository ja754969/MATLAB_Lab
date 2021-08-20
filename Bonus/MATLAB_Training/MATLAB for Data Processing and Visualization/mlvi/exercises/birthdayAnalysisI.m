%% BIRTHDAYANALYSISI  Plot birthday data from 1978.

%% 1. Execute birthdayRead.m file
% This creates the cell array of data (data)
birthdayRead

%% 2. Convert dates to numbers
dates = datenum(data{:, 1});

%% 3. Create a plot of the data
numData = data{:,2};
plot(dates,numData)
datetick('x','mmm')
title('US Births in 1978')
