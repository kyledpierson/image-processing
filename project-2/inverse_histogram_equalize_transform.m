function inverse = inverse_histogram_equalize_transform(image)
% Creates the mapping from an image to its equalized histogram image, but
% then reverses that mapping (switches the indices with the values at those
% indices).
transform = histogram_equalize_transform(image);
transform_length = length(transform);
inverse = cell(1, transform_length);

for i = 1:transform_length
    val = transform(i) + 1;
    inverse{val} = [inverse{val}, i - 1];
end
end

