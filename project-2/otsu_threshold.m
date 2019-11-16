function binary_image = otsu_threshold(gray_image)
% Thresholds the input image according to the Otsu method discussed in
% class.  Returns a binary thresholded image.

% Set the min and max values, and run custom_histogram
min_val = min(gray_image(:));
max_val = max(gray_image(:));
bins = (max_val - min_val) + 1;
% [gray_histogram, ~] = histcounts(gray_image, bins);
gray_histogram = custom_histogram(gray_image, double(bins), double(min_val), double(max_val + 1));

total_pixels = sum(gray_histogram);
gray_probabilities = gray_histogram ./ total_pixels;

% Initialize the max sigma and optimal threshold to 0 (to be overwritten)
max_sigma = 0;
optimal_threshold = 0;

% Loop through all possible thresholds
for k = 1:bins - 1
    % Follow the formula from the slides
    Pk1 = sum(gray_probabilities(1:k));
    Pk2 = sum(gray_probabilities(k+1:end));
    
    mk1 = 0;
    mk2 = 0;
    for i = 1:k
        mk1 = mk1 + (i * gray_probabilities(i));
    end
    for i = k+1:bins
        mk2 = mk2 + (i * gray_probabilities(i));
    end
    mk1 = mk1 / Pk1;
    mk2 = mk2 / Pk2;
    
    % Check if the sigma is maxed out, and if so, set the optimal threshold
    sigma = Pk1 * Pk2 * (mk1 - mk2)^2;
    if (sigma > max_sigma)
        max_sigma = sigma;
        optimal_threshold = k;
    end
end

optimal_threshold = (min_val + optimal_threshold) - 1;
binary_image = dual_threshold(gray_image, optimal_threshold, max_val);
end
