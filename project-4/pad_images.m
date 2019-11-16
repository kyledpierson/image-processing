function p_images = pad_images(images)
% Pads all images to be of the same size, using the average value.

num_images = length(images);
p_images = cell(1, num_images);

max_y = 0;
max_x = 0;
for i = 1:num_images
    [y, x] = size(images{i});
    max_y = max([y max_y]);
    max_x = max([x max_x]);
end

for i = 1:num_images
    [y, x] = size(images{i});
    avg = mean2(images{i});
    
    right = zeros(y, max_x-x) + avg;
    bottom = zeros(max_y-y, max_x) + avg;
    
    p_images{i} = [images{i} right; bottom];
end
end
