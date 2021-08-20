%% MRIREADread in MRI data

%% 1. Read the image into the workspace
fid = fopen('mri.rawb','r');
A = fread(fid);
fclose(fid);

%% 2. Reshape the data for viewing
imA = reshape(A,[181,217,181]);

%% 3. View image
image(imA(:,:,25));
colormap bone
axis image
