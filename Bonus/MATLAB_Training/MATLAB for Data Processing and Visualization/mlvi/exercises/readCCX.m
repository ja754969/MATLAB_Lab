%% READCCX Reads data with irregular block formatting in CCX.DAT.
% 
% The data in CCX.DAT is the result of a wireless network communication 
% quality test. Each block is a test in a different environment (e.g. 
% mobile, indoor, outdoor). The numerical results show the data error rate 
% over a range of noise levels for a number of independent tests.
%
% After 4 headerlines, CCX.DAT is made up of a number 
% of blocks of data, each with the following format:
%
% * Two headerlines of description
% * A parameter m
% * A p x m table of data
%
% TEXTSCAN is able to change its formatting and conversion specifications
% at each block, depending on the block's size, and pick up where the last 
% TEXTSCAN left off. All of the data is read into cell arrays, allowing for 
% the storage of different size blocks.

%% 1. View the file
edit('CCX.dat')

%% 2. Read the file
% Open the file as readable text.
fid = fopen('CCX.dat','rt');

% Skip the four header lines
[~] = textscan(fid,'','HeaderLines',4);

% Read each block.
% Each block consists of a header, a table name, column headers for the
% data, and then the data itself.

Block = 1;   % Initialise block index.
while (~feof(fid))      % For each block...
    
    % Read and display the block headerlines.
    disp(['Block: ' num2str(Block)]);       % Display the block number
    BlockHeaders{Block,1} = fgetl(fid);     % Read the test name
    disp(BlockHeaders{Block});
 
    % Read the number of columns in the block.
    CatchNumCols = textscan(fid,'Num SNR=%f','HeaderLines',1);
    NumCols = CatchNumCols{1};            

    % Read the data block.
    FormatString = repmat('%f',1,NumCols);
    CatchData = textscan(fid,FormatString,'Delimiter',','); 
    Data{Block,1} = cell2mat(CatchData);    % Convert from a cell to a numerical array. 
    
    % Read and discard end of block (EOB) marker.
    [~] = fgetl(fid);
    
    % Increment the block index.
    Block = Block + 1; 
    
end

% Close the file.
fclose(fid);
