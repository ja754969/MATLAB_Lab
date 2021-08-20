% MLBAUTO Imports and plots data from multiple files.
%

%% Read in data from mlb07al_east.dat
fn = 'mlb07al_east.dat';
% Open the connection
fid = fopen(fn, 'rt');
% Create the format specifier
fmt = '%11[^0123456789] %f %f %f %s %s %f-%f %s %f-%f %s';
% Store the data into the variable data
data = textscan(fid, fmt, 'HeaderLines', 7);
% Close the connection
fclose(fid);

% Pull out the data to be plotted - wins and losses
wins = data{2};
losses = data{3};

% Plot the data
figure
barh([wins,losses])
legend('wins','losses','Location','E')
title('American League Baseball - East - 2007')
xlim([60,100])

% Update the tick labels
teamNames = data{1};
set(gca,'YTickLabel',teamNames)

%% Read in data from mlb07al_central.dat
fn = 'mlb07al_central.dat';
% Open the connection
fid = fopen(fn, 'rt');
% Create the format specifier
fmt = '%11[^0123456789] %f %f %f %s %s %f-%f %s %f-%f %s';
% Store the data into the variable data
data = textscan(fid, fmt, 'HeaderLines', 7);
% Close the connection
fclose(fid);

% Pull out the data to be plotted - wins and losses
wins = data{2};
losses = data{3};

% Plot the data
figure
barh([wins,losses])
legend('wins','losses','Location','E')
title('American League Baseball - Central - 2007')
xlim([60,100])

% Update the tick labels
teamNames = data{1};
set(gca,'YTickLabel',teamNames)

%% Read in data from mlb07al_west.dat
fn = 'mlb07al_west.dat';
% Open the connection
fid = fopen(fn, 'rt');
% Create the format specifier
fmt = '%11[^0123456789] %f %f %f %s %s %f-%f %s %f-%f %s';
% Store the data into the variable data
data = textscan(fid, fmt, 'HeaderLines', 7);
% Close the connection
fclose(fid);

% Pull out the data to be plotted - wins and losses
wins = data{2};
losses = data{3};

% Plot the data
figure
barh([wins,losses])
legend('wins','losses','Location','E')
title('American League Baseball - West - 2007')
xlim([60,100])

% Update the tick labels
teamNames = data{1};
set(gca,'YTickLabel',teamNames)
