function images = normalize_size(images)
% Makes all images have an even size in the x and y direction, for
% simplicity

num_images = length(images);

for i = 1:num_images
    [y, x] = size(images{i});
    new_y = ceil(y/2)*2;
    new_x = ceil(x/2)*2;
    
    avg = mean2(images{i});
    right = zeros(y, new_x-x) + avg;
    bottom = zeros(new_y-y, new_x) + avg;
    
    images{i} = [images{i} right; bottom];
end
end