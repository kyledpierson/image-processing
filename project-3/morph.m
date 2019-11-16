function output = morph(param_file)
% Performs a morph between two images based on the parameters in the input
% file.  First equalizes the histogram and size of the images.  Then
% computes the warp for each image in the morph, and saves the result.

% Read the params
[M, X, Y, images, output, num_images, kernel] = read_params(param_file, true);
source = images{1};
target = images{2};

t = linspace(1, 0, num_images);
color = length(size(source)) == 3;
[source, target, X, Y] = match_images(source, target, color, X, Y);
%combined = cell(2, 5);

% Form each image in the morph
for i = 1:num_images
    Xc = t(i)*X(:,1) + (1-t(i))*X(:,2);
    Yc = t(i)*Y(:,1) + (1-t(i))*Y(:,2);
    x_coefs = zeros(2, M + 3);
    y_coefs = zeros(2, M + 3);
    
    % Calculate the coefficients
    [x1_co, y1_co] = make_transformation(M, Xc, Yc, X(:,1), Y(:,1), kernel);
    x_coefs(1, :) = x1_co;
    y_coefs(1, :) = y1_co;
    [x2_co, y2_co] = make_transformation(M, Xc, Yc, X(:,2), Y(:,2), kernel);
    x_coefs(2, :) = x2_co;
    y_coefs(2, :) = y2_co;
    
    % Perform the warp and save the image
    if color
        red = warp(t(i), source(:, :, 1), target(:, :, 1), Xc, Yc, x_coefs, y_coefs, kernel);
        green = warp(t(i), source(:, :, 2), target(:, :, 2), Xc, Yc, x_coefs, y_coefs, kernel);
        blue = warp(t(i), source(:, :, 3), target(:, :, 3), Xc, Yc, x_coefs, y_coefs, kernel);
        warped = cat(3, red, green, blue);
    else
        warped = warp(t(i), source, target, Xc, Yc, x_coefs, y_coefs, kernel);
    end
    imwrite(uint8(warped), [output '_' num2str(i) '.tif']);
    %combined{idivide(i, 5, 'ceil'), mod(i - 1, 5) + 1} = warped;
end
%combined = cell2mat(combined);
%imwrite(uint8(combined), [output '_.tif']);
end

