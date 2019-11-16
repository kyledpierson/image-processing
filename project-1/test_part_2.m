clc;
clear all;
close all;

% Tests for part 2 - Connected Components
% -------------------- Turkeys -------------------- %
image = imread('turkeys.tif');
my_histogram = custom_histogram(image, 255, 0, 255);
plot(my_histogram);

% Run the connected components algorithm
threshold_image = dual_threshold(image, 0, 110);
[label_image, labels] = connected_components(threshold_image);
figure(1); imagesc(label_image);

% Shows the number of components found
disp(length(labels));

% -------------------- Shapes -------------------- %
image = imread('shapes.tif');
threshold_image = multiple_thresholds(image, [0 90 155 190 255]);
[label_image, labels] = connected_components(threshold_image);
figure(2); imagesc(label_image);
disp(length(labels));

% -------------------- Brain -------------------- %
image = imread('brain.tif');
threshold_image = multiple_thresholds(image, [0 25 70 120 255]);
[label_image, labels] = connected_components(threshold_image);
figure(3); imagesc(label_image);
disp(length(labels));

% image = imread('town.jpg'); image = image(:, :, 1);
% image = imread('clock.jpg');
% image = imread('light-puppy.jpg'); image = image(:, :, 1);
