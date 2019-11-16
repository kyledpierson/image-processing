clc;
clear all;
close all;

% Tests the two types of thresholding methods on the cell image
cell_image = imread('images/cell-image.tif');

% Change the second parameter for denoise to try different size thresholds
otsu_binary = otsu_threshold(cell_image);
otsu_denoised = denoise(otsu_binary, 50);
[otsu_connected, otsu_cells] = connected_components(otsu_denoised);

% Change the second and third parameters, for bsize and mvar
adaptive_binary = adaptive_threshold(cell_image, 100, 100);
adaptive_denoised = denoise(adaptive_binary, 50);
[adaptive_connected, adaptive_cells] = connected_components(adaptive_denoised);

% Generates the binary and connected-components image for each of the
% thresholding methods, qand also shows the original image to compare
% against.
figure('Name','Original','NumberTitle','off'); imagesc(cell_image);
figure('Name','Otsu Binary','NumberTitle','off'); imagesc(otsu_binary);
figure('Name','Otsu Denoised','NumberTitle','off'); imagesc(otsu_connected);
figure('Name','Adaptive Binary','NumberTitle','off'); imagesc(adaptive_binary);
figure('Name','Adaptive Denoised','NumberTitle','off'); imagesc(adaptive_connected);
disp(length(otsu_cells));
disp(length(adaptive_cells));
