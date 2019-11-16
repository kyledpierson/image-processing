function [source, target, X, Y] = match_images(source, target, color, X, Y)
% Matches the size and color of two images, using rescaling and histogram
% matching.  Also scales the X and Y correspondenc vectors.

% Resize the images
[a, b, ~] = size(source);
[c, d, ~] = size(target);

new_size = [max(a, c) max(b, d)];
source = imresize(source, new_size);
target = imresize(target, new_size);

% Rescale the correspondences
source_y = new_size(1) / a;
source_x = new_size(2) / b;
target_y = new_size(1) / c;
target_x = new_size(2) / d;
X = round([X(:,1)*source_x X(:,2)*target_x]);
Y = round([Y(:,1)*source_y Y(:,2)*target_y]);

% Equalize the histograms (doesn't look so good with color)
if ~color
    transform = histogram_equalize_transform(target);
    inverse = inverse_histogram_equalize_transform(source);
    mapping = create_mapping(transform, inverse);
    target = intensity_transform(target, mapping);
end
end