clc;
clear all;
close all;

% -------------------- Cells -------------------- %

ratio = 1;
p = 0.01;

images = cell(1, 6);
images{1} = imread('images/0002.0001.000.png');
images{2} = imread('images/0002.0001.001.png');
images{3} = imread('images/0002.0001.002.png');
images{4} = imread('images/0002.0001.004.png');
images{5} = imread('images/0002.0001.005.png');
images{6} = imread('images/0002.0001.006.png');

mosaic = stitch(images, ratio, 2, p);
imwrite(uint8(mosaic), ['mosaics/cells_' num2str(ratio) '_' num2str(p) '.png']);

% -------------------- Cells with Noise -------------------- %

ratio = 0.125;
p = 0.005;

images = cell(1, 6);
images{1} = imread('images/0003.0001.000.png');
images{2} = imread('images/0003.0001.001.png');
images{3} = imread('images/0003.0001.002.png');
images{4} = imread('images/0003.0001.004.png');
images{5} = imread('images/0003.0001.005.png');
images{6} = imread('images/0003.0001.006.png');

mosaic = stitch(images, ratio, 2, p);
imwrite(uint8(mosaic), ['mosaics/cells_noise_' num2str(ratio) '_' num2str(p) '.png']);

% -------------------- Whiteboard -------------------- %

ratio = 0.125;
p = 0.0025;

images = cell(1, 7);
images{1} = imread('images/im1.png');
images{2} = imread('images/im2.png');
images{3} = imread('images/im3.png');
images{4} = imread('images/im4.png');
images{5} = imread('images/im5.png');
images{6} = imread('images/im6.png');
images{7} = imread('images/im7.png');

images = normalize_size(images);
mosaic = stitch(images, ratio, 2, p);
imwrite(uint8(mosaic), ['mosaics/whiteboard_' num2str(ratio) '_' num2str(p) '.png']);

% -------------------- Cupboard -------------------- %

ratio = 1;
p = 0.075;

images = cell(1, 7);
image_1 = imread('images/cupboard_1.png');
image_2 = imread('images/cupboard_2.png');
image_3 = imread('images/cupboard_3.png');
image_4 = imread('images/cupboard_4.png');
image_5 = imread('images/cupboard_5.png');
image_6 = imread('images/cupboard_6.png');
image_7 = imread('images/cupboard_7.png');

mosaics = cell(1, 3);
for i = 1:3
    images{1} = image_1(:, :, i);
    images{2} = image_2(:, :, i);
    images{3} = image_3(:, :, i);
    images{4} = image_4(:, :, i);
    images{5} = image_5(:, :, i);
    images{6} = image_6(:, :, i);
    images{7} = image_7(:, :, i);
    
    images = normalize_size(images);
    mosaics{i} = stitch(images, ratio, 2, p);
end

mosaics = pad_images(mosaics);
mosaic = uint8(cat(3, mosaics{1}, mosaics{2}, mosaics{3}));
imwrite(mosaic, ['mosaics/cupboard_' num2str(ratio) '_' num2str(p) '.png']);
