function binary_image = adaptive_threshold(gray_image, bsize, mvar)
% Splits the image up into blocks of size bsize.  Thresholds each one with
% a variance greater than mvar, choosing a threshold of mean + 1 standard
% deviation

% First, we need to split the image up into blocks of bsize.  If the image
% is not a multiple of bsize, then just truncate the edge blocks to fit in
% the image.
[x, y] = size(gray_image);
min_val = min(gray_image(:));
max_val = max(gray_image(:));

x_arr = floor(x / bsize);
y_arr = floor(y / bsize);
last_x = mod(x, bsize);
last_y = mod(y, bsize);

x_dim = zeros(1, x_arr) + bsize;
y_dim = zeros(1, y_arr) + bsize;

% Used if the image is not an exact multiple of the block size
if (last_x ~= 0)
    x_dim = [x_dim last_x];
end
if (last_y ~= 0)
    y_dim = [y_dim last_y];
end

% Split up into blocks
cells = mat2cell(gray_image, x_dim, y_dim);
[m, n] = size(cells);

% Loop through each block
for i = 1:m
    for j = 1:n
        block = cells{i, j};
        linear_block = reshape(block, 1, []);
        
        % Check the variance
        variance = var(single(linear_block));
        if (variance > mvar)
            threshold = mean(linear_block) + sqrt(variance);
        else
            threshold = max_val;
        end
        % Threshold based on the threshold
        cells{i, j} = dual_threshold(block, min_val, threshold);
    end
end

% Convert back into an image
binary_image = cell2mat(cells);
end
