function output = atlas(param_file)
% Creates an atlas from several images, defined in the param_file. First
% matches the sizes of the images and scales the correspondences
% accordingly.  Then computes the warps from all images to the average
% correspondences, and takes an equal amount of intensity from each image
% to the point on the canvas to which it warps.
[M, X, Y, images, output, num_images, kernel] = read_params(param_file, false);

% Convert to grayscale
for i = 1:num_images
    if length(size(images{i})) == 3;
        R = images{i}(:, :, 1);
        G = images{i}(:, :, 2);
        B = images{i}(:, :, 3);
        images{i} = 0.299 * R + 0.587 * G + 0.114 * B;
    end
end

% Match the images (size and histogram)
[images, X, Y] = match_multiple_images(images, X, Y, num_images, 0);

% Mean of all correspondences
Xc = mean(X, 2);
Yc = mean(Y, 2);

% Calculate the x and y coefficients
x_coefs = zeros(num_images, M + 3);
y_coefs = zeros(num_images, M + 3);
for i = 1:num_images
    [x_co, y_co] = make_transformation(M, Xc, Yc, X(:, i), Y(:, i), kernel);
    x_coefs(i, :) = x_co;
    y_coefs(i, :) = y_co;
end

% Atlas and write the image
atlas = atlas_warp(images, Xc, Yc, x_coefs, y_coefs, num_images, kernel);
imwrite(uint8(atlas), [output '.tif']);
end