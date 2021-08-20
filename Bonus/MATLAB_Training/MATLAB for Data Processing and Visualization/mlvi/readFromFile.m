% Define file name
fnm = 'hurricaneData\hurricaneData2000.txt';
% Open the file
fid = fopen(fnm);

% Read the data:
% The file has 5 columns -- one text, four numeric -- separated by tabs
% Lines starting with "##" are headers -- ignore them
% Read just columns 1 and 4
data = textscan(fid,'%s%*f%*f%f%*f','Delimiter','\t','commentstyle','##');

% Close the file
fclose(fid);
