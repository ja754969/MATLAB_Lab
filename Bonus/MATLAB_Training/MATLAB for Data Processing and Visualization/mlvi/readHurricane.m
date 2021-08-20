function data = readHurricane(fnm)
% readHurricane  Reads data from hurricane data file
% Inputs: a string containing the file name
% Outputs: a 2-element cell array containing the date strings and the wind speeds

% Open the file
fid = fopen(fnm);

% Read the data:
% The file has 5 columns -- one text, four numeric -- separated by tabs
% Lines starting with "##" are headers -- ignore them
% Read just columns 1 and 4
data = textscan(fid,'%s%*f%*f%f%*f','Delimiter','\t','commentstyle','##');

% Close the file
fclose(fid);
