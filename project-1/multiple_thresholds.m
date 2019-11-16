function threshold_image = multiple_thresholds(image, n)
% This is a convinience function used for splitting an image into a
% threshold image, where the pixels belonging to each threshold are labeled
% with that threshold number.  The input n can be either a number or an
% array of numbers.
%
% n is a number => the number of equal thresholds in which to divide image
% n is an array => an array of thresholds in which to divide image

[size_x, size_y] = size(image);
linear_image = reshape(image, 1, []);

thresholds = n;
if(length(n) == 1)
    thresholds = linspace(0, 255, n + 1);
end

threshold_image = reshape(discretize(linear_image, thresholds), size_x, size_y);
end