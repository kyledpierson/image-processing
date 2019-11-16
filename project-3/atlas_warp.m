function atlas = atlas_warp(images, Xc, Yc, x_coefs, y_coefs, num_images, kernel)
% Performs an "atlas warp".  Creates a canvas, then loops through the
% canvas and computes the transformation to each of the other images.  Sets
% the pixel to be an average of the transformation to each image.

% Make the output image
[m, n] = size(images{1});
atlas = zeros(m, n);

% Loop through each pixel
for i = 1:m
    for j = 1:n
        % Calculate the transformation
        points = [Xc Yc];
        for k = 1:length(points)
            points(k, :) = norm(points(k, :) - [j i]);
        end
        phi = arrayfun(kernel, points(:, 1));
        phi(isnan(phi)) = 0;
        
        x = x_coefs * [phi; i; j; 1];
        y = y_coefs * [phi; i; j; 1];
        
        % Apply the transformation
        interp_vals = zeros(num_images, 1);
        for k = 1:num_images
            if 1 <= y(k) && y(k) <= m && 1 <= x(k) && x(k) <= n
                interp_vals(k) = bilinear_interp(images{k}, x(k), y(k));
            end
        end
        
        % Set the pixel to an average of each transformation
        atlas(i, j) = mean(interp_vals);
    end
end
end