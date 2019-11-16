function my_histogram = custom_histogram(I, n, min, max)
% This function takes an image I, the number of thresholds n, a minimum
% threshold, and a maximum threshold, divides the area between min and max
% into n equal sections, and returns an array of size n which contains,
% for each i in n, the number of pixels that belong to the corresponding
% threshold i in the image I

new_I = reshape(I, 1, []);

edges = linspace(min, max, n + 1);
counts = reshape(discretize(new_I, edges), [], 1);
my_histogram = reshape(accumarray(counts, 1), 1, []);
end