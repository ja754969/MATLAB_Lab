% Load the data, extracted from the text file and organized
load data2000_organized

%  Define the wind speeds for the boundaries of the Saffir-Simpson scale
SSscale = [39,74,96,111,130,157];

% Determine the category for each wind measurement
% Set aside space
ctgry = zeros(size(windSpeed));
% Loop over each measurement
for k = 1:length(ctgry)
    % Compare wind speed with values in the S-S scale
    ctgry(k) = sum(windSpeed(k) >= SSscale);
end
