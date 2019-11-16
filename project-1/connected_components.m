function [label_image, labels] = connected_components(threshold_image)
% This function takes a threshold image as input (an image which has been
% separated into thresholds) and returns a label image displaying the
% connected components, as well as an array of label data.  The number of
% connected components can be found by taking the length of the 'labels'
% array.  The 'labels' array also includes this array at each cell:
%
%                   labels{i} = [seed_x seed_y size]
%
% Which contains the x and y of a seed point, as well as the size of the
% component.

label_value = 0;
labels = cell(1, 3);
[size_x, size_y] = size(threshold_image);
label_image = zeros(size_x, size_y);

for i = 1:size_x
    for j = 1:size_y
        if(label_image(i, j) == 0)
            label_value = label_value + 1;
            [label_image, label_size] = flood_fill(label_image, label_value, [i j], threshold_image);
            labels{label_value} = [i j label_size];
        end
    end
end
end