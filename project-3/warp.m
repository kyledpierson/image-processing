function warped = warp(t, source, target, Xc, Yc, x_coefs, y_coefs, kernel)
% Applies a warp transformation on the source, using a transformation from
% Xc and Yc to both the source and the target.  Takes a weighted average
% of the transformation to both images based on the input parameter t (a
% number between 1-0 which indicates how far along the morph we are).

% Make the output image
[m, n] = size(source);
warped = zeros(m, n);

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
        
        % Apply the transformation
        x = x_coefs * [phi; i; j; 1];
        y = y_coefs * [phi; i; j; 1];
        
        % Bilinear interpolate the intensities from both images
        if 1 <= y(1) && y(1) <= m && 1 <= x(1) && x(1) <= n
            if 1 <= y(2) && y(2) <= m && 1 <= x(2) && x(2) <= n
                s_interp = bilinear_interp(source, x(1), y(1));
                t_interp = bilinear_interp(target, x(2), y(2));
                
                % Take a weighted average
                warped(i, j) = t*s_interp + (1 - t)*t_interp;
            end
        end
    end
end
end