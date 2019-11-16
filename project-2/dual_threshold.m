function binary_image = dual_threshold(image, lower, upper)
% This function takes an image, a lower threshold, and an upper threshold,
% and returns a binary image which shows 255 for each pixel that falls
% within the threshold, and 0 for everything else

[size_x, size_y] = size(image);
binary_image = zeros(size_x, size_y);

for i = 1:size_x
    for j = 1:size_y
        if(lower <= image(i, j) && image(i, j) <= upper)
            binary_image(i, j) = 255;
        end
    end
end
end