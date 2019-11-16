function [label_image, label_size] = flood_fill(label_image, label_value, seed, threshold_image)
% This function takes a label image, a label value, a seed, and a threshold
% image (an image which has been divided into thresholds) and returns a new
% label image with each pixel in the 4-connected neighborhood of the seed
% given the label value.  The 4-connected neighborhood is determined from
% the threshold image, where a pixel is in the neighborhood of another
% pixel if it is directly adjacent and belonging to the same threshold.

% Initialize the queue, set the seed to the label value, and determine the
% threshold value of the seed
next{1} = seed;
label_size = 1;
size_x = size(threshold_image, 1) + 1;
size_y = size(threshold_image, 2) + 1;
label_image(seed(1), seed(2)) = label_value;
threshold = threshold_image(seed(1), seed(2));

while not(isempty(next))
    % Weird way of looping through 4 adjacent pixels
    for i = 0:1
        for j = -1:2:1
            if(i == 0)
                adj_x = next{1}(1) + j;
                adj_y = next{1}(2);
            else
                adj_x = next{1}(1);
                adj_y = next{1}(2) + j;
            end
            
            % Do a bounds check, check to see if the pixel has not been
            % explored already, and that it is of the same threshold
            if(0 < adj_x && adj_x < size_x && 0 < adj_y && adj_y < size_y ...
                    && label_image(adj_x, adj_y) ~= label_value && threshold_image(adj_x, adj_y) == threshold)
                label_size = label_size + 1;
                next{end + 1} = [adj_x, adj_y];
                label_image(adj_x, adj_y) = label_value;
            end
        end
    end
    % Pop the queue
    next(1) = [];
end
end