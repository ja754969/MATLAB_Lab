%% MLBREADIV reads the baseball statistics from mlb07al.dat
%
% Demonstrates using the FGETL function to import character data from the
% 'mlb07al.dat' file.  In this example, the FGETL function reads a line of
% text from the file and discards the newline character. The WHILE-loop
% continues executing until it encounters the end of the file. For every
% line it checks for the occurence of word "Central". When that happens it
% reads the next 5 lines to import data for the central teams.

%% 1. Open mlb07al.dat file
edit('mlb07al.dat')

%% 2. Read to the point where the keyword 'Central' is found.
fid = fopen('mlb07al.dat');
textline = fgetl(fid);
while ischar(textline) % continue reading if textline is not -1
    % Compare to see if line read is the header for central teams
    if any(strfind(textline,'Central'))
        break
    end
    % Read the next line from the file
    textline = fgetl(fid);
end

%% 3. Import the data for the Central Region
% Establish a conversion specifier for the TEXTSCAN function
fmt = '%11[^0123456789] %f %f %f %s %s %f-%f %s %f-%f %f-%f';

% Import data for the central teams
central = textscan(fid,fmt,5);

% Close the connection.
status = fclose(fid);
