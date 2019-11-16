function transform = histogram_equalize_transform(image)
% Creates a mapping from a single channel image to its equalized histogram
L = max(image(:)) + 1;

% [pixel_histogram_1, ~] = histcounts(image, L);
pixel_histogram = custom_histogram(image, double(L), 0, double(L));

cumulative_histogram = cumsum(pixel_histogram);
cumulative_probabilities = cumulative_histogram ./ cumulative_histogram(end);
transform = floor(cumulative_probabilities .* double(L - 1));
end
