function [M, X, Y, images, output, num_images, kernel] = read_params(param_file, morph)
% Reads the parameters from a file.  The morph parameter is a boolean
% indicating whether this is for a morph or an atlas.

% Open the file and read the first line
file_id = fopen(param_file);
MN = textscan(file_id, '%d %d', 1, 'CommentStyle', '//');
M = MN{1}/2;
N = MN{2};

% Format the correspondences
XY = textscan(file_id, repmat('%f',[1,N]), 2*M, 'CommentStyle', '//');
XY = cell2mat(XY);
X = XY(1:2:end,:);
Y = XY(2:2:end,:);

% Read the rest of the parameters
image_strings = textscan(file_id, '%s', N, 'CommentStyle', '//');

% Open the images
images = cellfun(@imread, image_strings{1}, 'UniformOutput', 0);

% Output string, number of images, and kernel
output = textscan(file_id, '%s', 1, 'CommentStyle', '//');
output = output{1}{1};

num_images = N;
if(morph)
    num_images = textscan(file_id, '%d', 1, 'CommentStyle', '//');
    num_images = num_images{1};
end

kernel = textscan(file_id, '%s', 1, 'CommentStyle', '//');
kernel = str2func(kernel{1}{1});
end