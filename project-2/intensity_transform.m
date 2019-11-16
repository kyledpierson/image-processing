function new_image = intensity_transform(image, transform)
% Transforms each pixel from the input image according to the input
% transform.  The input transform is an array that maps old pixel values to
% new pixel values.
[m, n] = size(image);
new_image = zeros(m, n);

for i = 1:m
    for j = 1:n
        new_image(i, j) = transform(image(i, j) + 1);
    end
end
end

