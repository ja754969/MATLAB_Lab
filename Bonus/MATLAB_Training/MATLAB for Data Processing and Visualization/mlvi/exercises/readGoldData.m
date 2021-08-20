%% READGOLDDATA  Reads OlympicGoldMedalists.txt file as specified
%                by "Olympic Gold Medalists" exercise.


%% 1. Open the OlympicGoldMedalists.txt file. 
edit('OlympicGoldMedalists.txt')

%% 2. Read the 100-Meter Dash Information
% Open the text file for read access
fid = fopen('OlympicGoldMedalists.txt','rt');

% Import "100-Meter Dash" data with the following five fields:
% {Year, First Name, Last Name, Country, Seconds}
format = '%f %s %[^,], %s %f';
data100 = textscan(fid, format, 'HeaderLines', 20);

%% 3. Read the Marathon Information
% Import "Marathon" data with the following six fields:
% {Year, Entire Name, Country, Hours, Minutes, Seconds}
frewind(fid)
format = '%f %[^,], %s %f:%f:%f';
dataMarathon = textscan(fid, format, 'HeaderLines', 111);

%% 4. Import "High Jump" data with the following four fields:
% {Year, Entire Name, Country, Meters}
format = '%f %[^,], %s %f %*[^\n]';
dataHiJump = textscan(fid, format, 'HeaderLines', 3);

% Close the text file
status = fclose(fid);