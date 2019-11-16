clc;
clear all;
close all;

% Tests for part 4 - Motion Detection
% -------------------- Houndog -------------------- %
image_1 = imread('houndog1.tif');
image_2 = imread('houndog2.tif');

% Extract the blue channel
blue_image_1 = image_1(:, :, 3);
blue_image_2 = image_2(:, :, 3);

% Take the difference of the two images, and threshold/denoise it
blue_image = imabsdiff(blue_image_1, blue_image_2);
threshold_image = dual_threshold(blue_image, 20, 255);
figure(1); imagesc(threshold_image);
label_image = denoise(threshold_image, 200);
figure(2); imagesc(label_image);

% -------------------- Car -------------------- %
image_1 = imread('car1.tiff');
image_2 = imread('car2.tiff');
blue_image_1 = image_1(:, :, 3);
blue_image_2 = image_2(:, :, 3);

blue_image = imabsdiff(blue_image_1, blue_image_2);
threshold_image = dual_threshold(blue_image, 20, 255);
figure(3); imagesc(threshold_image);
label_image = denoise(threshold_image, 200);
figure(4); imagesc(label_image);
