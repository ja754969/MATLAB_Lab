%% HURRREORG pulls out hurricane data for 1975

%% 1. Load data from file
load hurr

%% 2. Find the hurricanes from 1975
ind1975 = hurr{1}==1975;

%% 3. Determine the number of unique hurricanes from 1975
allNames = cellstr(hurr{6});
data = [ hurr{7:9} ];
hurrNames = unique(allNames(ind1975));
nh1975 = length(hurrNames);
disp(['There were ',num2str(nh1975),' hurricanes in 1975.'])

%% 4. Make new cell array
hurr1975 = cell(nh1975,2);
for k = 1:nh1975
    hname = hurrNames(k);
    hurr1975{k,1} = hname;
    ivals = ind1975 & strcmp(hname,allNames);
    hurr1975{k,2} = data(ivals,:);
end
