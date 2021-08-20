function data = mlbBatchRead(fn)
%% MLBBATCHREAD will read the data from the file fn.

fmt = '%11[^0123456789] %f %f %f %s %s %f-%f %s %f-%f %s';
fid = fopen(fn, 'rt');
data = textscan(fid, fmt, 'HeaderLines', 7);
fclose(fid);
