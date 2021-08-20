%% FUELORG Solution to Fuel Efficiency Exercise


%% 1.Read the data in
load fuel

%% 2. Extract a unique list of auto manufacturers
mfr = data{2};

mfrUnique = unique(mfr);
disp(mfrUnique);

%% 3. Find the average city, hwy, and combined EPA MPG
epaCityMpg = data{9};
epaHwyMpg = data{10};
epaCombMpg = data{11};

% Compute the averages
avgCity = mean(epaCityMpg);
avgHwy  = mean(epaHwyMpg);
avgComb = mean(epaCombMpg);

% Display the results
disp('   City      Highway   Combined');
disp([avgCity, avgHwy, avgComb]);

%% 4. Create a histogram of the combined EPA MPG
figure
hist(epaCombMpg, 100);
title('EPA Combined MPG for 2009');
