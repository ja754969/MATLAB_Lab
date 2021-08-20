function [wins,losses,teams] = mlbAutoRead(fn)
%MLBAUTOREAD reads in the data from file fn

fid = fopen(fn, 'rt');
% Create the format specifier
fmt = '%11[^0123456789] %f %f %f %s %s %f-%f %s %f-%f %s';
% Store the data into the variable data
data = textscan(fid, fmt, 'HeaderLines', 7);
% Close the connection
fclose(fid);

wins = data{2};
losses = data{3};
teams = data{1};
