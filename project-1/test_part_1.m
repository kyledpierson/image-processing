clc;
clear all;
close all;

% Tests for part 1 - Histogram
I = imread('town.jpg'); I = I(:, :, 1);
% I = imread('clock.jpg');
% I = imread('light-puppy.jpg'); I = I(:, :, 1);

my_histogram = custom_histogram(I, 17, 0, 255);
disp(my_histogram);
plot(my_histogram);

% Used to check output
% histogram(I)