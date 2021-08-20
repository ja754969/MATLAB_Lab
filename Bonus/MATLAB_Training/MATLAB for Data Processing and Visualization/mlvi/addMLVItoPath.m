
function addMLVItoPath

rootDir = fileparts(which('addMLVItoPath'));

path2add{1} = rootDir;

path2add{2} = [rootDir,'\exercises'];

path2add{3} = [rootDir,'\hurricaneData'];


platform = computer;
if (~any(strcmp(platform,{'PCWIN','PCWIN64'})))
    for i = 1:length(path2add)
        path2add{i}(path2add{i} == '\') = '/';
    end
end

for i = 1:length(path2add)
    addpath(path2add{i},'-end');
end

