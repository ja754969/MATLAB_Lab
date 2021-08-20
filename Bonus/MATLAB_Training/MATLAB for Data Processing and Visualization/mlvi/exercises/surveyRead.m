%% SURVEYREAD  is a solution to Student Survey exercise.

%% 1. Open studentSurvey.txt
edit('studentSurvey.txt');

%% 2. Read the data into a variable
f = fopen('studentSurvey.txt','r');

% The key to processing Student_survey.txt is to notice that the delimiter
% is the tab character.

% Here, we only read the first line.  It consists of the column headers.
headers = textscan(f,'%s%s%s%s',1,'Delimiter','\t');
% Now, we're ready to read in the actual data.
data    = textscan(f,'%s%f%f%f','Delimiter','\t');

fclose(f);

%% 3. Turn each column into their own variables.
behavior = data{1};
IM = data{2};
NU = data{3};
NI = data{4};

%% 4.  Determine
% Which behavior had the highest/lowest vote in the “Important for academic
% success” category?
fprintf(1,'The Important for Academic Success Category:\n');
[valimx,iimx] = max(IM);
fprintf(1,'\t"%s" had the highest vote (%d)\n',behavior{iimx},valimx);
[valimn,iimn] = min(IM);
fprintf(1,'\t"%s" had the lowest vote (%d)\n\n',behavior{iimn},valimn);

% Which behavior had the highest vote in the “Neither important nor
% unimportant for academic success” category?
fprintf(1,['The Neither Important Nor Unimportant for Academic Success '...
    'Category:\n']);

[valnux,inux] = max(NU);
fprintf(1,'\t"%s" had the highest vote (%d)\n',behavior{inux},valnux);
[valnun,inun] = min(NU);
fprintf(1,'\t"%s" had the lowest vote (%d)\n\n',behavior{inun},valnun);

% Which behavior had the highest vote in the “Neither important nor
% unimportant for academic success” category?
fprintf(1,'The Not Important for Academic Success Category:\n');

[valnix,inix] = max(NI);
fprintf(1,'\t"%s" had the highest vote (%d)\n',behavior{inix},valnix);
[valnin,inin] = min(NI);
fprintf(1,'\t"%s" had the lowest vote (%d)\n\n',behavior{inin},valnin);
