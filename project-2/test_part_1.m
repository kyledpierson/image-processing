clc;
clear all;
close all;

% The first image is the one that is converted to gray, and then matched
% to the second image.  Change the images to any of the following:
% - lake-powell-1, lake-powell-2
% - forest-lake-1, forest-lake-2
% - tennis-1, tennis-2
image_1 = imread('images/tennis-1.jpg');
image_2 = imread('images/tennis-2.jpg');
figure(1); imshow(image_1);

R = image_1(:, :, 1);
G = image_1(:, :, 2);
B = image_1(:, :, 3);
gray_image = 0.299 * R + 0.587 * G + 0.114 * B;
% gray_image = rgb2gray(image_1);
colorized_image = colorize(gray_image, image_2);
figure(2); imshow(colorized_image);
