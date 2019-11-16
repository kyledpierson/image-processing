clc;
clear all;
close all;

% Test for part 3 - Topological Denoising
% -------------------- Turkeys -------------------- %
image = imread('turkeys.tif');
threshold_image = dual_threshold(image, 0, 115);
label_image = denoise(threshold_image, 150);
figure(1); imagesc(label_image);

% -------------------- Shapes -------------------- %
image = imread('shapes.tif');
threshold_image = multiple_thresholds(image, [0 90 155 190 255]);
label_image = denoise(threshold_image, 20);
figure(2); imagesc(label_image);

% -------------------- Brain -------------------- %
image = imread('brain.tif');
threshold_image = multiple_thresholds(image, [0 25 70 120 255]);
label_image = denoise(threshold_image, 10);
figure(3); imagesc(label_image);

% -------------------- Diamonds -------------------- %
image = imread('diamonds.png');
image = image(:, :, 1);
threshold_image = multiple_thresholds(image, [0 100 228 255]);
label_image = denoise(threshold_image, 300);
figure(4); imagesc(label_image);
